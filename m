Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE0644AEED
	for <lists+cgroups@lfdr.de>; Tue,  9 Nov 2021 14:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhKINoN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Nov 2021 08:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhKINoM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Nov 2021 08:44:12 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9039C061764
        for <cgroups@vger.kernel.org>; Tue,  9 Nov 2021 05:41:26 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id v20so20962063plo.7
        for <cgroups@vger.kernel.org>; Tue, 09 Nov 2021 05:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JGckYCKC3QkdmorCQBrCITV0xuJTY6O9SwWg8mL+BdQ=;
        b=6qbp9Ok8iGuglDC2shThRhER8hbZ8e0LEw0xFTjjSyMm8o877uHQg+ZRvG69MyHnq9
         HDlcrWjwFoDWE5cFGRO+H28PW8JbmP2vwYANGr2LbwIsxRzUtaEJwJET5AhwCiKwjJpN
         iIYZAkAwL0l8W373vktB/e/pGVcXBRZzjXqg39H9gaWiwBp6dxTCiTemCJ1/fTx20iPU
         aEDVSj/SFCxSPSiZKXJ+ZpDQ7+3sgPRSjf51y5YQRkUofRyrC5g0UCbRcagVO1sKXOyb
         uEuKNERuIXW4Sq5mjq3JfCmXPdx+X2ENAAxeThIqkm7Ms6xId7oopOQMjRtkxTRa2m5q
         Z8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JGckYCKC3QkdmorCQBrCITV0xuJTY6O9SwWg8mL+BdQ=;
        b=ZkkFFuXwmBFt3bbiN4pRAVZ0seIbjIuhSEmHtRCpVlBCRCzOZbjJR4KpuVpR1HWQKv
         i94+hTuX8wuTau+DsJQOJO77/R2EvOJrDvNhYo1F1rlGZVd+sjEoTcQWyO/ANOYgeqck
         vzcRXLsgJhIZ9/CtiNXCwLUlJmWjyRlhwhamGPtAaTf7q7h4FwoFphO4moPbPL/SqHHH
         ZC1kX75vXwNIUVZy7ocsxZ4JfBLT86EMsdg1jsmACG4diCaKQ0Jt7rTZxAzAZ7owzueC
         ijoiF4U8VcZJkVdgEEYyXT3tvDEpXn6io8Tw79zsB56FU47AjZJ3uZHgKniMSZ40q7Kq
         SVbg==
X-Gm-Message-State: AOAM532vWNx253oW4gr54JdSq6fQ5XqrlK0OxTv4qA9e8LRIreVdWC9x
        mEwZZjvtmigPN+8OrQGjWexFUg==
X-Google-Smtp-Source: ABdhPJwdT1FNusiCu32EShNsahIaRfVcIi6gvq8fqlCOCStKk0kdkAQx4Z7eIF0WDIHynJXYeEKXlA==
X-Received: by 2002:a17:90a:9606:: with SMTP id v6mr7179188pjo.27.1636465286239;
        Tue, 09 Nov 2021 05:41:26 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id k7sm16489930pgn.47.2021.11.09.05.41.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Nov 2021 05:41:25 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: slab: make slab iterator functions static
Date:   Tue,  9 Nov 2021 21:33:59 +0800
Message-Id: <20211109133359.32881-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There is no external users of slab_start/next/stop(), so make them
static. And the memory.kmem.slabinfo is deprecated, which outputs
nothing now, so move memcg_slab_show() into mm/memcontrol.c and
rename it to mem_cgroup_slab_show to be consistent with other
function names.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c  | 13 ++++++++++++-
 mm/slab.h        |  5 -----
 mm/slab_common.c | 17 +++--------------
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 781605e92015..8d63d4feaf6a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4845,6 +4845,17 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	return ret;
 }
 
+#if defined(CONFIG_MEMCG_KMEM) && (defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG))
+static int mem_cgroup_slab_show(struct seq_file *m, void *p)
+{
+	/*
+	 * Deprecated.
+	 * Please, take a look at tools/cgroup/slabinfo.py .
+	 */
+	return 0;
+}
+#endif
+
 static struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "usage_in_bytes",
@@ -4945,7 +4956,7 @@ static struct cftype mem_cgroup_legacy_files[] = {
 	(defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG))
 	{
 		.name = "kmem.slabinfo",
-		.seq_show = memcg_slab_show,
+		.seq_show = mem_cgroup_slab_show,
 	},
 #endif
 	{
diff --git a/mm/slab.h b/mm/slab.h
index 58c01a34e5b8..bf930ba8774d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -575,11 +575,6 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
 
 #endif
 
-void *slab_start(struct seq_file *m, loff_t *pos);
-void *slab_next(struct seq_file *m, void *p, loff_t *pos);
-void slab_stop(struct seq_file *m, void *p);
-int memcg_slab_show(struct seq_file *m, void *p);
-
 #if defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG)
 void dump_unreclaimable_slab(void);
 #else
diff --git a/mm/slab_common.c b/mm/slab_common.c
index e5d080a93009..3a5cad207a49 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1044,18 +1044,18 @@ static void print_slabinfo_header(struct seq_file *m)
 	seq_putc(m, '\n');
 }
 
-void *slab_start(struct seq_file *m, loff_t *pos)
+static void *slab_start(struct seq_file *m, loff_t *pos)
 {
 	mutex_lock(&slab_mutex);
 	return seq_list_start(&slab_caches, *pos);
 }
 
-void *slab_next(struct seq_file *m, void *p, loff_t *pos)
+static void *slab_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	return seq_list_next(p, &slab_caches, pos);
 }
 
-void slab_stop(struct seq_file *m, void *p)
+static void slab_stop(struct seq_file *m, void *p)
 {
 	mutex_unlock(&slab_mutex);
 }
@@ -1123,17 +1123,6 @@ void dump_unreclaimable_slab(void)
 	mutex_unlock(&slab_mutex);
 }
 
-#if defined(CONFIG_MEMCG_KMEM)
-int memcg_slab_show(struct seq_file *m, void *p)
-{
-	/*
-	 * Deprecated.
-	 * Please, take a look at tools/cgroup/slabinfo.py .
-	 */
-	return 0;
-}
-#endif
-
 /*
  * slabinfo_op - iterator that generates /proc/slabinfo
  *
-- 
2.11.0

