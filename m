Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D234ED05D
	for <lists+cgroups@lfdr.de>; Thu, 31 Mar 2022 01:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351868AbiC3Xte (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Mar 2022 19:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351873AbiC3Xtc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Mar 2022 19:49:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F9865D36
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 16:47:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j15so44578513eje.9
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 16:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VUJcnVdgNFYpQDTJEWf7H0xzus0K/Xa4FeMP7a1KnEQ=;
        b=ncvvGkdIFWyKuP25ghEWF3nSN6sW8+Q7qWkT1iDxucHp0v6lYGY/ZDllouL2Y/nAUz
         EfKl+Yna/ir+zTvabWIpqqPHbltci3rU6r0a/FfdvzTVkf/skKhGJIz18w5ccDRwnvyU
         PkCYTjGdCQqDJx0pTYz+iL5ZB/pY+zf4Ib1Q5D9f2xj+T1Sb9GR92JTnrsXPdu6ybLJ6
         QOKZxMy/CHs6nqkCPMHlp3Gr0FNX3f+TDadXhTC+jZM0QMdlg192xUdoD+jezjIDkBoz
         zEQ86AmCcX1LTF0ikiCsHDhKBWGD/mK/GxpycZ7iTVU31o0EMsfFH4hiQomO1nQr+xKL
         CUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VUJcnVdgNFYpQDTJEWf7H0xzus0K/Xa4FeMP7a1KnEQ=;
        b=tXeo+k89UBZ91k13cIAnYt0lnpITDEp5QIG8P85A6wRhnW7WPk8G6rAgJAB0Vg6JtX
         /Iia/zRZ+mBIhQPFPvmy8tOQ8NAzkC6xMHr0a7N3v5GV4Rn6L/PD1ugyyjf+rSBUwzey
         ACaTQrVfleOThMfR2l8ZfGM9M+5fGWzWOXlFkH+roP7sN+2+6zdxA81K9ILMKseJvSSW
         jTLnXHWSz2syNXNUJecetKbeupLqKvHw+Bz+rP/cFX1tsU7759owa3V4FmIdw6p4mmTl
         1FDAjX7VLx6JZtF8a8b7kW3WKmsJVQVeFUD6RfAdnY8MxZBHc8Ny8DRoNeXzxSbXNjQg
         1odA==
X-Gm-Message-State: AOAM5325WNcexJlDf85TbznCMGbddPaTJJ75bAm+km0hhBsRlFyqOTLc
        dMScWqhdxYFdUmb+o9+rIQ0=
X-Google-Smtp-Source: ABdhPJw/jBcGuEajUDutfuFfQAkzGZRZEOEI2ekZslgcYDUMcqzDRhHPQu4M3nSpuKl7u4RxhGoE6g==
X-Received: by 2002:a17:907:7244:b0:6df:fb38:1d02 with SMTP id ds4-20020a170907724400b006dffb381d02mr2309148ejc.453.1648684064052;
        Wed, 30 Mar 2022 16:47:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id qa30-20020a170907869e00b006df9ff41154sm8734153ejc.141.2022.03.30.16.47.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Mar 2022 16:47:43 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 3/3] mm/memcg: move generation assignment and comparison together
Date:   Wed, 30 Mar 2022 23:47:19 +0000
Message-Id: <20220330234719.18340-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220330234719.18340-1-richard.weiyang@gmail.com>
References: <20220330234719.18340-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For each round-trip, we assign generation on first invocation and
compare it on subsequent invocations.

Let's move them together to make it more self-explaining. Also this
reduce a check on prev.

[hannes@cmpxchg.org: better comment to explain reclaim model]

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>

---
v2: a better comment from Johannes
---
 mm/memcontrol.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5d433b79ba47..2cd8bfdec379 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1013,7 +1013,13 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		mz = root->nodeinfo[reclaim->pgdat->node_id];
 		iter = &mz->iter;
 
-		if (prev && reclaim->generation != iter->generation)
+		/*
+		 * On start, join the current reclaim iteration cycle.
+		 * Exit when a concurrent walker completes it.
+		 */
+		if (!prev)
+			reclaim->generation = iter->generation;
+		else if (reclaim->generation != iter->generation)
 			goto out_unlock;
 
 		while (1) {
@@ -1075,8 +1081,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 
 		if (!memcg)
 			iter->generation++;
-		else if (!prev)
-			reclaim->generation = iter->generation;
 	}
 
 out_unlock:
-- 
2.33.1

