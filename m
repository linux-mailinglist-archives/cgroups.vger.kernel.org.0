Return-Path: <cgroups+bounces-5968-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 009A39F7673
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2024 08:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD871882506
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2024 07:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CF82165EE;
	Thu, 19 Dec 2024 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gJD4Af7t"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FB9149DF4
	for <cgroups@vger.kernel.org>; Thu, 19 Dec 2024 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734595027; cv=none; b=n1aHNxqjmBCgbXjWRRXQl851BfkI45OdsPfus2pLZHIf0oFx+TxSukJ5hcqZA7/IUDds6nom5vVz3q68W4dERuwOKUWBVppdp8Y+oMAw0V2krElPSI2yYKTJ6dFP0m4P9PF03GbqI5heO78VRi58A3a4TVgKnKA1LrmlfBeMfd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734595027; c=relaxed/simple;
	bh=N2tKNLtLJtOHWoOrsE9lz6kDRGWmZBcTqhq1ZmtwoYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoBC96g8/LFFb3UF/F43xWsGUR5hsIVnOItPclmwfQxlxfyQ4lZZVeA4qaTiMw/Ds0Xyy2s18VYNctiOp3rEwc4aDyacRLYGqaTKV6k86+AtIsOpnoaaD7M3Dtg4FAcMfejDc2r8+Hes8m/SYMCy4y7aTqoIQOo+rmp7TznbbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gJD4Af7t; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aab925654d9so94033866b.2
        for <cgroups@vger.kernel.org>; Wed, 18 Dec 2024 23:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734595023; x=1735199823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JEx8BhRUkkgkswMHP6Lmd6KXutJJvSq42c8tbR5W3Eo=;
        b=gJD4Af7tUvVBbWqMlIHXGHCdgKNAuadpMuqoq/sTzizUs/VC2xc8jQnG5WCfy6z04G
         5U9euoDHkJA3Nb/aZWBHGu8+LyEugQICLmmGNVgza8unCSo4m8JLP58u0yPk9GRHejeM
         ctLuwM7GuST9qtX9mwr2WknjymKBkioVq4pfJOiid0kD5txy5PbOUKH7fo3Xjd9o9RHe
         BVV+lmgN2ccm9DhJXWRmolb+vIyK2U+I7/NeO+s8xGkkWwu4bebtf5H5m4vVNO3CAVsB
         JOnYi6yN9ZN79/qFRGwden9+Dkcriws/xXgdoJizVZYw9bE/msvu9sCbwEkktMKptGZF
         QFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734595023; x=1735199823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEx8BhRUkkgkswMHP6Lmd6KXutJJvSq42c8tbR5W3Eo=;
        b=U3Pc5I8pjsVW8tW1kUbIipFHxRQI/FTcoS9ycdLFf9jiwVDl082I8Xe6R8gmgbuuXI
         VohpuGEbrLK5EcBjGSdv/X5LZx/93CqVce106a+1CDZ/ggfM9Hj+4xJJCXL6S6R9wxoO
         rUm+XoeM9fdvg9go/Ocz28b/1FLwQy0Lxbe5lUmEYqEuBVwd9BJGOl2ycNmehurcMGq9
         G+6sXIJjRdgHH7TNQ/AOCNB717+BNc4VZs8A24zpwSPe301bzPPLrQtevJCmy7PKukRl
         eUsn/giXmTl4HKVO7Ct1/Rrrs14OA/PPtWEv4CiN2oK8o9KD4bGYC8tqdWxfWStCQZI6
         oHkw==
X-Forwarded-Encrypted: i=1; AJvYcCWMhdODWjzAVdSg9/tYzxVGB4vNBIFosELwa4tFSDtmmJaNq1c0c3au+4ieeIBS1oUX489xNo1t@vger.kernel.org
X-Gm-Message-State: AOJu0YzRxGzI3znrJlkmabJp+rmQSw5P+UqrnJNZYbJtuKM5sarkSIZP
	ZNPFrM9FtHSwxG3/UE3dV6MhML5aH3/d8MCdag0VBXe8lLle6XmyUcYpQHA1fQY=
X-Gm-Gg: ASbGnculAgNl7amVEBsL8NPMnUeeTbU0t70EMe9RVi5x4Kgf5ke3w0qaOGZhhxCxje+
	TSwHyVhtnNrkkdaM06HQC92zeXnXedqPq4+SL5X/ORV51q/3wJoTdqaXvnxDLVXiB9dFJuXOXUL
	HR1/NK9Qo+EkMycw96Y5ajRjLS/nT9/DlcTW1hG4MxtHrp1vBK1EnyFa7YRHn3bP86lWUTnynvV
	IZD/TG6B8begFTCviYj2uwmOosNiKBDeboJaTeacxTXAOh3BMz0ddftP6PxVwxl
X-Google-Smtp-Source: AGHT+IFObg+BLSYVoCnWrejO/CfDsPWEnBJkisYPPT/XL+9HTYPC53Xic1aTpZCg0MxeBKFnmi/9Og==
X-Received: by 2002:a17:907:9555:b0:aab:a0d4:ec9f with SMTP id a640c23a62f3a-aabf4758f2amr406629166b.21.1734595023224;
        Wed, 18 Dec 2024 23:57:03 -0800 (PST)
Received: from localhost (109-81-88-1.rct.o2.cz. [109.81.88.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e89537dsm37406766b.54.2024.12.18.23.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 23:57:02 -0800 (PST)
Date: Thu, 19 Dec 2024 08:57:01 +0100
From: Michal Hocko <mhocko@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org,
	hannes@cmpxchg.org, yosryahmed@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, davidf@vimeo.com,
	vbabka@suse.cz, handai.szj@taobao.com, rientjes@google.com,
	kamezawa.hiroyu@jp.fujitsu.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v1] memcg: fix soft lockup in the OOM process
Message-ID: <Z2PRzf0EU_wGwEVI@tiehlicka>
References: <20241217121828.3219752-1-chenridong@huaweicloud.com>
 <Z2F0ixNUW6kah1pQ@tiehlicka>
 <872c5042-01d6-4ff3-94bc-8df94e1e941c@huaweicloud.com>
 <Z2KAJZ4TKZnGxsOM@tiehlicka>
 <02f7d744-f123-4523-b170-c2062b5746c8@huaweicloud.com>
 <Z2KichB-NayQbzmd@tiehlicka>
 <7d7b3c01-4977-41fa-a19c-4e6399117e8e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7b3c01-4977-41fa-a19c-4e6399117e8e@huaweicloud.com>

On Thu 19-12-24 09:27:52, Chen Ridong wrote:
> 
> 
> On 2024/12/18 18:22, Michal Hocko wrote:
> > On Wed 18-12-24 17:00:38, Chen Ridong wrote:
> >>
> >>
> >> On 2024/12/18 15:56, Michal Hocko wrote:
> >>> On Wed 18-12-24 15:44:34, Chen Ridong wrote:
> >>>>
> >>>>
> >>>> On 2024/12/17 20:54, Michal Hocko wrote:
> >>>>> On Tue 17-12-24 12:18:28, Chen Ridong wrote:
> >>>>> [...]
> >>>>>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> >>>>>> index 1c485beb0b93..14260381cccc 100644
> >>>>>> --- a/mm/oom_kill.c
> >>>>>> +++ b/mm/oom_kill.c
> >>>>>> @@ -390,6 +390,7 @@ static int dump_task(struct task_struct *p, void *arg)
> >>>>>>  	if (!is_memcg_oom(oc) && !oom_cpuset_eligible(p, oc))
> >>>>>>  		return 0;
> >>>>>>  
> >>>>>> +	cond_resched();
> >>>>>>  	task = find_lock_task_mm(p);
> >>>>>>  	if (!task) {
> >>>>>>  		/*
> >>>>>
> >>>>> This is called from RCU read lock for the global OOM killer path and I
> >>>>> do not think you can schedule there. I do not remember specifics of task
> >>>>> traversal for crgoup path but I guess that you might need to silence the
> >>>>> soft lockup detector instead or come up with a different iteration
> >>>>> scheme.
> >>>>
> >>>> Thank you, Michal.
> >>>>
> >>>> I made a mistake. I added cond_resched in the mem_cgroup_scan_tasks
> >>>> function below the fn, but after reconsideration, it may cause
> >>>> unnecessary scheduling for other callers of mem_cgroup_scan_tasks.
> >>>> Therefore, I moved it into the dump_task function. However, I missed the
> >>>> RCU lock from the global OOM.
> >>>>
> >>>> I think we can use touch_nmi_watchdog in place of cond_resched, which
> >>>> can silence the soft lockup detector. Do you think that is acceptable?
> >>>
> >>> It is certainly a way to go. Not the best one at that though. Maybe we
> >>> need different solution for the global and for the memcg OOMs. During
> >>> the global OOM we rarely care about latency as the whole system is
> >>> likely to struggle. Memcg ooms are much more likely. Having that many
> >>> tasks in a memcg certainly requires a further partitioning so if
> >>> configured properly the OOM latency shouldn't be visible much. But I am
> >>> wondering whether the cgroup task iteration could use cond_resched while
> >>> the global one would touch_nmi_watchdog for every N iterations. I might
> >>> be missing something but I do not see any locking required outside of
> >>> css_task_iter_*.
> >>
> >> Do you mean like that:
> > 
> > I've had something like this (untested) in mind
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 7b3503d12aaf..37abc94abd2e 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1167,10 +1167,14 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
> >  	for_each_mem_cgroup_tree(iter, memcg) {
> >  		struct css_task_iter it;
> >  		struct task_struct *task;
> > +		unsigned int i = 0
> >  
> >  		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
> > -		while (!ret && (task = css_task_iter_next(&it)))
> > +		while (!ret && (task = css_task_iter_next(&it))) {
> >  			ret = fn(task, arg);
> > +			if (++i % 1000)
> > +				cond_resched();
> > +		}
> >  		css_task_iter_end(&it);
> >  		if (ret) {
> >  			mem_cgroup_iter_break(memcg, iter);
> 
> Thank you for your patience.
> 
> I had this idea in mind as well.
> However, there are two considerations that led me to reconsider it:
> 
> 1. I wasn't convinced about how we should call cond_resched every N
> iterations. Should it be 1000 or 10000?

Sure, there will likely not be any _right_ value. This is mostly to
mitigate the overhead of cond_resched which is not completely free.
Having a system with 1000 tasks is not completely uncommon and we do not
really need cond_resched now.

More importantly we can expect cond_resched will eventually go away with
the PREEMPT_LAZY (or what is the current name of that) so I wouldn't
overthink this.

> 2. I don't think all callers of mem_cgroup_scan_tasks need cond_resched.
> Only fn is expensive (e.g., dump_tasks), and it needs cond_resched. At
> least, I have not encountered any other issue except except when fn is
> dump_tasks.

See above. I wouldn't really overthink this.
-- 
Michal Hocko
SUSE Labs

