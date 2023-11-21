Return-Path: <cgroups+bounces-499-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BC27F23C4
	for <lists+cgroups@lfdr.de>; Tue, 21 Nov 2023 03:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C71E282336
	for <lists+cgroups@lfdr.de>; Tue, 21 Nov 2023 02:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C8914AA4;
	Tue, 21 Nov 2023 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eONjVomh"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21663C8
	for <cgroups@vger.kernel.org>; Mon, 20 Nov 2023 18:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700533143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nedYr642nEg/r1pmego4Hp5PjxqjOd5QuDOx28RV/Z4=;
	b=eONjVomhyR6i7726RIwSPwn3crZYkd4N5r5yPpjpJcPODT33KNDCtqAU+8cj2QS1a1fQYN
	Ld8+aI2xxSmFtH6vVdtjg1hyC6/2XIq4HYuYSzXBOx9ocMfJdP/bHzpoe/owA3iUCotWy9
	btJjJeplLJ+q2JHmdKpY2uBucqz0tM8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-iYHo0YeKP32831Ej1aXyEg-1; Mon, 20 Nov 2023 21:19:00 -0500
X-MC-Unique: iYHo0YeKP32831Ej1aXyEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D36485A58C;
	Tue, 21 Nov 2023 02:18:59 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.109])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 26E9E1C060B0;
	Tue, 21 Nov 2023 02:18:59 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH-cgroup] workqueue: Move workqueue_set_unbound_cpumask() and its helpers inside CONFIG_SYSFS
Date: Mon, 20 Nov 2023 21:18:40 -0500
Message-Id: <20231121021840.10937-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Commit fe28f631fa94 ("workqueue: Add workqueue_unbound_exclude_cpumask()
to exclude CPUs from wq_unbound_cpumask") makes
workqueue_set_unbound_cpumask() static as it is not used elsewhere in
the kernel. However, this triggers a kernel test robot warning about
'workqueue_set_unbound_cpumask' defined but not used when CONFIG_SYS
isn't defined. It happens that workqueue_set_unbound_cpumask() is only
called when CONFIG_SYS is defined.

Move workqueue_set_unbound_cpumask() and its helpers inside the
CONFIG_SYSFS compilation block to avoid the warning. There is no
functional change.

Fixes: fe28f631fa94 ("workqueue: Add workqueue_unbound_exclude_cpumask() to exclude CPUs from wq_unbound_cpumask")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311130831.uh0AoCd1-lkp@intel.com/
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/workqueue.c | 102 ++++++++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bd9d34eacd78..2fc585d3d6ca 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4417,19 +4417,6 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
 	mutex_unlock(&ctx->wq->mutex);
 }
 
-static void apply_wqattrs_lock(void)
-{
-	/* CPUs should stay stable across pwq creations and installations */
-	cpus_read_lock();
-	mutex_lock(&wq_pool_mutex);
-}
-
-static void apply_wqattrs_unlock(void)
-{
-	mutex_unlock(&wq_pool_mutex);
-	cpus_read_unlock();
-}
-
 static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
 					const struct workqueue_attrs *attrs)
 {
@@ -5833,44 +5820,6 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 	return ret;
 }
 
-/**
- *  workqueue_set_unbound_cpumask - Set the low-level unbound cpumask
- *  @cpumask: the cpumask to set
- *
- *  The low-level workqueues cpumask is a global cpumask that limits
- *  the affinity of all unbound workqueues.  This function check the @cpumask
- *  and apply it to all unbound workqueues and updates all pwqs of them.
- *
- *  Return:	0	- Success
- *  		-EINVAL	- Invalid @cpumask
- *  		-ENOMEM	- Failed to allocate memory for attrs or pwqs.
- */
-static int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
-{
-	int ret = -EINVAL;
-
-	/*
-	 * Not excluding isolated cpus on purpose.
-	 * If the user wishes to include them, we allow that.
-	 */
-	cpumask_and(cpumask, cpumask, cpu_possible_mask);
-	if (!cpumask_empty(cpumask)) {
-		apply_wqattrs_lock();
-		cpumask_copy(wq_requested_unbound_cpumask, cpumask);
-		if (cpumask_equal(cpumask, wq_unbound_cpumask)) {
-			ret = 0;
-			goto out_unlock;
-		}
-
-		ret = workqueue_apply_unbound_cpumask(cpumask);
-
-out_unlock:
-		apply_wqattrs_unlock();
-	}
-
-	return ret;
-}
-
 /**
  * workqueue_unbound_exclude_cpumask - Exclude given CPUs from unbound cpumask
  * @exclude_cpumask: the cpumask to be excluded from wq_unbound_cpumask
@@ -6027,6 +5976,19 @@ static struct attribute *wq_sysfs_attrs[] = {
 };
 ATTRIBUTE_GROUPS(wq_sysfs);
 
+static void apply_wqattrs_lock(void)
+{
+	/* CPUs should stay stable across pwq creations and installations */
+	cpus_read_lock();
+	mutex_lock(&wq_pool_mutex);
+}
+
+static void apply_wqattrs_unlock(void)
+{
+	mutex_unlock(&wq_pool_mutex);
+	cpus_read_unlock();
+}
+
 static ssize_t wq_nice_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -6203,6 +6165,44 @@ static struct bus_type wq_subsys = {
 	.dev_groups			= wq_sysfs_groups,
 };
 
+/**
+ *  workqueue_set_unbound_cpumask - Set the low-level unbound cpumask
+ *  @cpumask: the cpumask to set
+ *
+ *  The low-level workqueues cpumask is a global cpumask that limits
+ *  the affinity of all unbound workqueues.  This function check the @cpumask
+ *  and apply it to all unbound workqueues and updates all pwqs of them.
+ *
+ *  Return:	0	- Success
+ *		-EINVAL	- Invalid @cpumask
+ *		-ENOMEM	- Failed to allocate memory for attrs or pwqs.
+ */
+static int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
+{
+	int ret = -EINVAL;
+
+	/*
+	 * Not excluding isolated cpus on purpose.
+	 * If the user wishes to include them, we allow that.
+	 */
+	cpumask_and(cpumask, cpumask, cpu_possible_mask);
+	if (!cpumask_empty(cpumask)) {
+		apply_wqattrs_lock();
+		cpumask_copy(wq_requested_unbound_cpumask, cpumask);
+		if (cpumask_equal(cpumask, wq_unbound_cpumask)) {
+			ret = 0;
+			goto out_unlock;
+		}
+
+		ret = workqueue_apply_unbound_cpumask(cpumask);
+
+out_unlock:
+		apply_wqattrs_unlock();
+	}
+
+	return ret;
+}
+
 static ssize_t __wq_cpumask_show(struct device *dev,
 		struct device_attribute *attr, char *buf, cpumask_var_t mask)
 {
-- 
2.39.3


