Return-Path: <cgroups+bounces-4798-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE86C97314D
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 12:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695FA1F27630
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 10:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5EA18FC73;
	Tue, 10 Sep 2024 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tsIFNrkk"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E01885A5;
	Tue, 10 Sep 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962745; cv=none; b=o9MqD9R5xYlG42UUp0oxQ8AZb4z6KtvDGnSeON7UZkVK4e+RVhq3+UOpeiOtinvzFCWlkny1WqS/79OCG2gCpU9Rt61gOZP3iMetGsBLJm6c0gWG++yUXBXM39euC7+qS3T0NpmlmGWlZr3lU/pdm4lilnBG4b5TGSFfF5wNS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962745; c=relaxed/simple;
	bh=tu8X9dwW6HzDMOtBT4dTgmJnhOEZVUCNKA5IzI8lVjQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Obfvhxv+mItj7G1vqkWnZ9V6veY/MaOzLD+ShxPps1DdJIiz3nx69tFiRl0lB89eFsTIbX2SGcdQ4BnR2yxX/o5N0YwOB04BbZniGJn4MCmMiniZaaveL0DhPVwLDLOZuATiw8mvcz/1qDhWWsDCCqSj/t9MUeR2sLjz2KmQ6EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tsIFNrkk; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725962735; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=NSDOMiRqf4Ype5BHpo/zHwUsrayd7BLkysQhUjWkhe8=;
	b=tsIFNrkkFihJy/Pkk5o2owoXyOrW8bhGVs4VQ9U0bUEPiJvysM0fkrJwrhEBZG2bQJBvdEJ9GX7qgXX+TVt6nBzUBA7kaKzmHJ69RAaT2d4/vnGoPfCc2HnqmEdym8oVNYv0gvNVXNxTt3mHL0SIwFPmao6j6D5NB6Qi84F409I=
Received: from smtpclient.apple(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0WEk2.rd_1725962733)
          by smtp.aliyun-inc.com;
          Tue, 10 Sep 2024 18:05:34 +0800
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
In-Reply-To: <t5x3lxz2au5caw33redslk6vmak4nc7kmuxzflhd7tr2x4d7ma@ssdb2g4nkdlq>
Date: Tue, 10 Sep 2024 18:05:22 +0800
Cc: tj@kernel.org,
 lizefan.x@bytedance.com,
 hannes@cmpxchg.org,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0D163D9-640F-4881-93C4-CCE40B5701F9@linux.alibaba.com>
References: <20240910074832.62536-1-liusong@linux.alibaba.com>
 <t5x3lxz2au5caw33redslk6vmak4nc7kmuxzflhd7tr2x4d7ma@ssdb2g4nkdlq>
To: =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
X-Mailer: Apple Mail (2.3774.600.62)



> 2024=E5=B9=B49=E6=9C=8810=E6=97=A5 17:35=EF=BC=8CMichal Koutn=C3=BD =
<mkoutny@suse.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hello.
>=20
> On Tue, Sep 10, 2024 at 03:48:32PM GMT, Liu Song =
<liusong@linux.alibaba.com> wrote:
>> For the handling logic of child_quota, there is no need to =
distinguish
>> between cgroup1 and cgroup2, so unify the handling logic here.
>=20
> IIUC, v1 check prevents quota overcommit while v2 doesn't.  So this
> isn't user invisible change (i.e. there may be a need to distinguish =
the
> two).
>=20
Hi

In cgroup2, child task group quota can set exceed parent task group =
quota.
However, at the scheduling level, the cpu runqueue (rq) performs checks
on the runtime of the CFS run queue (cfs_rq) in a hierarchical way.=20
Therefore, even though the child group quota appears to be greater than =
the
parent group quota, it will not actually receive a runtime that exceeds =
the
parent's quota. This logic also holds true for cgroup1, so there is no =
need to
differentiate the handling logic in this case.

Thanks

> Regards,
> Michal


