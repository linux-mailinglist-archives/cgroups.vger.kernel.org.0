Return-Path: <cgroups+bounces-10178-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D91EB7D079
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 14:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FDBF176246
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 06:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054D0271468;
	Wed, 17 Sep 2025 06:20:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E125A343;
	Wed, 17 Sep 2025 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090011; cv=none; b=eDF/4GTsy6ng7TOw7QbLSE63XcyNV1ng3KLIw9VAtDxx8h6H/dF3vuXji8/2YzXPOSenOJNFPWfuHaFpKMWvh2g/IpzB2a1Ml7ddJf27dYM45alUI3ZAX32l6kC4FjePGYVZ13Yibm09hNEDVI78KPQY18kw79dXkmUpTZsbD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090011; c=relaxed/simple;
	bh=OZKmL1eUw12hD8SIMOQLiDUo85g6XqRpjY90hHXadlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CR2AfV7A22Ea4nSWW4QCQJdYneEpxTsgDLDjvEHR7ke7aipmUp0td3o8zv1ncTvVslp9UNomKbdP3+wA7EBrcqwgPNv5is7Y9+3vaOU+e/uKG9WwTocuOzZ1/4SyBIYDEpMLlMV45YFKZ0GcceOq8GRGSe2HfLbdqfyx6gcv3cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cRTCD4dpFzYQvX1;
	Wed, 17 Sep 2025 14:20:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 403581A14A4;
	Wed, 17 Sep 2025 14:20:07 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCn74sNU8pos3slCw--.39134S4;
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
Subject: [PATCH -next 02/11] cpuset: remove unused assignment to trialcs->partition_root_state
Date: Wed, 17 Sep 2025 06:04:45 +0000
Message-Id: <20250917060454.2885698-3-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn74sNU8pos3slCw--.39134S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4xWFW5Xw13tr1xAFyrJFb_yoW8JF47pF
	WDGa1UGay5Wryjk3yDKrsruryrKa1DXa1Dtwnxt34rGFy7X3W2kFyDZ3sxZw10q39rCF18
	XasIvrWS9aySkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcTmhUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The trialcs->partition_root_state field is not used during the
configuration of 'cpuset.cpus' or 'cpuset.cpus.exclusive'. Therefore,
the assignment of values to this field can be safely removed.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 819adf4fd591..5452c3702b80 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2363,7 +2363,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		 * trialcs->effective_xcpus is used as a temporary cpumask
 		 * for checking validity of the partition root.
 		 */
-		trialcs->partition_root_state = PRS_MEMBER;
 		if (!cpumask_empty(trialcs->exclusive_cpus) || is_partition_valid(cs))
 			compute_effective_exclusive_cpumask(trialcs, NULL, cs);
 	}
@@ -2497,7 +2496,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		return 0;
 
 	if (*buf) {
-		trialcs->partition_root_state = PRS_MEMBER;
 		/*
 		 * Reject the change if there is exclusive CPUs conflict with
 		 * the siblings.
-- 
2.34.1


