Return-Path: <cgroups+bounces-17318-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F46aIuJTPmoqDwkAu9opvQ
	(envelope-from <cgroups+bounces-17318-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 12:26:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 712D96CC11B
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 12:26:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17318-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17318-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65682300B281
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB83D3EEAF8;
	Fri, 26 Jun 2026 10:26:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335DD3EF0CD;
	Fri, 26 Jun 2026 10:26:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469595; cv=none; b=As0gXxl805HUmEzO1HkKGl8dhEb8gGMvIer0ZHbL+pnTzP/me6XdqBlYLa2Z1/GbVgnE8AimeMNsGXEhVinx3TlRcM91xCPtBSaHZX8HFtXIenyv+7ZlH9J3KybiPWNQeRAxNp854V9mt8lRbBk0QDvtujPaQIcGK5OGSvjGyaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469595; c=relaxed/simple;
	bh=URN1VHmVgBb3RpsysdLqm5wkdjNYhwAxOff/XOWWCNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjYAb3G8wJkmwFZmklvFvqWOV3l57zxN11CpK4I5aOqiihKujGHIgFb0EFeGKIqx4acvsasAELboNoQoTXAwSbpsZjk9XCCR2cHW//b7gSTITkUEQSe9RtKThgpSdyxzEU75ZCND+kZbpllPw19+M75whyQWQLdgSmaHWmH8nC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Received: by mail.gandi.net (Postfix) with ESMTPSA id CDD153EBFE;
	Fri, 26 Jun 2026 10:26:18 +0000 (UTC)
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
Subject: [PATCH v2 2/9] memcg: charge kmem pages and slab objects against per-node objcg
Date: Fri, 26 Jun 2026 12:20:51 +0200
Message-ID: <20260626102358.1603618-3-alex@ghiti.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626102358.1603618-1-alex@ghiti.fr>
References: <20260626102358.1603618-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFilqhOMXToAz/+gNdVKTxHRLavAczJtQ6fU64KH+lF2vkD6tw/iDgQXjhpHB5KEzd/dhU0FR5U7NLGKc+kze3Yd4z5yM7SzW2g38NVzcUbh7Bi280+j7Pwgwze/T7Xezbi0avOoCHg9Agp2B4VsPEZg0Pe+zE3KqBIKbVVfO+pPA7VF068h8hAVGLigEAJqQMAfxAXDxSQRnN6HLgy0sV9WDEI5cElrhqcUCInbpyl2UnqzXx1Hot7ncShsRn/QOdYuZaK4mX1gbrSnFEPnR0oUjPGEaH2gqxRCqT8ROg5bkk51r5Fi81YBaCKsfO7reIkwe+CYd0WYgge08+VXt0SsWuUNEv510K/mjnT0QlTJ28O3Zly/R3M0IV1u38J0dYc0Whpp1wC66RFwaI8QgLapQl9pScXF87j0GGVBT6JOOnYHNQTIJX22C7Y+s4qVApL52sZ4nJxo6MNDZwxZN8FR3g+iGQ0+uUdwCk5vpa1cvcqhkQdt2sq6CxJle/Q/45BtHu1yWG7zpMwUEoakKF5LMTquEYYbSO4C8RgS8X3ZdJEK+WtBWxlzZtyyW4b2FSzRUgFsmZPSQXw0mMtexoGZ91kfpc+ahiN1PGtfyOcv3lhvrF65v3X5/5wE3uEpHnMLFooDoeeklceAyVsMY04/2i4dY6i7sPaqdhn6ZzgpQ
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17318-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[ghiti.fr];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_RECIPIENTS(0.00)[m:alexandre@ghiti.fr,m:akpm@linux-foundation.org,m:axelrasmussen@google.com,m:baohua@kernel.org,m:bsegall@google.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:cl@gentwo.org,m:david@kernel.org,m:dennis@kernel.org,m:dietmar.eggemann@arm.com,m:mingo@redhat.com,m:hannes@cmpxchg.org,m:juri.lelli@redhat.com,m:kasong@tencent.com,m:kent.overstreet@linux.dev,m:kprateek.nayak@amd.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:mgorman@suse.de,m:mhocko@kernel.org,m:rppt@kernel.org,m:minchan@kernel.org,m:muchun.song@linux.dev,m:nphamcs@gmail.com,m:peterz@infradead.org,m:qi.zheng@linux.dev,m:roman.gushchin@linux.dev,m:senozhatsky@chromium.org,m:shakeel.butt@linux.dev,m:rostedt@goodmis.org,m:surenb@google.com,m:tj@kernel.org,m:vschneid@redhat.com,m:vincent.guittot@linaro.org,m:vbabka@kernel.org,m:weixugc@google.com,m:yosry@kernel.org,m:yuanchu@google.com,m:alex@ghiti.fr,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,linux.dev,gentwo.org,arm.com,redhat.com,cmpxchg.org,tencent.com,amd.com,infradead.org,kvack.org,suse.de,gmail.com,chromium.org,goodmis.org,linaro.org,ghiti.fr];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ghiti.fr:email,ghiti.fr:mid,ghiti.fr:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 712D96CC11B

From: Shakeel Butt <shakeel.butt@linux.dev>

After 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg
per-node type") current_obj_cgroup() returns the per-node objcg of the
task's memcg for numa_node_id(). Two callers in the kmem accounting
path always know the actual target node — the page being charged in
__memcg_kmem_charge_page() and each slab being charged in
__memcg_slab_post_alloc_hook() — but were using current_obj_cgroup()
and so charged against an objcg whose nid did not match the
allocation's physical node. The per-objcg vmstat batching (keyed by
objcg->nid) and per-node charge attribution were both routed to the
wrong sibling of the same memcg whenever the allocating CPU's node
differed from the allocation's node.

Factor the per-node objcg lookup into __current_obj_cgroup(int nid)
and keep current_obj_cgroup() as a one-line wrapper that passes
numa_node_id(), preserving all other callers. Use the new helper in:

  - __memcg_kmem_charge_page(): pass page_to_nid(page).
  - __memcg_slab_post_alloc_hook(): re-fetch inside the loop using
    slab_nid(slab) so each slab in a bulk allocation is charged
    against its own node's objcg. The early per-task root/NULL check
    above the loop remains (all per-node objcgs of a memcg share the
    same root-ness, so it is still a valid fast path); the in-loop
    check guards the transient drain window where one node's entry
    may be NULL.

Update the stale slab_pgdat(slab) reference in the TODO comment to
slab_nid(slab); slab_pgdat is no longer relevant after the
obj_stock_pcp cached_pgdat removal.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 mm/memcontrol.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ee47427de9e2..3bcc20e72914 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2987,12 +2987,11 @@ static struct obj_cgroup **current_objcg_update(void)
 	return objcgs;
 }
 
-__always_inline struct obj_cgroup *current_obj_cgroup(void)
+__always_inline static struct obj_cgroup *__current_obj_cgroup(int nid)
 {
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
 	struct obj_cgroup **objcgs;
-	int nid = numa_node_id();
 
 	if (IS_ENABLED(CONFIG_MEMCG_NMI_UNSAFE) && in_nmi())
 		return NULL;
@@ -3036,6 +3035,11 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
 	return rcu_dereference_check(root_mem_cgroup->nodeinfo[nid]->objcg, 1);
 }
 
+__always_inline struct obj_cgroup *current_obj_cgroup(void)
+{
+	return __current_obj_cgroup(numa_node_id());
+}
+
 struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 {
 	struct obj_cgroup *objcg;
@@ -3143,7 +3147,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 	struct obj_cgroup *objcg;
 	int ret = 0;
 
-	objcg = current_obj_cgroup();
+	objcg = __current_obj_cgroup(page_to_nid(page));
 	if (objcg && !obj_cgroup_is_root(objcg)) {
 		ret = obj_cgroup_charge_pages(objcg, gfp, 1 << order);
 		if (!ret) {
@@ -3536,7 +3540,9 @@ static inline size_t obj_full_size(struct kmem_cache *s)
 {
 	/*
 	 * For each accounted object there is an extra space which is used
-	 * to store obj_cgroup membership. Charge it too.
+	 * to store obj_cgroup membership. Charge it too. In addition, we
+	 * allocate obj_exts array on the same node as slab_nid(), so per-node
+	 * kmem accounting is fine.
 	 */
 	return s->size + sizeof(struct obj_cgroup *);
 }
@@ -3594,6 +3600,16 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 			continue;
 		}
 
+		/*
+		 * Charge against the per-node objcg matching the slab's node
+		 * so the stock's per-objcg vmstat batch (keyed by objcg->nid)
+		 * aligns with the physical slab. May transiently fall back to
+		 * root if the per-node entry is being drained.
+		 */
+		objcg = __current_obj_cgroup(slab_nid(slab));
+		if (!objcg || obj_cgroup_is_root(objcg))
+			continue;
+
 		/*
 		 * if we fail and size is 1, memcg_alloc_abort_single() will
 		 * just free the object, which is ok as we have not assigned
@@ -3602,7 +3618,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		 * for larger sizes, kmem_cache_free_bulk() will uncharge
 		 * any objects that were already charged and obj_ext assigned
 		 *
-		 * TODO: we could batch this until slab_pgdat(slab) changes
+		 * TODO: we could batch this until slab_nid(slab) changes
 		 * between iterations, with a more complicated undo
 		 */
 		stock = trylock_stock();
-- 
2.54.0


