Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F5C7B5E0D
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 02:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbjJCASh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 20:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbjJCASg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 20:18:36 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC666D8;
        Mon,  2 Oct 2023 17:18:31 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-57ad95c555eso184150eaf.3;
        Mon, 02 Oct 2023 17:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696292311; x=1696897111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/ArhJOrTFxsFSzyEEFASkcwnYkX8juRHkl0KQuu84A=;
        b=Z6GxgV0pq3DbTXLPlnMKVfUc0YKF7EiXBx67+LPm8lpfDSXfAXKmW9cTBifNqwqHvL
         NcusV81xxoFBYIUEnlJtR1p+2Q0hns3lbppxLLpE2p3vVVpWNb8kOGZZfrotZqNHA+2m
         MCI96sjSo6Gr66mqc0d5ZGH3jsfzF0BFGuwOZZ54BPrzG0IAOPItZXhtSk3daEuvtJkt
         EcjG9ir2QHRSVdLqe1tiy1R8S5vAVys+Q0d2x01A5SiYmo+uvInFEq+2i3WRmFSosJ2x
         ENLzWSPGtskwKUNXj9QzGMjWol8Cw1l6TYDnlYkHEUegNYwBLUhwEL5mPk2MLBL+9Te3
         D0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696292311; x=1696897111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/ArhJOrTFxsFSzyEEFASkcwnYkX8juRHkl0KQuu84A=;
        b=Kr1QgpQ70ViLB8aeqc29O94nXa5E+9CQ5e8WswV10hxwxyoP9CSRBebwuSK1rJUeFg
         DHkwGAedd7oh0XQg0DNwIzpfL4HLP2mPiPl2zogK11u1VngYQPMyoT4kyuJuaAdCDlTV
         jjAFDRiHMorrWpRuRrYDVK8h2O00qGz7zzetyx9Ko3Jeoqg+CUABY5vRaUkgcCAMkAYZ
         RyKR3vsB/ITTZ/mCjFbu8dx6MfpBonBvHet2KeYmKs7QXMaZqHUnJpUumE60SYFiwjxx
         a5PYTsGOFN63mFV5J7F3kjF70UTF8sRmRe2nAmpL/U1g0+vBehfawxBTl/OAe19k34Qx
         Svcw==
X-Gm-Message-State: AOJu0YweipFz9h4tcNuODdUh8E2hgS8qImuRPwjxcsWrwZ7uwfXcQ0JR
        RXjdyhlzY4b0UJsWg+dalcSiOZFRsRzf4g==
X-Google-Smtp-Source: AGHT+IGeZQJRLurhTr3HaqjP/5G/e4x1v6LKbD/D7agOZxG0/HlpHolysCG6h0wgbFAUW9N/6GU6NQ==
X-Received: by 2002:a05:6870:14d0:b0:1d1:3c89:a7e5 with SMTP id l16-20020a05687014d000b001d13c89a7e5mr14709954oab.51.1696292310943;
        Mon, 02 Oct 2023 17:18:30 -0700 (PDT)
Received: from localhost (fwdproxy-prn-002.fbsv.net. [2a03:2880:ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id q24-20020a637518000000b00578e9751b88sm52212pgc.1.2023.10.02.17.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:18:30 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v3 1/3] memcontrol: add helpers for hugetlb memcg accounting
Date:   Mon,  2 Oct 2023 17:18:26 -0700
Message-Id: <20231003001828.2554080-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003001828.2554080-1-nphamcs@gmail.com>
References: <20231003001828.2554080-1-nphamcs@gmail.com>
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

This patch exposes charge committing and cancelling as parts of the
memory controller interface. These functionalities are useful when the
try_charge() and commit_charge() stages have to be separated by other
actions in between (which can fail). One such example is the new hugetlb
accounting behavior in the following patch.

The patch also adds a helper function to obtain a reference to the
current task's memcg.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/memcontrol.h | 21 ++++++++++++++
 mm/memcontrol.c            | 59 ++++++++++++++++++++++++++++++--------
 2 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e0cfab58ab71..42bf7e9b1a2f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -653,6 +653,8 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 		page_counter_read(&memcg->memory);
 }
 
+void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg);
+
 int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp);
 
 /**
@@ -704,6 +706,8 @@ static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
 	__mem_cgroup_uncharge_list(page_list);
 }
 
+void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages);
+
 void mem_cgroup_migrate(struct folio *old, struct folio *new);
 
 /**
@@ -760,6 +764,8 @@ struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
 
+struct mem_cgroup *get_mem_cgroup_from_current(void);
+
 struct lruvec *folio_lruvec_lock(struct folio *folio);
 struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
 struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
@@ -1245,6 +1251,11 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 	return false;
 }
 
+static inline void mem_cgroup_commit_charge(struct folio *folio,
+		struct mem_cgroup *memcg)
+{
+}
+
 static inline int mem_cgroup_charge(struct folio *folio,
 		struct mm_struct *mm, gfp_t gfp)
 {
@@ -1269,6 +1280,11 @@ static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
 {
 }
 
+static inline void mem_cgroup_cancel_charge(struct mem_cgroup *memcg,
+		unsigned int nr_pages)
+{
+}
+
 static inline void mem_cgroup_migrate(struct folio *old, struct folio *new)
 {
 }
@@ -1306,6 +1322,11 @@ static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	return NULL;
 }
 
+static inline struct mem_cgroup *get_mem_cgroup_from_current(void)
+{
+	return NULL;
+}
+
 static inline
 struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d1a322a75172..0219befeae38 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1086,6 +1086,27 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(get_mem_cgroup_from_mm);
 
+/**
+ * get_mem_cgroup_from_current - Obtain a reference on current task's memcg.
+ */
+struct mem_cgroup *get_mem_cgroup_from_current(void)
+{
+	struct mem_cgroup *memcg;
+
+	if (mem_cgroup_disabled())
+		return NULL;
+
+again:
+	rcu_read_lock();
+	memcg = mem_cgroup_from_task(current);
+	if (!css_tryget(&memcg->css)) {
+		rcu_read_unlock();
+		goto again;
+	}
+	rcu_read_unlock();
+	return memcg;
+}
+
 static __always_inline bool memcg_kmem_bypass(void)
 {
 	/* Allow remote memcg charging from any context. */
@@ -2873,7 +2894,12 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return try_charge_memcg(memcg, gfp_mask, nr_pages);
 }
 
-static inline void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
+/**
+ * mem_cgroup_cancel_charge() - cancel an uncommitted try_charge() call.
+ * @memcg: memcg previously charged.
+ * @nr_pages: number of pages previously charged.
+ */
+void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	if (mem_cgroup_is_root(memcg))
 		return;
@@ -2898,6 +2924,22 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	folio->memcg_data = (unsigned long)memcg;
 }
 
+/**
+ * mem_cgroup_commit_charge - commit a previously successful try_charge().
+ * @folio: folio to commit the charge to.
+ * @memcg: memcg previously charged.
+ */
+void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
+{
+	css_get(&memcg->css);
+	commit_charge(folio, memcg);
+
+	local_irq_disable();
+	mem_cgroup_charge_statistics(memcg, folio_nr_pages(folio));
+	memcg_check_events(memcg, folio_nid(folio));
+	local_irq_enable();
+}
+
 #ifdef CONFIG_MEMCG_KMEM
 /*
  * The allocated objcg pointers array is not accounted directly.
@@ -6105,7 +6147,7 @@ static void __mem_cgroup_clear_mc(void)
 
 	/* we must uncharge all the leftover precharges from mc.to */
 	if (mc.precharge) {
-		cancel_charge(mc.to, mc.precharge);
+		mem_cgroup_cancel_charge(mc.to, mc.precharge);
 		mc.precharge = 0;
 	}
 	/*
@@ -6113,7 +6155,7 @@ static void __mem_cgroup_clear_mc(void)
 	 * we must uncharge here.
 	 */
 	if (mc.moved_charge) {
-		cancel_charge(mc.from, mc.moved_charge);
+		mem_cgroup_cancel_charge(mc.from, mc.moved_charge);
 		mc.moved_charge = 0;
 	}
 	/* we must fixup refcnts and charges */
@@ -7020,20 +7062,13 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 			gfp_t gfp)
 {
-	long nr_pages = folio_nr_pages(folio);
 	int ret;
 
-	ret = try_charge(memcg, gfp, nr_pages);
+	ret = try_charge(memcg, gfp, folio_nr_pages(folio));
 	if (ret)
 		goto out;
 
-	css_get(&memcg->css);
-	commit_charge(folio, memcg);
-
-	local_irq_disable();
-	mem_cgroup_charge_statistics(memcg, nr_pages);
-	memcg_check_events(memcg, folio_nid(folio));
-	local_irq_enable();
+	mem_cgroup_commit_charge(folio, memcg);
 out:
 	return ret;
 }
-- 
2.34.1
