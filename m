Return-Path: <cgroups+bounces-15786-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAKmME87AmrmpAEAu9opvQ
	(envelope-from <cgroups+bounces-15786-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:25:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE525515D4F
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90498300AD5F
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE473803CC;
	Mon, 11 May 2026 20:24:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E36337F8AF;
	Mon, 11 May 2026 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531042; cv=none; b=OvWkpdm3CSKnTY+QFKfCQJ1877n2WwBPlcxFYyc7UOZTktXiuZM8GIWBHM69+uDH6MK1IZk04RewAcT0Y2w7yJD3A8bjPMkFWC6EW0/waorGw6YVNd/RxQOz4I6pKHWxJL+ECX9q+ZFvo4916T6xJVVE6NdnZoExPCqg08etm+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531042; c=relaxed/simple;
	bh=ottbWNCozW/E0GWx9OSZ96mnvezRd5s592+823TvDXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ss0Ku9/PlfQO9xpdcK9zgKWPQwJSgZxyu5zXa0nuZtBLAJ7x6x7GGJDxx9mysFl5dhxy2qM2Yjy6D9Fb9Ah+VfUGk+uAc3muvYyQ9ZNml4YlMU3Ujv0MTzYAaWkqdHz0nAlM25xIMLfsaA9zaQGAv+6WBbg6AgtkB60tF8LCraA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 937503ECE6;
	Mon, 11 May 2026 20:23:52 +0000 (UTC)
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
Subject: [PATCH 2/8] mm: percpu: charge obj_exts allocation with __GFP_ACCOUNT
Date: Mon, 11 May 2026 22:20:37 +0200
Message-ID: <20260511202136.330358-3-alex@ghiti.fr>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGASuQ7DzVEqE1yqVdt2m1IEMvyeiZ424ZAVS1woSZRBsZRcHOaYxo/wRroa9V549fgoGhwPyYnAfDpxQNFtzkxj0I5TMeBg/5jBppJQkWIBRGnFCdwyKb3+iAwjbc6HCyc2w6Fq1RMe0bJWfA1ndpco4RPwk+ydi46o3tuXnoPGtt57UGuv0fBX6aLFC8egYVKjqd5+b/oNYSj52BJhnje7YewqzwfY3MT59q3IHUZSXd+23dBE9VioRxzwOkioSO0aPH0PeFEsizQ7P2RVgZRWW0PznWL4m6swkEsBSSzcbL/DhTQy/lqZtdEuHj15ch+irNHdmG3iRmpUdYJcCG6VjUkRv1CkAYeyLeY/WeI51J8zK2GwKBeBN5OksHWf2r5o5u5+IAeboS6rj/43jVZAM8d3ptRYaFHeAJRH+9ykvTPe/bp3QsiBT+hPJcdM6WWnHPfPpjq6gHXLjGld3vhrRBYlF3br8YCfbxTxcuTbmb1nTDrWF0SPI3Bzr4ehEZct3YzmFVu0298dC4cTla85fzXI0mOIAxmPr1BfuDjX6blbueZAupFdb528b9CNfjjy5LMx7D3f47MmwSNlErViLcMSol/rTMSALKoCZmCkoP2C6XvDfkXSDUR+SehKz6AywKbM7okGrkK+Y7XEEwOn2Ch6v0tk2bRBwaXZBEB1g
X-Rspamd-Queue-Id: CE525515D4F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15786-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ghiti.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org,ghiti.fr];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.647];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is a preparatory patch for upcoming per-memcg-per-node kmem
accounting.

pcpu allocations are always fully charged at once using
pcpu_obj_full_size(), which returns the size of the pcpu "metadata" +
pcpu "payload". But metadata and payload may not be allocated on the
same numa node, so charge the metadata independently from the payload.

Do this by explicitly passing __GFP_ACCOUNT to the obj_exts allocation
and remove its accounting in pcpu_memcg_pre_alloc_hook().

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 mm/percpu-internal.h | 16 +++-------------
 mm/percpu.c          | 15 ++++++++-------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 4b3d6ec43703..f01db026d213 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -144,22 +144,12 @@ static inline int pcpu_chunk_map_bits(struct pcpu_chunk *chunk)
 }
 
 /**
- * pcpu_obj_full_size - helper to calculate size of each accounted object
+ * pcpu_obj_total_size - helper to calculate size of each accounted object
  * @size: size of area to allocate in bytes
- *
- * For each accounted object there is an extra space which is used to store
- * obj_cgroup membership if kmemcg is not disabled. Charge it too.
  */
-static inline size_t pcpu_obj_full_size(size_t size)
+static inline size_t pcpu_obj_total_size(size_t size)
 {
-	size_t extra_size = 0;
-
-#ifdef CONFIG_MEMCG
-	if (!mem_cgroup_kmem_disabled())
-		extra_size += size / PCPU_MIN_ALLOC_SIZE * sizeof(struct obj_cgroup *);
-#endif
-
-	return size * num_possible_cpus() + extra_size;
+	return size * num_possible_cpus();
 }
 
 #ifdef CONFIG_PERCPU_STATS
diff --git a/mm/percpu.c b/mm/percpu.c
index b0676b8054ed..13de6e099d96 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1460,7 +1460,8 @@ static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
 	if (need_pcpuobj_ext()) {
 		chunk->obj_exts =
 			pcpu_mem_zalloc(pcpu_chunk_map_bits(chunk) *
-					sizeof(struct pcpuobj_ext), gfp);
+					sizeof(struct pcpuobj_ext),
+					gfp | __GFP_ACCOUNT);
 		if (!chunk->obj_exts)
 			goto objcg_fail;
 	}
@@ -1625,7 +1626,7 @@ static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
 	if (!objcg || obj_cgroup_is_root(objcg))
 		return true;
 
-	if (obj_cgroup_charge(objcg, gfp, pcpu_obj_full_size(size)))
+	if (obj_cgroup_charge(objcg, gfp, pcpu_obj_total_size(size)))
 		return false;
 
 	*objcgp = objcg;
@@ -1645,10 +1646,10 @@ static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
 
 		rcu_read_lock();
 		mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
-				pcpu_obj_full_size(size));
+				pcpu_obj_total_size(size));
 		rcu_read_unlock();
 	} else {
-		obj_cgroup_uncharge(objcg, pcpu_obj_full_size(size));
+		obj_cgroup_uncharge(objcg, pcpu_obj_total_size(size));
 	}
 }
 
@@ -1664,11 +1665,11 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 		return;
 	chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].cgroup = NULL;
 
-	obj_cgroup_uncharge(objcg, pcpu_obj_full_size(size));
+	obj_cgroup_uncharge(objcg, pcpu_obj_total_size(size));
 
 	rcu_read_lock();
 	mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
-			-pcpu_obj_full_size(size));
+			-pcpu_obj_total_size(size));
 	rcu_read_unlock();
 
 	obj_cgroup_put(objcg);
@@ -1897,7 +1898,7 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 
 	trace_percpu_alloc_percpu(_RET_IP_, reserved, is_atomic, size, align,
 				  chunk->base_addr, off, ptr,
-				  pcpu_obj_full_size(size), gfp);
+				  pcpu_obj_total_size(size), gfp);
 
 	pcpu_memcg_post_alloc_hook(objcg, chunk, off, size);
 
-- 
2.54.0


