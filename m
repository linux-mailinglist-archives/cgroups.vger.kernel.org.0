Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E0030207
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2019 20:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfE3ShE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 May 2019 14:37:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42648 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfE3ShE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 May 2019 14:37:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id b18so4541743qkc.9
        for <cgroups@vger.kernel.org>; Thu, 30 May 2019 11:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2+RsImwZd4bRX52WU8k79NfPAhpZBCQ4GxVAX3EZvEc=;
        b=JYs/LsfK+DWAXmlK74mqRBtGmH6t3jM9O506wSl5iER4n1Rf2vYL830BJvfMiM7BKU
         iKhk59gQge5cnIKy8Geu2oVn84Rdb5JRMpWKL+MOEWArjcrdAJObNM3ZVBhfdIzWTalc
         tH5E6hsVI8mgkIl0ky+y3WmlE9E8amV1+/Gl4Cd/bWrh5QbHowXkq0ntatsD7a0I2OBN
         WQdRoz5dkWDDFauGgDsXQq+ZvQ0DxMNIjcuLWuKBe+381Nvp52CoiFvtBIiriPu8lOwD
         e4q9nHYwkYlsdeZnodbTZbnpG6AAwchm+OnCqsGPBH0ctbzo+LFAwZwvq1TARBvfCDKL
         AZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2+RsImwZd4bRX52WU8k79NfPAhpZBCQ4GxVAX3EZvEc=;
        b=UwaJa/wClZEjwya+bSYnpPH9tSSxqiLWY8LenPlwWMf7054fnDuGJUU8BavNIdhIiF
         H3+ZpxYWB5RNXm+41xqVHwCxNfFSThrrUANIJouSc4N50JvNHRb3Ytx4Vjb2v9NTQQUH
         sz99EeZ83q9nhqCF7LtPTPycMIql5ENHCGnAgD+dUxnJf0eu7JyF9L7ppxChaIZihhA4
         8RXbYXAnk2OEXdVVBHHcucp7FxQdcHk8VJC+iEuBl+KpTkgX3cCHGlNfkNlBW16eqn5q
         Wnl3HEcoGyPOgMtEXnhHZi7Cn/SXYjAXuq2w7DeiAZhzvwAE2BLhXXtG3AbV6VGnh4OU
         k9BA==
X-Gm-Message-State: APjAAAWaqDjN7G9ZDt1wOpE0KVwGLCuwUOc8cazd1onIvXtXuhr1z7uk
        i2X9h3ZQLzSXNTpJTzhde1Y=
X-Google-Smtp-Source: APXvYqxpOf5pdyf4LaxYq8fY8ePlBgvBVfGIxRRLOA0xvLdsyojlLpwpKh1r7MGdFWtp8+x/NT6tbw==
X-Received: by 2002:a37:dcc1:: with SMTP id v184mr4714248qki.338.1559241423251;
        Thu, 30 May 2019 11:37:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:658d])
        by smtp.gmail.com with ESMTPSA id c15sm2028256qkk.6.2019.05.30.11.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 11:37:02 -0700 (PDT)
Date:   Thu, 30 May 2019 11:37:00 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Li Zefan <lizefan@huawei.com>, Topi Miettinen <toiwoton@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, security@debian.org,
        Lennart Poettering <lennart@poettering.net>,
        security@kernel.org
Subject: [PATCH 3/3 cgroup/for-5.2-fixes] cgroup: Include dying leaders with
 live threads in PROCS iterations
Message-ID: <20190530183700.GT374014@devbig004.ftw2.facebook.com>
References: <1b882623-8eef-2281-a43e-5086727aa1d6@gmail.com>
 <20190527151806.GC8961@redhat.com>
 <87blznagrl.fsf@xmission.com>
 <1956727d-1ee8-92af-1e00-66ae4921b075@gmail.com>
 <87zhn6923n.fsf@xmission.com>
 <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com>
 <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com>
 <20190530183637.GS374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530183637.GS374014@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

CSS_TASK_ITER_PROCS currently iterates live group leaders; however,
this means that a process with dying leader and live threads will be
skipped.  IOW, cgroup.procs might be empty while cgroup.threads isn't,
which is confusing to say the least.

Fix it by making cset track dying tasks and include dying leaders with
live threads in PROCS iteration.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-and-tested-by: Topi Miettinen <toiwoton@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/cgroup-defs.h |    1 +
 include/linux/cgroup.h      |    1 +
 kernel/cgroup/cgroup.c      |   44 +++++++++++++++++++++++++++++++++++++-------
 3 files changed, 39 insertions(+), 7 deletions(-)

--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -216,6 +216,7 @@ struct css_set {
 	 */
 	struct list_head tasks;
 	struct list_head mg_tasks;
+	struct list_head dying_tasks;
 
 	/* all css_task_iters currently walking this cset */
 	struct list_head task_iters;
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -60,6 +60,7 @@ struct css_task_iter {
 	struct list_head		*task_pos;
 	struct list_head		*tasks_head;
 	struct list_head		*mg_tasks_head;
+	struct list_head		*dying_tasks_head;
 
 	struct css_set			*cur_cset;
 	struct css_set			*cur_dcset;
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -739,6 +739,7 @@ struct css_set init_css_set = {
 	.dom_cset		= &init_css_set,
 	.tasks			= LIST_HEAD_INIT(init_css_set.tasks),
 	.mg_tasks		= LIST_HEAD_INIT(init_css_set.mg_tasks),
+	.dying_tasks		= LIST_HEAD_INIT(init_css_set.dying_tasks),
 	.task_iters		= LIST_HEAD_INIT(init_css_set.task_iters),
 	.threaded_csets		= LIST_HEAD_INIT(init_css_set.threaded_csets),
 	.cgrp_links		= LIST_HEAD_INIT(init_css_set.cgrp_links),
@@ -1213,6 +1214,7 @@ static struct css_set *find_css_set(stru
 	cset->dom_cset = cset;
 	INIT_LIST_HEAD(&cset->tasks);
 	INIT_LIST_HEAD(&cset->mg_tasks);
+	INIT_LIST_HEAD(&cset->dying_tasks);
 	INIT_LIST_HEAD(&cset->task_iters);
 	INIT_LIST_HEAD(&cset->threaded_csets);
 	INIT_HLIST_NODE(&cset->hlist);
@@ -4399,15 +4401,18 @@ static void css_task_iter_advance_css_se
 			it->task_pos = NULL;
 			return;
 		}
-	} while (!css_set_populated(cset));
+	} while (!css_set_populated(cset) && !list_empty(&cset->dying_tasks));
 
 	if (!list_empty(&cset->tasks))
 		it->task_pos = cset->tasks.next;
-	else
+	else if (!list_empty(&cset->mg_tasks))
 		it->task_pos = cset->mg_tasks.next;
+	else
+		it->task_pos = cset->dying_tasks.next;
 
 	it->tasks_head = &cset->tasks;
 	it->mg_tasks_head = &cset->mg_tasks;
+	it->dying_tasks_head = &cset->dying_tasks;
 
 	/*
 	 * We don't keep css_sets locked across iteration steps and thus
@@ -4446,6 +4451,8 @@ static void css_task_iter_skip(struct cs
 
 static void css_task_iter_advance(struct css_task_iter *it)
 {
+	struct task_struct *task;
+
 	lockdep_assert_held(&css_set_lock);
 repeat:
 	if (it->task_pos) {
@@ -4462,17 +4469,32 @@ repeat:
 		if (it->task_pos == it->tasks_head)
 			it->task_pos = it->mg_tasks_head->next;
 		if (it->task_pos == it->mg_tasks_head)
+			it->task_pos = it->dying_tasks_head->next;
+		if (it->task_pos == it->dying_tasks_head)
 			css_task_iter_advance_css_set(it);
 	} else {
 		/* called from start, proceed to the first cset */
 		css_task_iter_advance_css_set(it);
 	}
 
-	/* if PROCS, skip over tasks which aren't group leaders */
-	if ((it->flags & CSS_TASK_ITER_PROCS) && it->task_pos &&
-	    !thread_group_leader(list_entry(it->task_pos, struct task_struct,
-					    cg_list)))
-		goto repeat;
+	if (!it->task_pos)
+		return;
+
+	task = list_entry(it->task_pos, struct task_struct, cg_list);
+
+	if (it->flags & CSS_TASK_ITER_PROCS) {
+		/* if PROCS, skip over tasks which aren't group leaders */
+		if (!thread_group_leader(task))
+			goto repeat;
+
+		/* and dying leaders w/o live member threads */
+		if (!atomic_read(&task->signal->live))
+			goto repeat;
+	} else {
+		/* skip all dying ones */
+		if (task->flags & PF_EXITING)
+			goto repeat;
+	}
 }
 
 /**
@@ -6009,6 +6031,7 @@ void cgroup_exit(struct task_struct *tsk
 	if (!list_empty(&tsk->cg_list)) {
 		spin_lock_irq(&css_set_lock);
 		css_set_move_task(tsk, cset, NULL, false);
+		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
 		cset->nr_tasks--;
 
 		WARN_ON_ONCE(cgroup_task_frozen(tsk));
@@ -6034,6 +6057,13 @@ void cgroup_release(struct task_struct *
 	do_each_subsys_mask(ss, ssid, have_release_callback) {
 		ss->release(task);
 	} while_each_subsys_mask();
+
+	if (use_task_css_set_links) {
+		spin_lock_irq(&css_set_lock);
+		css_set_skip_task_iters(task_css_set(task), task);
+		list_del_init(&task->cg_list);
+		spin_unlock_irq(&css_set_lock);
+	}
 }
 
 void cgroup_free(struct task_struct *task)
