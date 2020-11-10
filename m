Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3617A2ACB83
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 04:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgKJDKh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Nov 2020 22:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKJDKf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Nov 2020 22:10:35 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D4C0613D3
        for <cgroups@vger.kernel.org>; Mon,  9 Nov 2020 19:10:33 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w14so7469423pfd.7
        for <cgroups@vger.kernel.org>; Mon, 09 Nov 2020 19:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KlEMtRRnho5R/oyJ91jqGRJUyzsYfbjHE3I8y8AmGbY=;
        b=R9EijyKWLRbgDkV06Ti/5mY8HOQ6susqJloDOVCXIqcYpJ5pb7SPWMpqTcgVWIVS5r
         UiWNh/k9/+E8/5FvOJc5/z01kkQXtzYtvo34o/4wSuS14FkmgIttf4P8P51S7wPytvTS
         5B66HUz6Mu3iZsXyOCgw3HOm4eH0CCd4a6HCYOPQim/YG48Q9J2GvppV+acfVBsj2I+n
         qEn/5duGPZYda8iUehkSKlqVH8gb6oxgUD0TIuYpwuflNL+sFFjEq8RYaStSNbgWxyWf
         Rfb8TgiWxwR4PAcKDy7UXYv2O0tWoo2fhiZMf9o29JfklOxBeWfqWY/mi6EqSdgIBNWZ
         nvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KlEMtRRnho5R/oyJ91jqGRJUyzsYfbjHE3I8y8AmGbY=;
        b=BaqhdqmbHXluiHsyAiQzxX+RA/5C8fFxjF8aYusJO0IfGNUFVdvni4cjIUBU+USV9H
         l5Jihs43MJ5fQRgtxi5aMM8jDYsHS0NqY/Dzl3DqDQUAuGg1OIV7WxGQ8fh+i7ANrwLc
         56kU6Ld9++Zs3mGxl3PAKUepnHvy9ayGw+Xb9yVp15AXSCZY6QZ/XRgMyWZh2ln5IAux
         had3uGO3uNGUq49E40RjRz4O/r8VWhtmSDGs5fVIgZMpUyMkB9PdnM2hAkX1UYZ53VE5
         moX//WgXcVY3D4K+On0C4jtTnh2n6XTLFtd6dpmDUlrdYhoG7O5Pb6JPGPMTv4PQHX7O
         yt8w==
X-Gm-Message-State: AOAM530NTP/O4KJu2dxgsyuYkHvUFoPJfiSL6l37xWKgnYBo3Z4Z4kYB
        bNPOaOx/1Cx+JKMpDHpanl6hfg==
X-Google-Smtp-Source: ABdhPJzMwdYeC7bP7dbpCG3uH9hlZ//GTpy7Fpt+Z4ZQZ5rEo1kP/4pXtYH8kMPqENENg+OpZFmrWA==
X-Received: by 2002:a17:90a:80c6:: with SMTP id k6mr2547448pjw.73.1604977832879;
        Mon, 09 Nov 2020 19:10:32 -0800 (PST)
Received: from Smcdef-MBP.local.net ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id i11sm12116305pfd.211.2020.11.09.19.10.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 19:10:32 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, shakeelb@google.com,
        guro@fb.com, vbabka@suse.cz, laoar.shao@gmail.com,
        songmuchun@bytedance.com, chris@chrisdown.name
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2] mm: memcg/slab: Fix root memcg vmstats
Date:   Tue, 10 Nov 2020 11:10:15 +0800
Message-Id: <20201110031015.15715-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If we reparent the slab objects to the root memcg, when we free
the slab object, we need to update the per-memcg vmstats to keep
it correct for the root memcg. Now this at least affects the vmstat
of NR_KERNEL_STACK_KB for !CONFIG_VMAP_STACK when the thread stack
size is smaller than the PAGE_SIZE.

Fixes: ec9f02384f60 ("mm: workingset: fix vmstat counters for shadow nodes")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 v1->v2:
 - Just resend the patch.

 mm/memcontrol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2dde734df7d1..bbd40c5af61e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -875,8 +875,13 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 	rcu_read_lock();
 	memcg = mem_cgroup_from_obj(p);
 
-	/* Untracked pages have no memcg, no lruvec. Update only the node */
-	if (!memcg || memcg == root_mem_cgroup) {
+	/*
+	 * Untracked pages have no memcg, no lruvec. Update only the
+	 * node. If we reparent the slab objects to the root memcg,
+	 * when we free the slab object, we need to update the per-memcg
+	 * vmstats to keep it correct for the root memcg.
+	 */
+	if (!memcg) {
 		__mod_node_page_state(pgdat, idx, val);
 	} else {
 		lruvec = mem_cgroup_lruvec(memcg, pgdat);
-- 
2.20.1

