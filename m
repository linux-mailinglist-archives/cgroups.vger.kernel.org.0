Return-Path: <cgroups+bounces-13301-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 406DBD39318
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 08:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE53D30133AC
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 07:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C412376E0;
	Sun, 18 Jan 2026 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S15ZWQCu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2735F4A33
	for <cgroups@vger.kernel.org>; Sun, 18 Jan 2026 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768719718; cv=none; b=R1e5toDFlC6sWkO56ccKrEWgCb3+vz+1t6xdseLgm9F/sMRdHWDx3yUn1fQvbUwjiioGhxnHVYU9SehIL9mfM+j45OkcnVenCQWwdmqmYWF/eOE3ZGmXQI8YkwOTMChBoJEPGmvArV8x/qCYzFUUENtdPzPK3ViEHTGvgi/TRdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768719718; c=relaxed/simple;
	bh=7ouGLi6JdM0NKUQXU72THAOshUtnBzIEoRAMbwE/PqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pv27NjvbOdAI9eDOOD6oXiGOrqbGrIBtwyPb1bpH9PpD/ol/4pH3PcRoLOn4kk8OG8KKnaKpwL1XiiA66n9hXcgp+fZ9YwvnYi8n/nhNPrtIH42pSxhkLbT8uYrhiPF5sN+zc/QlEDOjeWwkK9sXwF8aym0GylD3Zv2Aqol3NXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S15ZWQCu; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-648ff033fb2so2944765d50.0
        for <cgroups@vger.kernel.org>; Sat, 17 Jan 2026 23:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768719716; x=1769324516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YnzSPUz1aoS143yFXVx72ftiBt4iAZjMmiuC9ed7P8=;
        b=S15ZWQCuTVW/8R/QGz0DjmIj4690OJ5pcBTOgdP2Z2ApiVyoiHR2RBIhmNO56kkNgs
         8OWCIvh9YV4dsQku7I3kaK+DkvyIOV04tyi9w0SvqTcYKihjJVsG9OQCvmI55S5gmqKF
         5jX5zydrFwyTaH57dW3LTB+2vzSEnzAkY107JA5AMtLsYUp82xnTeWhAgZ5gkO8ytdWA
         mjPh5xxLjmHSmScWxz2GWXK47YlWkZdtHNokaCSywA6mxjiyiFkPVjEcizSFetBS2nLP
         qGBEGvfC84Q0+pAYcSq86UDomQL29XB2RglWIc+V1BqdUGJGT024TdraPsObxzLmMekm
         ZcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768719716; x=1769324516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3YnzSPUz1aoS143yFXVx72ftiBt4iAZjMmiuC9ed7P8=;
        b=QdHEY+MV0ZlIu3o7WhgjyHHoEDThdFeb31j8ka7Iguqlb35zu9zVxbyDgsgcTjkRkW
         R0izAu4X/wgnD28JvTO7AbCLr5y5qoZzoNTa6wAeQD8/7cJItB/ucqwdAU0K2gu2yTHI
         /5e+pQZQcohsJ8ZCEu/Jfc987Ii/t1YlGQMlb4cIDSGw3qh5rf90RajyQPGqYvd1JaTN
         7d7R0FFjzFbF00jdecVRPn6gZtwvlUDf0+wi02JjKCM8tsaPZaP1H9qOxI8fUEmIRmBt
         UzUNqS678D6D4LEe0CSLZfULEEu6fvjd/CCGU5IfcmG8gHbnC2/lZSatL3xiNbk6WS6X
         C6GA==
X-Forwarded-Encrypted: i=1; AJvYcCXIkrPvh+wdiWS0ecQZ4DM5Jw/zGuvCb36GOCVXGpY1I9ihVWoUSj3QiHZItfW22yxwkprKGFXS@vger.kernel.org
X-Gm-Message-State: AOJu0YzP2+zhri0n232vvDU5ytjNz91ZJSFEL+6Fxbz35R75/5oBHIAS
	ypY0O8H7PKIXJJAqn2gBYSH5gjDqdPzu8jCX3fCj2JyJP6HEfYVFin9YzIpwxr+GZ0nRbuN3/vI
	AuHOQt+l2wILjbo4H9BAOXdUQZwfIQ04=
X-Gm-Gg: AY/fxX4CHm0qiVaDGuymvv1aYskGf+8rQV/9P/xv/FICo3wzp6/E8IlWVk6xFrpq1fL
	sP8zlIIoXqBe+AE9JsYRHxeDxhYN/xxbgZPo5FZnlJCMPYMuq1ach/5xXU0ysQG0498lJmvUxDX
	c5UrQY7jse5shzFMfMv4o8t5r0oU5JhdtS6YbGfKrAI33FWYF80M0/bUqTrrf/B38N4V1iSYywo
	WFIAcxQV9Tey+gI5ui/pIWMBQisSCgB0Fh37RgONqPWeM0im18TUUyEYesQKM9zqSuAeFQbS28r
	LlnRsbmUe5EjvY1eoVlvMyxZKNZKI8tB5CfM+0pEEBgHfNzFrYl/JqJVHgtR5yha5/xMX+g=
X-Received: by 2002:a05:690e:1651:b0:644:2e5b:4124 with SMTP id
 956f58d0204a3-6491649f516mr5984846d50.25.1768719716078; Sat, 17 Jan 2026
 23:01:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <696b56b1.050a0220.3390f1.0007.GAE@google.com> <20260117165722.6dc25d72fd58254cb89e711b@linux-foundation.org>
 <CADhLXY6ACKeyLrjARTTdfWyrvUdLbtD-wXiQvsvhsbGjwmUqDA@mail.gmail.com>
In-Reply-To: <CADhLXY6ACKeyLrjARTTdfWyrvUdLbtD-wXiQvsvhsbGjwmUqDA@mail.gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 18 Jan 2026 12:31:43 +0530
X-Gm-Features: AZwV_Qg0s-Fmk0LdSiYD_syYS5grst0M2xrOlSOhhy_fgxLE0lSLFhW8_tjzxJs
Message-ID: <CADhLXY7FJqRLjX7X2yJfa0=iDbUAMwhS35cOEExW+qBJWAnt+A@mail.gmail.com>
Subject: Re: [syzbot] [cgroups?] [mm?] WARNING in memcg1_swapout
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+079a3b213add54dd18a7@syzkaller.appspotmail.com>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 9:51=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> On Sun, Jan 18, 2026 at 6:27=E2=80=AFAM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Sat, 17 Jan 2026 01:30:25 -0800 syzbot <syzbot+079a3b213add54dd18a7@=
syzkaller.appspotmail.com> wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    0f853ca2a798 Add linux-next specific files for 202601=
13
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14f7259a5=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8d6e5303d=
96e21b5
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D079a3b213ad=
d54dd18a7
> > > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909=
b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D167ef92=
2580000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16d295fa5=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/480cd223f3f6=
/disk-0f853ca2.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/1ca2f0dbb7cc/vm=
linux-0f853ca2.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/60a0fef580=
5b/bzImage-0f853ca2.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+079a3b213add54dd18a7@syzkaller.appspotmail.com
> >
> > Thanks.
> >
> > > ------------[ cut here ]------------
> > > WARNING: mm/memcontrol-v1.c:642 at memcg1_swapout+0x6c2/0x8d0 mm/memc=
ontrol-v1.c:642, CPU#0: syz.4.233/6746
> >
> > That's
> >
> >         VM_WARN_ON_ONCE(oldid !=3D 0);
> >
> > which was added by Deepanshu's "mm/swap_cgroup: fix kernel BUG in
> > swap_cgroup_record".
> >
> > This patch has Fixes: 1a4e58cce84e ("mm: introduce MADV_PAGEOUT"),
> > which is six years old.  For some reason it has no cc:stable.
> >
> > Deepanshu's patch has no reviews.
> >
> > So can I please do the memcg maintainer summoning dance here?  We have =
a
> > repeatable BUG happening in mainline Linux.
> >
>
> Hi Andrew,
>
> I checked the git blame output for commit 0f853ca2a798:
>
> Line 763: memcg1_swapout(folio, swap);
> Line 764: __swap_cache_del_folio(ci, folio, swap, shadow);
>                     (d7a7b2f91f36b - Kairui Song, 2026-01-13 02:33:36 +08=
00)
>
> Kairui's reordering patch appears to have been merged on Jan 13.
> The syzbot report is also from Jan 13, likely from earlier in the
> day before the reordering patch was merged.
>
> So this report is from before the fix. The warning should not appear
> in linux-next builds after Jan 13.
>
> Thanks,
>
> Deepanshu

Hi Andrew,

I tested with the latest linux-next in sysbot. It is working fine

Thanks

Deepanshu

