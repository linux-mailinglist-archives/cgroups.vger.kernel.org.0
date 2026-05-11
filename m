Return-Path: <cgroups+bounces-15787-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P/uCX07AmrmpAEAu9opvQ
	(envelope-from <cgroups+bounces-15787-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:26:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AB6515D6D
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4634A301FA5B
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E773803D6;
	Mon, 11 May 2026 20:25:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA0B37FF71;
	Mon, 11 May 2026 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531107; cv=none; b=TcVPmFn9uivfyGZJJhOlIuZb6yWwpErQGo+0SjkPPcvfGCOrSfHI9PO1qKC0oTM/0JAEHpJeF8uSYYz2C4NkVX8XLl2LYw+xzIviK9wq0hdiW0ZqnH4mqauaAawLiwPQOapNoxQX/sbqzTQ7pHx5hM2W0hTPB1F0wtvwCUKrc54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531107; c=relaxed/simple;
	bh=N+E1pDIVpIXApWx5or1xCOhJbWO8U3sZ0WtpiTUdJf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkyivaRS6Mhb/QItCe+qqBqFGn1JAIOsGo/mlsvyeQJTcF3Y4voPPlIza6jhJ3PG0d/LnYmgzCPIaCudTnaiqijFW+7aH8QtioRUnox3DsAf4mbHfUoKg4sp3wIOIjtw9sPvFxY36CC8RFLxvxxgXPGdQUWFibXG+7MbJ2U78tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0B2463EC97;
	Mon, 11 May 2026 20:24:57 +0000 (UTC)
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
Subject: [PATCH 3/8] mm: percpu: Split memcg charging and kmem accounting
Date: Mon, 11 May 2026 22:20:38 +0200
Message-ID: <20260511202136.330358-4-alex@ghiti.fr>
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
X-GND-Cause: dmFkZTGASuQ7DzVEqE1yqVdt2m1IEMvyeiZ424ZAVS1woSZRBsZRcHOaYxo/wRroa9V549fgoGhwPyYnAfDpxQNFtzkxj0I5TMeBg/5jBppJQkWIBRGnFCdwyKb3+iAwjbc6HCyc2w6Fq1RMe0bJWfA1ndpco4RPwk+ydi46o3tuXnoPGtt57UGuv0fBX6aLFC8egYVKjqd5+b/oNYSj52BJhnje7YewqzwfY3MT59q3IHUZSXd+23dBE9VioRxzwOkioSO0aPH0PeFEsizQ7P2RVgZRWW0PznWL4m6swkEsBSSzcbL/DhTQy/lqZtdEuHj15ch+irNHdmG3iRmpUdYJcCG6FVRyCFmUUefwWKvmaU8zciFZr9tv02clCs29RgJIe6uEHw+tHpKx9hC0tk9VwW3YlOuSyQlzq7zcDO7cJZuRLZjIeYUuDZY43XuUpam9sFTsMHZohmtUl9SiE0Jfu6DdZaxw90yzWEKKUSOlXg4J1Z16+k7QwHE/Ap3MW22DG/TSgjt5seNYJm7KBXRAPlXmUsd2VjSwn8EV/3xg3yQpsgdLhJbkr5M3xPszfR56699O1eGfBtzdrb6nViTLCQHO+Gkproj+k5gd7upyyXN9nu3oJJPtq6HaXmZYNdI2z47UdrcWga1FD/yPaRKqkRrOKPqmtOp4KPeDAPJHh2y4+w
X-GND-State: clean
X-GND-Score: -100
X-Rspamd-Queue-Id: 88AB6515D6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15787-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ghiti.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org,ghiti.fr];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.636];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ghiti.fr:email,ghiti.fr:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is preparatory patch for upcoming per-memcg-per-node kmem
accounting.

Percpu allocations charge memory before knowing which NUMA nodes the
pages will land on. So we need to decouple the memcg charging from the
kmem accounting:

1. In the pre-alloc hook, obj_cgroup_precharge() reserves pages for
   memcg limit enforcement without updating kmem stats.
2. In the post-alloc hook, obj_cgroup_account_kmem() accounts kmem
   and places the sub-page remainder into the obj stock after the
   allocation succeeds.

Because of that decoupling, we must not rely on the stock in the
precharge function and always charge the necessary pages that will
be accounted after the allocations happened. That means we may
temporarily overcharge the memcg but the obj_stock draining will get
things back to normal.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 include/linux/memcontrol.h |  4 +++
 mm/memcontrol.c            | 50 ++++++++++++++++++++++++++++++++++++++
 mm/percpu.c                | 15 +++++++++---
 3 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index dc3fa687759b..568ab08f42af 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1707,6 +1707,10 @@ static inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
+int obj_cgroup_precharge(struct obj_cgroup *objcg, gfp_t gfp,
+			 unsigned int nr_pages);
+void obj_cgroup_unprecharge(struct obj_cgroup *objcg, unsigned int nr_pages);
+void obj_cgroup_account_kmem(struct obj_cgroup *objcg, unsigned int nr_pages);
 
 extern struct static_key_false memcg_bpf_enabled_key;
 static inline bool memcg_bpf_enabled(void)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d81a76654b2c..aaaa6a8b9f15 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3405,6 +3405,56 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 	refill_obj_stock(objcg, size, true);
 }
 
+/*
+ * obj_cgroup_account_kmem - account KMEM for nr_pages
+ *
+ * Called after obj_cgroup_precharge() when the allocation succeeds.
+ * Accounts KMEM for nr_pages on the objcg's node.
+ */
+void obj_cgroup_account_kmem(struct obj_cgroup *objcg, unsigned int nr_pages)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	account_kmem_nmi_safe(memcg, nr_pages);
+	memcg1_account_kmem(memcg, nr_pages);
+	rcu_read_unlock();
+}
+
+/*
+ * obj_cgroup_precharge - reserve pages without KMEM accounting
+ *
+ * Reserves page counter credits for limit enforcement. Does not update
+ * KMEM stats or the per-CPU obj stock, because precharge decouples
+ * the page counter charge from KMEM accounting (which happens later
+ * per-node via obj_cgroup_account_kmem).
+ *
+ * On failure, use obj_cgroup_unprecharge() to release the reservation.
+ */
+int obj_cgroup_precharge(struct obj_cgroup *objcg, gfp_t gfp,
+			 unsigned int nr_pages)
+{
+	struct mem_cgroup *memcg;
+	int ret;
+
+	memcg = get_mem_cgroup_from_objcg(objcg);
+	ret = try_charge_memcg(memcg, gfp, nr_pages);
+	css_put(&memcg->css);
+
+	return ret;
+}
+
+void obj_cgroup_unprecharge(struct obj_cgroup *objcg, unsigned int nr_pages)
+{
+	struct mem_cgroup *memcg;
+
+	memcg = get_mem_cgroup_from_objcg(objcg);
+	if (!mem_cgroup_is_root(memcg))
+		refill_stock(memcg, nr_pages);
+	css_put(&memcg->css);
+}
+
 static inline size_t obj_full_size(struct kmem_cache *s)
 {
 	/*
diff --git a/mm/percpu.c b/mm/percpu.c
index 13de6e099d96..7c67dc2e4878 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1626,7 +1626,8 @@ static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
 	if (!objcg || obj_cgroup_is_root(objcg))
 		return true;
 
-	if (obj_cgroup_charge(objcg, gfp, pcpu_obj_total_size(size)))
+	if (obj_cgroup_precharge(objcg, gfp,
+				 PAGE_ALIGN(pcpu_obj_total_size(size)) >> PAGE_SHIFT))
 		return false;
 
 	*objcgp = objcg;
@@ -1641,15 +1642,23 @@ static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
 		return;
 
 	if (likely(chunk && chunk->obj_exts)) {
+		size_t total = pcpu_obj_total_size(size);
+		size_t remainder = PAGE_ALIGN(total) - total;
+
 		obj_cgroup_get(objcg);
 		chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].cgroup = objcg;
 
 		rcu_read_lock();
 		mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
-				pcpu_obj_total_size(size));
+				total);
 		rcu_read_unlock();
+
+		obj_cgroup_account_kmem(objcg, PAGE_ALIGN(total) >> PAGE_SHIFT);
+		if (remainder)
+			obj_cgroup_uncharge(objcg, remainder);
 	} else {
-		obj_cgroup_uncharge(objcg, pcpu_obj_total_size(size));
+		obj_cgroup_unprecharge(objcg,
+				       PAGE_ALIGN(pcpu_obj_total_size(size)) >> PAGE_SHIFT);
 	}
 }
 
-- 
2.54.0


