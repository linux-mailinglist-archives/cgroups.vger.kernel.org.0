Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4AD41761E
	for <lists+cgroups@lfdr.de>; Fri, 24 Sep 2021 15:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhIXNqP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Sep 2021 09:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345359AbhIXNqN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Sep 2021 09:46:13 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5C5C061571;
        Fri, 24 Sep 2021 06:44:40 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id w8so9926527pgf.5;
        Fri, 24 Sep 2021 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=C1qOcUv37x/aaV73V8Kv4uQFgD37HZdVWZKX5cd1Pnk=;
        b=nfd9Owc88HKGgehebXgCJr67ojOZM1yqCQzTr98bMufXc/0LgwVS7BnbHzNNhEJpBt
         3qbdd5XKWGxa4nYrhDO+Z/uHKASWxlzW8I0r6jitV/he2yVkhwwGEgb21kbP93X/PrTc
         PTsSb62GSsi4elOHlMxnSnSLmSVWgi9WEu59a2L79Bf9SZXlxgu3ACMfFL5KSXpux915
         XaDGo484m6SXrBYzy5YJ9kAnSk2gKuI1/QMjC+A5bpooa9Ro3oRB12RRNGzTK7xTZLc1
         pmxhmGWd07S/CXMnG3bjoTyzR8c2UGLwYhPB8h8xX+ejtFUUmJwfC+WTUd4hVow0CprV
         gYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=C1qOcUv37x/aaV73V8Kv4uQFgD37HZdVWZKX5cd1Pnk=;
        b=zistHWOrPukmFUf3zopthyaU704NK31TTlAKiWNLw1arOEX48vTVkS2gUKxgxALHCv
         8nR5xNTbaQrQMlaOzBBmlC2EFBXe9XRkyeeURqmwGOTxaySfRs80wr0FL+W4BLiJMKYz
         WKoQPp/DG2O1Ss7N2RZ0beO/UirQVSkYFoEwjURFSjMf5uoKJzWwuwrLIsn8iv9TNfC/
         WG7WO2FDz2fngrVKDH6RPQZ2YtoPRayJelQR9Gp/imJD5sFbXeO2EBM1x15h6l8CcSJX
         AGUBmNcERAd3mH5etxOd+FxkwqKFQNRRJkowWGxPej+lMJaeJiY3yhdeimrCRAON6MTW
         KoSw==
X-Gm-Message-State: AOAM532LAfdl5XXQtAxJse/8ebACJMiO1WDEEgk7/VslioETJLeVHl73
        1TkxHBWnCEo7LzBK2IVNV5s=
X-Google-Smtp-Source: ABdhPJzQumP3YVWkVIm0f8wxVRflW+gOVlCHImrqp1o9AjGWTi4Ls/KGC0BGlSBKwAN8rAV2kqvGMA==
X-Received: by 2002:a63:ef57:: with SMTP id c23mr3891486pgk.60.1632491079845;
        Fri, 24 Sep 2021 06:44:39 -0700 (PDT)
Received: from localhost.localdomain ([171.221.148.237])
        by smtp.gmail.com with ESMTPSA id t13sm12299968pjj.31.2021.09.24.06.44.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Sep 2021 06:44:39 -0700 (PDT)
From:   yongw.pur@gmail.com
X-Google-Original-From: wang.yong12@zte.com.cn
To:     tj@kernel.org, mhocko@suse.com, peterz@infradead.org,
        wang.yong12@zte.com.cn, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.yang29@zte.com.cn
Subject: [PATCH v3] vmpressure: wake up work only when there is registration event
Date:   Fri, 24 Sep 2021 06:44:25 -0700
Message-Id: <1632491065-10785-1-git-send-email-wang.yong12@zte.com.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: wangyong <wang.yong12@zte.com.cn>

Use the global variable num_events to record the number of vmpressure
events registered by the system, and wake up work only when there
is registration event.
Usually, the vmpressure event is not registered in the system, this patch
can avoid waking up work and doing nothing.

Test with 5.14.0-rc5-next-20210813 on x86_64 4G ram.
Consume cgroup memory until it is about to be reclaimed, then execute
"perf stat -I 2000 malloc.out" command to trigger memory reclamation
and get performance results.
The context-switches is reduced by about 20 times.

unpatched:
Average of 10 test results
582.4674048     task-clock(msec)
19910.8         context-switches
0               cpu-migrations
1292.9          page-faults
414784733.1     cycles
580070698.4     instructions
125572244.7     branches
2073541.2       branch-misses

patched:
Average of 10 test results
973.6174796     task-clock(msec)
988.6           context-switches
0               cpu-migrations
1785.2          page-faults
772883602.4     cycles
1360280911      instructions
290519434.9     branches
3378378.2       branch-misses

Signed-off-by: wangyong <wang.yong12@zte.com.cn>
---

Changlogs in v3:
  -Use static inline helper to know whether there
   is registration event.
  -Add necessary description.
  -The location of the helper is based on that the else
   branch will modify the socket_pressure and will not
   wake up the work, and it is necessary to judge the tree
   parameters at the same time.

Changlogs in v2:
  -Use static_key type data as global variable.
  -Make event registration judgment earlier.

 mm/vmpressure.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index 76518e4..1f53ced 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -67,6 +67,16 @@ static const unsigned int vmpressure_level_critical = 95;
  */
 static const unsigned int vmpressure_level_critical_prio = ilog2(100 / 10);
 
+/*
+ * Count the number of vmpressure events registered in the system.
+ */
+DEFINE_STATIC_KEY_FALSE(num_events);
+
+static __always_inline bool vmpressure_unregistered(void)
+{
+	return !static_branch_unlikely(&num_events);
+}
+
 static struct vmpressure *work_to_vmpressure(struct work_struct *work)
 {
 	return container_of(work, struct vmpressure, work);
@@ -272,6 +282,12 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 		return;
 
 	if (tree) {
+		/* If there is no registered event, return directly.
+		 * We wake up work only when there is registration event.
+		 */
+		if (vmpressure_unregistered())
+			return;
+
 		spin_lock(&vmpr->sr_lock);
 		scanned = vmpr->tree_scanned += scanned;
 		vmpr->tree_reclaimed += reclaimed;
@@ -407,6 +423,7 @@ int vmpressure_register_event(struct mem_cgroup *memcg,
 	mutex_lock(&vmpr->events_lock);
 	list_add(&ev->node, &vmpr->events);
 	mutex_unlock(&vmpr->events_lock);
+	static_branch_inc(&num_events);
 	ret = 0;
 out:
 	kfree(spec_orig);
@@ -435,6 +452,7 @@ void vmpressure_unregister_event(struct mem_cgroup *memcg,
 		if (ev->efd != eventfd)
 			continue;
 		list_del(&ev->node);
+		static_branch_dec(&num_events);
 		kfree(ev);
 		break;
 	}
-- 
2.7.4

