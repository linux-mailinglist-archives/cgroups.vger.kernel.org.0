Return-Path: <cgroups+bounces-4803-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC989736E6
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50592896BB
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375AC18FDA5;
	Tue, 10 Sep 2024 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0+j3NxW"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3918DF8F
	for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970337; cv=none; b=rjEzrQ5otkAVxTyz9kpIm2rXoyCDaPaFellRj2M2H63wguBWU3lbtmREUVirYNWT2Cbpaxlekw4VyZs0spT+1sWlTN2fQ8GAjqe/hq9D1hTHGUM6nuSfrRYV0s/YpJuyy4bfVA+gbMPg5cfl38aX2xnShm9lOa5+Q6saWbOcLlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970337; c=relaxed/simple;
	bh=t0gEutdl6lArfQ4mxt9PBtquIJv22r6Vqp5mGj9q1Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2/SWZ/frM1b0i7f09bUTSvnEL3/LlMWP94VKASoVu04FmA0DU4RZ5VQSHF3GEdYGa/dYC5VQGyOEYWUEANcz1hJ8peV82fNw4/x8I/3Q0xkWSrj00QxtNCIWdQJdiiayhzWxGTP8/2Z/RTNM1eUw7n00S+AGAElWmo/S6g6h4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0+j3NxW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725970333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyK5emFvwMpmdU1nLRx0/iN2Gl/znXxq5FCrTqgvDWw=;
	b=N0+j3NxWSMshcTBJVNgaENAhgmLxZh1QZuQ8ClIJYoqlX9YPTOtZTJ8A5hZCv0D8Hla9px
	y5zDBjk+XwHVz1tGfbTAyc7qXyHcSdj3u3W4Y/VBg+W4Q90Lb3kmCB65AwOe8gUC4mYtW8
	8dfa9FZyGSQe+E/n6njTJISMVPSpfTQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-6JbTV2KpMXOuA3BC3M810g-1; Tue,
 10 Sep 2024 08:12:10 -0400
X-MC-Unique: 6JbTV2KpMXOuA3BC3M810g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82C631955DDC;
	Tue, 10 Sep 2024 12:12:08 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.32.72])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F1DE1956096;
	Tue, 10 Sep 2024 12:12:06 +0000 (UTC)
Date: Tue, 10 Sep 2024 08:12:03 -0400
From: Phil Auld <pauld@redhat.com>
To: =?utf-8?B?5YiY5bWp?= <liusong@linux.alibaba.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched, cgroup: cgroup1 can also take the
 non-RUNTIME_INF min
Message-ID: <20240910121203.GD318990@pauld.westford.csb>
References: <20240910074832.62536-1-liusong@linux.alibaba.com>
 <20240910104949.GA318990@pauld.westford.csb>
 <0339F628-43F2-40D1-B199-5E641C238CAC@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0339F628-43F2-40D1-B199-5E641C238CAC@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Sep 10, 2024 at 07:13:32PM +0800 刘嵩 wrote:
> 
> 
> > 2024年9月10日 18:49，Phil Auld <pauld@redhat.com> 写道：
> > 
> > 
> > Hi,
> > 
> > On Tue, Sep 10, 2024 at 03:48:32PM +0800 Liu Song wrote:
> >> For the handling logic of child_quota, there is no need to distinguish
> >> between cgroup1 and cgroup2, so unify the handling logic here.
> >> 
> >> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> >> ---
> >> kernel/sched/core.c | 21 +++++----------------
> >> 1 file changed, 5 insertions(+), 16 deletions(-)
> >> 
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index e752146e59a4..8418c67faa69 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -9501,23 +9501,12 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
> >> parent_quota = parent_b->hierarchical_quota;
> >> 
> >> /*
> >> - * Ensure max(child_quota) <= parent_quota.  On cgroup2,
> >> - * always take the non-RUNTIME_INF min.  On cgroup1, only
> >> - * inherit when no limit is set. In both cases this is used
> >> - * by the scheduler to determine if a given CFS task has a
> >> - * bandwidth constraint at some higher level.
> > 
> > This comment is here for a reason. Please don't remove it.
> 
> Hi
> 
> I don’t see why cgroup1 needs to impose this restriction while cgroup2
> can directly take the non-RUNTIME_INF minimum value. What is the
> necessity of this? 
>

That's how cgroupv1 bandwidth control is defined. See
Documentation/scheduler/sched-bcw.rst.

> It seems more reasonable to unify the handling logic. Even if the child
> group quota exceeds the parent group quota, it would not actually take
> effect. 
>

It's not about it taking effect or not. You are not supposed to be
allowed to configure a child quota > parent quota. It's supposed to
be an error. 

Also, my comment about the comment specifically is that last sentence, which
explains that other parts of the scheduler rely on this being set correctly,
needs to remain.  But since I don't think this change is right, that should
not be an issue.


Cheers,
Phil

> However, if the parent group quota is reset to a larger value, then the
> child group quota would have actual significance. Therefore, the handling
> logic should be consistent between cgroup1 and cgroup2.
> 
> Thanks
> 
> 
> > 
> >> + * Ensure max(child_quota) <= parent_quota.
> >> */
> >> - if (cgroup_subsys_on_dfl(cpu_cgrp_subsys)) {
> >> - if (quota == RUNTIME_INF)
> >> - quota = parent_quota;
> >> - else if (parent_quota != RUNTIME_INF)
> >> - quota = min(quota, parent_quota);
> >> - } else {
> >> - if (quota == RUNTIME_INF)
> >> - quota = parent_quota;
> >> - else if (parent_quota != RUNTIME_INF && quota > parent_quota)
> >> - return -EINVAL;
> >> - }
> >> + if (quota == RUNTIME_INF)
> >> + quota = parent_quota;
> >> + else if (parent_quota != RUNTIME_INF)
> >> + quota = min(quota, parent_quota);
> >> }
> >> cfs_b->hierarchical_quota = quota;
> >> 
> > 
> > I don't think there is a need to optimize this slow path
> > to allow setting invalid values which have to be handled in
> > fast paths.   And this will change expected behavior.
> > 
> > So NAK.
> > 
> > Cheers,
> > Phil
> > 
> > --
> 

-- 


