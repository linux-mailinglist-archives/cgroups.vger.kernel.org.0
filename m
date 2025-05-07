Return-Path: <cgroups+bounces-8055-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0A2AAD433
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 05:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D643C983F53
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 03:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7400D1C9EB1;
	Wed,  7 May 2025 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qbKWJtoA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7203A1B85CC
	for <cgroups@vger.kernel.org>; Wed,  7 May 2025 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589454; cv=none; b=lzsLPn0tLSMp9QxEUmhwhMMq+8vzkQrfo6GIqPE63u/lFkWO4WPjENcTV/ta5Ldg+Z801H2r4bVIevlOQXpgKItm9REi5Hk8MO9e+A66hMrXe1nCojr8OvUtLiVU6Yl9Lx+j6umbWBYVeELKCOZTay5MVY2XY4riPhgVblcyP5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589454; c=relaxed/simple;
	bh=ZuyvyGJRgOf6b34z52aP6GoJUzazlvD+31gfs6Y7pHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+r694folnVrrzI3HeQlFvjfr6GHENA1OJZIik5bhixvNCtGtQYOIfjDIE1YIsku59RVQBr2+HO7w2zyJwf/634EwXJp1UKcZpHUOOMRSaGjTMgXlLzm2DrucNRdPutsZuqpeV/eEPQqveMM38Sbnvvt79XfHCnSDhJQHWLqgPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qbKWJtoA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac289147833so1167523966b.2
        for <cgroups@vger.kernel.org>; Tue, 06 May 2025 20:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746589451; x=1747194251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuyvyGJRgOf6b34z52aP6GoJUzazlvD+31gfs6Y7pHc=;
        b=qbKWJtoAejErecmHFe7rbthznhxoENtBJHUhVPWRXURmzq7Nbg1M45J3Ag2jI5z8kK
         QFLKPkUC7OMkDsCHubrLsb9LMhMS2w2XXnTFRjJoOztCCpEwAW12RP4M4A5d5l292L0u
         RsvX4Is5ru36DZALikJwghI+rYEtKMpsHU98Z6tnGdSIYaOCxJCO2Da4cNT3EqULqMHQ
         thBgHTDRocoH8H3y4UP+nTAypFrVoQjkK0fxeBkWAf8vCufdBlx74zsibguw9Q3vTSpv
         JPw0ndT/qcCe/w6DuNzQA2vPa4Wc5WkzNnogH4MvYDeg2mE4SClngfP00C4dw1gJ0GBI
         FOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746589451; x=1747194251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuyvyGJRgOf6b34z52aP6GoJUzazlvD+31gfs6Y7pHc=;
        b=vaVwVXAFzsnl8MyAtd0MVFAx1HA1OA8740vm7wfQFav2SOhlpc5LzbJZP2QBb4BRnl
         3xthas7GlOpF6prMGw+GBoMUQzLDN4DcukLiw1i39dx2eLfMDG9mrG8nGyNiPbA46K9Z
         28N29yQeVlKii8fPSjx45Tdung9W85PrBL5JZ5Y0DUT6PNdxGJfhVodDROQ0weXgrC9J
         A0qtBFWj2mufUqL4Jdfrh29bIHIIeQ2AV5TzrTXm0a6e3s61FeofXaO1ts9hc+SER87U
         LdK8GH93foN9U1ISZ8mi1MGIFW+4UzQg2Uvif58gOUkNHXjqx+jucoow96rR7r3Jdoai
         fBtg==
X-Forwarded-Encrypted: i=1; AJvYcCVB5cYXpK0B296I4X878zQMjgbWBdoGi22riUIRmnLRmYGbNV2Q4brtnCLSTGRISbbn61tWGCuu@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJZM0GIvfFk6oisdr12MIMeTcwnSotrGWSh2yk4EhIwFLuTXR
	7mzl7bniJruTM86R/VeJ5reiNdoIh1qZ4ZynaWEZCKXucchgsh0od/pTFATJf5XRx4t2DIbSJw/
	bcg1abTElyrSZwZrYzg/2pvRJlIFV3PRi1XpP
X-Gm-Gg: ASbGncuA8/YnN4LQit7+Re8Xg3K0VoJYFRvh4sq8uATWaRTmFOD2molQsb747eI56Gb
	WOh5JlUlKQAfanzwWvDQEd5YxQdTTgMJLyZpZxJdXXikNxht//m61jHOes3PR89fO4du2UGwQr3
	GyHNUKJp+h+QHUSsUR5VgA4Z1kZbI/ulyPiSyFr87ZoFsnGNyyf3Ed4hPccBb1P2HtiA==
X-Google-Smtp-Source: AGHT+IH7IGKTEFhC4cr8+0rRXEHJu2nDGTsN/0//XY9q17g/0aaFrfhBXbLnWK9RCYRx9yAZA3AgFcdYqMmUhKmXe28=
X-Received: by 2002:a17:907:1c0b:b0:acb:5c83:251 with SMTP id
 a640c23a62f3a-ad1e8e2b9demr175785266b.53.1746589450585; Tue, 06 May 2025
 20:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506183533.1917459-1-xii@google.com> <aBqmmtST-_9oM9rF@slm.duckdns.org>
In-Reply-To: <aBqmmtST-_9oM9rF@slm.duckdns.org>
From: Xi Wang <xii@google.com>
Date: Tue, 6 May 2025 20:43:57 -0700
X-Gm-Features: ATxdqUHUz2sResNmX2xSRB_WefjQNHw4KWqWeezZNZ8hfP4zrd-J_xJY7gN2DcY
Message-ID: <CAOBoifh4BY1f4B3EfDvqWCxNSV8zwmJPNoR3bLOA7YO11uGBCQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] sched: Support moving kthreads into cpuset cgroups
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, David Rientjes <rientjes@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <longman@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com1>, Frederic Weisbecker <frederic@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Dan Carpenter <dan.carpenter@linaro.org>, Chen Yu <yu.c.chen@intel.com>, 
	Kees Cook <kees@kernel.org>, Yu-Chun Lin <eleanor15x@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:17=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, May 06, 2025 at 11:35:32AM -0700, Xi Wang wrote:
> > In theory we should be able to manage kernel tasks with cpuset
> > cgroups just like user tasks, would be a flexible way to limit
> > interferences to real-time and other sensitive workloads. This is
> > however not supported today: When setting cpu affinity for kthreads,
> > kernel code uses a simpler control path that directly lead to
> > __set_cpus_allowed_ptr or __ktread_bind_mask. Neither honors cpuset
> > restrictions.
> >
> > This patch adds cpuset support for kernel tasks by merging userspace
> > and kernel cpu affinity control paths and applying the same
> > restrictions to kthreads.
> >
> > The PF_NO_SETAFFINITY flag is still supported for tasks that have to
> > run with certain cpu affinities. Kernel ensures kthreads with this
> > flag have their affinities locked and they stay in the root cpuset:
> >
> > If userspace moves kthreadd out of the root cpuset (see example
> > below), a newly forked kthread will be in a non root cgroup as well.
> > If PF_NO_SETAFFINITY is detected for the kthread, it will move itself
> > into the root cpuset before the threadfn is called. This does depend
> > on the kthread create -> kthread bind -> wake up sequence.
>
> Can you describe the use cases in detail? This is not in line with the
> overall direction. e.g. We're making cpuset work with housekeeping mechan=
ism
> and tell workqueue which CPUs can be used for unbound execution and kthre=
ads
> which are closely tied to userspace activities are spawned into the same
> cgroups as the user thread and subject to usual resource control.
>
> There are a lot of risks in subjecting arbitrary kthreads to all cgroup
> resource controls and just allowing cpuset doesn't seem like a great idea=
.
> Integration through housekeeping makes a lot more sense to me. Note that
> even for just cpuset thread level control doesn't really work that well. =
All
> kthreads are forked by kthreadd. If you move the kthreadd into a cgroup, =
all
> kthreads includling kworkers for all workqueues will be spawned there. Th=
e
> granularity of control isn't much better than going through housekeeping.

For the use cases, there are two major requirements at the moment:

Dynamic cpu affinity based isolation: CPUs running latency sensitive thread=
s
(vcpu threads) can change over time. We'd like to configure kernel thread
affinity at run time too. Changing cpu affinity at run time requires cpumas=
k
calculations and thread migrations. Sharing cpuset code would be nice.

Support numa based memory daemon affinity: We'd like to restrict kernel mem=
ory
daemons but maintain their numa affinity at the same time. cgroup hierarchi=
es
can be helpful, e.g. create kernel, kernel/node0 and kernel/node1 and move =
the
daemons to the right cgroup.

Workqueue coverage is optional. kworker threads can use their separate
mechanisms too.

Since the goal is isolation, we'd like to restrict as many kthreads as poss=
ible,
even the ones that don't directly interact with user applications.

The kthreadd case is handled - a new kthread can be forked inside a non roo=
t
cgroup, but based on flags it can move itself to the root cgroup before thr=
eadfn
is called.

-Xi

