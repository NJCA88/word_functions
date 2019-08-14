

function init() {
  $('#anagram-link').on('click', betterAnagrams);
  $('#prefix-link').on('click', betterPrefixes);
  $('#word-ladder').on('click', betterLadder);
}

function betterAnagrams(event){
  word = $('#anagram-word').val();
  if (word.length === 0) {
    $('#results').html("We're going to need some input");
    $('#results-subheading').html("Anagrams")
    return
  }
  
  $.ajax({
    url: "/betteranagrams/" + word, 
    success: function (result) {

      result = JSON.parse(result)
      let mappedResult = result.map(el => {
        return (
          `<p> ${el}</p > `
        )
      })
      $('#results').html(mappedResult);
      $('#results-subheading').html("All anagrams of: " + word)

    },
    error: function(err){
    }
  });
}
function betterPrefixes(event){
  prefix = $('#prefix').val();
  if (prefix.length === 0){
    $('#results').html("We're going to need some input");
    $('#results-subheading').html("Prefixed Words")
    return
  }
  
  $.ajax({
    url: "/betterprefixes/" + prefix, 
    success: function (result) {
      result = JSON.parse(result)
      let mappedResult = result.map(el => {
      return(
          `<p> ${ el }</p > `
      )
      })
      $('#results').html(mappedResult);
      $('#results-subheading').html("All words that start with the prefix: " + prefix)
    },
    error: function(err){
    }
  });
}

function betterLadder(event) {
  startWord = $('#start-word').val();
  endWord = $('#end-word').val();
  if (startWord.length === 0 || endWord.length === 0) {
    $('#results').html("We need 2 words to find a path ");
    $('#results-subheading').html("Word Ladder")

    return
  }

  $.ajax({
    url: "/betterLadder/" + startWord + '/' + endWord,
    success: function (result) {
      result = JSON.parse(result)
      let mappedResult = result.map(el => {
        return (
          `<p> ${el}</p > `
        )
      })
      $('#results').html(mappedResult);
      $('#results-subheading').html("Here is the path from " + startWord + " to " + endWord)
    },
    error: function (err) {
    }
  });
}

$(init);
