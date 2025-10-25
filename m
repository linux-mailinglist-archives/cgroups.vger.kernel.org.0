Return-Path: <cgroups+bounces-11158-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A55EEC08C99
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 09:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1487D3510EA
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 07:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1AA2DCBF3;
	Sat, 25 Oct 2025 07:03:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A64A2512EE;
	Sat, 25 Oct 2025 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375835; cv=none; b=YP+q9ugvefAZxUkEapHLnXy+O32OKZ4Kaix/TLdy3GMK5gVgsCwbA2F0Q6qeXtJcbnMCMGXzlftbOyRIuWeYkqL8uMk0BHMe4Dk/QwO056+Butj1deseut5HH3iiRSzVER9/4WWTy37Y+hBpvoTb8FVhE6dEu7ffsKHrtPDZi1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375835; c=relaxed/simple;
	bh=VUCkL1G2EBUWyn9nn3uK4N45ALqDuTK7WjoReHz3Mek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vq7xU2cTfmAqzbH+NqXGvjoggXpY4SpV82tGepdcIHEtG8xUd9yvZjZkuITf25aKfknYI/+kELzgUnW5GkiDlOHxGnmBiv7thvz8+cK77n4UWz8KusWxmGaXZxAsNcHLO93rywqfZrL3jrgCBXir1tlj9U2LoaMby3/vN+xIn+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctrM56rMTzKHMYH;
	Sat, 25 Oct 2025 15:02:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D815E1A121F;
	Sat, 25 Oct 2025 15:03:49 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHKUJGdvxovSssBg--.49460S2;
	Sat, 25 Oct 2025 15:03:49 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH RFC v2 00/22] cpuset: rework local partition logic
Date: Sat, 25 Oct 2025 06:48:22 +0000
Message-Id: <20251025064844.495525-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHKUJGdvxovSssBg--.49460S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr15CrWxZFWUAr4DJw1DKFg_yoW5ur1rpF
	y3GaySy34UGry5C3srJan7Aw4FgwsrJa4Utwnxu348Xr13Aw1vya40y395Za47Wr9rZryU
	Z3ZrWr48X3W7u3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
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

1. Fix a bug that isolcpus stat in root partition.

2. Infrastructure Preparation (Patches 2-3):
   - Code cleanup and preparation for the refactoring work

3. Introduce partition operation helpers (Patches 4-6):
   - Intoduce out partition_enable(), partition_disable(), and
     partition_update() functions.

4. Use new helpers for remote partition (Patches 7-9)

5. Local Partition Implementation (Patches 10-13):
   - Separate update_parent_effective_cpumask() into dedicated functions:
     * local_partition_enable()
     * local_partition_disable()
     * local_partition_invalidate()
     * local_partition_update()

6. Optimization and Cleanup (Patches 14-22):
   - Remove redundant partition-related operations
   - Additional optimizations based on the new architecture

---

Changes in v2:
- Added bugfix for root partition isolcpus at series start.
- Completed helper function implementations when first introduced.
- Split larger patches into smaller, more reviewable units.
- Incorporated feedback from Longman.

Chen Ridong (22):
  cpuset: fix isolcpus stay in root when isolated partition changes to
    root
  cpuset: add early empty cpumask check in partition_xcpus_add/del
  cpuset: generalize validate_partition() interface
  cpuset: introduce partition_enable()
  cpuset: introduce partition_disable()
  cpuset: introduce partition_update()
  cpuset: use partition_enable() for remote partition enablement
  cpuset: use partition_disable() for remote partition disablement
  cpuset: use partition_update() for remote partition update
  cpuset: introduce local_partition_enable()
  cpuset: introduce local_partition_disable()
  cpuset: introduce local_partition_invalidate()
  cpuset: introduce local_partition_update()
  cpuset: remove update_parent_effective_cpumask
  cpuset: remove redundant partition field updates
  cpuset: simplify partition update logic for hotplug tasks
  cpuset: unify local partition disable and invalidate
  cpuset: use partition_disable for compute_partition_effective_cpumask
  cpuset: use validate_local_partition in local_partition_enable
  cpuset: introduce validate_remote_partition
  cpuset: simplify update_prstate() function
  cpuset: remove prs_err clear when notify_partition_change

 kernel/cgroup/cpuset.c | 1000 +++++++++++++++++++---------------------
 1 file changed, 463 insertions(+), 537 deletions(-)

-- 
2.34.1


