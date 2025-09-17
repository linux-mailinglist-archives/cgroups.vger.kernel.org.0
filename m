Return-Path: <cgroups+bounces-10179-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56587B7D0C4
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 14:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E1D1797C6
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 06:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A27D273D60;
	Wed, 17 Sep 2025 06:20:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012FD248861;
	Wed, 17 Sep 2025 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090011; cv=none; b=CXV3USiT+kER/gEzRwtXGqBOKpCMmazWwZjtaBU3YTOqmr7x9oFLwcIXyaTaghg5AsCvTyjsBSCMfHEf6UCFh6BtgqXfZ2J2ie57brN+D3DEfqXOpeJpBsau3+uX36vRfApoQdrS28GdeivBiHjWhrzbCBQfeXxjb4MXdSytQAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090011; c=relaxed/simple;
	bh=A3WpJYfVNdnSgFxNP8tuvoSGBsfYDIXMX0wHSJx7+Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hWwCtHTljyyPsek4rBnOkJiNWEhxzk94WZ6X3A/gAthwBtJ+L8EAeSNZBfqvST8R7puZgLQGbCtSmqEVQRxWzneQ6iU8Lemp8nsmCluvU23bofgMDb/kovqU5KvmUTuRgDQAAfPoFKokI38FnjVQY2LPWR0yzUbLfz5BCd80xj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cRTCD4CP7zYQvWm;
	Wed, 17 Sep 2025 14:20:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3300B1A0902;
	Wed, 17 Sep 2025 14:20:07 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCn74sNU8pos3slCw--.39134S3;
	Wed, 17 Sep 2025 14:20:07 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 01/11] cpuset: move the root cpuset write check earlier
Date: Wed, 17 Sep 2025 06:04:44 +0000
Message-Id: <20250917060454.2885698-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917060454.2885698-1-chenridong@huaweicloud.com>
References: <20250917060454.2885698-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn74sNU8pos3slCw--.39134S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWUKr47Xw43tF45AFy7ZFb_yoW8Ar4rpF
	4UC3yUJrW5XF1UCws7XrZF934rKw1rJFyDtan7Kw1rCF9IyF4jkFy7XwnIyry5GryDCF4U
	Xa9I9rWj9a1DtFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0d41b4993f8c..819adf4fd591 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2338,10 +2338,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	bool force = false;
 	int old_prs = cs->partition_root_state;
 
-	/* top_cpuset.cpus_allowed tracks cpu_active_mask; it's read-only */
-	if (cs == &top_cpuset)
-		return -EACCES;
-
 	/*
 	 * An empty cpus_allowed is ok only if the cpuset has no tasks.
 	 * Since cpulist_parse() fails on an empty mask, we special case
@@ -2802,15 +2798,6 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
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
@@ -3280,6 +3267,10 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	struct cpuset *trialcs;
 	int retval = -ENODEV;
 
+	/* root is read-only */
+	if (cs == &top_cpuset)
+		return -EACCES;
+
 	buf = strstrip(buf);
 	cpuset_full_lock();
 	if (!is_cpuset_online(cs))
-- 
2.34.1


