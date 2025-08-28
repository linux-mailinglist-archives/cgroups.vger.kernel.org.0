Return-Path: <cgroups+bounces-9466-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D6DB39E44
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 15:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC2A16EBA6
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 13:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A303115B5;
	Thu, 28 Aug 2025 13:11:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3503112BF;
	Thu, 28 Aug 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386695; cv=none; b=uhcm+Mt264XurcaFlNk1RAXM3oxjlkJHvsx7daa9ifrR/ZdhX16p2KUcsu9ee2IIf4+gLdlXqBq1XO1uJ+gHZzX4lyg3eLgeLB1meoRtc8dK4UhIda2+znAf3eZS3MAwKBfL84Jiu4HLkVwXhYvFIlLvKfN/TLp0tSDOs7rsgBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386695; c=relaxed/simple;
	bh=M/NChHRMz1EubjxSqT312/k/skbF330zOVG9sCmDxEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CiOUfoqKzYGv7Nae8pg2Zhq3EH50FW2E96SoCpxjDwlWetP00YB10jb9l2MvbjDztB2r7BUzLTp3+iECLy2JFm1CUylbo8Qg9dZgi7/BZIWbZ6gdCytpepoR7tmsqqhVcj3Yg04/uiIJ4WLrn5wXSJQm1UuoPw9IXN2eNhGMM1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cCMH85wSwzYQvdM;
	Thu, 28 Aug 2025 21:11:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5A0C71A1356;
	Thu, 28 Aug 2025 21:11:31 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgBX8mlsVbBoQsxPAg--.40352S2;
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
Subject: [PATCH -next RFC 00/11] Refactor cpus mask setting
Date: Thu, 28 Aug 2025 12:56:20 +0000
Message-Id: <20250828125631.1978176-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBX8mlsVbBoQsxPAg--.40352S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4kZF1UJw18uw1kCF45ZFb_yoW8Ww15pF
	yakF13Ary8Gr1akanxJ397Wr4Yga1ktF47tFy3K34xKry7ZF1qyryvyasxuFy3GF9xCw1U
	XanIqFs29FnrA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Chen Ridong (11):
  cpuset: move the root cpuset write check earlier
  cpuset: remove unused assignment to trialcs->partition_root_state
  cpuset: change return type of is_partition_[in]valid to bool
  cpuset: Refactor exclusive CPU mask computation logic
  cpuset: refactor CPU mask buffer parsing logic
  cpuset: introduce cpus_excl_conflict and mems_excl_conflict helpers
  cpuset: refactor out invalidate_cs_partition
  cpuset: refactor acpus_validate_change
  cpuset: refactor partition_cpus_change
  cpuset: use parse_cpulist for setting cpus.exclusive
  cpuset: use partition_cpus_change for setting exclusive cpus

 kernel/cgroup/cpuset.c | 443 ++++++++++++++++++++++-------------------
 1 file changed, 239 insertions(+), 204 deletions(-)

-- 
2.34.1


