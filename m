Return-Path: <cgroups+bounces-14732-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKJQOuoFsGlregIAu9opvQ
	(envelope-from <cgroups+bounces-14732-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 12:52:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 612CC24BB2D
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 12:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AE07308C456
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 11:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E189E3876D3;
	Tue, 10 Mar 2026 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I6slFtHH"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A02D387361;
	Tue, 10 Mar 2026 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142754; cv=none; b=sT6sfjsAWe8SOoDwR52/3GE1cF4cbRLeNgjkb85d/PeotzKKUMVwWC80EFmTGJpMpbx/EkvLkwSLsPNU4RQvKjufW51J8BoHQNNlRgHB7QI70MRehD+2q/lhENO2/ntjGvS9jXtft6chG2eqn3Vn553vKipcqpgcUni90vMK1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142754; c=relaxed/simple;
	bh=cxMVR6IX9dyBlWdtTxMmXlOemN7P7NKpH4TNjdg+5vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPR2FjUYnM9rODFNR0MCbZAC8lF9O0cZ4lTT+OYKPzNqtng+LURzeh8ZdQhhlEba+oxeSUS+vuxgAiI309vJj/H7jsh+x/4F+HgS43l/DmJ6O5SbQLyLJomF5dl+Xw+0kx5H0tizcBQkgkqxOdqoPWxE7dFecCBh7bUPmgRVSOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I6slFtHH; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2P
	j32kdU73jtg0RPPrl74jg5H3Dfkdxo7gX8u6gz0W4=; b=I6slFtHH7b6XoU4ZtK
	JOQZmU4X+zhk+Ii3QIxTkYg8QjveW1L6lTP9UGDOYKveh65rb5Z578OSr73hNyo7
	N+pxW9cFm6GgAC/vQpUKi8CUb33h4IFGsPkdUZn/bCLXqHyim+FWy/+098NZ+2Vu
	8q583NsBxI9hhsezEZVIro/mg=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXvQ+eArBpwhXAAA--.11763S4;
	Tue, 10 Mar 2026 19:38:10 +0800 (CST)
From: ranxiaokai627@163.com
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	harry.yoo@oracle.com,
	hao.li@linux.dev,
	cl@gentwo.org,
	rientjes@google.com
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] memcg: fix kmem over-charging for embedded obj_exts array
Date: Tue, 10 Mar 2026 11:38:04 +0000
Message-ID: <20260310113804.245647-3-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310113804.245647-1-ranxiaokai627@163.com>
References: <20260310113804.245647-1-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXvQ+eArBpwhXAAA--.11763S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1kCw4UJrW3ZF4ftw47Arb_yoW5Gr47pF
	y3C3sFy3yrZFZ7WrsFqFsru34fZ3yvvFyUCayxtr1kZFsxtw1vva1Yvry8JFZ8JFWxGF1q
	qrn8Kr1rWayUA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR58nnUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxgIve2mwAqJlqAAA3k
X-Rspamd-Queue-Id: 612CC24BB2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,zte.com.cn,163.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14732-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ranxiaokai627@163.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,zte.com.cn:email]
X-Rspamd-Action: no action

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Since commit a77d6d338685 ("mm/slab: place slabobj_ext metadata
in unused space within s->size"), the struct slabobj_ext array
can use slab leftover space or be embedded into the slub object
to save memory by calling alloc_slab_obj_exts_early(). In these
cases, no extra kmalloc space is allocated to store the obj_exts array.

Optimize obj_full_size() behavior to avoid over-charging kmem
for objects whose obj_exts use slab leftover space or are embedded
in the object.

Fixes: a77d6d338685 ("mm/slab: place slabobj_ext metadata in unused space within s->size")
Cc: stable@vger.kernel.org
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 mm/memcontrol.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 87614cfc4a3e..d6289a5cd6f3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3199,11 +3199,20 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 	refill_obj_stock(objcg, size, true, 0, NULL, 0);
 }
 
-static inline size_t obj_full_size(struct kmem_cache *s)
+static inline size_t obj_full_size(struct kmem_cache *s, struct slab *slab)
 {
+	if (obj_exts_in_slab(s, slab)) {
+		/*
+		 * If obj_exts array uses slab leftover space or is embedded
+		 * in object, no extra space is allocated, just charge the
+		 * object size.
+		 */
+		return s->size;
+	}
+
 	/*
-	 * For each accounted object there is an extra space which is used
-	 * to store obj_cgroup membership. Charge it too.
+	 * For caches whose obj_exts array is allocated separately
+	 * outside of slab, also charge the objcg pointer.
 	 */
 	return s->size + sizeof(struct obj_cgroup *);
 }
@@ -3270,7 +3279,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		 * TODO: we could batch this until slab_pgdat(slab) changes
 		 * between iterations, with a more complicated undo
 		 */
-		if (obj_cgroup_charge_account(objcg, flags, obj_full_size(s),
+		if (obj_cgroup_charge_account(objcg, flags, obj_full_size(s, slab),
 					slab_pgdat(slab), cache_vmstat_idx(s)))
 			return false;
 
@@ -3289,7 +3298,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 			    void **p, int objects, unsigned long obj_exts)
 {
-	size_t obj_size = obj_full_size(s);
+	size_t obj_size = obj_full_size(s, slab);
 
 	for (int i = 0; i < objects; i++) {
 		struct obj_cgroup *objcg;
-- 
2.25.1



