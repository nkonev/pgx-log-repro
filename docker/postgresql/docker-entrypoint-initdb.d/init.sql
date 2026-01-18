create table chat_common (
    id bigint primary key,
    title text not null
);

insert into chat_common(id, title) values 
(1, 'Chat of souls'),
(2, 'Not a chat'),
(3, 'Hidden')
;