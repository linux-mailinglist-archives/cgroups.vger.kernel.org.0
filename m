Return-Path: <cgroups+bounces-15282-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFXzN/Wu3WlPhwkAu9opvQ
	(envelope-from <cgroups+bounces-15282-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 05:05:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4DB3F5289
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 05:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23EE230333A1
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 03:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A557D3168EB;
	Tue, 14 Apr 2026 03:05:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06CF313277
	for <cgroups@vger.kernel.org>; Tue, 14 Apr 2026 03:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776135914; cv=none; b=ITdF9aca2FyL14zI/6gXeNPRcLLveFgjUKkyfFKKHJej3b0Qt/Bjn743hGKr2WI0aSqfglOoRzJBLTbRJOM0BxNik/LP7oWhnUco4A/g4p0hFr/TGBxozgIfQ6txHMAbVehYeb6PPNBl/DQ8Zp3D4esRZL/PUHHFTudxV4d/nr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776135914; c=relaxed/simple;
	bh=iIkey2oim3PlO7vo+3FK0G8oXI2A0hzPeh0Tb+R90y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC0YAHqiY+1FR42g/CjjNJYol3fvW62MT5j1oIAt5HZloQ9IfpIFXxa353Wwg26oPYCZ6XF5o5AxMqMD6z78TwWkPQfg89/IJpFKz0QRvA/9OH1cEq0Wf/tXPc39xHg/0RwB5xpkHsKWBq8ToP7JPDV14zY2PPdEm1I/9/woAvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 14 Apr 2026 11:50:09 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 14 Apr 2026 11:50:08 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com,
	cgroups@vger.kernel.org, chengming.zhou@linux.dev,
	chrisl@kernel.org, corbet@lwn.net, david@kernel.org,
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org,
	hughd@google.com, jannh@google.com, joshua.hahnjy@gmail.com,
	lance.yang@linux.dev, lenb@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev,
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com,
	peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org,
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org,
	ryan.roberts@arm.com, shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com, surenb@google.com, tglx@kernel.org,
	vbabka@suse.cz, weixugc@google.com, ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev, yuanchu@google.com,
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com,
	riel@surriel.com
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
Message-ID: <ad2rYH9tUPthHFoj@yjaykim-PowerEdge-T330>
References: <20260320192735.748051-1-nphamcs@gmail.com>
 <acQrQYHJgqof0yx4@yjaykim-PowerEdge-T330>
 <CAKEwX=NnHxpQKp9qBg2=r_euyjgxw2nHXjbgof3MymHTgJmRAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=NnHxpQKp9qBg2=r_euyjgxw2nHXjbgof3MymHTgJmRAQ@mail.gmail.com>
X-Spamd-Result: default: False [0.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15282-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C4DB3F5289
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 06:40:44PM -0700, Nhat Pham wrote:

Hello Nhat!

> > 1. Modularization
> >
> > You removed CONFIG_* and went with a unified approach. I recall
> > you were also considering a module-based structure at some point.
> > What are your thoughts on that direction?
> >
>
> The CONFIG-based approach was a huge mess. It makes me not want to
> look at the code, and I'm the author :)
>
> > If we take that approach, we could extend the recent swap ops
> > patchset (https://lore.kernel.org/linux-mm/20260302104016.163542-1-bhe@redhat.com/)
> > as follows:
> > - Make vswap a swap module
> > - Have cluster allocation functions reside in swapops
> > - Enable vswap through swapon
>
> Hmmmmm.

I think this would be a happy world, but I wonder what others think.
Anyway, I'm looking forward to the future direction.

> > 2. Flash-friendly swap integration (for my use case)
> >
> > I've been thinking about the flash-friendly swap concept that
> > I mentioned before and recently proposed:
> > (https://lore.kernel.org/linux-mm/aZW0voL4MmnMQlaR@yjaykim-PowerEdge-T330/)
> >
> > One of its core functions requires buffering RAM-swapped pages
> > and writing them sequentially at an appropriate time -- not
> > immediately, but in proper block-sized units, sequentially.
> >
> > This means allocated offsets must essentially be virtual, and
> > physical offsets need to be managed separately at the actual
> > write time.
> >
> > If we integrate this into the current vswap, we would either
> > need vswap itself to handle the sequential writes (bypassing
> > the physical device and receiving pages directly), or swapon
> > a swap device and have vswap obtain physical offsets from it.
> > But since those offsets cannot be used directly (due to
> > buffering and sequential write requirements), they become
> > virtual too, resulting in:
> >
> >   virtual -> virtual -> physical
> >
> > This triple indirection is not ideal.
> >
> > However, if the modularization from point 1 is achieved and
> > vswap acts as a swap device itself, then we can cleanly
> > establish a:
> >
> >   virtual -> physical
>
> I read that thread sometimes ago. Some remarks:
>
> 1. I think Christoph has a point. Seems like some of your ideas ( are
> broadly applicable to swap in general. Maybe fixing swap infra
> generally would make a lot of sense?

Broadly speaking, there are two main ideas:
1. Swap I/O buffering (which is also tied to cluster management issues)
2. Deduplication

Are you leaning towards the view that these two should be placed in a
higher layer?

> 2. Why do we need to do two virtual layers here? For example, If you
> want to buffer multiple swap outs and turn them into a sequential
> request, you can:
>
> a. Allocate virtual swap space for them as you wish. They don't even
> need to be sequential.
>
> b. At swap_writeout() time, don't allocate physical swap space for
> them right away. Instead, accumulate them into a buffer. You can add a
> new virtual swap entry type to flag it if necessary.
>
> c. Once that buffer reaches a certain size, you can now allocate
> contiguous physical swap space for them. Then flush etc. You can flush
> at swap_writeout() time, or use a dedicated threads etc.

I initially thought implementing this in vswap would be complicated
(due to the ripple effects of altering behavior at swap_writeout timing),
but it seems entirely possible!

1. We could change the behavior (e.g., buffering) at vswap_alloc_swap_slot
   timing by checking things like the si type.
2. Additionally, if we can handle the cluster data structures and
   mechanisms in the swap_info_struct privately, a virtual-to-physical
   one-direction approach seems feasible.
   (Come to think of it, it might be better to refactor the infra to let
   other modules handle this, potentially removing the swap_info_struct
   mechanism entirely. Just imagination ;) )

> Deduplication sounds like something that should live at a lower layer
> - I was thinking about it for zswap/zsmalloc back then. I mean, I
> assume you don't want content sharing across different swap media? :)
> Something along the line of:
>
> 1. Maintain an content index for swapped out pages.
>
> 2. For the swap media that support deduplication, you'll need to add
> some sort of reference count (more overhead ew).
>
> 3. Each time we swapped out, we can content-check to see if the same
> piece of conent has been swapped out before. If so, set the vswap
> backend to the physical location of the data, increment some sort of
> reference count (perhaps we can use swap count) of the older entry,
> and have the swap type point to it.

As for reference count management, applying it loosely might be a good
approach. Instead of strictly managing the lifecycle of the dedup contents
with refcounts, we could just periodically clean up the hash. This also
has the benefit of reducing I/O for the same swap content compared to
deleting it immediately.

> But have you considered the implications of sharing swap data like
> this? I need to read the paper you cite - seems like a potential fun
> read. But what happen when these two pages that share the content
> belong to two different cgroups? How does the
> charging/uncharging/charge transferring story work? That's one of the
> things that made me pause when I wanted to implement deduplication for
> zswap/zsmalloc. Zram does not charge memory towards cgroup, but zswap
> does, so we'll need to handle this somehow, and at that point all the
> complexity might no longer be worth it.

Since our private swap device is similar to ZRAM, I hadn't considered
the charging aspect. It is indeed a complex issue.

If it goes into ZSWAP, there would definitely be a clear advantage of
seeing dedup benefits across all swap devices. It's a technically
interesting area, and I'd like to discuss it in a separate thread if
I have more ideas or thoughts.

Just a thought that comes to mind here: if vswap becomes modularized,
how about doing memcg charging for this entire area? 
(Come to think of it, to fully benefit from vswap modularization,
zswap should also be applied within its scope.)

Best regards,
Youngjun Park

