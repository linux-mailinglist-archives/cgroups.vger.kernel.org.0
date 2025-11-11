Return-Path: <cgroups+bounces-11808-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988DCC4E2D1
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 14:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D9D3AC3B6
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF91340281;
	Tue, 11 Nov 2025 13:39:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2465C32471F;
	Tue, 11 Nov 2025 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868375; cv=none; b=jMXOd6en8GGjkfkKMywx34c2tly+b4fkZXWhHiBviJUpJQLJ1sZ25DLxDAGvjYeoSQviFPLMgsbTWfF0mnDM9wjI+4M+J24Ohj/64rvRFx3zpkQeIToET+7kBzWQdq152pRrfFFc3YW+Y31kHE8kt6G75Kdq80T9i8QCaSnzYOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868375; c=relaxed/simple;
	bh=pUpRrqx6uPaYtCYfYiROxokEsn1l4zoEcFa5SFjuin0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q3BGUQnDHuoMf9/BHAjvBLCUrslrZ2sgLOEjrgTV4imW16W7eM3M0lGzQgM9WHIlTDF5QZQlYyHwrqCLqeoyIvQWFNVJCPOL+XYYFxO7/FSNAGaCurQ2frwSzd5oox3xFQoGbzq4aYeyhepKLsrydrIOQhnoAleTm4Xur9zOdf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d5SLV1rKPzKHM0R;
	Tue, 11 Nov 2025 21:39:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 660C81A01A0;
	Tue, 11 Nov 2025 21:39:30 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgBXgF2EPBNpML6FAQ--.14435S2;
	Tue, 11 Nov 2025 21:39:30 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next v2 0/3] cpuset: code cleanups
Date: Tue, 11 Nov 2025 13:24:26 +0000
Message-Id: <20251111132429.950343-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXgF2EPBNpML6FAQ--.14435S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWUZw18tr48JFyDZw4xJFb_yoW3trc_AF
	W8ta45trnrJFWSkFy7AF4rta4qyF4UCF1qya4rtw4UAr9xAF17XrnY9rW2qr95uFZ5Xr17
	J3s0yrZ5ZrnFvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Patch 1 simplifies the error handling path in cpuset_set_nodes() by
returning directly on failure, eliminating an unnecessary jump.

Patch 2 removes the global remote_children list and replaces it with
a boolean remote_partition flag, which provides a more direct way
to identify remote partitions.

Patch 3 removes need_rebuild_sched_domains.

---

v2: Patch 2 moves up 'remote_partition' and removes redundant
    initialization.

Chen Ridong (3):
  cpuset: simplify node setting on error
  cpuset: remove global remote_children list
  cpuset: remove need_rebuild_sched_domains

 kernel/cgroup/cpuset-internal.h | 10 ++++++---
 kernel/cgroup/cpuset.c          | 40 ++++++++++++---------------------
 2 files changed, 21 insertions(+), 29 deletions(-)

-- 
2.34.1


