function anagrams(event) {
  word = $('#anagram-word').val();
  window.location = '/anagrams/' + word;
  return false;
}

function prefixes(event) {
  word = $('#prefix').val();
  window.location = '/prefixed/' + word;
  return false;
}

function ladder(event) {
  startWord = $('#start-word').val();
  endWord = $('#end-word').val();
  window.location = '/word_ladder/' + startWord + '/' + endWord;
  return false;
}

function init() {
  $('#anagram-link').on('click', anagrams);
  $('#prefix-link').on('click', prefixes);
  $('#word-ladder').on('click', ladder);
}

$(init);
