Return-Path: <cgroups+bounces-12703-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6493BCDDC42
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 13:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E9343016CFB
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 12:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35471E5B73;
	Thu, 25 Dec 2025 12:45:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3293A1E69;
	Thu, 25 Dec 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766666755; cv=none; b=BdfJdeWLawQY8bxCneqeuG4OHZIhiHZwXbA8Py+x4niZR12iLEBcMn8KbyOWElzOGyX2Knid+Ui3TG6nYENTDpr1UELDpv6ICoDhMXoZ0gboaVohwDLWDjbFyD1DUs4h7IwYl1JDts9aKzKnglNI+Ig9rIyG3aKN43549V0IGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766666755; c=relaxed/simple;
	bh=WicAJG6gQgRoPhd/33P248Hfzrty3g1jIFiGxt8pt7I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=adTW/57qOPUReO4e+Geq8Qxkc/DewKD3grIyqqclD/vVgnQf+qiIaMcqVAY1Ol7NAyQvNA2kO9lh0C0zXw3JduidPh1rsQHzBVPTLWI5ttDjpH6cwHO8mIVzFf34CtUBTepdJWc4CZ3SXUmRj46J7JBvvUw93EpGyGIZKS1dsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dcT494R9czKHMSb;
	Thu, 25 Dec 2025 20:45:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ECB8E4056D;
	Thu, 25 Dec 2025 20:45:50 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHdfb1MU1pT76_BQ--.27441S2;
	Thu, 25 Dec 2025 20:45:50 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH RESEND -next 00/21] cpuset: rework local partition logic
Date: Thu, 25 Dec 2025 12:30:37 +0000
Message-Id: <20251225123058.231765-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHdfb1MU1pT76_BQ--.27441S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr15CrWxZFWUAr4DJw1DKFg_yoWrJr13pF
	y3GaySyryUGry5C39rXa1xAw4FgwsrJa4Utwnxu348Xr1ayw1vya40v395ZayUWr9rZryU
	ZFnrWr48X3WUuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUU
	UUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The current local partition implementation consolidates all operations
(enable, disable, invalidate, and update) within the large
update_parent_effective_cpumask() function, which exceeds 300 lines.
This monolithic approach has become increasingly difficult to understand
and maintain. Additionally, partition-related fields are updated in
multiple locations, leading to redundant code and potential corner case
oversights.

This patch series refactors the local partition logic by separating
operations into dedicated functions: local_partition_enable(),
local_partition_disable(), and local_partition_update(), creating
symmetry with the existing remote partition infrastructure.

The series is organized as follows:

1. Infrastructure Preparation (Patches 1-2):
   - Code cleanup and preparation for the refactoring work

2. Introduce partition operation helpers (Patches 3-5):
   - Introduce out partition_enable(), partition_disable(), and
     partition_update() functions.

3. Use new helpers for remote partition (Patches 6-8)

4. Local Partition Implementation (Patches 9-12):
   - Separate update_parent_effective_cpumask() into dedicated functions:
     * local_partition_enable()
     * local_partition_disable()
     * local_partition_update()

5. Optimization and Cleanup (Patches 13-21):
   - Remove redundant partition-related operations
   - Additional optimizations based on the new architecture

base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8

---

Changes in RESEND:
1. Rebase on the next-20251219

Changes from RFC v2:
1. Dropped the bugfix (already merged/fixed upstream)
2. Rebased onto next
3. Introduced partition_switch to handle root state switches
4. Directly use local_partition_disable()—no longer first introduce
   local_partition_invalidate() before unifying the two
5. Incorporated modifications based on Longman's suggestions

Changes in RFC v1:
1. Added bugfix for root partition isolcpus at series start.
2. Completed helper function implementations when first introduced.
3. Split larger patches into smaller, more reviewable units.
4. Incorporated feedback from Longman.

Chen Ridong (21):
  cpuset: add early empty cpumask check in partition_xcpus_add/del
  cpuset: generalize the validate_partition() interface
  cpuset: introduce partition_enable()
  cpuset: introduce partition_disable()
  cpuset: introduce partition_update()
  cpuset: use partition_enable() for remote partition enablement
  cpuset: use partition_disable() for remote partition disablement
  cpuset: use partition_update() for remote partition update
  cpuset: introduce local_partition_enable()
  cpuset: introduce local_partition_disable()
  cpuset: user local_partition_disable() to invalidate local partition
  cpuset: introduce local_partition_update()
  cpuset: remove update_parent_effective_cpumask
  cpuset: remove redundant partition field updates
  cpuset: simplify partition update logic for hotplug tasks
  cpuset: use partition_disable for compute_partition_effective_cpumask
  cpuset: use validate_local_partition in local_partition_enable
  cpuset: introduce validate_remote_partition
  cpuset: simplify the update_prstate() function
  cpuset: remove prs_err clear when notify_partition_change
  cpuset: Remove unnecessary validation in partition_cpus_change

 kernel/cgroup/cpuset.c | 1023 ++++++++++++++++++----------------------
 1 file changed, 454 insertions(+), 569 deletions(-)

-- 
2.34.1


