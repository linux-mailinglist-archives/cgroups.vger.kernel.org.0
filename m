Return-Path: <cgroups+bounces-8072-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3ACAAE7C4
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 19:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 879607BDF9B
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 17:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4F528C85E;
	Wed,  7 May 2025 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKGsGhv1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EAF1EB5DD
	for <cgroups@vger.kernel.org>; Wed,  7 May 2025 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638620; cv=none; b=iSx0k5hoZApq0cats+M7I4GFkJen0DpeLqW1Ts27EqVXCi2ZWCWg+nmwtUXMN4vzjH2B9dsRvceBhUEH2PXBkfrVTqCY0CIYeWSA2CS/uepv1u08BV3cMK3kBzbjKfu0EwB1BvQNZo7sZPKHWSzzUgbB+B+7cGBLlXVVDx46Zx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638620; c=relaxed/simple;
	bh=ewlV+sRszF9muSFOX7hfJtjSreVRo33zhmUq1+5wQOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SF2Cyogw4azAiWl8mgOYmT28qgzeJTHCmE5eQGGZeU0kTx/WVH2cP31s1WxEVglyObtLJmHWbqXi4Jzg03TYhbzLmF1Z+rZ5Vv2QZfl/gchEq3nvAo+2Z+N4BtwM9js1C40t4c9SXjaHcedFpGDxSabyEj2EwRzHAHfl7y2s+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PKGsGhv1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5faaddb09feso95893a12.2
        for <cgroups@vger.kernel.org>; Wed, 07 May 2025 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746638617; x=1747243417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY+h6X2XedSZi20l91/QA51b9ryXVScf2CPooruo8DE=;
        b=PKGsGhv1AClwXcr7KW0FtJA7JSW15uu20tCrRbcTIF7g1+GScXhQ58noRQ6kL0Ssxb
         OlKg/uAhOSzI5X2VDJM9JS7acPs/w+cE/YwZ3LzeI06riSGAph+vhkiV6N6+Y5NEyQ4V
         8AMh5SW2CI10KyAJV69wuNaCv6FhpbwfWCGKtZaVwrPfAq/u+3CNMWxvvkTXbSVpPaUl
         CPYASNGHf22UMXkwiXFVjVAnkrm0ROENEjb5CVIsfxpY9fooi6n9tFthzC3tjQPN7gvB
         6p17FPpAP2/E7ZsXW3+W+CRCnCwM96kZtESShYrlHOBfmVc3E7guFfi0Qt4NUD4vhVBF
         62dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638617; x=1747243417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZY+h6X2XedSZi20l91/QA51b9ryXVScf2CPooruo8DE=;
        b=NG+ju+Ql9+EEP12BZOhDOzgdpFWuX8RBx36PdtPIvXOINxOVu+EX9UG7kGVRRfGicA
         4zSldeQRs6InRLhRE+5LdwrZ6+uthrx+pW9Z5BX3d9THvtPUMGDEJJVF5qoFNlaweZho
         m1Q+YyW1QQKMoqiY4bibGlZO9PiOaNg+T9wGMNXbpXYO9TK6lVR963P2hXStRamq0/JK
         /CJUAdpZRihIIPkPbIPZrAc13BZ/Lg8XeaQOVDgjZkTGZKgSA3FhnA/RVEveF4UlXz0L
         nYGudRAL5XMfKOvevvTdBXz7HBHGFHp3SG+zGwlrQAJ6HR2PQ/S+UIzVIvxf2t/40mfJ
         6sRA==
X-Forwarded-Encrypted: i=1; AJvYcCXIhdXiHBKDTdZmdyWA4c3WhaSmXYPbuGWlM4NvCRo6Et25Ls8BM+hCN+iEJKXUEKj5I9Gtzwsz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1gQB4IQvKMrYGnb64VADXuu0EaZnAVXjcGkzSYZIVp7iuDVD6
	VyTFAWtUdm6ji23FklIpfbQ0nqZ04URDUyQhufTk+1AIbqzTdZHcblBie+7EaMdetgC78SW12pe
	w/JMpzQwIJpMr0cVjyAuHH/JFyVuiUkuDJ8mZ
X-Gm-Gg: ASbGncuMkr4KipVo+ZgM46KIl0RpQrATO9RXSJuSPfN0S3VCzMnEFSa2wJGqHOwKoYh
	fpJIpsClNHYqapASuqGFe1zTwZYmSir/UGWxvRoMzazXmvmPBK5zRVchs8+TH8MwwlRsZs9Phbe
	E/QpnUKL2UHhjGZ+s/f5oYxK+7sYitPpKPkk7AHioKYZ2O8ORYFQ==
X-Google-Smtp-Source: AGHT+IF0pJTKi36N0DAA0O9JgGyEtGDnfSk8P/Zj5vvwMQ+L6BFmKylLNPDtOHBsd9fX8CQa3qUfPG5Tl2Sv0KGaShg=
X-Received: by 2002:a17:907:d046:b0:ace:c180:e3b with SMTP id
 a640c23a62f3a-ad1fe6f6113mr2941566b.31.1746638616671; Wed, 07 May 2025
 10:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506183533.1917459-1-xii@google.com> <aBqmmtST-_9oM9rF@slm.duckdns.org>
 <CAOBoifh4BY1f4B3EfDvqWCxNSV8zwmJPNoR3bLOA7YO11uGBCQ@mail.gmail.com> <aBtp98E9q37FLeMv@localhost.localdomain>
In-Reply-To: <aBtp98E9q37FLeMv@localhost.localdomain>
From: Xi Wang <xii@google.com>
Date: Wed, 7 May 2025 10:23:24 -0700
X-Gm-Features: ATxdqUEiwuZBXPQM5AxuYr3cRC8Jy0fmaTsk7TiDCQLyU3wbnCFO16CEVv3w2rQ
Message-ID: <CAOBoifgp=oEC9SSgFC+4_fYgDgSH_Z_TMgwhOxxaNZmyD-ijig@mail.gmail.com>
Subject: Re: [RFC/PATCH] sched: Support moving kthreads into cpuset cgroups
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, David Rientjes <rientjes@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <longman@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Dan Carpenter <dan.carpenter@linaro.org>, Chen Yu <yu.c.chen@intel.com>, 
	Kees Cook <kees@kernel.org>, Yu-Chun Lin <eleanor15x@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	jiangshanlai@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 7:11=E2=80=AFAM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> Le Tue, May 06, 2025 at 08:43:57PM -0700, Xi Wang a =C3=A9crit :
> > On Tue, May 6, 2025 at 5:17=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> > For the use cases, there are two major requirements at the moment:
> >
> > Dynamic cpu affinity based isolation: CPUs running latency sensitive th=
reads
> > (vcpu threads) can change over time. We'd like to configure kernel thre=
ad
> > affinity at run time too.
>
> I would expect such latency sensitive application to run on isolated
> partitions. And those already don't pull unbound kthreads.
>
> > Changing cpu affinity at run time requires cpumask
> > calculations and thread migrations. Sharing cpuset code would be nice.
>
> There is already some (recent) affinity management in the kthread subsyst=
em.
> A list of kthreads having a preferred affinity (but !PF_NO_SETAFFINITY)
> is maintained and automatically handled against hotplug events and housek=
eeping
> state.
>
> >
> > Support numa based memory daemon affinity: We'd like to restrict kernel=
 memory
> > daemons but maintain their numa affinity at the same time. cgroup hiera=
rchies
> > can be helpful, e.g. create kernel, kernel/node0 and kernel/node1 and m=
ove the
> > daemons to the right cgroup.
>
> The kthread subsystem also handles node affinity. See kswapd / kcompactd.=
 And it
> takes care of that while still honouring isolated / isolcpus partitions:
>
>       d1a89197589c ("kthread: Default affine kthread to its preferred NUM=
A node")
>
> >
> > Workqueue coverage is optional. kworker threads can use their separate
> > mechanisms too.
> >
> > Since the goal is isolation, we'd like to restrict as many kthreads as =
possible,
> > even the ones that don't directly interact with user applications.
> >
> > The kthreadd case is handled - a new kthread can be forked inside a non=
 root
> > cgroup, but based on flags it can move itself to the root cgroup before=
 threadfn
> > is called.
>
> kthreadd and other kthreads that don't have a preferred affinity are also
> affine outside isolcpus/nohz_full. And since isolated cpuset partitions
> create NULL domains, those kthreads won't run there either.
>
> What am I missing?

Overall I think your arguments depend on kernel and application threads are
significantly different for cpu affinity management, but there isn't enough
evidence for it. If cpuset is a bad idea for kernel threads it's probably n=
ot
a good idea for user threads either. Maybe we should just remove cpuset fro=
m
kernel and let applications threads go with boot time global variables and
set their own cpu affinities.

-Xi

