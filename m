Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2AF7B748B
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 01:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjJCXO2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 19:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjJCXO1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 19:14:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7D4AF;
        Tue,  3 Oct 2023 16:14:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c723f1c80fso11384575ad.1;
        Tue, 03 Oct 2023 16:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696374864; x=1696979664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWjIhVNT1E7PfrfKwNLVQZ455aStkJaWOS9he+QZwc4=;
        b=bmJ0Os0XHMwPi+/FSTBaHKOQFubBPd8lJsAuoj7Ouw4QydaJIyp7+cfJtZnmo0EF2n
         4cioSqFeEAlGIVJvFu448HiCssEoupJw5xV7MBJu6BEHiGEalCuVkP2ljOgsYp7qpswD
         LJ9+rzz/IWZJ7Yhsc930S+Ve5T050hyd0s4x3lPWxr6GrincDyQWXLEafowBaKjumaOt
         iuT3/19pEeENg/EU4BiaDKF3Yz9Bbt9MnN3c6DNukwnmQ6aC62ZxD4G/sbwsB+OQHyRN
         UkI8vnBKeaaAC0+JRoYsAK6Mg5/ugkRixwQCYqs5etz62xxYJcoVzXFu6Yod9Mgfpw8e
         XBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696374864; x=1696979664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWjIhVNT1E7PfrfKwNLVQZ455aStkJaWOS9he+QZwc4=;
        b=Kbfz5mvbIdoFafq4ZZiAnYu5pIBiXgVn/IAfiEaOX/LQMdwe4ByDJO3ZIArE8uB+5t
         aOmvSjScfX9Lq1kcVGvefN5RyBsReLdlmxgu62R48Vnnn0nZdC1Rlvd5r5VckKFKBZ10
         BS43EMWO2uX3/vlJz5zZT3VBkgOeOOQB8iLMl2NgMSXjSxbkUKsyESU9znzC19kgTTyN
         GqqX66LL6OXiI+dmfn4/aYwbxPqtp8ncmdZvJWWvY3uznqtVEG680KWWl6Gh4kurpPXS
         432OaW3scmCLGz/AYuH6tshgDoTQLNpOHwWU1YKDbDkmfWQpKVZJlpkuMZKm3ms73UeI
         GXig==
X-Gm-Message-State: AOJu0YwC5zLJWwR0Gn7+0mx8Zak4Zy8zDI6DoTHghoh4tJK49K9UzgUv
        Q/077O4K8wwZZaazG3X9W5w=
X-Google-Smtp-Source: AGHT+IETIduuzQcGbX3ju74VeGurMPVK+mZzhRAQKI3L+wYgIJF0Bkfu8w2t03oMVilyhWuyfFZ02g==
X-Received: by 2002:a17:902:bc45:b0:1c7:7916:e87b with SMTP id t5-20020a170902bc4500b001c77916e87bmr1071338plz.14.1696374863896;
        Tue, 03 Oct 2023 16:14:23 -0700 (PDT)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090282c500b001c446dea2c5sm2173607plz.143.2023.10.03.16.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:14:23 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH] memcontrol: only transfer the memcg data for migration
Date:   Tue,  3 Oct 2023 16:14:22 -0700
Message-Id: <20231003231422.4046187-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003171329.GB314430@monkey>
References: <20231003171329.GB314430@monkey>
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
charging and uncharging will be done. These use cases include the new
hugetlb memcg accounting behavior (which was not previously handled).

This shaves off some work on the migration path, and avoids the
temporary double charging of a folio during its migration.

The only exception is replace_page_cache_folio(), which will use the old
mem_cgroup_migrate() (now renamed to mem_cgroup_replace_folio). In that
context, the isolation of the old page isn't quite as thorough as with
migration, so we cannot use our new implementation directly.

This patch is the result of the following discussion on the new hugetlb
memcg accounting behavior:

https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/

Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
Closes: https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/memcontrol.h |  7 ++++++
 mm/filemap.c               |  2 +-
 mm/memcontrol.c            | 45 +++++++++++++++++++++++++++++++++++---
 mm/migrate.c               |  3 +--
 4 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a827e2129790..e3eaa123256b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -711,6 +711,8 @@ static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
 
 void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages);
 
+void mem_cgroup_replace_folio(struct folio *old, struct folio *new);
+
 void mem_cgroup_migrate(struct folio *old, struct folio *new);
 
 /**
@@ -1294,6 +1296,11 @@ static inline void mem_cgroup_cancel_charge(struct mem_cgroup *memcg,
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
index 6660684f6f97..cbaa26605b3d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7316,16 +7316,17 @@ void __mem_cgroup_uncharge_list(struct list_head *page_list)
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
@@ -7364,6 +7365,44 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
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
+	 * It could have been allocated when memory_hugetlb_accounting was not
+	 * selected, for e.g.
+	 */
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
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 7d1804c4a5d9..6034c7ed1d65 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -633,8 +633,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 
 	folio_copy_owner(newfolio, folio);
 
-	if (!folio_test_hugetlb(folio))
-		mem_cgroup_migrate(folio, newfolio);
+	mem_cgroup_migrate(folio, newfolio);
 }
 EXPORT_SYMBOL(folio_migrate_flags);
 
-- 
2.34.1

