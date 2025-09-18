Return-Path: <cgroups+bounces-10257-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341C7B849F6
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 14:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B5187B245F
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 12:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F183043C6;
	Thu, 18 Sep 2025 12:40:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2206B2DF6E6;
	Thu, 18 Sep 2025 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199254; cv=none; b=GDnJpV9HLPsOvqNQw3sdwcc7yWtbM25+urqAwcQGSVfvR1Y/yV/N7tuOogSRsdhW9LhzQ+dIDBAHP75rEPBTgfhXZwF5ufpsRbi7xPhPy3CpJZUEkGfaD3fX3t7n28kLQEZbIn2qMQXXUF4SP+ZE+VwkHxDEA3TxMO0sZPIzzq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199254; c=relaxed/simple;
	bh=ZhlO110Q6q8JUkahnW9guMhMkWMo5MpIvsMtRhMIolk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pBxzqkZj8VtxDXIHWJhKgzMDz5I5brZKTrjodQ6U8OFSu49JQXoFzYtLCxSSuw3r0w1pdcwf7Qg+Uy2gsU0aULR+AqxQQ70dmGelkqgPSHKeTDNyVsroQu650cqE40gT4VwjU+J5oZDrjrAGxjrJjpoCh6Hgxi3h6rDA9gdyMP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cSFc23fSxzYQtpK;
	Thu, 18 Sep 2025 20:40:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2495F1A0F88;
	Thu, 18 Sep 2025 20:40:49 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCX4RXF_ctoY2EDAA--.7338S3;
	Thu, 18 Sep 2025 20:40:49 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH cgroup/for-next 1/2] cpuset: fix failure to enable isolated partition when containing isolcpus
Date: Thu, 18 Sep 2025 12:25:31 +0000
Message-Id: <20250918122532.2981503-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918122532.2981503-1-chenridong@huaweicloud.com>
References: <20250918122532.2981503-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCX4RXF_ctoY2EDAA--.7338S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urW5ZFWDJw4xZF43JF4Dtwb_yoW8Kr1xpF
	WUCry3J398ur15Cay2q3Z7u34YganrJF17t3ZxGw1xZFnrXa4vkFyjk39xJa45J3s5G345
	ZFya9r4fWa4DAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	7qjgUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The 'isolcpus' parameter specified at boot time can be assigned to an
isolated partition. While it is valid put the 'isolcpus' in an isolated
partition, attempting to change a member cpuset to an isolated partition
will fail if the cpuset contains any 'isolcpus'.

For example, the system boots with 'isolcpus=9', and the following
configuration works correctly:

  # cd /sys/fs/cgroup/
  # mkdir test
  # echo 1 > test/cpuset.cpus
  # echo isolated > test/cpuset.cpus.partition
  # cat test/cpuset.cpus.partition
  isolated
  # echo 9 > test/cpuset.cpus
  # cat test/cpuset.cpus.partition
  isolated
  # cat test/cpuset.cpus
  9

However, the following steps to convert a member cpuset to an isolated
partition will fail:

  # cd /sys/fs/cgroup/
  # mkdir test
  # echo 9 > test/cpuset.cpus
  # echo isolated > test/cpuset.cpus.partition
  # cat test/cpuset.cpus.partition
  isolated invalid (partition config conflicts with housekeeping setup)

The issue occurs because the new partition state (new_prs) is used for
validation against housekeeping constraints before it has been properly
updated. To resolve this, move the assignment of new_prs before the
housekeeping validation check when enabling a root partition.

Fixes: 11e5f407b64a ("cgroup/cpuset: Keep track of CPUs in isolated partitions")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 44231cb1d83f..2b7e2f17577e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1806,6 +1806,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		xcpus = tmp->delmask;
 		if (compute_excpus(cs, xcpus))
 			WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
+		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
 
 		/*
 		 * Enabling partition root is not allowed if its
@@ -1838,7 +1839,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 
 		deleting = true;
 		subparts_delta++;
-		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
 	} else if (cmd == partcmd_disable) {
 		/*
 		 * May need to add cpus back to parent's effective_cpus
-- 
2.34.1


