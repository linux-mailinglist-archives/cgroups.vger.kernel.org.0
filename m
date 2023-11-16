Return-Path: <cgroups+bounces-456-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8877EE761
	for <lists+cgroups@lfdr.de>; Thu, 16 Nov 2023 20:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FA51C208F5
	for <lists+cgroups@lfdr.de>; Thu, 16 Nov 2023 19:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C904595D;
	Thu, 16 Nov 2023 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RpEODg+X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A60118B
	for <cgroups@vger.kernel.org>; Thu, 16 Nov 2023 11:21:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso10566835ad.3
        for <cgroups@vger.kernel.org>; Thu, 16 Nov 2023 11:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700162488; x=1700767288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lQXUPDHwSb3W7AzEHeGiPOMrGqRC++G0/30oWFYpys=;
        b=RpEODg+XwhY1Acp+PJDOELMbmRUAu+D/Xoo/xYstpBTnWmMA8vGKzxqZiGQWUkc90K
         0lqw7UTGl1A4RJrJOIx7tbByfWwplwdStr18BLcAl7oZvcT51JQEfcCWKRKf2BwzlQEe
         Ab3h0t1Gqb5zCp26IZefLYGUCK02m7kkihq8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162488; x=1700767288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lQXUPDHwSb3W7AzEHeGiPOMrGqRC++G0/30oWFYpys=;
        b=rcEWF1VbegVbrLeDbSvoehXgA1u4/rZFQ8wOnqkm2iXKHYmwYI5O41L5Cfu4rJ+n/f
         ysJ74/E9trCdO0By8XcybkMaUgOHL9TGO0op7QNkoWO9nZnQivQlGy7zNkapmTps1Tb0
         pDnpMZ260E/1ucLvOmg0pbxjhEVEOSO1cMmD31xUeJR8pLlQaMqCXzNSu2veYODlzCQ8
         QeyeyEEjAFbZv+9y86P5GWpjq2LrGEfLN7vc9LB6muk39YlKeGeOVEnEZL5uusKypnAa
         RN3T+IBEOLTKbrlmjrqT6j+aIoxwXNfVmmiWx/cQxqLHinTLRXOqn9UtMMZReVCVjzFO
         t8OA==
X-Gm-Message-State: AOJu0YyfMUYPidxswHVUeJ0WHPgbKf9l8cQFbWj3YdVLMWu8oLX8zCr7
	VC7Wo5Hhfb6ovZjCHjqqZhdpAw==
X-Google-Smtp-Source: AGHT+IFm4YG/oaCFmEfgYf5uoVxckTreZ/Bctw5PNDreTVWHEYt0BKCZHpmtNgXlkwhnO8LZx1T2bQ==
X-Received: by 2002:a17:903:18e:b0:1ce:1674:fd15 with SMTP id z14-20020a170903018e00b001ce1674fd15mr11527634plg.65.1700162488598;
        Thu, 16 Nov 2023 11:21:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001c72c07c9d9sm5592plg.308.2023.11.16.11.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:21:28 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	cgroups@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 3/3] kernfs: Convert kernfs_path_from_node_locked() from strlcpy() to strscpy()
Date: Thu, 16 Nov 2023 11:21:25 -0800
Message-Id: <20231116192127.1558276-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116191718.work.246-kees@kernel.org>
References: <20231116191718.work.246-kees@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8689; i=keescook@chromium.org;
 h=from:subject; bh=sje9v6D9QIFWWAiLZIxMhxCeRGV4qg03i4fKPc7SIN8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlVmu1NoUIjydK+VgXZJN4O+Ab2Ex2hdoHKlPJH
 FjXVvdTYYGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVZrtQAKCRCJcvTf3G3A
 Jp/ZD/9/pX2tZ6bCcNKw/mYnC600HioBD2eNF1Vpf+wZoqJfvliJ824E7lu7kXMWB6xkrFuSDRQ
 HO7NELU2wWMz7ebzzgo2cM4inj0pnKRoqVGy0KKwvqZraO+yEElTI8tP5Upv4sSFPswbAE0hbw8
 SH2AAbx1+7DuvTJYHheHSkZQvxl9Vts+ZEt8v/VljlGtf9vgcHJLc6Ps0pBzsvLWwJibBuW0ixs
 l7UjIy3+Rqe1HUYOlIqJU2pfDyiA8qyI2oUPvKERjwyBEhG1lyoSCfomFFXHbRyip1lGJbQzVuG
 lxIBcKENShb9BFVjDZ75DeZUmCpzZ3hTH2tCmbkLow+30wZb0rkTzqDUU+cS9TFK/JwySY6FEOU
 QGHoMFWSmhHbOf3WfIS1Xl4tsI2FuvqZy3L3L+HiVK9Ig4DOLEqCc8rbLn6oyVhb2GIAENUZt/r
 2UD1BGAVkUAgu5Q9qcOR8q5PPNP1wJeE9rY+l8DY1Os2TijocUPtYzM36KaqEg8LWqqMoZ7iF5u
 3Q4XeYxLv1dk1bCOX9pBnd7zuUTekZx+/RUQ/i/WhlQrpCYLnzMtI1m43jfoeTbOWPB3yVmxy33
 4JWoKITXKwIpGGLlwlig9otmxMoQ9xG3Nz8oZRw6CWvBxnGPEIMXCDVim7aIKnMs2jZZTETIToD APj6swjaf4Y7M5A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

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
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: cgroups@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Co-developed-by: Azeem Shaikh <azeemshaikh38@gmail.com>
Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/kernfs/dir.c             | 37 ++++++++++++++++++++-----------------
 kernel/cgroup/cgroup-v1.c   |  2 +-
 kernel/cgroup/cgroup.c      |  4 ++--
 kernel/cgroup/cpuset.c      |  2 +-
 kernel/trace/trace_uprobe.c |  2 +-
 5 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8c0e5442597e..183f353b3852 100644
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
@@ -158,18 +159,22 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 
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
+		copied = scnprintf(buf + len, buflen - len, "/%s", kn->name);
+		if (copied < 0)
+			return copied;
+		len += copied;
 	}
 
 	return len;
@@ -214,7 +219,7 @@ int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
  * path (which includes '..'s) as needed to reach from @from to @to is
  * returned.
  *
- * Return: the length of the full path.  If the full length is equal to or
+ * Return: the length of the constructed path.  If the path would have been
  * greater than @buflen, @buf contains the truncated path with the trailing
  * '\0'.  On error, -errno is returned.
  */
@@ -265,12 +270,10 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
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
index 1d5b9de3b1b9..3a04db0d1fe6 100644
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
@@ -6313,7 +6313,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
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
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 99c051de412a..a84b85d8aac1 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -151,7 +151,7 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 		return -ENOMEM;
 
 	if (addr == FETCH_TOKEN_COMM)
-		ret = strlcpy(dst, current->comm, maxlen);
+		ret = strscpy(dst, current->comm, maxlen);
 	else
 		ret = strncpy_from_user(dst, src, maxlen);
 	if (ret >= 0) {
-- 
2.34.1


