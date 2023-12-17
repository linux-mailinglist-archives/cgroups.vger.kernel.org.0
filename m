Return-Path: <cgroups+bounces-971-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF44815F62
	for <lists+cgroups@lfdr.de>; Sun, 17 Dec 2023 14:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77AEB21353
	for <lists+cgroups@lfdr.de>; Sun, 17 Dec 2023 13:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C9E44373;
	Sun, 17 Dec 2023 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZE3fqbM2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0E43AB2
	for <cgroups@vger.kernel.org>; Sun, 17 Dec 2023 13:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881CBC433C8;
	Sun, 17 Dec 2023 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702819690;
	bh=wAmzBfLA6Y6IUIxQDBoPkyFLNPsBcpQpj/vdqEZGXn0=;
	h=Subject:To:From:Date:From;
	b=ZE3fqbM2RIHOCowNcEip+B5wdQF/ua1p29S2nLi8SXwE1vBIKlBn6TUvCzM6PxTbN
	 G1HjJYV81WosnLMOWv/eUBYJSNOA6e8AywFH/Ps0oF3VMQ0AYRP4CQEi1aDLo3R5PP
	 cttRN8WQmPtasrTylrjdeWigdJmKUKYXqE5dlFFA=
Subject: patch "kernfs: Convert kernfs_path_from_node_locked() from strlcpy() to" added to driver-core-next
To: keescook@chromium.org,azeemshaikh38@gmail.com,cgroups@vger.kernel.org,gregkh@linuxfoundation.org,hannes@cmpxchg.org,lizefan.x@bytedance.com,longman@redhat.com,tj@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Dec 2023 14:26:55 +0100
Message-ID: <2023121755-upheld-diffusion-a4d6@gregkh>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    kernfs: Convert kernfs_path_from_node_locked() from strlcpy() to

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From ff6d413b0b59466e5acf2e42f294b1842ae130a1 Mon Sep 17 00:00:00 2001
From: Kees Cook <keescook@chromium.org>
Date: Tue, 12 Dec 2023 13:17:40 -0800
Subject: kernfs: Convert kernfs_path_from_node_locked() from strlcpy() to
 strscpy()

One of the last remaining users of strlcpy() in the kernel is
kernfs_path_from_node_locked(), which passes back the problematic "length
we _would_ have copied" return value to indicate truncation.  Convert the
chain of all callers to use the negative return value (some of which
already doing this explicitly). All callers were already also checking
for negative return values, so the risk to missed checks looks very low.

In this analysis, it was found that cgroup1_release_agent() actually
didn't handle the "too large" condition, so this is technically also a
bug fix. :)

Here's the chain of callers, and resolution identifying each one as now
handling the correct return value:

kernfs_path_from_node_locked()
        kernfs_path_from_node()
                pr_cont_kernfs_path()
                        returns void
                kernfs_path()
                        sysfs_warn_dup()
                                return value ignored
                        cgroup_path()
                                blkg_path()
                                        bfq_bic_update_cgroup()
                                                return value ignored
                                TRACE_IOCG_PATH()
                                        return value ignored
                                TRACE_CGROUP_PATH()
                                        return value ignored
                                perf_event_cgroup()
                                        return value ignored
                                task_group_path()
                                        return value ignored
                                damon_sysfs_memcg_path_eq()
                                        return value ignored
                                get_mm_memcg_path()
                                        return value ignored
                                lru_gen_seq_show()
                                        return value ignored
                        cgroup_path_from_kernfs_id()
                                return value ignored
                cgroup_show_path()
                        already converted "too large" error to negative value
                cgroup_path_ns_locked()
                        cgroup_path_ns()
                                bpf_iter_cgroup_show_fdinfo()
                                        return value ignored
                                cgroup1_release_agent()
                                        wasn't checking "too large" error
                        proc_cgroup_show()
                                already converted "too large" to negative value

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Waiman Long <longman@redhat.com>
Cc:  <cgroups@vger.kernel.org>
Co-developed-by: Azeem Shaikh <azeemshaikh38@gmail.com>
Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
Link: https://lore.kernel.org/r/20231116192127.1558276-3-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20231212211741.164376-3-keescook@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/dir.c           | 34 +++++++++++++++++-----------------
 kernel/cgroup/cgroup-v1.c |  2 +-
 kernel/cgroup/cgroup.c    |  4 ++--
 kernel/cgroup/cpuset.c    |  2 +-
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index d23bf7883b08..bce1d7ac95ca 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -127,7 +127,7 @@ static struct kernfs_node *kernfs_common_ancestor(struct kernfs_node *a,
  *
  * [3] when @kn_to is %NULL result will be "(null)"
  *
- * Return: the length of the full path.  If the full length is equal to or
+ * Return: the length of the constructed path.  If the path would have been
  * greater than @buflen, @buf contains the truncated path with the trailing
  * '\0'.  On error, -errno is returned.
  */
@@ -138,16 +138,17 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 	struct kernfs_node *kn, *common;
 	const char parent_str[] = "/..";
 	size_t depth_from, depth_to, len = 0;
+	ssize_t copied;
 	int i, j;
 
 	if (!kn_to)
-		return strlcpy(buf, "(null)", buflen);
+		return strscpy(buf, "(null)", buflen);
 
 	if (!kn_from)
 		kn_from = kernfs_root(kn_to)->kn;
 
 	if (kn_from == kn_to)
-		return strlcpy(buf, "/", buflen);
+		return strscpy(buf, "/", buflen);
 
 	common = kernfs_common_ancestor(kn_from, kn_to);
 	if (WARN_ON(!common))
@@ -158,18 +159,19 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 
 	buf[0] = '\0';
 
-	for (i = 0; i < depth_from; i++)
-		len += strlcpy(buf + len, parent_str,
-			       len < buflen ? buflen - len : 0);
+	for (i = 0; i < depth_from; i++) {
+		copied = strscpy(buf + len, parent_str, buflen - len);
+		if (copied < 0)
+			return copied;
+		len += copied;
+	}
 
 	/* Calculate how many bytes we need for the rest */
 	for (i = depth_to - 1; i >= 0; i--) {
 		for (kn = kn_to, j = 0; j < i; j++)
 			kn = kn->parent;
-		len += strlcpy(buf + len, "/",
-			       len < buflen ? buflen - len : 0);
-		len += strlcpy(buf + len, kn->name,
-			       len < buflen ? buflen - len : 0);
+
+		len += scnprintf(buf + len, buflen - len, "/%s", kn->name);
 	}
 
 	return len;
@@ -214,7 +216,7 @@ int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
  * path (which includes '..'s) as needed to reach from @from to @to is
  * returned.
  *
- * Return: the length of the full path.  If the full length is equal to or
+ * Return: the length of the constructed path.  If the path would have been
  * greater than @buflen, @buf contains the truncated path with the trailing
  * '\0'.  On error, -errno is returned.
  */
@@ -265,12 +267,10 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
 	sz = kernfs_path_from_node(kn, NULL, kernfs_pr_cont_buf,
 				   sizeof(kernfs_pr_cont_buf));
 	if (sz < 0) {
-		pr_cont("(error)");
-		goto out;
-	}
-
-	if (sz >= sizeof(kernfs_pr_cont_buf)) {
-		pr_cont("(name too long)");
+		if (sz == -E2BIG)
+			pr_cont("(name too long)");
+		else
+			pr_cont("(error)");
 		goto out;
 	}
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 76db6c67e39a..9cb00ebe9ac6 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -802,7 +802,7 @@ void cgroup1_release_agent(struct work_struct *work)
 		goto out_free;
 
 	ret = cgroup_path_ns(cgrp, pathbuf, PATH_MAX, &init_cgroup_ns);
-	if (ret < 0 || ret >= PATH_MAX)
+	if (ret < 0)
 		goto out_free;
 
 	argv[0] = agentbuf;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a844b421fd83..4bc8183b669f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1893,7 +1893,7 @@ int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 	len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
 	spin_unlock_irq(&css_set_lock);
 
-	if (len >= PATH_MAX)
+	if (len == -E2BIG)
 		len = -ERANGE;
 	else if (len > 0) {
 		seq_escape(sf, buf, " \t\n\\");
@@ -6278,7 +6278,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 		if (cgroup_on_dfl(cgrp) || !(tsk->flags & PF_EXITING)) {
 			retval = cgroup_path_ns_locked(cgrp, buf, PATH_MAX,
 						current->nsproxy->cgroup_ns);
-			if (retval >= PATH_MAX)
+			if (retval == -E2BIG)
 				retval = -ENAMETOOLONG;
 			if (retval < 0)
 				goto out_unlock;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 615daaf87f1f..fb29158ae825 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4941,7 +4941,7 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
 	retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
 				current->nsproxy->cgroup_ns);
 	css_put(css);
-	if (retval >= PATH_MAX)
+	if (retval == -E2BIG)
 		retval = -ENAMETOOLONG;
 	if (retval < 0)
 		goto out_free;
-- 
2.43.0



