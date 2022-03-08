Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4224D0D73
	for <lists+cgroups@lfdr.de>; Tue,  8 Mar 2022 02:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiCHBW7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Mar 2022 20:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbiCHBWz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Mar 2022 20:22:55 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D803637009
        for <cgroups@vger.kernel.org>; Mon,  7 Mar 2022 17:21:59 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id r13so35835273ejd.5
        for <cgroups@vger.kernel.org>; Mon, 07 Mar 2022 17:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sX5s7jKgXd2WsU9F7nau9nEnt0LTAgg+hfHcITuEuBM=;
        b=ENqz0NVeHdKTzIpACb7Q9gDD11SNNdauqiy2jAzmxV49Bs5xz4/6u9nc363FgnwjOc
         db2aQrmbgMm+JEYdPncFEX5VQQvsjRhKVbvD+muJcfiBRB3R6diHamEZVbnJUElfYMuG
         K3ST7QJkIRRXUetvZ6Aad9u1qs+uNVbbL396ReLYD6W7jFWTCK/au2vp1ulGBSqTS3K8
         dmGAadaViT8WcX/booDtkS9outqBMSNflWKOygUbbjiOdYnZOMAuIvhB8GjmBaXUXsnZ
         1uV5J5PCNTxR8Qz3h6bQzbo+ZQ0H3mI8J0TkdHHpzQwO3jTkl8rKoNKzMKtUN1DvKjcK
         BMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sX5s7jKgXd2WsU9F7nau9nEnt0LTAgg+hfHcITuEuBM=;
        b=UAMi/gwV9hVsX8yNQfaDY+V9/OX7Mmty/5bjNdAUX1QmXeAVgQYf8DGlGnB9gbG8ko
         GXRTjsJaDaQvquou/zL2hvChw+lTAQnzXg/lLO9JGZxPm90154P7YtnwJp4TyL6H+MSX
         cbdCPWR0HEd5C3F4LGBvmRL/8+44w/rQ9GSWIvcI7A0U5+IKNR74BjnKaEPkK1AFhGSd
         kiujCjZRvnMRKgvGzwyJiLC17wY5S6YByk1EcGVz0XAzchDpp11gcNdh8CWgY6cLabYQ
         ZeTE9Mx7Ou4Z0s2GoaWHzvr8DUe44AbaeIxD6d4picnOC5MW4HIJ5Vjo/yJMYwRwZXsF
         SqFw==
X-Gm-Message-State: AOAM531mVgjLmgKmvh5zI2rjuostKBYxvDVhMfBikeo1M379W0hB9A/6
        3iHIPD86wvfVWE/1c3/zo10=
X-Google-Smtp-Source: ABdhPJwWvWbB6M4I64azTUqYp6eC7GowACebPQj8LpOgHNGq+QTdwjlKOjawgZ8a2CZH75xh5YFdGw==
X-Received: by 2002:a17:907:7f2a:b0:6d6:df12:7f57 with SMTP id qf42-20020a1709077f2a00b006d6df127f57mr11161124ejc.122.1646702518516;
        Mon, 07 Mar 2022 17:21:58 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906144200b006ceb8723de9sm5193049ejc.120.2022.03.07.17.21.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Mar 2022 17:21:58 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 3/3] mm/memcg: add next_mz back if not reclaimed yet
Date:   Tue,  8 Mar 2022 01:20:47 +0000
Message-Id: <20220308012047.26638-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220308012047.26638-1-richard.weiyang@gmail.com>
References: <20220308012047.26638-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

next_mz is removed from rb_tree, let's add it back if no reclaim has
been tried.

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

