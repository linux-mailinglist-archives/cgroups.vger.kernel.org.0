Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98B87BBEE8
	for <lists+cgroups@lfdr.de>; Fri,  6 Oct 2023 20:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjJFSqn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Oct 2023 14:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjJFSqf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Oct 2023 14:46:35 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA86C2;
        Fri,  6 Oct 2023 11:46:34 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1889872a12.3;
        Fri, 06 Oct 2023 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617994; x=1697222794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PLbRh1GdQSuzgMGxcjYajdp+r42f9X7B8/Cs8IIw1E=;
        b=FA8/2iUmvjVAYzzY1Nv6MpC7piEEiiiYT7jeohXVNotEEmCRsRfYlmfVJk1EF5ROOc
         E07EBGZLk1gX73IBv7/ndrcAssQcTi/+kA58T0Ny92pjt5YczpofF7kibwHqDjiquFof
         0yKDm+5n0WhsqhgwZb68G3UXqWXF/DstyKR00F5wa9K86bzo6+7vbFqyuDsqLsRp/B0H
         EvZ2GGbECSoiEfq4//vVANcc8dZ6SN836eirWahfyu4b49nM/1/XyasXARnabwtzbYFw
         ZqAtpuUDSJT2PLMuH5hyU3krqv3ZudCUnvFWDhzyXhWxN6PSC1lED6khBVdOmeVdR52w
         QbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617994; x=1697222794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PLbRh1GdQSuzgMGxcjYajdp+r42f9X7B8/Cs8IIw1E=;
        b=jgajFpSzm51uxIi+uiG9BNhDwMUZ7RP3dwMQK0/z72tvEdVDKU4QLTVISCZDFjjkOh
         MTfMwvEOlP4PoiXSqaAGkwrCGqOM9LHR3ozPu5s32cVve2bY0Xe+ff8UKy8W0oKEaP2z
         qszLBOXrDwAXU9zb3q6uH7XwfypSyzCpX+AAcY0gJWpcFilgp+/Rg8uGB45dRvNn7GX+
         0eawB4fdHg+j9XfY162mvsdaCp2AefES4WcB/hIcecfBx9Eg6MSVZO5WJaR2fZs8HNKF
         NagWWPwYqW3mmaPJn818LPAEE7Y8xYG0Szy85JY+epwpZwgEHPkPYxgQ+lEYUN4EXkQk
         sPZQ==
X-Gm-Message-State: AOJu0Yy7Y7IHzQ+cVMyFPrF7QRW+j93N+lzA6NwNStxwZdrirdVPQ2yj
        wvs7dur+vvmqDA2VenKx+Jw=
X-Google-Smtp-Source: AGHT+IEe+6yqU5r07JsaeSeLI4O7kp/29vLl/f9OnIgJYThbQQ0o75CPnRFGXWPYmDXr5YACLKuB3g==
X-Received: by 2002:a05:6a21:798a:b0:16c:bd7e:d524 with SMTP id bh10-20020a056a21798a00b0016cbd7ed524mr566168pzc.57.1696617993719;
        Fri, 06 Oct 2023 11:46:33 -0700 (PDT)
Received: from localhost (fwdproxy-prn-015.fbsv.net. [2a03:2880:ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id g22-20020aa78756000000b00682669dc19bsm1800647pfo.201.2023.10.06.11.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:46:32 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v4 2/4] memcontrol: only transfer the memcg data for migration
Date:   Fri,  6 Oct 2023 11:46:27 -0700
Message-Id: <20231006184629.155543-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006184629.155543-1-nphamcs@gmail.com>
References: <20231006184629.155543-1-nphamcs@gmail.com>
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

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h |  7 +++++++
 mm/filemap.c               |  2 +-
 mm/memcontrol.c            | 40 +++++++++++++++++++++++++++++++++++---
 3 files changed, 45 insertions(+), 4 deletions(-)

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
index 0219befeae38..b9c479d768e2 100644
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
@@ -7329,6 +7330,39 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
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
+	VM_WARN_ON_ONCE_FOLIO(!memcg, old);
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
