Return-Path: <cgroups+bounces-7902-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D3CAA3B49
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 00:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF38E4C86D1
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 22:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C809A270ED6;
	Tue, 29 Apr 2025 22:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G6qOR9Nm"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5992F26FA42
	for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965090; cv=none; b=HebtpET2LckZAn3/40aw3pwUcd7jOZ2fbPzmf1Nw+Prq2A8JmDkKj8tk5XRzYfGmvJuSwnH6675PnIM+qLX9Aqakk0608sqdX0/dvgk32gSR6RIEepT/8wpsBgRdo9FFeSOdfasa1g25bovfD8KNowlhsbaqmBZFUEAsBncLQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965090; c=relaxed/simple;
	bh=wDpIvk141ZV01NhrIY+JkCqDNYoHd9B0SSs3egxRMkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIORqdMXSwUAYA5ZnuqlGZ5YgkkJtlJRm3I3CzANrPLdN3w0wVHtLDAAJBWDRpFqcTeCsyEQMUutcDYi3To5zGmoTtbZDGskAhVnZJBDV8sV9cRsjojs20hiZAjFYf3xqL4LE+oKBa3oTzgot+xNg4pTgH3QQKPNOoVMUTTcxfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G6qOR9Nm; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 29 Apr 2025 22:17:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745965076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQJrRrVaFnBo4XocryJt5anmF0O/r9hN8T59g9L9+bs=;
	b=G6qOR9Nmd2hZRkjRJSwbebk2ojGNBZjKTHw9Cbq30iktCdJKq2cJddDCl+7skE3ZxiG5Ol
	YkVX0BUIC+d/kVdjEu6Xx0fbr0tLyechP3c0pYVUSxH1kX1oi4tPMOWBz+N/Zt0i7VM5gM
	p6eYvL0BqmG+5/n7pnQRRr/WLiA56vU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH rfc 00/12] mm: BPF OOM
Message-ID: <aBFQBUsrTJLwqGXA@google.com>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <aBC7E487qDSDTdBH@tiehlicka>
 <87selrrpqz.fsf@linux.dev>
 <CAJuCfpEToCmf6rdA6tNpWrzw70Er6Q4ZWOwn+ruCWpU=ZEEkmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEToCmf6rdA6tNpWrzw70Er6Q4ZWOwn+ruCWpU=ZEEkmA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 29, 2025 at 02:56:31PM -0700, Suren Baghdasaryan wrote:
> On Tue, Apr 29, 2025 at 7:45 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > Michal Hocko <mhocko@suse.com> writes:
> >
> > > On Mon 28-04-25 03:36:05, Roman Gushchin wrote:
> > >> This patchset adds an ability to customize the out of memory
> > >> handling using bpf.
> > >>
> > >> It focuses on two parts:
> > >> 1) OOM handling policy,
> > >> 2) PSI-based OOM invocation.
> > >>
> > >> The idea to use bpf for customizing the OOM handling is not new, but
> > >> unlike the previous proposal [1], which augmented the existing task
> > >> ranking-based policy, this one tries to be as generic as possible and
> > >> leverage the full power of the modern bpf.
> > >>
> > >> It provides a generic hook which is called before the existing OOM
> > >> killer code and allows implementing any policy, e.g.  picking a victim
> > >> task or memory cgroup or potentially even releasing memory in other
> > >> ways, e.g. deleting tmpfs files (the last one might require some
> > >> additional but relatively simple changes).
> > >
> > > Makes sense to me. I still have a slight concern though. We have 3
> > > different oom handlers smashed into a single one with special casing
> > > involved. This is manageable (although not great) for the in kernel
> > > code but I am wondering whether we should do better for BPF based OOM
> > > implementations. Would it make sense to have different callbacks for
> > > cpuset, memcg and global oom killer handlers?
> >
> > Yes, it's certainly possible. If we go struct_ops path, we can even
> > have both the common hook which handles all types of OOM's and separate
> > hooks for each type. The user then can choose what's more convenient.
> > Good point.
> >
> > >
> > > I can see you have already added some helper functions to deal with
> > > memcgs but I do not see anything to iterate processes or find a process to
> > > kill etc. Is that functionality generally available (sorry I am not
> > > really familiar with BPF all that much so please bear with me)?
> >
> > Yes, task iterator is available since v6.7:
> > https://docs.ebpf.io/linux/kfuncs/bpf_iter_task_new/
> >
> > >
> > > I like the way how you naturalely hooked into existing OOM primitives
> > > like oom_kill_process but I do not see tsk_is_oom_victim exposed. Are
> > > you waiting for a first user that needs to implement oom victim
> > > synchronization or do you plan to integrate that into tasks iterators?
> >
> > It can be implemented in bpf directly, but I agree that it probably
> > deserves at least an example in the test or a separate in-kernel helper.
> > In-kernel helper is probably a better idea.
> >
> > > I am mostly asking because it is exactly these kind of details that
> > > make the current in kernel oom handler quite complex and it would be
> > > great if custom ones do not have to reproduce that complexity and only
> > > focus on the high level policy.
> >
> > Totally agree.
> >
> > >
> > >> The second part is related to the fundamental question on when to
> > >> declare the OOM event. It's a trade-off between the risk of
> > >> unnecessary OOM kills and associated work losses and the risk of
> > >> infinite trashing and effective soft lockups.  In the last few years
> > >> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> > >> systemd-OOMd [4]). The common idea was to use userspace daemons to
> > >> implement custom OOM logic as well as rely on PSI monitoring to avoid
> > >> stalls.
> > >
> > > This makes sense to me as well. I have to admit I am not fully familiar
> > > with PSI integration into sched code but from what I can see the
> > > evaluation is done on regular bases from the worker context kicked off
> > > from the scheduler code. There shouldn't be any locking constrains which
> > > is good. Is there any risk if the oom handler took too long though?
> >
> > It's a good question. In theory yes, it can affect the timing of other
> > PSI events. An option here is to move it into a separate work, however
> > I'm not sure if it worth the added complexity. I actually tried this
> > approach in an earlier version of this patchset, but the problem was
> > that the code for scheduling this work should be dynamically turned
> > on/off when a bpf program is attached/detached, otherwise it's an
> > obvious cpu overhead.
> > It's doable, but Idk if it's justified.
> >
> > >
> > > Also an important question. I can see selftests which are using the
> > > infrastructure. But have you tried to implement a real OOM handler with
> > > this proposed infrastructure?
> >
> > Not yet. Given the size and complexity of the infrastructure of my
> > current employer, it's not a short process. But we're working on it.
> 
> Hi Roman,
> This might end up being very useful for Android. Since we have a
> shared current employer, we might be able to provide an earlier test
> environment for this concept on Android and speed up development of a
> real OOM handler. I'll be following the development of this patchset
> and will see if we can come up with an early prototype for testing.

Hi Suren,

Sounds great, thank you!

