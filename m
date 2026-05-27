Return-Path: <cgroups+bounces-16368-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOfkI5pYF2oPBQgAu9opvQ
	(envelope-from <cgroups+bounces-16368-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:48:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FEB5EA2D6
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 962DD305B12C
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 20:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB223BB119;
	Wed, 27 May 2026 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Dw8EFflU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2538AC85
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914893; cv=none; b=otfPQN62N3trYsBdC7yGdmqTZclO8alzcw4S3Cr22vPoIVXc4T0c0+MiB8d3YkmKPNvX8QkqyvqEoCw7WhpQ5pib+UvspZke5/EGnQ/InCBCewneAH5VRfqwhAf7bC2cYXIAOSiZNGKaXvG1VVhwt9JFgMoCM1Rub0CsEFAH5nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914893; c=relaxed/simple;
	bh=MIuXgMFArpJ+cS5wbI6q+vK/l639f8p29OZXV4dDPEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HLQPMVJKT46u8cjMtH0+Mp+6DNuX2K/4hq37kf6nbfBfZzyfes6e78LGcmLUeq4gFaFwfwC86jbOvyYXF1Ie84z0EnQ3xswmy0XYU8mys+pSx60A1prSizWElR2IuwZNVpODZ4Z2PGzZfYjtWO/SI/u8WSz4CP2ZWMdFEmTqPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Dw8EFflU; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8b5cda2dab9so117490806d6.0
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779914887; x=1780519687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9SkCbStG4zFLs0cKdzQpGVzBthUS3KzpWOEaBxS/LNo=;
        b=Dw8EFflUCM+KLy3zt/KATtOznCfJvdTqTfkTdsD2IhVIOoGJ1DkpGOdIiodqL3Hx4S
         b0VXh1EbHr8L2zhinkuR13zIZ1xiGmowMKc9mFheDCYg2qINOCFDxeIMsQPy7dByOqCe
         86OdRG89P6vt9BK7SXME2LE3MHTy+v7j496KyEQhDeMBX1Wn3nQU1/z3dQeiaPp2Bsbx
         TfOqtjAYg5AfzcLuo+HzBdNpYd5Nrr4s/LvD2bGMF5pAANwfj3B286t6Gk3O7EoxTMTY
         0VWpASg78e5yAEr8QCXcBSo+Qy8800a9jaEZg1Ur+0eYfyHBAKoDBOnDMc9OMFyWAfvf
         SYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779914887; x=1780519687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SkCbStG4zFLs0cKdzQpGVzBthUS3KzpWOEaBxS/LNo=;
        b=iucBApWPQEF7vlpoe1ufi6XudX3StsEVxViqyMgy17CHIYi9C/OdQ1jMKZBxj1rP+F
         nFuSb+K5iC3zUwQEPNWLswMVuLZWwFJxfJquLyB76ZwJF0mqvp+O/297HslPW+wxYkYh
         KjrFeymrafuz5HeQ7h+LNpcwX/gUGtTWItXsTD3yBaZYPXH8CJZA6pZW5LRtmVO2OeCj
         uKbMzicL8Sc2WyUwf9RP/hJc5jdb4ng4LRWGLl6H7jdxqFJMqHammQhTp7EeyJF/tjBT
         vcRlV4IBCJAxZEohp1PQWIdau1yGQzFHHV121N41ZMaN2V8noK73ViKsvlla5M32jHnR
         vqdA==
X-Forwarded-Encrypted: i=1; AFNElJ98JtwaerAb+fijDi6dfvdEY9Pd851nWuMP7Ci1tF6+JSwHyUk2WM/U0meZ8XCuwb3orlQQOwsu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0a5xevhxuUvVE/c4mJbDGgFyReaEht4juvK6wrIRpNaugxo+G
	ybZERGWinAVuZNwxOwI740xB1DeE03DpbVW9i4iTwy3Nlx7bdtTswekJcOzcGqw26+0=
X-Gm-Gg: Acq92OFQih3P3a+H6xjSGlo0Xel3RAM/mwqC4HFjN7kAEUAgebrXnu9WhdyiCe0kUP9
	k+VOtQNDRAsw+l+s6iZBXs6tL/Z8rjjNB5OTre36nfaGb9OVNAuMZpncWnuMkmLiWupvnC8jwfx
	xw/vIghVZe3OSf2gDFHEF20WDUt4FOtoucPgHk1aQXA7AN8kZcjBszTpjzfj2GiGqak27WsCqhx
	igunaMYw8YJmzfy+FdtF78/QcED7mzFFL/omyVmUZDp4XG3pbqMp616eivew/iehCClaPJtZpab
	pI/YRx1Qd6VBSz1asPr/n3LJyCAj0KpVnA2pzdFrX6vdJsHuTdBr56+rmKqiQBfoiTIBERSrw1U
	aeNWE5bIQe1xXOUbv9zlwEPOlCMTMZlfznmqSKwl8zmQi3Wi8NBzCV+JM9qi+0hGFZ1XBTb8UD7
	fvBrHbqZ5uY3rNtqRy34O2TxdOixktIqMU
X-Received: by 2002:a05:6214:509e:b0:8b3:ff3f:5d61 with SMTP id 6a1803df08f44-8cc6e69480cmr396088716d6.22.1779914886578;
        Wed, 27 May 2026 13:48:06 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80deae74sm178643956d6.11.2026.05.27.13.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:48:05 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/9] mm: switch THP shrinker to list_lru
Date: Wed, 27 May 2026 16:45:07 -0400
Message-ID: <20260527204757.2544958-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16368-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E3FEB5EA2D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is version 5 of switching the THP shrinker to list_lru.

Core of the new version is the list_lru/set_shrinker_bit fix up front,
which minimally affects later patches; and a rebase onto the latest
mm-unstable - replaced alloc_swap_folio() with __swap_cache_alloc().

The changes seemed small enough that *I chose to keep the review tags
from v4*. Please shout if you object to this!

Changes in v5:
- patch 1 is a new fix for a very old, pre-existing set_shrinker_bit()
  problem in list_lru, where the bit can be set on a dying child memcg
  instead of the ancestor that actually received the item. Pointed out
  by Usama Arif and Sashiko; fix it first to make it minimally
  backportable and so the conversion is safe.
- patches 6 and 9 adapt to that fix's new memcg-by-reference
  lock_list_lru_of_memcg() signature
- collapse_huge_page(): propagate folio_memcg_alloc_deferred() failure
  as SCAN_ALLOC_HUGE_PAGE_FAIL instead of leaking SCAN_SUCCEED and
  falsely reporting a successful MADV_COLLAPSE (Usama Arif, Sashiko)
- deferred_split_isolate(): fix a UAF by reading folio state before
  list_lru_isolate(); once removed, a racing folio_put() frees the
  folio via the lockless list_empty() check while we still touch its
  flags and stats (Sashiko)
- rebased to mm-unstable of 2026-05-27, which simplifies the flatten
  prep patch (now anon-only, as alloc_swap_folio() was folded into the
  new __swap_cache_alloc()) and moves the swap-side
  folio_memcg_alloc_deferred() hook into __swap_cache_alloc(). Kairui,
  I would appreciate an eyeball on that.

Changes in v4:
- guard folio_memcg_alloc_deferred() with mem_cgroup_disabled() to fix
  NULL deref in __memcg_list_lru_alloc() when booting with
  cgroup_disable=memory (e.g., kdump capture kernel) -- reported and
  tested by Mikhail Zaslonko on s390 and x86
- flatten if (folio) branches in alloc_swap_folio() and alloc_anon_folio()
  in a prep patch so the list_lru allocation additions are a clean minimal
  diff (Lorenzo)
- folio_memcg_alloc_deferred() moved out of alloc_charge_folio() into the
  anon-only collapse_huge_page() path; collapse_file() shares that helper
  but its pages don't go on the THP shrinker queue (David)
- guard folio_memcg_alloc_deferred() with order > 1; mTHPs below order-2
  can't be queued on the deferred split list (David)
- make deferred_split_lru static, hide behind folio_memcg_alloc_deferred()
  wrapper with GFP_KERNEL (Lorenzo)
- rename l -> lru throughout huge_memory.c (Lorenzo)
- kdoc for folio_memcg_list_lru_alloc() (Lorenzo)
- list_lru_lock_irq()/unlock_irq()/add_irq() irq-disabling variants;
  use list_lru_add_irq() in deferred_split_scan() (Lorenzo)
- reorder shrinker_free() before list_lru_destroy() (Lorenzo)

Changes in v3:
- dedicated lockdep_key for irqsafe deferred_split_lru.lock (syzbot)
- conditional list_lru ops in __folio_freeze_and_split_unmapped() (syzbot)
- annotate runs of inscrutable false, NULL, false function arguments (David)
- rename to folio_memcg_list_lru_alloc() (David)

Changes in v2:
- explicit rcu_read_lock() in __folio_freeze_and_split_unmapped() (Usama)
- split out list_lru prep bits (Dave)

The open-coded deferred split queue has issues. It's not NUMA-aware
(when cgroup is enabled), and it's more complicated in the callsites
interacting with it. Switching to list_lru fixes the NUMA problem and
streamlines things. It also simplifies planned shrinker work.

Patch 1 fixes a pre-existing list_lru bug where the shrinker bit is
set on the caller's memcg rather than the ancestor whose sublist the
item actually lands on after a walk-up. Standalone, backportable; the
rest of the series depends on it.

Patches 2-5 are cleanups and small refactors in list_lru code. They're
basically independent, but make the THP shrinker conversion easier.

Patch 6 extends the list_lru API to allow the caller to control the
locking scope. The THP shrinker has private state it needs to keep
synchronized with the LRU state.

Patch 7 extends the list_lru API with a convenience helper to do
list_lru head allocation (memcg_list_lru_alloc) when coming from a
folio. Anon THPs are instantiated in several places, and with the
folio reparenting patches pending, folio_memcg() access is now a more
delicate dance. This avoids having to replicate that dance everywhere.

Patch 8 flattens the alloc_anon_folio() retry loop so the next patch's
list_lru hook lands as a clean addition rather than nested deep inside
an if (folio) block.

Patch 9 finally switches the deferred_split_queue to list_lru.

Based on mm-unstable.

 include/linux/huge_mm.h    |   7 +-
 include/linux/list_lru.h   |  70 +++++++++
 include/linux/memcontrol.h |   4 -
 include/linux/mmzone.h     |  12 --
 mm/huge_memory.c           | 364 +++++++++++++++------------------------------
 mm/internal.h              |   2 +-
 mm/khugepaged.c            |   5 +
 mm/list_lru.c              | 238 +++++++++++++++++++----------
 mm/memcontrol.c            |  12 +-
 mm/memory.c                |  38 ++---
 mm/mm_init.c               |  15 --
 mm/swap_state.c            |  10 ++
 12 files changed, 399 insertions(+), 378 deletions(-)

The base moved substantially since v4 (the swap allocation rework in
particular reshuffled the alloc_swap_folio() landing spot), so the
patch-level diff between v4 and v5 is non-obvious from a tree diff
alone. For ease of review, here is the range-diff:

 -:  ------------ >  1:  f4f3933599b9 mm: list_lru: set shrinker bit on the memcg that owns the locked sublist
 1:  846dafe02e8b !  2:  e7b8f8bce2ec mm: list_lru: lock_list_lru_of_memcg() cannot return NULL if !skip_empty
    @@ mm/list_lru.c
     @@ mm/list_lru.c: bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
      	struct list_lru_one *l;
      
    - 	l = lock_list_lru_of_memcg(lru, nid, memcg, false, false);
    + 	l = lock_list_lru_of_memcg(lru, nid, &memcg, false, false);
     -	if (!l)
     -		return false;
      	if (list_empty(item)) {
      		list_add_tail(item, &l->list);
    - 		/* Set shrinker bit if the first element was added */
    + 		/*
     @@ mm/list_lru.c: bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
      {
      	struct list_lru_node *nlru = &lru->node[nid];
      	struct list_lru_one *l;
     +
    - 	l = lock_list_lru_of_memcg(lru, nid, memcg, false, false);
    + 	l = lock_list_lru_of_memcg(lru, nid, &memcg, false, false);
     -	if (!l)
     -		return false;
      	if (!list_empty(item)) {
 2:  afe28e645aff !  3:  f1e34640dff9 mm: list_lru: deduplicate unlock_list_lru()
    @@ mm/list_lru.c: static inline bool lock_list_lru(struct list_lru_one *l, bool irq
      		return false;
      	}
      	return true;
    -@@ mm/list_lru.c: lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
    - 	memcg = parent_mem_cgroup(memcg);
    +@@ mm/list_lru.c: lock_list_lru_of_memcg(struct list_lru *lru, int nid,
    + 	*memcg = parent_mem_cgroup(*memcg);
      	goto again;
      }
     -
    @@ mm/list_lru.c: lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_
      #else
      static void list_lru_register(struct list_lru *lru)
      {
    -@@ mm/list_lru.c: lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
    +@@ mm/list_lru.c: lock_list_lru_of_memcg(struct list_lru *lru, int nid,
      
      	return l;
      }
 3:  9e5499facfb1 !  4:  2612b71187ea mm: list_lru: move list dead check to lock_list_lru_of_memcg()
    @@ mm/list_lru.c: list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
      }
      
      static inline struct list_lru_one *
    -@@ mm/list_lru.c: lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
    +@@ mm/list_lru.c: lock_list_lru_of_memcg(struct list_lru *lru, int nid,
      	rcu_read_lock();
      again:
    - 	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
    + 	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(*memcg));
     -	if (likely(l) && lock_list_lru(l, irq)) {
     -		rcu_read_unlock();
     -		return l;
 4:  855b908bfb82 !  5:  cc2819362f07 mm: list_lru: deduplicate lock_list_lru()
    @@ mm/list_lru.c: list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
     -}
     -
      static inline struct list_lru_one *
    - lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
    - 		       bool irq, bool skip_empty)
    -@@ mm/list_lru.c: lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
    + lock_list_lru_of_memcg(struct list_lru *lru, int nid,
    + 		       struct mem_cgroup **memcg, bool irq, bool skip_empty)
    +@@ mm/list_lru.c: lock_list_lru_of_memcg(struct list_lru *lru, int nid,
      {
      	struct list_lru_one *l = &lru->node[nid].lru;
      
 5:  b8a70f1016f3 !  6:  08c4561616df mm: list_lru: introduce caller locking for additions and deletions
    @@ include/linux/list_lru.h: int memcg_list_lru_alloc(struct mem_cgroup *memcg, str
     + * list_lru_lock: lock the sublist for the given node and memcg
     + * @lru: the lru pointer
     + * @nid: the node id of the sublist to lock.
    -+ * @memcg: the cgroup of the sublist to lock.
    ++ * @memcg: pointer to the cgroup of the sublist to lock. On return,
    ++ *         updated to the cgroup whose sublist was actually locked,
    ++ *         which may be an ancestor if the original memcg was dying.
     + *
     + * Returns the locked list_lru_one sublist. The caller must call
     + * list_lru_unlock() when done.
    @@ include/linux/list_lru.h: int memcg_list_lru_alloc(struct mem_cgroup *memcg, str
     + * Return: the locked list_lru_one, or NULL on failure
     + */
     +struct list_lru_one *list_lru_lock(struct list_lru *lru, int nid,
    -+		struct mem_cgroup *memcg);
    ++		struct mem_cgroup **memcg);
     +
     +/**
     + * list_lru_unlock: unlock a sublist locked by list_lru_lock()
    @@ include/linux/list_lru.h: int memcg_list_lru_alloc(struct mem_cgroup *memcg, str
     +void list_lru_unlock(struct list_lru_one *l);
     +
     +struct list_lru_one *list_lru_lock_irq(struct list_lru *lru, int nid,
    -+		struct mem_cgroup *memcg);
    ++		struct mem_cgroup **memcg);
     +void list_lru_unlock_irq(struct list_lru_one *l);
     +
     +struct list_lru_one *list_lru_lock_irqsave(struct list_lru *lru, int nid,
    -+		struct mem_cgroup *memcg, unsigned long *irq_flags);
    ++		struct mem_cgroup **memcg, unsigned long *irq_flags);
     +void list_lru_unlock_irqrestore(struct list_lru_one *l,
     +		unsigned long *irq_flags);
     +
    @@ mm/list_lru.c
     @@ mm/list_lru.c: list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
      
      static inline struct list_lru_one *
    - lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
    --		       bool irq, bool skip_empty)
    -+		       bool irq, unsigned long *irq_flags, bool skip_empty)
    + lock_list_lru_of_memcg(struct list_lru *lru, int nid,
    +-		       struct mem_cgroup **memcg, bool irq, bool skip_empty)
    ++		       struct mem_cgroup **memcg, bool irq,
    ++		       unsigned long *irq_flags, bool skip_empty)
      {
      	struct list_lru_one *l;
      
    -@@ mm/list_lru.c: lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
    +@@ mm/list_lru.c: lock_list_lru_of_memcg(struct list_lru *lru, int nid,
      again:
    - 	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
    + 	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(*memcg));
      	if (likely(l)) {
     -		lock_list_lru(l, irq);
     +		lock_list_lru(l, irq, irq_flags);
    @@ mm/list_lru.c: lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_
     @@ mm/list_lru.c: list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
      
      static inline struct list_lru_one *
    - lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
    --		       bool irq, bool skip_empty)
    -+		       bool irq, unsigned long *irq_flags, bool skip_empty)
    + lock_list_lru_of_memcg(struct list_lru *lru, int nid,
    +-		       struct mem_cgroup **memcg, bool irq, bool skip_empty)
    ++		       struct mem_cgroup **memcg, bool irq,
    ++		       unsigned long *irq_flags, bool skip_empty)
      {
      	struct list_lru_one *l = &lru->node[nid].lru;
      
    @@ mm/list_lru.c: list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
     -bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
     -		  struct mem_cgroup *memcg)
     +struct list_lru_one *list_lru_lock(struct list_lru *lru, int nid,
    -+				   struct mem_cgroup *memcg)
    ++				   struct mem_cgroup **memcg)
      {
     -	struct list_lru_node *nlru = &lru->node[nid];
     -	struct list_lru_one *l;
    @@ mm/list_lru.c: list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
     +}
     +
     +struct list_lru_one *list_lru_lock_irq(struct list_lru *lru, int nid,
    -+				       struct mem_cgroup *memcg)
    ++				       struct mem_cgroup **memcg)
     +{
     +	return lock_list_lru_of_memcg(lru, nid, memcg, /*irq=*/true,
     +				      /*irq_flags=*/NULL, /*skip_empty=*/false);
    @@ mm/list_lru.c: list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
     +	unlock_list_lru(l, /*irq_off=*/true, /*irq_flags=*/NULL);
     +}
      
    --	l = lock_list_lru_of_memcg(lru, nid, memcg, false, false);
    +-	l = lock_list_lru_of_memcg(lru, nid, &memcg, false, false);
     +struct list_lru_one *list_lru_lock_irqsave(struct list_lru *lru, int nid,
    -+					   struct mem_cgroup *memcg,
    ++					   struct mem_cgroup **memcg,
     +					   unsigned long *flags)
     +{
     +	return lock_list_lru_of_memcg(lru, nid, memcg, /*irq=*/true,
    @@ mm/list_lru.c: list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
     +{
      	if (list_empty(item)) {
      		list_add_tail(item, &l->list);
    - 		/* Set shrinker bit if the first element was added */
    + 		/*
    +@@ mm/list_lru.c: bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
    + 		 */
      		if (!l->nr_items++)
      			set_shrinker_bit(memcg, nid, lru_shrinker_id(lru));
     -		unlock_list_lru(l, false);
    @@ mm/list_lru.c: list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
     +	struct list_lru_one *l;
     +	bool ret;
     +
    -+	l = list_lru_lock(lru, nid, memcg);
    ++	l = list_lru_lock(lru, nid, &memcg);
     +	ret = __list_lru_add(lru, l, item, nid, memcg);
     +	list_lru_unlock(l);
     +	return ret;
    @@ mm/list_lru.c: list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
     +	struct list_lru_one *l;
     +	bool ret;
     +
    -+	l = list_lru_lock_irq(lru, nid, memcg);
    ++	l = list_lru_lock_irq(lru, nid, &memcg);
     +	ret = __list_lru_add(lru, l, item, nid, memcg);
     +	list_lru_unlock_irq(l);
     +	return ret;
    @@ mm/list_lru.c: EXPORT_SYMBOL_GPL(list_lru_add_obj);
      	struct list_lru_one *l;
     +	bool ret;
      
    --	l = lock_list_lru_of_memcg(lru, nid, memcg, false, false);
    +-	l = lock_list_lru_of_memcg(lru, nid, &memcg, false, false);
     -	if (!list_empty(item)) {
     -		list_del_init(item);
     -		l->nr_items--;
    @@ mm/list_lru.c: EXPORT_SYMBOL_GPL(list_lru_add_obj);
     -	}
     -	unlock_list_lru(l, false);
     -	return false;
    -+	l = list_lru_lock(lru, nid, memcg);
    ++	l = list_lru_lock(lru, nid, &memcg);
     +	ret = __list_lru_del(lru, l, item, nid);
     +	list_lru_unlock(l);
     +	return ret;
    @@ mm/list_lru.c: __list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgr
      	unsigned long isolated = 0;
      
      restart:
    --	l = lock_list_lru_of_memcg(lru, nid, memcg, irq_off, true);
    -+	l = lock_list_lru_of_memcg(lru, nid, memcg, /*irq=*/irq_off,
    +-	l = lock_list_lru_of_memcg(lru, nid, &memcg, irq_off, true);
    ++	l = lock_list_lru_of_memcg(lru, nid, &memcg, /*irq=*/irq_off,
     +				   /*irq_flags=*/NULL, /*skip_empty=*/true);
      	if (!l)
      		return isolated;
 6:  0bf8cd5bc205 =  7:  9b1b9ab5e749 mm: list_lru: introduce folio_memcg_list_lru_alloc()
 7:  a26656c1c0a5 !  8:  fd4e1d364dc2 mm: memory: flatten folio allocation retry loops
    @@ Metadata
     Author: Johannes Weiner <hannes@cmpxchg.org>
     
      ## Commit message ##
    -    mm: memory: flatten folio allocation retry loops
    +    mm: memory: flatten alloc_anon_folio() retry loop
     
    -    alloc_swap_folio() and alloc_anon_folio() use a top-level if (folio)
    -    that buries the success path four levels deep. This makes for awkward
    -    long lines and wrapping. The next patch will add more code here, so
    -    flatten this now to keep things clean and simple.
    +    alloc_anon_folio() uses a top-level if (folio) that buries the success
    +    path four levels deep. This makes for awkward long lines and wrapping.
    +    The next patch will add more code here, so flatten this now to keep
    +    things clean and simple.
     
    -    alloc_anon_folio() already has a next label, use it for !folio. Add
    -    the equivalent to alloc_swap_folio().
    +    The next label is already there, use it for !folio.
     
         No functional change intended.
     
    @@ Commit message
         Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
     
      ## mm/memory.c ##
    -@@ mm/memory.c: static struct folio *alloc_swap_folio(struct vm_fault *vmf)
    - 	while (orders) {
    - 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
    - 		folio = vma_alloc_folio(gfp, order, vma, addr);
    --		if (folio) {
    --			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
    --							    gfp, entry))
    --				return folio;
    -+		if (!folio)
    -+			goto next;
    -+		if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm, gfp, entry)) {
    - 			count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
    - 			folio_put(folio);
    -+			goto next;
    - 		}
    -+		return folio;
    -+next:
    - 		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
    - 		order = next_order(&orders, order);
    - 	}
     @@ mm/memory.c: static struct folio *alloc_anon_folio(struct vm_fault *vmf)
      	while (orders) {
      		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
 8:  e454696ab1b7 !  9:  70fe768450de mm: switch deferred split shrinker to list_lru
    @@ mm/huge_memory.c: static int __folio_freeze_and_split_unmapped(struct folio *fol
     +	 */
     +	dequeue_deferred = folio_test_anon(folio) && old_order > 1;
     +	if (dequeue_deferred) {
    ++		struct mem_cgroup *memcg;
    ++
     +		rcu_read_lock();
    ++		memcg = folio_memcg(folio);
     +		lru = list_lru_lock(&deferred_split_lru,
    -+				    folio_nid(folio), folio_memcg(folio));
    ++				    folio_nid(folio), &memcg);
     +	}
      	if (folio_ref_freeze(folio, folio_cache_ref_count(folio) + 1)) {
      		struct swap_cluster_info *ci = NULL;
    @@ mm/huge_memory.c: int split_folio_to_list(struct folio *folio, struct list_head
      bool __folio_unqueue_deferred_split(struct folio *folio)
      {
     -	struct deferred_split *ds_queue;
    ++	struct mem_cgroup *memcg;
     +	struct list_lru_one *lru;
     +	int nid = folio_nid(folio);
      	unsigned long flags;
    @@ mm/huge_memory.c: int split_folio_to_list(struct folio *folio, struct list_head
     -	if (!list_empty(&folio->_deferred_list)) {
     -		ds_queue->split_queue_len--;
     +	rcu_read_lock();
    -+	lru = list_lru_lock_irqsave(&deferred_split_lru, nid, folio_memcg(folio), &flags);
    ++	memcg = folio_memcg(folio);
    ++	lru = list_lru_lock_irqsave(&deferred_split_lru, nid, &memcg, &flags);
     +	if (__list_lru_del(&deferred_split_lru, lru, &folio->_deferred_list, nid)) {
      		if (folio_test_partially_mapped(folio)) {
      			folio_clear_partially_mapped(folio);
    @@ mm/huge_memory.c: void deferred_split_folio(struct folio *folio, bool partially_
     +
     +	rcu_read_lock();
     +	memcg = folio_memcg(folio);
    -+	lru = list_lru_lock_irqsave(&deferred_split_lru, nid, memcg, &flags);
    ++	lru = list_lru_lock_irqsave(&deferred_split_lru, nid, &memcg, &flags);
      	if (partially_mapped) {
      		if (!folio_test_partially_mapped(folio)) {
      			folio_set_partially_mapped(folio);
    @@ mm/huge_memory.c: static bool thp_underused(struct folio *folio)
     +		return LRU_REMOVED;
     +	}
     +
    -+	/* We lost race with folio_put() */
    -+	list_lru_isolate(lru, item);
    ++	/*
    ++	 * We lost race with folio_put(). Read folio state before the
    ++	 * isolate: folio_unqueue_deferred_split() checks list_empty()
    ++	 * locklessly, so once removed the folio can be freed any time.
    ++	 */
     +	if (folio_test_partially_mapped(folio)) {
     +		folio_clear_partially_mapped(folio);
     +		mod_mthp_stat(folio_order(folio),
     +			      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
     +	}
    ++	list_lru_isolate(lru, item);
     +	return LRU_REMOVED;
     +}
     +
    @@ mm/huge_memory.c: static bool thp_underused(struct folio *folio)
      	struct folio *folio, *next;
     -	int split = 0, i;
     -	struct folio_batch fbatch;
    +-
    +-	folio_batch_init(&fbatch);
     +	int split = 0;
     +	unsigned long isolated;
      
    --	folio_batch_init(&fbatch);
    -+	isolated = list_lru_shrink_walk_irq(&deferred_split_lru, sc,
    -+					    deferred_split_isolate, &dispose);
    - 
     -retry:
     -	ds_queue = split_queue_lock_irqsave(sc->nid, sc->memcg, &flags);
     -	/* Take pin on all head pages to avoid freeing them under us */
    @@ mm/huge_memory.c: static bool thp_underused(struct folio *folio)
     -			break;
     -	}
     -	split_queue_unlock_irqrestore(ds_queue, flags);
    --
    ++	isolated = list_lru_shrink_walk_irq(&deferred_split_lru, sc,
    ++					    deferred_split_isolate, &dispose);
    + 
     -	for (i = 0; i < folio_batch_count(&fbatch); i++) {
     +	list_for_each_entry_safe(folio, next, &dispose, _deferred_list) {
      		bool did_split = false;
    @@ mm/khugepaged.c: static enum scan_result collapse_huge_page(struct mm_struct *mm
      	if (result != SCAN_SUCCEED)
      		goto out_nolock;
      
    -+	if (folio_memcg_alloc_deferred(folio))
    ++	if (folio_memcg_alloc_deferred(folio)) {
    ++		result = SCAN_ALLOC_HUGE_PAGE_FAIL;
     +		goto out_nolock;
    ++	}
     +
      	mmap_read_lock(mm);
      	result = hugepage_vma_revalidate(mm, pmd_addr, /*expect_anon=*/ true,
    @@ mm/memcontrol.c: static void mem_cgroup_css_offline(struct cgroup_subsys_state *
      	reparent_shrinker_deferred(memcg);
     
      ## mm/memory.c ##
    -@@ mm/memory.c: static struct folio *alloc_swap_folio(struct vm_fault *vmf)
    - 			folio_put(folio);
    - 			goto next;
    - 		}
    -+		if (order > 1 && folio_memcg_alloc_deferred(folio)) {
    -+			folio_put(folio);
    -+			goto fallback;
    -+		}
    - 		return folio;
    - next:
    - 		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
     @@ mm/memory.c: static struct folio *alloc_anon_folio(struct vm_fault *vmf)
      			folio_put(folio);
      			goto next;
    @@ mm/mm_init.c: static void __meminit pgdat_init_internals(struct pglist_data *pgd
      	pgdat_init_kcompactd(pgdat);
      
      	init_waitqueue_head(&pgdat->kswapd_wait);
    +
    + ## mm/swap_state.c ##
    +@@ mm/swap_state.c: static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
    + 		return ERR_PTR(-ENOMEM);
    + 	}
    + 
    ++	if (order > 1 && folio_memcg_alloc_deferred(folio)) {
    ++		spin_lock(&ci->lock);
    ++		__swap_cache_do_del_folio(ci, folio, entry, shadow);
    ++		spin_unlock(&ci->lock);
    ++		folio_unlock(folio);
    ++		/* nr_pages refs from swap cache, 1 from allocation */
    ++		folio_put_refs(folio, nr_pages + 1);
    ++		return ERR_PTR(-ENOMEM);
    ++	}
    ++
    + 	/* memsw uncharges swap when folio is added to swap cache */
    + 	memcg1_swapin(folio);
    + 	if (shadow)


