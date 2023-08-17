Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AE377F7AC
	for <lists+cgroups@lfdr.de>; Thu, 17 Aug 2023 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351418AbjHQN0w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Aug 2023 09:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351427AbjHQN01 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Aug 2023 09:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B82D7D
        for <cgroups@vger.kernel.org>; Thu, 17 Aug 2023 06:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692278736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xbf/RWuRBmFe9qyiZvWNgyow68Xfdh2X5sgn+zfTqQ=;
        b=S1vEbo9rHpwzHOXthZEenbJ2wcwBwGMo1GA1Ap7ZuF2CELMHIghRTJHIUA42cHVTeLtQ3Q
        8m/FAPNP44olN1UXmeNdcLfBgcd5RuoiOf1iv65cBWC5BVhhvKX/SGe+xC7XjpV0w/U0Qz
        iVq/PcQozIaqq8zPDDQNEyghYK8H6ik=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-p9dIBDiLMl-2wOT7UiLtTg-1; Thu, 17 Aug 2023 09:25:32 -0400
X-MC-Unique: p9dIBDiLMl-2wOT7UiLtTg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6ED8108BF83;
        Thu, 17 Aug 2023 13:25:13 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C8D1492C1B;
        Thu, 17 Aug 2023 13:25:13 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v7 4/6] cgroup/cpuset: Check partition conflict with housekeeping setup
Date:   Thu, 17 Aug 2023 09:24:52 -0400
Message-Id: <20230817132454.755459-5-longman@redhat.com>
In-Reply-To: <20230817132454.755459-1-longman@redhat.com>
References: <20230817132454.755459-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A user can pre-configure certain CPUs in an isolated state at boot time
with the "isolcpus" kernel boot command line option. Those CPUs will
not be in the housekeeping_cpumask(HK_TYPE_DOMAIN) and so will not
be in any sched domains. This may conflict with the partition setup
at runtime. Those boot time isolated CPUs should only be used in an
isolated partition.

This patch adds the necessary check and disallows partition setup if the
check fails.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index bf5486130071..b58bf3d9dd48 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -75,6 +75,7 @@ enum prs_errcode {
 	PERR_NOCPUS,
 	PERR_HOTPLUG,
 	PERR_CPUSEMPTY,
+	PERR_HKEEPING,
 };
 
 static const char * const perr_strings[] = {
@@ -85,6 +86,7 @@ static const char * const perr_strings[] = {
 	[PERR_NOCPUS]    = "Parent unable to distribute cpu downstream",
 	[PERR_HOTPLUG]   = "No cpu available due to hotplug",
 	[PERR_CPUSEMPTY] = "cpuset.cpus is empty",
+	[PERR_HKEEPING]  = "partition config conflicts with housekeeping setup",
 };
 
 struct cpuset {
@@ -1636,6 +1638,26 @@ static void remote_partition_check(struct cpuset *cs, struct cpumask *newmask,
 		rebuild_sched_domains_locked();
 }
 
+/*
+ * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
+ * @prstate: partition root state to be checked
+ * @new_cpus: cpu mask
+ * Return: true if there is conflict, false otherwise
+ *
+ * CPUs outside of housekeeping_cpumask(HK_TYPE_DOMAIN) can only be used in
+ * an isolated partition.
+ */
+static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
+{
+	const struct cpumask *hk_domain = housekeeping_cpumask(HK_TYPE_DOMAIN);
+	bool all_in_hk = cpumask_subset(new_cpus, hk_domain);
+
+	if (!all_in_hk && (prstate != PRS_ISOLATED))
+		return true;
+
+	return false;
+}
+
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1737,6 +1759,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		if (!cpumask_intersects(xcpus, parent->effective_xcpus))
 			return PERR_INVCPUS;
 
+		if (prstate_housekeeping_conflict(new_prs, xcpus))
+			return PERR_HKEEPING;
+
 		/*
 		 * A parent can be left with no CPU as long as there is no
 		 * task directly associated with the parent partition.
@@ -2324,6 +2349,9 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		if (cpumask_empty(trialcs->effective_xcpus)) {
 			invalidate = true;
 			cs->prs_err = PERR_INVCPUS;
+		} else if (prstate_housekeeping_conflict(old_prs, trialcs->effective_xcpus)) {
+			invalidate = true;
+			cs->prs_err = PERR_HKEEPING;
 		} else if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus)) {
 			invalidate = true;
 			cs->prs_err = PERR_NOCPUS;
@@ -2456,6 +2484,9 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		if (cpumask_empty(trialcs->exclusive_cpus)) {
 			invalidate = true;
 			cs->prs_err = PERR_INVCPUS;
+		} else if (prstate_housekeeping_conflict(old_prs, trialcs->effective_xcpus)) {
+			invalidate = true;
+			cs->prs_err = PERR_HKEEPING;
 		} else if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus)) {
 			invalidate = true;
 			cs->prs_err = PERR_NOCPUS;
-- 
2.31.1

