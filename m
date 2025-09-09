Return-Path: <cgroups+bounces-9799-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0E6B4A043
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 05:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F9E7AF813
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 03:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEB42DCF4D;
	Tue,  9 Sep 2025 03:48:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EB82571DC;
	Tue,  9 Sep 2025 03:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389681; cv=none; b=gyIceIHZ7bPxOTt/22DYrSmjWTwrhk2PKn3R4u0ZUHHDA/Q8MpF/c2zNff8Ycmz4FvKRz7ua5IgW8G52wtTfut91stzrt0PUXS81ZxdNRLskYgo8q9c6JP2QBbhb3Y5R5jttvHXhw7MJT1HbwlX+NN32UThbixQW+HCjuRElTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389681; c=relaxed/simple;
	bh=fmitcViLjI9lShqiC0YptWK20Iw11nsSEgUdpLizCGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lU93WmiPZ5AclMQmXpYl1Xx0ifqnZOUNBuESk+e8tRs+Zqw6WGrO8oB77NMBOMiSDgWFkSQ4e68soXXpxepyEMiMX8rht05SuHlPpeorCwZ01Vxx5STp6N76oMu9qzQlgZ+HrBuqWSH/MYbJprijw7pnqUtyUPAr1UE2yxPB+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cLVCH3c37zKHMlJ;
	Tue,  9 Sep 2025 11:47:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A3C4A1A0BC9;
	Tue,  9 Sep 2025 11:47:55 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP1 (Coremail) with SMTP id cCh0CgAnM3lOo79oBVdmBw--.63383S2;
	Tue, 09 Sep 2025 11:47:55 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next RFC -v2 00/11] Refactor cpus mask setting
Date: Tue,  9 Sep 2025 03:32:22 +0000
Message-Id: <20250909033233.2731579-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnM3lOo79oBVdmBw--.63383S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4kZF1UJw18uw1kCF45ZFb_yoW8uF1UpF
	yakw13A348Gr13CanrJwn7Wr4Yga1kJ3W7tFnxtw1xKry293WqyryvyasxCFy3Gr9xCw1U
	ZanIqFs7uF9rA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

This patch series refactors the CPU mask configuration logic for both
cpuset.cpus and cpuset.cpus.exclusive settings. The primary goal is to
improve code readability through comprehensive function restructuring.

The CPU mask update process follows these steps:
1. Parse user input
2. Skip processing if no actual change to CPU mask
3. Compute trial cpuset's effective exclusive CPUs
4. Validate changes and return error if invalid
5. Handle partition state changes resulting from CPU mask modifications
6. Apply new CPU mask to the cpuset
7. Propagate changes through the hierarchy

The series is organized as follows:
patches 1-3: Code cleanup and preparation for refactoring
patches 4-9: Refactoring of cpuset.cpus configuration logic
patches 10-11: Refactoring of cpuset.cpus.exclusive configuration logic

---

Changes from v1:
- Patch 1: Use direct comparison (cs == &top_cpuset) instead of the
           cpuset_is_root() helper function
- Patch 6: Updated comments for better clarity
- Patch 7: Refactored validate_partition to replace the previous
           invalidate_cs_partition implementation
- Patch 8: Renamed acpus_validate_change to cpus_allowed_validate_change
- Patch 9: Updated commit message with more detailed information

Chen Ridong (11):
  cpuset: move the root cpuset write check earlier
  cpuset: remove unused assignment to trialcs->partition_root_state
  cpuset: change return type of is_partition_[in]valid to bool
  cpuset: Refactor exclusive CPU mask computation logic
  cpuset: refactor CPU mask buffer parsing logic
  cpuset: introduce cpus_excl_conflict and mems_excl_conflict helpers
  cpuset: refactor out validate_partition
  cpuset: refactor cpus_allowed_validate_change
  cpuset: refactor partition_cpus_change
  cpuset: use parse_cpulist for setting cpus.exclusive
  cpuset: use partition_cpus_change for setting exclusive cpus

 kernel/cgroup/cpuset.c | 451 ++++++++++++++++++++++-------------------
 1 file changed, 247 insertions(+), 204 deletions(-)

-- 
2.34.1


