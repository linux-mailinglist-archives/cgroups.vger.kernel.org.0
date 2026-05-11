Return-Path: <cgroups+bounces-15790-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BuyeDOg7AmrYpQEAu9opvQ
	(envelope-from <cgroups+bounces-15790-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:28:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B75C515DB0
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C631302813D
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC13382371;
	Mon, 11 May 2026 20:28:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7C3822A6;
	Mon, 11 May 2026 20:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531300; cv=none; b=DujONDvizHdpsqDBiRPiwtgfasi81nJlZnDTSL53Yk/K/nWxzCOrwU68D8dmWweJWcbfGNybJw+PQwBfAg94ovY3YAw20ikUW6KCpWv921doPSp+ZSv2DoWLIhTqBP2RXxnPbzSFNeEZslb9zvVlIKiHB4R8m1qCyOVb5Z1EvEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531300; c=relaxed/simple;
	bh=q6nxpSUHdrkhq5l9smc6D8BRHTc0yRWKmrfLeIhy+Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUjWHHxu3ihoFZH6+AbXyTVUC7VFSpCTBgWXqF8Blf1Z7HLMqLgp7PNlaRmwOx6kIv5m4ZA0LTbv6huuRv0hkbZnQx6LvDSqQtHZfbtYznXoRJGVsXs+ul3v66kV6W9gj4z6G8j62yC8oJN0bdHC5rmKyjFIkljIiggTaznOGNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E1823ECA9;
	Mon, 11 May 2026 20:28:12 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Barry Song <baohua@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 6/8] mm: slab: per-node kmem accounting for slab
Date: Mon, 11 May 2026 22:20:41 +0200
Message-ID: <20260511202136.330358-7-alex@ghiti.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511202136.330358-1-alex@ghiti.fr>
References: <20260511202136.330358-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-Cause: dmFkZTGZq0GkJau6RWVth2AkA6mXp5hevURRivnwJLaOUMsROukueZFeGriViT3+cCjdcQdQP0MXVJyz1fLtz5XFi7fYpUSG4G6HGJNwB7Iq+AffJ+iN70qPoWx4sPkTvS8S8edtNse4haP6xRwCWHJvcVy7zsnDElyg9ELyVKHPrzVc71knPq23qOqkwc4KIrg5BHucIt4/5JbUi95cV8eeMKs6lPZKscraThdxjN0ea9JVj3y6puOv/mj1bfUb5Bpth59ONuYJuZ08jwh3vLgdvYEWkwTPa3c1OOv3+xRvJspVD1HTOqkt57ReSG7Uxn9/R/VsgPJlS+GPzNYXtlpAG3mkJbX67Njd6BIGbSd3kIMF6zI2SPxxVU8jrtHRPzhlOBMH78KZWa8sI6jzpCjCXhcVEcIIzcsk8ommP5+c+1S0+dBBC9M+DOr4qPvb7bjSQ9Bst2E7PCINEbdpofRg5cA3z50NO9Cxcf2ieLYT6YiOgFdZ3qCrvKKNG2Riem3KWDi/ad+KeaoCy0jkm5wkkolorVmEICRJ2TEKw/KZ54E3okbW4BByQNZZN45W9cpM7WFWL8Zs7eSB2YAcy+uCNP/LDkC7E08aaXjNJnMuas8rQDUCIGWuY0yybBBOpu/8LjqBbsxYR5yHgI/HmTNUq6bE7H7TFFFTL5qQ3OodEeOs6Q
X-GND-State: clean
X-GND-Score: -100
X-Rspamd-Queue-Id: 8B75C515DB0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15790-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ghiti.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org,ghiti.fr];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.631];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ghiti.fr:email,ghiti.fr:mid]
X-Rspamd-Action: no action

Update slab hook to use per-node obj_cgroup for correct NUMA
attribution of NR_KMEM.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 mm/memcontrol.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 66d2beb1c974..cefb335c990e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3521,14 +3521,18 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		unsigned long obj_exts;
 		struct slabobj_ext *obj_ext;
 		struct obj_stock_pcp *stock;
+		struct obj_cgroup *nid_objcg;
+		int nid;
 
 		slab = virt_to_slab(p[i]);
+		nid = slab_pgdat(slab)->node_id;
 
 		if (!slab_obj_exts(slab) &&
 		    alloc_slab_obj_exts(slab, s, flags, false)) {
 			continue;
 		}
 
+		nid_objcg = obj_cgroup_get_nid(objcg, nid);
 		/*
 		 * if we fail and size is 1, memcg_alloc_abort_single() will
 		 * just free the object, which is ok as we have not assigned
@@ -3541,17 +3545,17 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		 * between iterations, with a more complicated undo
 		 */
 		stock = trylock_stock();
-		if (!stock || !__consume_obj_stock(objcg, stock, obj_size)) {
+		if (!stock || !__consume_obj_stock(nid_objcg, stock, obj_size)) {
 			size_t remainder;
 
 			unlock_stock(stock);
-			if (__obj_cgroup_charge(objcg, flags, obj_size, &remainder))
+			if (__obj_cgroup_charge(nid_objcg, flags, obj_size, &remainder))
 				return false;
 			stock = trylock_stock();
 			if (remainder)
-				__refill_obj_stock(objcg, stock, remainder, false);
+				__refill_obj_stock(nid_objcg, stock, remainder, false);
 		}
-		__account_obj_stock(objcg, stock, obj_size,
+		__account_obj_stock(nid_objcg, stock, obj_size,
 				    slab_pgdat(slab), cache_vmstat_idx(s));
 		unlock_stock(stock);
 
@@ -3559,8 +3563,8 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		get_slab_obj_exts(obj_exts);
 		off = obj_to_index(s, slab, p[i]);
 		obj_ext = slab_obj_ext(slab, obj_exts, off);
-		obj_cgroup_get(objcg);
-		obj_ext->objcg = objcg;
+		obj_cgroup_get(nid_objcg);
+		obj_ext->objcg = nid_objcg;
 		put_slab_obj_exts(obj_exts);
 	}
 
-- 
2.54.0


