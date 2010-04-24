package ViV::FVL::Rule::JA;
use warnings;
use strict;
use utf8;

sub unique_id { '$_[field]は既に登録されています。' }
sub valid_id { '$_[table]のレコードが存在しません。' }


1;
