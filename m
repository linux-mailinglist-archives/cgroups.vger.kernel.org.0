Return-Path: <cgroups+bounces-4801-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C179735FA
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 13:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BCB285FAA
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 11:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD1918C925;
	Tue, 10 Sep 2024 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XUjRwzyz"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9FF1862B8;
	Tue, 10 Sep 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966836; cv=none; b=UOaNe8gE/8Qcj/H1p9UZ5K7TVQtVlRLvVt/fLvEPxTSuNrb3PA3Agvac1VbGAaiOJhpHnIb0AefIc1+j0pu8qn79PLOjTbFH0yLX1nQ2QE3N9YhgQCV6Lk7VwPQ54Qg2uwblSU2b8tGKLQAUc0v2hcaBNof0fDkrgqt6PFnAJOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966836; c=relaxed/simple;
	bh=ss8YI24+bwtpoeauo+RapxXHfzwXYRLVuejgUIR7Ams=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CS9lKyf89GAuH7VlvUm8nv59NRVHs/betytEdvds0dHIcFlSbNgvN9H9k8S6hF+ZtgX8rGpszAy0Y/aTEkkxlmA8f8vlpNG35Whskujcr5IdgeLm4KewZiCDMcQl/4swQBP279xtaAKPhws2HwPNb6bVhHLVSV5k6CEDB+NX2qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XUjRwzyz; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725966825; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=KBIey+3aqcnDOe1MADYXNZUTujmQY9SdJ4Gt4wOtH2E=;
	b=XUjRwzyzSj1xyqmYyHk785tw/FjkjvRU4+dS5Obn/YlYjD8j1PuTAIrZtS0uJ8gPNk5Ec1NGoB1ME6KGBwOIQw2Eq6gX7flpQpUFh8BghcCS18seBWBtnZagTIysEtkiEAlcsX3c6Oyt+H3KV6ypRDs5M4/B7KADTOwJjNTLfGY=
Received: from smtpclient.apple(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0WEkHz5h_1725966823)
          by smtp.aliyun-inc.com;
          Tue, 10 Sep 2024 19:13:44 +0800
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RFC PATCH] sched, cgroup: cgroup1 can also take the
 non-RUNTIME_INF min
From: =?utf-8?B?5YiY5bWp?= <liusong@linux.alibaba.com>
In-Reply-To: <20240910104949.GA318990@pauld.westford.csb>
Date: Tue, 10 Sep 2024 19:13:32 +0800
Cc: tj@kernel.org,
 lizefan.x@bytedance.com,
 hannes@cmpxchg.org,
 =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0339F628-43F2-40D1-B199-5E641C238CAC@linux.alibaba.com>
References: <20240910074832.62536-1-liusong@linux.alibaba.com>
 <20240910104949.GA318990@pauld.westford.csb>
To: Phil Auld <pauld@redhat.com>
X-Mailer: Apple Mail (2.3774.600.62)



> 2024=E5=B9=B49=E6=9C=8810=E6=97=A5 18:49=EF=BC=8CPhil Auld =
<pauld@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
> Hi,
>=20
> On Tue, Sep 10, 2024 at 03:48:32PM +0800 Liu Song wrote:
>> For the handling logic of child_quota, there is no need to =
distinguish
>> between cgroup1 and cgroup2, so unify the handling logic here.
>>=20
>> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
>> ---
>> kernel/sched/core.c | 21 +++++----------------
>> 1 file changed, 5 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index e752146e59a4..8418c67faa69 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -9501,23 +9501,12 @@ static int tg_cfs_schedulable_down(struct =
task_group *tg, void *data)
>> parent_quota =3D parent_b->hierarchical_quota;
>>=20
>> /*
>> - * Ensure max(child_quota) <=3D parent_quota.  On cgroup2,
>> - * always take the non-RUNTIME_INF min.  On cgroup1, only
>> - * inherit when no limit is set. In both cases this is used
>> - * by the scheduler to determine if a given CFS task has a
>> - * bandwidth constraint at some higher level.
>=20
> This comment is here for a reason. Please don't remove it.

Hi

I don=E2=80=99t see why cgroup1 needs to impose this restriction while =
cgroup2
can directly take the non-RUNTIME_INF minimum value. What is the
necessity of this?=20

It seems more reasonable to unify the handling logic. Even if the child
group quota exceeds the parent group quota, it would not actually take
effect.=20

However, if the parent group quota is reset to a larger value, then the
child group quota would have actual significance. Therefore, the =
handling
logic should be consistent between cgroup1 and cgroup2.

Thanks


>=20
>> + * Ensure max(child_quota) <=3D parent_quota.
>> */
>> - if (cgroup_subsys_on_dfl(cpu_cgrp_subsys)) {
>> - if (quota =3D=3D RUNTIME_INF)
>> - quota =3D parent_quota;
>> - else if (parent_quota !=3D RUNTIME_INF)
>> - quota =3D min(quota, parent_quota);
>> - } else {
>> - if (quota =3D=3D RUNTIME_INF)
>> - quota =3D parent_quota;
>> - else if (parent_quota !=3D RUNTIME_INF && quota > parent_quota)
>> - return -EINVAL;
>> - }
>> + if (quota =3D=3D RUNTIME_INF)
>> + quota =3D parent_quota;
>> + else if (parent_quota !=3D RUNTIME_INF)
>> + quota =3D min(quota, parent_quota);
>> }
>> cfs_b->hierarchical_quota =3D quota;
>>=20
>=20
> I don't think there is a need to optimize this slow path
> to allow setting invalid values which have to be handled in
> fast paths.   And this will change expected behavior.
>=20
> So NAK.
>=20
> Cheers,
> Phil
>=20
> --


