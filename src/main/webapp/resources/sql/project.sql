DROP TABLE CART;
DROP TABLE SHOW_INFO;
DROP TABLE ADVERTISEMENT;
DROP TABLE COMMENTS;
DROP TABLE RENTAL;
DROP TABLE REVIEW;
DROP TABLE MEMBER;
DROP TABLE ARTWORK;
DROP TABLE AUTHOR;

DELETE AUTHOR_SEQ FROM SEQUENCES;
CALL create_sequence('AUTHOR_SEQ');

DELETE ART_SEQ FROM SEQUENCES;
CALL create_sequence('ART_SEQ');

DELETE MEMBER_SEQ FROM SEQUENCES;
CALL create_sequence('MEMBER_SEQ');

DELETE REVIEW_SEQ FROM SEQUENCES;
CALL create_sequence('REVIEW_SEQ');

DELETE RENTAL_SEQ FROM SEQUENCES;
CALL create_sequence('RENTAL_SEQ');

DELETE COMMENTS_SEQ FROM SEQUENCES;
CALL create_sequence('COMMENTS_SEQ');

DELETE ADVERTISEMENT_SEQ FROM SEQUENCES;
CALL create_sequence('ADVERTISEMENT_SEQ');

DELETE SHOW_INFO_SEQ FROM SEQUENCES;
CALL create_sequence('SHOW_INFO_SEQ');

DELETE CART_SEQ FROM SEQUENCES;
CALL create_sequence('CART_SEQ');

CREATE TABLE AUTHOR
(
	AUTHOR_NO	        	BIGINT PRIMARY KEY,
	AUTHOR_NAME	        	VARCHAR(100),
	AUTHOR_INTRO   	 		VARCHAR(4000)
);

INSERT INTO AUTHOR VALUES( (SELECT nextval('AUTHOR_SEQ') FROM DUAL) , '최풀림', '최풀림');
INSERT INTO AUTHOR VALUES((SELECT nextval('AUTHOR_SEQ') FROM DUAL), '공예나', '공예나');
INSERT INTO AUTHOR VALUES((SELECT nextval('AUTHOR_SEQ') FROM DUAL), '조광익', '조광익');
INSERT INTO AUTHOR VALUES((SELECT nextval('AUTHOR_SEQ') FROM DUAL), '정윤아', '정윤아');
INSERT INTO AUTHOR VALUES((SELECT nextval('AUTHOR_SEQ') FROM DUAL), '김귀희', '김귀희');
INSERT INTO AUTHOR VALUES((SELECT nextval('AUTHOR_SEQ') FROM DUAL), '이미희', '이미희');
INSERT INTO AUTHOR VALUES((SELECT nextval('AUTHOR_SEQ') FROM DUAL), '송엘리', '송엘리');
INSERT INTO AUTHOR VALUES((SELECT nextval('AUTHOR_SEQ') FROM DUAL), '김시현', '김시현');
INSERT INTO AUTHOR VALUES((SELECT nextval('AUTHOR_SEQ') FROM DUAL), '한주아', '한주아');
INSERT INTO AUTHOR VALUES((SELECT nextval('AUTHOR_SEQ') FROM DUAL), '이종인', '이종인');

CREATE TABLE ARTWORK (
	ART_NO		BIGINT	PRIMARY KEY,
	AUTHOR_NO	BIGINT  REFERENCES AUTHOR(AUTHOR_NO) ON DELETE CASCADE,
	ART_NAME	VARCHAR(100),
	PATH		VARCHAR(300),
	PRICE		INT,
   	THEME       VARCHAR(100),
	STATE		INT
);

INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '움직이는 집- 휴식', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0055/A0055-0105.jpg', 69000, '풍경', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, 'Soak.2', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0234/A0234-0060.jpg', 99000, '추상', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '선 (線)2', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0599/A0599-0004.jpg', 150000, '상상', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '하얀마음', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0825/A0825-0045.jpg', 150000, '풍경', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '꽈리, 현묵소유', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0377/A0377-0013.jpg', 150000, '정물', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, 'a deer landscape', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0517/A0517-0008.jpg', 150000, '정물', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, 'ALBINISM(알비니즘)-白海龜(백해귀)', 'https://og-data.s3.amazonaws.com/media/artworks/half/A1424/A1424-0004.jpg', 99000, '동물', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, 'Red Territory', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0241/A0241-0017.jpg', 120000, '상상', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '달려라 달려', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0016/A0016-0008.jpg', 150000, '동물', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '우연한 구름', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0217/A0217-0001.jpg', 120000, '풍경', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '정원', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0546/A0546-0024.jpg', 69000, '풍경', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, 'An opaque body', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0261/A0261-0092.jpg', 69000, '상상', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '무료한 오후', 'https://og-data.s3.amazonaws.com/media/artworks/half/A1144/A1144-0023.jpg', 120000, '상상', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '식물채집 - 1', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0405/A0405-0014.jpg', 99000, '추상', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, 'My little Shanghai', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0056/A0056-0027.jpg', 150000, '풍경', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '밤바다', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0438/A0438-0067.jpg', 120000, '추상', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, 'Untitled', 'https://og-data.s3.amazonaws.com/media/artworks/half/A1350/A1350-0003.jpg', 69000, '추상', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, 'Cinque Terre', 'https://og-data.s3.amazonaws.com/media/artworks/half/A1000/A1000-0024.jpg', 69000, '인물', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '그리운 날에', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0537/A0537-0012.jpg', 120000, '풍경', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '제주 귤밭', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0027/A0027-0028.jpg', 99000, '풍경', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '내 안의 섬2', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0399/A0399-0009.jpg', 99000, '상상', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '박제된풍경_Maligne lake', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0365/A0365-0020.jpg', 150000, '풍경', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '붉은정원 11-09', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0039/A0039-0005.jpg', 150000, '동물',1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, 'Shroud-Man', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0489/A0489-0025.jpg', 69000, '풍경', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, 'Canvas Gardening_05', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0007/A0007-0028.jpg', 150000, '정물', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '무제', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0071/A0071-0022.jpg', 99000, '추상', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, 'KOI 2', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0502/A0502-0020.jpg', 150000, '동물', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, '데이트', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0411/A0411-0004.jpg', 150000, '인물', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, 'Day light', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0437/A0437-0007.jpg', 150000, '풍경', 1);
INSERT INTO ARTWORK VALUES((SELECT nextval('ART_SEQ') FROM DUAL), 1, 'crying-아리랑', 'https://og-data.s3.amazonaws.com/media/artworks/half/A0223/A0223-0018.jpg', 69000, '상상', 1);


CREATE TABLE MEMBER (
	USER_NO		BIGINT PRIMARY KEY,
	EMAIL		VARCHAR(100) NOT NULL,
	USER_NAME	VARCHAR(100),
	NICKNAME	VARCHAR(100),
	PW			VARCHAR(64),
	TEL			VARCHAR(13),
	USER_STATE	INT,
    UNIQUE KEY(EMAIL)
);

INSERT INTO MEMBER VALUES (MEMBER_SEQ.NEXTVAL, 'ADMIN', 'ADMIN', 'ADMIN', '1111', '012-3456-7890', 1);


CREATE TABLE CART (
	CART_NO 	BIGINT PRIMARY KEY,
	ART_NO	    BIGINT REFERENCES ARTWORK(ART_NO) ON DELETE CASCADE,
	USER_NO 	BIGINT REFERENCES MEMBER(USER_NO) ON DELETE CASCADE
);

CREATE TABLE RENTAL (
	RENTAL_NO   	BIGINT	PRIMARY KEY,
	ART_NO	    	BIGINT	REFERENCES ARTWORK(ART_NO) ON DELETE CASCADE,
	USER_NO	    	BIGINT REFERENCES MEMBER(USER_NO) ON DELETE CASCADE,
	RECIEVER_NAME	VARCHAR(100),
	RECIEVER_TEL	VARCHAR(13),
	ADDRESS			VARCHAR(300),
	REQUIREMENTS	VARCHAR(2000),
	START_DATE     	DATE,
	END_DATE        DATE,
	RENTAL_STATE	INT
);

CREATE TABLE REVIEW (
	REVIEW_NO		BIGINT	PRIMARY KEY,
	ART_NO			BIGINT	REFERENCES ARTWORK(ART_NO) ON DELETE CASCADE,
	USER_NO			BIGINT	REFERENCES MEMBER(USER_NO) ON DELETE CASCADE,
	REVIEW_CONTENT	VARCHAR(4000),
	STAR_RATING		INT	CHECK (STAR_RATING BETWEEN 1 AND 5)
);

INSERT INTO REVIEW VALUES((SELECT nextval('REVIEW_SEQ') FROM DUAL), 1, 1, '테이블이 놓인 편안한 공간을 담은 그림과 가을이 느껴지는 그림의 색감이 볼 때마다 마음에 들어요~ 그림이 있는 이 공간을 보면 가을이 가득 차있는 기분이에요', 1);
INSERT INTO REVIEW VALUES((SELECT nextval('REVIEW_SEQ') FROM DUAL), 1, 1, '초등학교에 다니는 딸은 그림을 보자마자 쿠키 나라 솜사탕에 빠진 푸딩 같다는 말을 하네요. 그러고 보니 푸딩처럼 탱글탱글한 느낌도 드는것 같은데요. 그림을 보면서 색감이나 붓의 터치감을 유심히 보더니 유화도 빨리 그려보고 싶다고 하네요 ㅎㅎ', 1);
INSERT INTO REVIEW VALUES((SELECT nextval('REVIEW_SEQ') FROM DUAL), 1, 1, '아침마다 멈머에게 인사하는걸로 시작하는 요즘, 이번엔 준우가 좋아하는 멈머가 있는 그림으로! 그림하나로 이렇게 집분위기가 따스해졌다. 우리 오늘도 이 공간에서 잘 지내보쟈 아들🤎', 1);
INSERT INTO REVIEW VALUES((SELECT nextval('REVIEW_SEQ') FROM DUAL), 1, 1, '차분한 분위기로 훌륭한 가을 인테리어를 선사해 주는 그림이네요. 가까이서 작품을 보면 세로선의 특이한 기법과 함께 숨어 있는 공간에 파라다이스가 펼쳐지는 것 같은 벅찬 감동이 느껴집니다', 1);
INSERT INTO REVIEW VALUES((SELECT nextval('REVIEW_SEQ') FROM DUAL), 1, 1, '파스텔톤 컬러의 화사한 우주를 표현해서 좀더 색다르게 느껴지네요. 얼핏보면 단순해 보이지만 나름의 규칙과 배열이 존재하는 무한한 우주의 공간감이 느껴지는 매력적인 작품이에요', 1);
INSERT INTO REVIEW VALUES((SELECT nextval('REVIEW_SEQ') FROM DUAL), 1, 1, '어두운 밤과 밝고 둥근 달, 그리고 그 달빛에 비친 데이지 꽃이 자아내는 은은하면서 온화한 느낌이 느껴져요. 요즘 마음이 조금 지치고 울적한 느낌이 들고 있었는데 이 그림을 보면서 힐링하는 중입니다', 1);
INSERT INTO REVIEW VALUES((SELECT nextval('REVIEW_SEQ') FROM DUAL), 1, 1, '꾸준히 이용중인 오픈갤러리. 요번엔 오랜만에 베이지톤 그림을 선택해봤는데 거실에 두니까 너무 예쁘다. 그림 하나로 공간 분위기가 쉽게 바뀌어서 여기저기 그림 옮겨 다는 재미도 있다. 37,000점이 넘는 작품들이 준비되어있어서 고르는 재미도 쏠쏠🧡', 1);
INSERT INTO REVIEW VALUES((SELECT nextval('REVIEW_SEQ') FROM DUAL), 1, 1, '그림대여를 계속 이용하다 보면 우리집에 어울리는 그림인테리어 느낌도 알 수 있고 저처럼 같은 작가의 그림대여를 또 하는 경우도 생기실거에요. 그러다가 정말 마음에 들면 그림구매로도 연결이 되는 것 같더라고요. 이렇게 홈카페 분위기로 여름인테리어를 바꾸니 엄마가 만든 딸기스무디도 스벅 음료처럼 더 맛있게 느껴진다고 하네', 1);
INSERT INTO REVIEW VALUES((SELECT nextval('REVIEW_SEQ') FROM DUAL), 1, 1, '테이블이 놓인 편안한 공간을 담은 그림과 가을이 느껴지는 그림의 색감이 볼 때마다 마음에 들어요~ 그림이 있는 이 공간을 보면 가을이 가득 차있는 기분이에요', 1);
INSERT INTO REVIEW VALUES((SELECT nextval('REVIEW_SEQ') FROM DUAL), 1, 1, '테이블이 놓인 편안한 공간을 담은 그림과 가을이 느껴지는 그림의 색감이 볼 때마다 마음에 들어요~ 그림이 있는 이 공간을 보면 가을이 가득 차있는 기분이에요', 1);


CREATE TABLE COMMENTS (
	COMMENT_NO		BIGINT PRIMARY KEY,
	REVIEW_NO		BIGINT REFERENCES REVIEW(REVIEW_NO) ON DELETE CASCADE,
	USER_NO			BIGINT REFERENCES MEMBER(USER_NO)ON DELETE CASCADE,
	COMMENT_CONTENT	VARCHAR(3000),
	COMMENT_CREATED	DATE,
	DEPTH			INT,
	GROUP_NO		BIGINT,
	COMMMENT_ORD	INT
);



CREATE TABLE ADVERTISEMENT (
	AD_NO		BIGINT	PRIMARY KEY,
	AD_PATH		VARCHAR(300),
    AD_TYPE     VARCHAR(300),
    AD_TITLE    VARCHAR(300),
	AD_EXPLAIN	VARCHAR(4000)
);
INSERT INTO ADVERTISEMENT VALUES((SELECT nextval('ADVERTISEMENT_SEQ') FROM DUAL),'https://cdn.pixabay.com/photo/2020/04/02/05/19/beauty-4993469_960_720.jpg', 'event', '[특별연장] 오늘이 진짜 마지막 기회', '연장요청 폭주! 그림렌탈 신청고객 선착순(50명) 신세계 프리미엄 코스메틱 "비디비치" 기프트 찬스');
INSERT INTO ADVERTISEMENT VALUES((SELECT nextval('ADVERTISEMENT_SEQ') FROM DUAL),'https://cdn.pixabay.com/photo/2020/02/06/18/56/house-4825225_960_720.jpg', 'event', '[오늘종료] 할인혜택이 곧 사라져요!', '지금 그림렌탈 ~80% 할인받고 부담 없이 그림 인테리어 시작해보세요.');
INSERT INTO ADVERTISEMENT VALUES((SELECT nextval('ADVERTISEMENT_SEQ') FROM DUAL),'https://cdn.pixabay.com/photo/2016/03/15/12/24/student-1258137_960_720.jpg', 'artwork', '3개월마다 그림 교체, 그림렌탈 오픈 갤러리', '40,439점의 작품이 당신을 기다리고 있습니다.');
INSERT INTO ADVERTISEMENT VALUES((SELECT nextval('ADVERTISEMENT_SEQ') FROM DUAL),'https://cdn.pixabay.com/photo/2019/02/21/18/52/art-4011967_960_720.jpg', 'service', '그림렌탈이 궁금하다면?', '전문 큐레이터의 1:1 작품 추천으로 당신의 공간을 바꾸어 드립니다.');


CREATE TABLE SHOW_INFO (
	SHOW_NO			BIGINT	PRIMARY KEY,
	SHOW_TITLE		VARCHAR(300),
	SHOW_AUTHOR 	VARCHAR(100),
	SHOW_DATE		VARCHAR(100),
	SHOW_TIME		VARCHAR(100),
	INQUIRING_TEL	VARCHAR(13),
	SHOW_LOCATION	VARCHAR(300)
);

INSERT INTO SHOW_INFO VALUES((SELECT nextval('SHOW_INFO_SEQ') FROM DUAL), 'Talk Play Love', '손현욱', '2021-12-07 ~ 2022-01-22', '10:00 ~ 19:00', '02-514-0555', '서울특별시 강남구 도산대로67길 27(청담동) 1층 장디자인아트');
INSERT INTO SHOW_INFO VALUES((SELECT nextval('SHOW_INFO_SEQ') FROM DUAL), '[BTS X Futura] HUMBLE SOULS', 'Futura', '2021-11-30 ~ 2022-05-29', '11:00 ~ 21:30', '02-2135-5057', '서울특별시 용산구 한강대로 42 (한강로3가) 하이브 인사이트');
INSERT INTO SHOW_INFO VALUES((SELECT nextval('SHOW_INFO_SEQ') FROM DUAL), '제3회 앙데팡당KOREA전', '홍영하 외 다수', '2021-12-22 ~ 2021-12-28', '10:00 ~ 18:00', '02-762-2005', '서울특별시 종로구 돈화문로5가길 1 (돈의동) 피카디리플러스빌딩 4층');
INSERT INTO SHOW_INFO VALUES((SELECT nextval('SHOW_INFO_SEQ') FROM DUAL), 'TRACE - 가드너스 갤러리 초대전', '류영봉', '2021-12-22 ~ 2021-12-28', '10:30 ~ 18:00', '031 703 7772', '경기도 성남시 분당구 운중로125번길 3-8 (운중동)');
INSERT INTO SHOW_INFO VALUES((SELECT nextval('SHOW_INFO_SEQ') FROM DUAL), '사물의 풍경', '밍예스 프로젝트, 서윤정, 연진영 외 다수', '2021-10-13 ~ 2022-01-23', '13:00 ~ 18:00', '070-7737-7067', '서울특별시 서초구 사평대로 84(반포동) 스페이스 이수');
INSERT INTO SHOW_INFO VALUES((SELECT nextval('SHOW_INFO_SEQ') FROM DUAL), '이명수 초대전', '류영봉', '2021-12-02 ~ 2022-02-02', '10:30 ~ 17:00', '031-581-4477', '경기도 가평군 북면 백둔로 322');
INSERT INTO SHOW_INFO VALUES((SELECT nextval('SHOW_INFO_SEQ') FROM DUAL), '투탕카멘 파라오의 비밀', '-', '2021-06-22 ~ 2022-04-24', '10:00 ~ 18:00', '02-6952-8071', '서울특별시 용산구 이태원로 29 (용산동1가) 용산전쟁기념관');
INSERT INTO SHOW_INFO VALUES((SELECT nextval('SHOW_INFO_SEQ') FROM DUAL), '넌 내게 홀렸어!', '다수', '2017-08-01 ~ 2022-08-01', '11:00 ~ 19:00', '031-945-4415', '경기도 파주시 탄현면 헤이리마을길 29');
INSERT INTO SHOW_INFO VALUES((SELECT nextval('SHOW_INFO_SEQ') FROM DUAL), '심상지도', '김봄', '2021-06-02 ~ 2023-07-11', '10:00 ~ 18:00', '032-764-7663', '인천광역시 동구 화도진로192번길 3-8 (만석동) 3-7,9,11');
INSERT INTO SHOW_INFO VALUES((SELECT nextval('SHOW_INFO_SEQ') FROM DUAL), '자유를 느끼다 자연을 만나다', '장은하 외 1 명', '2021-07-13 ~ 2023-07-25', '13:00 ~ 19:00', '010-2047-0222', '서울특별시 중구 퇴계로36길 35 (필동2가)');


/*작품 렌탈시 작품의 STATE를 1로 수정하는 트리거*/

DROP TRIGGER RENTAL_INSERT;
DELIMITER $$
	CREATE TRIGGER RENTAL_INSERT 
	 AFTER INSERT ON RENTAL 
	 FOR EACH ROW
	 BEGIN 
	  UPDATE ARTWORK SET STATE = 2 WHERE ART_NO = NEW.ART_NO;
	 END;
DELIMITER ;


/*작품 반납시 ARTWORK_STATE 2로 수정하는 트리거*/

DROP TRIGGER ART_RETURN;
DELIMITER $$
	CREATE TRIGGER ART_RETURN
	 AFTER UPDATE ON RENTAL
	 FOR EACH ROW
	 BEGIN
	   IF NEW.RENTAL_STATE = 2 THEN
		UPDATE ARTWORK 
		SET STATE = 1 
		WHERE ART_NO = OLD.ART_NO;
		END IF;
	END;
DELIMITER;

COMMIT;