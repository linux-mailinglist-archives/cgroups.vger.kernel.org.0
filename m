Return-Path: <cgroups+bounces-7905-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A8DAA3BD6
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BEC189746A
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B860D2DAF84;
	Tue, 29 Apr 2025 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EZHjBjQo"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C726F44C
	for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745967698; cv=none; b=fW/giY5ZU9dr2FacAJ85PWoLt3POZ4pPHeffhsXotx/ceunhN5ZBC9jZPEc77LRLTXTwQXhTt8do/K+9G9VRsUcN/+fFFeyY3u0ElNR2sUUJZymUBbWbtoxS6SgSvSUMCad1YMI7LUkhK/3k6p5wnvoJV6rlNZrLK9hIV/dl1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745967698; c=relaxed/simple;
	bh=+saGZl/GeJyD5ERyvlP2h14M60bUHmvywU/KeMSQC5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvSE+C5/A6K6I5DQ9PFBdAJcDDFlp3D4lDEcBz53JVz2YZKINfttBXAK4X1QtuIFY04KxF3ObgrUJGqlDVIKyfWFHp6qFSHeEbmFhIRokGgN+ECiqjaVdftp0KebJe3Eu3tunBwdgaphPX1jjQpT8/kXn/dUMLxNNOYEwoJn7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EZHjBjQo; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 29 Apr 2025 23:01:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745967683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6RAb5lr2vH/thJQTV2RC7ZmoJupPHdWHQNQ0zWyXSsI=;
	b=EZHjBjQo6DtxpylzX22842xs2AXvxFH10UOZ8oD2ivBAHSHaanjZGOz327yhlK9AUaPAR2
	wW7pKg9uX8wSE+XjqOZsvaSZYTK3m02h1n3uto5/q6+ZDi+AgW2z6IpFyUxnfJ/x/iNoXM
	rRFajoaRfrY3wAew8aOzVBLBA6G0oHc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH rfc 00/12] mm: BPF OOM
Message-ID: <aBFaNcaeYwzoJ13j@google.com>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <CAJuCfpHnND1UJ1ZqiyshPqwbZDfeN41HOUuc7DWQfSM1cATBmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHnND1UJ1ZqiyshPqwbZDfeN41HOUuc7DWQfSM1cATBmQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 29, 2025 at 03:44:14PM -0700, Suren Baghdasaryan wrote:
> On Sun, Apr 27, 2025 at 8:36 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > This patchset adds an ability to customize the out of memory
> > handling using bpf.
> >
> > It focuses on two parts:
> > 1) OOM handling policy,
> > 2) PSI-based OOM invocation.
> >
> > The idea to use bpf for customizing the OOM handling is not new, but
> > unlike the previous proposal [1], which augmented the existing task
> > ranking-based policy, this one tries to be as generic as possible and
> > leverage the full power of the modern bpf.
> >
> > It provides a generic hook which is called before the existing OOM
> > killer code and allows implementing any policy, e.g.  picking a victim
> > task or memory cgroup or potentially even releasing memory in other
> > ways, e.g. deleting tmpfs files (the last one might require some
> > additional but relatively simple changes).
> >
> > The past attempt to implement memory-cgroup aware policy [2] showed
> > that there are multiple opinions on what the best policy is.  As it's
> > highly workload-dependent and specific to a concrete way of organizing
> > workloads, the structure of the cgroup tree etc, a customizable
> > bpf-based implementation is preferable over a in-kernel implementation
> > with a dozen on sysctls.
> >
> > The second part is related to the fundamental question on when to
> > declare the OOM event. It's a trade-off between the risk of
> > unnecessary OOM kills and associated work losses and the risk of
> > infinite trashing and effective soft lockups.  In the last few years
> > several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> > systemd-OOMd [4]). The common idea was to use userspace daemons to
> > implement custom OOM logic as well as rely on PSI monitoring to avoid
> > stalls. In this scenario the userspace daemon was supposed to handle
> > the majority of OOMs, while the in-kernel OOM killer worked as the
> > last resort measure to guarantee that the system would never deadlock
> > on the memory. But this approach creates additional infrastructure
> > churn: userspace OOM daemon is a separate entity which needs to be
> > deployed, updated, monitored. A completely different pipeline needs to
> > be built to monitor both types of OOM events and collect associated
> > logs. A userspace daemon is more restricted in terms on what data is
> > available to it. Implementing a daemon which can work reliably under a
> > heavy memory pressure in the system is also tricky.
> 
> I didn't read the whole patchset yet but want to mention couple
> features that we should not forget:
> - memory reaping. Maybe you already call oom_reap_task_mm() after BPF
> oom-handler kills a process or maybe BPF handler is expected to
> implement it?
> - kill reporting to userspace. I think BPF handler would be expected
> to implement it?

The patchset implements the bpf_oom_kill_process() helper, which kills
the desired process the same way as the kernel oom killer: with the help
of the oom reaper, dumping corresponding stats into dmesg and bumping
corresponding memcg- and system-level stats.

For additional reporting generic bpf<->userspace interaction mechanims
can be used, e.g. ringbuffer.

Thanks!

