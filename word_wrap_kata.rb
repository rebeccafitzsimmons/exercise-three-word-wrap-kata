# tests
# 1 empty string returns empty string
# 2 string less than column, return string
# 3 string (no spaces) split once
# 4 string (no spaces) split many times
# 5 wraps on word boundary
# 6 wraps on word boundary that is immediately after the column
# 7 wraps on word boundary before column
# 8 wraps before word boundary
# 9 keeps as many words on one line as possible

def wrap(string, column)
  if string.length <= column then return string end
  boundary = string[0, column].rindex(" ")
  if !boundary.nil?
    return string[0, boundary].strip + "\n" + wrap(string[boundary + 1, string.length - 1].strip, column)
  else
    return string[0, column].strip + "\n" + wrap(string[column, string.length - 1].strip, column)
  end
end

RSpec.describe "wrap" do
  it "#empty string returns empty string" do
    expect(wrap("", 1)).to eq("")
  end
  it "#string less than column returns string" do
    expect(wrap("string", 7)).to eq("string")
  end
  it "#string (no spaces) split once" do
    expect(wrap("string", 3)).to eq("str\ning")
  end
  it "#string (no spaces) split many times" do
    expect(wrap("abcdefghijk", 3)).to eq("abc\ndef\nghi\njk")
  end
  it "#wraps on word boundary" do
    expect(wrap("word wrap", 5)).to eq("word\nwrap")
  end
  it "wraps on word boundary that is immediately after the column" do
    expect(wrap("word wrap", 4)).to eq("word\nwrap")
  end
  it "wraps on word boundary before column" do
    expect(wrap("word wrap", 6)).to eq("word\nwrap")
  end
  it "wraps before word boundary" do
    expect(wrap("word wrap", 3)).to eq("wor\nd\nwra\np")
  end
  it "#keeps as many words on one line as possible" do
    expect(wrap("long long word", 10)).to eq("long long\nword")
  end
end
