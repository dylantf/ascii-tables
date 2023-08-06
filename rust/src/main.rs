fn max_widths(header: &Vec<String>, rows: &[Vec<String>]) -> Vec<usize> {
    let lengths = |l: &Vec<String>| l.iter().map(|s| s.len()).collect::<Vec<usize>>();

    rows.iter().fold(lengths(header), |acc, row| {
        acc.iter()
            .zip(lengths(row))
            .map(|(&x, y)| match x.cmp(&y) {
                std::cmp::Ordering::Greater => x,
                _ => y,
            })
            .collect::<Vec<usize>>()
    })
}

fn render_separator(widths: &[usize]) -> String {
    let pieces = widths
        .iter()
        .map(|w| str::repeat("-", *w))
        .collect::<Vec<String>>()
        .join("-+-");

    format!("|-{pieces}-|")
}

fn pad(s: &str, length: usize) -> String {
    let padding = str::repeat(" ", length - s.len());
    format!("{s}{padding}")
}

fn render_row(row: &[String], widths: &[usize]) -> String {
    let padded_content = row
        .iter()
        .zip(widths)
        .map(|(s, &w)| pad(s, w))
        .collect::<Vec<String>>()
        .join(" | ");

    format!("| {padded_content} |")
}

fn render_table(header: &Vec<String>, rows: &[Vec<String>]) -> String {
    let widths = max_widths(header, rows);
    let separator = render_separator(&widths);

    [
        vec![
            separator.clone(),
            render_row(header, &widths),
            separator.clone(),
        ],
        rows.iter()
            .map(|row| render_row(row, &widths))
            .collect::<Vec<String>>(),
        vec![separator],
    ]
    .concat()
    .join("\n")
}

fn main() {
    let header = vec![String::from("Student"), String::from("Grade")];
    let rows = vec![
        vec![String::from("James"), String::from("A")],
        vec![String::from("Beatrice"), String::from("F-")],
        vec![String::from("Henry"), String::from("B+")],
    ];

    println!("{}", render_table(&header, &rows));
}
