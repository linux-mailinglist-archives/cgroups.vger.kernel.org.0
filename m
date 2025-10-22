Return-Path: <cgroups+bounces-10977-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE6DBF9B1A
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 04:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EA919A8401
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 02:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6261421A459;
	Wed, 22 Oct 2025 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9sc0WbR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8C21019C;
	Wed, 22 Oct 2025 02:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761099353; cv=none; b=Gyj4+20q5/vwp0Oy8C8GodZ/XpbsHz2nZDXTvsRhFEDPFt+SMapWTxYqVq9Vh5rhoY5jgiwhtkJ0Zx+qUQJFpbkJNCxpN6+/m+ORHfDCapRJGY2hsa3Qg07LZ46a+bi+/p/zWnKqt4eZz37EkSH5YwCnOIxpF23aqhuQ6retfuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761099353; c=relaxed/simple;
	bh=K8KyPpuWFb8QcJ7XXOwUi5j8hUUNg/w4R0Rxk5mqPqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1dd5rUox79LdoK5FWvOfnBuIdMEsxrF7sijVmqkhKLpGKBBWYD/etwjNghHV3OUVgctfwT6Vd3xg09vlq69TmkEd1XCewCbLb4+m1oJPaG92zPXf2p7qdEsqs2TqIc2lrCQ2e+HNK39f8saJcDMfBxSRScI/nkf3w1RoW8l64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9sc0WbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA5EC4CEF1;
	Wed, 22 Oct 2025 02:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761099352;
	bh=K8KyPpuWFb8QcJ7XXOwUi5j8hUUNg/w4R0Rxk5mqPqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z9sc0WbR5vWlhZcCkAalZUcE8a6choXCT7cZiw3CKT+J/5fC9T7v5u8AnSqXnYbsV
	 P7P2b6ik+JssEgaNDkNe2XnMW4PsoELzAWa2A70O8bYwKlVoCYveujBcfn2DN4GtuH
	 MtHpRjUE6qp40ZhvgbtLft0TF6MRQ4LrPNFHLLcWBElzO1sWuP5sZDzcxyqfyB6kKd
	 elTIYyj9yvVuubI/W/MSif1lULq9VXO5m4e9ogOmWMceGRX4NKD8H9fwlcT7ds2NBq
	 W+tjZ3+hUcvB8bsnj7q6LbFpYZppFs72qrTfn98svYFY45qzgLUFnjHr+RByRQO4aA
	 r1dgolbERzVsQ==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: manually uninline __memcg_memory_event
Date: Tue, 21 Oct 2025 19:15:49 -0700
Message-ID: <20251022021549.129413-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3h26sozqgksxn4fvh7i6qjhtbnrtzit6eluyieyhsvycs3fbs5@ddblsq2crkit>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Oct 2025 18:28:02 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Tue, Oct 21, 2025 at 05:58:00PM -0700, SeongJae Park wrote:
> > On Tue, 21 Oct 2025 16:44:25 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > 
> > > The function __memcg_memory_event has been unnecessarily marked inline
> > > even when it is not really performance critical. It is usually called
> > > to track extreme conditions. Over the time, it has evolved to include
> > > more functionality and inlining it is causing more harm.
> > > 
> > > Before the patch:
> > > $ size mm/memcontrol.o net/ipv4/tcp_input.o net/ipv4/tcp_output.o
> > >    text    data     bss     dec     hex filename
> > >   35645   10574    4192   50411    c4eb mm/memcontrol.o
> > >   54738    1658       0   56396    dc4c net/ipv4/tcp_input.o
> > >   34644    1065       0   35709    8b7d net/ipv4/tcp_output.o
> > > 
> > > After the patch:
> > > $ size mm/memcontrol.o net/ipv4/tcp_input.o net/ipv4/tcp_output.o
> > >    text    data     bss     dec     hex filename
> > >   35137   10446    4192   49775    c26f mm/memcontrol.o
> > >   54322    1562       0   55884    da4c net/ipv4/tcp_input.o
> > >   34492    1017       0   35509    8ab5 net/ipv4/tcp_output.o
> > > 
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > ---
> > >  include/linux/memcontrol.h | 32 ++------------------------------
> > >  mm/memcontrol.c            | 31 +++++++++++++++++++++++++++++++
> > >  2 files changed, 33 insertions(+), 30 deletions(-)
> > > 
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index d37e7c93bb8c..8d2e250535a8 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -1002,36 +1002,8 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
> > >  	count_memcg_events_mm(mm, idx, 1);
> > >  }
> > >  
> > > -static inline void __memcg_memory_event(struct mem_cgroup *memcg,
> > > -					enum memcg_memory_event event,
> > > -					bool allow_spinning)
> > > -{
> > > -	bool swap_event = event == MEMCG_SWAP_HIGH || event == MEMCG_SWAP_MAX ||
> > > -			  event == MEMCG_SWAP_FAIL;
> > > -
> > > -	/* For now only MEMCG_MAX can happen with !allow_spinning context. */
> > > -	VM_WARN_ON_ONCE(!allow_spinning && event != MEMCG_MAX);
> > > -
> > > -	atomic_long_inc(&memcg->memory_events_local[event]);
> > > -	if (!swap_event && allow_spinning)
> > > -		cgroup_file_notify(&memcg->events_local_file);
> > > -
> > > -	do {
> > > -		atomic_long_inc(&memcg->memory_events[event]);
> > > -		if (allow_spinning) {
> > > -			if (swap_event)
> > > -				cgroup_file_notify(&memcg->swap_events_file);
> > > -			else
> > > -				cgroup_file_notify(&memcg->events_file);
> > > -		}
> > > -
> > > -		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > > -			break;
> > > -		if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_LOCAL_EVENTS)
> > > -			break;
> > > -	} while ((memcg = parent_mem_cgroup(memcg)) &&
> > > -		 !mem_cgroup_is_root(memcg));
> > > -}
> > > +void __memcg_memory_event(struct mem_cgroup *memcg,
> > > +			  enum memcg_memory_event event, bool allow_spinning);
> > >  
> > >  static inline void memcg_memory_event(struct mem_cgroup *memcg,
> > >  				      enum memcg_memory_event event)
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 1a95049d8b88..93f7c76f0ce9 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1626,6 +1626,37 @@ unsigned long mem_cgroup_size(struct mem_cgroup *memcg)
> > >  	return page_counter_read(&memcg->memory);
> > >  }
> > >  
> > > +void __memcg_memory_event(struct mem_cgroup *memcg,
> > > +			  enum memcg_memory_event event, bool allow_spinning)
> > 
> > Seems this function is called only from memcontrol.c.  Why not making it a
> > static function?
> 
> There is a recent code where this is called (indirectly) from networking
> stack for MEMCG_SOCK_THROTTLED.

Thank you for enlightening me.  Apparently the code is from
https://lore.kernel.org/20251016161035.86161-1-shakeel.butt@linux.dev.

> 
> > 
> > > +{
> > > +	bool swap_event = event == MEMCG_SWAP_HIGH || event == MEMCG_SWAP_MAX ||
> > > +			  event == MEMCG_SWAP_FAIL;
> > > +
> > > +	/* For now only MEMCG_MAX can happen with !allow_spinning context. */
> > > +	VM_WARN_ON_ONCE(!allow_spinning && event != MEMCG_MAX);
> > > +
> > > +	atomic_long_inc(&memcg->memory_events_local[event]);
> > > +	if (!swap_event && allow_spinning)
> > > +		cgroup_file_notify(&memcg->events_local_file);
> > > +
> > > +	do {
> > > +		atomic_long_inc(&memcg->memory_events[event]);
> > > +		if (allow_spinning) {
> > > +			if (swap_event)
> > > +				cgroup_file_notify(&memcg->swap_events_file);
> > > +			else
> > > +				cgroup_file_notify(&memcg->events_file);
> > > +		}
> > > +
> > > +		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > > +			break;
> > > +		if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_LOCAL_EVENTS)
> > > +			break;
> > > +	} while ((memcg = parent_mem_cgroup(memcg)) &&
> > > +		 !mem_cgroup_is_root(memcg));
> > > +}
> > > +EXPORT_SYMBOL(__memcg_memory_event);
> > 
> > Also, seems there is no reason to export this symbol?
> 
> The networking code needs this export.
> 
> Thanks for taking a look.

Again, thank you for clarifying.

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

