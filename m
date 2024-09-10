Return-Path: <cgroups+bounces-4800-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA1097357A
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 12:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF60B1C24635
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86D717BB0C;
	Tue, 10 Sep 2024 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GihFLLgL"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C62AF15
	for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965401; cv=none; b=BXLn2k9wqRsNHUhJdoM3xIhgqBK3Vh7L5iXc/nRNNlcN9QzaLuboamHm3vlD1Pwl8vHbblC4/GGkQXAJkN1Nu7HSAX1tyTcHSWPDmLGBJn6xQqV7E10zut/NQ7+d+756V+7sisZNTZvw6uAKo/wNLXE0594nNB6JEN9DbR/kUls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965401; c=relaxed/simple;
	bh=tjRIYlNK9oEPZidwMLKbN36DkLeUA/Mt/bor3mAYdzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGHq7WMk8BlseHeVN4vWVmCfFCqSglQOLtPflbtAyFAXTeHjymLb12IuEStXtaFhq4Z7cUUnWdfMjznRCyBW1O//bKqCCITRLHbTpSvYNDxw1lMAEQCrqtsf217pct7ySXxemhkY4Lv1s2HbkkUmpKFl+FtzVavzuVME532xfkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GihFLLgL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725965399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YZgcuspLqcfqCSPDpXA3njSxo7eX4xp8bIeZdoi4VBY=;
	b=GihFLLgLcHSM3x32PUoe18B0ek8V/o3TIQahuqRQoCeW3u/DfsVxB9p/B4MW6i16OAQTNI
	O6DqoJo/T9xmmJ8KFV3vxjCe3y/AzmZ1XAxLORXOCjImvkKJM0M5FKFAktb0EEgkR/aIkR
	4TI6Pn/2c1wzeFGdZAcN6usdCGymodc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-iGTAO14eOdC-kAtyuE9GqQ-1; Tue,
 10 Sep 2024 06:49:55 -0400
X-MC-Unique: iGTAO14eOdC-kAtyuE9GqQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08EAE19560B2;
	Tue, 10 Sep 2024 10:49:54 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.32.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 009A219560AA;
	Tue, 10 Sep 2024 10:49:51 +0000 (UTC)
Date: Tue, 10 Sep 2024 06:49:49 -0400
From: Phil Auld <pauld@redhat.com>
To: Liu Song <liusong@linux.alibaba.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched, cgroup: cgroup1 can also take the
 non-RUNTIME_INF min
Message-ID: <20240910104949.GA318990@pauld.westford.csb>
References: <20240910074832.62536-1-liusong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910074832.62536-1-liusong@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


Hi,

On Tue, Sep 10, 2024 at 03:48:32PM +0800 Liu Song wrote:
> For the handling logic of child_quota, there is no need to distinguish
> between cgroup1 and cgroup2, so unify the handling logic here.
> 
> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> ---
>  kernel/sched/core.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e752146e59a4..8418c67faa69 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9501,23 +9501,12 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
>  		parent_quota = parent_b->hierarchical_quota;
>  
>  		/*
> -		 * Ensure max(child_quota) <= parent_quota.  On cgroup2,
> -		 * always take the non-RUNTIME_INF min.  On cgroup1, only
> -		 * inherit when no limit is set. In both cases this is used
> -		 * by the scheduler to determine if a given CFS task has a
> -		 * bandwidth constraint at some higher level.

This comment is here for a reason. Please don't remove it. 

> +		 * Ensure max(child_quota) <= parent_quota.
>  		 */
> -		if (cgroup_subsys_on_dfl(cpu_cgrp_subsys)) {
> -			if (quota == RUNTIME_INF)
> -				quota = parent_quota;
> -			else if (parent_quota != RUNTIME_INF)
> -				quota = min(quota, parent_quota);
> -		} else {
> -			if (quota == RUNTIME_INF)
> -				quota = parent_quota;
> -			else if (parent_quota != RUNTIME_INF && quota > parent_quota)
> -				return -EINVAL;
> -		}
> +		if (quota == RUNTIME_INF)
> +			quota = parent_quota;
> +		else if (parent_quota != RUNTIME_INF)
> +			quota = min(quota, parent_quota);
>  	}
>  	cfs_b->hierarchical_quota = quota;
>

I don't think there is a need to optimize this slow path
to allow setting invalid values which have to be handled in
fast paths.   And this will change expected behavior.

So NAK.

Cheers,
Phil

-- 


