Return-Path: <cgroups+bounces-8342-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A96AC309D
	for <lists+cgroups@lfdr.de>; Sat, 24 May 2025 19:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7770D3BCB1E
	for <lists+cgroups@lfdr.de>; Sat, 24 May 2025 17:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CBD17B506;
	Sat, 24 May 2025 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DJyxKc7m"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706802DCBE3
	for <cgroups@vger.kernel.org>; Sat, 24 May 2025 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748107975; cv=none; b=ju/B5rIgbJSqV5vaHcgVT4V5oxMmv/24Y3XG2LjI/Vu5ZmCokU5y0PeDTuBlolVjDosGwBZ0hdebEopHUlNb09+VVH7qiQeUcBdAT4jCyevnthdyS9WXHGbba+SKXOyXaDV224AfpDQfo6U+GuKOq00DfLUiEZzEXTJX8CS23/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748107975; c=relaxed/simple;
	bh=WROu/pu0ybtezcTtiIfVSav31rQxzPNSRZ+C+QZg8tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1vlwv4+5oZwRiMqkrozXfAp+oQel3gm88YxgOyuTC6IXqssm1A+jqmdVHgRvZIx0ggiU6qqJcQ1o3C/E/bbYMX8ynDGOqzII1QC8VfOvESvPhpApK+4+lg1p+UW+BodzEM2rrfrrb5k2lrqIRHQTqJT2PDfEorW5Z8TocJoAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DJyxKc7m; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCWjC39xMqo+b58J77GU/m11ovSM/aPrxdhujC78zvC9Q0hMQdtO0D4LhXo41iATy64i8okWg/ig26UYBjOm@vger.kernel.org, AJvYcCXP4e6n5CoELH3Dm7FKoGc2qi7L/egV/5/vdSMtvsaGgUOCc69SAhU7rhJmq16KEpT9WRF6zTjl@vger.kernel.org, AJvYcCXReQUYSAgG6UrWxEjqvc9kV/nCjgCGdyjYvrkmZkiG6u1noBA3mVD6n1yvYVsDVrVhajcMdAypmiAw@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748107960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WROu/pu0ybtezcTtiIfVSav31rQxzPNSRZ+C+QZg8tc=;
	b=DJyxKc7mlCCeK+zTphZNOmJBUOFtzUEu6bjlEnzHvuQ3c9lvj+w+UHJVXWYS2KasNOpUO9
	IM5GfJPDpw1PMAmyVnLSilvrFT5GPF+JxAdTVO3N4vOcFBiYi/X8QxRwbrVBlgT+PyQmS+
	XGyqMiJ5cOl3/ikSKFp7e+hRsIqPVRM=
X-Gm-Message-State: AOJu0YzHrs56pHOk78FVi4bb2aHLIpDo/UNQTmZhFCztRNWjNtiabRXJ
	gMBObbwm3SCGSzxgj3a6tXMNwfTDWt2d23nkTHf+oChHWbA5tCE2ucwcrXFk3P3q1TKvXsscPn6
	LeTeTvwKyoolqkhqbBJGrgtJ/YPOQBMA=
X-Google-Smtp-Source: AGHT+IHLfzVJ2UpaVUCWlm1zWAshulOa7vscD+okP1uymiyJvIt0gCpGOGxAHvcaNuNdCBxsLb/J5w4FXXuPCngwndM=
X-Received: by 2002:a67:e446:0:b0:4e4:3c3a:f163 with SMTP id
 ada2fe7eead31-4e43c3af25bmr1133636137.7.1748107953734; Sat, 24 May 2025
 10:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748002400.git.yu.c.chen@intel.com> <7ef90a88602ed536be46eba7152ed0d33bad5790.1748002400.git.yu.c.chen@intel.com>
 <cx4s4pnw5ymr4bxxmvrkhc457krq46eh6zamlr4ikp7tn3jsno@xzchjlnnawe5> <ad9f8af5-6bac-48c0-924b-498863370079@intel.com>
In-Reply-To: <ad9f8af5-6bac-48c0-924b-498863370079@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Sat, 24 May 2025 10:32:23 -0700
X-Gmail-Original-Message-ID: <CAGj-7pX9yFFEFuMPgXBL_gsWevX8MtUZix5qyUQxOqWGKcbFzA@mail.gmail.com>
X-Gm-Features: AX0GCFtAGKYvnyUctUx8VirEg3z97hG3ViBkmzEXKrnSY_iFkoXIYVHb96S8e1c
Message-ID: <CAGj-7pX9yFFEFuMPgXBL_gsWevX8MtUZix5qyUQxOqWGKcbFzA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] sched/numa: add statistics of numa balance task
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: peterz@infradead.org, akpm@linux-foundation.org, mkoutny@suse.com, 
	mingo@redhat.com, tj@kernel.org, hannes@cmpxchg.org, corbet@lwn.net, 
	mgorman@suse.de, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, tim.c.chen@intel.com, aubrey.li@intel.com, 
	libo.chen@oracle.com, kprateek.nayak@amd.com, vineethr@linux.ibm.com, 
	venkat88@linux.ibm.com, ayushjai@amd.com, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	yu.chen.surf@foxmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Sat, May 24, 2025 at 2:07=E2=80=AFAM Chen, Yu C <yu.c.chen@intel.com> wr=
ote:
>
> Hi Shakeel,
>
> On 5/24/2025 7:42 AM, Shakeel Butt wrote:
> > On Fri, May 23, 2025 at 08:51:15PM +0800, Chen Yu wrote:
> >> On systems with NUMA balancing enabled, it has been found
> >> that tracking task activities resulting from NUMA balancing
> >> is beneficial. NUMA balancing employs two mechanisms for task
> >> migration: one is to migrate a task to an idle CPU within its
> >> preferred node, and the other is to swap tasks located on
> >> different nodes when they are on each other's preferred nodes.
> >>
> >> The kernel already provides NUMA page migration statistics in
> >> /sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched. However,
> >> it lacks statistics regarding task migration and swapping.
> >> Therefore, relevant counts for task migration and swapping should
> >> be added.
> >>
> >> The following two new fields:
> >>
> >> numa_task_migrated
> >> numa_task_swapped
> >>
> >> will be shown in /sys/fs/cgroup/{GROUP}/memory.stat, /proc/{PID}/sched
> >> and /proc/vmstat
> >
> > Hmm these are scheduler events, how are these relevant to memory cgroup
> > or vmstat?
> > Any reason to not expose these in cpu.stat?
> >
>
> I understand that in theory they are scheduling activities.
> The reason for including these statistics here was mainly that
> I assumed there is a close relationship between page migration
> and task migration in Numa Balance. Specifically, task migration
> is triggered when page migration fails.
> Placing these statistics closer to the existing Numa Balance page
> statistics in /sys/fs/cgroup/{GROUP}/memory.stat and /proc/vmstat
> may help users query relevant data from a single file, avoiding
> the need to search through scattered files.
> Notably, these events are associated with a task=E2=80=99s working set
> (footprint) rather than pure CPU cycles IMO. I took a look at
> the cpu_cfs_stat_show() for cpu.stat, it seems that a lot of
> code is needed if we want to expose them in cpu.stat, while
> reusing existing interface of count_memcg_event_mm() is simpler.

Let me address two of your points first:

(1) cpu.stat currently contains cpu cycles stats. I don't see an issue
adding these new events in it as you can see memory.stat exposes stats
and events as well.

(2) You can still use count_memcg_event_mm() and related infra while
exposing the stats/events in cpu.stat.

Now your point on having related stats within a single interface is
more convincing. Let me ask you couple of simple questions:

I am not well versed with numa migration, can you expand a bit more on
these two events (numa_task_migrated & numa_task_swapped)? How are
these related to numa memory migration? You mentioned these events
happen on page migration failure, can you please give an end-to-end
flow/story of all these events happening on a timeline.

Beside that, do you think there might be some other scheduling events
(maybe unrelated to numa balancing) which might be suitable for
memory.stat? Basically I am trying to find if having sched events in
memory.stat be an exception for numa balancing or more general.

thanks,
Shakeel

