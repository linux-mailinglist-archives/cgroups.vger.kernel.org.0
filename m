Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE237B8D7D
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 21:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244496AbjJDTgh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 15:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243494AbjJDTg1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 15:36:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF28598;
        Wed,  4 Oct 2023 12:36:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2792d70ae25so129526a91.0;
        Wed, 04 Oct 2023 12:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696448183; x=1697052983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oxe/lUUklxbHu0vEIlUOVm4PBVuobqclnUB653St8qw=;
        b=KIFgDUGVqY3JVs3jmQR+xmEBsSoH2cZO1u2R/HJTQFwOPyMKL+RGlvI0Z+yddqFrHe
         sZ8XjingvA8bXgbhUeOju6jr+sNldAfWX87IOmxSKcCggXZioQT1LCNzAiOxmxFmuD9f
         cH+6RaiEeAHeRhQvJ7t8E+p3Pg1+t4XmkIS3tQo05lHUBaLTKwTLl9bpstakg05EMLGQ
         FaXI9qCRr4lzdS6Pd9fYGffK4OyaTFb2vorKp3lZeiEMYL1wMp/f//O0+JHbk2qHOxqN
         r9Il1J07YomaW3drqhwqCIO2Z5yPFM0bXuQGWEGVEL4ArktdwQgpsIyxcYSDYHjh9Ah9
         RckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696448183; x=1697052983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oxe/lUUklxbHu0vEIlUOVm4PBVuobqclnUB653St8qw=;
        b=tkWlUYnBM38kL5GiLZ2Fxb9IRCbqN0nbnOthAnPlc0w4vaTINDjkUCvgyKutlsxHT8
         HbhIf3l56VP7ky2IF24EvIiTTDVZ/qaFaFnfKxiv3Y98eNjigEL88vKHsnyyisU83CHj
         9n3JavJUF1dePjqtUi3v5o+ono6toqtvDaQu73QZH1rqJMagcZhtoQHJKq3xjZniDQb1
         f4ncBpu4Oj+YN4otuwkMW9GSl868nSrpHdh/SihedREmZH1rXZ1/gbsEfy1q/ax5nhz7
         so/2aV2e0HXqqbgI1adZWu5Fh3KXMOAqCKXVduvzk8DIp+9TJpl1wBADKUH7c793Y40r
         fSvQ==
X-Gm-Message-State: AOJu0Yz79e4mzdagHgBtDSEv/rr8WjXL+3aE9jCuWkD3JpAgXsyKrP1e
        OqCqFj+bNls5mF/ViAkPAng=
X-Google-Smtp-Source: AGHT+IGC2IF1Rwb6lyP1BbCO/xIxVJzbxzbXytefjWzvm4+Km4BvCbHu0QkrrRljkhcMchfRMGJoEA==
X-Received: by 2002:a17:90a:ce92:b0:274:6135:8363 with SMTP id g18-20020a17090ace9200b0027461358363mr2908761pju.33.1696448183010;
        Wed, 04 Oct 2023 12:36:23 -0700 (PDT)
Received: from localhost (fwdproxy-prn-113.fbsv.net. [2a03:2880:ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id bv6-20020a17090af18600b002630c9d78aasm1961226pjb.5.2023.10.04.12.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:36:22 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v2] memcontrol: only transfer the memcg data for migration
Date:   Wed,  4 Oct 2023 12:36:22 -0700
Message-Id: <20231004193622.900383-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For most migration use cases, only transfer the memcg data from the old
folio to the new folio, and clear the old folio's memcg data. No
charging and uncharging will be done.

This shaves off some work on the migration path, and avoids the
temporary double charging of a folio during its migration.

The only exception is replace_page_cache_folio(), which will use the old
mem_cgroup_migrate() (now renamed to mem_cgroup_replace_folio). In that
context, the isolation of the old page isn't quite as thorough as with
migration, so we cannot use our new implementation directly.

This patch is the result of the following discussion on the new hugetlb
memcg accounting behavior:

https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/

This should be added as the second prep patch in the following series:
https://lore.kernel.org/all/20231003001828.2554080-1-nphamcs@gmail.com/
(hugetlb memcg accounting)

and should go right before the following patch:
hugetlb: memcg: account hugetlb-backed memory in memory controller

Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
Closes: https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/memcontrol.h |  7 ++++++
 mm/filemap.c               |  2 +-
 mm/memcontrol.c            | 45 +++++++++++++++++++++++++++++++++++---
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 42bf7e9b1a2f..5daf14da3759 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -708,6 +708,8 @@ static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
 
 void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages);
 
+void mem_cgroup_replace_folio(struct folio *old, struct folio *new);
+
 void mem_cgroup_migrate(struct folio *old, struct folio *new);
 
 /**
@@ -1285,6 +1287,11 @@ static inline void mem_cgroup_cancel_charge(struct mem_cgroup *memcg,
 {
 }
 
+static inline void mem_cgroup_replace_folio(struct folio *old,
+		struct folio *new)
+{
+}
+
 static inline void mem_cgroup_migrate(struct folio *old, struct folio *new)
 {
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index 9481ffaf24e6..673745219c82 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -819,7 +819,7 @@ void replace_page_cache_folio(struct folio *old, struct folio *new)
 	new->mapping = mapping;
 	new->index = offset;
 
-	mem_cgroup_migrate(old, new);
+	mem_cgroup_replace_folio(old, new);
 
 	xas_lock_irq(&xas);
 	xas_store(&xas, new);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0219befeae38..2ccf0a53cd71 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7281,16 +7281,17 @@ void __mem_cgroup_uncharge_list(struct list_head *page_list)
 }
 
 /**
- * mem_cgroup_migrate - Charge a folio's replacement.
+ * mem_cgroup_replace_folio - Charge a folio's replacement.
  * @old: Currently circulating folio.
  * @new: Replacement folio.
  *
  * Charge @new as a replacement folio for @old. @old will
- * be uncharged upon free.
+ * be uncharged upon free. This is only used by the page cache
+ * (in replace_page_cache_folio()).
  *
  * Both folios must be locked, @new->mapping must be set up.
  */
-void mem_cgroup_migrate(struct folio *old, struct folio *new)
+void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 {
 	struct mem_cgroup *memcg;
 	long nr_pages = folio_nr_pages(new);
@@ -7329,6 +7330,44 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	local_irq_restore(flags);
 }
 
+/**
+ * mem_cgroup_migrate - Transfer the memcg data from the old to the new folio.
+ * @old: Currently circulating folio.
+ * @new: Replacement folio.
+ *
+ * Transfer the memcg data from the old folio to the new folio for migration.
+ * The old folio's data info will be cleared. Note that the memory counters
+ * will remain unchanged throughout the process.
+ *
+ * Both folios must be locked, @new->mapping must be set up.
+ */
+void mem_cgroup_migrate(struct folio *old, struct folio *new)
+{
+	struct mem_cgroup *memcg;
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
+	VM_BUG_ON_FOLIO(!folio_test_locked(new), new);
+	VM_BUG_ON_FOLIO(folio_test_anon(old) != folio_test_anon(new), new);
+	VM_BUG_ON_FOLIO(folio_nr_pages(old) != folio_nr_pages(new), new);
+
+	if (mem_cgroup_disabled())
+		return;
+
+	memcg = folio_memcg(old);
+	/*
+	 * Note that it is normal to see !memcg for a hugetlb folio.
+	 * For e.g, itt could have been allocated when memory_hugetlb_accounting
+	 * was not selected.
+	 */
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(old) && !memcg, old);
+	if (!memcg)
+		return;
+
+	/* Transfer the charge and the css ref */
+	commit_charge(new, memcg);
+	old->memcg_data = 0;
+}
+
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
 EXPORT_SYMBOL(memcg_sockets_enabled_key);
 
-- 
2.34.1
