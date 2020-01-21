import oaitools, strformat, os, progress, argparse, times

proc process_sets(oai_connection: OaiRequest, a_date: string): int =
  var 
    sets = oai_connection.list_sets()
    bar = newProgressBar(total=len(sets))
  echo fmt"{'\n'}Harvesting all MODS records since {a_date}.{'\n'}"
  bar.start()
  for i in 1..len(sets):
    oai_connection.oai_set = sets[i-1]
    discard oai_connection.harvest_metadata_records(metadata_format="mods", output_directory=fmt"{getCurrentDir()}/{sets[i-1]}", identifier=true, from_date=a_date, replace_filename="oai:utklib:")
    bar.increment()
  bar.finish()
  len(sets)

when isMainModule:
  var
    x = newOaiRequest("https://digital.lib.utk.edu/collections/oai2")
    p = newParser(fmt"Harvest UTK MODS"):
      option("-d", "--date", help="Download records since this date as yyyy-MM-dd.  Defaults to yesterday.", default="yesterday")
    argv = commandLineParams()
    opts = p.parse(argv)
    datestring: string
  case opts.date
  of "yesterday":
    datestring = $(now() - 1.days)
  else:
    datestring = opts.date
  discard process_sets(x, datestring)
