Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F5433CA14
	for <lists+cgroups@lfdr.de>; Tue, 16 Mar 2021 00:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhCOXl0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 19:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhCOXlC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Mar 2021 19:41:02 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2112C061756
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 16:41:01 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id m7so10456142qtq.11
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 16:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sHh364PFI7gr7Rg7wpaysNQPtI9BiNpDxSsKea0W7pA=;
        b=KbheRMtg2robQTyXPOEUrlWiONJ6e2isDPkgv9TYBs4HWXHrRdzR9F4j8VM+dTeX2M
         eabV8ybFsCDihGBWhwgMPDDTOX737BCr06IpzJThWzsqHtEJiT5yZZq3Z89KjreYoS2W
         9GMEiDZw38HOxAu7Z1TuHEAcU6cUTzw/i3xPEKKtM4aJJtASYaaboQmNpTbWdtH+uOIs
         tAPWz2umjmR8R0K+EHsBDPmG35CNquRmgrNIM+onWovfmkuPW6eYCeH4T0Bg0KGQ1Jbo
         2m7pNiKU76I12k+7IUBC77cbwWHyrwEwwo1g1QPp8LoL/FS4EHStaALOmG1cd3x7bIUn
         ms7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sHh364PFI7gr7Rg7wpaysNQPtI9BiNpDxSsKea0W7pA=;
        b=GaTegRFtPSiYw66ZsB7Wb4jJcpp7oc+rQ/UvICMcUiUsqlPiQhbGzbHKyY+LV4O39B
         zT5+Y8B4EYJJafx9JALCXoPZCDthkYQa5OqKVnRMhUd6eZ/BiDfGzrEI6oXqvlOyJhZx
         FgjseQdHyhcG/4it8qcPWv+22o186BkHdNNO0n23OyATf9CeBc1aVlTzyL2eObel4v0K
         M+bwSiX5ezaXlr9hfAj9WejTDANFK9uuKC/FYRpB5N26gtyG/HBPI7EtOfkVF3ZZ7hGo
         h9YxPCPTsft7qYUrFa9arfLiJCemGSAropgs6DiclsynIB+YzJBEBy0HNbC3NKzLAYxy
         KA6g==
X-Gm-Message-State: AOAM531oah6Eslv60GGwTyQ3fhSbmuNAZrPWfSsy1D+hDGE8UfGLvnp4
        WrQIpJeQbRUs0f66WiYJ8dcVog==
X-Google-Smtp-Source: ABdhPJz9md7FgYM4eYPuO/5SfyVzkVTi0KXgspL4ZAqLFAN4N7SNYwrgpLRwef8H/S3+tBIwqC2sgw==
X-Received: by 2002:ac8:1186:: with SMTP id d6mr14164688qtj.124.1615851661253;
        Mon, 15 Mar 2021 16:41:01 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id o7sm13242112qki.63.2021.03.15.16.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 16:41:00 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] mm: memcontrol: switch to rstat fix
Date:   Mon, 15 Mar 2021 19:41:00 -0400
Message-Id: <20210315234100.64307-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Fix a sleep in atomic section problem: wb_writeback() takes a spinlock
and calls wb_over_bg_thresh() -> mem_cgroup_wb_stats, but the regular
rstat flushing function called from in there does lockbreaking and may
sleep. Switch to the atomic variant, cgroup_rstat_irqsafe().

To be consistent with other memcg flush calls, but without adding
another memcg wrapper, inline and drop memcg_flush_vmstats() instead.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f7fb12d3c2fc..9091913ec877 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -757,11 +757,6 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 	return mz;
 }
 
-static void memcg_flush_vmstats(struct mem_cgroup *memcg)
-{
-	cgroup_rstat_flush(memcg->css.cgroup);
-}
-
 /**
  * __mod_memcg_state - update cgroup memory statistics
  * @memcg: the memory cgroup
@@ -1572,7 +1567,7 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	 *
 	 * Current memory state:
 	 */
-	memcg_flush_vmstats(memcg);
+	cgroup_rstat_flush(memcg->css.cgroup);
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
@@ -3523,7 +3518,7 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 	unsigned long val;
 
 	if (mem_cgroup_is_root(memcg)) {
-		memcg_flush_vmstats(memcg);
+		cgroup_rstat_flush(memcg->css.cgroup);
 		val = memcg_page_state(memcg, NR_FILE_PAGES) +
 			memcg_page_state(memcg, NR_ANON_MAPPED);
 		if (swap)
@@ -3925,7 +3920,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	int nid;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	memcg_flush_vmstats(memcg);
+	cgroup_rstat_flush(memcg->css.cgroup);
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
@@ -3997,7 +3992,7 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
 
-	memcg_flush_vmstats(memcg);
+	cgroup_rstat_flush(memcg->css.cgroup);
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
@@ -4500,7 +4495,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	memcg_flush_vmstats(memcg);
+	cgroup_rstat_flush_irqsafe(memcg->css.cgroup);
 
 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
-- 
2.30.1

