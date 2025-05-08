Return-Path: <cgroups+bounces-8100-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05CBAB0606
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 00:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E097BBE18
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 22:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB65722A811;
	Thu,  8 May 2025 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3xsq192"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5F4317D
	for <cgroups@vger.kernel.org>; Thu,  8 May 2025 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746743992; cv=none; b=eDJZ6hFt6V4pReHkIp5gh7vDNARe/fpo1dt/c4BbC0hrWNJRhDZi73CtfC53i/nZjOejIexYXflOPG3uotvHFlk2W3GiXhbjZbjJj5E1OKWFZsIMFuttU0EZdcILymle+9GPhHhgHOXun63KT8c/UkJ5kk0dRUp+0BcAgbAVANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746743992; c=relaxed/simple;
	bh=QzD2qbw3hSmQ04LZ66P4Z/xgHwYXJG0TxSk0W6ROdg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ES76gS4hRVA/w8nfcQ04wMk850URWVLFDF6ltiB6e+jnFvYDKhji7+NsD4cU0hRGdQddtiTz6tio1XASKnwEYvjBFE/sWp7zCztw+V2+7qL3mRZu+A8j0g+28MgPeZXJmnvnAIJCffnHW+XSI5TT3D+4Gzm3K41sYfXyTOZrumY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v3xsq192; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac3b12e8518so309434966b.0
        for <cgroups@vger.kernel.org>; Thu, 08 May 2025 15:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746743989; x=1747348789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzD2qbw3hSmQ04LZ66P4Z/xgHwYXJG0TxSk0W6ROdg4=;
        b=v3xsq1921GYbPRB6MBSavFISWnE4UD8dNp9R0kYFWmOXqn7lbV9ZJP6AaWJMesRGAF
         jILYjC7QpM9rJq/LsgN1AFoYXMp7Zznt57LDOIgfLc3QyKNNYmSRr1OoxTbOQ4PEGdQC
         zfGWTChYd2QDLbMgQsmV1/Ai0eSlwyBirR2tcqDjg9OTQ/warxh9oSZ/95/DjoKsYOYc
         jq7omzJdGJ3BjyGsg1T7WCCMiifRoSxE7LTi7tQ1GRuLlbjIJ+k/Soc8Bzq87mN3pl2R
         2Vf+QrcyhcP9WfB8Gvo0uvFghn5ThwWdPrSuXAlvgQn8fxsrAtjHrcKSqMD6jwAk8BfI
         z2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746743989; x=1747348789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzD2qbw3hSmQ04LZ66P4Z/xgHwYXJG0TxSk0W6ROdg4=;
        b=ZiEkbNkIQ2drMgoYVHcxQh0M+df2JRkw6XTbWy0mMpRiXie4TSrMC40j+R7pqaV+7S
         ya1tf9uEPSp346r/H92xoHZ6Ins2gWZ/OPBTHqAfCpkHvup97XuJ2EB+iMwivgLH+b6m
         q+wcyAuA7rVO5SZjiPoDuytDUaelSWTmnwbDHg7OD7K+fOyozjzfqjF/BHWTzMZYkiZG
         ddY406aL2mkYLGhUtA2TrbX54VT2dL9jkElFa+AnIJf8Z3pfKP7MrfarsAa5XCyDN84k
         HW29pp2Eu+x8FyyMWrTT6r4tcrfrfeAH21DhLcNJTLX0Klshs9K1rGwcSwhTx4dP7sC+
         H/TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUGvC7AraarQnOwj9wrZSZmWnBGdBObEoYi4cZls0C36mIYWIsOFC1CF/fKzygV+gF0leCMIpJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqm8cxJOnLjbBtj3AGiU+eNLhg7hrftxH/lP+dSCbeHH/yp5lV
	5IH3Kku84MSCsaKY+BBVGDseWKQkTBUufRoxhWBTmtx85eXKtSkoiKODXWeGFwHWytLB2m7i289
	JE7VVB0iD8/Ysa5XDZkGmKzc2Ce9sZCEZyrrH
X-Gm-Gg: ASbGncsOgyGdELHgMEqi81M9CkngCtMMGnlAvcgCy8TEUzfg0GpcqyhNzCrHkxHZ6bn
	AwUxxT0DSDEuWqDtBE/PtvqyVFJrW2k1safqpgtFtQK+RlWJq6BrmvmQyUQV7QBO5Fxc0CMSUeV
	jMNc+E/d/LkMarOxD2G0TywRvZe9crL9fgGqdmRVoyebca+cQwFiC+U57JVpryOOsZMMs=
X-Google-Smtp-Source: AGHT+IHEZEZcdQ6fKWsGsng5og7pZBg3gQtRVYyJEPAHwma2WhiqgM5OfwYcsXbJJ4oQ6cXZc7aWeuUYpKxQiOsGyDs=
X-Received: by 2002:a17:907:86a0:b0:ac4:76d:6d2c with SMTP id
 a640c23a62f3a-ad219171dc9mr139734466b.40.1746743988932; Thu, 08 May 2025
 15:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506183533.1917459-1-xii@google.com> <aBqmmtST-_9oM9rF@slm.duckdns.org>
 <CAOBoifh4BY1f4B3EfDvqWCxNSV8zwmJPNoR3bLOA7YO11uGBCQ@mail.gmail.com>
 <aBtp98E9q37FLeMv@localhost.localdomain> <CAOBoifgp=oEC9SSgFC+4_fYgDgSH_Z_TMgwhOxxaNZmyD-ijig@mail.gmail.com>
 <aBuaN-xtOMs17ers@slm.duckdns.org> <CAOBoifiv2GCeeDjax8Famu7atgkGNV0ZxxG-cfgvC857-dniqA@mail.gmail.com>
 <aBv2AG-VbZ4gcWpi@pavilion.home> <CAOBoifhWNi-j6jbP6B9CofTrT+Kr6TCSYYPMv7SQdbY5s930og@mail.gmail.com>
 <b7aa4b10-1afb-476f-ac5d-d8db7151d866@redhat.com>
In-Reply-To: <b7aa4b10-1afb-476f-ac5d-d8db7151d866@redhat.com>
From: Xi Wang <xii@google.com>
Date: Thu, 8 May 2025 15:39:37 -0700
X-Gm-Features: ATxdqUHca2Nia6mAxzFzZLx3W3dHkkjvOWT6yf9BvizXLviHa80VT2AUL1n5m4A
Message-ID: <CAOBoifjzJ=-siSR=2=3FtKwajSgkXsL40XO2pox0XR4c8vvkzg@mail.gmail.com>
Subject: Re: [RFC/PATCH] sched: Support moving kthreads into cpuset cgroups
To: Waiman Long <llong@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	David Rientjes <rientjes@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Dan Carpenter <dan.carpenter@linaro.org>, Chen Yu <yu.c.chen@intel.com>, 
	Kees Cook <kees@kernel.org>, Yu-Chun Lin <eleanor15x@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	jiangshanlai@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 12:35=E2=80=AFPM Waiman Long <llong@redhat.com> wrot=
e:
>
> On 5/8/25 1:51 PM, Xi Wang wrote:
> > I think our problem spaces are different. Perhaps your problems are clo=
ser to
> > hard real-time systems but our problems are about improving latency of =
existing
> > systems while maintaining efficiency (max supported cpu util).
> >
> > For hard real-time systems we sometimes throw cores at the problem and =
run no
> > more than one thread per cpu. But if we want efficiency we have to shar=
e cpus
> > with scheduling policies. Disconnecting the cpu scheduler with isolcpus=
 results
> > in losing too much of the machine capacity. CPU scheduling is needed fo=
r both
> > kernel and userspace threads.
> >
> > For our use case we need to move kernel threads away from certain vcpu =
threads,
> > but other vcpu threads can share cpus with kernel threads. The ratio ch=
anges
> > from time to time. Permanently putting aside a few cpus results in a re=
duction
> > in machine capacity.
> >
> > The PF_NO_SETAFFINTIY case is already handled by the patch. These threa=
ds will
> > run in root cgroup with affinities just like before.
> >
> > The original justifications for the cpuset feature is here and the reas=
ons are
> > still applicable:
> >
> > "The management of large computer systems, with many processors (CPUs),=
 complex
> > memory cache hierarchies and multiple Memory Nodes having non-uniform a=
ccess
> > times (NUMA) presents additional challenges for the efficient schedulin=
g and
> > memory placement of processes."
> >
> > "But larger systems, which benefit more from careful processor and memo=
ry
> > placement to reduce memory access times and contention.."
> >
> > "These subsets, or =E2=80=9Csoft partitions=E2=80=9D must be able to be=
 dynamically adjusted, as
> > the job mix changes, without impacting other concurrently executing job=
s."
> >
> > https://docs.kernel.org/admin-guide/cgroup-v1/cpusets.html
> >
> > -Xi
> >
> If you create a cpuset root partition, we are pushing some kthreads
> aways from CPUs dedicated to the newly created partition which has its
> own scheduling domain separate from the cgroup root. I do realize that
> the current way of excluding only per cpu kthreads isn't quite right. So
> I send out a new patch to extend to all the PF_NO_SETAFFINITY kthreads.
>
> So instead of putting kthreads into the dedicated cpuset, we still keep
> them in the root cgroup. Instead we can create a separate cpuset
> partition to run the workload without interference from the background
> kthreads. Will that functionality suit your current need?
>
> Cheers,
> Longman
>

It's likely a major improvement over a fixed partition but maybe still not =
fully
flexible. I am not familiar with cpuset partitions but I wonder if the foll=
owing
case can be supported:

Starting from
16 cpus
Root has cpu 0-3, 8-15
Job A has cpu 4-7 exclusive
Kernel threads cannot run on cpu 4-8 which is good.

Now adding best effort Job B, which is under SCHED_IDLE and rarely enters k=
ernel
mode. As we expect C can be easily preempted we allow it to share cpus with=
 A
and kernel threads to maximize throughput. Is there a layout that supports =
the
requirements below?

Job C threads on cpu 0-15
Job A threads on cpu 4-7
No kernel threads on cpu 4-7

-Xi

