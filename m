Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A64622FEE
	for <lists+cgroups@lfdr.de>; Wed,  9 Nov 2022 17:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiKIQN3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Nov 2022 11:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiKIQMw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Nov 2022 11:12:52 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2AF25C5D;
        Wed,  9 Nov 2022 08:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668010365; x=1699546365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x6XVT4VrLhMh4IJBu+3B412tbpXC3M4uZJfhwf8sKQM=;
  b=natJ81G2NaVCBnu9icWN+86xLgvJFJDDMfk1uB/ck7eZaTex0aUl2TZN
   2FjlkKdmvRcrV6PU6Mp7R7xS/Mpzt2LkidI6HuqQZLZCIk3ooKM/nPkiu
   S6JBUoMWAWN5NbGRDWUpAAdw+5xwZLwbhZK1NvL0QCDVxhF0RM2mDiQIb
   TUetC6TGjLHg2aDJLql0YVP4CpWsrulvFh52fE8pXGZ65s3YFdYcvRcRy
   ktFrFwmW+isM9EtrFAtws66M5oQgiLFzdlqiVg7KjLvOJlLSYOXAnyes2
   LZtCmQZPQPRStnVod08Chn80uuAN4IQiGMV/3uXK9fYtdrluASpk2AkS7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312181498"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="312181498"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:12:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="811684610"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="811684610"
Received: from smurnane-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.196.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:12:41 -0800
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
Subject: [RFC 13/13] drm/i915: Implement cgroup controller over budget throttling
Date:   Wed,  9 Nov 2022 16:11:41 +0000
Message-Id: <20221109161141.2987173-14-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109161141.2987173-1-tvrtko.ursulin@linux.intel.com>
References: <20221109161141.2987173-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

When notified by the drm core we are over our allotted time budget, i915
instance will check if any of the GPU engines it is reponsible for is
fully saturated. If it is, and the client in question is using that
engine, it will throttle it.

For now throttling is done simplistically by lowering the scheduling
priority while client is throttled.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    | 37 +++++++-
 drivers/gpu/drm/i915/i915_driver.c            |  1 +
 drivers/gpu/drm/i915/i915_drm_client.c        | 93 +++++++++++++++++++
 drivers/gpu/drm/i915/i915_drm_client.h        | 11 +++
 4 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 1160723c9d2d..280ed90d5001 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -6,6 +6,7 @@
 
 #include <linux/dma-resv.h>
 #include <linux/highmem.h>
+#include <linux/prandom.h>
 #include <linux/sync_file.h>
 #include <linux/uaccess.h>
 
@@ -3015,6 +3016,40 @@ static void retire_requests(struct intel_timeline *tl, struct i915_request *end)
 			break;
 }
 
+#ifdef CONFIG_CGROUP_DRM
+static unsigned int
+__get_class(struct drm_i915_file_private *fpriv, const struct i915_request *rq)
+{
+	unsigned int class;
+
+	class = rq->context->engine->uabi_class;
+
+	if (WARN_ON_ONCE(class >= ARRAY_SIZE(fpriv->client->throttle)))
+		class = 0;
+
+	return class;
+}
+
+static void copy_priority(struct i915_sched_attr *attr,
+			  const struct i915_execbuffer *eb,
+			  const struct i915_request *rq)
+{
+	struct drm_i915_file_private *file_priv = eb->file->driver_priv;
+
+	*attr = eb->gem_context->sched;
+	if (file_priv->client->throttle[__get_class(file_priv, rq)])
+		attr->priority -=
+		    1 + prandom_u32_max(-I915_CONTEXT_MIN_USER_PRIORITY / 2);
+}
+#else
+static void copy_priority(struct i915_sched_attr *attr,
+			  const struct i915_execbuffer *eb,
+			  const struct i915_request *rq)
+{
+	*attr = eb->gem_context->sched;
+}
+#endif
+
 static int eb_request_add(struct i915_execbuffer *eb, struct i915_request *rq,
 			  int err, bool last_parallel)
 {
@@ -3031,7 +3066,7 @@ static int eb_request_add(struct i915_execbuffer *eb, struct i915_request *rq,
 
 	/* Check that the context wasn't destroyed before submission */
 	if (likely(!intel_context_is_closed(eb->context))) {
-		attr = eb->gem_context->sched;
+		copy_priority(&attr, eb, rq);
 	} else {
 		/* Serialise with context_close via the add_to_timeline */
 		i915_request_set_error_once(rq, -ENOENT);
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 96a7da5258c4..d6c0501af3f4 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1897,6 +1897,7 @@ static const struct drm_ioctl_desc i915_ioctls[] = {
 #ifdef CONFIG_CGROUP_DRM
 static const struct drm_cgroup_ops i915_drm_cgroup_ops = {
 	.active_time_us = i915_drm_cgroup_get_active_time_us,
+	.signal_budget = i915_drm_cgroup_signal_budget,
 };
 #endif
 
diff --git a/drivers/gpu/drm/i915/i915_drm_client.c b/drivers/gpu/drm/i915/i915_drm_client.c
index c9754cb0277f..81144c8e8d05 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.c
+++ b/drivers/gpu/drm/i915/i915_drm_client.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/ktime.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
@@ -159,6 +160,98 @@ u64 i915_drm_cgroup_get_active_time_us(struct drm_file *file)
 
 	return busy;
 }
+
+int i915_drm_cgroup_signal_budget(struct drm_file *file, u64 usage, u64 budget)
+{
+	struct drm_i915_file_private *fpriv = file->driver_priv;
+	u64 class_usage[I915_LAST_UABI_ENGINE_CLASS + 1];
+	u64 class_last[I915_LAST_UABI_ENGINE_CLASS + 1];
+	struct drm_i915_private *i915 = fpriv->dev_priv;
+	struct i915_drm_client *client = fpriv->client;
+	struct intel_engine_cs *engine;
+	bool over = usage > budget;
+	unsigned int i;
+	ktime_t unused;
+	int ret = 0;
+	u64 t;
+
+	if (!supports_stats(i915))
+		return -EINVAL;
+
+	if (usage == 0 && budget == 0)
+		return 0;
+
+printk("i915_drm_cgroup_signal_budget client-id=%u over=%u (%llu/%llu) <%u>\n",
+       client->id, over, usage, budget, client->over_budget);
+
+	if (over) {
+		client->over_budget++;
+		if (!client->over_budget)
+			client->over_budget = 2;
+	} else {
+		client->over_budget = 0;
+		memset(client->class_last, 0, sizeof(client->class_last));
+		memset(client->throttle, 0, sizeof(client->throttle));
+		return 0;
+	}
+
+	memset(class_usage, 0, sizeof(class_usage));
+	for_each_uabi_engine(engine, i915)
+		class_usage[engine->uabi_class] +=
+			ktime_to_ns(intel_engine_get_busy_time(engine, &unused));
+
+	memcpy(class_last, client->class_last, sizeof(class_last));
+	memcpy(client->class_last, class_usage, sizeof(class_last));
+
+	for (i = 0; i < ARRAY_SIZE(uabi_class_names); i++)
+		class_usage[i] -= class_last[i];
+
+	t = client->last;
+	client->last = ktime_get_raw_ns();
+	t = client->last - t;
+
+	if (client->over_budget == 1)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(uabi_class_names); i++) {
+		u64 client_class_usage[I915_LAST_UABI_ENGINE_CLASS + 1];
+		unsigned int capacity;
+
+		if (!i915->engine_uabi_class_count[i])
+			continue;
+
+		t = DIV_ROUND_UP_ULL(t, 1000);
+		class_usage[i] = DIV_ROUND_CLOSEST_ULL(class_usage[i], 1000);
+		usage = DIV_ROUND_CLOSEST_ULL(class_usage[i] * 100ULL,
+					      t *
+					      i915->engine_uabi_class_count[i]);
+		if (usage <= 95) {
+			/* class not oversubsribed */
+			if (client->throttle[i]) {
+				client->throttle[i] = false;
+printk("  UN-throttling class%u (phys=%lld%%)\n",
+       i, usage);
+			}
+			continue;
+		}
+
+		client_class_usage[i] =
+			get_class_active_ns(client, i, &capacity);
+
+		if (client_class_usage[i] && !client->throttle[i]) {
+			ret |= 1;
+			client->throttle[i] = true;
+			/*
+			 * QQQ maybe apply "strength" of throttling based on
+			 * usage/budget?
+			 */
+printk("  THROTTLING class%u (phys=%lld%% client=%lluus)\n",
+       i, usage, client_class_usage[i] / 1000);
+		}
+	}
+
+	return ret;
+}
 #endif
 
 #ifdef CONFIG_PROC_FS
diff --git a/drivers/gpu/drm/i915/i915_drm_client.h b/drivers/gpu/drm/i915/i915_drm_client.h
index c8439eaa89be..1331cab7ad5e 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.h
+++ b/drivers/gpu/drm/i915/i915_drm_client.h
@@ -15,6 +15,8 @@
 
 #define I915_LAST_UABI_ENGINE_CLASS I915_ENGINE_CLASS_COMPUTE
 
+struct drm_file;
+
 struct drm_i915_private;
 
 struct i915_drm_clients {
@@ -38,6 +40,13 @@ struct i915_drm_client {
 	 * @past_runtime: Accumulation of pphwsp runtimes from closed contexts.
 	 */
 	atomic64_t past_runtime[I915_LAST_UABI_ENGINE_CLASS + 1];
+
+#ifdef CONFIG_CGROUP_DRM
+	bool throttle[I915_LAST_UABI_ENGINE_CLASS + 1];
+	unsigned int over_budget;
+	u64 last;
+	u64 class_last[I915_LAST_UABI_ENGINE_CLASS + 1];
+#endif
 };
 
 void i915_drm_clients_init(struct i915_drm_clients *clients,
@@ -66,5 +75,7 @@ void i915_drm_client_fdinfo(struct seq_file *m, struct file *f);
 void i915_drm_clients_fini(struct i915_drm_clients *clients);
 
 u64 i915_drm_cgroup_get_active_time_us(struct drm_file *file);
+int i915_drm_cgroup_signal_budget(struct drm_file *file,
+				  u64 usage, u64 budget);
 
 #endif /* !__I915_DRM_CLIENT_H__ */
-- 
2.34.1

