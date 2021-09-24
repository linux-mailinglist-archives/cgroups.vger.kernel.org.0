Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD24416C0D
	for <lists+cgroups@lfdr.de>; Fri, 24 Sep 2021 08:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244182AbhIXGr7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Sep 2021 02:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244211AbhIXGr7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Sep 2021 02:47:59 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA235C061574;
        Thu, 23 Sep 2021 23:46:26 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m21so8919642pgu.13;
        Thu, 23 Sep 2021 23:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=H3OrsFf3LDF8kSA9N72sHEwF/fijXJFJCQiPZi5ceNI=;
        b=G5C/0K7kIPn/uiaKVOaxliCn+ouk/2e/osVmj23SnCpR85VvwHouKbfuHaBSy+boIb
         NrLyylleC0PA3Lue5lGpx20aF/ecY5JzRgsujH9BvrKqT4te1OHXzpPJZ9i3onCiy4CL
         P3v/TRdjiy3NOnOGjTVCdu41amLOzx6RPNRP+8ZtPsgZ+TNPy6XL3YQc5n6mDBAIWbQX
         Q2+K4iqYoXamQjcW2JSVR9CscB+QuxHR2BheEYgKHm8ImCecNHgWDH9uYNaPwbbDpkMI
         V1BRTrN/Vy08LtJ58RWLyMgw9w3gXQymyllFJ9ffvuIof7yQjH2eKxZ+6a8rwo/kXmR/
         xpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H3OrsFf3LDF8kSA9N72sHEwF/fijXJFJCQiPZi5ceNI=;
        b=xThpVOzvnJn6CwJrKY6UUFACPj556DXSpzVRGJ2rybeT2o+ocCbgUgg/PNb1Nnz94V
         N6zoT9vTY9+UVKP/DyR7ygyzysmLc2J4PwG0cpvigrPxSIbd/wXZeDQ4iod61MOa+rJU
         dnl6mUHTIIQk+hxJPui3bdwmWu54jwjFiTf9MvAzCl5nh+ClTl2OJFs5JL60pyBnBvIP
         T8VFjC6KgwWSkof8rFcDq04Nlb35sG9xcC2NrnSDNCFBNVKvcBSersArP5ArQ8csjwwA
         iMAixrTU5IGhCEJte1Jr4NCFEbn7N//Kl1GXAjdVRDdBb8gwi7EVgzmn3CTrJN6uW7wI
         7b0Q==
X-Gm-Message-State: AOAM533gz5BAcuLK+PtZ733zODry7Y5HC8RUy3bnItX2K9CyucIj4R/7
        +lG43OBjAnPRf9vF+yPDz/8=
X-Google-Smtp-Source: ABdhPJwlOV2dYDrKjWgQc4v6KA8VJC7pFS3+WF10ir4vYU21T1tvKetc/uxk/HdNl64mig1aoLhoSg==
X-Received: by 2002:a63:f5b:: with SMTP id 27mr2386085pgp.302.1632465986239;
        Thu, 23 Sep 2021 23:46:26 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id q20sm7978818pfc.57.2021.09.23.23.46.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Sep 2021 23:46:25 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 1/2] mem_cgroup: optimize the atomic count of wb_completion
Date:   Fri, 24 Sep 2021 14:46:22 +0800
Message-Id: <1632465983-30525-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

In order to track inflight foreign writeback, we init
wb_completion.cnt to 1. For normal writeback, this cause
wb_wait_for_completion() to perform meaningless atomic
operations. Since foreign writebacks rarely occur in most
scenarios, we can init wb_completion.cnt to 0 and set
frn.done.cnt to 1. In this way we can avoid unnecessary
atomic operations.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/fs-writeback.c                | 1 -
 include/linux/backing-dev-defs.h | 2 +-
 mm/memcontrol.c                  | 7 ++++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 81ec192..1ef10f2 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -186,7 +186,6 @@ static void wb_queue_work(struct bdi_writeback *wb,
  */
 void wb_wait_for_completion(struct wb_completion *done)
 {
-	atomic_dec(&done->cnt);		/* put down the initial count */
 	wait_event(*done->waitq, !atomic_read(&done->cnt));
 }
 
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 3320700..38bd571 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -71,7 +71,7 @@ struct wb_completion {
 };
 
 #define __WB_COMPLETION_INIT(_waitq)	\
-	(struct wb_completion){ .cnt = ATOMIC_INIT(1), .waitq = (_waitq) }
+	(struct wb_completion){ .cnt = ATOMIC_INIT(0), .waitq = (_waitq) }
 
 /*
  * If one wants to wait for one or more wb_writeback_works, each work's
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b762215..3e1384a6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5168,9 +5168,10 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 #endif
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		memcg->cgwb_frn[i].done =
-			__WB_COMPLETION_INIT(&memcg_cgwb_frn_waitq);
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		atomic_set(&memcg->cgwb_frn[i].done.cnt, 1);
+		memcg->cgwb_frn[i].done.waitq = &memcg_cgwb_frn_waitq;
+	}
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
-- 
1.8.3.1

