Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5B9692296
	for <lists+cgroups@lfdr.de>; Fri, 10 Feb 2023 16:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjBJPrx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Feb 2023 10:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjBJPrw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Feb 2023 10:47:52 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEBA74042;
        Fri, 10 Feb 2023 07:47:51 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 7so3990115pga.1;
        Fri, 10 Feb 2023 07:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfmMbVSSF03x8/EU0op7vkHjUSmnGjVyyVeSw2o/bMM=;
        b=BQ/iZFengvaZKJ3dJwASQiyVaev+KFw4y51P7WZw4NwSnsRQG2uZNOGB3zBFW1QK0V
         mQx+3kvpRR5HnwelfEksbJwXc2u9EgEayhBNqtt+GwltUw9XeQz8hIUcZfpmzKK9sCdf
         kl/LTV3UiLSa3CvLJyeV5nTs30q6wPG1V2oyvHiZgKgYJjZl4Gf5skDU/Ey3PEt0xNYN
         cwaGROZ0gNhbe5wJ6q1scjleFZojcU35EPTGZHAF5Dwfb0knbSHm0dBe58k63hBXTLbY
         5MsFuOdqnsx4YIOCLtjhZIicCUH2vtVHUl94uuX3LAX6uFXzti3HsqZA3o0YJuE1FX7o
         R01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfmMbVSSF03x8/EU0op7vkHjUSmnGjVyyVeSw2o/bMM=;
        b=5ewyGusuy4i1FpXz08n5GHwzNWZJ1VB2yr5FPp9+9swP7hg0avFCw1T3L6QgzqGFSG
         Rl893s82v6m0n4Tg1KvTtf5aV6ZOhuwXoiOE9KABpyB+Zh+JgNpGsjS+Dj3IlctJKrgc
         FzBfAiNy2Zoj13aIEvPEnNj8b0/yUXiWHBApz0/mJZKbBatawa3fBzc22JNqZ9q8GQVS
         gjQP/N3iTjEc5IMNrqHgc3VpXlVhMNKn+H4deTGtbJz7wFqysaDOptuq7uveRKOLVOWn
         LZuno9/K5qVCgwlnd9x9sLt20WXqygCEAVapsufQ1cJruCFOa1BrHbnAUBVVkbu3KsVj
         t8PQ==
X-Gm-Message-State: AO0yUKXftT0lLB2fbstkEf7/iBl48UoR6Z+VOr2+pHsCW+LueKmD5vd0
        WR9fROjHNNH4UGZOH1aWpzw=
X-Google-Smtp-Source: AK7set8zE9YvB+rlMwZ5YZqUvOjqk39b6oN+vCogBTsbbmo4FDAGcstJKaNToWrU7wwqvzFDSnO41w==
X-Received: by 2002:a62:17cc:0:b0:5a7:9e27:faa2 with SMTP id 195-20020a6217cc000000b005a79e27faa2mr5314359pfx.4.1676044071214;
        Fri, 10 Feb 2023 07:47:51 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:2f6a:5400:4ff:fe4c:e050])
        by smtp.gmail.com with ESMTPSA id t20-20020aa79394000000b005921c46cbadsm3520069pfe.99.2023.02.10.07.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:47:50 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org
Cc:     bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 1/4] mm: memcontrol: add new kernel parameter cgroup.memory=nobpf
Date:   Fri, 10 Feb 2023 15:47:31 +0000
Message-Id: <20230210154734.4416-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230210154734.4416-1-laoar.shao@gmail.com>
References: <20230210154734.4416-1-laoar.shao@gmail.com>
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

Add new kernel parameter cgroup.memory=nobpf to allow user disable bpf
memory accounting. This is a preparation for the followup patch.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 Documentation/admin-guide/kernel-parameters.txt |  1 +
 include/linux/memcontrol.h                      | 11 +++++++++++
 mm/memcontrol.c                                 | 18 ++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3..29fb41e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -557,6 +557,7 @@
 			Format: <string>
 			nosocket -- Disable socket memory accounting.
 			nokmem -- Disable kernel memory accounting.
+			nobpf -- Disable BPF memory accounting.
 
 	checkreqprot=	[SELINUX] Set initial checkreqprot flag value.
 			Format: { "0" | "1" }
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d3c8203..26d4bf2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1751,6 +1751,12 @@ static inline void set_shrinker_bit(struct mem_cgroup *memcg,
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
 
+extern struct static_key_false memcg_bpf_enabled_key;
+static inline bool memcg_bpf_enabled(void)
+{
+	return static_branch_likely(&memcg_bpf_enabled_key);
+}
+
 extern struct static_key_false memcg_kmem_enabled_key;
 
 static inline bool memcg_kmem_enabled(void)
@@ -1829,6 +1835,11 @@ static inline struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
 	return NULL;
 }
 
+static inline bool memcg_bpf_enabled(void)
+{
+	return false;
+}
+
 static inline bool memcg_kmem_enabled(void)
 {
 	return false;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ab457f0..590526f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -89,6 +89,9 @@
 /* Kernel memory accounting disabled? */
 static bool cgroup_memory_nokmem __ro_after_init;
 
+/* BPF memory accounting disabled? */
+static bool cgroup_memory_nobpf __ro_after_init;
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 #endif
@@ -348,6 +351,9 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
  */
 DEFINE_STATIC_KEY_FALSE(memcg_kmem_enabled_key);
 EXPORT_SYMBOL(memcg_kmem_enabled_key);
+
+DEFINE_STATIC_KEY_FALSE(memcg_bpf_enabled_key);
+EXPORT_SYMBOL(memcg_bpf_enabled_key);
 #endif
 
 /**
@@ -5362,6 +5368,11 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_inc(&memcg_sockets_enabled_key);
 
+#if defined(CONFIG_MEMCG_KMEM)
+	if (!cgroup_memory_nobpf)
+		static_branch_inc(&memcg_bpf_enabled_key);
+#endif
+
 	return &memcg->css;
 }
 
@@ -5446,6 +5457,11 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg->tcpmem_active)
 		static_branch_dec(&memcg_sockets_enabled_key);
 
+#if defined(CONFIG_MEMCG_KMEM)
+	if (!cgroup_memory_nobpf)
+		static_branch_dec(&memcg_bpf_enabled_key);
+#endif
+
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
@@ -7310,6 +7326,8 @@ static int __init cgroup_memory(char *s)
 			cgroup_memory_nosocket = true;
 		if (!strcmp(token, "nokmem"))
 			cgroup_memory_nokmem = true;
+		if (!strcmp(token, "nobpf"))
+			cgroup_memory_nobpf = true;
 	}
 	return 1;
 }
-- 
1.8.3.1

