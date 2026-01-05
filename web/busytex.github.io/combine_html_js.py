import os

def read_file(path):
    with open(path, 'r', encoding='utf-8') as f:
        return f.read()


def find_files(base_dir, exts=(".js", ".html")):
    result = []
    for root, dirs, files in os.walk(base_dir):
        for file in files:
            if file.lower().endswith(exts):
                rel_path = os.path.relpath(os.path.join(root, file), base_dir)
                abs_path = os.path.join(root, file)
                result.append((rel_path, abs_path))
    return result

def main():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    output_path = os.path.join(base_dir, 'combined_code.txt')
    files = find_files(base_dir, (".js", ".html"))
    with open(output_path, 'w', encoding='utf-8') as out:
        for label, path in files:
            out.write(f"\n{'='*80}\n")
            out.write(f"BEGIN FILE: {label}\n")
            out.write(f"{'='*80}\n")
            try:
                content = read_file(path)
            except Exception as e:
                content = f"[ERROR READING FILE: {e}]"
            out.write(content)
            out.write(f"\n{'='*80}\n")
            out.write(f"END FILE: {label}\n")
            out.write(f"{'='*80}\n\n")
    print(f"Combined code written to {output_path}")

if __name__ == '__main__':
    main()