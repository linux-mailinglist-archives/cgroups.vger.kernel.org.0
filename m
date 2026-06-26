Return-Path: <cgroups+bounces-17325-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gg/uF7BVPmrpDwkAu9opvQ
	(envelope-from <cgroups+bounces-17325-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 12:34:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C542D6CC1EC
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 12:34:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17325-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17325-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF18C30433F4
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83A93B19B4;
	Fri, 26 Jun 2026 10:34:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FEA386578;
	Fri, 26 Jun 2026 10:34:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470059; cv=none; b=RhXvZxiHlV1A5BAg8sWKFuxqIp5SmF9ducgmg+T3R8/NJRNMkZ+Qa/znVtlOY16m9DktvkAgtQl4FAT/Q/FqEe/ia7hl9HS+27WrFok0zmU5l40eQPUuMhAPzlB8uKPP+QMGpeAMmZgVcWVCtkEyhQycwrfOdCgzuw7bK3oVANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470059; c=relaxed/simple;
	bh=pWgrlUV/OsfKyRy2jbkiPH/KFWWgKBblCFD4uY9gtcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXWDuTYG3dMxQJKY16p+w7qycbLb0gMghY5POrOQuw7h4WDr0omm0awbVL4gmMkO1KZ46wAf84eX4161cenlPOpN63NvrBF01RSZ2tB4jv4qOyGDno+AahBr/AjUXwZjoklaq9+zHTtpPd6k4zelUa/BUljJQgu/+873rq699VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35CA53EC65;
	Fri, 26 Jun 2026 10:34:01 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: alexandre@ghiti.fr,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Barry Song <baohua@kernel.org>,
	Ben Segall <bsegall@google.com>,
	cgroups@vger.kernel.org,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Hildenbrand <david@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kairui Song <kasong@tencent.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Wei Xu <weixugc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Yuanchu Xie <yuanchu@google.com>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v2 9/9] mm: zswap: per-node kmem accounting for zswap/zsmalloc
Date: Fri, 26 Jun 2026 12:20:58 +0200
Message-ID: <20260626102358.1603618-10-alex@ghiti.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626102358.1603618-1-alex@ghiti.fr>
References: <20260626102358.1603618-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTG3h5G6t3FC2isZZGU/PT2pn+1paeiWOdgcvbFuD+1BKVsNu4saVvfuzt75aavMMcGzuV3jTmfiGGFoaK1beSakgFC7iEno5M78bKzolba0CnxXwUui8VjRa1yK6+WhcZ/aKsvWtdNWYdQgHkYc+meTm6yjPpGSSCaQ/cUZsVZjasBVRYNS5HCE4R0qp9cJZuPpvf7jxHkgnY4LdvAc8t5qsLJYCXTJKl501kxTLSYYWKNE5ufQVuz5upqkJLG0shbqvbT6RN7ik/pC7OXlu/GwZnn7PAXBL5PaAIvFrTlXRqOeQUW0BAvIJCUnr8re/L97syiX1fL4lPXMhmn2cVwrKlRN7SgVe3oX12fxoLpgCMiakunAF0nk7ZKlp4KV7lAyV9Av1/BDD7qQI0UD+tGTHnWIjwfXgb3VWkWC1vfMSQSTfjPuLaaFznyiH01XFnRH/+8/Il79IfAYhV813teP6pqb0tLfCzfBb2rseQ3ItD5QjdM52zAZrfUJEG8f6stkCHzzDO/uyzLPyjJJk5WnPzwnSPb2ym2c9iPwjEyOx/0VVV1BM2xGJP8TbWaMP7ZbXKW/HZJXEu0230c32PzvnJr1ezYLZ+XbYak7O1/XIQ4uGlicjMdcGOoJ8d+X7NurrBJkszb5Uu1NqYfo1vuyuyilJYRKxgyCO0VYmTE4NA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17325-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[ghiti.fr];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexandre@ghiti.fr,m:akpm@linux-foundation.org,m:axelrasmussen@google.com,m:baohua@kernel.org,m:bsegall@google.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:cl@gentwo.org,m:david@kernel.org,m:dennis@kernel.org,m:dietmar.eggemann@arm.com,m:mingo@redhat.com,m:hannes@cmpxchg.org,m:juri.lelli@redhat.com,m:kasong@tencent.com,m:kent.overstreet@linux.dev,m:kprateek.nayak@amd.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:mgorman@suse.de,m:mhocko@kernel.org,m:rppt@kernel.org,m:minchan@kernel.org,m:muchun.song@linux.dev,m:nphamcs@gmail.com,m:peterz@infradead.org,m:qi.zheng@linux.dev,m:roman.gushchin@linux.dev,m:senozhatsky@chromium.org,m:shakeel.butt@linux.dev,m:rostedt@goodmis.org,m:surenb@google.com,m:tj@kernel.org,m:vschneid@redhat.com,m:vincent.guittot@linaro.org,m:vbabka@kernel.org,m:weixugc@google.com,m:yosry@kernel.org,m:yuanchu@google.com,m:alex@ghiti.fr,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,linux.dev,gentwo.org,arm.com,redhat.com,cmpxchg.org,tencent.com,amd.com,infradead.org,kvack.org,suse.de,gmail.com,chromium.org,goodmis.org,linaro.org,ghiti.fr];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ghiti.fr:email,ghiti.fr:mid,ghiti.fr:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C542D6CC1EC

Update zswap and zsmalloc to use per-node obj_cgroup for kmem
accounting, attributing compressed page charges to the correct
NUMA node.

But actually, this is incomplete because it does not correctly account
for entries that straddle pages, those pages being possibly on 2 different
nodes.

This will be correctly handled by Joshua in a different series [1].

Link: https://lore.kernel.org/linux-mm/20260311195153.4013476-1-joshua.hahnjy@gmail.com/ [1]
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 include/linux/zsmalloc.h |  2 ++
 mm/zsmalloc.c            | 11 +++++++++++
 mm/zswap.c               | 19 ++++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 478410c880b1..30427f3fe232 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -50,6 +50,8 @@ void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle);
 void zs_obj_write(struct zs_pool *pool, unsigned long handle,
 		  void *handle_mem, size_t mem_len);
 
+int zs_handle_to_nid(struct zs_pool *pool, unsigned long handle);
+
 extern const struct movable_operations zsmalloc_mops;
 
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 83f5820c45f9..17f7403ebe77 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1380,6 +1380,17 @@ static void obj_free(int class_size, unsigned long obj)
 	mod_zspage_inuse(zspage, -1);
 }
 
+int zs_handle_to_nid(struct zs_pool *pool, unsigned long handle)
+{
+	unsigned long obj;
+	struct zpdesc *zpdesc;
+
+	obj = handle_to_obj(handle);
+	obj_to_zpdesc(obj, &zpdesc);
+	return page_to_nid(zpdesc_page(zpdesc));
+}
+EXPORT_SYMBOL(zs_handle_to_nid);
+
 void zs_free(struct zs_pool *pool, unsigned long handle)
 {
 	struct zspage *zspage;
diff --git a/mm/zswap.c b/mm/zswap.c
index 761cd699e0a3..466c6a3f4ef3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1438,7 +1438,24 @@ static bool zswap_store_page(struct page *page,
 	 */
 	zswap_pool_get(pool);
 	if (objcg) {
-		obj_cgroup_get(objcg);
+		struct obj_cgroup *nid_objcg;
+		int nid = zs_handle_to_nid(pool->zs_pool, entry->handle);
+
+		/*
+		 * obj_cgroup_nid() returns a borrowed RCU pointer (no
+		 * reference), so the returned per-node objcg may be freed
+		 * (kfree_rcu) before we use it. Pin it with a tryget inside a
+		 * single rcu section; if it is already dying, fall back to the
+		 * folio objcg (held by the caller) so the charge still lands on
+		 * the right memcg, just without per-node attribution.
+		 */
+		rcu_read_lock();
+		nid_objcg = obj_cgroup_nid(objcg, nid);
+		if (nid_objcg && obj_cgroup_tryget(nid_objcg))
+			objcg = nid_objcg;
+		else
+			obj_cgroup_get(objcg);
+		rcu_read_unlock();
 		obj_cgroup_charge_zswap(objcg, entry->length);
 	}
 	atomic_long_inc(&zswap_stored_pages);
-- 
2.54.0


