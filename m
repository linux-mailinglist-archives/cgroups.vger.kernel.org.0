Return-Path: <cgroups+bounces-5961-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7829F5FBA
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 08:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1719A16748D
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 07:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D331586DB;
	Wed, 18 Dec 2024 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z6OyPX/X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4221157472
	for <cgroups@vger.kernel.org>; Wed, 18 Dec 2024 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734508587; cv=none; b=hlJsc5YBV2kPWqagXC/RoXdQMWr4IOpUQsWWPgySsxpd+HeNByTKVHKkN0THcFQyn3EpGoucaLbXktULmSwcIwdqLEONCpkldPkP55yEPs9fA1DHidAblJDCZrXHn2hZnoUcfF3NYRnPzedrzIZQFKr0j9WM1e8Hmwo6uW1DgK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734508587; c=relaxed/simple;
	bh=cjl0Cdu1nU64p1FBadrj6cML7s4f100BVHDG+dqkhvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MycEWa56B1mr4oBfjPj9TFIK9TaLvZmgjr0GI9zAwf8qVseLDViVMCU97jq5X6vpZcWFTwPZ/FABtDqQGdYhfLIVWNf8w+0KvACTR8jbhuuUmHLejoz/j50+bYkFPFTpxfUWjR43ESJWUvWsI9XbTHvgBAnCFcX1WIBPmgPygsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z6OyPX/X; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso966180366b.1
        for <cgroups@vger.kernel.org>; Tue, 17 Dec 2024 23:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734508583; x=1735113383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQN0wm71xAkj0p1Q/NdDLgt+KxZdFC6f+ofVO1dsHQo=;
        b=Z6OyPX/X228/2LtFOFEz3yj3mbOTnRdYG+yclJq9uAPSz56wcpprB6YupxGu70nSXW
         AkI/IeLYEN4bHfoacQhPnPHEG6xuTkhio1zyX3jR0KHzKgWD7CyTe07SI8umsfdNDTyQ
         3GRmMaiF4ka5bI/jyOhaXEwB2C5n4HbSpiL3wSjVNYqYjFVTsr283WI4g9XhGE0dui0r
         /t6YYNvLRm2iHjykXQyDaQGOyzo0fQZm9yiEHO2RzlAmdhHIadv4vUZ3oVKdssrFJcZo
         QK3NhqiYmpo7b4KpeRfrK4sHWBi2WVIUU42G9EjXE8hOLvmuOHSR/ZbRo4IP20QV/o/m
         fypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734508583; x=1735113383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQN0wm71xAkj0p1Q/NdDLgt+KxZdFC6f+ofVO1dsHQo=;
        b=bZlepKCrlybYV9h+yCQqwSI7tUbxPqOFYbTldGgpZc+37GJEuNOpepsxGScHR2zaHg
         OcUJDAfzlTcV24bt7zbGu0AQrLIglI0O2Fb+14kUJxTDuZ1qeyDNyq9rg/DapKYbmuoN
         ghkHtvV3tNRmuHvbOw9aI3WgQhV+kj3iysVVmahx7nqRWMK7JE7YtoV1YMEa1avqj0Js
         L1/6chhMWzVHv1jclqz4ekVhjltN4Xcx39vlHJmRxKDQlKBt/Y2SdXaBh+0mlJH12FfZ
         5uQmwXcrfkYFW1v1rwR5iKuuq6lFThYPKhYz07MdXN8CiR2aEeMx914Y4h5p6BmVUvyw
         MJqw==
X-Forwarded-Encrypted: i=1; AJvYcCUgXnYoYmleciU0SRbr/0Kfs/Nigxy/Bk1JER2HU/kwLsiiHd2nquuDCfO2+IRhyIVvY/7vZweZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxjHHvk0mIDQgHTyP+AfGoAEumNh9y7TH2W6E70iFB6+uX4+gqR
	75CmW0cFryTHZh9T6lVWHUWhsN0UBCzJlq+WXTpfew1WHjrjWOTI40HPb+5VK60=
X-Gm-Gg: ASbGncsWieFXJTQpwVFT3H70NWWJS0zvT+bUavOswdcSLdiXAAKyPd/Oo8iciBt9pLd
	eX5twlr1jD0j/n5TKxPntscs3fuzmXad+rdVEqf7CPPcjv7m8giLHCYEBDkPlbC2aZbHQ3GZmKO
	U6LkM05XgqOsoLsIIKG2MuNctxbidzaLxdBPXW4PVdEwk0u4DLrI1BsA8C4huqmtQrqlMrDEGf6
	xz4Q4XjBh0sljCwj7q+8facyjEMZe5X2Miix1pChWVSNsKY0wUcyvE8cskFqKLnl80=
X-Google-Smtp-Source: AGHT+IG9nTkGC+v0t17oJVqtodNfTCv4+bFZC7mXaRTkfBgwdIfAwM2qjG+K5/ZQ0hmsRv1dwYdgbA==
X-Received: by 2002:a17:906:3145:b0:aa6:b4b3:5923 with SMTP id a640c23a62f3a-aabf47baa14mr132241166b.33.1734508583140;
        Tue, 17 Dec 2024 23:56:23 -0800 (PST)
Received: from localhost (109-81-89-64.rct.o2.cz. [109.81.89.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ae1127sm5304774a12.42.2024.12.17.23.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 23:56:22 -0800 (PST)
Date: Wed, 18 Dec 2024 08:56:21 +0100
From: Michal Hocko <mhocko@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	handai.szj@taobao.com, rientjes@google.com,
	kamezawa.hiroyu@jp.fujitsu.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v1] memcg: fix soft lockup in the OOM process
Message-ID: <Z2KAJZ4TKZnGxsOM@tiehlicka>
References: <20241217121828.3219752-1-chenridong@huaweicloud.com>
 <Z2F0ixNUW6kah1pQ@tiehlicka>
 <872c5042-01d6-4ff3-94bc-8df94e1e941c@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <872c5042-01d6-4ff3-94bc-8df94e1e941c@huaweicloud.com>

On Wed 18-12-24 15:44:34, Chen Ridong wrote:
> 
> 
> On 2024/12/17 20:54, Michal Hocko wrote:
> > On Tue 17-12-24 12:18:28, Chen Ridong wrote:
> > [...]
> >> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> >> index 1c485beb0b93..14260381cccc 100644
> >> --- a/mm/oom_kill.c
> >> +++ b/mm/oom_kill.c
> >> @@ -390,6 +390,7 @@ static int dump_task(struct task_struct *p, void *arg)
> >>  	if (!is_memcg_oom(oc) && !oom_cpuset_eligible(p, oc))
> >>  		return 0;
> >>  
> >> +	cond_resched();
> >>  	task = find_lock_task_mm(p);
> >>  	if (!task) {
> >>  		/*
> > 
> > This is called from RCU read lock for the global OOM killer path and I
> > do not think you can schedule there. I do not remember specifics of task
> > traversal for crgoup path but I guess that you might need to silence the
> > soft lockup detector instead or come up with a different iteration
> > scheme.
> 
> Thank you, Michal.
> 
> I made a mistake. I added cond_resched in the mem_cgroup_scan_tasks
> function below the fn, but after reconsideration, it may cause
> unnecessary scheduling for other callers of mem_cgroup_scan_tasks.
> Therefore, I moved it into the dump_task function. However, I missed the
> RCU lock from the global OOM.
> 
> I think we can use touch_nmi_watchdog in place of cond_resched, which
> can silence the soft lockup detector. Do you think that is acceptable?

It is certainly a way to go. Not the best one at that though. Maybe we
need different solution for the global and for the memcg OOMs. During
the global OOM we rarely care about latency as the whole system is
likely to struggle. Memcg ooms are much more likely. Having that many
tasks in a memcg certainly requires a further partitioning so if
configured properly the OOM latency shouldn't be visible much. But I am
wondering whether the cgroup task iteration could use cond_resched while
the global one would touch_nmi_watchdog for every N iterations. I might
be missing something but I do not see any locking required outside of
css_task_iter_*.
-- 
Michal Hocko
SUSE Labs

