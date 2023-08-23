Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61C4785EEE
	for <lists+cgroups@lfdr.de>; Wed, 23 Aug 2023 19:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbjHWRsM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Aug 2023 13:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbjHWRsL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Aug 2023 13:48:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BFA10C2;
        Wed, 23 Aug 2023 10:48:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AC69A2219F;
        Wed, 23 Aug 2023 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692812887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oRv02HgHe+FBVfaMegRXeP4W687Upq+3iPpdDH2yY5c=;
        b=jZ8yre+TEJLVuO1ylH8E7S8bu+w2xRj4pPK3DvYyUymQBpe4VnrYI9m9GTun7UGKyAQdqc
        np0R8Gq+/nDHndl5gFV9ZUvq12MOy8aw8k+igkWORwWHXm6jQjKdeBSq/Jfh/23mTvk9wp
        HO7Wp5UxwtxlwwJir3CKkwGzt2nlg0w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8959213458;
        Wed, 23 Aug 2023 17:48:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oG68IFdG5mQ/ZwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 23 Aug 2023 17:48:07 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Firo Yang <firo.yang@suse.com>
Subject: [PATCH 2/2] cgroup: Remove v1 specific pidlist code
Date:   Wed, 23 Aug 2023 19:48:04 +0200
Message-ID: <20230823174804.23632-3-mkoutny@suse.com>
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

Functions and structures for generating, caching, disposing and
presenting pidlists are unused since v1 conversion to unordered listing
of member tasks. Remove the dead code now.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup-defs.h     |   7 -
 kernel/cgroup/cgroup-internal.h |   7 -
 kernel/cgroup/cgroup-v1.c       | 366 --------------------------------
 kernel/cgroup/cgroup.c          |   3 -
 4 files changed, 383 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 8a0d5466c7be..639fc8e6c8c2 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -482,13 +482,6 @@ struct cgroup {
 	struct cgroup_base_stat bstat;
 	struct prev_cputime prev_cputime;	/* for printing out cputime */
 
-	/*
-	 * list of pidlists, up to two for each namespace (one for procs, one
-	 * for tasks); created on demand.
-	 */
-	struct list_head pidlists;
-	struct mutex pidlist_mutex;
-
 	/* used to wait for offlining of csses */
 	wait_queue_head_t offline_waitq;
 
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 8edf7aeac159..3786009ef0ad 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -64,8 +64,6 @@ static inline struct cgroup_fs_context *cgroup_fc2context(struct fs_context *fc)
 	return container_of(kfc, struct cgroup_fs_context, kfc);
 }
 
-struct cgroup_pidlist;
-
 struct cgroup_file_ctx {
 	struct cgroup_namespace	*ns;
 
@@ -77,10 +75,6 @@ struct cgroup_file_ctx {
 		bool			started;
 		struct css_task_iter	iter;
 	} procs;
-
-	struct {
-		struct cgroup_pidlist	*pidlist;
-	} procs1;
 };
 
 /*
@@ -291,7 +285,6 @@ extern const struct fs_parameter_spec cgroup1_fs_parameters[];
 
 int proc_cgroupstats_show(struct seq_file *m, void *v);
 bool cgroup1_ssid_disabled(int ssid);
-void cgroup1_pidlist_destroy_all(struct cgroup *cgrp);
 void cgroup1_release_agent(struct work_struct *work);
 void cgroup1_check_for_release(struct cgroup *cgrp);
 int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 7c0945ccba0d..0de6db81efae 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -18,26 +18,12 @@
 
 #include <trace/events/cgroup.h>
 
-/*
- * pidlists linger the following amount before being destroyed.  The goal
- * is avoiding frequent destruction in the middle of consecutive read calls
- * Expiring in the middle is a performance problem not a correctness one.
- * 1 sec should be enough.
- */
-#define CGROUP_PIDLIST_DESTROY_DELAY	HZ
-
 /* Controllers blocked by the commandline in v1 */
 static u16 cgroup_no_v1_mask;
 
 /* disable named v1 mounts */
 static bool cgroup_no_v1_named;
 
-/*
- * pidlist destructions need to be flushed on cgroup destruction.  Use a
- * separate workqueue as flush domain.
- */
-static struct workqueue_struct *cgroup_pidlist_destroy_wq;
-
 /* protects cgroup_subsys->release_agent_path */
 static DEFINE_SPINLOCK(release_agent_path_lock);
 
@@ -149,343 +135,6 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	return ret;
 }
 
-/*
- * Stuff for reading the 'tasks'/'procs' files.
- *
- * Reading this file can return large amounts of data if a cgroup has
- * *lots* of attached tasks. So it may need several calls to read(),
- * but we cannot guarantee that the information we produce is correct
- * unless we produce it entirely atomically.
- *
- */
-
-/* which pidlist file are we talking about? */
-enum cgroup_filetype {
-	CGROUP_FILE_PROCS,
-	CGROUP_FILE_TASKS,
-};
-
-/*
- * A pidlist is a list of pids that virtually represents the contents of one
- * of the cgroup files ("procs" or "tasks"). We keep a list of such pidlists,
- * a pair (one each for procs, tasks) for each pid namespace that's relevant
- * to the cgroup.
- */
-struct cgroup_pidlist {
-	/*
-	 * used to find which pidlist is wanted. doesn't change as long as
-	 * this particular list stays in the list.
-	*/
-	struct { enum cgroup_filetype type; struct pid_namespace *ns; } key;
-	/* array of xids */
-	pid_t *list;
-	/* how many elements the above list has */
-	int length;
-	/* each of these stored in a list by its cgroup */
-	struct list_head links;
-	/* pointer to the cgroup we belong to, for list removal purposes */
-	struct cgroup *owner;
-	/* for delayed destruction */
-	struct delayed_work destroy_dwork;
-};
-
-/*
- * Used to destroy all pidlists lingering waiting for destroy timer.  None
- * should be left afterwards.
- */
-void cgroup1_pidlist_destroy_all(struct cgroup *cgrp)
-{
-	struct cgroup_pidlist *l, *tmp_l;
-
-	mutex_lock(&cgrp->pidlist_mutex);
-	list_for_each_entry_safe(l, tmp_l, &cgrp->pidlists, links)
-		mod_delayed_work(cgroup_pidlist_destroy_wq, &l->destroy_dwork, 0);
-	mutex_unlock(&cgrp->pidlist_mutex);
-
-	flush_workqueue(cgroup_pidlist_destroy_wq);
-	BUG_ON(!list_empty(&cgrp->pidlists));
-}
-
-static void cgroup_pidlist_destroy_work_fn(struct work_struct *work)
-{
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct cgroup_pidlist *l = container_of(dwork, struct cgroup_pidlist,
-						destroy_dwork);
-	struct cgroup_pidlist *tofree = NULL;
-
-	mutex_lock(&l->owner->pidlist_mutex);
-
-	/*
-	 * Destroy iff we didn't get queued again.  The state won't change
-	 * as destroy_dwork can only be queued while locked.
-	 */
-	if (!delayed_work_pending(dwork)) {
-		list_del(&l->links);
-		kvfree(l->list);
-		put_pid_ns(l->key.ns);
-		tofree = l;
-	}
-
-	mutex_unlock(&l->owner->pidlist_mutex);
-	kfree(tofree);
-}
-
-/*
- * pidlist_uniq - given a kmalloc()ed list, strip out all duplicate entries
- * Returns the number of unique elements.
- */
-static int pidlist_uniq(pid_t *list, int length)
-{
-	int src, dest = 1;
-
-	/*
-	 * we presume the 0th element is unique, so i starts at 1. trivial
-	 * edge cases first; no work needs to be done for either
-	 */
-	if (length == 0 || length == 1)
-		return length;
-	/* src and dest walk down the list; dest counts unique elements */
-	for (src = 1; src < length; src++) {
-		/* find next unique element */
-		while (list[src] == list[src-1]) {
-			src++;
-			if (src == length)
-				goto after;
-		}
-		/* dest always points to where the next unique element goes */
-		list[dest] = list[src];
-		dest++;
-	}
-after:
-	return dest;
-}
-
-/*
- * The two pid files - task and cgroup.procs - guaranteed that the result
- * is sorted, which forced this whole pidlist fiasco.  As pid order is
- * different per namespace, each namespace needs differently sorted list,
- * making it impossible to use, for example, single rbtree of member tasks
- * sorted by task pointer.  As pidlists can be fairly large, allocating one
- * per open file is dangerous, so cgroup had to implement shared pool of
- * pidlists keyed by cgroup and namespace.
- */
-static int cmppid(const void *a, const void *b)
-{
-	return *(pid_t *)a - *(pid_t *)b;
-}
-
-static struct cgroup_pidlist *cgroup_pidlist_find(struct cgroup *cgrp,
-						  enum cgroup_filetype type)
-{
-	struct cgroup_pidlist *l;
-	/* don't need task_nsproxy() if we're looking at ourself */
-	struct pid_namespace *ns = task_active_pid_ns(current);
-
-	lockdep_assert_held(&cgrp->pidlist_mutex);
-
-	list_for_each_entry(l, &cgrp->pidlists, links)
-		if (l->key.type == type && l->key.ns == ns)
-			return l;
-	return NULL;
-}
-
-/*
- * find the appropriate pidlist for our purpose (given procs vs tasks)
- * returns with the lock on that pidlist already held, and takes care
- * of the use count, or returns NULL with no locks held if we're out of
- * memory.
- */
-static struct cgroup_pidlist *cgroup_pidlist_find_create(struct cgroup *cgrp,
-						enum cgroup_filetype type)
-{
-	struct cgroup_pidlist *l;
-
-	lockdep_assert_held(&cgrp->pidlist_mutex);
-
-	l = cgroup_pidlist_find(cgrp, type);
-	if (l)
-		return l;
-
-	/* entry not found; create a new one */
-	l = kzalloc(sizeof(struct cgroup_pidlist), GFP_KERNEL);
-	if (!l)
-		return l;
-
-	INIT_DELAYED_WORK(&l->destroy_dwork, cgroup_pidlist_destroy_work_fn);
-	l->key.type = type;
-	/* don't need task_nsproxy() if we're looking at ourself */
-	l->key.ns = get_pid_ns(task_active_pid_ns(current));
-	l->owner = cgrp;
-	list_add(&l->links, &cgrp->pidlists);
-	return l;
-}
-
-/*
- * Load a cgroup's pidarray with either procs' tgids or tasks' pids
- */
-static int pidlist_array_load(struct cgroup *cgrp, enum cgroup_filetype type,
-			      struct cgroup_pidlist **lp)
-{
-	pid_t *array;
-	int length;
-	int pid, n = 0; /* used for populating the array */
-	struct css_task_iter it;
-	struct task_struct *tsk;
-	struct cgroup_pidlist *l;
-
-	lockdep_assert_held(&cgrp->pidlist_mutex);
-
-	/*
-	 * If cgroup gets more users after we read count, we won't have
-	 * enough space - tough.  This race is indistinguishable to the
-	 * caller from the case that the additional cgroup users didn't
-	 * show up until sometime later on.
-	 */
-	length = cgroup_task_count(cgrp);
-	array = kvmalloc_array(length, sizeof(pid_t), GFP_KERNEL);
-	if (!array)
-		return -ENOMEM;
-	/* now, populate the array */
-	css_task_iter_start(&cgrp->self, 0, &it);
-	while ((tsk = css_task_iter_next(&it))) {
-		if (unlikely(n == length))
-			break;
-		/* get tgid or pid for procs or tasks file respectively */
-		if (type == CGROUP_FILE_PROCS)
-			pid = task_tgid_vnr(tsk);
-		else
-			pid = task_pid_vnr(tsk);
-		if (pid > 0) /* make sure to only use valid results */
-			array[n++] = pid;
-	}
-	css_task_iter_end(&it);
-	length = n;
-	/* now sort & (if procs) strip out duplicates */
-	sort(array, length, sizeof(pid_t), cmppid, NULL);
-	if (type == CGROUP_FILE_PROCS)
-		length = pidlist_uniq(array, length);
-
-	l = cgroup_pidlist_find_create(cgrp, type);
-	if (!l) {
-		kvfree(array);
-		return -ENOMEM;
-	}
-
-	/* store array, freeing old if necessary */
-	kvfree(l->list);
-	l->list = array;
-	l->length = length;
-	*lp = l;
-	return 0;
-}
-
-/*
- * seq_file methods for the tasks/procs files. The seq_file position is the
- * next pid to display; the seq_file iterator is a pointer to the pid
- * in the cgroup->l->list array.
- */
-
-static void *cgroup_pidlist_start(struct seq_file *s, loff_t *pos)
-{
-	/*
-	 * Initially we receive a position value that corresponds to
-	 * one more than the last pid shown (or 0 on the first call or
-	 * after a seek to the start). Use a binary-search to find the
-	 * next pid to display, if any
-	 */
-	struct kernfs_open_file *of = s->private;
-	struct cgroup_file_ctx *ctx = of->priv;
-	struct cgroup *cgrp = seq_css(s)->cgroup;
-	struct cgroup_pidlist *l;
-	enum cgroup_filetype type = seq_cft(s)->private;
-	int index = 0, pid = *pos;
-	int *iter, ret;
-
-	mutex_lock(&cgrp->pidlist_mutex);
-
-	/*
-	 * !NULL @ctx->procs1.pidlist indicates that this isn't the first
-	 * start() after open. If the matching pidlist is around, we can use
-	 * that. Look for it. Note that @ctx->procs1.pidlist can't be used
-	 * directly. It could already have been destroyed.
-	 */
-	if (ctx->procs1.pidlist)
-		ctx->procs1.pidlist = cgroup_pidlist_find(cgrp, type);
-
-	/*
-	 * Either this is the first start() after open or the matching
-	 * pidlist has been destroyed inbetween.  Create a new one.
-	 */
-	if (!ctx->procs1.pidlist) {
-		ret = pidlist_array_load(cgrp, type, &ctx->procs1.pidlist);
-		if (ret)
-			return ERR_PTR(ret);
-	}
-	l = ctx->procs1.pidlist;
-
-	if (pid) {
-		int end = l->length;
-
-		while (index < end) {
-			int mid = (index + end) / 2;
-			if (l->list[mid] == pid) {
-				index = mid;
-				break;
-			} else if (l->list[mid] <= pid)
-				index = mid + 1;
-			else
-				end = mid;
-		}
-	}
-	/* If we're off the end of the array, we're done */
-	if (index >= l->length)
-		return NULL;
-	/* Update the abstract position to be the actual pid that we found */
-	iter = l->list + index;
-	*pos = *iter;
-	return iter;
-}
-
-static void cgroup_pidlist_stop(struct seq_file *s, void *v)
-{
-	struct kernfs_open_file *of = s->private;
-	struct cgroup_file_ctx *ctx = of->priv;
-	struct cgroup_pidlist *l = ctx->procs1.pidlist;
-
-	if (l)
-		mod_delayed_work(cgroup_pidlist_destroy_wq, &l->destroy_dwork,
-				 CGROUP_PIDLIST_DESTROY_DELAY);
-	mutex_unlock(&seq_css(s)->cgroup->pidlist_mutex);
-}
-
-static void *cgroup_pidlist_next(struct seq_file *s, void *v, loff_t *pos)
-{
-	struct kernfs_open_file *of = s->private;
-	struct cgroup_file_ctx *ctx = of->priv;
-	struct cgroup_pidlist *l = ctx->procs1.pidlist;
-	pid_t *p = v;
-	pid_t *end = l->list + l->length;
-	/*
-	 * Advance to the next pid in the array. If this goes off the
-	 * end, we're done
-	 */
-	p++;
-	if (p >= end) {
-		(*pos)++;
-		return NULL;
-	} else {
-		*pos = *p;
-		return p;
-	}
-}
-
-static int cgroup_pidlist_show(struct seq_file *s, void *v)
-{
-	seq_printf(s, "%d\n", *(int *)v);
-
-	return 0;
-}
-
 static int cgroup1_procs_show(struct seq_file *s, void *v)
 {
 	pid_t pid;
@@ -639,7 +288,6 @@ static int cgroup_clone_children_write(struct cgroup_subsys_state *css,
 struct cftype cgroup1_base_files[] = {
 	{
 		.name = "cgroup.procs",
-		.private = CGROUP_FILE_PROCS,
 		.release = cgroup_procs_release,
 		.seq_start = cgroup_procs_start,
 		.seq_next = cgroup_procs_next,
@@ -658,7 +306,6 @@ struct cftype cgroup1_base_files[] = {
 	},
 	{
 		.name = "tasks",
-		.private = CGROUP_FILE_TASKS,
 		.release = cgroup_procs_release,
 		.seq_start = cgroup_threads_start,
 		.seq_next = cgroup_procs_next,
@@ -1279,19 +926,6 @@ int cgroup1_get_tree(struct fs_context *fc)
 	return ret;
 }
 
-static int __init cgroup1_wq_init(void)
-{
-	/*
-	 * Used to destroy pidlists and separate to serve as flush domain.
-	 * Cap @max_active to 1 too.
-	 */
-	cgroup_pidlist_destroy_wq = alloc_workqueue("cgroup_pidlist_destroy",
-						    0, 1);
-	BUG_ON(!cgroup_pidlist_destroy_wq);
-	return 0;
-}
-core_initcall(cgroup1_wq_init);
-
 static int __init cgroup_no_v1(char *str)
 {
 	struct cgroup_subsys *ss;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3c5ba2ca7852..e65cbe2bfd7b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2014,8 +2014,6 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 	INIT_LIST_HEAD(&cgrp->self.sibling);
 	INIT_LIST_HEAD(&cgrp->self.children);
 	INIT_LIST_HEAD(&cgrp->cset_links);
-	INIT_LIST_HEAD(&cgrp->pidlists);
-	mutex_init(&cgrp->pidlist_mutex);
 	cgrp->self.cgroup = cgrp;
 	cgrp->self.flags |= CSS_ONLINE;
 	cgrp->dom_cgrp = cgrp;
@@ -5332,7 +5330,6 @@ static void css_free_rwork_fn(struct work_struct *work)
 	} else {
 		/* cgroup free path */
 		atomic_dec(&cgrp->root->nr_cgrps);
-		cgroup1_pidlist_destroy_all(cgrp);
 		cancel_work_sync(&cgrp->release_agent_work);
 		bpf_cgrp_storage_free(cgrp);
 
-- 
2.41.0

