import GCompris 1.0

// Must be updated once GnumchEquality is reviewed
ActivityInfo {
  name: "gnumch-multiples/GnumchMultiples.qml"
  difficulty: 3
  icon: "gnumch-multiples/gnumch-multiples.svg"
  author: "Manuel Tondeur <manueltondeur@gmail.com>"
  demo: false
  title: qsTr("Gnumch Multiples")
  description: qsTr("Guide the Number Muncher to all the multiples of the number at the top of the screen.")
//  intro: "Guide the number eater to the required numbers and press on it to swallow them."
  goal: qsTr("Learn about multiples and factors.")
  prerequisite: ""
  manual: qsTr("The multiples of a number are all the numbers that are equal to the original number times another number. For example, 24, 36, 48 and 60 are all multiples of 12. 25 is not a multiple of 12 because there isn't any number that can be multiplied by 12 to get 25. If one number is a factor of a second number, then the second number is a multiple of the first number. Again, you can think of multiples as families, and factors are the people who belong to those families. The factor 5, has parents 10, grandparents 15, great-grandparents 20, great-great-grandparents 25, and every extra step of 5 is another great- in front! But the number 5 does not belong in the 8 or 23 families. You can't fit any number of 5s into 8 or 23 with nothing left over. So 8 isn't a multiple of 5, nor is 23. Only 5, 10, 15, 20, 25 ... are multiples (or families or steps) of 5.") +
          "<br><br>" +
          qsTr("If you have a keyboard you can use the arrow keys to move and hit space to swallow a number. With a mouse you can click on the block next to your position to move and click again to swallow the number. With a touch screen you can do like with a mouse or swipe anywhere in the direction you want to move and tap to swallow the number.") +
          "<br><br>" +
          qsTr("Take care to avoid the Troggles.")
  credit: ""
  section: "math"
}
