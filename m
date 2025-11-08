Return-Path: <cgroups+bounces-11681-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA59C427DD
	for <lists+cgroups@lfdr.de>; Sat, 08 Nov 2025 06:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7C13B87E5
	for <lists+cgroups@lfdr.de>; Sat,  8 Nov 2025 05:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C7224BBF4;
	Sat,  8 Nov 2025 05:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rK0RiR/x"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223A52C21F3
	for <cgroups@vger.kernel.org>; Sat,  8 Nov 2025 05:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762580716; cv=none; b=bcS3W5/6hj82EeQbnoa3CeMBZVa1njigAbUyB10doaPD9vbsn2LZ8TAh1S4i2UZs2j6osNWgZLFrd+gI+BasAYz2ZBcZ9RsGBeDe0Dl4AMCufMNBqqoUlTrDUjMq2XvJYsIcELG9B36D8wo3Zx/PpKiUO7QTIFZBI25+0x7UnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762580716; c=relaxed/simple;
	bh=NVCTghZi5JjlEiSEJdbRNG52gFdsPmQjdyeqQdQogLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCs2S3ytBTaZ31D+on++flabKGubUji7hZ19An8X1LYRtO5t6rxFJ1/v5sPG7/YPnh4z0gE6U2mlan81TQ6O0qLIolVyHHHO+Bnk+f74ZhCXqwh46Vm3SfTLZ7wmVQ52aJcQ21+PGV4HYuowVidLRHx9rVGUVwmvTHrOxeWfrJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rK0RiR/x; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Nov 2025 21:45:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762580709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qwM369YFl+OLlR0vHxeHaLayeXRWU8S1aUt7oEr33o=;
	b=rK0RiR/xnW4uKGxUrWKA2zRLH1gbP10S7SpXJdr/OVXyGy6ziKfstyeaK9hyE7YFNcmALP
	TuHPNUbimbr7zsvineElD9m7kHKYtYNgh7PRcklXJo12snSmGsargyOwaG+vzUlJTiS6EF
	Qi4aL9bOqvocIHBFhhyIRqDetfzcL+k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm: memcg: dump memcg protection info on oom or alloc
 failures
Message-ID: <tawekrqql6efopwac3zrqgrszueampnadqp7s3g7wfvohsiqbt@22ai2cryardu>
References: <20251107234041.3632644-1-shakeel.butt@linux.dev>
 <20251108022639.73734-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108022639.73734-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 07, 2025 at 06:26:38PM -0800, SeongJae Park wrote:
> On Fri,  7 Nov 2025 15:40:41 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > Currently kernel dumps memory state on oom and allocation failures. One
> > of the question usually raised on those dumps is why the kernel has not
> > reclaimed the reclaimable memory instead of triggering oom. One
> > potential reason is the usage of memory protection provided by memcg.
> > So, let's also dump the memory protected by the memcg in such reports to
> > ease the debugging.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> [...]
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c34029e92bab..623446821b00 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5636,3 +5636,16 @@ bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> >  {
> >  	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
> >  }
> > +
> > +void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
> > +{
> > +	if (mem_cgroup_disabled() || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > +		return;
> > +
> > +	if (!memcg)
> > +		memcg = root_mem_cgroup;
> > +
> > +	pr_warn("Memory cgroup min protection %lukB -- low protection %lukB",
> > +		K(atomic_long_read(&memcg->memory.children_min_usage)*PAGE_SIZE),
> > +		K(atomic_long_read(&memcg->memory.children_low_usage)*PAGE_SIZE));
> > +}
> 
> I didn't expect this function is showing the information by calling pr_warn().
> To me, "show" feels like something for file operations, like memory_min_show().
> 
> What about s/show/dump/ on the name?  It makes it more consistent with the
> subject of this patch, and other similar functions like dump_page() ?
> 
> No strong opinion.  The current name is also ok for me, but I'm just curious your thought.
> 

I just took the inspiration from show_mem(). Initially I was trying to
put these pr_warn in show_mem() but noticed that it was called from more
places than I intend to print this info, so decided to have a separate
function.

Thanks for taking a look.

