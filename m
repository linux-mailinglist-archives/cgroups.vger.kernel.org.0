Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA75E7DA8
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2019 01:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfJ2Ay2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Oct 2019 20:54:28 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:32870 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfJ2Ay2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Oct 2019 20:54:28 -0400
Received: by mail-qt1-f201.google.com with SMTP id k53so12813957qtk.0
        for <cgroups@vger.kernel.org>; Mon, 28 Oct 2019 17:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CJNyfCkSt7mazdpKxm+NauccC7aNCXbzHO2WmG+WXZI=;
        b=VNIhRIVznNTE4231t1PB9Y892IckjdElWezZZVpfEZj80/mzanDBafaCAPwbWdo/2+
         A2IlnsRAL2Blt3IvIwX0ISb+ZmFwG9yrBZ55rX1/xuj9NUAqSD3FHneUmyprKlV5yl3q
         tTlgF3TG2RXMaFaXAlfpSDe9OiAODZDJ/pnsUOZfcjt++CXArvZZTjQ5fY2m5Jz4KDJj
         UImudqlau9RYfYGT+aEy1/m9RTwJwhjIFgij71FJyZX0avIJ5/L6Yy34dJ5ovk87MzOg
         vpUccTmI91a3yMxtIvMawk0rByNgb7F2mUfDUfz6Bqs+0lifTZdjCcjDQGftK7LTeiXB
         t6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CJNyfCkSt7mazdpKxm+NauccC7aNCXbzHO2WmG+WXZI=;
        b=J0G6h9rQ8dqqGgOUXCrArny8tJlS2kQEQZZkVAvtiB7/teCELwZ1VOHK5ynvLXGpEQ
         Nj5q+iEDabnTebStqQFt5G2mAIiG9utlozoMA2IsxyUtbfc094iOGj799+QMVsEUGJtQ
         CjBYqxuZQeBmLYOLFKoKcOioG2zINI5bGtYa5M8RV7EwAuOpgvSQ/hbNPtK/pPlAGGbe
         ss1gqjNyTMew17nfbqvbnqhqB83gfpDYlO1Gujux6AVXCd0E5fDLPrV9fvS8Qn7Yw+Ml
         noetGaTXfy1EQn/0ihF+PFsb5P4CVvAXk4KcH8HIfxKlgRU6/KBkYHzlyLBIrHbeDTWV
         UEUw==
X-Gm-Message-State: APjAAAVIUj+jKr47sXr0u2YWD1n6M0S2opttXeovQwQmuoO+j8g3CWbB
        Wxo8RNn2gVgKrKWrAMO1d2sVeHbq4f2PIQ==
X-Google-Smtp-Source: APXvYqyuC1vSPb0iXXoyj+RX6tq0hHQYQPJSlVZL8/Xu5SdTk1tHt39Bxai/8EbXawqb+7npXxeAku+T+G4lIw==
X-Received: by 2002:a37:9d15:: with SMTP id g21mr4415148qke.71.1572310467233;
 Mon, 28 Oct 2019 17:54:27 -0700 (PDT)
Date:   Mon, 28 Oct 2019 17:54:05 -0700
Message-Id: <20191029005405.201986-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH] mm: memcontrol: fix data race in mem_cgroup_select_victim_node
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Thelen <gthelen@google.com>,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Syzbot reported the following bug:

BUG: KCSAN: data-race in mem_cgroup_select_victim_node / mem_cgroup_select_victim_node

write to 0xffff88809fade9b0 of 4 bytes by task 8603 on cpu 0:
 mem_cgroup_select_victim_node+0xb5/0x3d0 mm/memcontrol.c:1686
 try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
 reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
 mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
 tracehook_notify_resume include/linux/tracehook.h:197 [inline]
 exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
 prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
 swapgs_restore_regs_and_return_to_usermode+0x0/0x40

read to 0xffff88809fade9b0 of 4 bytes by task 7290 on cpu 1:
 mem_cgroup_select_victim_node+0x92/0x3d0 mm/memcontrol.c:1675
 try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
 reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
 mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
 tracehook_notify_resume include/linux/tracehook.h:197 [inline]
 exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
 prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
 swapgs_restore_regs_and_return_to_usermode+0x0/0x40

mem_cgroup_select_victim_node() can be called concurrently which reads
and modifies memcg->last_scanned_node without any synchrnonization. So,
read and modify memcg->last_scanned_node with READ_ONCE()/WRITE_ONCE()
to stop potential reordering.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Cc: Greg Thelen <gthelen@google.com>
Reported-by: syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c4c555055a72..5a06739dd3e4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1667,7 +1667,7 @@ int mem_cgroup_select_victim_node(struct mem_cgroup *memcg)
 	int node;
 
 	mem_cgroup_may_update_nodemask(memcg);
-	node = memcg->last_scanned_node;
+	node = READ_ONCE(memcg->last_scanned_node);
 
 	node = next_node_in(node, memcg->scan_nodes);
 	/*
@@ -1678,7 +1678,7 @@ int mem_cgroup_select_victim_node(struct mem_cgroup *memcg)
 	if (unlikely(node == MAX_NUMNODES))
 		node = numa_node_id();
 
-	memcg->last_scanned_node = node;
+	WRITE_ONCE(memcg->last_scanned_node, node);
 	return node;
 }
 #else
-- 
2.24.0.rc0.303.g954a862665-goog

