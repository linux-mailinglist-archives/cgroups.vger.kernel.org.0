Return-Path: <cgroups+bounces-8038-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2589AAC010
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 11:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B2AD7AB15A
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 09:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C7C26FD9E;
	Tue,  6 May 2025 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vqJXirJ+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776326B2BE
	for <cgroups@vger.kernel.org>; Tue,  6 May 2025 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524473; cv=none; b=Tay8wkI6SzIecph7TfI2hsF4A6YOeVkQHGaoep+eR6IdzFoNeS5JyDm4A/Pbj5mU2pbqY2l0brsxxens2l87m0LsqpHrXjct6xyKFNKGn5pMC3AdkOyRt0ijlhgh92E1ymahPuM3aqWzTuOrJswyCD9xpuVL+RnhJQ5LwHWpgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524473; c=relaxed/simple;
	bh=enzffrG//0Be1JBzAGY/EHx/cuyUrQQ7nxl1aPShPSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mP+22Sv00Uct/E51HyYjE/Ea39Nbq+nKryxFpMjDedvIYc9ejZ4sk9x2tMddOnc2piXKSU6fFTRW5QOF2yMX8EESsagog41YApgVfF1+XQU87RSyMHgrcxuOo4eiTxqlTO337OWadQ9m3amXhv12Bxs9Yb0ahZbCiE46zCyN0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vqJXirJ+; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 May 2025 09:41:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746524469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p9JEQ5MEIGdY5HQTIeFYZw6nNX1hJPlNSluNRhYlSsM=;
	b=vqJXirJ+udQtoPHrcNBzmk2NUAB3/MCs3MuuKQuAiVoBygBttFPgI28D5TEBo/MSwzrB/M
	p5BSjXS4U3JgiW/vkd33EyqaOQaTk5I4OzbRiNtajIf6EaNFyLAVXFj6wgC8nbvc0kXCnd
	Pyc0+N8FWoQj9hqf4qUDcV4sketLqeQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	JP Kobryn <inwardvessel@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] cgroup: make css_rstat_updated nmi safe
Message-ID: <aBnZMBJ-OOEXvpUa@google.com>
References: <20250429061211.1295443-1-shakeel.butt@linux.dev>
 <20250429061211.1295443-4-shakeel.butt@linux.dev>
 <aBIiNMXIl6vyaNQ6@Asmaa.>
 <6u7ccequ5ye3e4iqblcdeqsigindo3xjpsvkdb6hyaw7cpjddc@u2ujv7ymlxc6>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6u7ccequ5ye3e4iqblcdeqsigindo3xjpsvkdb6hyaw7cpjddc@u2ujv7ymlxc6>
X-Migadu-Flow: FLOW_OUT

On Thu, May 01, 2025 at 03:10:20PM -0700, Shakeel Butt wrote:
> On Wed, Apr 30, 2025 at 06:14:28AM -0700, Yosry Ahmed wrote:
> [...]
> > > +
> > > +	if (!_css_rstat_cpu_trylock(css, cpu, &flags)) {
> > 
> > 
> > IIUC this trylock will only fail if a BPF program runs in NMI context
> > and tries to update cgroup stats, interrupting a context that is already
> > holding the lock (i.e. updating or flushing stats).
> > 
> 
> Correct (though note that flushing side can be on a different CPU).
> 
> > How often does this happen in practice tho? Is it worth the complexity?
> 
> This is about correctness, so even a chance of occurance need the
> solution.

Right, my question was more about the need to special case NMIs, see
below.

> 
> > 
> > I wonder if it's better if we make css_rstat_updated() inherently
> > lockless instead.
> > 
> > What if css_rstat_updated() always just adds to a lockless tree,
> 
> Here I assume you meant lockless list instead of tree.

Yeah, in a sense. I meant using lockless lists to implement the rstat
tree instead of normal linked lists.

> 
> > and we
> > defer constructing the proper tree to the flushing side? This should
> > make updates generally faster and avoids locking or disabling interrupts
> > in the fast path. We essentially push more work to the flushing side.
> > 
> > We may be able to consolidate some of the code too if all the logic
> > manipulating the tree is on the flushing side.
> > 
> > WDYT? Am I missing something here?
> > 
> 
> Yes this can be done but I don't think we need to tie that to current
> series. I think we can start with lockless in the nmi context and then
> iteratively make css_rstat_updated() lockless for all contexts.

My question is basically whether it would be simpler to actually make it
all lockless than special casing NMIs. With this patch we have two
different paths and a deferred list that we process at a later point. I
think it may be simpler if we just make it all lockless to begin with.
Then we would have a single path and no special deferred processing.

WDYT?

