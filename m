Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9159875BBE6
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 03:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjGUBnr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 21:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGUBnq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 21:43:46 -0400
Received: from bjm7-spam01.kuaishou.com (smtpcn03.kuaishou.com [103.107.217.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A441186
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 18:43:43 -0700 (PDT)
Received: from bjm7-pm-mail12.kuaishou.com ([172.28.1.94])
        by bjm7-spam01.kuaishou.com with ESMTPS id 36L1hd8D011485
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jul 2023 09:43:39 +0800 (GMT-8)
        (envelope-from yangyifei03@kuaishou.com)
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
        t=1689903819; h=from:subject:to:date:message-id;
        bh=WfBeYmQN+HAjcDnQhJBJiepaQUpxGJpfp8LGbLzGAuw=;
        b=Uaujp7JrVr1HhJ67/IKB8PC6lCzPwguABUa/mYbRzCJlEzSqAEHPT0u5lEaBUcmfYhVglsuMskD
        zNAu9f2cVSHPRTkK2DKpir1lJq754dPe/xWT7D0VITqwOEDznIdlwlwb4C36JHtvxa6y3QNe7yz8J
        QjoFX/q8VCAyp35S4jU=
Received: from public-bjmt-d51.idcyz.hb1.kwaidc.com (172.28.1.32) by
 bjm7-pm-mail12.kuaishou.com (172.28.1.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 21 Jul 2023 09:43:38 +0800
From:   Efly Young <yangyifei03@kuaishou.com>
To:     <hannes@cmpxchg.org>
CC:     <bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <mhocko@suse.com>, <shakeelb@google.com>, <yosryahmed@google.com>,
        <yangyifei03@kuaishou.com>
Subject: [PATCH] mm:vmscan: fix inaccurate reclaim during proactive reclaim
Date:   Fri, 21 Jul 2023 09:41:16 +0800
Message-ID: <20230721014116.3388-1-yangyifei03@kuaishou.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.1.32]
X-ClientProxiedBy: bjxm-pm-mail01.kuaishou.com (172.28.128.1) To
 bjm7-pm-mail12.kuaishou.com (172.28.1.94)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: bjm7-spam01.kuaishou.com 36L1hd8D011485
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Before commit f53af4285d77 ("mm: vmscan: fix extreme overreclaim and
swap floods"), proactive reclaim will extreme overreclaim sometimes.
But proactive reclaim still inaccurate and some extent overreclaim.

Problematic case is easy to construct. Allocate lots of anonymous
memory (e.g., 20G) in a memcg, then swapping by writing memory.recalim
and there is a certain probability of overreclaim. For example, request
1G by writing memory.reclaim will eventually reclaim 1.7G or other
values more than 1G.

The reason is that reclaimer may have already reclaimed part of requested
memory in one loop, but before adjust sc->nr_to_reclaim in outer loop,
call shrink_lruvec() again will still follow the current sc->nr_to_reclaim
to work. It will eventually lead to overreclaim. In theory, the amount
of reclaimed would be in [request, 2 * request).

Reclaimer usually tends to reclaim more than request. But either direct
or kswapd reclaim have much smaller nr_to_reclaim targets, so it is
less noticeable and not have much impact.

Proactive reclaim can usually come in with a larger value, so the error
is difficult to ignore. Considering proactive reclaim is usually low
frequency, handle the batching into smaller chunks is a better approach.

Signed-off-by: Efly Young <yangyifei03@kuaishou.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4b27e24..d36cf88 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6741,8 +6741,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			lru_add_drain_all();
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg,
-						nr_to_reclaim - nr_reclaimed,
-						GFP_KERNEL, reclaim_options);
+					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
+					GFP_KERNEL, reclaim_options);
 
 		if (!reclaimed && !nr_retries--)
 			return -EAGAIN;
-- 
1.8.3.1

