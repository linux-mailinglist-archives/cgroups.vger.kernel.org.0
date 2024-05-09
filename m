Return-Path: <cgroups+bounces-2832-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F068C0F89
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 14:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A041C21FF8
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 12:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6223C149DEB;
	Thu,  9 May 2024 12:21:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508C514B95A;
	Thu,  9 May 2024 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257280; cv=none; b=ObOY/NE/ikqP7qZxqLWLFj8XEdTeWp5DrGt0gDOXbWBbTVIncL9M/AXOptFSkk+cVBCpY+2DobAwtTESzYIfSX8ET83nOsC9E0k+ZcYMffJjAvhCScICSQ2LrZquozgCQWAvi34C1c2RhM+dHkVdGMP8uGgiXEJf3cRKf5Hxrzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257280; c=relaxed/simple;
	bh=FBOz4KJeoP60Kqz3cObH8n4DVo36OPuIdh1Oe10s+Fo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pVl93QwMSaSA6Y2bE0F8Y4qzb3p7XGFW/bpewPvRkjYjwwtp+2Uxsf4N8VCXfGy97/3fCM4+CRDUz0sgtD7/we0lNxHAa0l6jzAnJtGHaWmfaxOGehipZadxcfaH55dBJcBUwKUML+Swpuj03PFn6z+M/frpIQqrDjbndC8QaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VZrhf6s90z4f3jcq;
	Thu,  9 May 2024 20:21:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4FBE61A0F2D;
	Thu,  9 May 2024 20:21:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ63vzxm7lfBMA--.51358S4;
	Thu, 09 May 2024 20:21:13 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	chenhuacai@kernel.org,
	tj@kernel.org,
	josef@toxicpanda.com,
	victor@mojatatu.com,
	raven@themaw.net,
	yukuai3@huawei.com,
	twoerner@gmail.com,
	zhaotianrui@loongson.cn,
	svenjoac@gmx.de,
	jhs@mojatatu.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	cgroups@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH for-6.10/block 0/2] blk-throtl: delete throtl low and lay initialization
Date: Thu,  9 May 2024 20:11:05 +0800
Message-Id: <20240509121107.3195568-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ63vzxm7lfBMA--.51358S4
X-Coremail-Antispam: 1UD129KBjvdXoWrurWDur43XFWfXF1xCw4Durg_yoWfJrc_XF
	98C3WkJFn7Aw1kC3yUtr95uFnFk342gr1jgFyYyFW7XFn7X3ZrAws3tr4a9rsxua95Crsx
	JrWkXF1DZr1IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	QVy7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Tested with the new blktests:

https://lore.kernel.org/all/20240420084505.3624763-1-yukuai1@huaweicloud.com/

Changes from RFC:
 - remove patches to support build blk-throtl as module;
 - add ack tag for patch 1, also rebase on the top of for-6.10/block;
 - some small changes for patch 2;

Yu Kuai (2):
  blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW
  blk-throttle: delay initialization until configuration

 Documentation/ABI/stable/sysfs-block       |  12 -
 arch/loongarch/configs/loongson3_defconfig |   1 -
 block/Kconfig                              |  11 -
 block/bio.c                                |   1 -
 block/blk-cgroup.c                         |   6 -
 block/blk-stat.c                           |   3 -
 block/blk-sysfs.c                          |   8 -
 block/blk-throttle.c                       | 996 +++------------------
 block/blk-throttle.h                       |  46 +-
 block/blk.h                                |  11 -
 10 files changed, 127 insertions(+), 968 deletions(-)

-- 
2.39.2


