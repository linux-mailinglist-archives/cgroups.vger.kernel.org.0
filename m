Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7B257EFA5
	for <lists+cgroups@lfdr.de>; Sat, 23 Jul 2022 16:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbiGWO2g (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Jul 2022 10:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiGWO2f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Jul 2022 10:28:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0D13F9C;
        Sat, 23 Jul 2022 07:28:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d10so6689916pfd.9;
        Sat, 23 Jul 2022 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iXTEGIWZmjgwfsJ/RdqwpvQ7Oe1IR7cF5Wjfs1PckEA=;
        b=h9PL3fbnsUBo/gnY69vnKa0otkR5ryMB3SgIyfWBCDml8ASbNc4zGdsX9BXKE6Z3Go
         eDroGnkHR+2lW1V5+7abkPqDIMGThijkEj4lVifGrMlhmucXmx7cA6sKJaLTLwZIO4UP
         ZFFfMKs/S+EVxTUT0hwc0nPmd/SQm825cTwb+y5nnuQWqm5o893SdsL8IT2MuEd/APiy
         KmSJ6MaHxwaAix1kX/cyjOnsSwiz+tXLA2jBnsa+9Q6kE1ewTmMKhpAJ2TiRHImCgPpN
         SXcxNW8bV6Y0ZRXjRjRkcIdTTayHMo4bwt9UknTtThI1o9cUb5+Z2BKj3keeMGorRVDd
         85JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=iXTEGIWZmjgwfsJ/RdqwpvQ7Oe1IR7cF5Wjfs1PckEA=;
        b=4U5naBswJRR+1IpuXa20e7g7mkKuypOgxJfnoZ1VItKIGlKmQJtJ/czawauIpnpfZ4
         4YhYgnlMSCOEXR0QCFPWknhuTwtO+AyL3H21wRdtnCG/hOdc4Ig4ecwhDrCHzCP2icTu
         j2Dynv3LGTVvjZMSiy+fdC/tXVc98Dqs3zZRIl7mRhZV+Myw77A1T4eXQuk8pCZb4wjT
         azzl4KTlxFkA/QvncwMbPDpE9c3qc+YWXs9dIClBLiwzTh/0dAfmiWk7bGuCJCbVCnie
         W4YKRQ54LSB+cUXTMIybgzKYLcVoPCMWutZAW3k3mnsltIJb7xMFSo4psp2BuIUOJz/v
         jLuw==
X-Gm-Message-State: AJIora9jeA98Hd8N9MB8uTm3l0B1H4urFXmmlqwv9TtNAhFNEZ/AyWjE
        su5CPDXiNFbtIqsFRV9+FJJX+1GwQWM=
X-Google-Smtp-Source: AGRyM1uRGxogbvVk24HhZIl2nQdlX0mV2bFdci76PnpMQuoiUt4lLLBSWcBbvYfwouYz07wo59FeJA==
X-Received: by 2002:a63:d5:0:b0:41a:58f:929e with SMTP id 204-20020a6300d5000000b0041a058f929emr4077256pga.260.1658586510549;
        Sat, 23 Jul 2022 07:28:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:d97e])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902ccc100b0016d42244871sm3357453ple.6.2022.07.23.07.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 07:28:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 23 Jul 2022 04:28:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH RESEND 3/3 cgroup/for-5.20] cgroup: Make !percpu
 threadgroup_rwsem operations optional
Message-ID: <YtwFjPnCtw8ySnuv@slm.duckdns.org>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
 <YtDvU4jRPSsarcNp@slm.duckdns.org>
 <YtDvl7Qjc5zI3e/b@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtDvl7Qjc5zI3e/b@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

3942a9bd7b58 ("locking, rcu, cgroup: Avoid synchronize_sched() in
__cgroup_procs_write()") disabled percpu operations on threadgroup_rwsem
because the impiled synchronize_rcu() on write locking was pushing up the
latencies too much for android which constantly moves processes between
cgroups.

This makes the hotter paths - fork and exit - slower as they're always
forced into the slow path. There is no reason to force this on everyone
especially given that more common static usage pattern can now completely
avoid write-locking the rwsem. Write-locking is elided when turning on and
off controllers on empty sub-trees and CLONE_INTO_CGROUP enables seeding a
cgroup without grabbing the rwsem.

Restore the default percpu operations and introduce the mount option
"favordynmods" and config option CGROUP_FAVOR_DYNMODS for users who need
lower latencies for the dynamic operations.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Michal Koutný <mkoutny@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Dmitry Shmidt <dimitrysh@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>
---
I messed up patch generation and the patch was missing diffs for a few
files.

Thanks.

 Documentation/admin-guide/cgroup-v2.rst |    8 +++++
 include/linux/cgroup-defs.h             |   19 +++++++++++---
 init/Kconfig                            |   10 +++++++
 kernel/cgroup/cgroup-internal.h         |    1 
 kernel/cgroup/cgroup-v1.c               |   17 +++++++++++-
 kernel/cgroup/cgroup.c                  |   43 ++++++++++++++++++++++++++------
 6 files changed, 87 insertions(+), 11 deletions(-)

--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -184,6 +184,14 @@ cgroup v2 currently supports the followi
 	ignored on non-init namespace mounts.  Please refer to the
 	Delegation section for details.
 
+  [no]favordynmods
+        Reduce the latencies of dynamic cgroup modifications such as
+        task migrations and controller on/offs at the cost of making
+        hot path operations such as forks and exits more expensive.
+        The static usage pattern of creating a cgroup, enabling
+        controllers, and then seeding it with CLONE_INTO_CGROUP is
+        not affected by this option.
+
   memory_[no]localevents
         Only populate memory.events with data for the current cgroup,
         and not any subtrees. This is legacy behaviour, the default
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -89,19 +89,32 @@ enum {
 	CGRP_ROOT_NS_DELEGATE	= (1 << 3),
 
 	/*
+	 * Reduce latencies on dynamic cgroup modifications such as task
+	 * migrations and controller on/offs by disabling percpu operation on
+	 * cgroup_threadgroup_rwsem. This makes hot path operations such as
+	 * forks and exits into the slow path and more expensive.
+	 *
+	 * The static usage pattern of creating a cgroup, enabling controllers,
+	 * and then seeding it with CLONE_INTO_CGROUP doesn't require write
+	 * locking cgroup_threadgroup_rwsem and thus doesn't benefit from
+	 * favordynmod.
+	 */
+	CGRP_ROOT_FAVOR_DYNMODS = (1 << 4),
+
+	/*
 	 * Enable cpuset controller in v1 cgroup to use v2 behavior.
 	 */
-	CGRP_ROOT_CPUSET_V2_MODE = (1 << 4),
+	CGRP_ROOT_CPUSET_V2_MODE = (1 << 16),
 
 	/*
 	 * Enable legacy local memory.events.
 	 */
-	CGRP_ROOT_MEMORY_LOCAL_EVENTS = (1 << 5),
+	CGRP_ROOT_MEMORY_LOCAL_EVENTS = (1 << 17),
 
 	/*
 	 * Enable recursive subtree protection
 	 */
-	CGRP_ROOT_MEMORY_RECURSIVE_PROT = (1 << 6),
+	CGRP_ROOT_MEMORY_RECURSIVE_PROT = (1 << 18),
 };
 
 /* cftype->flags */
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -936,6 +936,16 @@ if CGROUPS
 config PAGE_COUNTER
 	bool
 
+config CGROUP_FAVOR_DYNMODS
+        bool "Favor dynamic modification latency reduction by default"
+        help
+          This option enables the "favordynmods" mount option by default
+          which reduces the latencies of dynamic cgroup modifications such
+          as task migrations and controller on/offs at the cost of making
+          hot path operations such as forks and exits more expensive.
+
+          Say N if unsure.
+
 config MEMCG
 	bool "Memory controller"
 	select PAGE_COUNTER
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -233,6 +233,7 @@ void cgroup_kn_unlock(struct kernfs_node
 int cgroup_path_ns_locked(struct cgroup *cgrp, char *buf, size_t buflen,
 			  struct cgroup_namespace *ns);
 
+void cgroup_favor_dynmods(struct cgroup_root *root, bool favor);
 void cgroup_free_root(struct cgroup_root *root);
 void init_cgroup_root(struct cgroup_fs_context *ctx);
 int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask);
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -875,6 +875,8 @@ static int cgroup1_show_options(struct s
 		seq_puts(seq, ",xattr");
 	if (root->flags & CGRP_ROOT_CPUSET_V2_MODE)
 		seq_puts(seq, ",cpuset_v2_mode");
+	if (root->flags & CGRP_ROOT_FAVOR_DYNMODS)
+		seq_puts(seq, ",favordynmods");
 
 	spin_lock(&release_agent_path_lock);
 	if (strlen(root->release_agent_path))
@@ -898,6 +900,8 @@ enum cgroup1_param {
 	Opt_noprefix,
 	Opt_release_agent,
 	Opt_xattr,
+	Opt_favordynmods,
+	Opt_nofavordynmods,
 };
 
 const struct fs_parameter_spec cgroup1_fs_parameters[] = {
@@ -909,6 +913,8 @@ const struct fs_parameter_spec cgroup1_f
 	fsparam_flag  ("noprefix",	Opt_noprefix),
 	fsparam_string("release_agent",	Opt_release_agent),
 	fsparam_flag  ("xattr",		Opt_xattr),
+	fsparam_flag  ("favordynmods",	Opt_favordynmods),
+	fsparam_flag  ("nofavordynmods", Opt_nofavordynmods),
 	{}
 };
 
@@ -960,6 +966,12 @@ int cgroup1_parse_param(struct fs_contex
 	case Opt_xattr:
 		ctx->flags |= CGRP_ROOT_XATTR;
 		break;
+	case Opt_favordynmods:
+		ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
+		break;
+	case Opt_nofavordynmods:
+		ctx->flags &= ~CGRP_ROOT_FAVOR_DYNMODS;
+		break;
 	case Opt_release_agent:
 		/* Specifying two release agents is forbidden */
 		if (ctx->release_agent)
@@ -1211,8 +1223,11 @@ static int cgroup1_root_to_use(struct fs
 	init_cgroup_root(ctx);
 
 	ret = cgroup_setup_root(root, ctx->subsys_mask);
-	if (ret)
+	if (!ret)
+		cgroup_favor_dynmods(root, ctx->flags & CGRP_ROOT_FAVOR_DYNMODS);
+	else
 		cgroup_free_root(root);
+
 	return ret;
 }
 
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1305,6 +1305,20 @@ struct cgroup_root *cgroup_root_from_kf(
 	return root_cgrp->root;
 }
 
+void cgroup_favor_dynmods(struct cgroup_root *root, bool favor)
+{
+	bool favoring = root->flags & CGRP_ROOT_FAVOR_DYNMODS;
+
+	/* see the comment above CGRP_ROOT_FAVOR_DYNMODS definition */
+	if (favor && !favoring) {
+		rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
+		root->flags |= CGRP_ROOT_FAVOR_DYNMODS;
+	} else if (!favor && favoring) {
+		rcu_sync_exit(&cgroup_threadgroup_rwsem.rss);
+		root->flags &= ~CGRP_ROOT_FAVOR_DYNMODS;
+	}
+}
+
 static int cgroup_init_root_id(struct cgroup_root *root)
 {
 	int id;
@@ -1365,6 +1379,7 @@ static void cgroup_destroy_root(struct c
 		cgroup_root_count--;
 	}
 
+	cgroup_favor_dynmods(root, false);
 	cgroup_exit_root_id(root);
 
 	mutex_unlock(&cgroup_mutex);
@@ -1858,6 +1873,7 @@ int cgroup_show_path(struct seq_file *sf
 
 enum cgroup2_param {
 	Opt_nsdelegate, Opt_nonsdelegate,
+	Opt_favordynmods, Opt_nofavordynmods,
 	Opt_memory_localevents, Opt_memory_nolocalevents,
 	Opt_memory_recursiveprot, Opt_memory_norecursiveprot,
 	nr__cgroup2_params
@@ -1866,6 +1882,8 @@ enum cgroup2_param {
 static const struct fs_parameter_spec cgroup2_fs_parameters[] = {
 	fsparam_flag("nsdelegate",		Opt_nsdelegate),
 	fsparam_flag("nonsdelegate",		Opt_nonsdelegate),
+	fsparam_flag("favordynmods",		Opt_favordynmods),
+	fsparam_flag("nofavordynmods",		Opt_nofavordynmods),
 	fsparam_flag("memory_localevents",	Opt_memory_localevents),
 	fsparam_flag("memory_nolocalevents",	Opt_memory_nolocalevents),
 	fsparam_flag("memory_recursiveprot",	Opt_memory_recursiveprot),
@@ -1890,6 +1908,12 @@ static int cgroup2_parse_param(struct fs
 	case Opt_nonsdelegate:
 		ctx->flags &= ~CGRP_ROOT_NS_DELEGATE;
 		return 0;
+	case Opt_favordynmods:
+		ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
+		return 0;
+	case Opt_nofavordynmods:
+		ctx->flags &= ~CGRP_ROOT_FAVOR_DYNMODS;
+		return 0;
 	case Opt_memory_localevents:
 		ctx->flags |= CGRP_ROOT_MEMORY_LOCAL_EVENTS;
 		return 0;
@@ -1914,6 +1938,9 @@ static void apply_cgroup_root_flags(unsi
 		else
 			cgrp_dfl_root.flags &= ~CGRP_ROOT_NS_DELEGATE;
 
+		cgroup_favor_dynmods(&cgrp_dfl_root,
+				     root_flags & CGRP_ROOT_FAVOR_DYNMODS);
+
 		if (root_flags & CGRP_ROOT_MEMORY_LOCAL_EVENTS)
 			cgrp_dfl_root.flags |= CGRP_ROOT_MEMORY_LOCAL_EVENTS;
 		else
@@ -1930,6 +1957,8 @@ static int cgroup_show_options(struct se
 {
 	if (cgrp_dfl_root.flags & CGRP_ROOT_NS_DELEGATE)
 		seq_puts(seq, ",nsdelegate");
+	if (cgrp_dfl_root.flags & CGRP_ROOT_FAVOR_DYNMODS)
+		seq_puts(seq, ",favordynmods");
 	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_LOCAL_EVENTS)
 		seq_puts(seq, ",memory_localevents");
 	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT)
@@ -1980,7 +2009,8 @@ void init_cgroup_root(struct cgroup_fs_c
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
 
-	root->flags = ctx->flags;
+	/* DYNMODS must be modified through cgroup_favor_dynmods() */
+	root->flags = ctx->flags & ~CGRP_ROOT_FAVOR_DYNMODS;
 	if (ctx->release_agent)
 		strscpy(root->release_agent_path, ctx->release_agent, PATH_MAX);
 	if (ctx->name)
@@ -2202,6 +2232,10 @@ static int cgroup_init_fs_context(struct
 	put_user_ns(fc->user_ns);
 	fc->user_ns = get_user_ns(ctx->ns->user_ns);
 	fc->global = true;
+
+#ifdef CONFIG_CGROUP_FAVOR_DYNMODS
+	ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
+#endif
 	return 0;
 }
 
@@ -5854,12 +5888,6 @@ int __init cgroup_init(void)
 
 	cgroup_rstat_boot();
 
-	/*
-	 * The latency of the synchronize_rcu() is too high for cgroups,
-	 * avoid it at the cost of forcing all readers into the slow path.
-	 */
-	rcu_sync_enter_start(&cgroup_threadgroup_rwsem.rss);
-
 	get_user_ns(init_cgroup_ns.user_ns);
 
 	mutex_lock(&cgroup_mutex);
@@ -6771,6 +6799,7 @@ static ssize_t features_show(struct kobj
 {
 	return snprintf(buf, PAGE_SIZE,
 			"nsdelegate\n"
+			"favordynmods\n"
 			"memory_localevents\n"
 			"memory_recursiveprot\n");
 }
