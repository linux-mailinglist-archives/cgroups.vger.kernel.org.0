Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90555532AB
	for <lists+cgroups@lfdr.de>; Tue, 21 Jun 2022 14:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351068AbiFUM7E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jun 2022 08:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351125AbiFUM62 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jun 2022 08:58:28 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526BA26131
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 05:58:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i64so13030649pfc.8
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R9q0ch1BG5yy3uNoTKVJadkT0JjG8vQh5rsCMZAiDeM=;
        b=X1ymgAzrECJrNEqT0zu/qYqioj+MK14RMF+IxcAS9y0uCpcuMThML5qsMfwkh5Syqb
         a+aAQz+na0wNKw5ONdOQH1YzYWTCg9aI9VoZg1AiFiGcFm5GNrdmqoniS/jFYAWZB9U0
         x7hnUcvnD2Uwvu2dL/27+ftKyQYgBnzgc38FLw8CWdGOZanoyKBMLvP036HHHz7f77de
         /57RM1HmPaKRHnE6aN43rnTmSuQnUSdoWtTVyMJC9jbL9ijPukp0Xg3q3OywkZdjchvG
         /bQ8emT1SlpJguuihXT//Xhcgv32+AVxjjynF7sfuZCkEaISt9UJisvUrCMCsdduD4Ug
         QLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R9q0ch1BG5yy3uNoTKVJadkT0JjG8vQh5rsCMZAiDeM=;
        b=8PJfWlnN+Ym7WXDWqgAXNvvSZB0FeH5Xd4Pv90gUUN6sf87Xg0LrmYP7NmKY0mjCBU
         O1HvUmk/8+GBBLZ+GFNC9i//L8/foD8fJny8AZYVU4MMs4s4wD4M2IL3omLkU843veRA
         9FMQAOH9djpWJ6WmiuBUrybDcJfcBbk0Ahpd+83ilR38yzz5wZQTSZCqt7Y5RkSzmMBC
         7sPUfclS45h29YpEGb2H4j9XcX+5EubsavMzhjyG6WCj1TjclQrDfI9ARtKN88xHyjXW
         6sA9UDLX6qgo+Dsr+oHd5tuZPavu/rInNAAWzTjw0l6HghT1sxQ4ZT/rN/dIPGEVvnjB
         aR4g==
X-Gm-Message-State: AJIora+LLjenMkr40Wvc88udDUoIcIEcm8DLQ7a4TA58nHIZJZwB9FMa
        IG6H8aga4+7nDbqudxjOvA97xQ==
X-Google-Smtp-Source: AGRyM1vJmCnTypP6KX9NHCb9AyM5aDswtoVUk0Wth7I38QLP7dlJmEjPt2tfj2n1yyM2/5DwhBTAJQ==
X-Received: by 2002:a63:5155:0:b0:400:14af:a1e6 with SMTP id r21-20020a635155000000b0040014afa1e6mr25830864pgl.71.1655816301516;
        Tue, 21 Jun 2022 05:58:21 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id e3-20020a170903240300b0015ea3a491a1sm10643134plo.191.2022.06.21.05.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:58:21 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, longman@redhat.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com
Cc:     cgroups@vger.kernel.org, duanxiongchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 08/11] mm: memcontrol: introduce memcg_reparent_ops
Date:   Tue, 21 Jun 2022 20:56:55 +0800
Message-Id: <20220621125658.64935-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220621125658.64935-1-songmuchun@bytedance.com>
References: <20220621125658.64935-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index a8bd4bb39502..63dbdef60cbd 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -353,6 +353,26 @@ struct mem_cgroup {
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
index 346a954e190e..6ef3a264054e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -335,24 +335,60 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
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

