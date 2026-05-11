Return-Path: <cgroups+bounces-15738-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDaaI661AWr2igEAu9opvQ
	(envelope-from <cgroups+bounces-15738-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:55:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 088E050C53E
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73BC0305C4C9
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 10:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93333CFF6F;
	Mon, 11 May 2026 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQoQZmIz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD89E3DA7F0
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496740; cv=none; b=CgvfNw4pXZvdaGmTxbgaJ4wX61ZaahLlTLhvl5roxdJVw7k7Hnew6A4WvPsbpSP1I2GCGhDWp3/y5PVQ6SjhPIkuTiVcG7vrv+0y+W41fpijhjLzlATSy/Xudd5s8pPreBkPNjTYL9GAwZtsNzpWalghrtlykTaCr+I8eiocjVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496740; c=relaxed/simple;
	bh=zcW9l857uawFCXHEiacEiugUR4qFm/g0jRguMBzUXGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTdDQ7GmcjcsRIsgAQ2zJKxVC7O+6fiELtuAqcbC0p+ZFNNI0Pf5SZUY1G6sJT1vmViabRjLzg7jBm4PLyWk7uPW+ozHiRfk8uomR+X3tLUQ6LR5wCqREmNLIpafsl1uMWyBW6j9QeqkLW7dn45pmR0Ji4AgCVQOXQw1hU2knj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQoQZmIz; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-366330b6751so2561494a91.1
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 03:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778496737; x=1779101537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fjW4dLeqWiYQdk+4k4SbCTrPHj2YrRsMiHdQFzx+K0=;
        b=XQoQZmIzHIzom6+33oKV5qAzXF3xOrSBjV7bx2WHu60V5nqLn6AAJTK5uDiYL2KB2q
         kKxqSnQK37ardhkuKRn7zVw6sQCzDror1sMpPA7QPaGj4FdM/jIKzNtVE5NBAipsFsjp
         Bj6o+3n2RxaQ/lMAcrQhomEjKJr/fB4mJRi70aL4a060xasJ7bYwSbcSL4YVev/XOTTf
         u/mW/s5lvar85VHpIP/s9Y8pQiw9/pwaVOhGQ3vQ1fAUmXtXk4slSM1aQ1+bZia5FaAS
         i5ChahXfdR1lftEjU8JBXpYDpJIxW9f/Gi71JPOdZFX6LvvizvnYG3aug5QeypYwW1Oe
         gH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778496737; x=1779101537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9fjW4dLeqWiYQdk+4k4SbCTrPHj2YrRsMiHdQFzx+K0=;
        b=ggwDZNgWRk6+cyRcpjXILzxztTTVi2OstFhnDEZ9MIbcTiRik6Y3pplb/RXtN1r58L
         GKz3D02vZfJcFD7Hu4TbgLEdejn3tlpcfp33CwxbdsR4hsU5ciHwwXdFyT7MTGbNemiG
         6PiDtncebxUd+u4WrzPosPBkJ2DAigPRWu8ipXPbRiPX5kddBq2jmRggXTcT8CDMDmXP
         MZhbuBETtdty7jpumhnxmt3WbRvpF2RVCXJTBvKBzxdklvF1kL/EK/bNhZ9ucdRE1dbp
         c3HKrGVngtL+B9eh6YcqlTl03yj1SsqpPlHp04Arg9FhysgJ1c+xWTWub8nOH8rCX44b
         yAEg==
X-Gm-Message-State: AOJu0YxKg5mfCqmVZ4TtcU/zAWgH7UXjukdPDwj1hcBy1hCZUIiSYj/R
	Kxiv6/HRKytNLeo0I8i6NSpuzRAZEJxqElhzOg/FXXhpxlwgT95S4RJz
X-Gm-Gg: Acq92OGzi1RlginVRRsMyhMentMR6XhtTfon2sp/8wK9HsQiFLIXIY8H9TvLpw5Zzjv
	esatfw6skF4h3p/PUJAL+ANmjfvXXaXChgQ8rXVlTxZhWMP7YIPcTuqIjNjQ78Y1mo1DQ3nj+4e
	G0Me0UdpcPe4m2P/OhOycEMUNRb89YkO2SZODawnQg7Rl1ETc//c6JXgm9mqwO+mYx1Gq1Lfh1X
	WsQtt2q3Kkgo/KfenwF8qXK/XM5QD+t/3eoNFv5zFHw+mb8ArvoUsUMX3TxRu0GSlIkKuudtMB/
	fz52V4w/wNtruAEBu0AXM8AL/JQN8G7xXTgRP57lqHfn353VuQrr9EwItdDSgbyUS/jkbwpS/fw
	3CIn5xOxvcBVVGSpXbX2YpKHOR0K5GCqAvl22EH/j92x7ol/IzJY7fvoH5HHpsGbydkBtt1Dg/A
	IHjZCPQrAc2MOVbh7fcvEFGvzZxEXIG2eUFpE99JYTb7yVby0TwggsoBsBWL15JA==
X-Received: by 2002:a17:90b:2e0e:b0:366:469d:98ec with SMTP id 98e67ed59e1d1-366469d99a0mr14958354a91.13.1778496737121;
        Mon, 11 May 2026 03:52:17 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d409eesm98571745ad.32.2026.05.11.03.52.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 May 2026 03:52:16 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: akpm@linux-foundation.org,
	tj@kernel.org,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org,
	yosry@kernel.org,
	mkoutny@suse.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: [PATCH 2/3] mm/zswap: Implement proactive writeback
Date: Mon, 11 May 2026 18:51:48 +0800
Message-Id: <20260511105149.75584-3-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260511105149.75584-1-jiahao.kernel@gmail.com>
References: <20260511105149.75584-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 088E050C53E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15738-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lixiang.com:email]
X-Rspamd-Action: no action

From: Hao Jia <jiahao1@lixiang.com>

Zswap currently writes back pages to backing swap devices reactively,
triggered either by memory pressure via the shrinker or by the pool
reaching its size limit. This reactive approach offers no precise
control over when writeback happens, which can disturb latency-sensitive
workloads, and it cannot direct writeback at a specific memory cgroup.
However, there are scenarios where users might want to proactively
write back cold pages from zswap to the backing swap device, for
example, to free up memory for other applications or to prepare for
upcoming memory-intensive workloads.

Therefore, implement a proactive writeback mechanism for zswap by
adding a new cgroup interface file memory.zswap.proactive_writeback
within the memory controller.

Users can trigger writeback by writing to this file with the following
parameters:
- max=<bytes>: The maximum amount of memory to write back (optional,
  default: unlimited).
- <age>: The minimum age of the pages to write back. Only pages that
  have been in zswap for at least this duration will be written back.

Example usage:
  # Write back pages older than 1 hour (3600 seconds), max 10MB
  echo "max=10M 3600" > memory.zswap.proactive_writeback

The implementation consists of:
1. Add store_time to struct zswap_entry to record when each entry was
   inserted into zswap, used for proactive writeback age comparison.
2. Introduce struct zswap_shrink_walk_arg, passed as the cb_arg to
   list_lru_walk_one() in both the shrinker and proactive paths. It
   carries the per-invocation cutoff_time and proactive flag down to
   shrink_memcg_cb(), and propagates the encountered_page_in_swapcache
   out-signal from the callback back to the caller.
3. Modify the callback function shrink_memcg_cb() to proactively
   writeback zswap_entries that meet the time threshold.
4. Add zswap_proactive_writeback() as the proactive writeback driver:
   a per-node batched list_lru_walk_one() loop bounded by the
   writeback budget.

Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  24 ++++
 include/linux/zswap.h                   |   8 ++
 mm/memcontrol.c                         |  76 ++++++++++
 mm/zswap.c                              | 176 ++++++++++++++++++++++--
 4 files changed, 276 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6efd0095ed99..05b664b3b3e8 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1908,6 +1908,30 @@ The following nested keys are defined.
 	This setting has no effect if zswap is disabled, and swapping
 	is allowed unless memory.swap.max is set to 0.
 
+  memory.zswap.proactive_writeback
+	A write-only nested-keyed file which exists in non-root cgroups.
+
+	This interface allows proactive writeback of pages from the zswap
+	pool to the backing swap device. This is useful to offload cold
+	pages from the zswap pool to the slower swap device. It is only
+	available if zswap writeback is enabled.
+
+	Users can trigger writeback by writing to this file with the following
+	parameters:
+
+	- "max=<bytes>" : Optional. The maximum amount of data to write back.
+	  (default: unlimited). Please note that the kernel can over or under
+	  writeback this value.
+
+	- "<age>" : Required. The minimum age of the pages to write back
+	  (in seconds). Only pages that have been in the zswap pool for at
+	  least this amount of time will be written back.
+
+	Example::
+
+	  # Write back pages older than 1 hour (3600 seconds), max 10MB
+	  echo "max=10M 3600" > memory.zswap.proactive_writeback
+
   memory.pressure
 	A read-only nested-keyed file.
 
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index efa6b551217e..7a51b4f95017 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -44,6 +44,8 @@ void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_folio_swapin(struct folio *folio);
 bool zswap_is_enabled(void);
 bool zswap_never_enabled(void);
+int zswap_proactive_writeback(struct mem_cgroup *root, unsigned long nr_max_writeback,
+			      ktime_t cutoff);
 #else
 
 struct zswap_lruvec_state {};
@@ -78,6 +80,12 @@ static inline bool zswap_never_enabled(void)
 	return true;
 }
 
+static inline int zswap_proactive_writeback(struct mem_cgroup *root,
+					    unsigned long nr_max_writeback, ktime_t cutoff)
+{
+	return 0;
+}
+
 #endif
 
 #endif /* _LINUX_ZSWAP_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 409c41359dc8..ba7f7b1954a8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -70,6 +70,7 @@
 #include "memcontrol-v1.h"
 
 #include <linux/uaccess.h>
+#include <linux/parser.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/memcg.h>
@@ -5891,6 +5892,76 @@ static ssize_t zswap_writeback_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+enum {
+	ZSWAP_WRITEBACK_MAX,
+	ZSWAP_WRITEBACK_AGE,
+	ZSWAP_WRITEBACK_ERR,
+};
+
+static const match_table_t zswap_writeback_tokens = {
+	{ ZSWAP_WRITEBACK_MAX, "max=%s" },
+	{ ZSWAP_WRITEBACK_AGE, "%u" },
+	{ ZSWAP_WRITEBACK_ERR, NULL },
+};
+
+static ssize_t zswap_proactive_writeback_write(struct kernfs_open_file *of,
+					       char *buf, size_t nbytes,
+					       loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	unsigned long nr_max_writeback = ULONG_MAX;
+	substring_t args[MAX_OPT_ARGS];
+	unsigned int age_sec;
+	bool age_set = false;
+	ktime_t cutoff_time;
+	char *token, *end;
+	int err;
+
+	if (!mem_cgroup_zswap_writeback_enabled(memcg))
+		return -EINVAL;
+
+	buf = strstrip(buf);
+
+	while ((token = strsep(&buf, " ")) != NULL) {
+		if (!strlen(token))
+			continue;
+
+		switch (match_token(token, zswap_writeback_tokens, args)) {
+		case ZSWAP_WRITEBACK_MAX:
+			nr_max_writeback = memparse(args[0].from, &end);
+			if (*end != '\0')
+				return -EINVAL;
+			nr_max_writeback >>= PAGE_SHIFT;
+			break;
+		case ZSWAP_WRITEBACK_AGE:
+			if (age_set)
+				return -EINVAL;
+
+			if (match_uint(&args[0], &age_sec))
+				return -EINVAL;
+			age_set = true;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (!age_set || !age_sec || !nr_max_writeback)
+		return -EINVAL;
+
+	cutoff_time = ktime_sub(ktime_get_boottime(),
+				ns_to_ktime((u64)age_sec * NSEC_PER_SEC));
+	/* age_sec >= uptime: no entry can be that old, skip the walk. */
+	if (ktime_to_ns(cutoff_time) <= 0)
+		return nbytes;
+
+	err = zswap_proactive_writeback(memcg, nr_max_writeback, cutoff_time);
+	if (err)
+		return err;
+
+	return nbytes;
+}
+
 static struct cftype zswap_files[] = {
 	{
 		.name = "zswap.current",
@@ -5908,6 +5979,11 @@ static struct cftype zswap_files[] = {
 		.seq_show = zswap_writeback_show,
 		.write = zswap_writeback_write,
 	},
+	{
+		.name = "zswap.proactive_writeback",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.write = zswap_proactive_writeback_write,
+	},
 	{ }	/* terminate */
 };
 #endif /* CONFIG_ZSWAP */
diff --git a/mm/zswap.c b/mm/zswap.c
index 19538d6f169a..1173ac6836fa 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -36,6 +36,7 @@
 #include <linux/workqueue.h>
 #include <linux/list_lru.h>
 #include <linux/zsmalloc.h>
+#include <linux/timekeeping.h>
 
 #include "swap.h"
 #include "internal.h"
@@ -160,6 +161,12 @@ struct zswap_pool {
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
 };
 
+struct zswap_shrink_walk_arg {
+	ktime_t cutoff_time;
+	bool proactive;
+	bool encountered_page_in_swapcache;
+};
+
 /* Global LRU lists shared by all zswap pools. */
 static struct list_lru zswap_list_lru;
 
@@ -183,6 +190,7 @@ static struct shrinker *zswap_shrinker;
  * handle - zsmalloc allocation handle that stores the compressed page data
  * objcg - the obj_cgroup that the compressed memory is charged to
  * lru - handle to the pool's lru used to evict pages.
+ * store_time - Time when the entry was stored, for proactive writeback.
  */
 struct zswap_entry {
 	swp_entry_t swpentry;
@@ -192,6 +200,7 @@ struct zswap_entry {
 	unsigned long handle;
 	struct obj_cgroup *objcg;
 	struct list_head lru;
+	ktime_t store_time;
 };
 
 static struct xarray *zswap_trees[MAX_SWAPFILES];
@@ -1148,10 +1157,19 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 				       void *arg)
 {
 	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
-	bool *encountered_page_in_swapcache = (bool *)arg;
-	swp_entry_t swpentry;
+	struct zswap_shrink_walk_arg *walk_arg = arg;
+	bool proactive_wb = walk_arg && walk_arg->proactive;
 	enum lru_status ret = LRU_REMOVED_RETRY;
 	int writeback_result;
+	swp_entry_t swpentry;
+
+	/*
+	 * For proactive writeback, rotate young entries to the LRU tail
+	 * so that subsequent list_lru_walk_one() batches start past
+	 * them.
+	 */
+	if (proactive_wb && ktime_after(entry->store_time, walk_arg->cutoff_time))
+		return LRU_ROTATE;
 
 	/*
 	 * Second chance algorithm: if the entry has its referenced bit set, give it
@@ -1160,7 +1178,9 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 	 */
 	if (entry->referenced) {
 		entry->referenced = false;
-		return LRU_ROTATE;
+		/* Proactive writeback is an explicit hint; don't rotate. */
+		if (!proactive_wb)
+			return LRU_ROTATE;
 	}
 
 	/*
@@ -1214,9 +1234,9 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 		 * into the warmer region. We should terminate shrinking (if we're in the dynamic
 		 * shrinker context).
 		 */
-		if (writeback_result == -EEXIST && encountered_page_in_swapcache) {
+		if (writeback_result == -EEXIST && walk_arg) {
 			ret = LRU_STOP;
-			*encountered_page_in_swapcache = true;
+			walk_arg->encountered_page_in_swapcache = true;
 		}
 	} else {
 		zswap_written_back_pages++;
@@ -1228,8 +1248,12 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 		struct shrink_control *sc)
 {
+	struct zswap_shrink_walk_arg walk_arg = {
+		.cutoff_time = KTIME_MAX,
+		.proactive = false,
+		.encountered_page_in_swapcache = false,
+	};
 	unsigned long shrink_ret;
-	bool encountered_page_in_swapcache = false;
 
 	if (!zswap_shrinker_enabled ||
 			!mem_cgroup_zswap_writeback_enabled(sc->memcg)) {
@@ -1238,9 +1262,9 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 	}
 
 	shrink_ret = list_lru_shrink_walk(&zswap_list_lru, sc, &shrink_memcg_cb,
-		&encountered_page_in_swapcache);
+					  &walk_arg);
 
-	if (encountered_page_in_swapcache)
+	if (walk_arg.encountered_page_in_swapcache)
 		return SHRINK_STOP;
 
 	return shrink_ret ? shrink_ret : SHRINK_STOP;
@@ -1508,6 +1532,7 @@ static bool zswap_store_page(struct page *page,
 	entry->swpentry = page_swpentry;
 	entry->objcg = objcg;
 	entry->referenced = true;
+	entry->store_time = ktime_get_boottime();
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
 		zswap_lru_add(&zswap_list_lru, entry);
@@ -1681,6 +1706,141 @@ int zswap_load(struct folio *folio)
 	return 0;
 }
 
+/* Cap LRU scan to this many entries per page of remaining budget. */
+#define ZSWAP_PROACTIVE_WB_SCAN_RATIO	16UL
+/*
+ * Batch size for proactive writeback, used both as the per-memcg
+ * writeback target in the outer memcg loop and as the per-walk budget
+ * for list_lru_walk_one().
+ */
+#define ZSWAP_PROACTIVE_WB_BATCH	128UL
+
+/*
+ * Walk @memcg's per-node LRUs, writing back entries older than @cutoff
+ * up to @nr_to_write pages. Returns the number of pages written back,
+ * or -ENOENT if @memcg is a zombie or has writeback disabled.
+ */
+static long zswap_proactive_shrink_memcg(struct mem_cgroup *memcg,
+					 ktime_t cutoff,
+					 unsigned long nr_to_write)
+{
+	unsigned long nr_written = 0;
+	int nid;
+
+	if (!mem_cgroup_zswap_writeback_enabled(memcg))
+		return -ENOENT;
+
+	if (!mem_cgroup_online(memcg))
+		return -ENOENT;
+
+	for_each_node_state(nid, N_NORMAL_MEMORY) {
+		struct zswap_shrink_walk_arg walk_arg = {
+			.cutoff_time = cutoff,
+			.proactive = true,
+			.encountered_page_in_swapcache = false,
+		};
+		unsigned long nr_to_scan, nr_scanned = 0;
+
+		/*
+		 * Cap by LRU length: bounds rewalks when entries keep
+		 * rotating (young or referenced).
+		 */
+		nr_to_scan = list_lru_count_one(&zswap_list_lru, nid, memcg);
+		if (!nr_to_scan)
+			continue;
+
+		/*
+		 * Cap by SCAN_RATIO * remaining budget: bounds scan cost
+		 * to the remaining writeback budget.
+		 */
+		nr_to_scan = min(nr_to_scan,
+				 (nr_to_write - nr_written) * ZSWAP_PROACTIVE_WB_SCAN_RATIO);
+
+		while (nr_scanned < nr_to_scan) {
+			unsigned long nr_to_walk = min(ZSWAP_PROACTIVE_WB_BATCH,
+						       nr_to_scan - nr_scanned);
+
+			if (signal_pending(current))
+				return nr_written;
+
+			/*
+			 * Account the committed budget rather than the walker's
+			 * actual delta: if the list empties under us the walker
+			 * visits nothing and nr_scanned would never advance.
+			 */
+			nr_scanned += nr_to_walk;
+
+			nr_written += list_lru_walk_one(&zswap_list_lru, nid, memcg,
+							&shrink_memcg_cb, &walk_arg,
+							&nr_to_walk);
+
+			if (nr_written >= nr_to_write)
+				return nr_written;
+			if (walk_arg.encountered_page_in_swapcache)
+				break;
+
+			cond_resched();
+		}
+	}
+
+	return nr_written;
+}
+
+int zswap_proactive_writeback(struct mem_cgroup *root,
+			      unsigned long nr_max_writeback,
+			      ktime_t cutoff)
+{
+	struct mem_cgroup *memcg;
+	unsigned long nr_written = 0;
+	int failures = 0, attempts = 0;
+
+	/*
+	 * Writeback will be aborted with -EAGAIN if @nr_written is still
+	 * zero and we encounter the following MAX_RECLAIM_RETRIES times:
+	 * - No writeback-candidate memcgs found in a subtree walk.
+	 * - A writeback-candidate memcg wrote back zero pages.
+	 */
+	while (nr_written < nr_max_writeback) {
+		unsigned long nr_to_write;
+		long shrunk;
+
+		if (signal_pending(current))
+			return -EINTR;
+
+		memcg = zswap_mem_cgroup_iter(root);
+
+		if (!memcg) {
+			/*
+			 * Continue without incrementing failures if we found
+			 * candidate memcgs in the last subtree walk.
+			 */
+			if (!attempts && ++failures == MAX_RECLAIM_RETRIES)
+				goto out;
+			attempts = 0;
+			continue;
+		}
+
+		nr_to_write = min(nr_max_writeback - nr_written,
+				  ZSWAP_PROACTIVE_WB_BATCH);
+		shrunk = zswap_proactive_shrink_memcg(memcg, cutoff, nr_to_write);
+		mem_cgroup_put(memcg);
+
+		/* Writeback-disabled or offline: skip without counting. */
+		if (shrunk == -ENOENT)
+			continue;
+
+		++attempts;
+		if (shrunk > 0)
+			nr_written += shrunk;
+		else if (++failures == MAX_RECLAIM_RETRIES)
+			goto out;
+
+		cond_resched();
+	}
+out:
+	return nr_written ? 0 : -EAGAIN;
+}
+
 void zswap_invalidate(swp_entry_t swp)
 {
 	pgoff_t offset = swp_offset(swp);
-- 
2.34.1


