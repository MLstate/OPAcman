var GLOBALS = {
    jsReady:false,
    flashReady:false
};

var MindWave = {
    mSignal:-1,
    mAttentionLevel:-1,
    mMeditationLevel:-1,
    setSignalValue:function(iconValue) {
	this.mSignal = iconValue;
	this.log("setSignal("+this.mSignal+")");
    },
    setAttentionLevel:function(thinkingLevel) {
	this.mAttentionLevel = thinkingLevel;
	this.log("setAttentionLevel("+this.mAttentionLevel+")");
    },
    setMeditationLevel:function(relaxationLevel) {
	this.mMeditationLevel = relaxationLevel;
	this.log("setMeditationLevel("+this.mMeditationLevel+")");
    },
    displayIcon:function() {
	//this.log("getSignal("+this.mSignal+")");
	return this.mSignal >= 0 && this.mSignal <= 200;
    },
    getAttentionLevel:function() {
	//this.log("getAttentionLevel("+this.mAttentionLevel+")");
	var t = this.mAttentionLevel;
	if (t) return t;
	return 0;
    },
    getMeditationLevel:function() {
	//this.log("getMeditationLevel("+this.mMeditationLevel+")");
	var r = this.mMeditationLevel;
	if (r) return r;
	return 0;
    },
    log:function(message) {
	console.log(message);
    }
};

function trace(text) {
    console.log(text);
}

function isReady() {
    return GLOBALS.jsReady;
}

$(document).ready(function() {
    GLOBALS.jsReady = true;
});

// var MindWave = (function () {
//     return {
//         isPresent: function() {
//             return Math.random() > 0.1;
//         },
//         getAttentionLevel: function() {
//             return Math.floor(Math.random()*101);
//         },
//         getRelaxationLevel: function() {
//             return Math.floor(Math.random()*101);
//         }
//     };
// }());

