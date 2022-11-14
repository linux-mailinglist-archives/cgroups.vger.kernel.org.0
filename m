Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9806289C0
	for <lists+cgroups@lfdr.de>; Mon, 14 Nov 2022 20:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbiKNTtM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 14:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbiKNTst (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 14:48:49 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158242983D
        for <cgroups@vger.kernel.org>; Mon, 14 Nov 2022 11:48:12 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id u7so8417079qvn.13
        for <cgroups@vger.kernel.org>; Mon, 14 Nov 2022 11:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=omJyx+p3MZnXmMetOfD+Vb81mPQBWZRFtKehGT/esV0=;
        b=oPRUVWptCQQmFoRVOuC0Bg4LNaPVc12ejrt634brCi0WT/hC+s0sQDVTF10pFjtxTY
         2yzL0yNRUHUd1oX17N/BxcyF/qmvW3QhZXrPtNzOoYFRIF5RqMINMd8PvVISkRHPY2nu
         68op9yrb34dqOW+3Y/FmdRZGxNalulMhlZOhIWvbmehB0CgB/lnmP/jC1uO6+q+bozBP
         R2kGUT3x9G/BALjKomL4YolNC6TRbHvc0sb4+upz0vx0CduE+3gfG/V/K3kVbe2xce5l
         UexYq0kHvri6fpktU2NgA+FKrK4tHRhL88cyTTD/yRn0z7X5yBdQ4jbRxt0ut+v9nLt0
         MaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omJyx+p3MZnXmMetOfD+Vb81mPQBWZRFtKehGT/esV0=;
        b=cAZf+MYcomnQEgY8dwTexexjbmWOP4a2icH9Mwl3VHBw98pmbmjpLbIGE/BdPGbWNv
         DhIxPb3K3rBculDXpYosHJdPvEMW7CavGQXb1xUGBGaDT5QehwMgWme3N/9Eg6AZKKuP
         PfahajXHlzcZR3WtqFg0SaV00A0UZ1KuxZQ7YUdXBgSPEn4u9XUmQt7y65tVNedttSLj
         1NL4Iw8eXjrk91jBKULqWeeCarYRMwCU69hlAmWaLh7aaI3AiZhz+Q6/Viaj9keANR+m
         iS1L2fue+0aSiJI5jhg3npR47UTBneL9+tywia1uABmJxF89joCAS2M1/6a2RlfkyqnF
         UXVQ==
X-Gm-Message-State: ANoB5pmaPvIhkKB0RugL4ryMm2Go+wLvaJ8m0Sf6PjXZEYE3Csm8OZPx
        dgZRnRfsPBzAUsio0Nol7Nyvgg==
X-Google-Smtp-Source: AA0mqf4wUNlfuKye4Owp4CiIw1RKoijXmW0oaG+ryyGoW8oK71GRxdThjAXUznrw22jSjvSwItFBFA==
X-Received: by 2002:a05:6214:2b9c:b0:4bb:684e:c94f with SMTP id kr28-20020a0562142b9c00b004bb684ec94fmr13996725qvb.52.1668455287880;
        Mon, 14 Nov 2022 11:48:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:e032])
        by smtp.gmail.com with ESMTPSA id s36-20020a05622a1aa400b0039cc944ebdasm6121471qtc.54.2022.11.14.11.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:48:07 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Liguang <liliguang@baidu.com>,
        stable@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: correctly charge compressed memory to its memcg
Date:   Mon, 14 Nov 2022 14:48:28 -0500
Message-Id: <20221114194828.100822-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Li Liguang <liliguang@baidu.com>

Kswapd will reclaim memory when memory pressure is high, the
annonymous memory will be compressed and stored in the zpool
if zswap is enabled. The memcg_kmem_bypass() in
get_obj_cgroup_from_page() will bypass the kernel thread and
cause the compressed memory not charged to its memory cgroup.

Remove the memcg_kmem_bypass() and properly charge compressed
memory to its corresponding memory cgroup.

Link: https://lore.kernel.org/linux-mm/CALvZod4nnn8BHYqAM4xtcR0Ddo2-Wr8uKm9h_CHWUaXw7g_DCg@mail.gmail.com/
Fixes: f4840ccfca25 ("zswap: memcg accounting")
Cc: stable@vger.kernel.org # 5.19+
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Li Liguang <liliguang@baidu.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This fell through the cracks in summer as it didn't make it to the
right mailing lists. Resending.

I know it's close to 6.1-final, but the fix should be safe to put
in. It's straight-forward and obvious code-wise. We also have large
parts of production running on it without problems.

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d8549ae1b30..a1a35c12635e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3026,7 +3026,7 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
 {
 	struct obj_cgroup *objcg;
 
-	if (!memcg_kmem_enabled() || memcg_kmem_bypass())
+	if (!memcg_kmem_enabled())
 		return NULL;
 
 	if (PageMemcgKmem(page)) {
-- 
2.38.1

