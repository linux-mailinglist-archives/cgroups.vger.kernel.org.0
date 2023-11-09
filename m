Return-Path: <cgroups+bounces-300-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A0D7E7528
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 00:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42011C209DE
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 23:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32DD38FA6;
	Thu,  9 Nov 2023 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YivSktR6"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0DE374E0;
	Thu,  9 Nov 2023 23:30:20 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AE01727;
	Thu,  9 Nov 2023 15:30:19 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-28003daaaa6so1288261a91.0;
        Thu, 09 Nov 2023 15:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699572619; x=1700177419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzWizreQuKAz/UNGsGC3KN3uOwl/h0p9EJebFq0ac0g=;
        b=YivSktR6Qd1w1GEYClDb5i0sv0ZWsB+TQ6+GpfSUcr3JIzBWFTXmsvIIifWbaj/sXU
         Oiocu70c5Bb/RjfQ+PMJIZLsrxh0pWk5AaKuuT7WZUXsSmIQWDYnFvtKb8Fr0DmPt8yT
         Q0WFdB8hIB8twtOAGurRghX/DQU643C6lLCn1GtP89+KFGpWPoNqjHKVsCpFY+32iCVM
         uV5KI9qgcJAYCTM3AQptqWED0fenqsBX7yxZzwH1tdQpJnj6GckZpjYVv/729WICYMYc
         1xdJ06kwHHA6W56a0lrcDp+oN+BZI+heGQ7X8c8FnJUqkIyrQMPY8lZmEV22ku6TxBc1
         KMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699572619; x=1700177419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzWizreQuKAz/UNGsGC3KN3uOwl/h0p9EJebFq0ac0g=;
        b=qSq8BLcadFkFzi8gxAAZyWl/mVBDKQ+orehMxAhOxv1+XDOfgxVI2z3pI7ynsqZ9Z4
         HZiBzKClLRmeWrFH+yG5aypSksrk/qBXI01iXmCQFeqekE6inB/F2GHUoGpyZH+G35pb
         nPlvQmRGkYwd+6xsIOKOGUYLlgtNJeWnrB9ivbmcI0snlo7QnXCXFbg1p92wiRpGgQwJ
         OQsOgZeF0CuzaBhUxMd6hVQ09S3Theh8BVKKqraEhlkVBKuMzDOJnqjlaBwM1n6xIsn9
         2M7sTBzaAtQUXZifupXPULABZ3WMLLknTOOiIQK+23aTT5NgfB8WQVKLVQ+Odt+Q+wUx
         LzFA==
X-Gm-Message-State: AOJu0Ywc/2i5dA8i0T4+F+3ox6/qhJ792QofyOqK2B2OjUQmtorbni8Z
	6ank5XF8AIfk3yPY2xXoHnE=
X-Google-Smtp-Source: AGHT+IEaB9V7pPlJC2nCZz1fwZM7aHlTmYtIF+zC/feNQ0H6CvSWEJ60qS/MkknKeGYDbMh0Kyu+Yg==
X-Received: by 2002:a17:90a:bf0b:b0:280:682d:cb2 with SMTP id c11-20020a17090abf0b00b00280682d0cb2mr3369010pjs.1.1699572619033;
        Thu, 09 Nov 2023 15:30:19 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id 15-20020a17090a030f00b0027d0c3507fcsm396004pje.9.2023.11.09.15.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 15:30:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Nov 2023 13:30:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, longman@redhat.com, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH v3 bpf-next 05/11] cgroup: Add a new helper for cgroup1
 hierarchy
Message-ID: <ZU1riY0lCI3YkAqg@slm.duckdns.org>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
 <20231029061438.4215-6-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029061438.4215-6-laoar.shao@gmail.com>

Hello,

The following is the version updated to use irqsave/restore applied to
cgroup/for-6.8-bpf.

Thanks.
--- 8< ---
From aecd408b7e50742868b3305c24325a89024e2a30 Mon Sep 17 00:00:00 2001
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 29 Oct 2023 06:14:32 +0000
Subject: [PATCH] cgroup: Add a new helper for cgroup1 hierarchy

A new helper is added for cgroup1 hierarchy:

- task_get_cgroup1
  Acquires the associated cgroup of a task within a specific cgroup1
  hierarchy. The cgroup1 hierarchy is identified by its hierarchy ID.

This helper function is added to facilitate the tracing of tasks within
a particular container or cgroup dir in BPF programs. It's important to
note that this helper is designed specifically for cgroup1 only.

tj: Use irsqsave/restore as suggested by Hou Tao <houtao@huaweicloud.com>.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup.h          |  4 +++-
 kernel/cgroup/cgroup-internal.h |  1 -
 kernel/cgroup/cgroup-v1.c       | 34 +++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 0ef0af66080e..34aaf0e87def 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -69,6 +69,7 @@ struct css_task_iter {
 extern struct file_system_type cgroup_fs_type;
 extern struct cgroup_root cgrp_dfl_root;
 extern struct css_set init_css_set;
+extern spinlock_t css_set_lock;
 
 #define SUBSYS(_x) extern struct cgroup_subsys _x ## _cgrp_subsys;
 #include <linux/cgroup_subsys.h>
@@ -386,7 +387,6 @@ static inline void cgroup_unlock(void)
  * as locks used during the cgroup_subsys::attach() methods.
  */
 #ifdef CONFIG_PROVE_RCU
-extern spinlock_t css_set_lock;
 #define task_css_set_check(task, __c)					\
 	rcu_dereference_check((task)->cgroups,				\
 		rcu_read_lock_sched_held() ||				\
@@ -853,4 +853,6 @@ static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
 
 #endif /* CONFIG_CGROUP_BPF */
 
+struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id);
+
 #endif /* _LINUX_CGROUP_H */
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 5e17f01ced9f..520b90dd97ec 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -164,7 +164,6 @@ struct cgroup_mgctx {
 #define DEFINE_CGROUP_MGCTX(name)						\
 	struct cgroup_mgctx name = CGROUP_MGCTX_INIT(name)
 
-extern spinlock_t css_set_lock;
 extern struct cgroup_subsys *cgroup_subsys[];
 extern struct list_head cgroup_roots;
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 76db6c67e39a..04d11a7dd95f 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1262,6 +1262,40 @@ int cgroup1_get_tree(struct fs_context *fc)
 	return ret;
 }
 
+/**
+ * task_get_cgroup1 - Acquires the associated cgroup of a task within a
+ * specific cgroup1 hierarchy. The cgroup1 hierarchy is identified by its
+ * hierarchy ID.
+ * @tsk: The target task
+ * @hierarchy_id: The ID of a cgroup1 hierarchy
+ *
+ * On success, the cgroup is returned. On failure, ERR_PTR is returned.
+ * We limit it to cgroup1 only.
+ */
+struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id)
+{
+	struct cgroup *cgrp = ERR_PTR(-ENOENT);
+	struct cgroup_root *root;
+	unsigned long flags;
+
+	rcu_read_lock();
+	for_each_root(root) {
+		/* cgroup1 only*/
+		if (root == &cgrp_dfl_root)
+			continue;
+		if (root->hierarchy_id != hierarchy_id)
+			continue;
+		spin_lock_irqsave(&css_set_lock, flags);
+		cgrp = task_cgroup_from_root(tsk, root);
+		if (!cgrp || !cgroup_tryget(cgrp))
+			cgrp = ERR_PTR(-ENOENT);
+		spin_unlock_irqrestore(&css_set_lock, flags);
+		break;
+	}
+	rcu_read_unlock();
+	return cgrp;
+}
+
 static int __init cgroup1_wq_init(void)
 {
 	/*
-- 
2.42.0


