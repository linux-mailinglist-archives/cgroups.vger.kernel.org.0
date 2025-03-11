Return-Path: <cgroups+bounces-6958-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E0BA5BFE2
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 13:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF0E7A30C8
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 11:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3E32561B3;
	Tue, 11 Mar 2025 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqTwGj9C"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85E254875
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694390; cv=none; b=TzR30dONwQAEw/s6WGickHFBtqSmyycwlDcefbBKSTJybjZMK3B2IGDQ2QzZ4/zAX6q4vcKXRDBQNldGk9D1H+G0dHB9bIqjg7XiLp7XfwhdDa1d7F1zyGLkedW+KrKdlv/QHOLcXDJtVj3sy0OhOTF32dyN1sgMT5DpIFvBdR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694390; c=relaxed/simple;
	bh=6ik8CDdyssom/lcu/O8RGgc/PpkhidUmPdJmCaGldO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uw5O6irCCBep4pnDOUWtITNkC95UgJJVTemWibMzBy4qGQc5p+kpfem6d0fRbxS8d2j1pV6FA3AJ21EgnTEOLnAzUjglba+zQt87x0uC4ANi5N5Qi9xUtlFoc/wYTagld+awMyCxbd8A9ztir/PNJBGifDYtWE8fs8f2R8lCIiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqTwGj9C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741694386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDKIujl/GD2HW4RyQYl/pH+0c9rxOzqbtce1pc+BO6M=;
	b=aqTwGj9CHkVFVn3DEBlCkxhlU06W8g0emzKte2tBn2ihXl5YSI8FcpHEs5OrrYf7pwYmPw
	i+af9rTlUQd+klYkOLgWXQdiuMUZbwxkNzPLF8rQjBmkwmiZbUZspIq5lmyWWFN9LLcNDT
	mJcwqwhLdI1y7HzRkX+heto3qjrWdDg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-ABg_znQKNjG4czENfmmyfg-1; Tue, 11 Mar 2025 07:59:45 -0400
X-MC-Unique: ABg_znQKNjG4czENfmmyfg-1
X-Mimecast-MFC-AGG-ID: ABg_znQKNjG4czENfmmyfg_1741694384
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso25541625e9.2
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 04:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694384; x=1742299184;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDKIujl/GD2HW4RyQYl/pH+0c9rxOzqbtce1pc+BO6M=;
        b=ki5sGmua923nkGmuM6H0hdDY6PkJ0Li/scibr8Ttj1+uH85jBm9xp7yRzg1V0u6A0q
         tOtBeEifU54whRbszZlaflPM/gqsf9iNkNBBrHtUmpDiXUq7pI4P8I+/feuA5HAPht/S
         byJxJS0gH5b5B9/Mdu3z4XtpGBJKGY1HVw+i9MmLI1tPZC67cEpiiGycRLbQxLlvDtyd
         xBmaLIfr48oteWwsI85xCeNJSQVTcH5qvzZ2mt4z6AxxEgIDnoH9V2Rb7IshATWRGIbz
         U1xQwkx8Vnc2R2ApY/48sdA2iPZoHbGbpyq4GIGz7uuNa0iIpXTZyi42J9COSKP+wFkn
         Skbw==
X-Forwarded-Encrypted: i=1; AJvYcCWKXH9BjWdGdvB5PRgKswtWQF8eT5qwaT7c/aJdSWY5U/umeRmjc6SizG5o+3OdK1ZMBxGrAD2S@vger.kernel.org
X-Gm-Message-State: AOJu0YyEoEnScq8Uy0yjtqdIM94Q5InyvUOkc9UDHfOw4naX3HiJGzxn
	P6G+uBy2uXjVF5h+TLwHwCF9SJGd2DyF/W+bAxpfYO6JmJ1As0Hd4PwIHWBSKS75C3TFbD7ZUln
	Pkj5tkkOFK8gv8x7R1iuxrzeJ2P49tak+3cQwnrZh7PBNx77Mgu2h90Y=
X-Gm-Gg: ASbGncvUrzGBCmR/SGEB3ZE1DiRea4NbjSUgbg9p8XHZ6AMeimHbkZ8RRfoh0RajuwO
	fcWFfVvzd4OKJ9bNZGi61RrgP8aNTkjR51+N0ZM/SxV260H6jDLc6fhgPG8mNdqhZayvjXOUtVa
	vlrMARliiAeROb8cv/SxYBwtZijPcieG22/LuAzQjubI/SpyOXQPEg2uWd6y16stCTKDjkV7ahH
	Y5A10fXdl/CiI/yOySB3uF93pLkxs+N8XVqElN6ew+3EC63pB4X6o2OZDNsLzSTIcfsCgtxKV5r
	Srngbh8D8v25yH0q3AevPU9lwm2Zc1IwTwIkCZFZlTI=
X-Received: by 2002:a05:600c:4f0c:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-43ceeeeb9e3mr86667245e9.20.1741694384268;
        Tue, 11 Mar 2025 04:59:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO9dgeAbIUcM48A8qtpiJ49dyz1L2I4mkXKwM7z476ZguqAw6Rk7o/AfXg3QYfwBdjPJvv1w==
X-Received: by 2002:a05:600c:4f0c:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-43ceeeeb9e3mr86666545e9.20.1741694383075;
        Tue, 11 Mar 2025 04:59:43 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352e29sm206132935e9.32.2025.03.11.04.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 04:59:42 -0700 (PDT)
Date: Tue, 11 Mar 2025 12:59:39 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
Message-ID: <Z9Alq55RpuFqWT--@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
 <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
 <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
 <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>

On 10/03/25 20:16, Waiman Long wrote:
> On 3/10/25 3:18 PM, Waiman Long wrote:
> > 
> > On 3/10/25 2:54 PM, Dietmar Eggemann wrote:
> > > On 10/03/2025 10:37, Juri Lelli wrote:
> > > > Rebuilding of root domains accounting information (total_bw) is
> > > > currently broken on some cases, e.g. suspend/resume on aarch64. Problem
> > > Nit: Couldn't spot any arch dependency here. I guess it was just tested
> > > on Arm64 platforms so far.
> > > 
> > > [...]
> > > 
> > > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > > index 44093339761c..363ad268a25b 100644
> > > > --- a/kernel/sched/topology.c
> > > > +++ b/kernel/sched/topology.c
> > > > @@ -2791,6 +2791,7 @@ void partition_sched_domains_locked(int
> > > > ndoms_new, cpumask_var_t doms_new[],
> > > >       ndoms_cur = ndoms_new;
> > > >         update_sched_domain_debugfs();
> > > > +    dl_rebuild_rd_accounting();
> > > Won't dl_rebuild_rd_accounting()'s lockdep_assert_held(&cpuset_mutex)
> > > barf when called via cpuhp's:
> > > 
> > > sched_cpu_deactivate()
> > > 
> > >    cpuset_cpu_inactive()
> > > 
> > >      partition_sched_domains()
> > > 
> > >        partition_sched_domains_locked()
> > > 
> > >          dl_rebuild_rd_accounting()
> > > 
> > > ?

Good catch. Guess I didn't notice while testing with LOCKDEP as I was
never able to hit this call path on my systems.

> > Right. If cpuhp_tasks_frozen is true, partition_sched_domains() will be
> > called without holding cpuset mutex.
> > 
> > Well, I think we will need an additional wrapper in cpuset.c that
> > acquires the cpuset_mutex first before calling partition_sched_domains()
> > and use the new wrapper in these cases.
> 
> Actually, partition_sched_domains() is called with the special arguments (1,
> NULL, NULL) to reset the domain to a single one. So perhaps something like
> the following will be enough to avoid this problem.

I think this would work, as we will still rebuild the accounting after
last CPU comes back from suspend. The thing I am still not sure about is
what we want to do in case we have DEADLINE tasks around, since with
this I belive we would be ignoring them and let suspend proceed.


