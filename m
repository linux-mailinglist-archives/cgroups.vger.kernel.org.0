Return-Path: <cgroups+bounces-8521-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D49AD9BC2
	for <lists+cgroups@lfdr.de>; Sat, 14 Jun 2025 11:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12B9189611C
	for <lists+cgroups@lfdr.de>; Sat, 14 Jun 2025 09:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B67F1B4236;
	Sat, 14 Jun 2025 09:31:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49CA2E11B1;
	Sat, 14 Jun 2025 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749893507; cv=none; b=Lnkig/O2FTE4H2pkESgAEl4EA3LRiY7I5OWdHeeBGl1htbboHJqYbirvALcaKptpUdWTzSnmI+d3AsQESlHnH8F6ZrqCzvZpcaQu/1ervzgYIqheqI9u8Z3QFBjuG5BBsCbqmVvtbQBtU+lEFibynJDVJuXLCKkIWk2C7Vhx1qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749893507; c=relaxed/simple;
	bh=JshamBfwvE68wdRFcf5ss03G78d6bXwNFx1IUnHVYcI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HCnmiinMPdJeDPBuvl+l8DoLhG4yqCOr7yuUekd4rQHGseSn9EFBTzjSFlfKM3gTGbPfg7glnPVbUF3Rl3c+RwstJg6jHG6Dww1RVSaOXRqSEBaI4TzBUPeqsgpEGs9I7Pw8M5KdpxzYSlx+0Vcg5HkcMXVVz24UK9yT6lOjfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bK9y71XjZzYQv24;
	Sat, 14 Jun 2025 17:31:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2F2C21A0F46;
	Sat, 14 Jun 2025 17:31:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAni19zQU1oHxfvPQ--.9099S4;
	Sat, 14 Jun 2025 17:31:41 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: ming.lei@redhat.com,
	yukuai3@huawei.com,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC v2 0/5] blk-mq-sched: support request batch dispatching for sq elevator
Date: Sat, 14 Jun 2025 17:25:23 +0800
Message-Id: <20250614092528.2352680-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni19zQU1oHxfvPQ--.9099S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw17Kry8uFWrJF1DAw47Jwb_yoW8AF4Upr
	WfG3ZxKr1DWFnIqryS9w17Jw1rG3y8Wry3JrsxJF48tr17Ar17XF1vq3W8ZFW7XryfJFsr
	W3WDJF93GFyUC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoWlkDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Before this patch, each dispatch context will hold a global lock to
dispatch one request at a time, which introduce intense lock competition:

lock
ops.dispatch_request
unlock

Hence support dispatch a batch of requests while holding the lock to
reduce lock contention.

nullblk setup:
modprobe null_blk nr_devices=0 &&
    udevadm settle &&
    cd /sys/kernel/config/nullb &&
    mkdir nullb0 &&
    cd nullb0 &&
    echo 0 > completion_nsec &&
    echo 512 > blocksize &&
    echo 0 > home_node &&
    echo 0 > irqmode &&
    echo 128 > submit_queues &&
    echo 1024 > hw_queue_depth &&
    echo 1024 > size &&
    echo 0 > memory_backed &&
    echo 2 > queue_mode &&
    echo 1 > power ||
    exit $?

Test script:
fio -filename=/dev/$disk -name=test -rw=randwrite -bs=4k -iodepth=32 \
  -numjobs=16 --iodepth_batch_submit=8 --iodepth_batch_complete=8 \
  -direct=1 -ioengine=io_uring -group_reporting -time_based -runtime=30

Test result(elevator is deadline): iops
|                 | null_blk | scsi hdd |
| --------------- | -------- | -------- |
| before this set | 263k     | 24       |
| after this set  | 475k     | 272      |

Yu Kuai (5):
  elevator: introduce global lock for sq_shared elevator
  mq-deadline: switch to use elevator lock
  block, bfq: switch to use elevator lock
  blk-mq-sched: refactor __blk_mq_do_dispatch_sched()
  blk-mq-sched: support request batch dispatching for sq elevator

 block/bfq-cgroup.c   |   4 +-
 block/bfq-iosched.c  |  53 ++++------
 block/bfq-iosched.h  |   2 +-
 block/blk-mq-sched.c | 226 +++++++++++++++++++++++++++++--------------
 block/blk-mq.c       |   5 +-
 block/blk-mq.h       |  21 ++++
 block/elevator.c     |   1 +
 block/elevator.h     |  61 +++++++++++-
 block/mq-deadline.c  |  58 +++++------
 9 files changed, 282 insertions(+), 149 deletions(-)

-- 
2.39.2


