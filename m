Return-Path: <cgroups+bounces-2352-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6E289A9A7
	for <lists+cgroups@lfdr.de>; Sat,  6 Apr 2024 10:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188601F2232B
	for <lists+cgroups@lfdr.de>; Sat,  6 Apr 2024 08:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA5725763;
	Sat,  6 Apr 2024 08:09:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A00722EED;
	Sat,  6 Apr 2024 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712390956; cv=none; b=V/khBzUeDxjx56PGSE0oDKdZjeWvs3uW5zg/bIX+VJkfPrkdtqPoBnzbosgzh3h3B08zjTTEVpW4yOpirQRx2xoZn1nwEJlVOf+MAVHDL/Ognct1SH4czoWSeR58aqoDl30h3/W9uvjWSFx+VAqg2necTbj1VcnJncOUjIoGEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712390956; c=relaxed/simple;
	bh=h0RhV8ibSEdOVAZU/kaIWg6VheFaanRrzHLKmEQKyOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W0Ic83v5P7lv3r3ISvAOr2ZAtA2gf3kosnCf9RdHLdqhWEn28qxF8u5jTQuQi+K+ZFxWY5uLFbMxhttSH1SyiBeLnkLE7ak/2ePowkM3O4k+snd1A99rdBT5wz7wczGKx03L5pu6rScHwHTNH6Trn1j3k1gQpP92DBJwlf5b+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBSg51sWrz4f3jpk;
	Sat,  6 Apr 2024 16:09:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8F60C1A0175;
	Sat,  6 Apr 2024 16:09:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAjAxFmnZTkJA--.2125S4;
	Sat, 06 Apr 2024 16:09:09 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	chenhuacai@kernel.org,
	tj@kernel.org,
	josef@toxicpanda.com,
	jhs@mojatatu.com,
	svenjoac@gmx.de,
	raven@themaw.net,
	pctammela@mojatatu.com,
	yukuai3@huawei.com,
	qde@naccy.de,
	zhaotianrui@loongson.cn
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	cgroups@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v2 0/6] blk-throttle: support enable and disable during runtime
Date: Sat,  6 Apr 2024 16:00:53 +0800
Message-Id: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAjAxFmnZTkJA--.2125S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw13Kr4UJw1UXFWxXrWrXwb_yoW8Xr47pr
	Waqr15Gr12gFn09Fn3Cw1SgrW8ta95GrWUJ3s8XF4SyryjkryIvFnYvr18ZayIvFW2yF42
	vr15GryIkF1Uu37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	fUOmhFUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Hi, all!

I'm planning to support build all blk-throttle polices as kernel module,
this is the first part for blk-throttle:

- patch 1 remove THROTTLE LOW;
- patch 2 delay initialization from disk initialization to
configuration;
- patch 3-5 support to destroy blk-throttle is it's disabled;
- patch 6 switch blk-throttle to use rq_qos to stop exposing
blk-throttle internal implementations;

Changes from RFV v1:
 - add missing places in patch 1;
 - add patch 2-6;

Yu Kuai (6):
  blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW
  blk-throttle: delay initialization until configuration
  blk-throttle: expand tg_conf_updated() to return if any tg has rules
  blk-cgroup: add a new helper blkg_conf_exit_blkg()
  blk-throttle: support to destroy throtl_data when blk-throttle is
    disabled
  blk-throtl: switch to use rq_qos

 Documentation/ABI/stable/sysfs-block       |   12 -
 arch/loongarch/configs/loongson3_defconfig |    1 -
 block/Kconfig                              |   11 -
 block/bio.c                                |    1 -
 block/blk-cgroup.c                         |   25 +-
 block/blk-cgroup.h                         |    1 +
 block/blk-core.c                           |    4 +-
 block/blk-merge.c                          |    2 +-
 block/blk-mq-debugfs.c                     |    2 +
 block/blk-rq-qos.c                         |   13 +
 block/blk-rq-qos.h                         |   11 +
 block/blk-stat.c                           |    3 -
 block/blk-sysfs.c                          |    9 -
 block/blk-throttle.c                       | 1598 ++++++--------------
 block/blk-throttle.h                       |   76 +-
 block/blk.h                                |   11 -
 block/genhd.c                              |    3 -
 include/linux/blkdev.h                     |    4 -
 18 files changed, 495 insertions(+), 1292 deletions(-)

-- 
2.39.2


