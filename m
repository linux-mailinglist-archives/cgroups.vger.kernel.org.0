Return-Path: <cgroups+bounces-5963-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2C39F62BB
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 11:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9313A168191
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F0198E75;
	Wed, 18 Dec 2024 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q1DUgQDR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21963192598
	for <cgroups@vger.kernel.org>; Wed, 18 Dec 2024 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517367; cv=none; b=QyZaM3C5SOeGhnyDoP5wXWHWgWupIC2Xc5Q3nx068BVlHxEM5ilGW57lVIGFltA3Gu1p+udkvKpLenPfVaaiAlv61RbqE1GkqzOTLb/Gnm0UE2dqnnp1AEL3uS6PKn7LMOYSl60YLmowyrVW//YOR/ixPzBjPZMnU67HI3MLwe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517367; c=relaxed/simple;
	bh=9bzkDyasgQRPQbe0QqxrPH1hlqz7hBcQVSTkwNrJGE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkfMTOFBF/n5lAA9hKSLYoL4wpkjjZsNONRR/YLIVT7oOuRpMBjhDnrGrg7FoRp5VHBnAAWmWMafjhu45ryEtCnNenMCK7EZ56zh7XxP5TE2OwK6JZprtQayOFsVg/v1IFa6prNCHhL2du74kgWj3pPudVzIJYcgNblPyLDxBB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q1DUgQDR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa692211331so115301066b.1
        for <cgroups@vger.kernel.org>; Wed, 18 Dec 2024 02:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734517363; x=1735122163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oYOKzNBnl4zkAfK+4bxUQampaW88vV82YML9h86Utj4=;
        b=Q1DUgQDR3mLmpPGEeYpNQRvlBYJ0ttMi4zFZAi4jvUECSzdUsH6vGfvz+FfM/P0XZP
         fFUt/sa5N9rrNDOvcrN690saQMCOHiiL2FYqpx5lw/mkuUPpu87AHKWEl4tE2YB/lg6V
         WNNK+GPEknDzEWvn9o9bGypVtv3HPuS5Bhd0xEeKr885yF129aouLUU5P/qL4jfW5tgN
         ABdYBR+qjCCrSKOuCkix7xVjU18lSaXa7RxVkW6PWFTCx4TANhr7nDe1GUJtzSACcRCc
         sfDDtr7o+hgco+toUql5fc+FkvKjnTHLrcia1vP3H9ogtFcw1OuW/6y0KtimiJbOkT+D
         /jKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734517363; x=1735122163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYOKzNBnl4zkAfK+4bxUQampaW88vV82YML9h86Utj4=;
        b=Abhofcfv9QWlgClj7KCCWvMiKiX5vcEo80EmJcvP2VH6isLdhM3KIERdQTmEWsG+sh
         aWVGDdcxeGQfPlAQWxSQUbQirEyQeL/EsvqjbpulC0WaCw+SLb7KRHwwmvlhQm+qgUhB
         8geVklV+cpXKQZmnSBTZ+cUFxtbiZouA+33UildgkJybwMH4+OcfZoyA+kEDE5/hqWDM
         OGk5pR7UwhwONJyIkW0ETAMd9QQckaDVc9GV6hOeR3gJOa9MloXWZT4/mMsoBSdCILSn
         HJwTIsitV+MU2q9eDgp8X8MrFkwfbImr+qTOMBvn/cWNNOE4O+z8/5nfuCJaJjPyDQAE
         LIpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8AMi/0kVLKW/1vduzQQdPEUMH+y6AELxFkH5oaORAAJrFocw4gjPbmcjDJ+qjFqJmiejEkHjP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ZRaBOYuo8VjoB4ipwt/vCCFM3arcvZkEONz5rDBwub2f3lPp
	QpzLHGn7fjsJBRKIPrlJMKpj/hLy4WzQUERxogMAuWFeCALojPiCMGF+m/A8Uho=
X-Gm-Gg: ASbGncvHWbbw8A6jb43Lrrf1O9IupqLO+H4k8Z/6mPliXq80HXNvwiS6yVTIp4D6n55
	hM10FNkuqRtam0tbFaK8OrNtU5Igqa1lkh175ZYpEGoVQisNhmhjSLol8dmYL3iOgM2OaJiWZsI
	8dvU3DPui2uzQ3nOETW0LZqgbeRHpEixXf2RyZlUyI0MpQpmQ/iBX3ELNF9peqmTL67En20J/t7
	vRlt/QMbPEwj0iM/t1aPmREXF21Td+2m7C0JKsEWlPl1E+QaROAF2FmspiIfimx8pU=
X-Google-Smtp-Source: AGHT+IEHMf20e4IOkXuBAj5Qk+7IMn4EhZCqjZWbJBo6BUh8KaMpOPPLLrs0IiDTRqJYNXF2qFtlWw==
X-Received: by 2002:a17:906:c093:b0:aab:edc2:ccef with SMTP id a640c23a62f3a-aabedc2cdffmr301073466b.2.1734517363519;
        Wed, 18 Dec 2024 02:22:43 -0800 (PST)
Received: from localhost (109-81-89-64.rct.o2.cz. [109.81.89.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ecfesm548407766b.146.2024.12.18.02.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 02:22:43 -0800 (PST)
Date: Wed, 18 Dec 2024 11:22:42 +0100
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
Message-ID: <Z2KichB-NayQbzmd@tiehlicka>
References: <20241217121828.3219752-1-chenridong@huaweicloud.com>
 <Z2F0ixNUW6kah1pQ@tiehlicka>
 <872c5042-01d6-4ff3-94bc-8df94e1e941c@huaweicloud.com>
 <Z2KAJZ4TKZnGxsOM@tiehlicka>
 <02f7d744-f123-4523-b170-c2062b5746c8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02f7d744-f123-4523-b170-c2062b5746c8@huaweicloud.com>

On Wed 18-12-24 17:00:38, Chen Ridong wrote:
> 
> 
> On 2024/12/18 15:56, Michal Hocko wrote:
> > On Wed 18-12-24 15:44:34, Chen Ridong wrote:
> >>
> >>
> >> On 2024/12/17 20:54, Michal Hocko wrote:
> >>> On Tue 17-12-24 12:18:28, Chen Ridong wrote:
> >>> [...]
> >>>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> >>>> index 1c485beb0b93..14260381cccc 100644
> >>>> --- a/mm/oom_kill.c
> >>>> +++ b/mm/oom_kill.c
> >>>> @@ -390,6 +390,7 @@ static int dump_task(struct task_struct *p, void *arg)
> >>>>  	if (!is_memcg_oom(oc) && !oom_cpuset_eligible(p, oc))
> >>>>  		return 0;
> >>>>  
> >>>> +	cond_resched();
> >>>>  	task = find_lock_task_mm(p);
> >>>>  	if (!task) {
> >>>>  		/*
> >>>
> >>> This is called from RCU read lock for the global OOM killer path and I
> >>> do not think you can schedule there. I do not remember specifics of task
> >>> traversal for crgoup path but I guess that you might need to silence the
> >>> soft lockup detector instead or come up with a different iteration
> >>> scheme.
> >>
> >> Thank you, Michal.
> >>
> >> I made a mistake. I added cond_resched in the mem_cgroup_scan_tasks
> >> function below the fn, but after reconsideration, it may cause
> >> unnecessary scheduling for other callers of mem_cgroup_scan_tasks.
> >> Therefore, I moved it into the dump_task function. However, I missed the
> >> RCU lock from the global OOM.
> >>
> >> I think we can use touch_nmi_watchdog in place of cond_resched, which
> >> can silence the soft lockup detector. Do you think that is acceptable?
> > 
> > It is certainly a way to go. Not the best one at that though. Maybe we
> > need different solution for the global and for the memcg OOMs. During
> > the global OOM we rarely care about latency as the whole system is
> > likely to struggle. Memcg ooms are much more likely. Having that many
> > tasks in a memcg certainly requires a further partitioning so if
> > configured properly the OOM latency shouldn't be visible much. But I am
> > wondering whether the cgroup task iteration could use cond_resched while
> > the global one would touch_nmi_watchdog for every N iterations. I might
> > be missing something but I do not see any locking required outside of
> > css_task_iter_*.
> 
> Do you mean like that:

I've had something like this (untested) in mind
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..37abc94abd2e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1167,10 +1167,14 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	for_each_mem_cgroup_tree(iter, memcg) {
 		struct css_task_iter it;
 		struct task_struct *task;
+		unsigned int i = 0
 
 		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
-		while (!ret && (task = css_task_iter_next(&it)))
+		while (!ret && (task = css_task_iter_next(&it))) {
 			ret = fn(task, arg);
+			if (++i % 1000)
+				cond_resched();
+		}
 		css_task_iter_end(&it);
 		if (ret) {
 			mem_cgroup_iter_break(memcg, iter);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1c485beb0b93..3bf2304ed20c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -430,10 +430,14 @@ static void dump_tasks(struct oom_control *oc)
 		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
 	else {
 		struct task_struct *p;
+		unsigned int i = 0;
 
 		rcu_read_lock();
-		for_each_process(p)
+		for_each_process(p) {
+			if (++i % 1000)
+				touch_softlockup_watchdog();
 			dump_task(p, oc);
+		}
 		rcu_read_unlock();
 	}
 }
-- 
Michal Hocko
SUSE Labs

