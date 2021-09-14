Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0216940B428
	for <lists+cgroups@lfdr.de>; Tue, 14 Sep 2021 18:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhINQHV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Sep 2021 12:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbhINQHU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Sep 2021 12:07:20 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E02EC061764;
        Tue, 14 Sep 2021 09:06:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f129so13178926pgc.1;
        Tue, 14 Sep 2021 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=s5oUww/KW0dwIowi5W2rJXOaMiXlxCDKY0oBpmzbqzw=;
        b=XNrj+vkp8TdMcL+diFidKiPuX7g/Eoa/0pzMB+yNwjiIwQAr4bkGqspPavHrz7GpRQ
         MziRNMfi0znxPuVdVPxwvv9+v7wo6qHOzG3ogD7u9i/MbRmA7Dj0JVLZ5hUDStlDwrHq
         5brNW89diOHl547VwRfBWjP/70q9IiyepW0X2BomJCAKbF1rzhe89iBPKRUfMekhg55G
         tcw6QgPWuPgC0TieK1r2ltDQrDKxxh5jTFDqKF++7iuTvtWutLm2uhmm892RGj0113Rp
         5/RqeZkRQvRokQqqt0YbvIsIbaJRxVfd1ife8WllzJf+Xm8mtTVuSZs/4t6Aq1OEMYMd
         Lf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=s5oUww/KW0dwIowi5W2rJXOaMiXlxCDKY0oBpmzbqzw=;
        b=YDZSL7xYpci0ORqOeKZG+8DYUVDb+GeKxJ2Oy6XMp86BtjRMI6kFYrFmYH+SWijz4/
         GmBGiOQUPt8CLhwJm/OazuV1k5SM6WBK9cu9Le+382AQYtnCWZOgSIlLe3BabR3b6kZg
         RX6pN/SPx1lLz8DiBg3SJ7wy7LHZegk5Z7SOuNae42Xexh2wYv44PMqBdAYVZCSpSR9H
         lQBXfnlm3bmCc8VyTa+cspTkMbVse0bfWPGc3pRZmIDCTSsnvqo1z7jSIZSnUY28KMW1
         7UbUftLFhnWP1dsLX4YOgNHKAIpGnRPJZUTKK4bUk5GBMx39WimjxK/JMfUQbrmbJtRl
         pYYw==
X-Gm-Message-State: AOAM533Kt6o/3W8GKiAQtBKe5COdgRktm8+jpWQq+jlE7kSCOg+99H/i
        agdDeWS92nJbKTDH1YdAKas=
X-Google-Smtp-Source: ABdhPJy1ERBGfrwXU5csdCVVaihFZaGcXMLE2+avw8seOIH5zLLGB8jX0VYdACP47Dxbb36RmKVoXw==
X-Received: by 2002:a63:3545:: with SMTP id c66mr16043185pga.377.1631635562572;
        Tue, 14 Sep 2021 09:06:02 -0700 (PDT)
Received: from localhost.localdomain ([192.154.103.190])
        by smtp.gmail.com with ESMTPSA id cp17sm2132963pjb.3.2021.09.14.09.05.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 09:06:02 -0700 (PDT)
From:   yongw.pur@gmail.com
X-Google-Original-From: wang.yong12@zte.com.cn
To:     tj@kernel.org, mhocko@suse.com, peterz@infradead.org,
        wang.yong12@zte.com.cn, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.yang29@zte.com.cn
Subject: [PATCH v2] vmpressure: wake up work only when there is registration event
Date:   Tue, 14 Sep 2021 09:05:51 -0700
Message-Id: <1631635551-8583-1-git-send-email-wang.yong12@zte.com.cn>
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

Test with 5.14.0-rc5-next-20210813 on x86_64 4G ram.
Consume cgroup memory until it is about to be reclaimed, then execute
"perf stat -I 2000 malloc.out" command to trigger memory reclamation
and get performance results.
The context-switches is reduced by about 20 times.

unpatched:
Average of 10 test results
582.4674048	task-clock(msec)
19910.8		context-switches
0		cpu-migrations
1292.9		page-faults
414784733.1	cycles
<not supported>	stalled-cycles-frontend
<not supported>	stalled-cycles-backend
580070698.4	instructions
125572244.7	branches
2073541.2	branch-misses

patched
Average of 10 test results
973.6174796	task-clock(msec)
988.6		context-switches
0		cpu-migrations
1785.2		page-faults
772883602.4	cycles
<not supported>	stalled-cycles-frontend
<not supported>	stalled-cycles-backend
1360280911	instructions
290519434.9	branches
3378378.2	branch-misses

Tested-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: wangyong <wang.yong12@zte.com.cn>
---

Changes since v1:
-Use static_key type data as global variable
-Make event registration judgment earlier

 mm/vmpressure.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index 76518e4..6f4e984 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -67,6 +67,11 @@ static const unsigned int vmpressure_level_critical = 95;
  */
 static const unsigned int vmpressure_level_critical_prio = ilog2(100 / 10);
 
+/*
+ * Count the number of vmpressure events registered in the system.
+ */
+DEFINE_STATIC_KEY_FALSE(num_events);
+
 static struct vmpressure *work_to_vmpressure(struct work_struct *work)
 {
 	return container_of(work, struct vmpressure, work);
@@ -272,6 +277,9 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 		return;
 
 	if (tree) {
+		if (!static_branch_unlikely(&num_events))
+			return;
+
 		spin_lock(&vmpr->sr_lock);
 		scanned = vmpr->tree_scanned += scanned;
 		vmpr->tree_reclaimed += reclaimed;
@@ -407,6 +415,7 @@ int vmpressure_register_event(struct mem_cgroup *memcg,
 	mutex_lock(&vmpr->events_lock);
 	list_add(&ev->node, &vmpr->events);
 	mutex_unlock(&vmpr->events_lock);
+	static_branch_inc(&num_events);
 	ret = 0;
 out:
 	kfree(spec_orig);
@@ -435,6 +444,7 @@ void vmpressure_unregister_event(struct mem_cgroup *memcg,
 		if (ev->efd != eventfd)
 			continue;
 		list_del(&ev->node);
+		static_branch_dec(&num_events);
 		kfree(ev);
 		break;
 	}
-- 
2.7.4

