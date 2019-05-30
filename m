Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3011C30206
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2019 20:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfE3Sgk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 May 2019 14:36:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36279 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfE3Sgk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 May 2019 14:36:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id u12so8234100qth.3
        for <cgroups@vger.kernel.org>; Thu, 30 May 2019 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nbiKKyOmhCzgQRToKzCk6lJExzXR6tkkOOMIj1Dr0CI=;
        b=jGwmqK0UFtIOumP55sWMJrG2LxGGe2YBumlP3G19y/9YYgXtA9h/vcuVwsxoD7J3mF
         H2klIa4IYmU62MgCRhVzyN8wHNITQaVrkjIfWvRAM70aoPzkQcffJqwF2PFhFSHGFHuN
         3X7XeFOeIdtGpbgfJFEDqt3ND36elc1qkjGEJgZx+EGdk9uIMSJilldocDZOLtkDKCG4
         geJL1nng5w8XtbosKuWsSKHL8euyZRkzCEM3EDkRQ+xATJg2EmED+C6Y7h4vHGBtHNhd
         GZAGFADy2n7Lc1KBBwx+L4mhn5tBm8MLtkwSiwHD9mOnlxwphB8Dx3UIXXfncAxEVlO5
         +OGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nbiKKyOmhCzgQRToKzCk6lJExzXR6tkkOOMIj1Dr0CI=;
        b=ZHRmqIK8h2ZQQs4eSUtqQOnkEet+W9ipYI9icn57lGgmf5d2H42E7+OTNmgaymkNQp
         1TSlttKsbuRWMsFvoI/ZQmrMjjGE302wWUc3v7MQWE49jnQvF/UnMY6lg93XaF/jCOKJ
         qlvgf/YUVhFYNHopJCxCcrNqgHTNU+ba4uyLYZkeet6zYbgyzbqdj5qY2zmfsbUBx5EM
         a92q2GygfkF7LCeEv67j5rBcO1NXLZjIlx3qJHWpTzzSH907FA14lKXMYnJmThx52FVA
         De0XII6mSU5BX/XRqJXByoXLy5YZ3Q5CFBMPlQpsRmpBcJa6IwOc1FFfoIWOoC0z+ftW
         SoUw==
X-Gm-Message-State: APjAAAW6hBKBjtkYJMzt+e9nOInZ03OB9oO7KO4EEIPXTGGMgJX6IpAt
        EAtuzGXaucgVn3fPtWgDAdo=
X-Google-Smtp-Source: APXvYqweKAgx1hdsnGohbqZ5Es/fH5fqXT+TSRQAAAiljEwZA0qvfyTXXZRfx5D50RgTjoBGtYwmLA==
X-Received: by 2002:a05:6214:248:: with SMTP id k8mr4873069qvt.200.1559241399199;
        Thu, 30 May 2019 11:36:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:658d])
        by smtp.gmail.com with ESMTPSA id u125sm1988573qkd.5.2019.05.30.11.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 11:36:38 -0700 (PDT)
Date:   Thu, 30 May 2019 11:36:37 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Li Zefan <lizefan@huawei.com>, Topi Miettinen <toiwoton@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, security@debian.org,
        Lennart Poettering <lennart@poettering.net>,
        security@kernel.org
Subject: [PATCH 2/3 cgroup/for-5.2-fixes] cgroup: Implement
 css_task_iter_skip() before __exit_signal()
Message-ID: <20190530183637.GS374014@devbig004.ftw2.facebook.com>
References: <20190524104054.GA29724@redhat.com>
 <1b882623-8eef-2281-a43e-5086727aa1d6@gmail.com>
 <20190527151806.GC8961@redhat.com>
 <87blznagrl.fsf@xmission.com>
 <1956727d-1ee8-92af-1e00-66ae4921b075@gmail.com>
 <87zhn6923n.fsf@xmission.com>
 <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com>
 <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530183556.GR374014@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When a task is moved out of a cset, task iterators pointing to the
task are advanced using the normal css_task_iter_advance() call.  This
is fine but we'll be tracking dying tasks on csets and thus moving
tasks from cset->tasks to (to be added) cset->dying_tasks.  When we
remove a task from cset->tasks, if we advance the iterators, they may
move over to the next cset before we had the chance to add the task
back on the dying list, which can allow the task to escape iteration.

This patch separates out skipping from advancing.  Skipping only moves
the affected iterators to the next pointer rather than fully advancing
it and the following advancing will recognize that the cursor has
already been moved forward and do the rest of advancing.  This ensures
that when a task moves from one list to another in its cset, as long
as it moves in the right direction, it's always visible to iteration.

This doesn't cause any visible behavior changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/cgroup.h |    3 ++
 kernel/cgroup/cgroup.c |   60 +++++++++++++++++++++++++++++--------------------
 2 files changed, 39 insertions(+), 24 deletions(-)

--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -43,6 +43,9 @@
 /* walk all threaded css_sets in the domain */
 #define CSS_TASK_ITER_THREADED		(1U << 1)
 
+/* internal flags */
+#define CSS_TASK_ITER_SKIPPED		(1U << 16)
+
 /* a css_task_iter should be treated as an opaque object */
 struct css_task_iter {
 	struct cgroup_subsys		*ss;
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -215,7 +215,8 @@ static struct cftype cgroup_base_files[]
 
 static int cgroup_apply_control(struct cgroup *cgrp);
 static void cgroup_finalize_control(struct cgroup *cgrp, int ret);
-static void css_task_iter_advance(struct css_task_iter *it);
+static void css_task_iter_skip(struct css_task_iter *it,
+			       struct task_struct *task);
 static int cgroup_destroy_locked(struct cgroup *cgrp);
 static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 					      struct cgroup_subsys *ss);
@@ -843,6 +844,21 @@ static void css_set_update_populated(str
 		cgroup_update_populated(link->cgrp, populated);
 }
 
+/*
+ * @task is leaving, advance task iterators which are pointing to it so
+ * that they can resume at the next position.  Advancing an iterator might
+ * remove it from the list, use safe walk.  See css_task_iter_skip() for
+ * details.
+ */
+static void css_set_skip_task_iters(struct css_set *cset,
+				    struct task_struct *task)
+{
+	struct css_task_iter *it, *pos;
+
+	list_for_each_entry_safe(it, pos, &cset->task_iters, iters_node)
+		css_task_iter_skip(it, task);
+}
+
 /**
  * css_set_move_task - move a task from one css_set to another
  * @task: task being moved
@@ -868,22 +884,9 @@ static void css_set_move_task(struct tas
 		css_set_update_populated(to_cset, true);
 
 	if (from_cset) {
-		struct css_task_iter *it, *pos;
-
 		WARN_ON_ONCE(list_empty(&task->cg_list));
 
-		/*
-		 * @task is leaving, advance task iterators which are
-		 * pointing to it so that they can resume at the next
-		 * position.  Advancing an iterator might remove it from
-		 * the list, use safe walk.  See css_task_iter_advance*()
-		 * for details.
-		 */
-		list_for_each_entry_safe(it, pos, &from_cset->task_iters,
-					 iters_node)
-			if (it->task_pos == &task->cg_list)
-				css_task_iter_advance(it);
-
+		css_set_skip_task_iters(from_cset, task);
 		list_del_init(&task->cg_list);
 		if (!css_set_populated(from_cset))
 			css_set_update_populated(from_cset, false);
@@ -4430,10 +4433,19 @@ static void css_task_iter_advance_css_se
 	list_add(&it->iters_node, &cset->task_iters);
 }
 
-static void css_task_iter_advance(struct css_task_iter *it)
+static void css_task_iter_skip(struct css_task_iter *it,
+			       struct task_struct *task)
 {
-	struct list_head *next;
+	lockdep_assert_held(&css_set_lock);
+
+	if (it->task_pos == &task->cg_list) {
+		it->task_pos = it->task_pos->next;
+		it->flags |= CSS_TASK_ITER_SKIPPED;
+	}
+}
 
+static void css_task_iter_advance(struct css_task_iter *it)
+{
 	lockdep_assert_held(&css_set_lock);
 repeat:
 	if (it->task_pos) {
@@ -4442,15 +4454,15 @@ repeat:
 		 * consumed first and then ->mg_tasks.  After ->mg_tasks,
 		 * we move onto the next cset.
 		 */
-		next = it->task_pos->next;
-
-		if (next == it->tasks_head)
-			next = it->mg_tasks_head->next;
+		if (it->flags & CSS_TASK_ITER_SKIPPED)
+			it->flags &= ~CSS_TASK_ITER_SKIPPED;
+		else
+			it->task_pos = it->task_pos->next;
 
-		if (next == it->mg_tasks_head)
+		if (it->task_pos == it->tasks_head)
+			it->task_pos = it->mg_tasks_head->next;
+		if (it->task_pos == it->mg_tasks_head)
 			css_task_iter_advance_css_set(it);
-		else
-			it->task_pos = next;
 	} else {
 		/* called from start, proceed to the first cset */
 		css_task_iter_advance_css_set(it);
