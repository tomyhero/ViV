create table member (
    member_id int(10) unsigned NOT NULL auto_increment,
    login_name varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    screen_name varchar(255) NOT NULL,
    on_admin tinyint unsigned NOT NULL,
    created_at datetime NOT NULL default '0000-00-00 00:00:00',
    updated_at timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    PRIMARY KEY (member_id)
);
create table project (
    project_id int(10) unsigned NOT NULL auto_increment,
    owner_id int(10) unsigned NOT NULL ,
    project_name varchar(255) NOT NULL default '',
    created_at datetime NOT NULL default '0000-00-00 00:00:00',
    updated_at timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    PRIMARY KEY (project_id)
);

create table vision (
    vision_id int(10) unsigned NOT NULL auto_increment,
    parent_vision_id int(10) unsigned NOT NULL default 0,
    vision_name varchar(255) NOT NULL default '',
    description text NOT NULL,
    created_at datetime NOT NULL default '0000-00-00 00:00:00',
    updated_at timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    PRIMARY KEY (vision_id)
);

create table actor (
    actor_id int(10) unsigned NOT NULL auto_increment,
    actor_name varchar(255) NOT NULL default '',
    description text NOT NULL,
    created_at datetime NOT NULL default '0000-00-00 00:00:00',
    updated_at timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    PRIMARY KEY (actor_id)
);


create table vision_commitment (
    vision_commitment_id int(10) unsigned NOT NULL auto_increment,
    vision_commitment_name varchar(255) NOT NULL,
    description text NOT NULL,
    created_at datetime NOT NULL default '0000-00-00 00:00:00',
    updated_at timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    PRIMARY KEY (vision_commitment_id)
);

create table action (
    action_id,
    vision_id,
    name
);
create table action_index (
    action_index_id,
    name ,
    description,
);
create table action_point (
);
create table action_reference (
);
create table action_plan (
);
create table action_report (
);
create table action_commitment (
);
