Return-Path: <cgroups+bounces-108-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6F77DAB17
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 07:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BEC3281747
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 06:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17456AA0;
	Sun, 29 Oct 2023 06:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkqe8aFf"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64725256;
	Sun, 29 Oct 2023 06:14:56 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165A0CC;
	Sat, 28 Oct 2023 23:14:55 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2f2b9a176so2325179b6e.0;
        Sat, 28 Oct 2023 23:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698560094; x=1699164894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+GKCMm3ywxhq8MnvGKc+S0I8QLqm/LrvywuBerA5qs=;
        b=Gkqe8aFfMhWLoG3Qq76lKkt+nl3xNTnSDuL9xUzGJIA1Rc2+5Y+HMZeajLtGUvP7+K
         KxiRVxa7k25zPQYMEKGmmDahXnZxcAi51vT0UsVEWdNne1yV3y2nqG6+IqxZNCCydj9/
         UYC4g8hOsXoQ8SoveBfq0X4gFlvuj2DPltbct/nc7jlD1QtXBiU/i6dRaay9z34qDOV/
         I08s1TN4DAGqjpiHje4iuXD9hwPkvQPJvSmd+gk3DDMSGaTLSdtAthUp38QV/rU1k5Hl
         jnnkA57crGGclNOnF5CDtyVkIqeuzhzWxMW9YL4odi0FxoYg3JFVIUWvpuOW22chxzH4
         jGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698560094; x=1699164894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+GKCMm3ywxhq8MnvGKc+S0I8QLqm/LrvywuBerA5qs=;
        b=Rn623KJNg/zNw0KKwUB6+MfoCBYeRr/CqZe/MR0xN+9QDOQSu44AkiCBERJkgyt0Tm
         FA9h9cfb9r63kBd/HXd04FzTXHrcSdDUoMq2siFTR+Rc3YqzAk8A7RS4YYCGI7p05Cy9
         pXUnWAjgZ0N5HPoyfQCqXgSxkAID8lcY2NuGe1F+SlbdCQlGzrGI5Bz825J6QraWE7kf
         fBc3pt/iyKqD5nURZ8JXj5bpz2Ach93rTj5nq8WBvDzltS+ll5n+CfBdOoyVIGGESc3C
         ohclnoQipHonKYBqU+1WR63ySR53HiIVElquWFLU6Y1EuNOIEd3UNh7ebndMqjTyOCYu
         hMZA==
X-Gm-Message-State: AOJu0YwrDiDHtF3s+4U+UFo7xy/l5sYeUrraX6/ImNqG+Bb0ZoEOh5b9
	fRy4lqmyCw1zFf8MGeRsgaQ=
X-Google-Smtp-Source: AGHT+IHRWm5nG/sOfw5Ed/y+BCWmOfbUzZTasvwRvtOoHQuaMEtaT4lvfMMXF8bJVGfKohvAR4/oIA==
X-Received: by 2002:a05:6808:1243:b0:3ae:b06:2131 with SMTP id o3-20020a056808124300b003ae0b062131mr7995051oiv.0.1698560094374;
        Sat, 28 Oct 2023 23:14:54 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:2b5:5400:4ff:fea0:d066])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b006b225011ee5sm3775106pfo.6.2023.10.28.23.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 23:14:53 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	mkoutny@suse.com,
	sinquersw@gmail.com,
	longman@redhat.com
Cc: cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	oliver.sang@intel.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 05/11] cgroup: Add a new helper for cgroup1 hierarchy
Date: Sun, 29 Oct 2023 06:14:32 +0000
Message-Id: <20231029061438.4215-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231029061438.4215-1-laoar.shao@gmail.com>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new helper is added for cgroup1 hierarchy:

- task_get_cgroup1
  Acquires the associated cgroup of a task within a specific cgroup1
  hierarchy. The cgroup1 hierarchy is identified by its hierarchy ID.

This helper function is added to facilitate the tracing of tasks within
a particular container or cgroup dir in BPF programs. It's important to
note that this helper is designed specifically for cgroup1 only.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/cgroup.h          |  4 +++-
 kernel/cgroup/cgroup-internal.h |  1 -
 kernel/cgroup/cgroup-v1.c       | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b307013..e063e4c 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -71,6 +71,7 @@ struct css_task_iter {
 extern struct file_system_type cgroup_fs_type;
 extern struct cgroup_root cgrp_dfl_root;
 extern struct css_set init_css_set;
+extern spinlock_t css_set_lock;
 
 #define SUBSYS(_x) extern struct cgroup_subsys _x ## _cgrp_subsys;
 #include <linux/cgroup_subsys.h>
@@ -388,7 +389,6 @@ static inline void cgroup_unlock(void)
  * as locks used during the cgroup_subsys::attach() methods.
  */
 #ifdef CONFIG_PROVE_RCU
-extern spinlock_t css_set_lock;
 #define task_css_set_check(task, __c)					\
 	rcu_dereference_check((task)->cgroups,				\
 		rcu_read_lock_sched_held() ||				\
@@ -855,4 +855,6 @@ static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
 
 #endif /* CONFIG_CGROUP_BPF */
 
+struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id);
+
 #endif /* _LINUX_CGROUP_H */
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 5e17f01..520b90d 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -164,7 +164,6 @@ struct cgroup_mgctx {
 #define DEFINE_CGROUP_MGCTX(name)						\
 	struct cgroup_mgctx name = CGROUP_MGCTX_INIT(name)
 
-extern spinlock_t css_set_lock;
 extern struct cgroup_subsys *cgroup_subsys[];
 extern struct list_head cgroup_roots;
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index c487ffe..f41767f 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1263,6 +1263,39 @@ int cgroup1_get_tree(struct fs_context *fc)
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
+
+	rcu_read_lock();
+	for_each_root(root) {
+		/* cgroup1 only*/
+		if (root == &cgrp_dfl_root)
+			continue;
+		if (root->hierarchy_id != hierarchy_id)
+			continue;
+		spin_lock_irq(&css_set_lock);
+		cgrp = task_cgroup_from_root(tsk, root);
+		if (!cgrp || !cgroup_tryget(cgrp))
+			cgrp = ERR_PTR(-ENOENT);
+		spin_unlock_irq(&css_set_lock);
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
1.8.3.1


