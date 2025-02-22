Return-Path: <cgroups+bounces-6648-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E88A40C41
	for <lists+cgroups@lfdr.de>; Sun, 23 Feb 2025 00:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC3C189D801
	for <lists+cgroups@lfdr.de>; Sun, 23 Feb 2025 00:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37967204C31;
	Sat, 22 Feb 2025 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="HMMaV2Ty"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D885204594
	for <cgroups@vger.kernel.org>; Sat, 22 Feb 2025 23:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740268789; cv=none; b=lM4d2LqG5BvPx+BkxAbLN1YU5Jb97UGbbXv3e6z+QpfMUNSRZQm2h1N5qyv9EOBYkSfySfLqDlrFSgQGLXiE1XbfXANKS2d28JhSnjDsVMYmDWO8QSPVoOw9cxlIE4NmhGfeeS74UbL6GKlxUJncDOSLm7pvH+r8Fm1FKO4i2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740268789; c=relaxed/simple;
	bh=BC1VikLvaQ+wmk7I7O5kqTkttd71b1FW4KIkZw3Br0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vt/SWKy5GxtA6KTeDu7qTRBKeeeQJlBZ7JfPkBoTp7Kns15ZdpqXpHozt456YzhediXQjXHHLOeQc76YQZ+Jhma9fPDJFrXiIk+j3DT1JlsXjtwZ7n8lGzraDaB6JbAWeXZ3HlyhMPR9mlGs/s6YJ+IFuuIb91MSahV5iRJlXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=HMMaV2Ty; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e050b1491eso7616233a12.0
        for <cgroups@vger.kernel.org>; Sat, 22 Feb 2025 15:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1740268785; x=1740873585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lu2LoNkT4EDP4h3CKy4CP8LgrHHyNd0iD27ycNO3cNY=;
        b=HMMaV2Tynj3BGowSvfj9cHuQoVqAX/HkWUxJOH1zJzPICzw+fYsk5FE2gDA8+fRDnL
         7fE5yb8roH+HqCw9DVVnqwxvBeHhldTN9xIxZBed2j/r0Jz0sKJblk+ersgetj7Qze3a
         4YNeiSn8CtZ1JM92TtHW7UPt6eISGPCqjITB7leBAq8I8yAHxwWvx3+I4cU3vju75b77
         Bw5weGObOTNk5aC6kYtV2psXM3aC3pVXtia3Uq4RboDgGSeQVswCxAESKKAhiaUJTi1n
         n/CKj8G1ubmFZ8URoI4I9nEeY8XXu8xtLCYjRSmIdkXfEnRpP+dybVt9Bu+o4GJyoWjj
         /isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740268785; x=1740873585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu2LoNkT4EDP4h3CKy4CP8LgrHHyNd0iD27ycNO3cNY=;
        b=LIRkRa3ukdCA06OXPdIxC/2E3gLDdFRN3y5neyNDKE3NfFJA3STCPmL/aTSGrKFVQv
         MY8quupOrhA/aeRURk5CURWlPyll6HnmI39eTapJNXQBCfsAC99vVDOwCbZjDBTXy1BQ
         9G5VUWf6V17Istn/aJ+4pAHL2VovJsac5gTP6H8P7G5l2ufJhAqIwZTcvT/rwWVUfoSP
         WAjWruzmoqBPfajD2Us9+WFKVD3KZx6UH9vCS0IhdtJqDwaovE+2R+5ADdpcLEpRPALK
         yghIDpPbp/jN1y+ZTh3Em8oy+fQc1InUZr5wtM4pNJ1nkIZEhqBRajhZbFYYjDchEhuR
         eo4w==
X-Forwarded-Encrypted: i=1; AJvYcCVrSN7SJdWWGCf/ywve7WV2cD7sp6SUL4FdR68ogyJdAt4oifKdPIVCB8N1IKWDmpmWkxI/9mar@vger.kernel.org
X-Gm-Message-State: AOJu0Yzval5/+tjKCY6DffLkCQuxYdReENdXhFBeI12qXNyQvihC2q8X
	vi3tALEWV18E1EsAQQ3NFmgN3nC2WNDEgntFi0/qCWeCwzE38SXxdur6ydv2ZVY=
X-Gm-Gg: ASbGncvHpD4OWRszmuT0xOVWBI3N9H/iAoWhcYPbBeNprV7e40Q+0WocDIhXsr8I9fq
	58sR1z2cCI7K6g2z5lzDboe8dLt+AUCG9yExc0E2nt0cEec5Pn3TGjRPi4mh+xyH/DDdsAdm79x
	DkdTflS3Qqr6H5qeuGzgQRgoUHrUKsZjXk0j/zvgsOUgnpChfgnGCgocsQ3HfAVAwrqDDUy7nKS
	JkRcnlgW2ycCAHTTyylGJH8BiJzMmjDmY4ALqIyaW49sUHR7Par7GloahGy0TQENAj82Gbd+wo5
	HmQQU8ggTdEjkGe/z8/I
X-Google-Smtp-Source: AGHT+IEwAuQGxMOVSUtusVjN0BopgUdnw2fnKA4dzOqvUMZKdjWs0Zk6qVmFxkFPYOp6ZdBA7ynXRg==
X-Received: by 2002:a17:907:7fa7:b0:abb:d334:73e7 with SMTP id a640c23a62f3a-abc0ae910a4mr749202366b.14.1740268785510;
        Sat, 22 Feb 2025 15:59:45 -0800 (PST)
Received: from airbuntu ([46.186.201.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8209a2cbsm1458407366b.133.2025.02.22.15.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 15:59:45 -0800 (PST)
Date: Sat, 22 Feb 2025 23:59:36 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>,
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
Message-ID: <20250222235936.jmyrfacutheqt5a2@airbuntu>
References: <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
 <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <285a43db-c36d-400e-8041-0566f089a482@arm.com>
 <Z62PPUOY5DClYo1A@jlelli-thinkpadt14gen4.remote.csb>
 <20250216163340.ttwddti5pzuynsj5@airbuntu>
 <Z7NNHmGgrEF666W_@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7NNHmGgrEF666W_@jlelli-thinkpadt14gen4.remote.csb>

On 02/17/25 15:52, Juri Lelli wrote:
> On 16/02/25 16:33, Qais Yousef wrote:
> > On 02/13/25 07:20, Juri Lelli wrote:
> > > On 12/02/25 19:22, Dietmar Eggemann wrote:
> > > > On 11/02/2025 11:42, Juri Lelli wrote:
> > > 
> > > ...
> > > 
> > > > > What about we actually ignore them consistently? We already do that for
> > > > > admission control, so maybe we can do that when rebuilding domains as
> > > > > well (until we find maybe a better way to deal with them).
> > > > > 
> > > > > Does the following make any difference?
> > > > 
> > > > It at least seems to solve the issue. And like you mentioned on irc, we
> > > > don't know the bw req of sugov anyway.
> > > > 
> > > > So with this change we start with 'dl_bw->total_bw = 0' even w/ sugov tasks.
> > > > 
> > > > dl_rq[0]:
> > > >   .dl_nr_running                 : 0
> > > >   .dl_bw->bw                     : 996147
> > > >   .dl_bw->total_bw               : 0       <-- !
> > > > 
> > > > IMHO, people who want to run serious DL can always check whether there
> > > > are already these infrastructural DL tasks or even avoid schedutil.
> > > 
> > > It definitely not ideal and admittedly gross, but not worse than what we
> > > are doing already considering we ignore sugovs at AC and the current
> > > bandwidth allocation its there only to help with PI. So, duck tape. :/
> > > 
> > > A more proper way to work with this would entail coming up with sensible
> > > bandwidth allocation for sugovs, but that's most probably hardware
> > > specific, so I am not sure how we can make that general enough.
> > 
> > I haven't been following the problem closely, but one thing I was considering
> > and I don't know if it makes sense to you and could help with this problem too.
> > Shall we lump sugov with stopper class or create a new sched_class (seems
> > unnecessary, I think stopper should do)? With the consolidate cpufreq update
> > patch I've been working on Vincent raised issues with potential new ctx switch
> > and to improve that I needed to look at improving sugov wakeup path. If we
> > decouple it from DL I think that might fix your problem here and could allow us
> > to special case it for other problems like the ones I faced more easily without
> > missing up with DL.
> > 
> > Has the time come to consider retire the simple solution of making sugov a fake
> > DL task?
> 
> Problem is that 'ideally' we would want to explicitly take sugovs into
> account when designing the system. We don't do that currently as a
> 'temporary solution' that seemed simpler than a proper approach (started
> wondering if it's indeed simpler). So, not sure if moving sugovs outside
> DL is something we want to do.

Okay I see. The issue though is that for a DL system with power management
features on that warrant to wake up a sugov thread to update the frequency is
sort of half broken by design. I don't see the benefit over using RT in this
case. But I appreciate I could be misguided. So take it easy on me if it is
obviously wrong understanding :) I know in Android usage of DL has been
difficult, but many systems ship with slow switch hardware.

How does DL handle the long softirqs from block and network layers by the way?
This has been in a practice a problem for RT tasks so they should be to DL.
sugov done in stopper should be handled similarly IMHO. I *think* it would be
simpler to masquerade sugov thread as irq pressure.

You can use the rate_limit_us as a potential guide for how much bandwidth sugov
needs if moving it to another class really doesn't make sense instead?

