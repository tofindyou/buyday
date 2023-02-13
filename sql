# member

create table member(
	userid varchar(50) primary key,
	userpw varchar(50) not null,
    username varchar(30) not null,
    useraddress varchar(100),
    email varchar(100),
    tel varchar(20) not null,
    birthDate varchar(20),
    regDate timestamp default now()
);

alter table member add postcode varchar(20);

select * from member order by regDate desc;

drop table member;

DELETE FROM member WHERE userid = "1234";

alter table member add point varchar(8);



# product

create table product (
	productId varchar(100) primary key,
    productName varchar(100) not null,
    price varchar(10) not null, /* price 는 반드시 숫자만으로 입력해야 함 (jsp 에서 fmt:parseNumber 를 사용하였음) */
    stock varchar(4) default 0,
    category varchar(50),
    productInfo varchar(300),
    regDate timestamp default now(),
    updateDate timestamp default now()
);

select * from product order by regDate desc, updateDate desc;

INSERT INTO PRODUCT (productId, productName, price) VALUES ('test_product_id5', 'test_product_name', 50000);



# cart
/* (장바구니 정보는 CRUD 작업이 필요하므로 작성한다.
	장바구니 정보에는 상품 정보, 고객 정보가 필요하므로
    해당 테이블을 참조하는 외래키를 추가한다.) */

create table cart (
	userid varchar(50),
    productId varchar(100),
    cartid varchar(10) primary key, /* cartid 는 숫자 1 부터 순차적 입력할 예정 */
    cart_quantity varchar(4),
    regDate timestamp default now()
);

alter table cart add foreign key(userid) references member(userid);
alter table cart add foreign key(productId) references product(productId);

drop table cart;

select * from cart order by regDate desc;

insert into cart (userid, productId, cartid) values ("final1", "449724_COL_COL05_276", 1);
insert into cart (userid, productId, cartid) values ("kim", "L2_M_CATEGORY_JEANS_220902", 2);

select max(cartid) from cart;



# setOrder

create table setOrder (
	userid varchar(50),
    username varchar(30),
    email varchar(100),
    tel varchar(20),
    useraddress varchar(100),
    postcode varchar(20),
    point varchar(8),
    
    productId varchar(100),
    productName varchar(100),
    price varchar(10),
    category varchar(50),
    productInfo varchar(300),
    
	orderId varchar(40) primary key,
    order_seq varchar(8),
    order_quantity varchar(4),
    selected_size varchar(2),
    delivery_status varchar(2), /* boolean 으로 설정 */
    delivery_msg varchar(300),
    amount varchar(8),
    payment_method varchar(20),
    orderDate timestamp default now()
);

alter table setOrder add foreign key(userid) references member(userid);
alter table setOrder add foreign key(productId) references product(productId);

drop table setOrder;

select * from setOrder;

update setOrder set delivery_status = "1" where orderId = "20230213102707";

insert into setOrder (userid, productId, orderId, order_seq)
values ("final1", "452361_COL_COL04_276", "20230213075500", "1");

delete from setOrder where order_seq = 1;



