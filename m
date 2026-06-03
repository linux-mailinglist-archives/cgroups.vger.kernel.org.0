Return-Path: <cgroups+bounces-16592-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BLWfAUixH2ocowAAu9opvQ
	(envelope-from <cgroups+bounces-16592-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 06:44:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FE2634304
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 06:44:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=H7XQaTxB;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16592-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16592-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 549E8301BF69
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 04:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E093EDE79;
	Wed,  3 Jun 2026 04:44:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E791B3ECBDD
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 04:44:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780461891; cv=none; b=urdivjpA7v2qGUSuN4MNvx/ZrbOPmCM+U6zBH0X/J7fsdZGo2mXZR41AccrtO8LPONk2YA/N5Qz5xpRgei+H3d5OlK1pyZvsbHtXtQwxXa4EpUaaeW/6xCBL023y3p3oPI2JtM82uR1HUQaiSAhksJJo137p+mLFuGRHBA8TKlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780461891; c=relaxed/simple;
	bh=hqb8L/YFdRptP3c4PFdrYdEEmBWuJA9WXpWtLhukVKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLUaW5O221h0hh0VFb+DP/2y2jo93MsxJNk2I7y6P17jM/cwFH8Muh4ggl83CEBJTUrBVScY0A8RFwFknf76Wotwgup/ofIhHJFgx7MXmGBMYnBbxJD7Dv3FR663LUCt6tfjWqOMmKiIOSmNf97+ILb7dAa0Ux4mdxlniv8Vu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H7XQaTxB; arc=none smtp.client-ip=95.215.58.179
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780461886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xj0nD0QD/WNmMfrUXCn9Q5TSzWLvSSnzm5MnjEnC8kQ=;
	b=H7XQaTxB33HBNwRGqtmsRiVQBxgVHF/d9blO8P3L26M95U+NwvCotTQfsN7Tz+YglGBoLI
	kyBaTd4fgoO0wu/LWpkH0Bm5GswE6Yt8fHPDFaSxexO0DfwmxH8WaXqtR1mpPWw9xExSGx
	yJ7IEzomxULbP0YlFDQ5qfIaAnLAtco=
From: Lance Yang <lance.yang@linux.dev>
To: hannes@cmpxchg.org
Cc: lance.yang@linux.dev,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org,
	david@fromorbit.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	qi.zheng@linux.dev,
	yosry.ahmed@linux.dev,
	ziy@nvidia.com,
	liam@infradead.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	vbabka@kernel.org,
	ryncsn@gmail.com,
	zaslonko@linux.ibm.com,
	gor@linux.ibm.com,
	baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	dev.jain@arm.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] mm: switch THP shrinker to list_lru
Date: Wed,  3 Jun 2026 12:44:26 +0800
Message-Id: <20260603044426.54863-1-lance.yang@linux.dev>
In-Reply-To: <ah9PGv12mqai84ES@cmpxchg.org>
References: <ah9PGv12mqai84ES@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,kernel.org,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16592-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:lance.yang@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:david@fromorbit.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:qi.zheng@linux.dev,m:yosry.ahmed@linux.dev,m:ziy@nvidia.com,m:liam@infradead.org,m:usama.arif@linux.dev,m:kas@kernel.org,m:vbabka@kernel.org,m:ryncsn@gmail.com,m:zaslonko@linux.ibm.com,m:gor@linux.ibm.com,m:baolin.wang@linux.alibaba.com,m:baohua@kernel.org,m:dev.jain@arm.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lance.yang@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21FE2634304


On Tue, Jun 02, 2026 at 05:46:02PM -0400, Johannes Weiner wrote:
>On Mon, Jun 01, 2026 at 04:36:52PM +0800, Lance Yang wrote:
>> As the changelog above says, the old queue is per-memcg only, rather
>> than per-memcg-per-node. So reclaim on one node can still walk the whole
>> memcg queue and split underused THPs from other nodes in the same memcg.
>> 
>> But I think the new one can lose reclaim in the cgroup.memory=nokmem
>> case ...
>> 
>> With nokmem, the deferred shrinker can still run from memcg reclaim,
>> because it is SHRINKER_NONSLAB. But the list_lru is no longer per-memcg:
>> 
>> __list_lru_init() clears memcg_aware,
>> 
>> 	if (mem_cgroup_kmem_disabled())
>> 		memcg_aware = false;
>> 
>> so list_lru_from_memcg_idx() falls back to the shared node list:
>> 
>> static inline struct list_lru_one *
>> list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
>> {
>> 	if (list_lru_memcg_aware(lru) && idx >= 0) {
>> [...]
>> 	}
>> 	return &lru->node[nid].lru;
>> }
>> 
>> That makes the shrinker bit unreliable. __list_lru_add() still sets the
>> bit on the memcg passed in, but only when the list goes from empty to
>> non-empty:
>> 
>> bool __list_lru_add(struct list_lru *lru, struct list_lru_one *l,
>> 		    struct list_head *item, int nid,
>> 		    struct mem_cgroup *memcg)
>> {
>> 	if (list_empty(item)) {
>> [...]
>> 		if (!l->nr_items++)
>> 			set_shrinker_bit(memcg, nid, lru_shrinker_id(lru));
>> [...]
>> 		return true;
>> 	}
>> 	return false;
>> }
>> 
>> If memcg A adds the first folio, A gets the bit. If memcg B later adds a
>> folio to the same shared list, B does not get a bit, because the list
>> was already non-empty.
>> 
>> So in the A-first/B-later case, reclaim from B may not call the deferred
>> shrinker at all. The shared list is scanned from memcg reclaim only if
>> reclaim runs from the memcg that has the bit, such as A here, or from
>> global reclaim :)
>> 
>> Anyway, only after the shared list is emptied does the next memcg to add
>> a folio get to be the one with the bit, IIUC :)
>
>Sorry for the delay, this took me a bit to think about. The shrinker
>code is a mess.
>
>I read it the same way you do. And this is true for all list_lru users
>when nokmem is set: we just set random nonsense shrinker bits.
>
>HOWEVER, the generic shrinker code fixes that up by IGNORING random
>shrinker bits like this when !memcg_kmem_online(). And shrinking
>correctly happens only against the shared root queue when the reclaim
>iterator walks root_mem_cgroup.
>
>HOWEVER, the THP shrinker explicitly sets SHRINKER_NONSLAB, which in
>turn overrides the previous override. So yes there is a weirdness: we
>get the root cgroup invocation against the shared queue, and then one
>more time triggered by that random memcg bit.
>
>The most direct fix is to just drop SHRINKER_NONSLAB. It declares
>independence from kmem, which is no longer true.
>
>Cleaning up the shrinker code is left for another day.

Thanks for working on this!

Wondering if this fix trades one problem for another, though ...

Before this series, the deferred split shrinker had a real per-memcg
queue. Even with cgroup.memory=nokmem, memcg reclaim could still scan
that memcg's own deferred_split_queue:

memcg reclaim -> deferred split shrinker -> sc->memcg->deferred_split_queue

With the fix, nokmem + w/o SHRINKER_NONSLAB falls back to a
non-memcg-aware shrinker:

memcg reclaim -> skip deferred split shrinker

root/global reclaim -> deferred split shrinker -> shared list_lru

Is that expected? There woud be no memcg-driven deferred split reclaim
under nokmem, IIUC ...

Not sure what the right fix is, as I am not a memcg expert ...

Cheers, Lance

>Andrew, if there are no objections, can you please fold this?
>
>---
>
>>From 6787efabb9584824c196bf01c517d93aae3764c3 Mon Sep 17 00:00:00 2001
>From: Johannes Weiner <hannes@cmpxchg.org>
>Date: Tue, 2 Jun 2026 17:11:46 -0400
>Subject: [PATCH] mm: switch deferred split shrinker to list_lru fix
>
>Lance Yang points out a weirdness in the list_lru code with
>cgroup.memory=nokmem: in this mode, list_lru collapses to a shared
>per-node list that holds the folios, but __list_lru_add() still sets
>the shrinker bit on the owning memcg.
>
>Usually this is fine, because the generic shrinker code ignores these
>random bits when !memcg_kmem_online(). But the THP shrinker still has
>the SHRINKER_NONSLAB flag set, which specifically declares an
>independence from kmem. As a result, the shrinker fires twice per
>reclaim cycle: one during the regular root cgroup scan, and then one
>more time triggered from whichever memcg got the shrinker bit.
>
>Drop the flag, since it's no longer true. The deferred_split shrinker
>then behaves like every other list_lru-backed shrinker under nokmem,
>including the non-kmem ones (zswap, workingset shadow_nodes): skipped
>from memcg-internal reclaim, driven by global reclaim only.
>
>This needs proper cleaning up on the shrinker and list_lru side, but
>that's scope for a follow-up series. Just make it consistent now.
>
>Reported-by: Lance Yang <lance.yang@linux.dev>
>Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>---
> mm/huge_memory.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index 72f6caf0fec6..aef495891f8c 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -956,8 +956,7 @@ int folio_memcg_alloc_deferred(struct folio *folio)
> static int __init thp_shrinker_init(void)
> {
> 	deferred_split_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
>-						 SHRINKER_MEMCG_AWARE |
>-						 SHRINKER_NONSLAB,
>+						 SHRINKER_MEMCG_AWARE,
> 						 "thp-deferred_split");
> 	if (!deferred_split_shrinker)
> 		return -ENOMEM;
>-- 
>2.54.0
>
>

