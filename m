Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23970537603
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 09:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbiE3HwS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 03:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiE3Hvw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 03:51:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEBA73551
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 00:51:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f18so9668452plg.0
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KV6RbMM8w6wD8F4JQPmwSzYM0iR92dgQE9lDfN51JOg=;
        b=OD2hATG9TOBEVqaSLbbb7DYN7E8AxGheax8qlgspCPL4scsq8K8ZDBJOLH6UR68odC
         s2KrbB/vRF3Bw+pYrdYCdp60/yeTrEYzRqbRKi8mCN0RtzUDev0NTCWYwqBZxmc2wc+n
         xSzVbVM9KwQdSk51ksO9a4BBDdf5ZwsFojHgLgUQaUx/Ls26AttA2JUg7SWXFBumtoYG
         fj3u7jLmMbfOQXtlNBi+WO+WEoIHGKj6wXpZLWfcDUfZcjqV+/WPOCBFIWgKk9P24235
         7c9W84Xep8nVv4TwBL/lczB1wY+BTC1hu+9N4zYnuxQEn02sXN2tnwfUZlH3S/BQeLRJ
         94cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KV6RbMM8w6wD8F4JQPmwSzYM0iR92dgQE9lDfN51JOg=;
        b=tqDRJZ/ngMLDofqTF6FwUA+RoIjH7jgtQNi9ShKajYF58cWBKLucgKmm15G0kxAK12
         kvhIo7D59j5hN8GU/8pD8Y9TpFj2YD2Ny6glL+xvFUWLWxlxL4HyqJA3vT9TWByT4YPo
         njd0uh4dfcrDOcFpBAedieGAsSCjVnlgWYsNa7P+lSdQLvc3I6waHJlGkC/FaDu5txxR
         rvcO2mWXb81kcj0IEfrky6+eBsTvLUghV7eqrhCFFKnz6ozIONjuEXkCZz55w3JaC+n4
         hw7QDklZB+sY+ALRzI/uMgQVUa67Ow9SuAHxUGRO9X8QAbMT6fbUIa1Lc807bKXEXXAw
         gH8w==
X-Gm-Message-State: AOAM532qbPiuF8xkCjeLwdNCtIZ4Y8YHqLvkeP6dJzy0/68NTv3UJfHu
        grHdVcSw4UgVBMbWh/7T87glEMEzrT+UyA==
X-Google-Smtp-Source: ABdhPJx6AClcURIyJsLO64YIW87asSM1Y5uhNBox8YFpOq5D89BEw3QtMBy0j3V9+Otgo4I2gLmM6A==
X-Received: by 2002:a17:902:bb82:b0:163:dc33:6b88 with SMTP id m2-20020a170902bb8200b00163dc336b88mr4349088pls.135.1653897086375;
        Mon, 30 May 2022 00:51:26 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([2408:8207:18da:2310:2071:e13a:8aa:cacf])
        by smtp.gmail.com with ESMTPSA id a23-20020a170902b59700b001616c3bd5c2sm8421381pls.162.2022.05.30.00.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 00:51:25 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 08/11] mm: memcontrol: introduce memcg_reparent_ops
Date:   Mon, 30 May 2022 15:49:16 +0800
Message-Id: <20220530074919.46352-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220530074919.46352-1-songmuchun@bytedance.com>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
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
index 16464116f94a..c2ac98a0ece4 100644
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
index 4cc392741753..059188eeb80c 100644
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

