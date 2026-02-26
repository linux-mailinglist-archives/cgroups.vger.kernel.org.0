Return-Path: <cgroups+bounces-14441-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLwCFmagoGlVlAQAu9opvQ
	(envelope-from <cgroups+bounces-14441-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 20:35:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ADD1AE685
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 20:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2A6730C8BBE
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 19:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BE53A1CE9;
	Thu, 26 Feb 2026 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL5z6dpN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131944DB8B
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134196; cv=none; b=gw1oGZRBfpLxiTmKS7G8ZgRu0dioAnRbZUQi4zZPnXvNlZyi1NzKLMMwT/oO1x27PZRz5kB1ocLAtsqsf2jEnJExDFn5+QoLlglEBuHtdzwertSR/dnHZLYoDRdp4KB51lIDreBuuTo7X1Hs4f1h3gwNo3E+AdFWMFb1+c+Dqrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134196; c=relaxed/simple;
	bh=yJ8hDpck92sFoRQLA5ASgE0Grx5gw3Jrij4YOy9XvEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtlA/t2Ursd6pVlNbu+3GTx0yZQQqSbKclPx3An2aTxsvSN8LP+73fkKCdmITCZtWZwm8NUasGBf7bafP7ghJTrTq8IpazJ2kUxtDx82kgAt723Xu5I6b2o3KrGQjBxogtv4upj0fq4uOr5jqS5ktKF+e9cwjaQtX0HFxx0oW8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL5z6dpN; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-463960df4f9so979057b6e.0
        for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 11:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134190; x=1772738990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQnJpZ9tlMxlAvSH4/u9efMTjBoGOkCwurLY+eANTp4=;
        b=WL5z6dpNtNOKuc28cuEB/g1Uxf7EYrfOUmTcSj7a3S5i9agIvvk0n92/iebzw/vqzR
         L0wZebi7eNeJPzDqLiNRYP2TTIyT/50ZQiDawAkc3+N/NBUQbOtYlHXaNZoWjbomcfIu
         GhsONQwAt0L5dEP2iTIbzixk/XfeXPXO8yLGQjy5vRbyZGG5lvIS/s1ziDbtB177eGRd
         +ODjomDPIB78K81ptkMsqhnPSDMJRKBbMvzD/Ndy6CkJQsiWrY3i7D0R7l8/ClVqEkS9
         Z+7jXQsLigvOpbtEkP8LPceFcWS8d/kCtZBJ/Q/LJGHd4Q1Fx6wXxGvKlW1LakXqHgcf
         WwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134190; x=1772738990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQnJpZ9tlMxlAvSH4/u9efMTjBoGOkCwurLY+eANTp4=;
        b=IKBjG5oWdFc4/qTZaY8hGJncE7rSSjyvyouBIRZ1K/Q36J4YYRMbkrqjbbQIthAJKi
         IW62765P1NQmH3B/4LfmfchDqbCmoSRMTx79pQUR8YssaWYU6hbUvsoybk6OSWlQ36T2
         U+783Z1RAnYdeolXmij/Fa0cwqbIbSyhEEdcRTacnGEkqtqE/NUzAH5T21VtgBNrkzkl
         YP51tDqVkbrtTmLp7SHKCB6tbVy+g8ZMBpyzHHM8oOR4AKA4DXyXgcKQ1Tszb4Loj7rK
         GRfrF8Equ8TckWBacb4+EBHfFnjdDKu6wDUSz9enxNagFDR4mmwKwyeKkSwNAAKLF7zK
         i1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCX1ofh+h6ZcadtucHFkO1gTtpA/SrlegPd7UgeCLf0N6Fse15qHuleOTfE17auxoq6SOdDG/ZFw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqzl+j+RkCGY3BdqbMTTt2wHztidItlVMGduKaiViQrIcPi3ie
	VGbybugYKfnWt/G719emPcyOG/CkZpXeL2IRZSbSGqnShd2SWfH+5LR2
X-Gm-Gg: ATEYQzwBjcwkJyEiTqvuWfChHC2koFFrg0uRQv/YG3vy+UPjSoDz02WEHr4tJBAw++N
	5BS3wQAJ7Wsuz2mWsPk5yDRMTO6cGLiZKlPs+mSdkZ7QpIaHEX7UhgRJ477WgMc7jbxLzl+IN/t
	0jEOjP3GVCzBDYlHXUhA7uY76MtX3j/5jM1b3MMji5ukTfJBrtaGGEUDZ8rGy+CAqgO9DNpYQcS
	wz0ZVCSbM0+mGLzcCwg6wmcwYbTTxy/emawSeTcs92ekUHuaMNGi9g+AiwRcTILj13d1LaXed38
	GuRLjI5cfaBbUFgE+h3ig6siv4a/RlWTHcd9ayID5CSbS9tGjMYTyGOExCrScpDILPd+Qod/xn4
	dmWJ1xnc6l8t3z529B8c2HiYibEGbn4l+ZTAlXm48s0Lz9a71Ys5fIXrg1xJ2i+HOo6d0jrpr7G
	pWa7j1Ul1TBVh14w8mapBrMQ==
X-Received: by 2002:a05:6808:c1e2:b0:45c:8c23:12b3 with SMTP id 5614622812f47-464bec872bdmr142745b6e.61.1772134189833;
        Thu, 26 Feb 2026 11:29:49 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4f::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb0991f5sm498612b6e.0.2026.02.26.11.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:29:48 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 6/8] mm/zsmalloc, zswap: Handle objcg charging and lifetime in zsmalloc
Date: Thu, 26 Feb 2026 11:29:29 -0800
Message-ID: <20260226192936.3190275-7-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226192936.3190275-1-joshua.hahnjy@gmail.com>
References: <20260226192936.3190275-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,gmail.com,kernel.org,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	TAGGED_FROM(0.00)[bounces-14441-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8ADD1AE685
X-Rspamd-Action: no action

Now that zswap_entries do not directly track obj_cgroups of the entries,
handle the lifetime management and charging of these entries into the
zsmalloc layer.

One functional change is that zswap entries are now no longer accounted
by the size of the compressed object, but by the size of the size_class
slot they occupy.

This brings the charging one step closer to an accurate representation
of the memory consumed in the zpdesc; even if a compressed object
doesn't consume the entirety of a obj slot, the hole it creates between
the objects is dead space the obj is accountable for.

Thus, account the memory each object makes unusable, not the amount of
memory each object takes up.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/memcontrol.h | 10 -------
 mm/memcontrol.c            | 51 ----------------------------------
 mm/zsmalloc.c              | 57 ++++++++++++++++++++++++++++++++++++--
 mm/zswap.c                 |  8 ------
 4 files changed, 55 insertions(+), 71 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b6c82c8f73e1..dd4278b1ca35 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1824,22 +1824,12 @@ static inline bool memcg_is_dying(struct mem_cgroup *memcg)
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
 bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
-void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
-void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
 bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg);
 #else
 static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 {
 	return true;
 }
-static inline void obj_cgroup_charge_zswap(struct obj_cgroup *objcg,
-					   size_t size)
-{
-}
-static inline void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg,
-					     size_t size)
-{
-}
 static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 {
 	/* if zswap is disabled, do not block pages going to the swapping device */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 007413a53b45..3432e1afc037 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5433,57 +5433,6 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 	return ret;
 }
 
-/**
- * obj_cgroup_charge_zswap - charge compression backend memory
- * @objcg: the object cgroup
- * @size: size of compressed object
- *
- * This forces the charge after obj_cgroup_may_zswap() allowed
- * compression and storage in zswap for this cgroup to go ahead.
- */
-void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
-{
-	struct mem_cgroup *memcg;
-
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return;
-
-	VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
-
-	/* PF_MEMALLOC context, charging must succeed */
-	if (obj_cgroup_charge(objcg, GFP_KERNEL, size))
-		VM_WARN_ON_ONCE(1);
-
-	rcu_read_lock();
-	memcg = obj_cgroup_memcg(objcg);
-	mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
-	mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
-	rcu_read_unlock();
-}
-
-/**
- * obj_cgroup_uncharge_zswap - uncharge compression backend memory
- * @objcg: the object cgroup
- * @size: size of compressed object
- *
- * Uncharges zswap memory on page in.
- */
-void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
-{
-	struct mem_cgroup *memcg;
-
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return;
-
-	obj_cgroup_uncharge(objcg, size);
-
-	rcu_read_lock();
-	memcg = obj_cgroup_memcg(objcg);
-	mod_memcg_state(memcg, MEMCG_ZSWAP_B, -size);
-	mod_memcg_state(memcg, MEMCG_ZSWAPPED, -1);
-	rcu_read_unlock();
-}
-
 bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 {
 	/* if zswap is disabled, do not block pages going to the swapping device */
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 067215a6ddcc..88c7cd399261 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -963,6 +963,44 @@ static bool alloc_zspage_objcgs(struct size_class *class, gfp_t gfp,
 	return true;
 }
 
+static void zs_charge_objcg(struct zpdesc *zpdesc, struct obj_cgroup *objcg,
+			    int size, unsigned long offset)
+{
+	struct mem_cgroup *memcg;
+
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return;
+
+	VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
+
+	/* PF_MEMALLOC context, charging must succeed */
+	if (obj_cgroup_charge(objcg, GFP_KERNEL, size))
+		VM_WARN_ON_ONCE(1);
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
+	mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
+	rcu_read_unlock();
+}
+
+static void zs_uncharge_objcg(struct zpdesc *zpdesc, struct obj_cgroup *objcg,
+			      int size, unsigned long offset)
+{
+	struct mem_cgroup *memcg;
+
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return;
+
+	obj_cgroup_uncharge(objcg, size);
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	mod_memcg_state(memcg, MEMCG_ZSWAP_B, -size);
+	mod_memcg_state(memcg, MEMCG_ZSWAPPED, -1);
+	rcu_read_unlock();
+}
+
 static void migrate_obj_objcg(unsigned long used_obj, unsigned long free_obj,
 			      int size)
 {
@@ -1018,6 +1056,12 @@ static bool alloc_zspage_objcgs(struct size_class *class, gfp_t gfp,
 	return true;
 }
 
+static void zs_charge_objcg(struct zpdesc *zpdesc, struct obj_cgroup *objcg,
+		            int size, unsigned long offset) {}
+
+static void zs_uncharge_objcg(struct zpdesc *zpdesc, struct obj_cgroup *objcg,
+			      int size, unsigned long offset) {}
+
 static void migrate_obj_objcg(unsigned long used_obj, unsigned long free_obj,
 			      int size) {}
 
@@ -1334,8 +1378,11 @@ void zs_obj_write(struct zs_pool *pool, unsigned long handle,
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
 
-	if (objcg)
+	if (objcg) {
+		obj_cgroup_get(objcg);
+		zs_charge_objcg(zpdesc, objcg, class->size, off);
 		zpdesc_set_obj_cgroup(zpdesc, obj_idx, class->size, objcg);
+	}
 
 	if (!ZsHugePage(zspage))
 		off += ZS_HANDLE_SIZE;
@@ -1501,6 +1548,7 @@ static void obj_free(int class_size, unsigned long obj)
 	struct link_free *link;
 	struct zspage *zspage;
 	struct zpdesc *f_zpdesc;
+	struct obj_cgroup *objcg;
 	unsigned long f_offset;
 	unsigned int f_objidx;
 	void *vaddr;
@@ -1510,7 +1558,12 @@ static void obj_free(int class_size, unsigned long obj)
 	f_offset = offset_in_page(class_size * f_objidx);
 	zspage = get_zspage(f_zpdesc);
 
-	zpdesc_set_obj_cgroup(f_zpdesc, f_objidx, class_size, NULL);
+	objcg = zpdesc_obj_cgroup(f_zpdesc, f_objidx, class_size);
+	if (objcg) {
+		zs_uncharge_objcg(f_zpdesc, objcg, class_size, f_offset);
+		obj_cgroup_put(objcg);
+		zpdesc_set_obj_cgroup(f_zpdesc, f_objidx, class_size, NULL);
+	}
 
 	vaddr = kmap_local_zpdesc(f_zpdesc);
 	link = (struct link_free *)(vaddr + f_offset);
diff --git a/mm/zswap.c b/mm/zswap.c
index 55161a5c9d4c..77d3c6516ed3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -711,10 +711,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	zs_free(entry->pool->zs_pool, entry->handle);
 	zswap_pool_put(entry->pool);
 
-	if (objcg) {
-		obj_cgroup_uncharge_zswap(objcg, entry->length);
-		obj_cgroup_put(objcg);
-	}
 	if (entry->length == PAGE_SIZE)
 		atomic_long_dec(&zswap_stored_incompressible_pages);
 	zswap_entry_cache_free(entry);
@@ -1437,10 +1433,6 @@ static bool zswap_store_page(struct page *page,
 	 * when the entry is removed from the tree.
 	 */
 	zswap_pool_get(pool);
-	if (objcg) {
-		obj_cgroup_get(objcg);
-		obj_cgroup_charge_zswap(objcg, entry->length);
-	}
 	atomic_long_inc(&zswap_stored_pages);
 	if (entry->length == PAGE_SIZE)
 		atomic_long_inc(&zswap_stored_incompressible_pages);
-- 
2.47.3


