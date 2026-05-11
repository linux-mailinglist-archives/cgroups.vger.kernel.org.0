Return-Path: <cgroups+bounces-15793-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIbULnc9AmrmpAEAu9opvQ
	(envelope-from <cgroups+bounces-15793-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:35:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 193A2515EC3
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B85C8308E511
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD0237EFF1;
	Mon, 11 May 2026 20:29:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9E93845D0;
	Mon, 11 May 2026 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531364; cv=none; b=Z8EZjnM2/PsW2vGMtKfvSF/+xE5T0lzrfT6MqoLR3p0PoZYtkUZDjh7bsqTWs/GJFkQGUlcSN9TlSvRmDJE9yxAVWAxQq5n7qtamTtfiermmlocIzmLo7e2QWe/OD2pcWBgC0HQIgyelW5xGjZUMqIo8+x3ekm+d1M0nE4ATaC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531364; c=relaxed/simple;
	bh=qAMkBaLtEhHYPwMRbBThD+MHIgVejhO8IskUWJHHXjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHY/ynBYGRs5OuN2kJI34IlF48Ygy7pSyYT4JKKOfVeWICJu9s8D29c9zXj7PAdy3RWXxG+YqmOczVeqg8s4vwrXzt7iM2f834GICvskv59RSqVep1HHlsm5avSjq/WsJyc4ZVojbrs3BryoFnC0SZrs1DPFwnMn0OoNmj/wRzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62DDB3ECB2;
	Mon, 11 May 2026 20:29:17 +0000 (UTC)
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
Subject: [PATCH 7/8] mm: percpu: per-node kmem accounting using local credit
Date: Mon, 11 May 2026 22:20:42 +0200
Message-ID: <20260511202136.330358-8-alex@ghiti.fr>
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
X-GND-Cause: dmFkZTGZq0GkJau6RWVth2AkA6mXp5hevURRivnwJLaOUMsROukueZFeGriViT3+cCjdcQdQP0MXVJyz1fLtz5XFi7fYpUSG4G6HGJNwB7Iq+AffJ+iN70qPoWx4sPkTvS8S8edtNse4haP6xRwCWHJvcVy7zsnDElyg9ELyVKHPrzVc71knPq23qOqkwc4KIrg5BHucIt4/5JbUi95cV8eeMKs6lPZKscraThdxjN0ea9JVj3y6puOv/mj1bfUb5Bpth59ONuYJuZ08jwh3vLgdvYEWkwTPa3c1OOv3+xRvJspVD1HTOqkt57ReSG7Uxn9/R/VsgPJlS+GPzNYXtlpAG3mkrCAYVlQ1QLzc8PgqvLuSY/YkZhVxydEWjxIqmFuCf7lJAlhvSGQ8cfvdIDB7OU/HYVxTLOpB4JBfIt1eOof1Bdl5hHzsJ0ydLr/d7anp0g74eJqpy3sBXAJcopo2J1Otn7Rwa/xEdKRJx35MWolIDA0b64eBq37Rnd7MW+Ig66uhETjVl+B0j7xrMVx1N3dJJB1+ZxUEgyUIxUtOGnHEe2NAlYicb/tl+XECjEbEH/8kNJ4Di+XoiwwIIvIbhVUEqIAmqesGqMNXreRm0AvrwbAXYjre+Fz0ZtK7rtmNm5RRQDPwS95sy4JLDFpO4q7b3j0Pf/UQuowlA+wnxPrjmA
X-GND-State: clean
X-GND-Score: -100
X-Rspamd-Queue-Id: 193A2515EC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15793-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ghiti.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org,ghiti.fr];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.624];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ghiti.fr:email,ghiti.fr:mid]
X-Rspamd-Action: no action

Now that the memcg charging is decoupled from the kmem accounting, we
can't use obj_stock to handle the percpu accounting because our
precharged pages may get drained. That's a problem because we suppose
we have enough charged pages in pcpu_memcg_post_alloc_hook() and we cannot
charge more pages here because it may fail and would defeat the purpose of
the precharge.

So instead of using obj_stock, use a local per-node credit that fills
the same purpose whose surplus eventually gets refilled into the
stock.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 mm/percpu.c | 88 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 12 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 7c67dc2e4878..64b327fe3c26 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1614,6 +1614,16 @@ static struct pcpu_chunk *pcpu_chunk_addr_search(void *addr)
 }
 
 #ifdef CONFIG_MEMCG
+static unsigned int pcpu_memcg_nr_precharge_pages(size_t size)
+{
+	size_t total = pcpu_obj_total_size(size);
+
+	if (total < PAGE_SIZE)
+		return num_possible_nodes();
+
+	return PAGE_ALIGN(total) >> PAGE_SHIFT;
+}
+
 static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
 				      struct obj_cgroup **objcgp)
 {
@@ -1626,8 +1636,7 @@ static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
 	if (!objcg || obj_cgroup_is_root(objcg))
 		return true;
 
-	if (obj_cgroup_precharge(objcg, gfp,
-				 PAGE_ALIGN(pcpu_obj_total_size(size)) >> PAGE_SHIFT))
+	if (obj_cgroup_precharge(objcg, gfp, pcpu_memcg_nr_precharge_pages(size)))
 		return false;
 
 	*objcgp = objcg;
@@ -1642,29 +1651,68 @@ static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
 		return;
 
 	if (likely(chunk && chunk->obj_exts)) {
-		size_t total = pcpu_obj_total_size(size);
-		size_t remainder = PAGE_ALIGN(total) - total;
+		unsigned int nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+		unsigned int precharge_pages = pcpu_memcg_nr_precharge_pages(size);
+		unsigned int pages_used = 0;
+		unsigned int node_credit[MAX_NUMNODES] = { 0 };
+		unsigned int cpu;
+		int nid;
 
 		obj_cgroup_get(objcg);
 		chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].cgroup = objcg;
 
 		rcu_read_lock();
 		mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
-				total);
+				pcpu_obj_total_size(size));
 		rcu_read_unlock();
 
-		obj_cgroup_account_kmem(objcg, PAGE_ALIGN(total) >> PAGE_SHIFT);
-		if (remainder)
-			obj_cgroup_uncharge(objcg, remainder);
+		for_each_possible_cpu(cpu) {
+			unsigned int i;
+
+			for (i = 0; i < nr_pages; i++) {
+				void *addr = (void *)pcpu_chunk_addr(chunk, cpu,
+								     PFN_DOWN(off) + i);
+				size_t page_sz = i < nr_pages - 1 ?
+					PAGE_SIZE : size - (nr_pages - 1) * PAGE_SIZE;
+
+				nid = page_to_nid(pcpu_addr_to_page(addr));
+
+				if (node_credit[nid] < page_sz) {
+					struct obj_cgroup *nid_objcg;
+
+					nid_objcg = obj_cgroup_get_nid(objcg, nid);
+					obj_cgroup_account_kmem(nid_objcg, 1);
+					node_credit[nid] += PAGE_SIZE;
+					pages_used++;
+				}
+
+				node_credit[nid] -= page_sz;
+			}
+		}
+
+		/* Return unused precharged pages */
+		if (pages_used < precharge_pages)
+			obj_cgroup_unprecharge(objcg, precharge_pages - pages_used);
+
+		/* Put leftover per-node credit into stock */
+		for_each_online_node(nid) {
+			if (node_credit[nid] > 0) {
+				struct obj_cgroup *nid_objcg;
+
+				nid_objcg = obj_cgroup_get_nid(objcg, nid);
+				obj_cgroup_uncharge(nid_objcg, node_credit[nid]);
+			}
+		}
 	} else {
-		obj_cgroup_unprecharge(objcg,
-				       PAGE_ALIGN(pcpu_obj_total_size(size)) >> PAGE_SHIFT);
+		obj_cgroup_unprecharge(objcg, pcpu_memcg_nr_precharge_pages(size));
 	}
 }
 
 static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 {
+	unsigned int nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct obj_cgroup *objcg;
+	unsigned int cpu;
 
 	if (unlikely(!chunk->obj_exts))
 		return;
@@ -1674,13 +1722,29 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 		return;
 	chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].cgroup = NULL;
 
-	obj_cgroup_uncharge(objcg, pcpu_obj_total_size(size));
-
 	rcu_read_lock();
 	mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
 			-pcpu_obj_total_size(size));
 	rcu_read_unlock();
 
+	for_each_possible_cpu(cpu) {
+		unsigned int i;
+
+		for (i = 0; i < nr_pages; i++) {
+			void *addr = (void *)pcpu_chunk_addr(chunk, cpu,
+							     PFN_DOWN(off) + i);
+			struct obj_cgroup *nid_objcg;
+			int nid;
+			size_t unc;
+
+			nid = page_to_nid(pcpu_addr_to_page(addr));
+			nid_objcg = obj_cgroup_get_nid(objcg, nid);
+			unc = i < nr_pages - 1 ?
+				PAGE_SIZE : size - (nr_pages - 1) * PAGE_SIZE;
+			obj_cgroup_uncharge(nid_objcg, unc);
+		}
+	}
+
 	obj_cgroup_put(objcg);
 }
 
-- 
2.54.0


