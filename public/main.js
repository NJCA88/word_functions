// All 3 of my functions operate in similar ways.
// I have a results container at the bottom of my page, and when the
// user clicks a button to get results, a javascript function is run, 
// making an AJAX request.  If that request is succesful, we update
// the sub heading of the results container, as well as the contents of
// that container

// We trim all inputs to remove whitespace, and if there is no input in the 
// required field, we give the user a message but do not make an AJAX call.


function init() {
  $('#anagram-link').on('click', betterAnagrams);
  $('#prefix-link').on('click', betterPrefixes);
  $('#word-ladder').on('click', betterLadder);
}

function betterAnagrams(event){
  word = $('#anagram-word').val().trim();
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
  prefix = $('#prefix').val().trim();
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
  startWord = $('#start-word').val().trim();
  endWord = $('#end-word').val().trim();
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
