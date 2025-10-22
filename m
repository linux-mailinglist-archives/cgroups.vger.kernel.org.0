Return-Path: <cgroups+bounces-10975-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2629BF99B7
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 03:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FFB461D55
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 01:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3059F1DE4E1;
	Wed, 22 Oct 2025 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gBNL3dOQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1C1EB193
	for <cgroups@vger.kernel.org>; Wed, 22 Oct 2025 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096499; cv=none; b=ipUn398WXaZPUrdhJOKltD0szNbjzXmel/7cdSOHvVkRh2sspQ5luVumwKmz9QT18ImvR/qYxl6ovbt6LTsIXfWVyXELBSOFcuASVUcur1de8PamQOMR5k6W8KewUjEyTc0xpWuOFZeBYJ5y1yJ6E3BGQnS8heQ1FbjVGEISlsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096499; c=relaxed/simple;
	bh=2/7l1ZgIOzArMLZCemQFzf/h1l47Bpx65GCwsdEaGWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0JyLV66axw1uJjcLL6BSycAPHZnN0Swt/IUURrrPmllzln2JuirO+0NNiL8KB8mRo5+sE7r/+5fBLaOvhtrm530NF5JX1WOVjZ4FX36g5e8r8AvrGNCs+jFNMOUqHLeuUnOEa6LKvSeLPNzJq3N249Oxx9dgQwpQKD/joM4azs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gBNL3dOQ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 21 Oct 2025 18:28:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761096494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbZbIYaArDkWKOuqj+k7VxfsSO/LaVRV6EW0i8CqmOI=;
	b=gBNL3dOQAR7TzV0Wvx3oL5xWfRBqCvgcdlTkhXXM6WB3p1zSQjOZ5d6mpbXrf9Mamy8tlG
	htlYBhABwh0jdKIY3/hV3Mp+Y0/esz2qacnO0Az2oxEcYKivo+DJ2l3WXF5FD4kUa9/t+O
	rRCR9XWbRsPGDdc+IXNmPV/V7tDUuRM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: manually uninline __memcg_memory_event
Message-ID: <3h26sozqgksxn4fvh7i6qjhtbnrtzit6eluyieyhsvycs3fbs5@ddblsq2crkit>
References: <20251021234425.1885471-1-shakeel.butt@linux.dev>
 <20251022005801.120250-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022005801.120250-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 21, 2025 at 05:58:00PM -0700, SeongJae Park wrote:
> On Tue, 21 Oct 2025 16:44:25 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > The function __memcg_memory_event has been unnecessarily marked inline
> > even when it is not really performance critical. It is usually called
> > to track extreme conditions. Over the time, it has evolved to include
> > more functionality and inlining it is causing more harm.
> > 
> > Before the patch:
> > $ size mm/memcontrol.o net/ipv4/tcp_input.o net/ipv4/tcp_output.o
> >    text    data     bss     dec     hex filename
> >   35645   10574    4192   50411    c4eb mm/memcontrol.o
> >   54738    1658       0   56396    dc4c net/ipv4/tcp_input.o
> >   34644    1065       0   35709    8b7d net/ipv4/tcp_output.o
> > 
> > After the patch:
> > $ size mm/memcontrol.o net/ipv4/tcp_input.o net/ipv4/tcp_output.o
> >    text    data     bss     dec     hex filename
> >   35137   10446    4192   49775    c26f mm/memcontrol.o
> >   54322    1562       0   55884    da4c net/ipv4/tcp_input.o
> >   34492    1017       0   35509    8ab5 net/ipv4/tcp_output.o
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  include/linux/memcontrol.h | 32 ++------------------------------
> >  mm/memcontrol.c            | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+), 30 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index d37e7c93bb8c..8d2e250535a8 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1002,36 +1002,8 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
> >  	count_memcg_events_mm(mm, idx, 1);
> >  }
> >  
> > -static inline void __memcg_memory_event(struct mem_cgroup *memcg,
> > -					enum memcg_memory_event event,
> > -					bool allow_spinning)
> > -{
> > -	bool swap_event = event == MEMCG_SWAP_HIGH || event == MEMCG_SWAP_MAX ||
> > -			  event == MEMCG_SWAP_FAIL;
> > -
> > -	/* For now only MEMCG_MAX can happen with !allow_spinning context. */
> > -	VM_WARN_ON_ONCE(!allow_spinning && event != MEMCG_MAX);
> > -
> > -	atomic_long_inc(&memcg->memory_events_local[event]);
> > -	if (!swap_event && allow_spinning)
> > -		cgroup_file_notify(&memcg->events_local_file);
> > -
> > -	do {
> > -		atomic_long_inc(&memcg->memory_events[event]);
> > -		if (allow_spinning) {
> > -			if (swap_event)
> > -				cgroup_file_notify(&memcg->swap_events_file);
> > -			else
> > -				cgroup_file_notify(&memcg->events_file);
> > -		}
> > -
> > -		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > -			break;
> > -		if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_LOCAL_EVENTS)
> > -			break;
> > -	} while ((memcg = parent_mem_cgroup(memcg)) &&
> > -		 !mem_cgroup_is_root(memcg));
> > -}
> > +void __memcg_memory_event(struct mem_cgroup *memcg,
> > +			  enum memcg_memory_event event, bool allow_spinning);
> >  
> >  static inline void memcg_memory_event(struct mem_cgroup *memcg,
> >  				      enum memcg_memory_event event)
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 1a95049d8b88..93f7c76f0ce9 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1626,6 +1626,37 @@ unsigned long mem_cgroup_size(struct mem_cgroup *memcg)
> >  	return page_counter_read(&memcg->memory);
> >  }
> >  
> > +void __memcg_memory_event(struct mem_cgroup *memcg,
> > +			  enum memcg_memory_event event, bool allow_spinning)
> 
> Seems this function is called only from memcontrol.c.  Why not making it a
> static function?

There is a recent code where this is called (indirectly) from networking
stack for MEMCG_SOCK_THROTTLED.

> 
> > +{
> > +	bool swap_event = event == MEMCG_SWAP_HIGH || event == MEMCG_SWAP_MAX ||
> > +			  event == MEMCG_SWAP_FAIL;
> > +
> > +	/* For now only MEMCG_MAX can happen with !allow_spinning context. */
> > +	VM_WARN_ON_ONCE(!allow_spinning && event != MEMCG_MAX);
> > +
> > +	atomic_long_inc(&memcg->memory_events_local[event]);
> > +	if (!swap_event && allow_spinning)
> > +		cgroup_file_notify(&memcg->events_local_file);
> > +
> > +	do {
> > +		atomic_long_inc(&memcg->memory_events[event]);
> > +		if (allow_spinning) {
> > +			if (swap_event)
> > +				cgroup_file_notify(&memcg->swap_events_file);
> > +			else
> > +				cgroup_file_notify(&memcg->events_file);
> > +		}
> > +
> > +		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > +			break;
> > +		if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_LOCAL_EVENTS)
> > +			break;
> > +	} while ((memcg = parent_mem_cgroup(memcg)) &&
> > +		 !mem_cgroup_is_root(memcg));
> > +}
> > +EXPORT_SYMBOL(__memcg_memory_event);
> 
> Also, seems there is no reason to export this symbol?

The networking code needs this export.

Thanks for taking a look.

