Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7709E4ED05B
	for <lists+cgroups@lfdr.de>; Thu, 31 Mar 2022 01:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351869AbiC3Xte (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Mar 2022 19:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351868AbiC3Xtc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Mar 2022 19:49:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2525D65D26
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 16:47:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bi12so44696022ejb.3
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 16:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F2sr6A+74F0K682i5KfFbDfyxE+MQpH5kf2WVRDaVIg=;
        b=DXlRh9VdTEpO7NS8UN7I/7xFcNqWI9MpkZUOkkXQrKpqPO+/o7s8ip5/V3wuJlw9OC
         N3JRk5k243KQRIuZCPQP2fwXOTj3I89ZdtinJXIsTV+Yyy1E8T+vW0I7IB2dOco/Idn9
         CG3tUrd4r5OzGyJRPpU3422sei2X2oIgWsBz6S6wAlgwQzPlkMw+E2SMYoOWVJ9v9nrM
         FFT3i2i6zxf7106D+R9OFTCDqr58JFeYzzWuOWg6KtBG6Qr1KppDZNE1fes9Kaguf5Z9
         Rj5p1RThizy2W3wNBRgnN6gGxCIGyH6cq10Ur8eWx9EWyHWotIdxRDSCOlXYEPUBXlA+
         31yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F2sr6A+74F0K682i5KfFbDfyxE+MQpH5kf2WVRDaVIg=;
        b=otud+efyEp5ZmDFTFdIwiDcP4NM3p9l7z7KvJndIt+iENXzp2fedAN5ql2Sh6SnBZO
         CEK+qIVew/neaJoillUor2gQVfjUb//n9eL25UYpCaTSMkNbUnSSA2vQOg/xOmjx/QrB
         iTUZgkUKhEZKDMvdF8CHoWMOWUbV5mTLi+ooh9XpOUh9tqzj4brNQyn51OJZeqecIAdP
         erLsX1xBlWfc2GYpVyjWdopl0M5ymurq+AHmTqE4Lst4Xg2ewRUNYhzeIaRQd+w4BB3k
         lKNu3DViRIxkfvmsufYv13xn9ATy/BL4TRD14SXfFMpHiysa51JjwAjoVaHRQh8XemNX
         8I/Q==
X-Gm-Message-State: AOAM533hNfLVTtjG2SrqiBCTfuCFrCpvwxNwkW2F6LtWBj/pSWccpWvZ
        wI3gWymB6mNwAPZ3TmQ2Fmk=
X-Google-Smtp-Source: ABdhPJxzxxKzXun8q1D4jDTvVnY2R6tSETGwmLXnIvxFv5FeES3d4jdl2vhSvZHTjQQ6vZQ4adTvKQ==
X-Received: by 2002:a17:906:4fd5:b0:6e1:2084:99d2 with SMTP id i21-20020a1709064fd500b006e1208499d2mr2245403ejw.639.1648684062588;
        Wed, 30 Mar 2022 16:47:42 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e28-20020a170906649c00b006df6dfeb557sm8719049ejm.49.2022.03.30.16.47.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Mar 2022 16:47:42 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 1/3] mm/memcg: set memcg after css verified and got reference
Date:   Wed, 30 Mar 2022 23:47:17 +0000
Message-Id: <20220330234719.18340-2-richard.weiyang@gmail.com>
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

Instead of reset memcg when css is either not verified or not got
reference, we can set it after these process.

No functional change, just simplified the code a little.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dc193e83794d..eed9916cdce5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1057,15 +1057,10 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 * is provided by the caller, so we know it's alive
 		 * and kicking, and don't take an extra reference.
 		 */
-		memcg = mem_cgroup_from_css(css);
-
-		if (css == &root->css)
-			break;
-
-		if (css_tryget(css))
+		if (css == &root->css || css_tryget(css)) {
+			memcg = mem_cgroup_from_css(css);
 			break;
-
-		memcg = NULL;
+		}
 	}
 
 	if (reclaim) {
-- 
2.33.1

