$(function () {
    "use strict";

$('a').on('click', function (e) {
    e.preventDefault(); // 기본 동작 방지 (필요 시)
    const link = $(this).closest('a'); // 항상 상위 <a> 태그를 가져옴
    console.log(link.attr('href')); // 링크 주소 확인
    window.location.href = link.attr('href'); // 페이지 이동
});

    $(document).ready(function () {
        // URL에서 드롭다운 상태 읽기
        const urlParams = new URLSearchParams(window.location.search);
        const dropdownIndex = urlParams.get('dropdownIndex'); // URL에서 dropdownIndex 값 가져오기
        const selectedIndex = urlParams.get('selectedIndex'); // URL에서 selectedIndex 값 가져오기

        // 페이지 로드 시 드롭다운 상태 복원
        if (dropdownIndex !== null) {
            const $dropD = $('.dropD').eq(parseInt(dropdownIndex, 10)); // 인덱스로 드롭다운 선택
            const $dropMenu = $dropD.find('.dropD-menu');
            const $icon = $dropD.find('> a > .fa-solid');

            // 드롭다운 열기 및 아이콘 변경
            $dropMenu.addClass('show');
            $icon.removeClass('fa-angle-right').addClass('fa-angle-down');
        }

        // 페이지 로드 시 선택된 항목 복원
        if (selectedIndex !== null) {
            const $selectedItem = $('.dropD-menu > li').eq(parseInt(selectedIndex, 10));
            $selectedItem.addClass('selected');
        }

        // 드롭다운 클릭 시 상태 저장
        $('.dropD').on('click', function (e) {
            e.stopPropagation(); // 이벤트 전파 방지

            const $this = $(this);
            const $dropMenu = $this.find('.dropD-menu');
            const $icon = $this.find('.fa-solid');
            const index = $('.dropD').index(this); // 현재 드롭다운의 인덱스 계산

            // 열림/닫힘 상태 토글
            const isOpen = $dropMenu.hasClass('show');
            $('.dropD-menu').removeClass('show'); // 다른 드롭다운 닫기
            $('.fa-solid').removeClass('fa-angle-down').addClass('fa-angle-right'); // 아이콘 초기화

            if (!isOpen) {
                $dropMenu.addClass('show'); // 현재 드롭다운 열기
                $icon.removeClass('fa-angle-right').addClass('fa-angle-down'); // 아이콘 변경
            }

            // URL 쿼리 파라미터에 상태 저장
            const currentUrl = new URL(window.location.href);
            currentUrl.searchParams.set('dropdownIndex', index);
            window.history.replaceState({}, '', currentUrl); // URL 갱신
        });

        // 드롭다운 내부 링크 클릭 시 상태 유지 및 이동
        $('.dropD-menu > li a').on('click', function (e) {
            const $this = $(this).closest('li'); // 클릭된 항목
            const dropdownIndex = $('.dropD').index($this.closest('.dropD'));
            const selectedIndex = $('.dropD-menu > li').index($this); // 현재 항목의 인덱스 계산

            // 모든 항목에서 selected 클래스 제거
            $('.dropD-menu > li').removeClass('selected');

            // 현재 클릭된 항목에 selected 클래스 추가
            $this.addClass('selected');

            // URL에 상태 저장
            const currentUrl = new URL($(this).attr('href'), window.location.href);
            currentUrl.searchParams.set('dropdownIndex', dropdownIndex);
            currentUrl.searchParams.set('selectedIndex', selectedIndex);

            // 링크 이동
            window.location.href = currentUrl.toString();

            // 기본 클릭 동작 중단
            e.preventDefault();
        });

        // 외부 클릭 시 모든 드롭다운 닫기
        $(document).on('click', function () {
            $('.dropD-menu').removeClass('show');
            $('.fa-solid').removeClass('fa-angle-down').addClass('fa-angle-right');
        });
    });

    $.sidebarMenu = function (menu) {
        var animationSpeed = 300,
            subMenuSelector = '.sidebar-submenu';
        $(menu).on('click', 'li a', function (e) {
            var $this = $(this);
            var checkElement = $this.next();
            if (checkElement.is(subMenuSelector) && checkElement.is(':visible')) {
                checkElement.slideUp(animationSpeed, function () {
                    checkElement.removeClass('menu-open');
                });
                checkElement.parent("li").removeClass("active");
            }
            //If the menu is not visible
            else if ((checkElement.is(subMenuSelector)) && (!checkElement.is(':visible'))) {
                //Get the parent menu
                var parent = $this.parents('ul').first();
                //Close all open menus within the parent
                var ul = parent.find('ul:visible').slideUp(animationSpeed);
                //Remove the menu-open class from the parent
                ul.removeClass('menu-open');
                //Get the parent li
                var parent_li = $this.parent("li");
                //Open the target menu and add the menu-open class
                checkElement.slideDown(animationSpeed, function () {
                    //Add the class active to the parent li
                    checkElement.addClass('menu-open');
                    parent.find('li.active').removeClass('active');
                    parent_li.addClass('active');
                });
            }
            //if this isn't a link, prevent the page from being redirected
            if (checkElement.is(subMenuSelector)) {
                e.preventDefault();
            }
        });
    };
});
