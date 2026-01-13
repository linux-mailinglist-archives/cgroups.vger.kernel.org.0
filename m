Return-Path: <cgroups+bounces-13132-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2DDD16CC2
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 07:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D60C53007539
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 06:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1579369967;
	Tue, 13 Jan 2026 06:19:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CFF368291;
	Tue, 13 Jan 2026 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285198; cv=none; b=Oc30rkaHeSfAYcQOPGU2ac14ckofJTr9LMEjAOA/QjYNhVXoJ1mq929issHLeF49vZIZuRr2s1fLEGjhzY5bHrmnj1s12l6Uz48U0GEds4FEEQjNZ/FK0+aokt8c1EZSR7D67GtZk4Y6oz1blpIN/NI65jiR39Y4C5kyc0S7B0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285198; c=relaxed/simple;
	bh=YeAO4kGVX7bDlbIPutFQICHgao9lVV+Pa11XzN0gnCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FkzDyK/p6MVIw3xfWvUcIgVkN5v0vAXDA8ZA/1ODKOEu1MKL1lSlJvGu4SeyCCXTIOL7tMe/FaFLKm4jmrWRcEWhD0JZsQ5WcwrV88X4GMvc14lPy4CtTNTNI2YLX6y7ivbMsxvG5ssdXrPqjIMV589ffTEDbSFpDX1qu/kUIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dqzbG74k8zKHMZ0;
	Tue, 13 Jan 2026 14:18:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 18AAD40539;
	Tue, 13 Jan 2026 14:19:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgC3ZPX642VpuTeEDg--.370S4;
	Tue, 13 Jan 2026 14:19:39 +0800 (CST)
From: Zheng Qixing <zhengqixing@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	yukuai3@huawei.com,
	hch@infradead.org
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mkoutny@suse.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	zhengqixing@huawei.com
Subject: [PATCH v2 0/3] blk-cgroup: cleanup and bugfixs in blk-cgroup
Date: Tue, 13 Jan 2026 14:10:32 +0800
Message-Id: <20260113061035.1902522-1-zhengqixing@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3ZPX642VpuTeEDg--.370S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1xZF15CrW8Kr17XF4rAFb_yoWxKrg_uF
	y0va48Jw4rZa10kF92yF13XrZ5CFWjgr1UXF1IqrW7Gw17trZ7Xanay398ZF4UuFW7XFyU
	Ja4DCr1kArsrKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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

Changes in v2:
 - Move the cleanup patch to the end of the series and added Reviewed-by
   tags
 - Add blkcg_mutex protection for blkg_list traversal in
   blkcg_activate_policy() in patch 1
 - Add Reviewed-by tags to patch 2

v1:
https://lore.kernel.org/all/20260108014416.3656493-1-zhengqixing@huaweicloud.com/

Zheng Qixing (3):
  blk-cgroup: fix race between policy activation and blkg destruction
  blk-cgroup: skip dying blkg in blkcg_activate_policy()
  blk-cgroup: factor policy pd teardown loop into helper

 block/blk-cgroup.c | 64 +++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

-- 
2.39.2


