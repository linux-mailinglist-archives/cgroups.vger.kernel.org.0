Return-Path: <cgroups+bounces-16509-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICZaAIhFHWrdYAkAu9opvQ
	(envelope-from <cgroups+bounces-16509-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 10:40:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F5461B9E0
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 10:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCD86305FB28
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 08:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AD6348C74;
	Mon,  1 Jun 2026 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mJvCT03g"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9263403F3
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303028; cv=none; b=MY8tI8JjJ4CCzpo1yqzRcn8BvqDv88MwFq7tBiOL0oubENZ9Tp+jEjqGXBELoYucO4UVB9n+waZyULxWYf+NbU7UHV7xqhbjSN38LTzZ53qSEMfliCRVdtubD5aR+xiTjYdV3uJcKBaox1XuPZQGeo2Si0OYTZmyHoIHwtE6r7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303028; c=relaxed/simple;
	bh=6bMwlshmv+PoBohdQWd+c60QMtm1VS1nbOSHY4vA/Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHgG/2StXcFpjnCSnrGIAQe3NLZ500jY0CqQnmS9rJJbhRXnSsNesVHXj+K19WFfolAqDyVlg2OqOAJDEYOxHR6uc5GqBVLZZuNBEf3Xd9u/1627Ypuq7nsSk8BJjdp8WYl6SfHOVHdS7zK/s6vdqRfVTARTVOR7RKm4kUSFkeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mJvCT03g; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780303024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1cAnVe0vgR161tCTvMa190G3YVoUsIA3Fi5oEWLr4Q=;
	b=mJvCT03gZw/QyQXXfMaQSG0rfbdxV7lvTw8dOCiC8I2+Vc8xHutXhZ6lgQj40Am+N2vkpu
	d5p0utl7Wis48n4hwB0IfxxY0StkNOEwRg7hExKJh99TXsKpRhh3IcyeYGYWkZq58QedRG
	VlqnyqZSrPMfb0daeTXDM4LvlMqyxeE=
From: Lance Yang <lance.yang@linux.dev>
To: hannes@cmpxchg.org
Cc: akpm@linux-foundation.org,
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
	lance.yang@linux.dev,
	npache@redhat.com,
	ryan.roberts@arm.com,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] mm: switch THP shrinker to list_lru
Date: Mon,  1 Jun 2026 16:36:52 +0800
Message-Id: <20260601083652.59539-1-lance.yang@linux.dev>
In-Reply-To: <20260527204757.2544958-1-hannes@cmpxchg.org>
References: <20260527204757.2544958-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16509-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_TWELVE(0.00)[28];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 85F5461B9E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Johannes,

On Wed, May 27, 2026 at 04:45:07PM -0400, Johannes Weiner wrote:
>This is version 5 of switching the THP shrinker to list_lru.
>
>Core of the new version is the list_lru/set_shrinker_bit fix up front,
>which minimally affects later patches; and a rebase onto the latest
>mm-unstable - replaced alloc_swap_folio() with __swap_cache_alloc().
>
>The changes seemed small enough that *I chose to keep the review tags
>from v4*. Please shout if you object to this!
>
>Changes in v5:
>- patch 1 is a new fix for a very old, pre-existing set_shrinker_bit()
>  problem in list_lru, where the bit can be set on a dying child memcg
>  instead of the ancestor that actually received the item. Pointed out
>  by Usama Arif and Sashiko; fix it first to make it minimally
>  backportable and so the conversion is safe.
>- patches 6 and 9 adapt to that fix's new memcg-by-reference
>  lock_list_lru_of_memcg() signature
>- collapse_huge_page(): propagate folio_memcg_alloc_deferred() failure
>  as SCAN_ALLOC_HUGE_PAGE_FAIL instead of leaking SCAN_SUCCEED and
>  falsely reporting a successful MADV_COLLAPSE (Usama Arif, Sashiko)
>- deferred_split_isolate(): fix a UAF by reading folio state before
>  list_lru_isolate(); once removed, a racing folio_put() frees the
>  folio via the lockless list_empty() check while we still touch its
>  flags and stats (Sashiko)
>- rebased to mm-unstable of 2026-05-27, which simplifies the flatten
>  prep patch (now anon-only, as alloc_swap_folio() was folded into the
>  new __swap_cache_alloc()) and moves the swap-side
>  folio_memcg_alloc_deferred() hook into __swap_cache_alloc(). Kairui,
>  I would appreciate an eyeball on that.
>
>Changes in v4:
>- guard folio_memcg_alloc_deferred() with mem_cgroup_disabled() to fix
>  NULL deref in __memcg_list_lru_alloc() when booting with
>  cgroup_disable=memory (e.g., kdump capture kernel) -- reported and
>  tested by Mikhail Zaslonko on s390 and x86
>- flatten if (folio) branches in alloc_swap_folio() and alloc_anon_folio()
>  in a prep patch so the list_lru allocation additions are a clean minimal
>  diff (Lorenzo)
>- folio_memcg_alloc_deferred() moved out of alloc_charge_folio() into the
>  anon-only collapse_huge_page() path; collapse_file() shares that helper
>  but its pages don't go on the THP shrinker queue (David)
>- guard folio_memcg_alloc_deferred() with order > 1; mTHPs below order-2
>  can't be queued on the deferred split list (David)
>- make deferred_split_lru static, hide behind folio_memcg_alloc_deferred()
>  wrapper with GFP_KERNEL (Lorenzo)
>- rename l -> lru throughout huge_memory.c (Lorenzo)
>- kdoc for folio_memcg_list_lru_alloc() (Lorenzo)
>- list_lru_lock_irq()/unlock_irq()/add_irq() irq-disabling variants;
>  use list_lru_add_irq() in deferred_split_scan() (Lorenzo)
>- reorder shrinker_free() before list_lru_destroy() (Lorenzo)
>
>Changes in v3:
>- dedicated lockdep_key for irqsafe deferred_split_lru.lock (syzbot)
>- conditional list_lru ops in __folio_freeze_and_split_unmapped() (syzbot)
>- annotate runs of inscrutable false, NULL, false function arguments (David)
>- rename to folio_memcg_list_lru_alloc() (David)
>
>Changes in v2:
>- explicit rcu_read_lock() in __folio_freeze_and_split_unmapped() (Usama)
>- split out list_lru prep bits (Dave)
>
>The open-coded deferred split queue has issues. It's not NUMA-aware
>(when cgroup is enabled), and it's more complicated in the callsites
>interacting with it. Switching to list_lru fixes the NUMA problem and
>streamlines things. It also simplifies planned shrinker work.
>
>Patch 1 fixes a pre-existing list_lru bug where the shrinker bit is
>set on the caller's memcg rather than the ancestor whose sublist the
>item actually lands on after a walk-up. Standalone, backportable; the
>rest of the series depends on it.
>
>Patches 2-5 are cleanups and small refactors in list_lru code. They're
>basically independent, but make the THP shrinker conversion easier.
>
>Patch 6 extends the list_lru API to allow the caller to control the
>locking scope. The THP shrinker has private state it needs to keep
>synchronized with the LRU state.
>
>Patch 7 extends the list_lru API with a convenience helper to do
>list_lru head allocation (memcg_list_lru_alloc) when coming from a
>folio. Anon THPs are instantiated in several places, and with the
>folio reparenting patches pending, folio_memcg() access is now a more
>delicate dance. This avoids having to replicate that dance everywhere.
>
>Patch 8 flattens the alloc_anon_folio() retry loop so the next patch's
>list_lru hook lands as a clean addition rather than nested deep inside
>an if (folio) block.
>
>Patch 9 finally switches the deferred_split_queue to list_lru.

As the changelog above says, the old queue is per-memcg only, rather
than per-memcg-per-node. So reclaim on one node can still walk the whole
memcg queue and split underused THPs from other nodes in the same memcg.

But I think the new one can lose reclaim in the cgroup.memory=nokmem
case ...

With nokmem, the deferred shrinker can still run from memcg reclaim,
because it is SHRINKER_NONSLAB. But the list_lru is no longer per-memcg:

__list_lru_init() clears memcg_aware,

	if (mem_cgroup_kmem_disabled())
		memcg_aware = false;

so list_lru_from_memcg_idx() falls back to the shared node list:

static inline struct list_lru_one *
list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
{
	if (list_lru_memcg_aware(lru) && idx >= 0) {
[...]
	}
	return &lru->node[nid].lru;
}

That makes the shrinker bit unreliable. __list_lru_add() still sets the
bit on the memcg passed in, but only when the list goes from empty to
non-empty:

bool __list_lru_add(struct list_lru *lru, struct list_lru_one *l,
		    struct list_head *item, int nid,
		    struct mem_cgroup *memcg)
{
	if (list_empty(item)) {
[...]
		if (!l->nr_items++)
			set_shrinker_bit(memcg, nid, lru_shrinker_id(lru));
[...]
		return true;
	}
	return false;
}

If memcg A adds the first folio, A gets the bit. If memcg B later adds a
folio to the same shared list, B does not get a bit, because the list
was already non-empty.

So in the A-first/B-later case, reclaim from B may not call the deferred
shrinker at all. The shared list is scanned from memcg reclaim only if
reclaim runs from the memcg that has the bit, such as A here, or from
global reclaim :)

Anyway, only after the shared list is emptied does the next memcg to add
a folio get to be the one with the bit, IIUC :)

Hopefully I didn't miss somthing important ...

Cheers, Lance

