Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0843785EE9
	for <lists+cgroups@lfdr.de>; Wed, 23 Aug 2023 19:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbjHWRsL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Aug 2023 13:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbjHWRsK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Aug 2023 13:48:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B7CE7F;
        Wed, 23 Aug 2023 10:48:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 872492219B;
        Wed, 23 Aug 2023 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692812887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hzy72L1hwInpLzqKyvPYU2J/nqr3QlKzFpp5LwCn0/I=;
        b=Y+M78rlXnur/6rWLJj1rlK9roYJscnm3bbh07zhvhO79wmYgNdFqAajrOoEuMWRtSvljyy
        BiKEPSkz3RdKvUe2iWTwlg6izk68XqVfBbmwnue6aIBgIrthgmTdtRwkbePIZUSHe/8ZXN
        980f4XL5tnwk2cFRB2GUja+aLFlNcmY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67A8513592;
        Wed, 23 Aug 2023 17:48:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GDCLGFdG5mQ/ZwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 23 Aug 2023 17:48:07 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Firo Yang <firo.yang@suse.com>
Subject: [PATCH 1/2] cgroup: Print v1 cgroup.procs and tasks without pidlists
Date:   Wed, 23 Aug 2023 19:48:03 +0200
Message-ID: <20230823174804.23632-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823174804.23632-1-mkoutny@suse.com>
References: <20230823174804.23632-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

pidlists are structure that allows printing cgroup member tasks in
sorted order and with proper pidns (in)visibility.

The promise of sorted output was removed in the commit 7823da36ce8e
("cgroups: update documentation of cgroups tasks and procs files") (more
than 13 years ago at the time of writing this).

On systems that still use v1 hierarchies (e.g. systemd in non-unified
mode), pidlists are problematic because:
a) their cache unnecessarily busies workqueues (cgroup_pidlist_destroy_wq)
b) PID recycling [1] may lead to logging noise:
> seq_file: buggy .next function kernfs_seq_next did not update position index

It is possible to reuse cgroup v2 code that relies directly on css_set
iterator without caching (effectively extracting css_task_iter_* calls
from pidlist_array_load()).
We only need to make a provision for pidns by skipping external tasks
(instead of printing '0' like in v2).

[1] cgroup v1 code uses PID as the iterator position, PID recycling causes
    a repetition of the same PID at the end of (`tasks`) pidlist and
    seq_file interprets this as a non-incremented index. (seq_file code
    corrects it by PID++, which should be harmless unless tasks file is
    read byte by byte).

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup-internal.h |  5 +++++
 kernel/cgroup/cgroup-v1.c       | 32 ++++++++++++++++++++++++--------
 kernel/cgroup/cgroup.c          |  8 ++++----
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c56071f150f2..8edf7aeac159 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -264,6 +264,11 @@ int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 int __cgroup_task_count(const struct cgroup *cgrp);
 int cgroup_task_count(const struct cgroup *cgrp);
 
+void cgroup_procs_release(struct kernfs_open_file *of);
+void *cgroup_procs_next(struct seq_file *s, void *v, loff_t *pos);
+void *cgroup_procs_start(struct seq_file *s, loff_t *pos);
+void *cgroup_threads_start(struct seq_file *s, loff_t *pos);
+
 /*
  * rstat.c
  */
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 83044312bc41..7c0945ccba0d 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -486,6 +486,22 @@ static int cgroup_pidlist_show(struct seq_file *s, void *v)
 	return 0;
 }
 
+static int cgroup1_procs_show(struct seq_file *s, void *v)
+{
+	pid_t pid;
+
+	/* Print PID both for `tasks` file (threads) and `cgroup.procs`
+	 * (processes), the latter iterates with CSS_TASK_ITER_PROCS hence we
+	 * get PIDs of thread group leaders, i.e. tgids.
+	 */
+	pid = task_pid_vnr(v);
+	if (!pid)
+		return SEQ_SKIP;
+
+	seq_printf(s, "%d\n", pid);
+	return 0;
+}
+
 static ssize_t __cgroup1_procs_write(struct kernfs_open_file *of,
 				     char *buf, size_t nbytes, loff_t off,
 				     bool threadgroup)
@@ -623,11 +639,11 @@ static int cgroup_clone_children_write(struct cgroup_subsys_state *css,
 struct cftype cgroup1_base_files[] = {
 	{
 		.name = "cgroup.procs",
-		.seq_start = cgroup_pidlist_start,
-		.seq_next = cgroup_pidlist_next,
-		.seq_stop = cgroup_pidlist_stop,
-		.seq_show = cgroup_pidlist_show,
 		.private = CGROUP_FILE_PROCS,
+		.release = cgroup_procs_release,
+		.seq_start = cgroup_procs_start,
+		.seq_next = cgroup_procs_next,
+		.seq_show = cgroup1_procs_show,
 		.write = cgroup1_procs_write,
 	},
 	{
@@ -642,11 +658,11 @@ struct cftype cgroup1_base_files[] = {
 	},
 	{
 		.name = "tasks",
-		.seq_start = cgroup_pidlist_start,
-		.seq_next = cgroup_pidlist_next,
-		.seq_stop = cgroup_pidlist_stop,
-		.seq_show = cgroup_pidlist_show,
 		.private = CGROUP_FILE_TASKS,
+		.release = cgroup_procs_release,
+		.seq_start = cgroup_threads_start,
+		.seq_next = cgroup_procs_next,
+		.seq_show = cgroup1_procs_show,
 		.write = cgroup1_tasks_write,
 	},
 	{
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f55a40db065f..3c5ba2ca7852 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4963,7 +4963,7 @@ void css_task_iter_end(struct css_task_iter *it)
 		put_task_struct(it->cur_task);
 }
 
-static void cgroup_procs_release(struct kernfs_open_file *of)
+void cgroup_procs_release(struct kernfs_open_file *of)
 {
 	struct cgroup_file_ctx *ctx = of->priv;
 
@@ -4971,7 +4971,7 @@ static void cgroup_procs_release(struct kernfs_open_file *of)
 		css_task_iter_end(&ctx->procs.iter);
 }
 
-static void *cgroup_procs_next(struct seq_file *s, void *v, loff_t *pos)
+void *cgroup_procs_next(struct seq_file *s, void *v, loff_t *pos)
 {
 	struct kernfs_open_file *of = s->private;
 	struct cgroup_file_ctx *ctx = of->priv;
@@ -5008,7 +5008,7 @@ static void *__cgroup_procs_start(struct seq_file *s, loff_t *pos,
 	return cgroup_procs_next(s, NULL, NULL);
 }
 
-static void *cgroup_procs_start(struct seq_file *s, loff_t *pos)
+void *cgroup_procs_start(struct seq_file *s, loff_t *pos)
 {
 	struct cgroup *cgrp = seq_css(s)->cgroup;
 
@@ -5152,7 +5152,7 @@ static ssize_t cgroup_procs_write(struct kernfs_open_file *of,
 	return __cgroup_procs_write(of, buf, true) ?: nbytes;
 }
 
-static void *cgroup_threads_start(struct seq_file *s, loff_t *pos)
+void *cgroup_threads_start(struct seq_file *s, loff_t *pos)
 {
 	return __cgroup_procs_start(s, pos, 0);
 }
-- 
2.41.0

