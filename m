Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B1348A4A4
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 02:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346042AbiAKBDH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 20:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345865AbiAKBDH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 20:03:07 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CF1C06173F;
        Mon, 10 Jan 2022 17:03:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b13so7437781edn.0;
        Mon, 10 Jan 2022 17:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cOmBhmo4B4Ukm6s0FflMe2nP4T2kTWokfAC8k0+Tp8A=;
        b=YdgiRcT5b4ToQFSxyF5G4EFVb1dSoHDJMo4BUDntHy0fbYJAVvGNz2aLcQ9HPdOnrG
         Z1sygXtxjEKW5l21yHQYo6TMcsMuKs8+IwB4Bm5KBUiS2pCZK5M/by1eZa65loOVD11n
         /fQN9xKi5oCnon17uwfJ83+pqOmbLnfQ4gAuhkLEOrTz96IMpxOLoC6hD0ZugnSWdQ5f
         oMkmm+o+nQUJ9UZYxNmro9tT+l6fj5/Gssaid2pvz+RMJj7hjueA9Gk7AjS+CDpqSncg
         kiDq+AS7sukqRCjwLFbsn03pN318DzDzfQiZcvXxyZEpfYs8luKYAB85EAZG+JX0dren
         X+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cOmBhmo4B4Ukm6s0FflMe2nP4T2kTWokfAC8k0+Tp8A=;
        b=JLxfJAedG/Z8+gU76i2KEb+cWfKBa1HWGKDO2Z9Bi7UNFMxqHS9CwJ/LJrpPb583s2
         I3xDTfZYmpOvJHq0NlZ0JE1GlLFGXClI7nMznsAyS78h9BdNd6958FyD+qQcDVydwIFG
         7W0xf5M0k+jYWWVAHOLgA2PUL/XEPkyl6Ry9Aa6jQ/kSy1dueMmii3gTNZZ43OBt4AMi
         N+iLLGtYl3imDEEssxjnocZDIosAWQyCp2DE0rYX9TIn5OhN8IgtHQpOF7eHh1S7EvW0
         bdjX3VySbRNgbFAw6qfWOXSLfimbbuIm+PIIc17u4p4m4TSEHYuDqZaTmtQVpvpL/AJ6
         5Bhg==
X-Gm-Message-State: AOAM530LXw9g0v2cSF9FVMbTqx45wgUgHR45tpc3OOCR6urzGV92Hhz/
        OESWefFoYL9MOyMCBOZnxGE=
X-Google-Smtp-Source: ABdhPJxdEYNE0zGnRtVv966sHQg3qTYvZay17m6gYLTCfaNoG9QG4hGa8q87+UBkeLJYqwCUWADsBg==
X-Received: by 2002:a05:6402:3496:: with SMTP id v22mr2107340edc.263.1641862985361;
        Mon, 10 Jan 2022 17:03:05 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 18sm2968137ejo.8.2022.01.10.17.03.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jan 2022 17:03:05 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        vbabka@suse.cz, willy@infradead.org, songmuchun@bytedance.com,
        shy828301@gmail.com, surenb@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/4] mm/memcg: mem_cgroup_per_node is already set to 0 on allocation
Date:   Tue, 11 Jan 2022 01:03:00 +0000
Message-Id: <20220111010302.8864-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220111010302.8864-1-richard.weiyang@gmail.com>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

kzalloc_node() would set data to 0, so it's not necessary to set it
again.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/memcontrol.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 11715f7323c0..a504616f904a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5067,8 +5067,6 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	}
 
 	lruvec_init(&pn->lruvec);
-	pn->usage_in_excess = 0;
-	pn->on_tree = false;
 	pn->memcg = memcg;
 
 	memcg->nodeinfo[node] = pn;
-- 
2.33.1

