Return-Path: <cgroups+bounces-4984-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8443F989D64
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 10:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15B81C21BAF
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14111184528;
	Mon, 30 Sep 2024 08:56:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B81517E8F7;
	Mon, 30 Sep 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686574; cv=none; b=dZBK95L2wQlK1UEwj7eqkdQDQqDygygroDYvv0/mSLsgo2uckkGQnCtzqCOcyBRx5/0L3/5Rugth+XZbV6bLNPhFlOWEQK/Jrf5M1nvND3RZlI0/Mwfbs6c7rtZ8M3BwiqHhA2QlY5J6YXdq8nafrvBOpfRhMAUxpqmKf0sdOjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686574; c=relaxed/simple;
	bh=lUTwDQSqkKGRsIl8wa7PBIeHm8INHd1Lkwaoo3IKbKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f4FPGB+bwtvyeRxnKiyteBnSfoa7OaHJOKMSpGcNR/eHQmuYD+EkYZKP3MarQDq2uOHjv11zYU4BSNjju7pEL6PiUpLZdYdaki6Jddo3B/2jwhJiUNmmu3psyQ0gpIt/rzU2C9K9L2A0n6jIWbxy/nARq+NBD+7gphZFl4vBmJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XHFKN0WMKz4f67pB;
	Mon, 30 Sep 2024 16:55:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 893411A08DC;
	Mon, 30 Sep 2024 16:56:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn28emZ_pmgEUMCw--.63034S4;
	Mon, 30 Sep 2024 16:56:08 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 0/5] blk-cgroup: don't abuse bdi in blk-cgroup
Date: Mon, 30 Sep 2024 16:52:57 +0800
Message-Id: <20240930085302.1558217-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn28emZ_pmgEUMCw--.63034S4
X-Coremail-Antispam: 1UD129KBjvdXoWrur17Zw17Aw1kCrWDJF4DXFb_yoWfWwb_XF
	ykCasYg3Z7Ja93ZFZ3tFnYq3yUKr4jgrWjyasrGrZxAr4fXFs3Jr43tw4kXF45ZF47Gry5
	AryYyr18AF4jvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The bdi_dev_name() should not be used in blk-cgroup code, because bdi is
not related at all, add a new helper to print device name directly from
gendisk. The helper can also fix that "unknown" will be printed for
hidden disks.

Yu Kuai (5):
  blk-cgroup: add a new helper blkg_print_dev_name()
  blk-iocost: use new helper blkg_print_dev_name()
  blk-throttle: use new helper blkg_print_dev_name()
  blk-iolatency: use new helper blkg_print_dev_name()
  blk-cgroup: use new helper blkg_print_dev_name()

 block/blk-cgroup-rwstat.c | 13 +++++++------
 block/blk-cgroup.c        | 19 ++++---------------
 block/blk-cgroup.h        | 13 ++++++++++++-
 block/blk-iocost.c        | 23 ++++++++++++-----------
 block/blk-iolatency.c     | 11 +++++++----
 block/blk-throttle.c      | 15 +++++----------
 6 files changed, 47 insertions(+), 47 deletions(-)

-- 
2.39.2


