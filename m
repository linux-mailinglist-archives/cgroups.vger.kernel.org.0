Return-Path: <cgroups+bounces-4382-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC78958EEF
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 21:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE82C1F23433
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 19:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC7B175D5F;
	Tue, 20 Aug 2024 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXkIP5gO"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C816B391
	for <cgroups@vger.kernel.org>; Tue, 20 Aug 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183781; cv=none; b=FGAKdF8rzJ1z+FTrZr4efEoJ9Snq7tArq84lmKy0nuOckLPDYGl7LAXv3PboaHtlULfbDKSfHFUqDeIVc8MJUdndQiwmrjB9lNs9R9a6CILsYmVRUMZfqU+7ul2CWls2S78nhXixXTrndpSBPHD2DQ9YeuTu3/AGriZeDswy5fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183781; c=relaxed/simple;
	bh=9c/1U64AoyT6lKrVYZHFdSUubLINvZDoe6O2kCKfgK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mACKeSGumole13KD5Icojh1MjU5DGbN7I2oZLRXBRO3Z+KPg9hQkldfIArv+ZWAXHvqWj5WQUTQMVzVGFoZW5Uiuq8d1IUv2LL73Sfx/curuYam0Yvtc0Tasat1b0ftSFztFQMrPE4wZ7AT+HB1tsM5RCQwfPceca+ul4Ki8t90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXkIP5gO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724183779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5U2V8FtawKHDTZxwF7g9+c+0FIw36v3sUNSIDdlPKTk=;
	b=HXkIP5gOJdxUtNd2iezKF+QzZuXo9EdlA9q5t9pPv34rpCHmObUQ212prI6GVzXSNS1oQv
	L0wcYPDDTH/Z+giG2wmvJ2LWV7aDdVa1H+p0EKoWM8FDtYlRBPcSJJ05wAS5vMputQ9MrQ
	NYkLn/sXSt5l0M16QiFscS3wd7JZ48E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-cJvmZZq0NB2_RIISYNNrqg-1; Tue,
 20 Aug 2024 15:56:10 -0400
X-MC-Unique: cJvmZZq0NB2_RIISYNNrqg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 324491955D48;
	Tue, 20 Aug 2024 19:56:07 +0000 (UTC)
Received: from llong.com (unknown [10.2.17.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E4BC1300019C;
	Tue, 20 Aug 2024 19:56:04 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 1/2] cgroup/cpuset: Account for boot time isolated CPUs
Date: Tue, 20 Aug 2024 15:55:35 -0400
Message-ID: <20240820195536.202066-2-longman@redhat.com>
In-Reply-To: <20240820195536.202066-1-longman@redhat.com>
References: <20240820195536.202066-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

With the "isolcpus" boot command line parameter, we are able to
create isolated CPUs at boot time. These isolated CPUs aren't fully
accounted for in the cpuset code. For instance, the root cgroup's
"cpuset.cpus.isolated" control file does not include the boot time
isolated CPUs. Fix that by looking for pre-isolated CPUs at init time.

The prstate_housekeeping_conflict() function does check the
HK_TYPE_DOMAIN housekeeping cpumask to make sure that CPUs outside of it
can only be used in isolated partition. Given the fact that we are going
to make housekeeping cpumasks dynamic, the current check may not be right
anymore. Save the boot time HK_TYPE_DOMAIN cpumask and check against
it instead of the upcoming dynamic HK_TYPE_DOMAIN housekeeping cpumask.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7db55eed63cf..8b40df89c3c1 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -224,6 +224,12 @@ static cpumask_var_t	subpartitions_cpus;
  */
 static cpumask_var_t	isolated_cpus;
 
+/*
+ * Housekeeping (HK_TYPE_DOMAIN) CPUs at boot
+ */
+static cpumask_var_t	boot_hk_cpus;
+static bool		have_boot_isolcpus;
+
 /* List of remote partition root children */
 static struct list_head remote_children;
 
@@ -1823,15 +1829,15 @@ static void remote_partition_check(struct cpuset *cs, struct cpumask *newmask,
  * @new_cpus: cpu mask
  * Return: true if there is conflict, false otherwise
  *
- * CPUs outside of housekeeping_cpumask(HK_TYPE_DOMAIN) can only be used in
- * an isolated partition.
+ * CPUs outside of boot_hk_cpus, if defined, can only be used in an
+ * isolated partition.
  */
 static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
 {
-	const struct cpumask *hk_domain = housekeeping_cpumask(HK_TYPE_DOMAIN);
-	bool all_in_hk = cpumask_subset(new_cpus, hk_domain);
+	if (!have_boot_isolcpus)
+		return false;
 
-	if (!all_in_hk && (prstate != PRS_ISOLATED))
+	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
 		return true;
 
 	return false;
@@ -4345,6 +4351,13 @@ int __init cpuset_init(void)
 
 	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
 
+	have_boot_isolcpus = housekeeping_enabled(HK_TYPE_DOMAIN);
+	if (have_boot_isolcpus) {
+		BUG_ON(!alloc_cpumask_var(&boot_hk_cpus, GFP_KERNEL));
+		cpumask_copy(boot_hk_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN));
+		cpumask_andnot(isolated_cpus, cpu_possible_mask, boot_hk_cpus);
+	}
+
 	return 0;
 }
 
-- 
2.43.5


