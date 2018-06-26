package dotfilesync

import java.nio.file.{Files, Path, Paths, LinkOption}

import scala.util.{Failure, Success, Try}
import scala.collection.JavaConverters._

object FileOp extends Enumeration {
  type FileOp = Value
  val Copy, SymLink = Value
}

object Main {

  type TryNull = Try[Null]

  import FileOp._

  def downloadFileTo(url: String, path: Path): TryNull = {
    val buf = scala.io.Source.fromURL(url).takeWhile(_ != -1).map(_.toByte).toArray
    Try({
      Files.createDirectories(path.getParent)
      Files.write(path, buf)
    }).flatMap(_ => Success(null))
  }

  def backupAndOp(fileOp: FileOp)(source: Path, target: Path, backup: Path): TryNull = {
    Try({
      if (Files.exists(target, LinkOption.NOFOLLOW_LINKS)) {
        Files.createDirectories(backup.getParent)
        Files.move(target, backup)
      }
      Files.createDirectories(target.getParent)
      fileOp match {
        case SymLink => Files.createSymbolicLink(target, source)
        case Copy => Files.copy(source, target)
      }
    }).flatMap(_ => Success(null))
  }

  def traverseWith(f: Path, fn: Path => TryNull): TryNull = {
    if (Files.isDirectory(f))
      Files.newDirectoryStream(f)
        .asScala
        .foldLeft[TryNull](Success(null))((t, f) => t match {
        case Success(_) => traverseWith(f, fn)
        case e@Failure(_) => e
      })
    else
      fn(f)
  }

  def syncDotfiles(dir: Path, backupPath: Path, fileOp: FileOp): TryNull = {
    if (!Files.exists(dir))
      Failure(new Error(dir + " does not exist"))
    else if (!Files.isDirectory(dir))
      Failure(new Error(dir + " is not a directory"))
    else {
      Files.createDirectories(backupPath)
      val rootPathElems = dir.toAbsolutePath.getNameCount // e.g., "/a/b/c" = 3
      val homePath = Paths.get(System.getProperty("user.home"))
      traverseWith(dir, f => {
        if (Files.isSymbolicLink(f))
          return Failure(new Error(f + " is symlink"))
        val fAbs = f.toAbsolutePath
        val rightConfigPath = fAbs.subpath(rootPathElems, fAbs.getNameCount)
        val homeConfigFile = homePath.resolve(rightConfigPath)
        val backupFile = backupPath.resolve(rightConfigPath)
        backupAndOp(fileOp)(fAbs, homeConfigFile, backupFile)
      })
    }
  }

  def main(args: Array[String]): Unit = {
    if (System.getProperty("os.name").toLowerCase.contains("win")) {
      println("this program is not supported on windows")
      return
    }
    // files in copyDir and linkDir must not conflict
    val now = System.currentTimeMillis() / 1000
    val copyDir = Paths.get("copydir")
    val linkDir = Paths.get("symlinkdir")
    val copyBackup = Paths.get("copydir_backup_" + now)
    val linkBackup = Paths.get("symlinkdir_backup_" + now)
    val res = syncDotfiles(copyDir, copyBackup, Copy)
      .flatMap(_ => syncDotfiles(linkDir, linkBackup, SymLink))
      .flatMap(_ => {
        val url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        val path = Paths.get(System.getProperty("user.home")).resolve(".local/share/nvim/site/autoload/plug.vim")
        downloadFileTo(url, path)
      })
    res match {
      case Success(_) => println("ok")
      case Failure(e) => println("operation failed with error: " + e)
    }
  }
}
