Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E404A5440
	for <lists+cgroups@lfdr.de>; Tue,  1 Feb 2022 01:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiBAArC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 19:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiBAArC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 19:47:02 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7818CC061714;
        Mon, 31 Jan 2022 16:47:01 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id s13so48678553ejy.3;
        Mon, 31 Jan 2022 16:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=uPVLcxrrpf12Ei4lWc6lSHRXgw8cc0G/gavfe4Q9af4=;
        b=hdpLvN0QxInM8+zBsj9rlh83NVjYyFJoIFuN/De4NAA9EcVJhT7Wqhkcj75YZEeEV2
         th2W52TZaFlmrPuVbf6bmepEh9nDGgI4CSDd+GaLoRrX1GocorJrKLmA9JiVmpB6t8s5
         66kbKsZny0SG2cCxsmhC78eAk8a3CPKbs558vyZgfnz46XL3sxK28SQN2uG3f6XLjnzl
         LNghAm/XyZAZInH39ADFZhe9ctC11i3g7jcQor7TRZxqtGO16EuWNH8wT2AC3cDP3IuA
         0C0BTkQ33c8fKzbuibkJDmgEw1NtwrOcnpFtlrZOFnPEaDzl3jCxB+jJoKQlGI40mEK6
         Gi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uPVLcxrrpf12Ei4lWc6lSHRXgw8cc0G/gavfe4Q9af4=;
        b=TiceN4VhKLMmTTQ7rot6B4Of3l8XLvfU+rWxZVQq6zLicZ4VHytqRQUjzpNH5E3kT2
         dLqTMcrvnZeUFhgwk+ju7EU0uP4zmQ+AS0uUCrWmDyXrN4yepKR/noojfxnb75fB6Wtj
         rwQvgZJjrUqLXtPNDhYKkipgpJfJq8y2i9YqrOTa/1ZQO+DNVZQ76L0aqA9jq7hI+LrI
         aM+GynvabMk1o5yOxUq1cM884O/MmjcvCDechMiz3ahMpPff85RZ1WVqFbon6ME/IA1i
         Tv2kBhdxRDS3P5pSHlH1sOwPIUSSTuSDvpwvnbUPMMwWIWHJrVjuJjgfuPZPAg7M6TJs
         6NMw==
X-Gm-Message-State: AOAM530rZEvjQaChNuTvPojqCkranxycOa1Pza4gqvLWg6B3yp8VLyYU
        kZ5RdFSWDiMZj9/eaHw1XsU=
X-Google-Smtp-Source: ABdhPJw8HWmyZMvyKUz/GCpLFtIhWj2bZvqHd92ATTkn5xbAydEP5bf6sPKyPc0j527YW5ynQlVdrQ==
X-Received: by 2002:a17:907:c19:: with SMTP id ga25mr20364151ejc.606.1643676419516;
        Mon, 31 Jan 2022 16:46:59 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v10sm18500935edx.36.2022.01.31.16.46.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Jan 2022 16:46:59 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        willy@infradead.org, songmuchun@bytedance.com, shy828301@gmail.com,
        surenb@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/2] mm/memcg: mem_cgroup_per_node is already set to 0 on allocation
Date:   Tue,  1 Feb 2022 00:46:42 +0000
Message-Id: <20220201004643.8391-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

kzalloc_node() would set data to 0, so it's not necessary to set it
again.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ea8460658550..ce7060907df2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5070,8 +5070,6 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	}
 
 	lruvec_init(&pn->lruvec);
-	pn->usage_in_excess = 0;
-	pn->on_tree = false;
 	pn->memcg = memcg;
 
 	memcg->nodeinfo[node] = pn;
-- 
2.33.1

