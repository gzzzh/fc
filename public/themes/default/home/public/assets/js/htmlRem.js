(function(designWidth, maxWidth) {
    doc = document.documentElement,
    remStyle = document.createElement("style"),
    function refreshRem() {
        var width = docEl.getBoundingClientRect().width;
        maxWidth = maxWidth || 540;
        width>maxWidth && (width=maxWidth);
        var rem = width * 100 / designWidth; // 实际屏幕宽度相对于设计稿需要缩放的倍数*100
        remStyle.innerHTML = 'html{font-size:' + rem + 'px;}';
    }
    refreshRem();
}(1125, 1125)