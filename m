Return-Path: <cgroups+bounces-8611-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD652AE1E84
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 17:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F58F4C180A
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 15:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1659B2E54CF;
	Fri, 20 Jun 2025 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHWVq1SJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60962BF3F3;
	Fri, 20 Jun 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433018; cv=none; b=ON00xh/1qT1FnlKAwaxd3NpWQhZoDMnc0O/cTqUw2qNGgit64rQ8H6F5oUa3M+HyfFXmsEOOAxnbk+k9NMj6U6cwTrGW9BHYoexJ9uV5+suS+tu/ESGvKQyHkxlR4c9nhLWgRWvcbp8uaZDNvKAg+3i7M2t0v7ZPPCp/RmI75LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433018; c=relaxed/simple;
	bh=NgFkxLsB6pI1LPP33IKIqTl6H68LrR1CV3Ob+pEb3ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ilf3djERkwlPWI7ZtRwK1yFlGDHqHImahUnrkIVPCaioOOS5Wq6OBrFL5DUdM6z9qDU/bhKOJXPg072U1/RqR6lRJHqMHYzsgRSmHRG1kmtEotW0ni0lJOCZ9M81jMd3AxcOHk96nZQD2B1u7LSaowZNjwevnxha62RYgc1cipY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHWVq1SJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DACC4CEEF;
	Fri, 20 Jun 2025 15:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750433015;
	bh=NgFkxLsB6pI1LPP33IKIqTl6H68LrR1CV3Ob+pEb3ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SHWVq1SJJifIxnLZZcRlQAtcXftd0wXnBdJiGBYnOCYXLHK9VFRD4/KRSXH1SxKqY
	 HlTFixp5qIj9M+ywxx5kV8TxwZMcjBVeOidzjOwAJzqiQZlN2e67Qi4C9+U0zZdTrY
	 sCcPy7iccNIH40lgQ/Qc6m3csyCMzOcyCGRS17i/0HeGy1AFsl7Y2JlRq5zj+o2Xxy
	 Ds4F1NoC19qtfvEf0/zat5SJ4nIcyqKTanqsDaC8camPLkvDq/jpfLPCIBuxRARtAY
	 dqIb/uWBfL/A/SBFExyIengU3xEyNURXCwKcHYCNyMoDJy7UDSUj/Mk8NIcKIZCcqf
	 E+2FWRBekiybQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Michal Koutny <mkoutny@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 08/27] cpuset: Convert boot_hk_cpus to use HK_TYPE_DOMAIN_BOOT
Date: Fri, 20 Jun 2025 17:22:49 +0200
Message-ID: <20250620152308.27492-9-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250620152308.27492-1-frederic@kernel.org>
References: <20250620152308.27492-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

boot_hk_cpus is an ad-hoc copy of HK_TYPE_DOMAIN_BOOT. Remove it and use
the official version.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cgroup/cpuset.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3bc4301466f3..aae8a739d48d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -80,12 +80,6 @@ static cpumask_var_t	subpartitions_cpus;
  */
 static cpumask_var_t	isolated_cpus;
 
-/*
- * Housekeeping (HK_TYPE_DOMAIN) CPUs at boot
- */
-static cpumask_var_t	boot_hk_cpus;
-static bool		have_boot_isolcpus;
-
 /* List of remote partition root children */
 static struct list_head remote_children;
 
@@ -1601,15 +1595,16 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
  * @new_cpus: cpu mask
  * Return: true if there is conflict, false otherwise
  *
- * CPUs outside of boot_hk_cpus, if defined, can only be used in an
+ * CPUs outside of HK_TYPE_DOMAIN_BOOT, if defined, can only be used in an
  * isolated partition.
  */
 static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
 {
-	if (!have_boot_isolcpus)
+	if (!housekeeping_enabled(HK_TYPE_DOMAIN_BOOT))
 		return false;
 
-	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
+	if ((prstate != PRS_ISOLATED) &&
+	    !cpumask_subset(new_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT)))
 		return true;
 
 	return false;
@@ -3766,12 +3761,9 @@ int __init cpuset_init(void)
 
 	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
 
-	have_boot_isolcpus = housekeeping_enabled(HK_TYPE_DOMAIN);
-	if (have_boot_isolcpus) {
-		BUG_ON(!alloc_cpumask_var(&boot_hk_cpus, GFP_KERNEL));
-		cpumask_copy(boot_hk_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN));
-		cpumask_andnot(isolated_cpus, cpu_possible_mask, boot_hk_cpus);
-	}
+	if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT))
+		cpumask_andnot(isolated_cpus, cpu_possible_mask,
+			       housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
 
 	return 0;
 }
-- 
2.48.1


