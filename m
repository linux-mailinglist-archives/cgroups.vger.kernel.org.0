Return-Path: <cgroups+bounces-919-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E7C80F8F6
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 22:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0388E282004
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 21:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521C265A8F;
	Tue, 12 Dec 2023 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EBII8CWq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50E8A7
	for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 13:17:42 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d098b87eeeso54945325ad.0
        for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 13:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702415862; x=1703020662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgP6QDGYW90+EPtUKh6hhExTw/nr/8L1WXYuh71GNlI=;
        b=EBII8CWqTewHCYUKQvaukG1zWeJjB2pl/RbMg+j8fFcvUq11md9ygurXaQ0F8RZJRd
         QN9d/19YNp3UbZ8oh9br9LCWCn2S3HP6xRQ592cXogzBEjuqKMlAo7D2tjJgS0BmhQwY
         x3edF44sbx8FhzObBflU+lF0Lssb3eOq3JnHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702415862; x=1703020662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgP6QDGYW90+EPtUKh6hhExTw/nr/8L1WXYuh71GNlI=;
        b=gtIuIDQLA587xRYET9A929XDgPiQ4qQ6lJPOJGGwQMQfK8Or0kKrpE9es4zlE1zL8+
         YvJDzC9qwdL/dtnNrksydShPWiuB8blsUNOy6pqrgU6neNWNVZv1l5DU1oRt1WFPffrj
         x9ZBFmtUfgFmzCICFjWJGmQYiu3PH2XCfW7XoJnW2Z+mhufVZZ3fvLHq5+o1bql5VIXe
         TK/YXG3zywQxUtI2xWx++XH1/6qtWIesn+DQMEDtMGO71b8TSEeZ9DlzTjioYKUnXeJS
         ApIkDWRE9zzbUHd0b1sGURu2QaRN4XMjkxJeEhXSYM0acGl3aQVVBSuTsu+BMJlVfQKl
         coow==
X-Gm-Message-State: AOJu0Yyf3TVoxIm2MzS5E7f0bOERRXZm5NQv0Ugm/F6vYAj7Hv7vM9iw
	de/SL+AIaNKxuUcmIR1bdo1XRA==
X-Google-Smtp-Source: AGHT+IFjDgIDgEDyV0NYMtC7wrznCUmiU5/lWSweOP8HyZzQAO0+By9K4rXrnLgAr+Ii7qKKdIvgKg==
X-Received: by 2002:a17:902:e74e:b0:1cc:5e1b:98b5 with SMTP id p14-20020a170902e74e00b001cc5e1b98b5mr7270093plf.66.1702415862230;
        Tue, 12 Dec 2023 13:17:42 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001cf7c07be50sm9052322plq.58.2023.12.12.13.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:17:41 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 3/3] kernfs: Convert kernfs_path_from_node_locked() from strlcpy() to strscpy()
Date: Tue, 12 Dec 2023 13:17:40 -0800
Message-Id: <20231212211741.164376-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212211606.make.155-kees@kernel.org>
References: <20231212211606.make.155-kees@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8042; i=keescook@chromium.org;
 h=from:subject; bh=shZXUYfHvcn83JB9rTJeaRzUZqZ1UgzjWRrQTVCVtxU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBleM30G+t8NV/vyHSFzjkC+K+Zj47yXA4kAs33K
 S4H3DoxNmuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZXjN9AAKCRCJcvTf3G3A
 JkyTEAConGhiBLHsocQ8sbSwq6RTnjeVAFv2A72J5kJK8MHW3sFiydk6ragXK0H4NjhddAT6k9R
 Iwpc+sAMeXtC5LSHlbkxzwxmAmTpvdZ0+HkpGNofYnO1GRBS2tNZQBx2xovmaBZGLhI3uL1S2Mf
 uFy1jEp7IRjwOUbM1zHWV4bM+TLIxRHQDtwtec7aUCS9kz92muBO+LZI8wOqu3//0chhPA/oJYK
 OmIQjfULUR5a/IzcHJAYVXdcRoDKXwclSWSFPM/lbR+ZX7XOdatfwteancUB7mA3VqMASoK6jzD
 /WWodvOyGvMywKDybb9iVwPwLdcDqi6f6YRwUsKHrO1PU0X/vaRreWv0AW+McpdjcGDDak159n5
 dLG/EkNlTRggxw61NNRmjuUIplvXSnvWAMjv1qumw8iiEzajnLTxs+d3rF7yWOneFFWz8cuucBs
 T6q984RP+2VM4dWIU9dRcdMhF4+sfRiXBnCq95xZcrcakrbEqaZ1G6JMiaKn+pTpTGFBrSw9CAT
 91oa2XERahlLlqpV8VMm0QS8tptziqLPqdU3+jQq45xdbDLw4g26B01O8G9PkgXEBkYxNXi2CfE
 mc85dyxzgFB/wBjBPh0kEN9HaDc4FwRSQ25SkObRCYaStboeynzw51FRZV/pJz/aF6MJJlMUqNu aYQ0Cy79yRW6wZg==
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
Cc: cgroups@vger.kernel.org
Co-developed-by: Azeem Shaikh <azeemshaikh38@gmail.com>
Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
Link: https://lore.kernel.org/r/20231116192127.1558276-3-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/kernfs/dir.c           | 34 +++++++++++++++++-----------------
 kernel/cgroup/cgroup-v1.c |  2 +-
 kernel/cgroup/cgroup.c    |  4 ++--
 kernel/cgroup/cpuset.c    |  2 +-
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8c0e5442597e..8ec73f6cf6ec 100644
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
index 4b9ff41ca603..8d2674c6aaef 100644
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
@@ -6301,7 +6301,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
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
2.34.1


