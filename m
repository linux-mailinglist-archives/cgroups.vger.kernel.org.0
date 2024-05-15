Return-Path: <cgroups+bounces-2913-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 369408C62A6
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 10:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24E1281754
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 08:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1655C4C62E;
	Wed, 15 May 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoytAeSR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA24D9E0;
	Wed, 15 May 2024 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715761067; cv=none; b=aX26Rr5dzJGg3wVNl9CDzBBRhwpyBMlaN46haVJI5xM/YoBYTsbqkAuf45N67vst1VPdn06b4BIF/qDGohFk89Fk3Gt8D9E8xpOcAiiptR1oF03/rtDv+BWTYlIkJ6kYvswaNZmx3woy4se4zNis1NPMfTgXKGm1Xyi2LsYe/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715761067; c=relaxed/simple;
	bh=q5tyix8/CdwXcv3NXRWGGohErOn5+XFyjwCd/BJQAz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/0bjlnK43SLXsudmiYz5xm5kyup5Xniw0J+CGT3/HFOfD92BrZs7Uzav4aWp/d209XZKGOymQMZj77bQo9pORoUuxomYG52m4qtLJHPCZcSBWjMAUpcCBaJEuhHBLbwTVceyvOCTN3AhWoI6Rk21RgX5OKr4rrJaXrHx4cvAco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoytAeSR; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52192578b95so7658832e87.2;
        Wed, 15 May 2024 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715761064; x=1716365864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj6izB1xCJw1GZWlAcK8e0ry0yqw0jDJm2ygPS5dAv4=;
        b=LoytAeSRPPMaLYJvpPXrubauLMwEgK+lsibLgUtYtLVqqqXk7XsDTF8Vs97YZe8HLF
         WiJNEyml6u7Q8YJKDqrj7JHJTVhNJJh+cyhdjQa/IEQY+EeFyo1U5fZTNXXBKZtFeX1y
         y0HEHStb/ZtuUaLxQZYiPg5zxmwLN4T/epRiLLcH/wzFL9l+TjSL1GkwYHNI5TKH048Z
         XG/o4b+uNPlLe33UTRcj1XXypkSs+vgNUk0cnxgJQCwFfV+/gbKiZzjkqqBEjrNM8euJ
         NCVgUIKgfcJFVovPnABk01wHMX6j4R9WoQUTTGhw62uCczbpIHYgIS01JWgIgPukOfVS
         Ol7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715761064; x=1716365864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bj6izB1xCJw1GZWlAcK8e0ry0yqw0jDJm2ygPS5dAv4=;
        b=dQG8qNgGVTL7uOYSbhPGlOENCivwLoWP11OXAIAozWak8KC7RhTgXAFs6VsV8R14J1
         4X6WAXFaubsBukMaTjj2M5OA+96ntHFZ99ILwUgSUcc8pF5O2bRgFffMI4f1jkzqRjyh
         U7LY5mZPsTnFPmTI618qDK88Kvd3oQYpiZ6gpFBLdedEkhDUBkgfsEsfRKoU6MiErk9z
         OJh0fwuh5UvYRqgEYmxmgrIqWI7V6TBrk5X2TF+N+mRw0hP8T3GSQ2pVrWRzm1kmWYpI
         RYnrSpqvaP3aTBCvZVlzJOQ0j9KvjWaRFgtIGaxSFWOk9UuMvwnFVpUel75aT8JENe8f
         01TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO/6+2oKRajWAiBIoSx1BFbZce10xR8Z4ojr+aTGzWahRXbjrWHDPLYXQDiB1lTkMoncd01nNSDKX6PlZR2ROuxSXVQGvKC+6xGxFz/3d1kOcQyBwOId5GIaPecV+2p8jchYbLgufKTekDAaCRqSy6N00uy053G5VYR0+AaWitGobw
X-Gm-Message-State: AOJu0Yywkm6r8CpC3mEdRcR1GnYYSO9GBb//ID6jlxAuE634nlbxXXVI
	mpOcpEtBH+49IyrGc584NoB9Yav6dVM1eVKarUtdV7B7YmBtOsjaOXLVNjxwON01FAuLG8DYq8S
	T3zvgJzqyWmGEryp2eIkeF9+D4JA=
X-Google-Smtp-Source: AGHT+IHzlN7O1yeX51A2QH0c/hRDuBbMvUd+6sXdbSmMrT5WjGn8ZJGvks3a2Cbi+gZdoawSByRjhAf2EvCw8I9UD50=
X-Received: by 2002:a2e:9959:0:b0:2d2:dac3:90f with SMTP id
 38308e7fff4ca-2e5204aef5emr98481421fa.52.1715761064157; Wed, 15 May 2024
 01:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515012350.1166350-1-zhaoyang.huang@unisoc.com>
 <20240515012350.1166350-3-zhaoyang.huang@unisoc.com> <ZkRnCDasZNvFQUaY@slm.duckdns.org>
In-Reply-To: <ZkRnCDasZNvFQUaY@slm.duckdns.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 15 May 2024 16:17:32 +0800
Message-ID: <CAGWkznEbN4UFCS2LQkGMjXeFXFmDBva9pT0fTjX7+mcP2qAiLQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm: introduce budgt control in readahead
To: Tejun Heo <tj@kernel.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Josef Bacik <josef@toxicpanda.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 3:40=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, May 15, 2024 at 09:23:50AM +0800, zhaoyang.huang wrote:
> > +static unsigned long get_next_ra_size(struct readahead_control *ractl,
> >                                     unsigned long max)
> >  {
> > +     unsigned long cur =3D ractl->ra->size;
> > +     struct inode *inode =3D ractl->mapping->host;
> > +     unsigned long budgt =3D inode->i_sb->s_bdev ?
> > +                     blk_throttle_budgt(inode->i_sb->s_bdev) : 0;
>
> Technical correctness aside, I'm not convinced it's generally a good idea=
 to
> bubble up one specific IO control mechanism's detail all the way upto RA
> layer. Besides what's the gain here? For continuous IO stream, whether so=
me
> RA bios are oversized or not shouldn't matter, no? Doesn't this just affe=
ct
> the accuracy of the last RA IO of a finite read stream?
Thanks for feedback. If I understand right, the oversized RA bios of a
finite read will fail by being queued to tg's queue which should be
deemed as introducing a drop of IOPS.

submit_bio
    blk_throtl_bio
        if(!tg_may_dispatch) //failed, queue the bio to tg's queue

What we get here is a more precise BW of the throttled blkcg like
below, from which we can find the result of 'after' could exactly meet
the configured bps value and a little bit enhancement since there are
no hung(oversized) bios any more.

blkio.throttle.read_bps_device =3D 20MB/s
fio ... -numjobs=3D8 ...

    before : IOPS=3D37.9k, BW=3D148MiB/s (155MB/s)(11.6GiB/80333msec)
    after  : IOPS=3D39.0k, BW=3D153MiB/s (160MB/s)(15.6GiB/104914msec)

    before : clat (usec): min=3D4, max=3D1056.6k, avg=3D197.23, stdev=3D100=
80.69
    after  : clat (usec): min=3D4, max=3D193481, avg=3D188.83, stdev=3D4651=
.29

    before : lat (usec): min=3D5, max=3D1056.6k, avg=3D200.48, stdev=3D1008=
0.76
    after  : lat (usec): min=3D5, max=3D193483, avg=3D192.68, stdev=3D4651.=
87

blkio.throttle.read_bps_device =3D 30MB/s
fio ... -numjobs=3D8 ...

    before : IOPS=3D57.2k, BW=3D224MiB/s (234MB/s)(15.6GiB/71561msec)
    after  : IOPS=3D58.5k, BW=3D229MiB/s (240MB/s)(15.6GiB/69996msec)

    before : clat (usec): min=3D4, max=3D1105.5k, avg=3D126.20, stdev=3D641=
9.22
    after  : clat (usec): min=3D4, max=3D183956, avg=3D120.60, stdev=3D2957=
.28

    before : lat (usec): min=3D5, max=3D1105.5k, avg=3D129.45, stdev=3D6419=
.29
    after  : lat (usec): min=3D5, max=3D183958, avg=3D124.40, stdev=3D2958.=
18

>
> Thanks. blk_throttle_budgt

>
> --
> tejun

