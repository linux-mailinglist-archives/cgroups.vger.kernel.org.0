Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26FA49CC1C
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 15:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiAZORK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 09:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242041AbiAZORJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 09:17:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73787C06161C
        for <cgroups@vger.kernel.org>; Wed, 26 Jan 2022 06:17:09 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id v3so15929263pgc.1
        for <cgroups@vger.kernel.org>; Wed, 26 Jan 2022 06:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuBjI/BryKVkGIA4h31vhmSSCk11smyr2XD+Upk34ss=;
        b=eLgorfddK9RDt16GtJUDSQjE2iZvbV3tiZ19IQiNbHso9K5YwgELoAegHUh6ZjivMI
         IZLfI7pCrI7uBYBwthU5+CPYcxUn2OnwKcISkz+ACEnzl5PhDDnPSMSQuIAOyI6/PzSw
         sf2XJ0jaumGZPt3Az/dV2emlU3/3B/1YL2FPiI5zP6OpHXc87P3eNYSmX+z7KEpjoDWp
         vqrhEfW/AequoC+byd7VPhnzvH5p9gqS3gVS8qRhHulpiUWCqKV3vB1G8SbOpZTK4ekK
         YowgSXGjIuA8ZM+itgeLTa7pU4YbyphWbbCgVNojYjPlxtMxGrB91l2eYtPCnysgDOAw
         M8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuBjI/BryKVkGIA4h31vhmSSCk11smyr2XD+Upk34ss=;
        b=27SF81fWbEh54BVIpSWCOcWdhBJrcMuINGXEsm4FOJgxziZb5h3l4NH46jwazSOF4L
         nM+Ezg07B7/50q1Ue2LM3nJCW7ZooTlOze4dezUir+a0QVgzaOWnmgZ9VLk5LR71n/kZ
         Ae2W3G7HzXXI7IWWN2ga+cE4tGB5iAahqKfbp8H0bOTkKFrBA6Zn5wj3B3kMkyShINcX
         LWjf6ZZ0eXxyotHwI2GTsgXT8wGK4BHLTcsi8ef+HLszBw0KQHB7UuttAcD75HZ/NRhZ
         C5Sy3INRdmhJNK3TGWvrqfZcJhn6u7mRnsceWtd0hnoxe0QP8qu+vzWkPc9Su/U0N+kd
         AyLw==
X-Gm-Message-State: AOAM530VB+9kOgjhVvM6fadkAAuVMfvEn0qgsjPKRf1qHR8/RIrajp3I
        TcuOgNIRyg5QroHLthdeOyg=
X-Google-Smtp-Source: ABdhPJw2Bj8vx6rwvGwyB+HEb3e9oDBnlEdGmZXkJ4RvAFQVXmKJrR3Yeq223sW9lSAFdZyHv1YBZA==
X-Received: by 2002:a63:b30b:: with SMTP id i11mr19168820pgf.457.1643206628750;
        Wed, 26 Jan 2022 06:17:08 -0800 (PST)
Received: from vultr.guest ([45.76.74.237])
        by smtp.gmail.com with ESMTPSA id d8sm2452797pfl.198.2022.01.26.06.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 06:17:08 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH] cgroup: minor optimization around the usage of cur_tasks_head
Date:   Wed, 26 Jan 2022 14:17:05 +0000
Message-Id: <20220126141705.6497-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Recently there was an issue occurred on our production envrionment with a
very old kernel version 4.19. That issue can be fixed by upstream
commit 9c974c772464 ("cgroup: Iterate tasks that did not finish do_exit()")

When I was trying to fix that issue on our production environment, I found
we can create a hotfix with a simplified version of the commit -

As the usage of cur_tasks_head is within the function
css_task_iter_advance(), we can make it as a local variable. That could
make it more clear and easier to understand. Another benefit is we don't
need to carry it in css_task_iter.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup.h |  1 -
 kernel/cgroup/cgroup.c | 29 ++++++++++++++++-------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 75c151413fda..f619a92d0fa0 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -61,7 +61,6 @@ struct css_task_iter {
 
 	struct list_head		*task_pos;
 
-	struct list_head		*cur_tasks_head;
 	struct css_set			*cur_cset;
 	struct css_set			*cur_dcset;
 	struct task_struct		*cur_task;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 919194de39c8..ffb0c863b97a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4545,10 +4545,12 @@ static struct css_set *css_task_iter_next_css_set(struct css_task_iter *it)
 /**
  * css_task_iter_advance_css_set - advance a task iterator to the next css_set
  * @it: the iterator to advance
+ * @cur_tasks_head: head of current tasks
  *
  * Advance @it to the next css_set to walk.
  */
-static void css_task_iter_advance_css_set(struct css_task_iter *it)
+static void css_task_iter_advance_css_set(struct css_task_iter *it,
+				struct list_head **cur_tasks_head)
 {
 	struct css_set *cset;
 
@@ -4557,13 +4559,13 @@ static void css_task_iter_advance_css_set(struct css_task_iter *it)
 	/* Advance to the next non-empty css_set and find first non-empty tasks list*/
 	while ((cset = css_task_iter_next_css_set(it))) {
 		if (!list_empty(&cset->tasks)) {
-			it->cur_tasks_head = &cset->tasks;
+			*cur_tasks_head = &cset->tasks;
 			break;
 		} else if (!list_empty(&cset->mg_tasks)) {
-			it->cur_tasks_head = &cset->mg_tasks;
+			*cur_tasks_head = &cset->mg_tasks;
 			break;
 		} else if (!list_empty(&cset->dying_tasks)) {
-			it->cur_tasks_head = &cset->dying_tasks;
+			*cur_tasks_head = &cset->dying_tasks;
 			break;
 		}
 	}
@@ -4571,7 +4573,7 @@ static void css_task_iter_advance_css_set(struct css_task_iter *it)
 		it->task_pos = NULL;
 		return;
 	}
-	it->task_pos = it->cur_tasks_head->next;
+	it->task_pos = (*cur_tasks_head)->next;
 
 	/*
 	 * We don't keep css_sets locked across iteration steps and thus
@@ -4610,6 +4612,7 @@ static void css_task_iter_skip(struct css_task_iter *it,
 
 static void css_task_iter_advance(struct css_task_iter *it)
 {
+	struct list_head *cur_tasks_head = NULL;
 	struct task_struct *task;
 
 	lockdep_assert_held(&css_set_lock);
@@ -4626,18 +4629,18 @@ static void css_task_iter_advance(struct css_task_iter *it)
 			it->task_pos = it->task_pos->next;
 
 		if (it->task_pos == &it->cur_cset->tasks) {
-			it->cur_tasks_head = &it->cur_cset->mg_tasks;
-			it->task_pos = it->cur_tasks_head->next;
+			cur_tasks_head = &it->cur_cset->mg_tasks;
+			it->task_pos = cur_tasks_head->next;
 		}
 		if (it->task_pos == &it->cur_cset->mg_tasks) {
-			it->cur_tasks_head = &it->cur_cset->dying_tasks;
-			it->task_pos = it->cur_tasks_head->next;
+			cur_tasks_head = &it->cur_cset->dying_tasks;
+			it->task_pos = cur_tasks_head->next;
 		}
 		if (it->task_pos == &it->cur_cset->dying_tasks)
-			css_task_iter_advance_css_set(it);
+			css_task_iter_advance_css_set(it, &cur_tasks_head);
 	} else {
 		/* called from start, proceed to the first cset */
-		css_task_iter_advance_css_set(it);
+		css_task_iter_advance_css_set(it, &cur_tasks_head);
 	}
 
 	if (!it->task_pos)
@@ -4651,12 +4654,12 @@ static void css_task_iter_advance(struct css_task_iter *it)
 			goto repeat;
 
 		/* and dying leaders w/o live member threads */
-		if (it->cur_tasks_head == &it->cur_cset->dying_tasks &&
+		if (cur_tasks_head == &it->cur_cset->dying_tasks &&
 		    !atomic_read(&task->signal->live))
 			goto repeat;
 	} else {
 		/* skip all dying ones */
-		if (it->cur_tasks_head == &it->cur_cset->dying_tasks)
+		if (cur_tasks_head == &it->cur_cset->dying_tasks)
 			goto repeat;
 	}
 }
-- 
2.17.1

