Return-Path: <cgroups+bounces-3167-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87292906154
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 03:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F10B21F8D
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 01:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6581A28D;
	Thu, 13 Jun 2024 01:50:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5815E85;
	Thu, 13 Jun 2024 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243419; cv=none; b=eyvNDnqpInP37UPgCZs7sg2IfB+r5JIasFqmpYrg05VNGMQCt3l39K58OyKAVzU2sy/X1+h8UbXO0h0jnfenp0oWIGxDM3aKRrrNHva9vQIr0Ywfgu3OAM5/9U7L30OH2jFrHyHslYXna7GF/xnLOdbz5YtPt6hjK9JHSmGROKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243419; c=relaxed/simple;
	bh=wYp9YQpTchpbL1P9Xzk13haoIGQ94SA7dohMtJPHVAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aPlTrWgj9IBkDeW+8u5EWJNd+apSehP4sHGXpb86xZ67FpPIcw5N7c8vgG+PBDs4V1FEUfZsyQORimfqG1FniOKWveNUV88Wl5Tx7mhGdSrW07f37mCdc2y1NRCr0NWnITVqb5GcccFya7i4kcHvo0VRU5VlMf7yrc7hzW3hhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W052J5rXmz4f3kKb;
	Thu, 13 Jun 2024 09:50:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 68A051A0EFE;
	Thu, 13 Jun 2024 09:50:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFNUGpm3eFSPQ--.6570S4;
	Thu, 13 Jun 2024 09:50:07 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	gregkh@linuxfoundation.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC -next 0/7] blk-iocost: support to build iocost as kernel module
Date: Thu, 13 Jun 2024 09:49:30 +0800
Message-Id: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBFNUGpm3eFSPQ--.6570S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JFW8Gr1kZF43GFWUur1xKrg_yoWxCrb_ZF
	95JFyFqr1xGFy7ZFyrtFs8trWUKr4rXr4jva4UJrW7JF17tFn0ywsxXr4kXrsxuF45Gr98
	CFy7XF97JFnrXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	XdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Yu Kuai (7):
  kernfs: export pr_cont_kernfs_path()
  cgroup: export cgroup_parse_float
  block: export some API
  blk-iocost: factor out helpers to handle params from ioc_qos_write()
  blk-iocost: parse params before initializing iocost
  blk-iocost: support to free iocost
  blk-iocost: support to build iocost as kernel module

 block/Kconfig             |   2 +-
 block/blk-cgroup.c        |   4 +
 block/blk-iocost.c        | 223 ++++++++++++++++++++++++++------------
 block/blk-rq-qos.c        |   2 +
 fs/kernfs/dir.c           |   1 +
 include/linux/blk_types.h |   2 +-
 kernel/cgroup/cgroup.c    |   1 +
 7 files changed, 163 insertions(+), 72 deletions(-)

-- 
2.39.2


