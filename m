Return-Path: <cgroups+bounces-9469-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F26B39E4C
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 15:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C46516ECDD
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5D9312801;
	Thu, 28 Aug 2025 13:11:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3BC3112C1;
	Thu, 28 Aug 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386696; cv=none; b=JmR3TsHszk9jPsQRyRrkvwyATDe8b03CNc1CSPajpvGbpJJUZzUIYfx/3Wb2KDG+3UniqkuNvmHcBMrvLBgfcB/K/roSTctZcluUn86I/vMXK9Ysy5kqQRN7uCQJ6l8FdebLlqij5+IiZQ3uPsVkbntH1EVv0s3LEOaIYr5bpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386696; c=relaxed/simple;
	bh=VgIvhKpLS2BJZnX4MiaOHPT/BIPH3+CsTIegR2+zmj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X32XCi3iRuYnkxOg5As1HrTEQtezgsTxu/84TyAFdmBMyg7WUUKrt0p1IO8Aa0ZaHjq+kTc6SSyNhmH+tLL2rK1AAy0PSZ5wFWaCveOfZkjltCXHrrWQjzHpBacN1OgCOYROuwZTZUWwALIuQVs1/2WU1rGp/2R0YPDiJD4aHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cCMH86GdvzYQvcy;
	Thu, 28 Aug 2025 21:11:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 65EBE1A1358;
	Thu, 28 Aug 2025 21:11:31 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgBX8mlsVbBoQsxPAg--.40352S3;
	Thu, 28 Aug 2025 21:11:31 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next RFC 01/11] cpuset: move the root cpuset write check earlier
Date: Thu, 28 Aug 2025 12:56:21 +0000
Message-Id: <20250828125631.1978176-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828125631.1978176-1-chenridong@huaweicloud.com>
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBX8mlsVbBoQsxPAg--.40352S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWUKr4xKw1xurW5Ar4rAFb_yoW8ZFykpF
	WDC347KrW5XFyUCws7X39ruwnYgw18JFyDtw17Kw1rCFyayF4jkFy7XwnIyFy5CryxuF4U
	JFZI9rWj9a4qyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7qjgUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The 'cpus' or 'mems' lists of the top_cpuset cannot be modified.
This check can be moved before acquiring any locks as a common code
block to improve efficiency and maintainability.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a78ccd11ce9b..7e6a40e361ea 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -337,6 +337,11 @@ static inline bool cpuset_v2(void)
 		cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
 }
 
+static inline bool cpuset_is_root(struct cpuset *cs)
+{
+	return (cs == &top_cpuset);
+}
+
 /*
  * Cgroup v2 behavior is used on the "cpus" and "mems" control files when
  * on default hierarchy or when the cpuset_v2_mode flag is set by mounting
@@ -2334,10 +2339,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	bool force = false;
 	int old_prs = cs->partition_root_state;
 
-	/* top_cpuset.cpus_allowed tracks cpu_active_mask; it's read-only */
-	if (cs == &top_cpuset)
-		return -EACCES;
-
 	/*
 	 * An empty cpus_allowed is ok only if the cpuset has no tasks.
 	 * Since cpulist_parse() fails on an empty mask, we special case
@@ -2783,15 +2784,6 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
 {
 	int retval;
 
-	/*
-	 * top_cpuset.mems_allowed tracks node_stats[N_MEMORY];
-	 * it's read-only
-	 */
-	if (cs == &top_cpuset) {
-		retval = -EACCES;
-		goto done;
-	}
-
 	/*
 	 * An empty mems_allowed is ok iff there are no tasks in the cpuset.
 	 * Since nodelist_parse() fails on an empty mask, we special case
@@ -3257,6 +3249,10 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	struct cpuset *trialcs;
 	int retval = -ENODEV;
 
+	/* root is read-only */
+	if (cpuset_is_root(cs))
+		return -EACCES;
+
 	buf = strstrip(buf);
 	cpuset_full_lock();
 	if (!is_cpuset_online(cs))
-- 
2.34.1


