open Core

let max_widths header rows =
  let lengths l = List.map ~f:String.length l in
  List.fold rows ~init:(lengths header) ~f:(fun acc row ->
      List.map2_exn ~f:Int.max acc (lengths row))

let render_separator widths =
  let pieces = List.map widths ~f:(fun w -> String.make w '-') in
  "|-" ^ String.concat ~sep:"-+-" pieces ^ "-|"

let pad s length = s ^ String.make (length - String.length s) ' '

let render_row row widths =
  let padded = List.map2_exn row widths ~f:pad in
  "| " ^ String.concat ~sep:" | " padded ^ " |"

let render_table header rows =
  let widths = max_widths header rows in
  String.concat ~sep:"\n"
    ([
       render_separator widths;
       render_row header widths;
       render_separator widths;
     ]
    @ List.map rows ~f:(fun row -> render_row row widths)
    @ [ render_separator widths ])

let () =
  render_table [ "Student"; "Grade" ]
    [ [ "James"; "A" ]; [ "Beatrice"; "F-" ]; [ "Henry"; "B+" ] ]
  |> print_endline
