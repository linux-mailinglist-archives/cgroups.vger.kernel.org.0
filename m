Return-Path: <cgroups+bounces-3215-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62E590C24C
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 05:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7187B283CFA
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 03:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC3B19B3D1;
	Tue, 18 Jun 2024 03:18:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FC51C69D;
	Tue, 18 Jun 2024 03:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718680728; cv=none; b=uh4XGc9rwek5BVzvqXlG7W6hB3L2SJwI/d5SpawQyvg5Evh5RCXHYshiNbhgKEyfdcEO3CAMjJLfjm2QvQHl+ztKhndyAou7X7he3nnEK6iKptpT512zJHqla83fdbX5RTtAlgIHBPQbure1aPScv2EsAM1h5fxIvonjIWZEKCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718680728; c=relaxed/simple;
	bh=iJDZc9m2RG0x8XpdmbtTCaEIW8kUeEyAjdeRKO/SaTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iwqavsf+/VWdgubR8cZO3BfvcavZHIIfw3WgJ2UR6LvkBvrtyR8fjS+pt4kgWLwnR5WvpsoYtYvwwY5EvBocHjVGPfDQwirUw54cNyQZdx1iI8AZ8zJO52IJH5wpRBLKife3hLUQIqef3xQGmF+Tc1UPGK2YYCe2JHyPY51NUoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W3Bm36j0fz4f3kvt;
	Tue, 18 Jun 2024 11:18:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A89321A0181;
	Tue, 18 Jun 2024 11:18:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXAQ+N_HBmFJj8AA--.12964S4;
	Tue, 18 Jun 2024 11:18:39 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	gregkh@linuxfoundation.org,
	bvanassche@acm.org,
	hch@infradead.org,
	josef@toxicpanda.com,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v2 0/7] blk-iocost: support to build iocost as kernel module
Date: Tue, 18 Jun 2024 11:17:44 +0800
Message-Id: <20240618031751.3470464-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXAQ+N_HBmFJj8AA--.12964S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4rKw18AF45Xr18XrW8WFg_yoW8Xr4UpF
	sIgr15Cay7Grs7J3WfGw1293Wftw4kWFWrJ3ZxXr95Aw17JF1Iy3Wvv348G34xZFW7Ar4Y
	gFW3Jry3Kr1ayFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UQvtAUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes from RFC v1:
 - replace the first patch.
 - add commit message of our motivation and advantages to build iocost
 as kernel module.

The motivation is that iocost is not used widely in our production, and
some customers don't want to increase kernel size to enable iocost that
they will never use, and it'll be painful to maintain a new downstream
kernel. Hence it'll be beneficially to build iocost as kernel module:

- Kernel Size and Resource Usage, modules are loaded only when their
specific functionality is required.

- Flexibility and Maintainability, allows for dynamic loading and unloading
of modules at runtime without the need to recompile and restart the kernel,
for example we can just replace blk-iocost.ko to fix iocost CVE in our
production environment.

Yu Kuai (7):
  blk-cgroup: add a new helper pr_cont_blkg_path()
  cgroup: export cgroup_parse_float
  block: export some API
  blk-iocost: factor out helpers to handle params from ioc_qos_write()
  blk-iocost: parse params before initializing iocost
  blk-iocost: support to free iocost
  blk-iocost: support to build iocost as kernel module

 block/Kconfig             |   2 +-
 block/blk-cgroup.c        |  10 ++
 block/blk-cgroup.h        |   1 +
 block/blk-iocost.c        | 225 ++++++++++++++++++++++++++------------
 block/blk-rq-qos.c        |   2 +
 include/linux/blk_types.h |   2 +-
 kernel/cgroup/cgroup.c    |   1 +
 7 files changed, 170 insertions(+), 73 deletions(-)

-- 
2.39.2


