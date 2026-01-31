Return-Path: <cgroups+bounces-13563-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCR0I+l0fWn+SAIAu9opvQ
	(envelope-from <cgroups+bounces-13563-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 04:20:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3499CC07BD
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 04:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14CD5300D145
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 03:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129A3349AFC;
	Sat, 31 Jan 2026 03:20:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383FB285073;
	Sat, 31 Jan 2026 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769829604; cv=none; b=ptznP25KsEH64bFUhPadZ7yugZubPWYE21NJUQqPnsO0Rr9vUlBcz0pZQcXMoFtReNVLkOv18L1Bn6m2CNktG4q1iHKgbGMjBxMk6oAP7H6LZ45G7UK4SqHw63X9KQ8Bsp5ciLosqmCns2VCzGGKTL/mOW3MJCIpTWTusHXVAAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769829604; c=relaxed/simple;
	bh=9PZnEZXXmh2yGqz5R6UhGQ+JSoncG562QrTlOaSQOu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dgEopoJ8oM4mjY13TDTiOOBfeTnb3PqkAh0VdkqalwdEL+t5TOr7304h+Xr08sPUsqyome6CyewUiOEa1AO0/FWryXyrFNQhBwIofYTMCfkaOplvoYstH7gx6Yi3pMTg/WlkxTMUaGOl3FVmnmQUBvHBu4bwt+Edd0gaLTEfNpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f2ylm6BGpzYQtk5;
	Sat, 31 Jan 2026 11:19:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 845F440577;
	Sat, 31 Jan 2026 11:19:58 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgB32PjWdH1prIflFg--.17344S2;
	Sat, 31 Jan 2026 11:19:58 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	inwardvessel@gmail.com,
	longman@redhat.com,
	shakeel.butt@linux.dev,
	chenridong@huawei.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next v2] cgroup: increase maximum subsystem count from 16 to 32
Date: Sat, 31 Jan 2026 03:05:09 +0000
Message-Id: <20260131030509.317315-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB32PjWdH1prIflFg--.17344S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJr15Ww4fCw48Xr4DKr4xtFb_yoWkWr4rpF
	nrCr17K3yFyFW5CF4Iya409F1fWws5Xw4UGrWDG34ftry7tr13XFn29Fy8XFy8ZF97Kw13
	Ar4Yyryjkr18tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-13563-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,goodmis.org,efficios.com,gmail.com,redhat.com,linux.dev,huawei.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3499CC07BD
X-Rspamd-Action: no action

From: Chen Ridong <chenridong@huawei.com>

The current cgroup subsystem limit of 16 is insufficient, as the number of
existing subsystems has already reached this limit. When adding a new
subsystem that is not yet in the mainline kernel, building with
`make allmodconfig` requires first bypassing the
`BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16)` restriction to allow compilation
to succeed. However, the kernel still fails to boot afterward.

This patch increases the maximum number of supported cgroup subsystems from
16 to 32, providing enough room for future subsystem additions.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
Acked-by: Waiman Long <longman@redhat.com>
Tested-by: JP Kobryn <inwardvessel@gmail.com>
Acked-by: JP Kobryn <inwardvessel@gmail.com>
---

V2: update commit memssge.

 include/linux/cgroup-defs.h     |  8 +++---
 include/trace/events/cgroup.h   |  2 +-
 kernel/cgroup/cgroup-internal.h |  8 +++---
 kernel/cgroup/cgroup-v1.c       | 12 ++++-----
 kernel/cgroup/cgroup.c          | 46 ++++++++++++++++-----------------
 kernel/cgroup/debug.c           |  2 +-
 6 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index f7cc60de0058..bb92f5c169ca 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -535,10 +535,10 @@ struct cgroup {
 	 * one which may have more subsystems enabled.  Controller knobs
 	 * are made available iff it's enabled in ->subtree_control.
 	 */
-	u16 subtree_control;
-	u16 subtree_ss_mask;
-	u16 old_subtree_control;
-	u16 old_subtree_ss_mask;
+	u32 subtree_control;
+	u32 subtree_ss_mask;
+	u32 old_subtree_control;
+	u32 old_subtree_ss_mask;
 
 	/* Private pointers for each registered subsystem */
 	struct cgroup_subsys_state __rcu *subsys[CGROUP_SUBSYS_COUNT];
diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index ba9229af9a34..b736da06340a 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -16,7 +16,7 @@ DECLARE_EVENT_CLASS(cgroup_root,
 
 	TP_STRUCT__entry(
 		__field(	int,		root			)
-		__field(	u16,		ss_mask			)
+		__field(	u32,		ss_mask			)
 		__string(	name,		root->name		)
 	),
 
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 22051b4f1ccb..3bfe37693d68 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -52,7 +52,7 @@ struct cgroup_fs_context {
 	bool		cpuset_clone_children;
 	bool		none;			/* User explicitly requested empty subsystem */
 	bool		all_ss;			/* Seen 'all' option */
-	u16		subsys_mask;		/* Selected subsystems */
+	u32		subsys_mask;		/* Selected subsystems */
 	char		*name;			/* Hierarchy name */
 	char		*release_agent;		/* Path for release notifications */
 };
@@ -146,7 +146,7 @@ struct cgroup_mgctx {
 	struct cgroup_taskset	tset;
 
 	/* subsystems affected by migration */
-	u16			ss_mask;
+	u32			ss_mask;
 };
 
 #define CGROUP_TASKSET_INIT(tset)						\
@@ -235,8 +235,8 @@ int cgroup_path_ns_locked(struct cgroup *cgrp, char *buf, size_t buflen,
 void cgroup_favor_dynmods(struct cgroup_root *root, bool favor);
 void cgroup_free_root(struct cgroup_root *root);
 void init_cgroup_root(struct cgroup_fs_context *ctx);
-int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask);
-int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask);
+int cgroup_setup_root(struct cgroup_root *root, u32 ss_mask);
+int rebind_subsystems(struct cgroup_root *dst_root, u32 ss_mask);
 int cgroup_do_get_tree(struct fs_context *fc);
 
 int cgroup_migrate_vet_dst(struct cgroup *dst_cgrp);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index a9e029b570c8..724950c4b690 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -28,7 +28,7 @@
 #define CGROUP_PIDLIST_DESTROY_DELAY	HZ
 
 /* Controllers blocked by the commandline in v1 */
-static u16 cgroup_no_v1_mask;
+static u32 cgroup_no_v1_mask;
 
 /* disable named v1 mounts */
 static bool cgroup_no_v1_named;
@@ -1037,13 +1037,13 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
 static int check_cgroupfs_options(struct fs_context *fc)
 {
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
-	u16 mask = U16_MAX;
-	u16 enabled = 0;
+	u32 mask = U32_MAX;
+	u32 enabled = 0;
 	struct cgroup_subsys *ss;
 	int i;
 
 #ifdef CONFIG_CPUSETS
-	mask = ~((u16)1 << cpuset_cgrp_id);
+	mask = ~((u32)1 << cpuset_cgrp_id);
 #endif
 	for_each_subsys(ss, i)
 		if (cgroup_ssid_enabled(i) && !cgroup1_ssid_disabled(i) &&
@@ -1095,7 +1095,7 @@ int cgroup1_reconfigure(struct fs_context *fc)
 	struct kernfs_root *kf_root = kernfs_root_from_sb(fc->root->d_sb);
 	struct cgroup_root *root = cgroup_root_from_kf(kf_root);
 	int ret = 0;
-	u16 added_mask, removed_mask;
+	u32 added_mask, removed_mask;
 
 	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
 
@@ -1343,7 +1343,7 @@ static int __init cgroup_no_v1(char *str)
 			continue;
 
 		if (!strcmp(token, "all")) {
-			cgroup_no_v1_mask = U16_MAX;
+			cgroup_no_v1_mask = U32_MAX;
 			continue;
 		}
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 94788bd1fdf0..8af4351536cf 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -203,13 +203,13 @@ EXPORT_SYMBOL_GPL(cgrp_dfl_root);
 bool cgrp_dfl_visible;
 
 /* some controllers are not supported in the default hierarchy */
-static u16 cgrp_dfl_inhibit_ss_mask;
+static u32 cgrp_dfl_inhibit_ss_mask;
 
 /* some controllers are implicitly enabled on the default hierarchy */
-static u16 cgrp_dfl_implicit_ss_mask;
+static u32 cgrp_dfl_implicit_ss_mask;
 
 /* some controllers can be threaded on the default hierarchy */
-static u16 cgrp_dfl_threaded_ss_mask;
+static u32 cgrp_dfl_threaded_ss_mask;
 
 /* The list of hierarchy roots */
 LIST_HEAD(cgroup_roots);
@@ -231,10 +231,10 @@ static u64 css_serial_nr_next = 1;
  * These bitmasks identify subsystems with specific features to avoid
  * having to do iterative checks repeatedly.
  */
-static u16 have_fork_callback __read_mostly;
-static u16 have_exit_callback __read_mostly;
-static u16 have_release_callback __read_mostly;
-static u16 have_canfork_callback __read_mostly;
+static u32 have_fork_callback __read_mostly;
+static u32 have_exit_callback __read_mostly;
+static u32 have_release_callback __read_mostly;
+static u32 have_canfork_callback __read_mostly;
 
 static bool have_favordynmods __ro_after_init = IS_ENABLED(CONFIG_CGROUP_FAVOR_DYNMODS);
 
@@ -472,13 +472,13 @@ static bool cgroup_is_valid_domain(struct cgroup *cgrp)
 }
 
 /* subsystems visibly enabled on a cgroup */
-static u16 cgroup_control(struct cgroup *cgrp)
+static u32 cgroup_control(struct cgroup *cgrp)
 {
 	struct cgroup *parent = cgroup_parent(cgrp);
-	u16 root_ss_mask = cgrp->root->subsys_mask;
+	u32 root_ss_mask = cgrp->root->subsys_mask;
 
 	if (parent) {
-		u16 ss_mask = parent->subtree_control;
+		u32 ss_mask = parent->subtree_control;
 
 		/* threaded cgroups can only have threaded controllers */
 		if (cgroup_is_threaded(cgrp))
@@ -493,12 +493,12 @@ static u16 cgroup_control(struct cgroup *cgrp)
 }
 
 /* subsystems enabled on a cgroup */
-static u16 cgroup_ss_mask(struct cgroup *cgrp)
+static u32 cgroup_ss_mask(struct cgroup *cgrp)
 {
 	struct cgroup *parent = cgroup_parent(cgrp);
 
 	if (parent) {
-		u16 ss_mask = parent->subtree_ss_mask;
+		u32 ss_mask = parent->subtree_ss_mask;
 
 		/* threaded cgroups can only have threaded controllers */
 		if (cgroup_is_threaded(cgrp))
@@ -1633,9 +1633,9 @@ static umode_t cgroup_file_mode(const struct cftype *cft)
  * This function calculates which subsystems need to be enabled if
  * @subtree_control is to be applied while restricted to @this_ss_mask.
  */
-static u16 cgroup_calc_subtree_ss_mask(u16 subtree_control, u16 this_ss_mask)
+static u32 cgroup_calc_subtree_ss_mask(u32 subtree_control, u32 this_ss_mask)
 {
-	u16 cur_ss_mask = subtree_control;
+	u32 cur_ss_mask = subtree_control;
 	struct cgroup_subsys *ss;
 	int ssid;
 
@@ -1644,7 +1644,7 @@ static u16 cgroup_calc_subtree_ss_mask(u16 subtree_control, u16 this_ss_mask)
 	cur_ss_mask |= cgrp_dfl_implicit_ss_mask;
 
 	while (true) {
-		u16 new_ss_mask = cur_ss_mask;
+		u32 new_ss_mask = cur_ss_mask;
 
 		do_each_subsys_mask(ss, ssid, cur_ss_mask) {
 			new_ss_mask |= ss->depends_on;
@@ -1848,12 +1848,12 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
 	return ret;
 }
 
-int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
+int rebind_subsystems(struct cgroup_root *dst_root, u32 ss_mask)
 {
 	struct cgroup *dcgrp = &dst_root->cgrp;
 	struct cgroup_subsys *ss;
 	int ssid, ret;
-	u16 dfl_disable_ss_mask = 0;
+	u32 dfl_disable_ss_mask = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -2149,7 +2149,7 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 		set_bit(CGRP_CPUSET_CLONE_CHILDREN, &root->cgrp.flags);
 }
 
-int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
+int cgroup_setup_root(struct cgroup_root *root, u32 ss_mask)
 {
 	LIST_HEAD(tmp_links);
 	struct cgroup *root_cgrp = &root->cgrp;
@@ -3131,7 +3131,7 @@ void cgroup_procs_write_finish(struct task_struct *task,
 	put_task_struct(task);
 }
 
-static void cgroup_print_ss_mask(struct seq_file *seq, u16 ss_mask)
+static void cgroup_print_ss_mask(struct seq_file *seq, u32 ss_mask)
 {
 	struct cgroup_subsys *ss;
 	bool printed = false;
@@ -3496,9 +3496,9 @@ static void cgroup_finalize_control(struct cgroup *cgrp, int ret)
 	cgroup_apply_control_disable(cgrp);
 }
 
-static int cgroup_vet_subtree_control_enable(struct cgroup *cgrp, u16 enable)
+static int cgroup_vet_subtree_control_enable(struct cgroup *cgrp, u32 enable)
 {
-	u16 domain_enable = enable & ~cgrp_dfl_threaded_ss_mask;
+	u32 domain_enable = enable & ~cgrp_dfl_threaded_ss_mask;
 
 	/* if nothing is getting enabled, nothing to worry about */
 	if (!enable)
@@ -3541,7 +3541,7 @@ static ssize_t cgroup_subtree_control_write(struct kernfs_open_file *of,
 					    char *buf, size_t nbytes,
 					    loff_t off)
 {
-	u16 enable = 0, disable = 0;
+	u32 enable = 0, disable = 0;
 	struct cgroup *cgrp, *child;
 	struct cgroup_subsys *ss;
 	char *tok;
@@ -6347,7 +6347,7 @@ int __init cgroup_init(void)
 	struct cgroup_subsys *ss;
 	int ssid;
 
-	BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16);
+	BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 32);
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup_base_files));
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup_psi_files));
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup1_base_files));
diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 81ea38dd6f9d..a5490097fe52 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -230,7 +230,7 @@ static int cgroup_subsys_states_read(struct seq_file *seq, void *v)
 }
 
 static void cgroup_masks_read_one(struct seq_file *seq, const char *name,
-				  u16 mask)
+				  u32 mask)
 {
 	struct cgroup_subsys *ss;
 	int ssid;
-- 
2.34.1


