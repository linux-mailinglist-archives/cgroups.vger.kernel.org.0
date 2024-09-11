Return-Path: <cgroups+bounces-4838-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F249747F8
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 03:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746E82888A0
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 01:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD80225D7;
	Wed, 11 Sep 2024 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CyMl7f15"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6032A8460;
	Wed, 11 Sep 2024 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726019624; cv=none; b=UywGRHje9jEfizoEIYo1D2Xd/MnPyPdySNyyVMQpujwfQRrV95dqA6anhA3fAVVZPaE7tgr4jzFhgXK3HNx7hEbDWK9+zfWHcfnlbq7zCEC57STCY8OAHzPJTZ63uowrd8PYsCqYSQDZhCSbx3yYXwxUjfYOcPZm/zBSyZ9GRb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726019624; c=relaxed/simple;
	bh=hZDcR8PdFZWl+XiNt3aHWGr4+6Kem637UcITfbJ7k2U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jfZIC8SlHbYCRhnMEhrIZ7rtSCSoLtekgKMppZXFOFFIA0sJRJS74JFLz5wjUzbwwPsDtEubTgG78qZIEaSwamIg0sOucvv4tl2otjCj9ZJxlFCcfumEC0ugP+DiMBC8fI5qsnUD6S0OkuS0GYZvs+beDXP4rxPzTRpvM+AUCqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CyMl7f15; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726019619; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=hZDcR8PdFZWl+XiNt3aHWGr4+6Kem637UcITfbJ7k2U=;
	b=CyMl7f15P0XVAAiuM7/uw5FPQUOjH2wO+9eu6cyzetO1IkSLPgovlzk498ulM2jng82DbqnxU73uhnsxwO1gLXcTPcO0Q+CO0/ShrSqII0TEGolo4y7gBSXMwld7MjNibmQk4KliMT4gEaPzbidTKEofZmraSiuz2wfXkFedTwQ=
Received: from smtpclient.apple(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0WElvSs1_1726019617)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 09:53:38 +0800
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RFC PATCH] sched, cgroup: cgroup1 can also take the
 non-RUNTIME_INF min
From: =?utf-8?B?5YiY5bWp?= <liusong@linux.alibaba.com>
In-Reply-To: <ZuCe0U1Kwr0hYoOz@slm.duckdns.org>
Date: Wed, 11 Sep 2024 09:53:27 +0800
Cc: lizefan.x@bytedance.com,
 hannes@cmpxchg.org,
 =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <784F48E6-C07E-4A38-B45B-BD2D66677894@linux.alibaba.com>
References: <20240910074832.62536-1-liusong@linux.alibaba.com>
 <ZuCe0U1Kwr0hYoOz@slm.duckdns.org>
To: Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)



> 2024=E5=B9=B49=E6=9C=8811=E6=97=A5 03:32=EF=BC=8CTejun Heo =
<tj@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Sep 10, 2024 at 03:48:32PM +0800, Liu Song wrote:
>> For the handling logic of child_quota, there is no need to =
distinguish
>> between cgroup1 and cgroup2, so unify the handling logic here.
>>=20
>> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
>=20
> It doens't make much sense to change the interface for cgroup1 at this
> point. Let's please leave it as-is.
>=20
> Thanks.
>=20
> --=20
> tejun

Hi

In scenarios involving secure shared containers (like Kata), where =
containers are deployed
on VMs and constrained by CPU runtime using quotas, the concept of vCPUs =
comes into
play.

If the CPU limit set by Kubernetes is less than the actual number of =
vCPUs, meaning the
CPU count derived from the quota is less than the vCPU count, then when =
a user runs lscpu
inside the container, the reported CPU count will be greater than the =
container's quota.

If the user uses this reported count to calculate quota and attempts to =
set it for their own
sub-container, it will result in an error under cgroup1, whereas the =
same operation will
succeed under cgroup2. To avoid imposing extra learning costs on users, =
unifying the
handling logic in this regard is still beneficial.

Thanks=

