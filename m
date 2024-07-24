Return-Path: <cgroups+bounces-3880-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D7593B0B3
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 13:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720031C21289
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 11:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BA7156F28;
	Wed, 24 Jul 2024 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="NGiOWrAu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC315575F
	for <cgroups@vger.kernel.org>; Wed, 24 Jul 2024 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821754; cv=none; b=mcMA8w56HQHuvTfcr6neLzcNxdL2GrdkYMuhLecZSTTgqqgXFyT+Ll+FA0+w050GNj2NxCqhr6JllJBp4HsdmThpiUdqYR9k1dThE1mHX5Pa5FPmm9IPE2JR/YKwJalFleS7rQyFaN8pu10ZpCCzFRJhaREVco1lCfA7UXpBlo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821754; c=relaxed/simple;
	bh=q5BNZZnYXCfz5BQs4aahSBIwit5DV28WbPMtKTqD8JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQwx9YcNGE+1Xk6yObZhSKlhTBtZp96sYIPGHONXkZNPeJbZsrdqtFAg8dvBoiOQyvgXcRww9IJoKIqL3Lrm/0MURtrO8P65+CimxwrI+4sG9JrNJ+ecv4H7WRBC4NAm/zTg2TJ04Ye0Hzjn5+DoGv5/SO7dFqsRD0PE4SyzGa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=NGiOWrAu; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79f1b569ab7so308064385a.3
        for <cgroups@vger.kernel.org>; Wed, 24 Jul 2024 04:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1721821751; x=1722426551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2AZJKrk8iITWmBZL5VKywEjtBZAHwrNAU5Vz8WqNcz8=;
        b=NGiOWrAuyPKKBkVypFAkC8EbtbMdPeKi+kyPu6ibaQgF3oJEtIW4rMEEayeqj8QGVH
         WKiCxiZFwo90fsVrp629GvKXhbDsDRkCQfMftZ064sRcrMu1gmNsKjGR8eqEHssxu5xE
         yU/lc19SOTbXixogxf8AvtvEptODA35uK5fPcJsMslfHAT9i3OVIRz5FlBf7wDTqBiZT
         1rE/1UiPaCrGDhW1/gJXK/4D2Y31SI2M/2c+jP9Ds+LnKYEDOZtt5eQ325J8SYPjOV8V
         vrnORsc7sTBrw7PChCvkDQwd1GFYxCguq3oyVbroFwGhAYH4qIAB7oO3gtBQSVnMggDr
         4gIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721821751; x=1722426551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AZJKrk8iITWmBZL5VKywEjtBZAHwrNAU5Vz8WqNcz8=;
        b=QR+R+gSoXKDjsRxihXxdeUuDc3XirhbuxtjPyUPbaltSMILfnZ3YP6LTJBuWjSDSzV
         ofn6HDnZpYa6CDjTNQYYf98rNPA0TZBWHEja3ZJMsh/Y610BhcElXEs6sVucOolducQy
         Imff9FCWSeUXYNLryTpI26aGUubQfI7wvqqgPZEJG1mSacQMoJjZKmoqAR5QqonRyUbF
         EEaZ8N4W5GzkbD9bVd8XsFp5wCwc4G91R8Ivl+psZrCB+Fkxz8qakKVckpyijsnXLdxR
         wPG2l9t6nOZhc3svuFy48O35oZraGyUkgMrh4aaqUM99suCVFF3s19z53lSyA/ACp36i
         cWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzxYJHShtkqwQj3K+Ii1dxk/aZr3ve5MqQsUD7Pw1rDL9TpYFjgfwU8R/bXWWJbc8dEl/LMK0vpEH55wvexp+uxN9ekN/DPw==
X-Gm-Message-State: AOJu0YyJ5Xparm+2Qs3lrEeHSOovAKjd9ojR6H+7qj/9v1cucrf+ECMI
	uK+syOc3BfXHIcxKclIwAFBQN2p4fVwBhUlmRqIU66I8mY+bpXO3xdX5+lO/Jfs=
X-Google-Smtp-Source: AGHT+IH+ncWONYNFlORvxZR9kiEz5v28cZwt8KEfLHZR4owEBgNh00LBs1VgQWphxGekAbR+pUmsXg==
X-Received: by 2002:a05:620a:4548:b0:79f:8a7:eb87 with SMTP id af79cd13be357-7a1a1344844mr1567340085a.42.1721821750783;
        Wed, 24 Jul 2024 04:49:10 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19907a6b2sm571074685a.101.2024.07.24.04.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 04:49:10 -0700 (PDT)
Date: Wed, 24 Jul 2024 07:49:05 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Waiman Long <longman@redhat.com>
Cc: David Finkel <davidf@vimeo.com>, Muchun Song <muchun.song@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <20240724114905.GB389003@cmpxchg.org>
References: <20240723233149.3226636-1-davidf@vimeo.com>
 <20240723233149.3226636-2-davidf@vimeo.com>
 <22a95c76-4e9e-482e-b95d-cb0f01971d98@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a95c76-4e9e-482e-b95d-cb0f01971d98@redhat.com>

On Tue, Jul 23, 2024 at 09:55:19PM -0400, Waiman Long wrote:
> Could you use the "-v <n>" option of git-format-patch to add a version 
> number to the patch title? Without that, it can be confusing as to 
> whether the patch is new or a resend of the previous one.

+1

> > @@ -775,6 +775,11 @@ struct cgroup_subsys {
> >   
> >   extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
> >   
> > +struct cgroup_of_peak {
> > +	long			value;
> > +	struct list_head	list;
> > +};
> The name "cgroup_of_peak" is kind of confusing. Maybe local_peak?

It's the peak associated with an 'of' (which is a known concept in
cgroup code), and it pairs up nicely with of_peak(). I'd prefer
keeping that over local_peak.

> > @@ -26,6 +26,7 @@ struct page_counter {
> >   	atomic_long_t children_low_usage;
> >   
> >   	unsigned long watermark;
> > +	unsigned long local_watermark; /* track min of fd-local resets */
> track "min"? I thought it is used to track local maximum after a reset.

Yeah, the comment doesn't sound quite right.

However, I think we'd be hard-pressed to explain correctly and
comprehensively what this thing does in <40 characters.

I'd just remove the comment tbh.

> > @@ -78,7 +79,10 @@ int page_counter_memparse(const char *buf, const char *max,
> >   
> >   static inline void page_counter_reset_watermark(struct page_counter *counter)
> >   {
> > -	counter->watermark = page_counter_read(counter);
> > +	unsigned long usage = page_counter_read(counter);
> > +
> > +	counter->watermark = usage;
> > +	counter->local_watermark = usage;
> >   }
> >   
> 
> Could you set the local_watermark first before setting watermark? There 
> is a very small time window that the invariant "local_watermark <= 
> watermark" is not true.

Does it matter? Only cgroup1 supports global resets; only cgroup2
supports local peaks watching. This doesn't add anything to the race
that already exists between reset and global watermark update on cg1.

> > @@ -3950,12 +3955,90 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
> >   	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
> >   }
> >   
> > -static u64 memory_peak_read(struct cgroup_subsys_state *css,
> > -			    struct cftype *cft)
> > +static int peak_show(struct seq_file *sf, void *v, struct page_counter *pc)
> >   {
> > -	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> > +	struct cgroup_of_peak *ofp = of_peak(sf->private);
> > +	s64 fd_peak = ofp->value, peak;
> > +
> > +	/* User wants global or local peak? */
> > +	if (fd_peak == -1)
> > +		peak = pc->watermark;
> > +	else
> > +		peak = max(fd_peak, (s64)pc->local_watermark);
> Should you save the local_watermark value into ofp->value if 
> local_watermark is bigger? This will ensure that each successive read of 
> the fd is monotonically increasing. Otherwise the value may go up or 
> down if there are multiple resets in between.

The reset saves local_watermark into ofp->value if it's bigger..?

I do see another problem, though. The compiler might issue multiple
reads to ofp->value in arbitrary order. We could print max(-1, ...)
which is nonsense. Saving ofp->value into a local variable is the
right idea, but the compiler might still issue two reads anyway. It
needs a READ_ONCE() to force a single read.

I'd use unsigned long for fd_peak. This way the "specialness" is on
the -1UL comparison. The max() must be between two positive numbers,
so the (s64) there is confusing.

