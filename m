Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5409604EDF
	for <lists+cgroups@lfdr.de>; Wed, 19 Oct 2022 19:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiJSRej (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Oct 2022 13:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiJSReS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Oct 2022 13:34:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870101D2B55;
        Wed, 19 Oct 2022 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666200856; x=1697736856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ji8CP4xluWOS2NrGBbUVXyKLzEJJ2hTlHVJTBMnur4M=;
  b=FDpironghNhixps0sAEyfhSrkLnoEuNbigtNltdkXJNHGsr69VWR0ROu
   GavqLkZ9gAioBMNh0SI/xamthtjtU7sMhORU8O4pAP6RyiEm/E3DBN1Pd
   XTGRYoeX8OtFAQIgJO4VhLRefb7kpWaA3GbU3oHlPd0lXYO6+MVwfLV7C
   WEAuaRH8jFO30NK6G0jUUKfHyIL4ne/2nb7/+gx7FujXdg/8oehAvHLmi
   j2jHIZ3gtiKjQMBT3A4ZxZZgdY4b/YYLsmYd8c7sqIp0yLGYGsv4mcYim
   Eg5Y29yXV2JoQrqCIVOh35h1E1vxQE12FjdScOapjnCQ+LNApEhR+K0d9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="306474584"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="306474584"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:34:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607204894"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607204894"
Received: from mjmcener-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.213.233.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:34:03 -0700
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [RFC 14/17] cgroup/drm: Show group budget signaling capability in sysfs
Date:   Wed, 19 Oct 2022 18:32:51 +0100
Message-Id: <20221019173254.3361334-15-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019173254.3361334-1-tvrtko.ursulin@linux.intel.com>
References: <20221019173254.3361334-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Show overall status of a task group - whether all DRM clients in a group
support over budget signaling, or some do not, or if there are no DRM
clients in the group to start with.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  7 ++++
 drivers/gpu/drm/drm_cgroup.c            | 33 ++++++++++++++++
 include/drm/drm_clients.h               |  7 ++++
 include/drm/drm_drv.h                   | 11 +++++-
 kernel/cgroup/drm.c                     | 52 +++++++++++++++++++++++++
 5 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 318f463a1316..6ee94ee109f0 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2491,6 +2491,13 @@ DRM scheduling soft limits interface files
 	signal.
 	Value of zero (defaul) disables the soft limit checking.
 
+  drm.budget_supported
+	One of:
+	 1) 'yes' - when all DRM clients in the group support the functionality.
+	 2) 'no' - when at least one of the DRM clients does not support the
+		   functionality.
+	 3) 'n/a' - when there are no DRM clients in the group.
+
 Misc
 ----
 
diff --git a/drivers/gpu/drm/drm_cgroup.c b/drivers/gpu/drm/drm_cgroup.c
index ff99d1f4f1d4..d2d8b2cb4ab3 100644
--- a/drivers/gpu/drm/drm_cgroup.c
+++ b/drivers/gpu/drm/drm_cgroup.c
@@ -259,3 +259,36 @@ void drm_pid_signal_budget(struct pid *pid, u64 usage, u64 budget)
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(drm_pid_signal_budget);
+
+enum drm_cg_supported drm_pid_signal_budget_supported(struct pid *pid)
+{
+	enum drm_cg_supported supported = DRM_CG_NOT_APPLICABLE;
+	struct drm_pid_clients *clients;
+
+	rcu_read_lock();
+	clients = xa_load(&drm_pid_clients, (unsigned long)pid);
+	if (clients) {
+		struct drm_file *fpriv;
+
+		list_for_each_entry_rcu(fpriv, &clients->file_list, clink) {
+			const struct drm_cgroup_ops *cg_ops =
+				fpriv->minor->dev->driver->cg_ops;
+
+			if (!cg_ops ||
+			    !cg_ops->active_time_us ||
+			    !cg_ops->signal_budget ||
+			    cg_ops->signal_budget(fpriv, 0, 0) < 0) {
+				supported = DRM_CG_NOT_SUPPORTED;
+				break;
+			}
+
+			if (supported == DRM_CG_NOT_APPLICABLE)
+				supported = DRM_CG_SUPPORTED;
+
+		}
+	}
+	rcu_read_unlock();
+
+	return supported;
+}
+EXPORT_SYMBOL_GPL(drm_pid_signal_budget_supported);
diff --git a/include/drm/drm_clients.h b/include/drm/drm_clients.h
index 7ad09fd0a404..5d14ae26ece6 100644
--- a/include/drm/drm_clients.h
+++ b/include/drm/drm_clients.h
@@ -14,6 +14,12 @@ struct drm_pid_clients {
 	struct rcu_head rcu;
 };
 
+enum drm_cg_supported {
+	DRM_CG_NOT_APPLICABLE = -1,
+	DRM_CG_NOT_SUPPORTED = 0,
+	DRM_CG_SUPPORTED
+};
+
 #if IS_ENABLED(CONFIG_CGROUP_DRM)
 void drm_clients_close(struct drm_file *file_priv);
 int drm_clients_open(struct drm_file *file_priv);
@@ -39,5 +45,6 @@ unsigned int drm_pid_priority_levels(struct pid *pid, bool *non_uniform);
 void drm_pid_update_priority(struct pid *pid, int priority);
 u64 drm_pid_get_active_time_us(struct pid *pid);
 void drm_pid_signal_budget(struct pid *pid, u64 usage, u64 budget);
+enum drm_cg_supported drm_pid_signal_budget_supported(struct pid *pid);
 
 #endif
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 07dec956ebfb..7a1a20d1b8de 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -198,8 +198,17 @@ struct drm_cgroup_ops {
 	 *
 	 * Optional callback used by the DRM core to forward over/under GPU time
 	 * messages sent by the DRM cgroup controller.
+	 *
+	 * Zero used with zero budget is a special budgeting support status
+	 * query which needs to return either zero or -EINVAL if client does not
+	 * support budget control.
+	 *
+	 * Returns:
+	 * 	* 1 when client has been throttled.
+	 * 	* 0 when no action has been taken.
+	 * 	* -EINVAL when not supported by the client.
 	 */
-	void (*signal_budget) (struct drm_file *, u64 used, u64 budget);
+	int (*signal_budget) (struct drm_file *, u64 used, u64 budget);
 };
 
 /**
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index af50ead1564a..dd7db70c2831 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -239,6 +239,53 @@ drmcs_write_weight(struct cgroup_subsys_state *css, struct cftype *cftype,
 	return 0;
 }
 
+static int drmcs_show_budget_supported(struct seq_file *sf, void *v)
+{
+	struct drm_cgroup_state *drmcs = css_to_drmcs(seq_css(sf));
+	enum drm_cg_supported overall = DRM_CG_NOT_APPLICABLE;
+	struct cgroup *cgrp = drmcs->css.cgroup;
+	struct task_struct *task;
+	struct css_task_iter it;
+
+	css_task_iter_start(&cgrp->self,
+			    CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED,
+			    &it);
+	while ((task = css_task_iter_next(&it))) {
+		enum drm_cg_supported supported;
+
+		/* Ignore kernel threads here. */
+		if (task->flags & PF_KTHREAD)
+			continue;
+
+		supported = drm_pid_signal_budget_supported(task_pid(task));
+		if (supported == DRM_CG_SUPPORTED &&
+		    overall == DRM_CG_NOT_APPLICABLE) {
+			overall = DRM_CG_SUPPORTED;
+		} else if (supported == DRM_CG_NOT_SUPPORTED) {
+			overall = DRM_CG_NOT_SUPPORTED;
+			break;
+		}
+	}
+	css_task_iter_end(&it);
+
+	switch (overall) {
+	case DRM_CG_NOT_APPLICABLE:
+		seq_puts(sf, "n/a\n");
+		break;
+	case DRM_CG_NOT_SUPPORTED:
+		seq_puts(sf, "no\n");
+		break;
+	case DRM_CG_SUPPORTED:
+		seq_puts(sf, "yes\n");
+		break;
+	default:
+		seq_printf(sf, "%u\n", overall);
+		break;
+	}
+
+	return 0;
+}
+
 static int drmcs_online(struct cgroup_subsys_state *css)
 {
 	struct drm_cgroup_state *drmcs = css_to_drmcs(css);
@@ -690,6 +737,11 @@ struct cftype files[] = {
 		.read_u64 = drmcs_read_weight,
 		.write_u64 = drmcs_write_weight,
 	},
+	{
+		.name = "budget_supported",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = drmcs_show_budget_supported,
+	},
 	{
 		.name = "period_us",
 		.flags = CFTYPE_NOT_ON_ROOT,
-- 
2.34.1

