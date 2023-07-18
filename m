Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0F475713D
	for <lists+cgroups@lfdr.de>; Tue, 18 Jul 2023 03:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGRBJI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 21:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGRBJG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 21:09:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29395E2;
        Mon, 17 Jul 2023 18:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689642545; x=1721178545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9girh5GPhN5YgqyPJQ4IkQZyQxbkf5IJkL20eKANKd8=;
  b=YkXcM8NorNSyTI24EeTCUMOW3CGbmQLkwOW5T5IuXN/E0tD4yaq3AJTm
   hJQivE7A8IiivrRD+tYvzi7h/VPSpQQsiRIm6w2pF72kqLntISdcnQ2pn
   t17wPMcUNzjVaiEyTHEMABm1m0e18ea00qvDt0KUvRC7hOtMK1KC0pO1R
   B+Vw3UIb/q+1GetEfjQv4n0Pf43wRZRTyHazGqcah4eChZkyuAxajn16t
   NGajQyxXMQO+Yi5vN+4YQKCJXmqAFSyKHPi2Iq8lePbjaOjsgGFKS0wZs
   j6sYCZN+hY1x4jhTfmpK/02Kcdk3NZ1znLLwdz5vFuJhSTT9AiiOsfB4y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432255253"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432255253"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 18:08:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793437557"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793437557"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2023 18:08:46 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     tj@kernel.org, jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     vipinsh@google.com, kai.huang@intel.com, reinette.chatre@intel.com,
        zhiquan1.li@intel.com, kristen@linux.intel.com
Subject: [PATCH 2/2] cgroup/misc: Change counters to be explicit 64bit types
Date:   Mon, 17 Jul 2023 18:08:45 -0700
Message-Id: <20230718010845.35197-2-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718010845.35197-1-haitao.huang@linux.intel.com>
References: <ZLWmdBfcuPUBtk1K@slm.duckdns.org>
 <20230718010845.35197-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

So the variables can account for resources of huge quantities even on
32-bit machines.

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
 include/linux/misc_cgroup.h | 22 +++++++--------
 kernel/cgroup/misc.c        | 53 +++++++++++++++++++------------------
 2 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index c238207d1615..2751cf12796d 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -34,9 +34,9 @@ struct misc_cg;
  * @failed: True if charged failed for the resource in a cgroup.
  */
 struct misc_res {
-	unsigned long max;
-	atomic_long_t usage;
-	atomic_long_t events;
+	u64 max;
+	atomic64_t usage;
+	atomic64_t events;
 };
 
 /**
@@ -53,12 +53,12 @@ struct misc_cg {
 	struct misc_res res[MISC_CG_RES_TYPES];
 };
 
-unsigned long misc_cg_res_total_usage(enum misc_res_type type);
-int misc_cg_set_capacity(enum misc_res_type type, unsigned long capacity);
+u64 misc_cg_res_total_usage(enum misc_res_type type);
+int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
-		       unsigned long amount);
+		       u64 amount);
 void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg,
-		      unsigned long amount);
+		      u64 amount);
 
 /**
  * css_misc() - Get misc cgroup from the css.
@@ -99,27 +99,27 @@ static inline void put_misc_cg(struct misc_cg *cg)
 
 #else /* !CONFIG_CGROUP_MISC */
 
-static inline unsigned long misc_cg_res_total_usage(enum misc_res_type type)
+static inline u64 misc_cg_res_total_usage(enum misc_res_type type)
 {
 	return 0;
 }
 
 static inline int misc_cg_set_capacity(enum misc_res_type type,
-				       unsigned long capacity)
+				       u64 capacity)
 {
 	return 0;
 }
 
 static inline int misc_cg_try_charge(enum misc_res_type type,
 				     struct misc_cg *cg,
-				     unsigned long amount)
+				     u64 amount)
 {
 	return 0;
 }
 
 static inline void misc_cg_uncharge(enum misc_res_type type,
 				    struct misc_cg *cg,
-				    unsigned long amount)
+				    u64 amount)
 {
 }
 
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index b127607837c6..c4546e99cde4 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -14,7 +14,7 @@
 #include <linux/misc_cgroup.h>
 
 #define MAX_STR "max"
-#define MAX_NUM ULONG_MAX
+#define MAX_NUM U64_MAX
 
 /* Miscellaneous res name, keep it in sync with enum misc_res_type */
 static const char *const misc_res_name[] = {
@@ -37,7 +37,7 @@ static struct misc_cg root_cg;
  * more than the actual capacity. We are using Limits resource distribution
  * model of cgroup for miscellaneous controller.
  */
-static unsigned long misc_res_capacity[MISC_CG_RES_TYPES];
+static u64 misc_res_capacity[MISC_CG_RES_TYPES];
 
 /**
  * parent_misc() - Get the parent of the passed misc cgroup.
@@ -74,10 +74,10 @@ static inline bool valid_type(enum misc_res_type type)
  * Context: Any context.
  * Return: Current total usage of the resource.
  */
-unsigned long misc_cg_res_total_usage(enum misc_res_type type)
+u64 misc_cg_res_total_usage(enum misc_res_type type)
 {
 	if (valid_type(type))
-		return atomic_long_read(&root_cg.res[type].usage);
+		return atomic64_read(&root_cg.res[type].usage);
 
 	return 0;
 }
@@ -95,7 +95,7 @@ EXPORT_SYMBOL_GPL(misc_cg_res_total_usage);
  * * %0 - Successfully registered the capacity.
  * * %-EINVAL - If @type is invalid.
  */
-int misc_cg_set_capacity(enum misc_res_type type, unsigned long capacity)
+int misc_cg_set_capacity(enum misc_res_type type, u64 capacity)
 {
 	if (!valid_type(type))
 		return -EINVAL;
@@ -114,9 +114,9 @@ EXPORT_SYMBOL_GPL(misc_cg_set_capacity);
  * Context: Any context.
  */
 static void misc_cg_cancel_charge(enum misc_res_type type, struct misc_cg *cg,
-				  unsigned long amount)
+				  u64 amount)
 {
-	WARN_ONCE(atomic_long_add_negative(-amount, &cg->res[type].usage),
+	WARN_ONCE(atomic64_add_negative(-amount, &cg->res[type].usage),
 		  "misc cgroup resource %s became less than 0",
 		  misc_res_name[type]);
 }
@@ -138,12 +138,12 @@ static void misc_cg_cancel_charge(enum misc_res_type type, struct misc_cg *cg,
  *	      capacity.
  */
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
-		       unsigned long amount)
+		       u64 amount)
 {
 	struct misc_cg *i, *j;
 	int ret;
 	struct misc_res *res;
-	long new_usage;
+	s64 new_usage;
 
 	if (!(valid_type(type) && cg && READ_ONCE(misc_res_capacity[type])))
 		return -EINVAL;
@@ -154,7 +154,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 	for (i = cg; i; i = parent_misc(i)) {
 		res = &i->res[type];
 
-		new_usage = atomic_long_add_return(amount, &res->usage);
+		new_usage = atomic64_add_return(amount, &res->usage);
 		if (new_usage > READ_ONCE(res->max) ||
 		    new_usage > READ_ONCE(misc_res_capacity[type]) ||
 		    new_usage < 0) {
@@ -166,7 +166,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 
 err_charge:
 	for (j = i; j; j = parent_misc(j)) {
-		atomic_long_inc(&j->res[type].events);
+		atomic64_inc(&j->res[type].events);
 		cgroup_file_notify(&j->events_file);
 	}
 
@@ -186,7 +186,7 @@ EXPORT_SYMBOL_GPL(misc_cg_try_charge);
  * Context: Any context.
  */
 void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg,
-		      unsigned long amount)
+		      u64 amount)
 {
 	struct misc_cg *i;
 
@@ -210,7 +210,7 @@ static int misc_cg_max_show(struct seq_file *sf, void *v)
 {
 	int i;
 	struct misc_cg *cg = css_misc(seq_css(sf));
-	unsigned long max;
+	u64 max;
 
 	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
 		if (READ_ONCE(misc_res_capacity[i])) {
@@ -218,7 +218,7 @@ static int misc_cg_max_show(struct seq_file *sf, void *v)
 			if (max == MAX_NUM)
 				seq_printf(sf, "%s max\n", misc_res_name[i]);
 			else
-				seq_printf(sf, "%s %lu\n", misc_res_name[i],
+				seq_printf(sf, "%s %llu\n", misc_res_name[i],
 					   max);
 		}
 	}
@@ -242,13 +242,13 @@ static int misc_cg_max_show(struct seq_file *sf, void *v)
  * Return:
  * * >= 0 - Number of bytes processed in the input.
  * * -EINVAL - If buf is not valid.
- * * -ERANGE - If number is bigger than the unsigned long capacity.
+ * * -ERANGE - If number is bigger than the u64 capacity.
  */
 static ssize_t misc_cg_max_write(struct kernfs_open_file *of, char *buf,
 				 size_t nbytes, loff_t off)
 {
 	struct misc_cg *cg;
-	unsigned long max;
+	u64 max;
 	int ret = 0, i;
 	enum misc_res_type type = MISC_CG_RES_TYPES;
 	char *token;
@@ -272,7 +272,7 @@ static ssize_t misc_cg_max_write(struct kernfs_open_file *of, char *buf,
 	if (!strcmp(MAX_STR, buf)) {
 		max = MAX_NUM;
 	} else {
-		ret = kstrtoul(buf, 0, &max);
+		ret = kstrtou64(buf, 0, &max);
 		if (ret)
 			return ret;
 	}
@@ -298,13 +298,13 @@ static ssize_t misc_cg_max_write(struct kernfs_open_file *of, char *buf,
 static int misc_cg_current_show(struct seq_file *sf, void *v)
 {
 	int i;
-	unsigned long usage;
+	u64 usage;
 	struct misc_cg *cg = css_misc(seq_css(sf));
 
 	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
-		usage = atomic_long_read(&cg->res[i].usage);
+		usage = atomic64_read(&cg->res[i].usage);
 		if (READ_ONCE(misc_res_capacity[i]) || usage)
-			seq_printf(sf, "%s %lu\n", misc_res_name[i], usage);
+			seq_printf(sf, "%s %llu\n", misc_res_name[i], usage);
 	}
 
 	return 0;
@@ -323,12 +323,12 @@ static int misc_cg_current_show(struct seq_file *sf, void *v)
 static int misc_cg_capacity_show(struct seq_file *sf, void *v)
 {
 	int i;
-	unsigned long cap;
+	u64 cap;
 
 	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
 		cap = READ_ONCE(misc_res_capacity[i]);
 		if (cap)
-			seq_printf(sf, "%s %lu\n", misc_res_name[i], cap);
+			seq_printf(sf, "%s %llu\n", misc_res_name[i], cap);
 	}
 
 	return 0;
@@ -337,12 +337,13 @@ static int misc_cg_capacity_show(struct seq_file *sf, void *v)
 static int misc_events_show(struct seq_file *sf, void *v)
 {
 	struct misc_cg *cg = css_misc(seq_css(sf));
-	unsigned long events, i;
+	u64 events;
+	int i;
 
 	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
-		events = atomic_long_read(&cg->res[i].events);
+		events = atomic64_read(&cg->res[i].events);
 		if (READ_ONCE(misc_res_capacity[i]) || events)
-			seq_printf(sf, "%s.max %lu\n", misc_res_name[i], events);
+			seq_printf(sf, "%s.max %llu\n", misc_res_name[i], events);
 	}
 	return 0;
 }
@@ -399,7 +400,7 @@ misc_cg_alloc(struct cgroup_subsys_state *parent_css)
 
 	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
 		WRITE_ONCE(cg->res[i].max, MAX_NUM);
-		atomic_long_set(&cg->res[i].usage, 0);
+		atomic64_set(&cg->res[i].usage, 0);
 	}
 
 	return &cg->css;
-- 
2.25.1

