Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB43E4C3A66
	for <lists+cgroups@lfdr.de>; Fri, 25 Feb 2022 01:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiBYAfQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Feb 2022 19:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiBYAfP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Feb 2022 19:35:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE4929DD60
        for <cgroups@vger.kernel.org>; Thu, 24 Feb 2022 16:34:44 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x5so5188117edd.11
        for <cgroups@vger.kernel.org>; Thu, 24 Feb 2022 16:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ilQGiGw+cHHnWYdpNd2TsqiqLrmn72vknxopCrZER/Q=;
        b=EXhP+YADKLWYCXD23XUiXLkpefnymxGvQ/D3MVz2Nk0z3XGGwRNe8I8uITmCtQwIFm
         4VBod9Tn78bwab2BZ6kHXnt2BwHZ8uUEHy7OzOAKBSZJ6fc1QETVMyQqbXCcNsyyNHmj
         97dZX0Epb88JPt0lOOpWx5jvJ4XY959jv7wVBuSoVSgpqg8I0ylEXoDrTok1pLCiMh5F
         tXdlQvD1HPzeefQzeA955geaPEZK76a0puWvb624G1Uk60kRkYJM9LXDRiEGmrQ7jnYq
         0HtNtCuP/AO4ipwxFWETbeAfyVM1DbdZnpvq2VBPheijzUBcevHVMOJzgQp4VUcYlosT
         Qe9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ilQGiGw+cHHnWYdpNd2TsqiqLrmn72vknxopCrZER/Q=;
        b=dRjMFZoEW7dstvBv7bFjdn3XT74pWI5lrDgkTWvBC8hgO81lxCNgy8bmHdkyJQ1aLc
         cwdE0ZcBChRObjf83EbbYpw2fABHjfKTzAq71NMkQG/V8kkffPGVWmQIs9kt6tqqNnkH
         pSx7eltnR0VFSCrQVoo7+JEBoz19Y3v2as947KXT/zrm/uHdu516j9U7EN9l+ZGJQdGt
         Y4G7xqot9P65V0axjeTqJb78QikO+uRDEIBPuk+jNHmEP/uhTf/m7xeKBPRqjwSCf6hP
         WZuEWl5+y5tu0MGvsBYm2pDooXddLx0uok+yqlBJQTZLuEYh8dFLo26pLyc4Lhf38VXa
         hPpA==
X-Gm-Message-State: AOAM532LmVWSX4GOE3VOcrnBaJLVL9WOI1gycbej4lVAHg173eJotkQz
        SQQTrOy5xnDv2TcNRQ/uUWI=
X-Google-Smtp-Source: ABdhPJyuoa5ezgs1FJUFIN4JTKE1OZe4PXfPQZ6hNFf3F6TNXGWk9P7dqdy+drSU3xm8bap1JfloTQ==
X-Received: by 2002:aa7:cc82:0:b0:410:d2b0:1a07 with SMTP id p2-20020aa7cc82000000b00410d2b01a07mr4691617edt.359.1645749282998;
        Thu, 24 Feb 2022 16:34:42 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id dc4-20020a170906c7c400b006a9bca854c2sm337086ejb.37.2022.02.24.16.34.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Feb 2022 16:34:42 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 3/3] mm/memcg: move generation assignment and comparison together
Date:   Fri, 25 Feb 2022 00:34:37 +0000
Message-Id: <20220225003437.12620-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220225003437.12620-1-richard.weiyang@gmail.com>
References: <20220225003437.12620-1-richard.weiyang@gmail.com>
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

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/memcontrol.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 03399146168f..17da93c2f94e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -996,7 +996,14 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		mz = root->nodeinfo[reclaim->pgdat->node_id];
 		iter = &mz->iter;
 
-		if (prev && reclaim->generation != iter->generation)
+		/*
+		 * On first invocation, assign iter->generation to
+		 * reclaim->generation.
+		 * On subsequent invocations, make sure no one else jump in.
+		 */
+		if (!prev)
+			reclaim->generation = iter->generation;
+		else if (reclaim->generation != iter->generation)
 			goto out_unlock;
 
 		while (1) {
@@ -1056,8 +1063,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 
 		if (!memcg)
 			iter->generation++;
-		else if (!prev)
-			reclaim->generation = iter->generation;
 	}
 
 out_unlock:
-- 
2.33.1

