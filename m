Return-Path: <cgroups+bounces-9365-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1655BB334C6
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 05:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F961B23CCF
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 03:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ED5253956;
	Mon, 25 Aug 2025 03:38:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746661BD9D0;
	Mon, 25 Aug 2025 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756093126; cv=none; b=EinsCSnJYuU3exvnBYGGWaruGplHbBgOCcvpxVmie4+l5eHhT68wRj2qZB/yBSL/v4vB+uM2A3mlXsxSPnkju0v9p7mSnJ9QQoORixjM12WmRIyH/ULBoSg4ZjGtOUHajsbiX003T0ghTLZte163sPYl+CYbA5q4D8sG5NhJej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756093126; c=relaxed/simple;
	bh=kEWdERmZoL+lU0NtaRGbSj3AZNMJZJyj5GZRsDGCNnc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FsSBJriTacm6Yfocu6J4zNTQtz+bYsHeorZqoTOIWo7Ye9lrr3eU50b1s6kmasz4E9wixyk26Qq35kBa7nJ0pHFMcjvbe3Lsn5xLQAuATHNANhZsMmI2dTQYq4M7a4hvD1y6GqhOPh1TTx0B8tpGWPT+jtOUFc0sKsqF4TyHFGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9GjZ0n1NzKHN2Q;
	Mon, 25 Aug 2025 11:38:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AE22A1A1950;
	Mon, 25 Aug 2025 11:38:41 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDXII2x2qtoTBLUAA--.30877S2;
	Mon, 25 Aug 2025 11:38:41 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next v5 0/3] some optimization for cpuset
Date: Mon, 25 Aug 2025 03:23:49 +0000
Message-Id: <20250825032352.1703602-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXII2x2qtoTBLUAA--.30877S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1rtr4rAF4UAF1rAFWkJFb_yoWfZrb_AF
	y8ZFy8KrnrJF4fta1ayrn5trWkKw4UCr1kAa4DtrsrZF9rArn3Zr1qya4Fvr17ZFWfCr15
	uF9rCrn5Jan7JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUotCzDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

This patch series contains several cpuset improvements:

1. Decouple cpuset and tmpmasks allocation/freeing.
2. Add cpuset_full_[un]lock helpers.

---
v5:
 - add return tag comment for patch 2.

v4:
 - update the commit message for patch 3.

v3:
 - fix typos and comment errors.
 - rename cpus_read_cpuset_[un]lock to cpuset_full_[un]lock

v2:
 - dropped guard helper approach, nusing new helper instead.
 - added patches for decoupling cpuset/tmpmasks allocation


Chen Ridong (3):
  cpuset: decouple tmpmasks and cpumasks freeing in cgroup
  cpuset: separate tmpmasks and cpuset allocation logic
  cpuset: add helpers for cpus read and cpuset_mutex locks

 kernel/cgroup/cpuset-internal.h |   2 +
 kernel/cgroup/cpuset-v1.c       |  12 +-
 kernel/cgroup/cpuset.c          | 219 +++++++++++++++++---------------
 3 files changed, 122 insertions(+), 111 deletions(-)

-- 
2.34.1


