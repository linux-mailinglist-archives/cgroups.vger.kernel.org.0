Return-Path: <cgroups+bounces-16308-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bcL6M16IFWqGWQcAu9opvQ
	(envelope-from <cgroups+bounces-16308-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 13:47:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE515D51F8
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 13:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D404C300F787
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 11:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66D13EE1C2;
	Tue, 26 May 2026 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEBbuo8O"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52913EDAA3
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796007; cv=none; b=QjlFYCzcz4GTkPyUkKqnkiT3MvAbqKDLYP0qUlCHqCyF/56UP4QmkiDwoxsaZ2Oi702ni3gumcjM/jczzKF4IJJNrSNDgfRUv5yAAXgTRcCsJbvhJrWtSgxDyFogXE6JVjlC2d1QQ9xqLRlTXKwk1JDx+bPgPOV0oK+W18J6D98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796007; c=relaxed/simple;
	bh=xGgNsH72C/nIq69G4H4KYtqOBv468aDHxjm6I3eoGJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BXD96cv3+iTYW0QFynMgyZVjirztIGcPtyTO1jVlYXsq6u6l5Ygdp5S/5wpDeieM0II4esFyZNE8SyJDVYF9bHOR1gXYp5LeQ3b4jkQNij0i5ryIr3VcdxtgNiCXduLwH6r2Ma5LoibGnsI5OzlNz8gk9RrP7edzGU/dJkrbHpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEBbuo8O; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c736261ee8dso4690125a12.1
        for <cgroups@vger.kernel.org>; Tue, 26 May 2026 04:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779795996; x=1780400796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUCd8YO/TGnxTv33ZbkeaZ1htMubaCTkJySuysD11rI=;
        b=CEBbuo8Oy7QaYhbn6c3QqXY+/bXSlvXmw/jTQ3TMLuXOdYOVfwBOHSMTE2+nELLiBa
         obdLOs7Co5TmmPjEqk4SleFPvpXbN7J8uN6GOjx2jg8yL9JNDJnBhrqwzfaXwfzuYrTc
         3kfHbuOipuiJoWb3lLF2fN5Zqv6pS3ACR0XcHtgOjEJXft1vhnoYXGCdb2x2sJIj9FOC
         RaJPowBQHPQHziHf448w66JukGLOvqwe6XSlX/jKQnKhJrfkbOQ8EXIiH75bNs6D4Be2
         HTwimPAmW3RBu70xDYU7NuO+3fBWoEBkcMKnCc/vlyuQuM7GNABHI83A4bvmsi4GFEz5
         R36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779795996; x=1780400796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wUCd8YO/TGnxTv33ZbkeaZ1htMubaCTkJySuysD11rI=;
        b=VpjUrNVXSsbPpdtD2M+SqZ3DJRQFcXHzK3M293/Bu3gdQB9OZngtqzgUzlQwSrMTQb
         BoEHByus4hELv5y2EJBBWDqeUmXwrEcqu39eLxLBd1LtZkrhILUoYs7AwV7V2vQG1F6+
         vpGbgLYtZUm3e0Do8Mr/ekDUS7MJdTDoK7jv4faGVtYMvTZotxzYtUjLjq424ok/2Nj6
         s7+0HgcUtCFYDzCfsQlJL59h8Iihnro3D9M1eGiGWf5TmoPXCkmeJGGAQyZB4GxopgcR
         Zzoqo5pTHtA4vx91SwHqfkohyYWE4OH7UPi7u+u8tEIYfdTj4QyZviHmo0zKM8WRp96I
         7qMw==
X-Gm-Message-State: AOJu0YwB2N0EohcGLtGWTs/FwfOlzGkiYsOiVyYUAcZn5mxMfBiNJS0h
	IF00IpwukF8EWT7bYV1UsbN1YVXF3Xsa8zAJhZBp4F7yX2pVtJeuIltv
X-Gm-Gg: Acq92OHnLaMO6R9L5kL07cdgbtVaatGGb/LBnuqbLJBAhjUBwsx3WzSTGa1H0Xg7wJ+
	RgrXQAL/46WhJpM7YMbBCD99iWBGWtR0uMAwtPcqgy9B5421Ptk9f6qgbt44yOPuuakrEf47Tds
	b1wrm8iz/TaGVlWgJYHLC/B17ltV4yZy5ZnDQT4Z3U6WzRfy/UhP+CHMQTGRopYpg0oJN+o4mNQ
	PVJngHbuTISKAHltw5y97TtApUAEeVi51+ZuoAeSLTpStYNR1Zm7WcErlrouNFAovq9szOmorXi
	ynmEigtnseJNXLKYJ35PWu3RjTpAoFfrN8DThrPZmRlq9gEe0Sc2sWM6ao8RrLdTogSZlRL6YFq
	bniwarVV+M8Knnwr7ZN1T34xtxCU4VnnRbVHwZPFi2rXIxP91R7uYrBhPVkqODdjAxUv6i4NNaL
	qoNTH1l48F23/FHak2xqfeWfQ9qr7BO5o8XWAGsx716dNyDgDKWSA=
X-Received: by 2002:a05:6300:6d8d:20b0:3b3:9199:b1d4 with SMTP id adf61e73a8af0-3b39199c626mr3929480637.48.1779795996335;
        Tue, 26 May 2026 04:46:36 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852028fe99sm10304341a12.4.2026.05.26.04.46.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 04:46:35 -0700 (PDT)
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
Subject: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
Date: Tue, 26 May 2026 19:45:59 +0800
Message-Id: <20260526114601.67041-3-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260526114601.67041-1-jiahao.kernel@gmail.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16308-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DDE515D51F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hao Jia <jiahao1@lixiang.com>

Zswap currently writes back pages to backing swap reactively, triggered
either by the shrinker or when the pool reaches its size limit. There is
no mechanism to control the amount of writeback for a specific memory
cgroup. However, users may want to proactively write back zswap pages,
e.g., to free up memory for other applications or to prepare for
memory-intensive workloads.

Introduce a "zswap_writeback_only" key to the memory.reclaim cgroup
interface. When specified, this key bypasses standard memory reclaim
and exclusively performs proactive zswap writeback up to the requested
budget. If omitted, the default reclaim behavior remains unchanged.

Example usage:
  # Write back 100MB of pages from zswap to the backing swap
  echo "100M zswap_writeback_only" > memory.reclaim

Note that the actual amount written back may be less than requested due
to the zswap second-chance algorithm: referenced entries are rotated on
the LRU on the first encounter and only written back on a second pass.
If fewer bytes are written back than requested, -EAGAIN is returned,
matching the existing memory.reclaim semantics.

Internally, extend user_proactive_reclaim() to parse the new
"zswap_writeback_only" token and invoke the dedicated handler. Add
zswap_proactive_writeback() to walk the target memcg subtree via the
per-memcg writeback cursor, draining per-node zswap LRUs through
list_lru_walk_one() with the shrink_memcg_cb() callback.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  18 +++-
 Documentation/admin-guide/mm/zswap.rst  |  11 +-
 include/linux/zswap.h                   |   7 ++
 mm/vmscan.c                             |  14 +++
 mm/zswap.c                              | 138 ++++++++++++++++++++++++
 5 files changed, 185 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6efd0095ed99..6564abf0dec5 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1425,9 +1425,10 @@ PAGE_SIZE multiple when read back.
 
 The following nested keys are defined.
 
-	  ==========            ================================
+	  ====================  ==================================================
 	  swappiness            Swappiness value to reclaim with
-	  ==========            ================================
+	  zswap_writeback_only  Only perform proactive zswap writeback
+	  ====================  ==================================================
 
 	Specifying a swappiness value instructs the kernel to perform
 	the reclaim with that swappiness value. Note that this has the
@@ -1437,6 +1438,19 @@ The following nested keys are defined.
 	The valid range for swappiness is [0-200, max], setting
 	swappiness=max exclusively reclaims anonymous memory.
 
+	The zswap_writeback_only key skips ordinary memory reclaim and
+	writes back pages from zswap to the backing swap device until
+	the requested amount has been written or no further candidates
+	are found. This is useful to proactively offload cold pages from
+	the zswap pool to the swap device. It is only available if
+	zswap writeback is enabled. zswap_writeback_only cannot be combined
+	with swappiness; specifying both returns -EINVAL.
+
+	Example::
+
+	  # Write back up to 100MB of pages from zswap to the backing swap
+	  echo "100M zswap_writeback_only" > memory.reclaim
+
   memory.peak
 	A read-write single value file which exists on non-root cgroups.
 
diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index 2464425c783d..1c0598e77958 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -131,7 +131,16 @@ User can enable it as follows::
   echo Y > /sys/module/zswap/parameters/shrinker_enabled
 
 This can be enabled at the boot time if ``CONFIG_ZSWAP_SHRINKER_DEFAULT_ON`` is
-selected.
+selected. Once enabled, the shrinker automatically writes back zswap pages to
+backing swap during memory reclaim.
+
+If users want to explicitly trigger proactive zswap writeback for a specific
+memory cgroup without invoking standard page reclaim, it can be done as follows::
+
+	echo "100M zswap_writeback_only" > /sys/fs/cgroup/<cgroup-name>/memory.reclaim
+
+Both of the methods mentioned above are subject to the ``memory.zswap.writeback``
+control. This means that ``memory.zswap.writeback`` can reject all zswap writeback.
 
 A debugfs interface is provided for various statistic about pool size, number
 of pages stored, same-value filled pages and various counters for the reasons
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index efa6b551217e..98434d39339a 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -44,6 +44,7 @@ void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_folio_swapin(struct folio *folio);
 bool zswap_is_enabled(void);
 bool zswap_never_enabled(void);
+int zswap_proactive_writeback(struct mem_cgroup *memcg, unsigned long nr_to_writeback);
 #else
 
 struct zswap_lruvec_state {};
@@ -78,6 +79,12 @@ static inline bool zswap_never_enabled(void)
 	return true;
 }
 
+static inline int zswap_proactive_writeback(struct mem_cgroup *memcg,
+					    unsigned long nr_to_writeback)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
 
 #endif /* _LINUX_ZSWAP_H */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ca4533eba701..63fa4341b823 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -64,6 +64,7 @@
 
 #include <linux/swapops.h>
 #include <linux/sched/sysctl.h>
+#include <linux/zswap.h>
 
 #include "internal.h"
 #include "swap.h"
@@ -7856,11 +7857,13 @@ static unsigned long __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask,
 enum {
 	MEMORY_RECLAIM_SWAPPINESS = 0,
 	MEMORY_RECLAIM_SWAPPINESS_MAX,
+	MEMORY_RECLAIM_ZSWAP_WRITEBACK_ONLY,
 	MEMORY_RECLAIM_NULL,
 };
 static const match_table_t tokens = {
 	{ MEMORY_RECLAIM_SWAPPINESS, "swappiness=%d"},
 	{ MEMORY_RECLAIM_SWAPPINESS_MAX, "swappiness=max"},
+	{ MEMORY_RECLAIM_ZSWAP_WRITEBACK_ONLY, "zswap_writeback_only"},
 	{ MEMORY_RECLAIM_NULL, NULL },
 };
 
@@ -7870,6 +7873,7 @@ int user_proactive_reclaim(char *buf,
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	unsigned long nr_to_reclaim, nr_reclaimed = 0;
 	int swappiness = -1;
+	bool zswap_writeback_only = false;
 	char *old_buf, *start;
 	substring_t args[MAX_OPT_ARGS];
 	gfp_t gfp_mask = GFP_KERNEL;
@@ -7900,11 +7904,21 @@ int user_proactive_reclaim(char *buf,
 		case MEMORY_RECLAIM_SWAPPINESS_MAX:
 			swappiness = SWAPPINESS_ANON_ONLY;
 			break;
+		case MEMORY_RECLAIM_ZSWAP_WRITEBACK_ONLY:
+			zswap_writeback_only = true;
+			break;
 		default:
 			return -EINVAL;
 		}
 	}
 
+	if (zswap_writeback_only) {
+		/* zswap_writeback_only and swappiness are mutually exclusive. */
+		if (swappiness != -1)
+			return -EINVAL;
+		return zswap_proactive_writeback(memcg, nr_to_reclaim);
+	}
+
 	while (nr_reclaimed < nr_to_reclaim) {
 		/* Will converge on zero, but reclaim enforces a minimum */
 		unsigned long batch_size = (nr_to_reclaim - nr_reclaimed) / 4;
diff --git a/mm/zswap.c b/mm/zswap.c
index 73e64a635690..7bcbf788f634 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1679,6 +1679,144 @@ int zswap_load(struct folio *folio)
 	return 0;
 }
 
+/*
+ * Maximum LRU scan limit:
+ * number of entries to scan per page of remaining budget.
+ */
+#define ZSWAP_PROACTIVE_WB_SCAN_RATIO	16UL
+/*
+ * Batch size for proactive writeback:
+ * - As the per-memcg writeback target in the outer memcg loop.
+ * - As the per-walk budget passed to list_lru_walk_one().
+ */
+#define ZSWAP_PROACTIVE_WB_BATCH	128UL
+
+/*
+ * Walk the per-node LRUs of @memcg to write back up to @nr_to_write pages.
+ * Returns the number of pages written back, or -ENOENT if @memcg is a
+ * zombie or has writeback disabled.
+ */
+static long zswap_proactive_shrink_memcg(struct mem_cgroup *memcg,
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
+		bool encountered_page_in_swapcache = false;
+		unsigned long nr_to_scan, nr_scanned = 0;
+
+		/*
+		 * Cap by LRU length: bounds rewalks when referenced
+		 * entries keep rotating to the tail.
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
+			 * Account for the committed budget rather than the walker's
+			 * actual delta. If the list is emptied concurrently, the
+			 * walker visits nothing and nr_scanned would never advance.
+			 */
+			nr_scanned += nr_to_walk;
+
+			nr_written += list_lru_walk_one(&zswap_list_lru, nid, memcg,
+							&shrink_memcg_cb,
+							&encountered_page_in_swapcache,
+							&nr_to_walk);
+
+			if (nr_written >= nr_to_write)
+				return nr_written;
+			if (encountered_page_in_swapcache)
+				break;
+
+			cond_resched();
+		}
+	}
+
+	return nr_written;
+}
+
+int zswap_proactive_writeback(struct mem_cgroup *memcg,
+			      unsigned long nr_to_writeback)
+{
+	struct mem_cgroup *iter_memcg;
+	unsigned long nr_written = 0;
+	int failures = 0, attempts = 0;
+
+	if (!memcg)
+		return -EINVAL;
+	if (!nr_to_writeback)
+		return 0;
+
+	/*
+	 * Writeback will be aborted with -EAGAIN if we encounter
+	 * the following MAX_RECLAIM_RETRIES times:
+	 * - No writeback-candidate memcgs found in a subtree walk.
+	 * - A writeback-candidate memcg wrote back zero pages.
+	 */
+	while (nr_written < nr_to_writeback) {
+		unsigned long batch_size;
+		long shrunk;
+
+		if (signal_pending(current))
+			return -EINTR;
+
+		iter_memcg = zswap_mem_cgroup_iter(memcg);
+
+		if (!iter_memcg) {
+			/*
+			 * Continue without incrementing failures if we found
+			 * candidate memcgs in the last subtree walk.
+			 */
+			if (!attempts && ++failures == MAX_RECLAIM_RETRIES)
+				return -EAGAIN;
+			attempts = 0;
+			continue;
+		}
+
+		batch_size = min(nr_to_writeback - nr_written,
+				 ZSWAP_PROACTIVE_WB_BATCH);
+		shrunk = zswap_proactive_shrink_memcg(iter_memcg, batch_size);
+		mem_cgroup_put(iter_memcg);
+
+		/* Writeback-disabled or offline: skip without counting. */
+		if (shrunk == -ENOENT)
+			continue;
+
+		++attempts;
+		if (shrunk > 0)
+			nr_written += shrunk;
+		else if (++failures == MAX_RECLAIM_RETRIES)
+			return -EAGAIN;
+
+		cond_resched();
+	}
+
+	return 0;
+}
+
 void zswap_invalidate(swp_entry_t swp)
 {
 	pgoff_t offset = swp_offset(swp);
-- 
2.34.1


