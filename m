Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EFC532332
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 08:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiEXG2Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 02:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiEXG2S (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 02:28:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175B3737AF
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 23:28:16 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w3so8413565plp.13
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 23:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NIoa7/YAUntswrCKfqoiHIwQ2FiZAUKsFw3sXpH2ToA=;
        b=nmPPdm0n11BOQ5k1iXVhMTgOfUnT5doQW6FEzqyptlVcbRMwfoXIbTPOIt+hcvURYm
         O/Nzh2C3SdKHRPAyGRnaF7nYOlZpg0prTt9wOpP7vQYDWfArjY7T7ApBJ/JAjAgVvECg
         4jls9zpAlcLrVEOlK+ywZNAG7nqEKA2b9BaLbgp81TVUePK7vD9suhJWDXnJXra5Ju0l
         TyOGR8EJB98F0nb8TEaC6QAaRokmsR0nOX6rWCne6FPTiuZMak68sJLTis5vjtjMKXdP
         dEE2Vgt89hFC9V3zjfIoJOLpgb3NNQ3m21yXjs+4S62wvOivx9BWVqvSTt1KsMEMAqko
         jK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NIoa7/YAUntswrCKfqoiHIwQ2FiZAUKsFw3sXpH2ToA=;
        b=qJ9N0mkgj/7dGsP3wuCAFPTxmTcQL15oLxMYvqCbcdIGAUoOQa7mnJV60gV67n9tSv
         YL8IVg3fZsagabPRHrdgH05413ZedVrhuroYQ70WyMMlNY9zBz25gBLHhaeAg/sluO5f
         bF0ulUhLi+6UZbx7Aflh/PnGjG8A+7R98fgrAM3h+oUloF34ZJQwft3N7zNVkmsAFK/9
         8oKmsxvwPSpZYyVue0fd6NypbEAao3LZo5Cnnmi8D+psfB+fm/L9c5tlLBmQC3ZB7s0V
         +hVRdKzJ+Z+k/nTcY1dvvT+c77RuYb/A3H5jDdNeDcPoz9B8vXx0cc5PD+zeQAlzuZCU
         9kfw==
X-Gm-Message-State: AOAM532Sl3f/QIzBBs018kSxDpXjbqYF4JND8X/+GIEVeLE0cjLwpR3E
        T3AwVcvm3ujfsj5heuNx/I+r5g==
X-Google-Smtp-Source: ABdhPJz3zlcfAkmEkbweh3Xk2zbyA46Z3LjTGnxV11LirLFNvvsfkscs2z1dzbsre43De32HasZ8nw==
X-Received: by 2002:a17:90a:6342:b0:1df:763d:4eca with SMTP id v2-20020a17090a634200b001df763d4ecamr2938988pjs.85.1653373695699;
        Mon, 23 May 2022 23:28:15 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([2408:8207:18da:2310:f940:af17:c2f5:8656])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b0016168e90f2dsm6254455plf.219.2022.05.23.23.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 23:28:15 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 08/11] mm: memcontrol: introduce memcg_reparent_ops
Date:   Tue, 24 May 2022 14:05:48 +0800
Message-Id: <20220524060551.80037-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220524060551.80037-1-songmuchun@bytedance.com>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In the previous patch, we know how to make the lruvec lock safe when LRU
pages are reparented. We should do something like following.

    memcg_reparent_objcgs(memcg)
        1) lock
        // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
        spin_lock(&lruvec->lru_lock);
        spin_lock(&lruvec_parent->lru_lock);

        2) relocate from current memcg to its parent
        // Move all the pages from the lruvec list to the parent lruvec list.

        3) unlock
        spin_unlock(&lruvec_parent->lru_lock);
        spin_unlock(&lruvec->lru_lock);

Apart from the page lruvec lock, the deferred split queue lock (THP only)
also needs to do something similar. So we extract the necessary three steps
in the memcg_reparent_objcgs().

    memcg_reparent_objcgs(memcg)
        1) lock
        memcg_reparent_ops->lock(memcg, parent);

        2) relocate
        memcg_reparent_ops->relocate(memcg, reparent);

        3) unlock
        memcg_reparent_ops->unlock(memcg, reparent);

Now there are two different locks (e.g. lruvec lock and deferred split
queue lock) need to use this infrastructure. In the next patch, we will
use those APIs to make those locks safe when the LRU pages reparented.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 20 +++++++++++++++
 mm/memcontrol.c            | 62 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3a0e2592434e..e806e743a1fc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -347,6 +347,26 @@ struct mem_cgroup {
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
+struct memcg_reparent_ops {
+	/*
+	 * Note that interrupt is disabled before calling those callbacks,
+	 * so the interrupt should remain disabled when leaving those callbacks.
+	 */
+	void (*lock)(struct mem_cgroup *src, struct mem_cgroup *dst);
+	void (*relocate)(struct mem_cgroup *src, struct mem_cgroup *dst);
+	void (*unlock)(struct mem_cgroup *src, struct mem_cgroup *dst);
+};
+
+#define DEFINE_MEMCG_REPARENT_OPS(name)					\
+	const struct memcg_reparent_ops memcg_##name##_reparent_ops = {	\
+		.lock		= name##_reparent_lock,			\
+		.relocate	= name##_reparent_relocate,		\
+		.unlock		= name##_reparent_unlock,		\
+	}
+
+#define DECLARE_MEMCG_REPARENT_OPS(name)				\
+	extern const struct memcg_reparent_ops memcg_##name##_reparent_ops
+
 /*
  * size of first charge trial. "32" comes from vmscan.c's magic value.
  * TODO: maybe necessary to use big numbers in big irons.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dcaf6cf5dc74..7d62764c6380 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -337,24 +337,60 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	return objcg;
 }
 
-static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
+static void objcg_reparent_lock(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	spin_lock(&objcg_lock);
+}
+
+static void objcg_reparent_relocate(struct mem_cgroup *src, struct mem_cgroup *dst)
 {
 	struct obj_cgroup *objcg, *iter;
-	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 
-	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
+	objcg = rcu_replace_pointer(src->objcg, NULL, true);
+	/* 1) Ready to reparent active objcg. */
+	list_add(&objcg->list, &src->objcg_list);
+	/* 2) Reparent active objcg and already reparented objcgs to dst. */
+	list_for_each_entry(iter, &src->objcg_list, list)
+		WRITE_ONCE(iter->memcg, dst);
+	/* 3) Move already reparented objcgs to the dst's list */
+	list_splice(&src->objcg_list, &dst->objcg_list);
+}
+
+static void objcg_reparent_unlock(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	spin_unlock(&objcg_lock);
+}
 
-	spin_lock_irq(&objcg_lock);
+static DEFINE_MEMCG_REPARENT_OPS(objcg);
 
-	/* 1) Ready to reparent active objcg. */
-	list_add(&objcg->list, &memcg->objcg_list);
-	/* 2) Reparent active objcg and already reparented objcgs to parent. */
-	list_for_each_entry(iter, &memcg->objcg_list, list)
-		WRITE_ONCE(iter->memcg, parent);
-	/* 3) Move already reparented objcgs to the parent's list */
-	list_splice(&memcg->objcg_list, &parent->objcg_list);
-
-	spin_unlock_irq(&objcg_lock);
+static const struct memcg_reparent_ops *memcg_reparent_ops[] = {
+	&memcg_objcg_reparent_ops,
+};
+
+#define DEFINE_MEMCG_REPARENT_FUNC(phase)				\
+	static void memcg_reparent_##phase(struct mem_cgroup *src,	\
+					   struct mem_cgroup *dst)	\
+	{								\
+		int i;							\
+									\
+		for (i = 0; i < ARRAY_SIZE(memcg_reparent_ops); i++)	\
+			memcg_reparent_ops[i]->phase(src, dst);		\
+	}
+
+DEFINE_MEMCG_REPARENT_FUNC(lock)
+DEFINE_MEMCG_REPARENT_FUNC(relocate)
+DEFINE_MEMCG_REPARENT_FUNC(unlock)
+
+static void memcg_reparent_objcgs(struct mem_cgroup *src)
+{
+	struct mem_cgroup *dst = parent_mem_cgroup(src);
+	struct obj_cgroup *objcg = rcu_dereference_protected(src->objcg, true);
+
+	local_irq_disable();
+	memcg_reparent_lock(src, dst);
+	memcg_reparent_relocate(src, dst);
+	memcg_reparent_unlock(src, dst);
+	local_irq_enable();
 
 	percpu_ref_kill(&objcg->refcnt);
 }
-- 
2.11.0

