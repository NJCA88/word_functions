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
  $('#anagram-link').on('click', betterAnagrams);
  $('#prefix-link').on('click', betterPrefixes);
  $('#word-ladder').on('click', betterLadder);
  // $('#anagram-btn').on('click', betterAnagrams);
}

function betterAnagrams(event){
  // alert('thing happening')
  console.log('here we go')
  word = $('#anagram-word').val();
  
  $.ajax({
    url: "/betteranagrams/" + word, 
    success: function (result) {
      console.log('success', result)
      // $("#div1").html(result);
      // $('#results').remove();
      result = JSON.parse(result)
      let mappedResult = result.map(el => {
        return (
          `<p> ${el}</p > `
        )
      })
      // $('#results').html(result);
      $('#results').html(mappedResult);
      $('#results-subheading').html("All anagrams of: " + word)

    },
    error: function(err){
      console.log('sadness')
    }
  });
  console.log('done')
}
function betterPrefixes(event){
  // alert('thing happening')
  console.log('here we go')
  prefix = $('#prefix').val();
  
  $.ajax({
    url: "/betterprefixes/" + prefix, 
    success: function (result) {
      console.log('success', result)
      console.log('success', result)
      console.log("array? ", Array.isArray(result))
      // $("#div1").html(result);
      // $('#results').remove();
      result = JSON.parse(result)
      let mappedResult = result.map(el => {
      return(
          `<p> ${ el }</p > `
      )
      })
      // $('#results').html(result);
      $('#results').html(mappedResult);
      $('#results-subheading').html("All words that start with the prefix: " + prefix)
    },
    error: function(err){
      console.log('sadness')
    }
  });
  console.log('done')
}

function betterLadder(event) {
  // alert('thing happening')
  console.log('here we go')
  startWord = $('#start-word').val();
  endWord = $('#end-word').val();
  console.log('starting with: ', startWord)
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
      // $('#results').html(result);
      $('#results').html(mappedResult);
      $('#results-subheading').html("Here is the path from " + startWord + " to " + endWord)
    },
    error: function (err) {
      console.log('sadness')
      console.log(err)
    }
  });
  console.log('done')
}

$(init);
