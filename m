Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8117331A32F
	for <lists+cgroups@lfdr.de>; Fri, 12 Feb 2021 18:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhBLRC5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Feb 2021 12:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBLRC4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Feb 2021 12:02:56 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06C2C061574
        for <cgroups@vger.kernel.org>; Fri, 12 Feb 2021 09:02:16 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gx20so765617pjb.1
        for <cgroups@vger.kernel.org>; Fri, 12 Feb 2021 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdVPqrFgHTgC5mTllAq9fBNSua/ngygoblWbV1oigUI=;
        b=Wqq++mXdhn6HE2fF23Wh8h9AFqcynW3GPMQs21nMApsmcn9L4h6O8KtYPRjAUeNCDn
         iNMu2YDjYyY8JDBGuTJAEVoQcXdkJcwdAMiDMk/43qpb0yi2y/gjcH86jMmW4oRF16x3
         L8UNDDz8q5XJPbV/D8jN4450QYrAUnCaJ5cUuSHsVoO/e/3r98A0TR3WAK0qaFp0ufcz
         5FcU7+Yz6okzH9k+R28b7nmm6Z9f63wUb2h6VTNDmLX3s/VAfDqzX8JRwrHt08eJ5okY
         cIbjgV0hM5kJGL5B1Ttc4NuCgqtZIs5c37uIrW6rDWoTarmMsvNlMxDDAHHWfGQAiIkl
         0GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdVPqrFgHTgC5mTllAq9fBNSua/ngygoblWbV1oigUI=;
        b=BM15vVvFxhExhxXO//UbQBgc6gAsfcxA97TNPa9vKjlZqnpaI2T1ofAsN4VXE0guZM
         jM67LApL7zMzIAStLVyK1Gg8zcaM4Prqus2F3HOBvZfw3RFGeFDr9pc+tK5ekOqnLz1d
         6OpS2Xt0AyhvmJ73jf72Hlz7O5RIYKFi2sOk4a27b7dFWceJC2GtUUXaa2LtZFMAMc7g
         CgW3tqx0Ojdo9Fk248VeRrPbYJZkq2WAWjZgOHuMaVzV70HHGtQ8wM0xrViD6sZCyC32
         VH4pS6I8xcO0Lz4ZokBiOLjqAiznPOZY8aO39M9aupPNlKaoZ67d9XTHh7/ooL6yAhYx
         cwRw==
X-Gm-Message-State: AOAM532wKh6DSh2clTcBGn2XHDCmsn2KROTbTkKLAuKarYIhpI4IRVEV
        0NZWwJ9kH7v6K87Dwh7xkJ04tw==
X-Google-Smtp-Source: ABdhPJybZwdjimV2P5ym8dkQiRVRyC5DByFMgygAkBaUP5rkFW8O6XL/Sn6SVVsiqOEugp4e7rkVow==
X-Received: by 2002:a17:90b:2312:: with SMTP id mt18mr3636553pjb.81.1613149336083;
        Fri, 12 Feb 2021 09:02:16 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id e21sm9317815pgv.74.2021.02.12.09.02.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 09:02:15 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/4] mm: memcontrol: remove memcg check from memcg_oom_recover
Date:   Sat, 13 Feb 2021 01:01:56 +0800
Message-Id: <20210212170159.32153-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The memcg_oom_recover() almost never do anything but the test (because
oom_disabled is a rarely used) is just waste of cycles in some hot
paths (e.g. kmem uncharge). And it is very small, so it is better to
make it inline. Also, the parameter of memcg cannot be NULL, so removing
the check can reduce useless check.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c035846c7a4..7afca9677693 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1925,7 +1925,7 @@ static int memcg_oom_wake_function(wait_queue_entry_t *wait,
 	return autoremove_wake_function(wait, mode, sync, arg);
 }
 
-static void memcg_oom_recover(struct mem_cgroup *memcg)
+static inline void memcg_oom_recover(struct mem_cgroup *memcg)
 {
 	/*
 	 * For the following lockless ->under_oom test, the only required
@@ -1935,7 +1935,7 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
 	 * achieved by invoking mem_cgroup_mark_under_oom() before
 	 * triggering notification.
 	 */
-	if (memcg && memcg->under_oom)
+	if (memcg->under_oom)
 		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
 }
 
-- 
2.11.0

