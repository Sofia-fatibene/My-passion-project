import Foundation

let PathString = "Documents/MusicDB/DB/Console/"
let Log = OutStream(path: PathString)
var Out:OutStream
    Log.Open("Log.txt", Clear: false)
    let StartTime = Date()
    Log.Write("Session on \(StartTime)ms\n", BlockConsole: true)
      Out = OutStream(path: PathString)
      Out.ConsoleOn()
      Out.Open("Output.txt")      // to clear add Clear:
      Out.Pipe(to: Log)
        Out.Write("Hello, World!\n")
// -------------------------------------------------------------------
        var DB = DBSong.Load(path:"Documents/MusicDB/DB/")
        //DB.Populate()

        

        var r = DB.Sort(by: Phrase("Coraline Verità"))

        for n in 0..<r.count {
            Out.Write(r[n])
        }

        DB.Save()


// -------------------------------------------------------------------
        Out.Write("Bye, World!\n")
      Out.Close()
    let EndTime = Date()
    Log.Write("Session off \(EndTime)ms  De=\(EndTime.timeIntervalSince(StartTime))ms\n\n\n", BlockConsole: true)
Log.Close()
