Return-Path: <cgroups+bounces-5983-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2479F9F11
	for <lists+cgroups@lfdr.de>; Sat, 21 Dec 2024 08:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2AA916BABF
	for <lists+cgroups@lfdr.de>; Sat, 21 Dec 2024 07:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D651EC4D8;
	Sat, 21 Dec 2024 07:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eIszqlFX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172D18A6A6
	for <cgroups@vger.kernel.org>; Sat, 21 Dec 2024 07:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734766098; cv=none; b=jye1EknFycdE27Fsit49VT+K077vHGSuP8MwNE2e2tVaKehVnj5lbNZJqvz+pVK8/SVzHZqbxJOznGF4c7f+ufw6vZ2RXBNK+7+Nw7McXpiGbCW8jMnOP4Isslx3QA9UtUc6bhwIBFI1ydq+dB6lhWIcEHfVs57NrkZZnbvkTWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734766098; c=relaxed/simple;
	bh=1f9p+y4d/GY9dmYzXSe4n28/ksqkQiyNWLPnNNm9qnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJc/QYybGHHuHpd2OCJCAk6zdCJ2tQGHi5a8rLHVkHu8o9NMiMuKPfih+y39u/SZglv4Fs+U1NbC+I+BjbLP1fx9uSF0juPVYeRpcVj5CPnpEOqlTKg7vndPeRQ3d5UDWoij3gjs1Dy/rOGpim2JtMoZTROTckLBbB2VyjbDLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eIszqlFX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a68480164so440445766b.3
        for <cgroups@vger.kernel.org>; Fri, 20 Dec 2024 23:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734766094; x=1735370894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfsGErZKjmGQuLFmm6/I8+C/KfUfqFh+6QS5YvZcZGo=;
        b=eIszqlFXn8zX//UGm8sWcLN5Jh6bVdt1nHzJ6vCYYDDivvxS/QWRTv8GsvuffS8Bag
         /fVLoiKH3qm48SwCjqKt5oAp2LAOPu8/8MUfhBCQILBD05eXRaggL6MSEZYcmExNrW1k
         d32h96ezBioYXydLxJ0ZgFxzqYh1obSLk4Mz/IIaIde7jKxJlOBXcXbZwCompW2IO+wi
         6E8w2sd7hhADvacppNiHbQFJJEPb2uVc3hacUGHUSFTWGWASPyjxri69E9BH/9horpjN
         hQkwQR6AVRmeW2Xo1ouKtvXF4ajBQS/Cv0tVTu76A9T1xFsI3yHkyj846UOHPg4njOEu
         YsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734766094; x=1735370894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfsGErZKjmGQuLFmm6/I8+C/KfUfqFh+6QS5YvZcZGo=;
        b=xTqtHR/U8ZvEEhOVmPLQR+mughisdY9AratPIrUXyQFVTYYgo5QL4LXF06T9XKHXij
         A7VNkObM8ZE7lS85qlDq9Gq1gCHiQMWext1JLoXHpzGk4ITq+5MQaYohVGl+Zan81ctN
         MZuTe15FwcXy7Vx9Qm4ZXXR4pyDRp21B+pA1pCMtZjoDykNk0gOQsk3HRqyAxqAhmi3o
         mhYWUaYom0q81ewHlZVsHbs56PDlwMgwVKRLqRm979mgMlq44iUwEtrbu+LqHwSIBMA4
         CTVDunbvX6PLKR3cuxJWd78fqv2IVrdWhw+/8StoCbM8oh7/hhNTomEBekQGAsRMBGE9
         QFrA==
X-Forwarded-Encrypted: i=1; AJvYcCVrn4esVVn02i3S5Ox4/7MElZYxD6b0YHs3nsmFdygFmyiBi3Cjv/FYWgYki4jrBcnUscjIfDgO@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6+92bZWU1HfJvc14f4ii4U6M2ZwZa52OXdeYG1pB8ZDnf6Mu
	AYhi8YbW25o/oWXl/fqRCIivamXI+2ZCjfYrI85mAOqJBAz/57az8/CVHuBCdec=
X-Gm-Gg: ASbGnct5sL+HCAsY1QfoNk9Wk9LuaBwEMM82byBQWQ90ZhBYjJEIXF4NvlQkF7DaQoi
	+vN9a822kd3bAQaQnv9sZWoZEgfFbC+/KN67aQE8C4NUq6uv4hucdHqQgtAgaclEU8c7JSOnKrQ
	arBGDWQ11WTF2nsHNIS9CacrfgqLzGN46CkZWlzCaax0YjynFYmcOJFs3wUInW3WUugOfxdCjic
	dcwcxbl31cNKW6P7v3kufZ/jArBCuZb3FjhUiDCrS4KcWHtI0Z6a1YkZrkuLPcM
X-Google-Smtp-Source: AGHT+IFHzrzntAhwZIjd/yc/QVtZxcJtWRq2cNvhXhZieIi32xjE4dR2rFr7xEc0wZQva/G+/Hck9g==
X-Received: by 2002:a17:907:7208:b0:aa5:43c4:da78 with SMTP id a640c23a62f3a-aac33685dfemr503281866b.51.1734766094208;
        Fri, 20 Dec 2024 23:28:14 -0800 (PST)
Received: from localhost (109-81-88-1.rct.o2.cz. [109.81.88.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe46b3sm252247466b.99.2024.12.20.23.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 23:28:13 -0800 (PST)
Date: Sat, 21 Dec 2024 08:28:13 +0100
From: Michal Hocko <mhocko@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org,
	yosryahmed@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, davidf@vimeo.com,
	vbabka@suse.cz, handai.szj@taobao.com, rientjes@google.com,
	kamezawa.hiroyu@jp.fujitsu.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v2] memcg: fix soft lockup in the OOM process
Message-ID: <Z2ZuDTYu3PwV1JmT@tiehlicka>
References: <20241220103123.3677988-1-chenridong@huaweicloud.com>
 <20241220144734.05d62ef983fa92e96e29470d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220144734.05d62ef983fa92e96e29470d@linux-foundation.org>

On Fri 20-12-24 14:47:34, Andrew Morton wrote:
> On Fri, 20 Dec 2024 10:31:23 +0000 Chen Ridong <chenridong@huaweicloud.com> wrote:
> 
> > From: Chen Ridong <chenridong@huawei.com>
> > 
> > A soft lockup issue was found in the product with about 56,000 tasks were
> > in the OOM cgroup, it was traversing them when the soft lockup was
> > triggered.
> > 
> > ...
> >
> > This is because thousands of processes are in the OOM cgroup, it takes a
> > long time to traverse all of them. As a result, this lead to soft lockup
> > in the OOM process.
> > 
> > To fix this issue, call 'cond_resched' in the 'mem_cgroup_scan_tasks'
> > function per 1000 iterations. For global OOM, call
> > 'touch_softlockup_watchdog' per 1000 iterations to avoid this issue.
> > 
> > ...
> >
> > --- a/include/linux/oom.h
> > +++ b/include/linux/oom.h
> > @@ -14,6 +14,13 @@ struct notifier_block;
> >  struct mem_cgroup;
> >  struct task_struct;
> >  
> > +/* When it traverses for long time,  to prevent softlockup, call
> > + * cond_resched/touch_softlockup_watchdog very 1000 iterations.
> > + * The 1000 value  is not exactly right, it's used to mitigate the overhead
> > + * of cond_resched/touch_softlockup_watchdog.
> > + */
> > +#define SOFTLOCKUP_PREVENTION_LIMIT 1000
> 
> If this is to have potentially kernel-wide scope, its name should
> identify which subsystem it belongs to.  Maybe OOM_KILL_RESCHED or
> something.
> 
> But I'm not sure that this really needs to exist.  Are the two usage
> sites particularly related?

Yes, I do not think this needs to pretend to be a more generic mechanism
to prevent soft lockups. The number of iterations highly depends on the
operation itself.

> 
> >  enum oom_constraint {
> >  	CONSTRAINT_NONE,
> >  	CONSTRAINT_CPUSET,
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 5c373d275e7a..f4c12d6e7b37 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1161,6 +1161,7 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
> >  {
> >  	struct mem_cgroup *iter;
> >  	int ret = 0;
> > +	int i = 0;
> >  
> >  	BUG_ON(mem_cgroup_is_root(memcg));
> >  
> > @@ -1169,8 +1170,11 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
> >  		struct task_struct *task;
> >  
> >  		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
> > -		while (!ret && (task = css_task_iter_next(&it)))
> > +		while (!ret && (task = css_task_iter_next(&it))) {
> >  			ret = fn(task, arg);
> > +			if (++i % SOFTLOCKUP_PREVENTION_LIMIT)
> 
> And a modulus operation is somewhat expensive.

This is a cold path used during OOM. While we can make it more optimal I
doubt it matters in practice so we should aim at readbility. I do not
mind either way, I just wanted to note that this is not performance
sensitive.

> 
> Perhaps a simple
> 
> 		/* Avoid potential softlockup warning */
> 		if ((++i & 1023) == 0)
> 
> at both sites will suffice.  Opinions might vary...
> 

-- 
Michal Hocko
SUSE Labs

