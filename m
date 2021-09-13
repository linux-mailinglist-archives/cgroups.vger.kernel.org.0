Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40FF4097F4
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 17:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhIMPzm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 11:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhIMPzl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 11:55:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF754C061574;
        Mon, 13 Sep 2021 08:54:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w19so4875307pfn.12;
        Mon, 13 Sep 2021 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=y/l6pZsY0+2abPXmYytXZzrEUxa84oSBx60olTgQf5E=;
        b=mySNaluwtOtRo928O2znR/NiPO5G6dqZfvoJdPmgWCMzUgffI575v5P84+CHHB0Vfl
         DdzelrBd3luKHRw23f4nlwsau96M4VKeCeePlQ381ozCkE2Q93w+7C8hHj9CjM3PJcpR
         tWXVkRQzMnbron3nqCIfSDXucVPzZbtf3/TzXvE5dKu4fJ0IpmRfYgXO5HS7iTeEY3Xj
         Pm2AYeBFlsxuceo0EjeJBuTL8OOsgePonPmKHpvzZhro/p9GixF6BZBcXiK8Mzs7Dwtg
         lob1qjaliO8X4iXY3XGpzpTvPx9X70z8BJeQCYPBZv2/Tt+HCnwbBdQUVDTQz050SALw
         1Bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=y/l6pZsY0+2abPXmYytXZzrEUxa84oSBx60olTgQf5E=;
        b=3utOoxJ4493UJ7pRwz6UKWJhqBHpc4ck6kY4JyMKn/oKlaWVWEgOHgWGXVWruATRnT
         xHslwby1ccdlDFMiy7QGV8txEa9BYjT2YFWgggzmVDoouRe/S/BteHfB7uIys7jWH1ta
         tVu9IP8gIH09eRvbDLCpL9j1pw6cyi3aq62oEOcrews5ytblX1mW94tPozZbeGGqrWm4
         NPTIJHDXkzhLsDs+CmtTyinKMgdqvaYX14z9a0GqIywYb0ILh8DDn+3uXsrjyAhowgBu
         16hw0IB+zpFSk0Up93WcrGjdaxSJlnH0Ggy6g7tQWDp3H/kFS786y3SCq9GLZJGDbVD9
         OwLA==
X-Gm-Message-State: AOAM533K3MEnmwEKTPXeQCBZGO4P3F/BpOayv9HLBhCTdGBW7V9y8Myc
        MGlqhRWob5L/t7mhbiv+pqc=
X-Google-Smtp-Source: ABdhPJzNqMuMRGdOROVmqd5AOofZXa1krgAO8dHxeUSI78J488MNadogQthymGUprBZCE86rFeIkYw==
X-Received: by 2002:a62:403:0:b0:433:9582:d449 with SMTP id 3-20020a620403000000b004339582d449mr119417pfe.15.1631548465383;
        Mon, 13 Sep 2021 08:54:25 -0700 (PDT)
Received: from localhost.localdomain (vps-e35ab625.vps.ovh.us. [51.81.186.255])
        by smtp.gmail.com with ESMTPSA id gp11sm7239662pjb.2.2021.09.13.08.54.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Sep 2021 08:54:24 -0700 (PDT)
From:   yongw.pur@gmail.com
X-Google-Original-From: wang.yong12@zte.com.cn
To:     tj@kernel.org, mhocko@suse.com, mhocko@kernel.org,
        peterz@infradead.org, wang.yong12@zte.com.cn,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, yang.yang29@zte.com.cn
Subject: [PATCH v1] vmpressure: wake up work only when there is registration event
Date:   Mon, 13 Sep 2021 08:54:01 -0700
Message-Id: <1631548441-2784-1-git-send-email-wang.yong12@zte.com.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: wangyong <wang.yong12@zte.com.cn>

Use the global variable num_events to record the number of vmpressure
events registered by the system, and wake up work only when there is
registration event.
Usually, the vmpressure event is not registered in the system, this patch
can avoid waking up work and doing nothing.

Refer to Michal Hocko's suggestion:
https://lore.kernel.org/linux-mm/YR%2FNRJEhPKRQ1r22@dhcp22.suse.cz/

Tested-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: wangyong <wang.yong12@zte.com.cn>
---
 mm/vmpressure.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index 76518e4..dfac76b 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -67,6 +67,11 @@ static const unsigned int vmpressure_level_critical = 95;
  */
 static const unsigned int vmpressure_level_critical_prio = ilog2(100 / 10);
 
+/*
+ * Count the number of vmpressure events registered in the system.
+ */
+static atomic_t num_events = ATOMIC_INIT(0);
+
 static struct vmpressure *work_to_vmpressure(struct work_struct *work)
 {
 	return container_of(work, struct vmpressure, work);
@@ -277,7 +282,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 		vmpr->tree_reclaimed += reclaimed;
 		spin_unlock(&vmpr->sr_lock);
 
-		if (scanned < vmpressure_win)
+		if (scanned < vmpressure_win || atomic_read(&num_events) == 0)
 			return;
 		schedule_work(&vmpr->work);
 	} else {
@@ -407,6 +412,7 @@ int vmpressure_register_event(struct mem_cgroup *memcg,
 	mutex_lock(&vmpr->events_lock);
 	list_add(&ev->node, &vmpr->events);
 	mutex_unlock(&vmpr->events_lock);
+	atomic_add(1, &num_events);
 	ret = 0;
 out:
 	kfree(spec_orig);
@@ -435,6 +441,7 @@ void vmpressure_unregister_event(struct mem_cgroup *memcg,
 		if (ev->efd != eventfd)
 			continue;
 		list_del(&ev->node);
+		atomic_sub(1, &num_events);
 		kfree(ev);
 		break;
 	}
-- 
2.7.4

