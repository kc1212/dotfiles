package dotfilesync

import java.io.File
import java.nio.file.{Files, Paths, LinkOption}

import scala.util.{Failure, Success, Try}

object FileOp extends Enumeration {
  type FileOp = Value
  val Copy, SymLink = Value
}

object Main {

  import FileOp._

  type TryNull = Try[Null]

  def downloadFileTo(url: String, target: String): TryNull = {
    var path = Paths.get(target)
    val buf = scala.io.Source.fromURL(url).takeWhile(_ != -1).map(_.toByte).toArray
    Try(path.toFile.getParentFile.mkdirs)
      .map(_ => Files.write(path, buf))
      .flatMap(_ => Success(null))
  }

  def backupAndOp(fileOp: FileOp)(source: File, target: File, backup: File): TryNull = {
    Try({
      if (Files.exists(target.toPath, LinkOption.NOFOLLOW_LINKS)) {
        backup.getParentFile.mkdirs
        Files.move(target.toPath, backup.toPath)
      }
    })
      .map(_ => target.getParentFile.mkdirs)
      .map(_ => fileOp match {
        case SymLink => Files.createSymbolicLink(target.toPath, source.toPath)
        case Copy => Files.copy(source.toPath, target.toPath)
      })
      .flatMap(_ => Success(null))
  }

  def traverseWith(f: File, fn: File => TryNull): TryNull = {
    if (f.isDirectory)
      f.listFiles.foldLeft[TryNull](Success(null))((t, f) => t match {
        case Success(_) => traverseWith(f, fn)
        case e@Failure(_) => e
      })
    else
      fn(f.getAbsoluteFile)
  }

  def syncDotfiles(dir: File, backupDir: File, fileOp: FileOp): TryNull = {
    if (!dir.exists)
      Failure(new Error(dir.getAbsolutePath + " does not exist"))
    else if (!dir.isDirectory)
      Failure(new Error(dir.getAbsolutePath + " is not a directory"))
    else {
      if (!backupDir.mkdir) {
        return Failure(new Error("failed to make directory " + backupDir))
      }
      val rootDir = dir.getAbsolutePath
      traverseWith(dir, f => {
        if (Files.isSymbolicLink(f.toPath)) return Failure(new Error(f + " is symlink"))
        val rightConfigPath = f.getAbsolutePath.replace(rootDir, "")
        val homeFile = Paths.get(System.getProperty("user.home"), rightConfigPath).toFile
        val backupFile = new File(backupDir, rightConfigPath)
        backupAndOp(fileOp)(f, homeFile, backupFile)
      })
    }
  }

  def main(args: Array[String]): Unit = {
    if (System.getProperty("os.name").toLowerCase.contains("win")) {
      println("this program is not supported on windows")
      return
    }
    // files in copyDir and linkDir must not conflict
    val now = System.currentTimeMillis()/1000
    val copyDir = new File("copydir")
    val linkDir = new File("symlinkdir")
    val copyBackup = new File("copydir_backup" + now)
    val linkBackup = new File("symlinkdir_backup" + now)
    val res = syncDotfiles(copyDir, copyBackup, Copy)
      .flatMap(_ => syncDotfiles(linkDir, linkBackup, SymLink))
      .flatMap(_ => {
        val url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        val target = System.getProperty("user.home") + "/.local/share/nvim/site/autoload/plug.vim"
        downloadFileTo(url, target)
      })
    res match {
      case Success(_) => println("ok")
      case Failure(e) => println("operation failed with error: " + e)
    }
  }
}
