Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4489C4D6D35
	for <lists+cgroups@lfdr.de>; Sat, 12 Mar 2022 08:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiCLHRy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Mar 2022 02:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiCLHRw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Mar 2022 02:17:52 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A1D1E5A49
        for <cgroups@vger.kernel.org>; Fri, 11 Mar 2022 23:16:46 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id kt27so23578526ejb.0
        for <cgroups@vger.kernel.org>; Fri, 11 Mar 2022 23:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6eF3CkGTMOIQmVHUtkEwTATvUD+GDDg0zGlDrlu3cRs=;
        b=LJ8fzFe6HkpMjK3dAG/kkCB3VwjmJ5YokqYQBqn6mRELFnmoDR4ND2YGflHHQEY3cw
         cHN2GmvSaxTqzUyKiaZ6G8mHq8RfzREKBl/YpsSReGoKIicDRHevo1QbIm1z64ki9ydZ
         pRhNKC3UotSGcN2JnVtD+VJ7gz7fnGndetV6M4+7G3pGlRMVUfOdoBLqqjJonINME7Lz
         X1wG7JfWG67Nm3dD3p8y7Vmt+mZiOjMmF9XwDF/9Z2bTX6XZJ88FXOTMfvYNrcmzXyuH
         UKAMGTiXg31ZO88PFlisMM/+EvoJVtJ60F3IWXVXj7eWcyg3PQBPDPcLj8gastjMjOZT
         hXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6eF3CkGTMOIQmVHUtkEwTATvUD+GDDg0zGlDrlu3cRs=;
        b=XNSDvM6XFfHmNFABD/eiwu4F63SN1VstlloHPkNJWaE20YBJqqTs7tcgsmlSTau/Re
         9d6fkUmCswCcl1QW54zc1IkRNePYlrJHugFNedeDCzI2n0Bko6udkD6WZeSzYiutUa0c
         sOXuamV9O191ULhIP5FpJQ3onMVBg5BJJRD27tlJr0G2CBSu0L/Vt/zHcy6oqUQWYhj7
         kXG+nhQUi58nmdylDhv0YWU3QI/JtyYePQkawVeKjMtD4LpaHFsRb8oR5dhRWAQ21gJt
         MNuZOwKfwV4Z6ffoQtGlWYf0lpIljd0SnmPDelKOclFzEKWaLYwCYWvemeTidueTqXEC
         SNYg==
X-Gm-Message-State: AOAM531r2fL92Zkds9JKbCWmQRYFav1+a8OcqMr9yKciFx4q4J7OGHS6
        C2TY0RdScqeK+z2Opm+WLZA=
X-Google-Smtp-Source: ABdhPJwqMXsfiaLvKKPLz6WsxVosaOPmy5L2VlCKhaMPJ2MZj7Bkc+bVrRx/4xwJMxKmu3vU7/oliw==
X-Received: by 2002:a17:907:6296:b0:6da:745b:7b40 with SMTP id nd22-20020a170907629600b006da745b7b40mr11567649ejc.750.1647069405200;
        Fri, 11 Mar 2022 23:16:45 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006dbb2c2a847sm1148528ejm.125.2022.03.11.23.16.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Mar 2022 23:16:44 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 3/3] mm/memcg: add next_mz back to soft limit tree if not reclaimed yet
Date:   Sat, 12 Mar 2022 07:16:23 +0000
Message-Id: <20220312071623.19050-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220312071623.19050-1-richard.weiyang@gmail.com>
References: <20220312071623.19050-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When memory reclaim failed for a maximum number of attempts and we bail
out of the reclaim loop, we forgot to put the target mem_cgroup chosen
for next reclaim back to the soft limit tree. This prevented pages in
the mem_cgroup from being reclaimed in the future even though the
mem_cgroup exceeded its soft limit.

Let's say there are two mem_cgroup and both of them exceed the soft
limit, while the first one is more active then the second. Since we add
a mem_cgroup to soft limit tree every 1024 event, the second one just
get a rare chance to be put on soft limit tree even it exceeds the
limit.

As time goes on, the first mem_cgroup was kept close to its soft limit
due to reclaim activities, while the memory usage of the second
mem_cgroup keeps growing over the soft limit for a long time due to its
relatively rare occurrence.

This patch adds next_mz back to prevent this sceanrio.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/memcontrol.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 344a7e891bc5..e803ff02aae2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3493,8 +3493,13 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
 			break;
 	} while (!nr_reclaimed);
-	if (next_mz)
+	if (next_mz) {
+		spin_lock_irq(&mctz->lock);
+		excess = soft_limit_excess(next_mz->memcg);
+		__mem_cgroup_insert_exceeded(next_mz, mctz, excess);
+		spin_unlock_irq(&mctz->lock);
 		css_put(&next_mz->memcg->css);
+	}
 	return nr_reclaimed;
 }
 
-- 
2.33.1

