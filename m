Return-Path: <cgroups+bounces-17846-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oU+/HodiV2pmKwEAu9opvQ
	(envelope-from <cgroups+bounces-17846-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:35:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E524275D0BB
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:35:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=lWVjevAk;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17846-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17846-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E255F3018429
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24987442137;
	Wed, 15 Jul 2026 10:35:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412AB44211D
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 10:35:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111740; cv=none; b=ObgSXA4ms7F7icIvaMwHBQMb/PxuIa1BkDJhGbdYDs4U7WxT6Rf+ZOD8Nbuyy/1WgUPZPeOsFrdOYDBS4/o08OWvRTjgIm9xUwbvW6mfD+jBT7bc+uvmLIPzLoIy/SaHEFxTyuMp7ggeLdBAZQi51ddLYhcdjBW32n7OgWZQTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111740; c=relaxed/simple;
	bh=SwdezaImxQcMt43h0jRN9TZ6bt6yTKaTU02f07mkxsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aV40SsjYD8kCCYOA/+iIU7RL1LcZrlvXCufUlU6k5X86u4J+jSWyPaCkfl2M5Ticg1tidZeqxNSXs1qsfrUeVx/65TfdgD/Rc+N7HaTms00gqkUkmrIHR3K1wpgKDnjF8o+Pe9MUsM1zUENajfvgt/07PVX+6E+t4CUTZ4a/TJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lWVjevAk; arc=none smtp.client-ip=91.218.175.171
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784111726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0PjHU3TbDnfGWF+iD96TKWS2XZ53YHp9da69Ponf0rw=;
	b=lWVjevAkYZ064aFltJs8lMrrHhbvW3jfDDXTJNUk7br0vYrO703lDuTQkLrrB6DW2oxclA
	CDTz4ntBIHKH7+v1OXbDtlB7q9AuF4Y9XDGtBTQ8/JYqvFRDPp3/uFjWpytuv6YlkxJ9HI
	zsJlgnUW59RhgT+41ErbmMD+ZA0Uy4k=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@fromorbit.com,
	dgc@kernel.org,
	qi.zheng@linux.dev,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	clm@fb.com,
	dsterba@suse.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	jack@suse.cz,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	kernel-team@meta.com
Cc: Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v2] fs: push nr_cached_objects memcg gating into individual filesystems
Date: Wed, 15 Jul 2026 03:35:16 -0700
Message-ID: <20260715103516.2410175-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17846-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:david@fromorbit.com,m:dgc@kernel.org,m:qi.zheng@linux.dev,m:baolin.wang@linux.alibaba.com,m:brauner@kernel.org,m:cgroups@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:hannes@cmpxchg.org,m:hughd@google.com,m:jack@suse.cz,m:linux-btrfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:mhocko@kernel.org,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:viro@zeniv.linux.org.uk,m:kernel-team@meta.com,m:usama.arif@linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim,suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E524275D0BB

Commit 0baad6f9b997 ("fs/super: skip non-memcg-aware nr_cached_objects
in memcg slab shrink") added a check in fs/super.c that skipped every
->nr_cached_objects() hook whenever the shrinker was invoked for a
non-root memcg, on the assumption that none of them honour sc->memcg.

That assumption is wrong for XFS, whose inode-reclaim hook is
intentionally driven from per-memcg contexts to free memcg-charged
slab. Encoding a blanket "never memcg-aware" policy in fs/super.c
short-circuits that path.

Push the check down into the callbacks whose counters really are
irrelevant to per-memcg reclaim - btrfs_nr_cached_objects() and
shmem_unused_huge_count() - and drop the fs/super.c gate. Each
filesystem can now lift the restriction independently if its counter
later grows memcg awareness, without touching fs/super.c.

Introduce mem_cgroup_shrink_is_root() in <linux/memcontrol.h> so the
callbacks don't open-code "sc->memcg is NULL or root".

Fixes: 0baad6f9b997 ("fs/super: skip non-memcg-aware nr_cached_objects in memcg slab shrink")
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
v1 -> v2:
- Do not gate xfs_fs_nr_cached_objects(); XFS's inode reclaim is
  intentionally driven from per-memcg contexts to free memcg-charged
  slab (Dave Chinner).
- Add mem_cgroup_shrink_is_root() helper in <linux/memcontrol.h> so the
  filesystem callbacks don't open-code "sc->memcg is NULL or root".
  (Dave Chinner)
- Add fixes tag (Dave Chinner)
---
 fs/btrfs/super.c           | 10 ++++++++++
 fs/super.c                 | 19 ++-----------------
 include/linux/memcontrol.h | 21 +++++++++++++++++++++
 mm/shmem.c                 | 10 ++++++++++
 4 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a7d804219bec..cc4537435399 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -22,6 +22,7 @@
 #include <linux/namei.h>
 #include <linux/miscdevice.h>
 #include <linux/magic.h>
+#include <linux/memcontrol.h>
 #include <linux/slab.h>
 #include <linux/ratelimit.h>
 #include <linux/crc32c.h>
@@ -2434,6 +2435,15 @@ static long btrfs_nr_cached_objects(struct super_block *sb, struct shrink_contro
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	const s64 nr = percpu_counter_read_positive(&fs_info->evictable_extent_maps);
 
+	/*
+	 * The evictable extent map counter is filesystem-global and does not
+	 * honour sc->memcg, so it is only meaningful on the global (kswapd or
+	 * root direct reclaim) shrink path. Skip the per-memcg iterations of
+	 * shrink_slab_memcg() to avoid queueing duplicate global work.
+	 */
+	if (!mem_cgroup_shrink_is_root(sc))
+		return 0;
+
 	trace_btrfs_extent_map_shrinker_count(fs_info, nr);
 
 	return nr;
diff --git a/fs/super.c b/fs/super.c
index d2d04a6f4f84..a8fd61136aaf 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -24,7 +24,6 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
-#include <linux/memcontrol.h>
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
@@ -170,19 +169,6 @@ static void super_wake(struct super_block *sb, unsigned int flag)
 	wake_up_var(&sb->s_flags);
 }
 
-/*
- * The s_op->nr_cached_objects hooks (used for example by btrfs and xfs)
- * operate on filesystem-global state and ignore sc->memcg. Driving them
- * from per-memcg shrink_slab_memcg() invocations only burns CPU walking
- * per-cpu counters and queueing duplicate work: the actual reclaim happens on
- * the global path (kswapd or root direct reclaim) regardless. Restrict them
- * to that path.
- */
-static inline bool super_fs_objects_eligible(struct shrink_control *sc)
-{
-	return !sc->memcg || mem_cgroup_is_root(sc->memcg);
-}
-
 /*
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
@@ -212,7 +198,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	if (!super_trylock_shared(sb))
 		return SHRINK_STOP;
 
-	if (sb->s_op->nr_cached_objects && super_fs_objects_eligible(sc))
+	if (sb->s_op->nr_cached_objects)
 		fs_objects = sb->s_op->nr_cached_objects(sb, sc);
 
 	inodes = list_lru_shrink_count(&sb->s_inode_lru, sc);
@@ -273,8 +259,7 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 		return 0;
 	smp_rmb();
 
-	if (sb->s_op && sb->s_op->nr_cached_objects &&
-	    super_fs_objects_eligible(sc))
+	if (sb->s_op && sb->s_op->nr_cached_objects)
 		total_objects = sb->s_op->nr_cached_objects(sb, sc);
 
 	total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e1f46a0016fc..5407e4200460 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -520,6 +520,22 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 	return (memcg == root_mem_cgroup);
 }
 
+/**
+ * mem_cgroup_shrink_is_root - is this a global or root-memcg shrink invocation?
+ * @sc: shrink_control describing the current shrinker call
+ *
+ * Returns true when @sc represents a global reclaim shrink (sc->memcg == NULL)
+ * or a root-memcg shrink, i.e. not a per-memcg iteration of
+ * shrink_slab_memcg(). Filesystems whose ->nr_cached_objects()/
+ * ->free_cached_objects() implementations operate on filesystem-global state
+ * and do not honour sc->memcg can use this to early-return 0 in per-memcg
+ * contexts.
+ */
+static inline bool mem_cgroup_shrink_is_root(struct shrink_control *sc)
+{
+	return !sc->memcg || mem_cgroup_is_root(sc->memcg);
+}
+
 static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
 {
 	return objcg->is_root;
@@ -1071,6 +1087,11 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 	return true;
 }
 
+static inline bool mem_cgroup_shrink_is_root(struct shrink_control *sc)
+{
+	return true;
+}
+
 static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
 {
 	return true;
diff --git a/mm/shmem.c b/mm/shmem.c
index 5789a0f5a346..dc8cd4f563f4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -846,6 +846,16 @@ static long shmem_unused_huge_count(struct super_block *sb,
 		struct shrink_control *sc)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+
+	/*
+	 * The per-superblock shrinklist is filesystem-global and does not
+	 * honour sc->memcg, so it is only meaningful on the global (kswapd or
+	 * root direct reclaim) shrink path. Skip the per-memcg iterations of
+	 * shrink_slab_memcg() to avoid queueing duplicate global work.
+	 */
+	if (!mem_cgroup_shrink_is_root(sc))
+		return 0;
+
 	return READ_ONCE(sbinfo->shrinklist_len);
 }
 #else /* !CONFIG_TRANSPARENT_HUGEPAGE */
-- 
2.53.0-Meta


