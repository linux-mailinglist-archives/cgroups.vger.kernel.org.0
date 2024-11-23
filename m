Return-Path: <cgroups+bounces-5665-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DDC9D67CA
	for <lists+cgroups@lfdr.de>; Sat, 23 Nov 2024 07:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092C328218F
	for <lists+cgroups@lfdr.de>; Sat, 23 Nov 2024 06:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F84F16130C;
	Sat, 23 Nov 2024 06:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rcr+bqvh"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D959745F2
	for <cgroups@vger.kernel.org>; Sat, 23 Nov 2024 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732342201; cv=none; b=Z0hMsf7xFGc2fTxK1Ydfrdg9u7y99JZMg4TiCz8n+AxUMZWYgbzT8CPFzJ81o2QRmkTPxk68XqcbOiiAafWD4/E1nFtXB/XeasrCBLaIBsrFAU7Y6ixTYIHakcm0IwIOwXrdAp6cB3UDUw0EEeoF5gEfUXDRgO1ZVWqvuIVn6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732342201; c=relaxed/simple;
	bh=frRITaPzcBtAahtEMvvYVZTwXu3H/5fZcPsFOIOO5rE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L22S446Ykqu2+1KBxYiP/nhMu56yNGqzT7BKnp6kYQmKiv8sRVfgfzgzy++bmd45C8GmdBMtXBt5o9j3/+IJgqjfUrAza/vS8Bfh/YnXY39SeLzCYuWQ4IWLbJXGo8qxWz0gOZlVNH0GwEeBr6K5xt7kc6NodjwdZ9MyyEj054s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rcr+bqvh; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732342196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z/FHdAwT3UFixi6NAoa390cp3x+oKcU453tlU0Jllgg=;
	b=rcr+bqvh97kJeYUmM+cl1xZN0Y+4OVRSTvX5uBGjp3Yt/50tnLN6/6frxztIRMjCzd9iF7
	RgJ1Mwm+z8p9ega28RG5mV1SC8zfV++N/oJTIVMHELurBmacIifBdVqZ8G9usbW9VuhkxM
	7x2++VYXzMHlDIJ8mzHDJt9F87+LkQI=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] mm: mmap_lock: optimize mmap_lock tracepoints
Date: Fri, 22 Nov 2024 22:09:39 -0800
Message-ID: <20241123060939.169978-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We are starting to deploy mmap_lock tracepoint monitoring across our
fleet and the early results showed that these tracepoints are consuming
significant amount of CPUs in kernfs_path_from_node when enabled.

It seems like the kernel is trying to resolved the cgroup path in the
fast path of the locking code path when the tracepoints are enabled. In
addition for some application their metrics are regressing when
monitoring is enabled.

The cgroup path resolution can be slow and should not be done in the
fast path. Most userspace tools, like bpftrace, provides functionality
to get the cgroup path from cgroup id, so let's just trace the cgroup
id and the users can use better tools to get the path in the slow path.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h       | 18 ++++++++++++
 include/trace/events/mmap_lock.h | 32 ++++++++++----------
 mm/mmap_lock.c                   | 50 ++------------------------------
 3 files changed, 36 insertions(+), 64 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5502aa8e138e..d82f08cd70cd 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1046,6 +1046,19 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 
 void split_page_memcg(struct page *head, int old_order, int new_order);
 
+static inline u64 memcg_id_from_mm(struct mm_struct *mm)
+{
+	struct mem_cgroup *memcg;
+	u64 id = 0;
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
+	if (likely(memcg))
+		id = cgroup_id(memcg->css.cgroup);
+	rcu_read_unlock();
+	return id;
+}
+
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1466,6 +1479,11 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 static inline void split_page_memcg(struct page *head, int old_order, int new_order)
 {
 }
+
+static inline u64 memcg_id_from_mm(struct mm_struct *mm)
+{
+	return 0;
+}
 #endif /* CONFIG_MEMCG */
 
 /*
diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
index bc2e3ad787b3..5529933d19c5 100644
--- a/include/trace/events/mmap_lock.h
+++ b/include/trace/events/mmap_lock.h
@@ -5,6 +5,7 @@
 #if !defined(_TRACE_MMAP_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_MMAP_LOCK_H
 
+#include <linux/memcontrol.h>
 #include <linux/tracepoint.h>
 #include <linux/types.h>
 
@@ -12,64 +13,61 @@ struct mm_struct;
 
 DECLARE_EVENT_CLASS(mmap_lock,
 
-	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write),
+	TP_PROTO(struct mm_struct *mm, bool write),
 
-	TP_ARGS(mm, memcg_path, write),
+	TP_ARGS(mm, write),
 
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
-		__string(memcg_path, memcg_path)
+		__field(u64, memcg_id)
 		__field(bool, write)
 	),
 
 	TP_fast_assign(
 		__entry->mm = mm;
-		__assign_str(memcg_path);
+		__entry->memcg_id = memcg_id_from_mm(mm);
 		__entry->write = write;
 	),
 
 	TP_printk(
-		"mm=%p memcg_path=%s write=%s",
-		__entry->mm,
-		__get_str(memcg_path),
+		"mm=%p memcg_id=%llu write=%s",
+		__entry->mm, __entry->memcg_id,
 		__entry->write ? "true" : "false"
 	)
 );
 
 #define DEFINE_MMAP_LOCK_EVENT(name)                                    \
 	DEFINE_EVENT(mmap_lock, name,                                   \
-		TP_PROTO(struct mm_struct *mm, const char *memcg_path,  \
-			bool write),                                    \
-		TP_ARGS(mm, memcg_path, write))
+		TP_PROTO(struct mm_struct *mm, bool write),		\
+		TP_ARGS(mm, write))
 
 DEFINE_MMAP_LOCK_EVENT(mmap_lock_start_locking);
 DEFINE_MMAP_LOCK_EVENT(mmap_lock_released);
 
 TRACE_EVENT(mmap_lock_acquire_returned,
 
-	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
-		bool success),
+	TP_PROTO(struct mm_struct *mm, bool write, bool success),
 
-	TP_ARGS(mm, memcg_path, write, success),
+	TP_ARGS(mm, write, success),
 
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
-		__string(memcg_path, memcg_path)
+		__field(u64, memcg_id)
 		__field(bool, write)
 		__field(bool, success)
 	),
 
 	TP_fast_assign(
 		__entry->mm = mm;
-		__assign_str(memcg_path);
+		__entry->memcg_id = memcg_id_from_mm(mm);
 		__entry->write = write;
 		__entry->success = success;
 	),
 
 	TP_printk(
-		"mm=%p memcg_path=%s write=%s success=%s",
+		"mm=%p memcg_id=%llu write=%s success=%s",
 		__entry->mm,
-		__get_str(memcg_path),
+		__entry->memcg_id,
 		__entry->write ? "true" : "false",
 		__entry->success ? "true" : "false"
 	)
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index f186d57df2c6..e7dbaf96aa17 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -17,51 +17,7 @@ EXPORT_TRACEPOINT_SYMBOL(mmap_lock_start_locking);
 EXPORT_TRACEPOINT_SYMBOL(mmap_lock_acquire_returned);
 EXPORT_TRACEPOINT_SYMBOL(mmap_lock_released);
 
-#ifdef CONFIG_MEMCG
-
-/*
- * Size of the buffer for memcg path names. Ignoring stack trace support,
- * trace_events_hist.c uses MAX_FILTER_STR_VAL for this, so we also use it.
- */
-#define MEMCG_PATH_BUF_SIZE MAX_FILTER_STR_VAL
-
-#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)				\
-	do {								\
-		if (trace_mmap_lock_##type##_enabled()) {		\
-			char buf[MEMCG_PATH_BUF_SIZE];                  \
-			get_mm_memcg_path(mm, buf, sizeof(buf));        \
-			trace_mmap_lock_##type(mm, buf, ##__VA_ARGS__); \
-		}							\
-	} while (0)
-
-#else /* !CONFIG_MEMCG */
-
-#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
-	trace_mmap_lock_##type(mm, "", ##__VA_ARGS__)
-
-#endif /* CONFIG_MEMCG */
-
 #ifdef CONFIG_TRACING
-#ifdef CONFIG_MEMCG
-/*
- * Write the given mm_struct's memcg path to a buffer. If the path cannot be
- * determined, empty string is written.
- */
-static void get_mm_memcg_path(struct mm_struct *mm, char *buf, size_t buflen)
-{
-	struct mem_cgroup *memcg;
-
-	buf[0] = '\0';
-	memcg = get_mem_cgroup_from_mm(mm);
-	if (memcg == NULL)
-		return;
-	if (memcg->css.cgroup)
-		cgroup_path(memcg->css.cgroup, buf, buflen);
-	css_put(&memcg->css);
-}
-
-#endif /* CONFIG_MEMCG */
-
 /*
  * Trace calls must be in a separate file, as otherwise there's a circular
  * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
@@ -69,20 +25,20 @@ static void get_mm_memcg_path(struct mm_struct *mm, char *buf, size_t buflen)
 
 void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write)
 {
-	TRACE_MMAP_LOCK_EVENT(start_locking, mm, write);
+	trace_mmap_lock_start_locking(mm, write);
 }
 EXPORT_SYMBOL(__mmap_lock_do_trace_start_locking);
 
 void __mmap_lock_do_trace_acquire_returned(struct mm_struct *mm, bool write,
 					   bool success)
 {
-	TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, write, success);
+	trace_mmap_lock_acquire_returned(mm, write, success);
 }
 EXPORT_SYMBOL(__mmap_lock_do_trace_acquire_returned);
 
 void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write)
 {
-	TRACE_MMAP_LOCK_EVENT(released, mm, write);
+	trace_mmap_lock_released(mm, write);
 }
 EXPORT_SYMBOL(__mmap_lock_do_trace_released);
 #endif /* CONFIG_TRACING */
-- 
2.43.5


