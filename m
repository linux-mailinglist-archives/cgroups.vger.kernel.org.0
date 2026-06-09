Return-Path: <cgroups+bounces-16754-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CCnnCRGYJ2o9zQIAu9opvQ
	(envelope-from <cgroups+bounces-16754-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 06:35:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7121B65C398
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 06:35:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lge.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16754-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16754-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE72C30376AA
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 04:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40959373C1E;
	Tue,  9 Jun 2026 04:34:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28B3655DB
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 04:34:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780979659; cv=none; b=C1hDpMmk+fQ0lIpVsWP/EoTlhcaZSGyCgiiPcgK9IMIj5wcJwUjZHi7uzajPg9tgvQWnKpJfgO1t1W2PsKRZJ5FItM4rLRkcmr3XBN99cAGVA61CzAZT72Un2kH48acBtTlTb1p/N5+AZQGc/mYozMHRkx3piYUogTIK373ICHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780979659; c=relaxed/simple;
	bh=+hQ+RWuqaS/Jpfm/1pJ71r7akfcY/Ua/eGAmRinOwPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVkFGagZuAWDSlDdiYkQkwYNus/HIoXJHx/k3LDvgjFrCJ15YLebldcMT19cQDLr9pJls2b9pARW3Ve8eLiey2vypLmlgojtqMOzagUHDe7TZRyO9FOvmA+ZY03+850+5MhiGcfQqZGQ4jZ4TU/o7T+R9wuQb/fe0e0/33Vjmnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 9 Jun 2026 13:19:13 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 9 Jun 2026 13:19:13 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Hao Jia <jiahao.kernel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>, mhocko@kernel.org,
	tj@kernel.org, mkoutny@suse.com, roman.gushchin@linux.dev,
	Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>, chrisl@kernel.org,
	kasong@tencent.com, baoquan.he@linux.dev
Subject: Re: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
Message-ID: <aieUQUBHI+E3uNPW@yjaykim-PowerEdge-T330>
References: <6deeaea7-3cd1-4403-29fc-d2dc55c297f8@gmail.com>
 <aiBqzOtEv5iAC_qC@google.com>
 <CAKEwX=OhxUxRCEfvZMnWzXy=Fa4jgzL3DuP-RmaVzdK65m4bew@mail.gmail.com>
 <6db27a22-cc7a-9a94-db3f-c912fd39aa32@gmail.com>
 <CAO9r8zM4SDdTgz9L2s1VfXL8K2VBjMD9ej2BTDxaGge1t2+quA@mail.gmail.com>
 <aicJBVT4pBvmyooT@linux.dev>
 <aicZ-5GX9De3MAU7@linux.dev>
 <CAO9r8zNBJ-BsXyKFveA92jbwMu63uFVTY5CuT4fRHTBVcOjhPw@mail.gmail.com>
 <aictKA0XWMWbxFdN@linux.dev>
 <CAO9r8zPvCaCqvoUhPdAN5Oi_Sj0mK-t7DJhOOz3Xf1DT-Wrgcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9r8zPvCaCqvoUhPdAN5Oi_Sj0mK-t7DJhOOz3Xf1DT-Wrgcw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:shakeel.butt@linux.dev,m:jiahao.kernel@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:roman.gushchin@linux.dev,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:chrisl@kernel.org,m:kasong@tencent.com,m:baoquan.he@linux.dev,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16754-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,cmpxchg.org,kernel.org,suse.com,linux-foundation.org,vger.kernel.org,kvack.org,lixiang.com,tencent.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7121B65C398

On Mon, Jun 08, 2026 at 03:27:07PM -0700, Yosry Ahmed wrote:

+Chris +Kairui +Baoquan

Hello

Thanks for inviting me to the discussion, Shakeel.

> > > > Youngjun is working on swap tiers. At the moment he is more interested in
> > > > allowing a specific swap device to a memcg or not. I can imagine in future there
> > > > will be use-cases where there will be a need to demote data on higher tier swap
> > > > to lower tier swap. What would be the appropriate interface?

Speaking of my work on swap tiers, I recently submitted a patch and am
currently considering memcg integration:
https://lore.kernel.org/linux-mm/20260527062247.3440692-1-youngjun.park@lge.com/

The future use-cases imagined above seem to align with this
direction. (BTW, I am currently waiting for reviews/feedback from the memcg
folks on this patch. Any reviews would be highly appreciated!)

We could potentially assign a target tier
for writeback within the existing memory.zswap.writeback interface. 

For instance, '0' could mean disabled, while non-zero values could represent
specific tiers, which would maintain backward compatibility with the current
version. Alternatively, if zswap is treated as the default top tier, 
the `memory.swap.tiers` interface could potentially replace `memory.zswap.writeback`.

Furthermore, this could be expanded so that each swap tier can demote data
user-triggered demotion between swap tiers.

Based on the current patch's ideas combined with my swap tiers concept:

Assuming a hierarchy like:
zswap -> tier1 (SSD swap) -> tier2 (HDD swap) -> tier3 (Network swap)

We could configure the active tiers via a setting like `memory.swap.tiers`
(tier2 enabled, tier3 enabled).

For example, the concept of `echo "100M zswap_writeback_only > memory.reclaim"`
could be extended. A user could run `echo "100M tier2 > memory.reclaim"`
to explicitly trigger demotion from tier2 to tier3.
(BTW, if we combine these features, my personal preference for the keyword
format would be `<size> <demote_prefix><tier_name>`. I think it would be
better to explicitly indicate that it is a swap demotion by using a specific
prefix followed by the tier name. 
Or make demote prefix another key is also possible)

So, the whole picture would look something like this:
- memory.swap.tiers		: Interface for configuring the tier mask.
- memory.reclaim                : Entry point for user-triggered demotion.

> > > Things will probably get more
> > > blurry with memory tiers and compressed memory nodes though.
> >
> > I think there will still be distinction between byte addressable and fault on
> > access devices.
> 
> Yeah, I think it makes sense to define "swap" as fault on access
> (zswap, SSD, etc), and memory tiers as byte-addressable (even if you
> put an SSD behind CXL and make it byte-addressable). But I also
> remember seeing discussions about unifying memory tiers and swap in a
> way, and it makes sense from a reclaim perspective (swap or demote
> first?).


> > > > will be use-cases where there will be a need to demote data on higher tier swap
> > > > to lower tier swap. What would be the appropriate interface?
> > > >
> > > > BTW does zswap folks think of zswap as a top swap tier or something different?
> > >
> > > I haven't been following the swap tiers work closely, but personally I
> > > do think of zswap as a top swap tier.

Regarding zswap's position, I agree it needs to be defined as the default,
top-most tier in swap_tier. In my early RFC, I allocated a separate tier
specifically for zswap:
(https://lore.kernel.org/linux-mm/20251109124947.1101520-3-youngjun.park@lge.com/)

> > Same for me though I imagine swap tiers would introduce some duplication i.e.
> > different way (interface) to set limits for swap tiers for a given memcg.
> >

I also agree with the concern about interface duplication. We will eventually
need a mechanism to control swap amounts per tier, which requires thinking
about its relationship with swap.max. (I raised this as an open question in
my early RFC).
https://lore.kernel.org/linux-mm/20251109124947.1101520-1-youngjun.park@lge.com/
(Further Discussion and Open Questions Part)
However, since this feature is necessary anyway, wouldn't the proposed
interface be acceptable without causing conflicts at this early stage?

Additionally, `memory.zswap.writeback` seems redundant. Restricting a cgroup
to only use the zswap tier (assuming it's the first tier) is practically
identical to disabling `memory.zswap.writeback` (correct me if I'm wrong).
But there is no problem to integrate it as I think
e.g  `memory.zswap.writeback` could internally act as an alias for setting `memory.swap.tier` to 'zswap only'.

BR,
Youngjun Park

