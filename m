Return-Path: <cgroups+bounces-10581-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8BABC1023
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 12:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E6F74F448A
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 10:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1532B2D877C;
	Tue,  7 Oct 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWscjQ7K"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D28199FB0
	for <cgroups@vger.kernel.org>; Tue,  7 Oct 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832799; cv=none; b=Su0XA8edlf4IPZ0SfFMbLNOoQei53jeUiGM3bqP1NHB91QkcF3x8pgAEXGj30lXU/I/Se/VN4kHdZIkTFae6A5HXysXzE1He27VSoqLXdj2TadbR3ulC6KhoD0jvpGinZ2piwortWxYh+T5gw+gg8wO1BkAKWs1irOJvpHPjpQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832799; c=relaxed/simple;
	bh=gbzDoxYv0MvSzWpS8VUWjtEE8E1Rv9qpr+KsA+B9NqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPWqeazv3kzczdX3FminPqZm61o21miB0iiJ+AlYYaIezuTLzOktbrsGTEOQuEbm3IFY3XqgZWQABJ10CPZiC53hUt+focEaAp9DaaYeeo3nZO56YDkyDq/+eWPTL06D+sjjD3LFVqMl5rUr+4jThCsYhmmUHi7isc4O78aYnec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWscjQ7K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759832797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1oRiQ21RD56WeY2QvGAYtt4aZJ/FMR4+RaPEw0tI+EE=;
	b=SWscjQ7KQArvpzNf2mIfR+EQdUp5VHjsD7hk7x4nZ8XE4kLof/ppUNT5qMiMP+uC+JZ8mO
	XYP7823IJj7BMsXq0YhuKaJgnUQ+Kv5uEHJ0jTo/22rsaGOIDVEKL8uU0jiSpWWDN0uwjp
	UjwrM0y8pcGylDFvn86gPHizXASZljA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-hzDWz_O4NcalQvc9K8Mn0g-1; Tue, 07 Oct 2025 06:26:36 -0400
X-MC-Unique: hzDWz_O4NcalQvc9K8Mn0g-1
X-Mimecast-MFC-AGG-ID: hzDWz_O4NcalQvc9K8Mn0g_1759832795
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e473e577eso31763485e9.0
        for <cgroups@vger.kernel.org>; Tue, 07 Oct 2025 03:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759832795; x=1760437595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oRiQ21RD56WeY2QvGAYtt4aZJ/FMR4+RaPEw0tI+EE=;
        b=F4sRrGBj46UUbnBD/0ZxKnsnJ/nCgV2/i6QUmIu/XTLQHOykeuppuGV3cq9cwRMlOR
         Ydks5qA/xnuS2Jsj4/lBCOlFmpVRx4a2Gl9c6LW3J5pWCwfY46mPpj3tM5xQqOUoA2vB
         wlQwztwTqHKjoHYdHAQ5kSKJ41SeafnSjeEVdcbUk8tFr2q1j0JH4imtpw/egbD1E/cH
         9YCgJHQgWtj8sKxHYeDDxbMyr6BzvPl1rcy6fWw2ewZX91dtjPbn1cYdqvpBIgid27Cv
         75PV4/KL6JMUrJ4msMDFQOBYQI4PA+Edl8Z4RYhcaa3qJzQuDGxl0+XgltLek316RElj
         W+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVnzr7H253jkOQrbN3kPgo6Sor4SRDsbcilGWalMHetU1vh1TtDjRy/wjKkLDPJ6FftxfDgZUFI@vger.kernel.org
X-Gm-Message-State: AOJu0YwBtFQ5Gpik6rNrnlQPcWNW3TmlRKDB8vNq+M0l14EuikzEyoCK
	Kz6+69wRmnB2H4hb24nGRT/TlmyYwpi6zGDzYcdTTAOgddk0NbwUrRdeLszxzEnA6J/t5dMWYGO
	pZ6jDqj+/BwOYmgp0+A04+9cUb9ZYRqB0ZBqg4PT8ICbeyNRbs1I/33Sak/s=
X-Gm-Gg: ASbGncsA73m1aw9EUJddp29/BEMaSxp4bzwa+uYuGyFj/OQKp3iqloY8r/k/bMfW3yD
	fKFDYDSpu0gwx6PpscYHcwgHYy8jcW6ql+EeiPjQMdknd8S0qn0KcT0BgNpF6HwX1FBlGIZdlYI
	wQaA/ZfcwvcXKeImnUOFzKwlziSFb7qMTG30KmBHx3sJAE+aSs9YQIW8yIvCD2naXMsA8vhd8qG
	BejfITVQFPif8t835VrJoGptGjzVHvzImU2fW0xfl8/wyPTOGxJ41xuM4COuTVxxeF9rfzPAYtN
	n8Sja+uW/EtpKUEd76gIm0SyDbZiB4r0SnC5GgG/F+dRs0Bc4U7Og854gcHGT0RWVQJp2QkTWyT
	rEA==
X-Received: by 2002:a05:600c:548a:b0:46d:5189:3583 with SMTP id 5b1f17b1804b1-46e710b6231mr113836225e9.0.1759832794916;
        Tue, 07 Oct 2025 03:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpzj+r3TPYmWvbkiCjUYFasMEAw744DuMCfiYyedpCn/rb6hxGdhvFcG2MoVK74jPTRfi2Bg==
X-Received: by 2002:a05:600c:548a:b0:46d:5189:3583 with SMTP id 5b1f17b1804b1-46e710b6231mr113836035e9.0.1759832794472;
        Tue, 07 Oct 2025 03:26:34 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.135.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e674b6591sm265625615e9.4.2025.10.07.03.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 03:26:34 -0700 (PDT)
Date: Tue, 7 Oct 2025 12:26:31 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 1/3] sched: Detect per-class runqueue changes
Message-ID: <aOTq19a_OIONFmTs@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104652.630431579@infradead.org>
 <20251006105453.522934521@infradead.org>
 <aOTmg90J1Tdggm5z@jlelli-thinkpadt14gen4.remote.csb>
 <20251007101610.GD3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007101610.GD3245006@noisy.programming.kicks-ass.net>

On 07/10/25 12:16, Peter Zijlstra wrote:
> On Tue, Oct 07, 2025 at 12:08:03PM +0200, Juri Lelli wrote:
> > Hi Peter,
> > 
> > On 06/10/25 12:46, Peter Zijlstra wrote:
> > > Have enqueue/dequeue set a per-class bit in rq->queue_mask. This then
> > > enables easy tracking of which runqueues are modified over a
> > > lock-break.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > 
> > Nice.
> > 
> > > @@ -12887,8 +12888,8 @@ static int sched_balance_newidle(struct
> > >  	if (this_rq->cfs.h_nr_queued && !pulled_task)
> > >  		pulled_task = 1;
> > >  
> > > -	/* Is there a task of a high priority class? */
> > > -	if (this_rq->nr_running != this_rq->cfs.h_nr_queued)
> > > +	/* If a higher prio class was modified, restart the pick */
> > > +	if (this_rq->queue_mask & ~((fair_sched_class.queue_mask << 1)-1))
> > >  		pulled_task = -1;
> > 
> > Does this however want a self-documenting inline helper or macro to make
> > it even more clear? If this is always going to be the only caller maybe
> > not so much.
> 
> There's another one in patch 3. I suppose we can do that. Maybe
> something like:
> 
> static inline bool rq_modified_above(struct rq *rq, struct sched_class *class)
> {
> 	unsigned int mask = class->queue_mask;
> 	return rq->queue_mask & ~((mask << 1) - 1);
> }
> 
> This then writes the above like:
> 
> 	if (rq_modified_above(this_rq, &fair_sched_class))
> 

Yeah. Maybe also add a "check rq::queue_mask comment for additional
details" or something like this.

Thanks!
Juri


