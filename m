Return-Path: <cgroups+bounces-7898-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1922AA10C1
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 17:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D477B4F4F
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12C9227E98;
	Tue, 29 Apr 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iotlXLtG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2419227E8C
	for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941347; cv=none; b=PZlUKg4S3HnUHUZs9rF6cnrDpdXwjB50Bi5qGTzKrvnyhLysHAEypWw+UdVmB73lYqBH0uVDSlNJ06J5EgGoo/F3S4CXOyM0m7PMrWxn64hM+fTxJVkYlJ8reE0YZez+pI9wxGR0VnmfaH/bEI3MddtVKlm4NZSH1/oYCC96fD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941347; c=relaxed/simple;
	bh=j/YHf1teaDrb4ir9M8xT43/VAvVAAqIIQm3vpT9RNQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wfjw//wfM2pqLzKvRy+fsM8U3OQuw+1k92ngBXET8PXxM98I2rmievW+/BeAKpFiFFekxHDmA9hhJLHnD47PeZjC9zJO5+cQqZmTVG+YA654tfCP98UrEJ8HSo6wNq8OfusIOafmkrwH3bDR2wihRx7N8o7/W+om0U4vNV9cNs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iotlXLtG; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 29 Apr 2025 15:42:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745941342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y81njpVq6vhPefsffMyJQnG/4OkeUNAj+Vh1f25K2Cs=;
	b=iotlXLtGiFrEmKEnROAr+VqKuiA7RA246ZDTFou2eqbzF/kouv6PauUkEqtWaulgdxa00T
	zkXnBYIjyZyTkXO+5cpeuvw3oaywvYS2ckQ3YJiEpgVHOaUf9atwWt2MsUId+NVrAj8aEn
	y9VEyAGkcWE+a+JbdBWbRA1unqn3Yss=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH rfc 00/12] mm: BPF OOM
Message-ID: <aBDzWDcrk1Le32cN@google.com>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <aA9bu7UJOCTQGk6L@google.com>
 <aA-5xX10nXE2C2Dn@google.com>
 <CAP01T76Wv+swbT9xuQ-YhQ=-qOFggw6u1RziJNGjJBiNO233OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T76Wv+swbT9xuQ-YhQ=-qOFggw6u1RziJNGjJBiNO233OQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 29, 2025 at 03:56:54AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Mon, 28 Apr 2025 at 19:24, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Mon, Apr 28, 2025 at 10:43:07AM +0000, Matt Bobrowski wrote:
> > > On Mon, Apr 28, 2025 at 03:36:05AM +0000, Roman Gushchin wrote:
> > > > This patchset adds an ability to customize the out of memory
> > > > handling using bpf.
> > > >
> > > > It focuses on two parts:
> > > > 1) OOM handling policy,
> > > > 2) PSI-based OOM invocation.
> > > >
> > > > The idea to use bpf for customizing the OOM handling is not new, but
> > > > unlike the previous proposal [1], which augmented the existing task
> > > > ranking-based policy, this one tries to be as generic as possible and
> > > > leverage the full power of the modern bpf.
> > > >
> > > > It provides a generic hook which is called before the existing OOM
> > > > killer code and allows implementing any policy, e.g.  picking a victim
> > > > task or memory cgroup or potentially even releasing memory in other
> > > > ways, e.g. deleting tmpfs files (the last one might require some
> > > > additional but relatively simple changes).
> > > >
> > > > The past attempt to implement memory-cgroup aware policy [2] showed
> > > > that there are multiple opinions on what the best policy is.  As it's
> > > > highly workload-dependent and specific to a concrete way of organizing
> > > > workloads, the structure of the cgroup tree etc, a customizable
> > > > bpf-based implementation is preferable over a in-kernel implementation
> > > > with a dozen on sysctls.
> > > >
> > > > The second part is related to the fundamental question on when to
> > > > declare the OOM event. It's a trade-off between the risk of
> > > > unnecessary OOM kills and associated work losses and the risk of
> > > > infinite trashing and effective soft lockups.  In the last few years
> > > > several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> > > > systemd-OOMd [4]). The common idea was to use userspace daemons to
> > > > implement custom OOM logic as well as rely on PSI monitoring to avoid
> > > > stalls. In this scenario the userspace daemon was supposed to handle
> > > > the majority of OOMs, while the in-kernel OOM killer worked as the
> > > > last resort measure to guarantee that the system would never deadlock
> > > > on the memory. But this approach creates additional infrastructure
> > > > churn: userspace OOM daemon is a separate entity which needs to be
> > > > deployed, updated, monitored. A completely different pipeline needs to
> > > > be built to monitor both types of OOM events and collect associated
> > > > logs. A userspace daemon is more restricted in terms on what data is
> > > > available to it. Implementing a daemon which can work reliably under a
> > > > heavy memory pressure in the system is also tricky.
> > > >
> > > > [1]: https://lwn.net/ml/linux-kernel/20230810081319.65668-1-zhouchuyi@bytedance.com/
> > > > [2]: https://lore.kernel.org/lkml/20171130152824.1591-1-guro@fb.com/
> > > > [3]: https://github.com/facebookincubator/oomd
> > > > [4]: https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.service.html
> > > >
> > > > ----
> > > >
> > > > This is an RFC version, which is not intended to be merged in the current form.
> > > > Open questions/TODOs:
> > > > 1) Program type/attachment type for the bpf_handle_out_of_memory() hook.
> > > >    It has to be able to return a value, to be sleepable (to use cgroup iterators)
> > > >    and to have trusted arguments to pass oom_control down to bpf_oom_kill_process().
> > > >    Current patchset has a workaround (patch "bpf: treat fmodret tracing program's
> > > >    arguments as trusted"), which is not safe. One option is to fake acquire/release
> > > >    semantics for the oom_control pointer. Other option is to introduce a completely
> > > >    new attachment or program type, similar to lsm hooks.
> > >
> > > Thinking out loud now, but rather than introducing and having a single
> > > BPF-specific function/interface, and BPF program for that matter,
> > > which can effectively be used to short-circuit steps from within
> > > out_of_memory(), why not introduce a
> > > tcp_congestion_ops/sched_ext_ops-like interface which essentially
> > > provides a multifaceted interface for controlling OOM killing
> > > (->select_bad_process, ->oom_kill_process, etc), optionally also from
> > > the context of a BPF program (BPF_PROG_TYPE_STRUCT_OPS)?
> >
> > It's certainly an option and I thought about it. I don't think we need a bunch
> > of hooks though. This patchset adds 2 and they belong to completely different
> > subsystems (mm and sched/psi), so Idk how well they can be gathered
> > into a single struct ops. But maybe it's fine.
> >
> > The only potentially new hook I can envision now is one to customize
> > the oom reporting.
> >
> 
> If you're considering scoping it down to a particular cgroup (as you
> allude to in the TODO), or building a hierarchical interface, using
> struct_ops will be much better than fmod_ret etc., which is global in
> nature. Even if you don't support it now. I don't think a struct_ops
> is warranted only when you have more than a few callbacks. As an
> illustration, sched_ext started out without supporting hierarchical
> attachment, but will piggy-back on the struct_ops interface to do so
> in the near future.

Good point! I agree.

Thanks

