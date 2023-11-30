Return-Path: <cgroups+bounces-726-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA557FFC13
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 21:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D317F1C21172
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 20:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926F853E25;
	Thu, 30 Nov 2023 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M6KzEFPj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1520D10FF
	for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 12:12:26 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cdcef8b400so1372582b3a.1
        for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 12:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701375145; x=1701979945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IEJcj+02yasaKEUc42BotZapgbr+U+1GTgkYNrat/0=;
        b=M6KzEFPj1ASFT9ypGtIUDfUdu//+jEiRO2GNgJ9yr2GxKLeZ15pwnSvgE0PfPnzmFz
         eX1WjXFhr+d/gXmfeXh5OaCVJetULE8LCPUIgiLayZcysTu1fKwUPEwibGNXrSpVw1Ub
         EtcAFKFwC1BP6qI4yXM+/YzK9h5WFZY43ucZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375145; x=1701979945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IEJcj+02yasaKEUc42BotZapgbr+U+1GTgkYNrat/0=;
        b=hdJ2q7kNRutxLhjPNr7zz8z37Q4T7Lms0VrZjhh23u+LXedkH+jzkAqVVNkMo3hFrF
         3oKrFjSY3yzNElbevLFDIs1mXWeWBWega9AlOEp21pY47+KLZwx83zw2aSoSExpbEuer
         WWk+6HgsvqUkEQhGA64nZjUQK2Nxwo7NKYu2oXXzSqPrvGw6aolw5O13U5jnNRPNbEm4
         T/o8i1FY53gGGo1YVXpsY1Y9faLI8L4U9cTT2yROH6JGJJ2Bh4KuLenu6DDVsPzktFBP
         IJ6EUM55R1TXslqYUNUiZd3t8xw6d83Ru/vn1zsRq1Lg+SxM5cnPrn6N0dUIWa0qIran
         sPEw==
X-Gm-Message-State: AOJu0YwaoNxl2xoNRzAzf8JyU+GEvKzodenGv502Tv602x9x/pH12Lgf
	ZJAQqzCOoVzWbQiNNpr+1CX8vg==
X-Google-Smtp-Source: AGHT+IGmS512gLfjsiC23DOsNKs0FlGwweZbgWh3YqWfge+zfCU0ht7v1xSRmXV1rEL8ZTHooy6pjQ==
X-Received: by 2002:a05:6a20:7350:b0:18d:4821:f754 with SMTP id v16-20020a056a20735000b0018d4821f754mr2376838pzc.55.1701375145632;
        Thu, 30 Nov 2023 12:12:25 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902d2c700b001cc52ca2dfbsm1800902plc.120.2023.11.30.12.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:12:25 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 3/3] kernfs: Convert kernfs_path_from_node_locked() from strlcpy() to strscpy()
Date: Thu, 30 Nov 2023 12:12:19 -0800
Message-Id: <20231130201222.3613535-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130200937.it.424-kees@kernel.org>
References: <20231130200937.it.424-kees@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8106; i=keescook@chromium.org;
 h=from:subject; bh=ytYczlvWwngfOAhKBEd29zggKM1dZYUFgsNew6TNfcc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlaOyjjwlnfJ6o+rRxKIqAd0jCo71AoDJUjPpjY
 YoJBoDBvPWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWjsowAKCRCJcvTf3G3A
 JkPUD/90GudFsO1LYNdR1bciTGcerJiWBv2OIofG6858EQVJUxJIy77PoKrYXozBwoPcfnsC+GD
 zy7am0RcN4EDnQdqH8l+VezpYkFjVdhE3VTSEGyD37n5L90dTTf4Ko7u6pC+fWt0db5mTotni+L
 ozR/VRxweZuhlkxvb3pvfmBUF3qrnomBRIs6T3FFK3iy87pwtW7dDKpHs+AZNfopDZIrdxaXmGL
 H9yEGTdMxCk7RqGWS8ZPJBtMLtUuEGDmwpCiC9KcxIhMnKPx8J05OLUXizl38IrKn1me65Rqivv
 UUpZolnF6jUmpNvKLG/kn0KCZAqtZm74QZFet4VH/k+qsHfZv+gG5oBVDHUcuwhWrSbiTYEjRoH
 GoSqPQE4lwwx3p1I0xUa9samPc/0lnKVbi5O6TIIxjAa4HmO/KTDFOnZCHmbGJUfbjvMzKVEK9Y
 tJpiiqkWffLMWl4QrwD8+ws8E5HP3l3hRX6o58VH64Nb3hV8jlvZlt8tCKreY+gRsRNedQVvNgZ
 aOL8Tr7PqUhRqe95IHxKpun7DKTZrM6+0hWER/rHNQqtfIJueAMQMOrPyHwklNqZajUEjLr1UHe
 32zNNc/W45HOmSB32VYD2gHGvlwnS1+jONUOIj9zOxZVr0hT9NMwZbKeW65j/9nD+WsAZdPHoFx MLC/0IKHoha7fNA==
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
 fs/kernfs/dir.c           | 37 ++++++++++++++++++++-----------------
 kernel/cgroup/cgroup-v1.c |  2 +-
 kernel/cgroup/cgroup.c    |  4 ++--
 kernel/cgroup/cpuset.c    |  2 +-
 4 files changed, 24 insertions(+), 21 deletions(-)

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


