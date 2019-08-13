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
  $('#anagram-btn').on('click', betterAnagrams);
}

function betterAnagrams(event){
  // alert('thing happening')
  console.log('here we go')
  word = $('#anagram-chars').val();
  
  $.ajax({
    url: "/betteranagrams/" + word, 
    success: function (result) {
      console.log('success', result)
      // $("#div1").html(result);
      // $('#results').remove();
      $('#results').html(result);

    },
    error: function(err){
      console.log('sadness')
    }
  });
  console.log('done')
}

$(init);
