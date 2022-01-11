Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C1148A4A2
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 02:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345741AbiAKBDG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 20:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345733AbiAKBDG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 20:03:06 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14739C06173F;
        Mon, 10 Jan 2022 17:03:06 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id k15so60618043edk.13;
        Mon, 10 Jan 2022 17:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=gtH/Kion5HJLdt7FtzIkiM9uRZTByJ26w7a2rxZ6ieo=;
        b=qXleYNAEtWkveqdPsAnLgtk92hCEN09SWm8MqmPYwTeB5Z+ao26iVyzzy9RpgiBgTZ
         8jgSCWBbSu/+EcMPXaWB69plAmT+RzYF70HFPJGPze/pifY0liTk7l4bhV3LS3emDlSf
         TSlMHLsWyNFeVo9LGCl1fLz4RWow2N3xp3zHu1zCBsuANJQxavuEgZqY+iMsLs6946Mj
         z3bSwhaN4pSAxDE7azvHUiqAZL5/DLG+vb2+FOcmqVotTQlJTJVfyhPUTa8Rz/DUen++
         moKga1Zco3+BsQDcsATFw0hHoOaOsIZu6UTfn9mPV2b+gpLasbfx2DeA/YUKvIwXGmNS
         0BeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gtH/Kion5HJLdt7FtzIkiM9uRZTByJ26w7a2rxZ6ieo=;
        b=t1Bp7NlYgftwaD0Gcq2TfmaPjffV+bmuuyI4obFy8f1CaeaFM48ca/+0o6wQbZv54u
         BvM0c4cA7Kz0fesKIaQ2pOMmKfYYe3F4PaiBEzw0bHWNmjseT/EBQWTEVSJZhHcSzzXO
         wmQCe9P09BoqyZWjiFx913KLzniHQNAe6PhQYBXb717cY2VVUj1ceRUSXP/4RSOfnym4
         uYc17H4cddDeBctYRyh+gvm+x6oXU4D6A21DL0n/OZqaKwUAnJuPbtVvKm/scnkrlxJX
         +/dVwy5qFIDC/9nWDMwiRQh+vVYomWKo8Nhnq52j0LL799xmXjf6/delx3f1IT73nrbX
         w8/A==
X-Gm-Message-State: AOAM5334maF79rg63YlULVJCaXuq4vQvSs0vQX3d15AwwgQ0Pqc2zJ2f
        8S3LIioH1JzN87Tm7AMlL2k=
X-Google-Smtp-Source: ABdhPJzQ8x8kkI/8hwjjGRiuA1PLxA3FcIa/KPc7GCa12ZHynB+K97OHQE3/Cbi+isSsaC7j2CPQaA==
X-Received: by 2002:a17:907:7fa8:: with SMTP id qk40mr745080ejc.719.1641862984654;
        Mon, 10 Jan 2022 17:03:04 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id hc14sm2957460ejc.42.2022.01.10.17.03.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jan 2022 17:03:04 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        vbabka@suse.cz, willy@infradead.org, songmuchun@bytedance.com,
        shy828301@gmail.com, surenb@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/4] mm/memcg: use NUMA_NO_NODE to indicate allocation from unspecified node
Date:   Tue, 11 Jan 2022 01:02:59 +0000
Message-Id: <20220111010302.8864-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Instead of use "-1", let's use NUMA_NO_NODE for consistency.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2ed5f2a0879d..11715f7323c0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5054,7 +5054,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	 *       function.
 	 */
 	if (!node_state(node, N_NORMAL_MEMORY))
-		tmp = -1;
+		tmp = NUMA_NO_NODE;
 	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, tmp);
 	if (!pn)
 		return 1;
-- 
2.33.1

