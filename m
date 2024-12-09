Return-Path: <cgroups+bounces-5785-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5479E989C
	for <lists+cgroups@lfdr.de>; Mon,  9 Dec 2024 15:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6C3161346
	for <lists+cgroups@lfdr.de>; Mon,  9 Dec 2024 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C561ACED7;
	Mon,  9 Dec 2024 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3e7UMIx"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C831798F
	for <cgroups@vger.kernel.org>; Mon,  9 Dec 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754016; cv=none; b=f+0kCCGUJJqftBz5MVaYsF/fv+EKZlbEucBH7XXp3+rrcBds+V72BlttlzT9BOEY4WvxIy6AUqbV9WgmFD0VKFfvXDE4A7XVl95hzsdVTcbm7JYoSMzUlu8fsGI2BtNvioAM2ZdscTldoZVDN0HZekaol9ZJraBTypr0rIItfrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754016; c=relaxed/simple;
	bh=5LxPzkwXbkWs8QADAY0HXIgv9Pxu1uooRAocU3GSwZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTc55jc0mm01Ml8VUfhEq23RgjkZyBUYhI8tUNlVVCVustmagBq+kP0ewXzvfVrHvkuFGkr0bJfe4Rmmrt0vAwcrhU4YRbsov2VJDlnauoydplmW2pqf0gaFRHvim0Jd/Qfg6AnlO5vo89yRHX0Ol36BvetUtjGwfVzr6z46JL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3e7UMIx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733754014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uUafJPITbFDpJxN3Yx+BE2RB7iQ7hbigXZ4vj14KZBU=;
	b=d3e7UMIxfABm2rtETcxR5qBAKD/s1ZldQ46Hvo0qthOD73GnlGlbihjWEXRt7DIJn5g781
	yKNN2AjjNetROuwsXZucjE7xelfKHWHm0YXfNMQPJeyqGWAUOx2rKXBjZGPHtT7a63K53W
	83svar6ZMdHIaBIOJxOW9DYun2Zsirc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-NYxfuHOzNSGKl9mokm4bHw-1; Mon, 09 Dec 2024 09:20:13 -0500
X-MC-Unique: NYxfuHOzNSGKl9mokm4bHw-1
X-Mimecast-MFC-AGG-ID: NYxfuHOzNSGKl9mokm4bHw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3862be3bfc9so1666743f8f.3
        for <cgroups@vger.kernel.org>; Mon, 09 Dec 2024 06:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733754012; x=1734358812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUafJPITbFDpJxN3Yx+BE2RB7iQ7hbigXZ4vj14KZBU=;
        b=uxAajxmrM/Sr6NoFIOOEuBXVIcGhN6EgAKaNxFpyMvOPwU8IgUo1J+lEeFXK78HV9e
         a5bzn1GdD39/kDqQdRaGPt1smaUtJhWqedTV3sg2Q86sACbrZx1ux/hQE/NDHUSBPLmw
         7N7q3s5WWrxqQLifyIoZlu+Kv797CYOAhdKbUACl1sSjblsKV1N65A90mzrjyYEN2SBu
         SoDq9CbwM+Ts+k9p7JuD/5VVu3dlznDdFJLyw4Ob2KpI+jbCFVpv5zn+2yWPDzQrf7/X
         ccACV1oqU+T7J0v1Jszur8cYHHyHM6LhLv+rLpfiGSxfj9BBtGolFT1pTCbA6uVbFoHc
         zo6w==
X-Forwarded-Encrypted: i=1; AJvYcCWa6eO3GGnsxZ7gIKoOhzrOzb54vrqJU2Pw76h+lp4xB3dKWr1wAu/C7ShzXBSmRh4+8sH9V4Ev@vger.kernel.org
X-Gm-Message-State: AOJu0YxMJPsD+pjeXXNPQbUsNlg0NgLLHbiiss3GkXWGgXotm0Ds/2Xj
	xTsqFITYVgGSpFXr8dyedds1GHvkhXkFNevNjDqy+rouCJFf46OSm0m/niwXszah2d1cP7A+2XK
	P35sekNuFeVba1gfFHglsLXhNLGshwFE6JKBl8Gfs9wZ8XQfTM+bKo3s=
X-Gm-Gg: ASbGnctACdz85yObZuEdMRl61/uoxeU5ucinRLGbm8Nc7KY6qx+45hzRO4ujbT38It6
	U6SQ5lfDMiiGIwYvLiMtnwtvML4VA6cj3vQt7XIKd4jqSu2JIW+Aw9NLa2tiRUbjjkEXjuiSN0N
	xzLlrjdxcGHjHiEBzDwrtUED5GA1VBEyXYofqT2Kvemuh8mRN1n3u1zZHdDzuKCMo2vKJJ5pleJ
	gCeNH1Lj6r2PMJDKOVaTJ5j2m+snJSBI4oDJI/rcivdeEHWUwjioyKQu15ynsGhQTQxIkg6kOmI
	DYJI9l0xpprJEmyI/izxy3MFyg7UHokY+w==
X-Received: by 2002:a5d:47aa:0:b0:385:e9ca:4e18 with SMTP id ffacd0b85a97d-3862b345322mr9501059f8f.1.1733754011614;
        Mon, 09 Dec 2024 06:20:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEimI6Ui0mKxeYiiQzQnI7rasXWcvol+mQTx49rmAZ0iGqXOJRujNGaWhnPX9VCfJ4Dtk3eDQ==
X-Received: by 2002:a5d:47aa:0:b0:385:e9ca:4e18 with SMTP id ffacd0b85a97d-3862b345322mr9501019f8f.1.1733754011212;
        Mon, 09 Dec 2024 06:20:11 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-2-102-14-117.as13285.net. [2.102.14.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f063357csm77489715e9.22.2024.12.09.06.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:20:10 -0800 (PST)
Date: Mon, 9 Dec 2024 14:20:08 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sched/deadline: Correctly account for allocated
 bandwidth during hotplug
Message-ID: <Z1b8mGctDusOZPA8@jlelli-thinkpadt14gen4.remote.csb>
References: <20241114142810.794657-1-juri.lelli@redhat.com>
 <20241114142810.794657-3-juri.lelli@redhat.com>
 <cb188000-f0e1-4b0a-9b5a-d725b754c353@stanley.mountain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb188000-f0e1-4b0a-9b5a-d725b754c353@stanley.mountain>

Hi,

On 06/12/24 13:43, Dan Carpenter wrote:
> On Thu, Nov 14, 2024 at 02:28:10PM +0000, Juri Lelli wrote:
> >  static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
> >  {
> > -	unsigned long flags;
> > +	unsigned long flags, cap;
> >  	struct dl_bw *dl_b;
> >  	bool overflow = 0;
> > +	u64 fair_server_bw = 0;
>         ^^^^^^^^^^^^^^^^^^
> This is a u64.
> 
> >  
> >  	rcu_read_lock_sched();
> >  	dl_b = dl_bw_of(cpu);
> >  	raw_spin_lock_irqsave(&dl_b->lock, flags);
> >  
> > -	if (req == dl_bw_req_free) {
> > +	cap = dl_bw_capacity(cpu);
> > +	switch (req) {
> > +	case dl_bw_req_free:
> >  		__dl_sub(dl_b, dl_bw, dl_bw_cpus(cpu));
> > -	} else {
> > -		unsigned long cap = dl_bw_capacity(cpu);
> > -
> > +		break;
> > +	case dl_bw_req_alloc:
> >  		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
> >  
> > -		if (req == dl_bw_req_alloc && !overflow) {
> > +		if (!overflow) {
> >  			/*
> >  			 * We reserve space in the destination
> >  			 * root_domain, as we can't fail after this point.
> > @@ -3501,6 +3503,34 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
> >  			 */
> >  			__dl_add(dl_b, dl_bw, dl_bw_cpus(cpu));
> >  		}
> > +		break;
> > +	case dl_bw_req_deactivate:
> > +		/*
> > +		 * cpu is going offline and NORMAL tasks will be moved away
> > +		 * from it. We can thus discount dl_server bandwidth
> > +		 * contribution as it won't need to be servicing tasks after
> > +		 * the cpu is off.
> > +		 */
> > +		if (cpu_rq(cpu)->fair_server.dl_server)
> > +			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
> > +
> > +		/*
> > +		 * Not much to check if no DEADLINE bandwidth is present.
> > +		 * dl_servers we can discount, as tasks will be moved out the
> > +		 * offlined CPUs anyway.
> > +		 */
> > +		if (dl_b->total_bw - fair_server_bw > 0) {
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Since this subtraction is unsigned the condition is equivalent to:
> 
>         if (dl_b->total_bw != fair_server_bw)
> 
> but it feels like maybe it was intended to be:
> 
>         if (dl_b->total_bw > fair_server_bw) {

I actually believe they are equivalent for this case, as if there is a
dl_server total_bw is either equal or bigger than fair_server_bw, so
checking for it to be different than fair_server_bw should still be OK
(even though confusing maybe).

Thanks,
Juri


