Return-Path: <cgroups+bounces-12957-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20341D009E6
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 03:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20C7B3008558
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 02:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80715248861;
	Thu,  8 Jan 2026 02:13:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD41F4168;
	Thu,  8 Jan 2026 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767838393; cv=none; b=usqA9HbAdHvhlw+W1zifNby1Nic4O5VhIjIq8h/eAcwMvWNRQbGv5qCMM6kEfe7JQg6WlAbsFbktfJYzsxgW2W41z4ZhzuzPVdlCyeQv1KYJd/B+JeEIctnZytaZk7O31IBP+/oEkd0yIbPyKMwHHLiVntMQ2Ddu+kcD7UA+aWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767838393; c=relaxed/simple;
	bh=RLcMg3grPexfbM2TmCCRtpJOZq4fw4amoYAWLVmrMBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=otVjqbro+/y/0sn//pio9pC2G7l7po/hzCgdNnez12ymH427J7Djb8Uho7bulWwiPDDJNnLM545THhAKDEEAqg8sB8f2BBI777wKdDX1bM2QaIJ+Vo7F1tCqLNAXUlou2o5DeFMTDQY6bnifrPda7vKvPL13vEzzNTByFaKxKDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dmnwq2PTXzYQtvC;
	Thu,  8 Jan 2026 09:52:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 31CF84058D;
	Thu,  8 Jan 2026 09:53:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgAXd_f8DV9pVBQTDA--.41552S4;
	Thu, 08 Jan 2026 09:53:02 +0800 (CST)
From: Zheng Qixing <zhengqixing@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	yukuai@fnnas.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	zhengqixing@huawei.com
Subject: [PATCH 0/3] blk-cgroup: cleanup and bugfixs in blk-cgroup
Date: Thu,  8 Jan 2026 09:44:13 +0800
Message-Id: <20260108014416.3656493-1-zhengqixing@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXd_f8DV9pVBQTDA--.41552S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtFyUAFy5KFyfXryxCFW3KFg_yoWxCwc_uF
	yvyFy8Xw45ZF4fCFZ3tFnxXryUCr4UWr40vF1IgrW7Jry3XrsxJ3ZFy3y5XF1xZFW3JFy5
	Jryqqr4kArnFkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07ULdbbUUUUU=
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

From: Zheng Qixing <zhengqixing@huawei.com>

Hi,

This series contains three patches.

Patch 1 is a cleanup change which extracts the common teardown sequence
into a helper.

Patches 2 and 3 fix a use-after-free issue triggered by the concurrency
between switching the device I/O scheduler and blkcg deletion.

Zheng Qixing (3):
  blk-cgroup: factor policy pd teardown loop into helper
  blk-cgroup: fix uaf in blkcg_activate_policy() racing with
    blkg_free_workfn()
  blk-cgroup: skip dying blkg in blkcg_activate_policy()

 block/blk-cgroup.c | 63 +++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

-- 
2.39.2


