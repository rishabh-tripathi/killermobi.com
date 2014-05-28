alter table users add column current_bucket int(11) not null default 0;
alter table buckets add column zip_path varchar(1000) not null default '';
alter table buckets add column zip_name varchar(255) not null default '';
alter table buckets add column download_id varchar(255) not null default 0;
alter table buckets add column download_count int(11) not null default 0;
update downloads set category_id = category_id*100;
update downloads set type_id = type_id*100;
update downloads set type_id = 0 where type_id = 600;
alter table user_details add column dropbox_session varchar(1024) not null default '';
alter table authentications add column access_token varchar(1024) not null default '';
alter table users add column default_storage int(11) not null default 0;
alter table uploaded_files add column token varchar(50) not null default '';

alter table downloads add column fb_url varchar(255) not null default '';
alter table downloads add column twitter_url varchar(255) not null default '';
alter table downloads add column youtube_url varchar(255) not null default '';

alter table uploaded_files add column download_count int(11) not null default 0;