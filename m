Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430157BBEE4
	for <lists+cgroups@lfdr.de>; Fri,  6 Oct 2023 20:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjJFSqf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Oct 2023 14:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjJFSqe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Oct 2023 14:46:34 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AB8CF;
        Fri,  6 Oct 2023 11:46:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c877f27e8fso19769075ad.1;
        Fri, 06 Oct 2023 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617992; x=1697222792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ3fDKoP0HxAKgFx5HjhrMjKnZYWAS/nwLzGqRn4tZU=;
        b=neycuRVKvb8N1AEPcwUgrEdxwVeqzRrMSJJ7QeWYChnBlSU09nA7R6vcFcc6kJcpL6
         FsFLkoJmhwpkiR1EpQQMhUXqY4YATGPRaNxAbY3Bh1EyeU50kUZT8Eu74a2rbok89ICh
         iZAFJO3KIFJwOuMtNVbO19H7CDVuauxLps9z8iiHIGNBaIH7D7ju/FZK6MgKYmpOOgkD
         gygXjN7InzXmS+diHyrGdvY8cuGLeObzqkOyaEY64PMXC0lHiuI6DkLVFJBKLjCc+1o9
         mAaj5Vo9urjt8yie7nG1fOt9NZNcyZUSubOb8NBxZk3fSip/YAJkAnLdvTTiuvhmEV5L
         90vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617992; x=1697222792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ3fDKoP0HxAKgFx5HjhrMjKnZYWAS/nwLzGqRn4tZU=;
        b=ADQBCnIzOVlD3LdB0SyYXwNXoKwIoXva5gQ7TWQp7YRPNRcV0ed15O/uIZKgFKIo5N
         vVV1agHdq7PfNCJFkVVmXn8Az2KmLWUFxr3WSOZUrUbPjcuSMBM3EKzZH0hxuSDhuYZS
         5AK7U+ffnv1VQJ0Yw+NKMPoiR2kUCU1B7yLH4orqVL0vaYM1iD6zAOZ4tiXAYuGNEc2U
         z/gMQbtGZ3RplX3xnQWoN+EX1udywXuiRYn0ryeRtaX7qTkLt6vc4WkBJwHqCZ/yGe/U
         MHNZfJZp4JwNS8d9HlhH1Tk6FVF3MSdneRNS2iwc/7ed8E4Wyt9OQmM8CK9kOpYjAFrf
         jyyQ==
X-Gm-Message-State: AOJu0Yyqk2tyGlIOpTdajicZvs1dJoGBNJjZaCOmNUiFjB+wqJgYjOWf
        gFg7k16n7R//QX+SdCfl8YA=
X-Google-Smtp-Source: AGHT+IH+P+iy9kpiRfFqEt50ag8YuOg/nc+rwk5xrE7+ZTfX7UsJHZlKqKdNGkM0xrSHZ2CUdYxkDg==
X-Received: by 2002:a17:90a:b891:b0:273:441a:dae6 with SMTP id o17-20020a17090ab89100b00273441adae6mr8808492pjr.19.1696617991566;
        Fri, 06 Oct 2023 11:46:31 -0700 (PDT)
Received: from localhost (fwdproxy-prn-000.fbsv.net. [2a03:2880:ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902989400b001c5b8087fe5sm4250869plp.94.2023.10.06.11.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:46:31 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v4 1/4] memcontrol: add helpers for hugetlb memcg accounting
Date:   Fri,  6 Oct 2023 11:46:26 -0700
Message-Id: <20231006184629.155543-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006184629.155543-1-nphamcs@gmail.com>
References: <20231006184629.155543-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
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
