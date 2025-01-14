Return-Path: <cgroups+bounces-6130-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AD1A10851
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 15:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D5A18826FF
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 14:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BEF84D0F;
	Tue, 14 Jan 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjrDuTEG"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B1B4644E
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863349; cv=none; b=u80hoeCfM/gL0Y8XuD4hZziKwmIsd13xXZlRtlYhtcFnq3M0o0Mc1BYkAVxB5HD7JHMLRNowsKINxNyYTxZ2EygsjV1MVPOHTZDWq5sF8ENOe7kvaG5bdTyGdbk4M0HPd9dqaZzcLeiUXzynC+tS8RQ5T0Pq6OGfy4nEV51CUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863349; c=relaxed/simple;
	bh=Wwaqhu3BS83hIwdm2jCNfJB9XVk8B4R5hwS28BYn3kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxji0nn5+ZHjWkTwTEVafvhlTt+Bl9Mc4OlwH9T5BFSWIIHXy4tEyAlw5nWEH+Dh6FY2ENGLPkspCy9I1A7XRiBmDkjCtlMDqaf9/EbKv4EVtCS29LPlAC9C9g+1c0ryhgW+4zXXfLlxnfgWzLeuAdW9MsITYS5qwM9+vDOJ87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjrDuTEG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736863346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZ2stY1d0j5tFV9hzbqgrrllt/9ieviJhnDGzEJo1Rw=;
	b=GjrDuTEGssOxudoUCfrVVb5my1d1toabPRQV2V8K8nxsp/K9qfyM2fqGPnL4aHLuHB5IGr
	nXOjsR0B+I0YlocOJBzQIEksEXjd/4gS2MkTKykrnz3xApEWpIM5+Si/0Y8Q6uEM8wHgp0
	VxJJhmvzdhTHTjVXSmGlrsBZz9q6uOg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-xzfZA8d_P5qwkqtJ63i8Kw-1; Tue, 14 Jan 2025 09:02:23 -0500
X-MC-Unique: xzfZA8d_P5qwkqtJ63i8Kw-1
X-Mimecast-MFC-AGG-ID: xzfZA8d_P5qwkqtJ63i8Kw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-436723db6c4so37833105e9.3
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 06:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736863342; x=1737468142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ2stY1d0j5tFV9hzbqgrrllt/9ieviJhnDGzEJo1Rw=;
        b=f/GLyfv3SAZ/+b4HcznKto+e8/g+3fUPiebLeuz6qbhXuCZWo7dlKms8lCwNIwy1DM
         PYrcZSwH8w2U7BCIyvqtFLu68CBL7SDfKm05taQkLRRyAV+jF94TtxbtIjDfsMP3sZes
         5fXzh0FOM1zhhMxSIzZCFm8y7QkH89V71QyNRxhtaKdNndfe0mH3Dc6eIMLV26/bh6UM
         K+GPT78S4NP59+SOBVtXunsrMrYtzw17c1Ae8VUIqkNTPfitFXxrgOizRnlX2PR1I/zp
         zU/kn/KxO6wQv3WagdNUZ2Hz0MFlB3NuzDBJcjXYyYmM8lTihdS5nzkeySWfWX8X7xDs
         xqxA==
X-Forwarded-Encrypted: i=1; AJvYcCWDXPdqS9TVnfGzA5gwlwU8gZHBRiiDBIJf96x82gGb9x6UKavMVAFwfuzVUPZUuF8Cz8SrNAP+@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJmVgLE6xpnjhzHUuMmeK03D5tZw+P9qj4FgwUw5d5RR8aaZB
	CBtqjtSp04V6QFST7giz9hiH8GJ93c82dbWEPLE7TZccbgeTmkFgr4iCG+d469EuzyNDvEafNss
	lD7ZlMPHCPplcRjdGKyWmSKPKVcplZVrLo2ZOmNN+h8T+HMZRIWsLQPM=
X-Gm-Gg: ASbGncscYAvEZQAXmJ5bpboFln+jJoXpISYFRbn/9ftCMO0B/Vkwn20IXwCZOW0HiXa
	aw8slsbKXjP994veM/pLd331q4n9AcPoZ0oHs4eIVcglDqxalY0/mMZw9gm0EXJUY+DPcOorJmc
	0RvTK/dGOg3HePKn+1DDa5sWLeiUDwxI8sIVijPUnwhN0K73mikmire4tZsdpE9Z7GFTtMq0zul
	pe+ZUnTNuYACBJXQlLQVNy7PFuaaNm+q59EF6LgpQLm/X9ebk1kgC5COX+diT0IkGvSZiLXKtR0
	wOueba2a1Q==
X-Received: by 2002:a05:600c:3152:b0:434:f9e1:5cf8 with SMTP id 5b1f17b1804b1-436e271d3a2mr232038245e9.31.1736863342137;
        Tue, 14 Jan 2025 06:02:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6SqwrvvdK2Vn+2bLJW+Tuv+cb4ueUK0LuboeZtC3lmAh3e45fHn6HxH0eXGu0MJCRfRdu2g==
X-Received: by 2002:a05:600c:3152:b0:434:f9e1:5cf8 with SMTP id 5b1f17b1804b1-436e271d3a2mr232037215e9.31.1736863341385;
        Tue, 14 Jan 2025 06:02:21 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.92.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e37d46sm175300585e9.25.2025.01.14.06.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:02:20 -0800 (PST)
Date: Tue, 14 Jan 2025 15:02:17 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
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
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
Message-ID: <Z4ZuaeGssJ-9RQA2@jlelli-thinkpadt14gen4.remote.csb>
References: <20241114142810.794657-1-juri.lelli@redhat.com>
 <ZzYhyOQh3OAsrPo9@jlelli-thinkpadt14gen4.remote.csb>
 <Zzc1DfPhbvqDDIJR@jlelli-thinkpadt14gen4.remote.csb>
 <ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com>
 <Z4FAhF5Nvx2N_Zu6@jlelli-thinkpadt14gen4.remote.csb>
 <5d7e5c02-00ee-4891-a8cf-09abe3e089e1@nvidia.com>
 <Z4TdofljoDdyq9Vb@jlelli-thinkpadt14gen4.remote.csb>
 <e9f527c0-4530-42ad-8cc9-cb04aa3d94b7@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9f527c0-4530-42ad-8cc9-cb04aa3d94b7@nvidia.com>

On 14/01/25 13:52, Jon Hunter wrote:
> 
> On 13/01/2025 09:32, Juri Lelli wrote:
> > On 10/01/25 18:40, Jon Hunter wrote:
> > 
> > ...
> > 
> > > With the above I see the following ...
> > > 
> > > [   53.919672] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4
> > > [   53.930608] dl_bw_manage: cpu=4 cap=2048 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3
> > > [   53.941601] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2
> > 
> > So far so good.
> > 
> > > [   53.952186] dl_bw_manage: cpu=2 cap=1024 fair_server_bw=52428 total_bw=576708 dl_bw_cpus=2
> > 
> > But, this above doesn't sound right.
> > 
> > > [   53.962938] dl_bw_manage: cpu=1 cap=0 fair_server_bw=52428 total_bw=576708 dl_bw_cpus=1
> > > [   53.971068] Error taking CPU1 down: -16
> > > [   53.974912] Non-boot CPUs are not disabled
> > 
> > What is the topology of your board?
> > 
> > Are you using any cpuset configuration for partitioning CPUs?
> 
> 
> I just noticed that by default we do boot this board with 'isolcpus=1-2'. I
> see that this is a deprecated cmdline argument now and I must admit I don't
> know the history of this for this specific board. It is quite old now.
> 
> Thierry, I am curious if you have this set for Tegra186 or not? Looks like
> our BSP (r35 based) sets this by default.
> 
> I did try removing this and that does appear to fix it.

OK, good.

> Juri, let me know your thoughts.

Thanks for the additional info. I guess I could now try to repro using
isolcpus at boot on systems I have access to (to possibly understand
what the underlying problem is).

Best,
Juri


