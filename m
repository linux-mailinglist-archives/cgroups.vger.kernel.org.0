Return-Path: <cgroups+bounces-8926-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882C8B15AAF
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 10:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284083AE4C1
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 08:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127E829B778;
	Wed, 30 Jul 2025 08:29:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EF9292B43;
	Wed, 30 Jul 2025 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864144; cv=none; b=UfIhxd2of0gn+3RHll+vfz8nlhmTdqOkDjyYQwEyvnAsbxOusljnTPu4ohGIbt/o5glP9/sX25BUTdC+1ztnjCV7sN3fybHyIQYAXVfY0LLW3Y5E6hMNaiQ/mE0ywAUaBID2Wd3KRgDPVQ1HhsTsfAX4jHq4z4HflbEsn6RRJRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864144; c=relaxed/simple;
	bh=tFNZP/sFwuWDQj8EkBPFt3c6SYzQt4ofWGQ0udUkyVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rn2BMnfe1qmG7Pyg2+lqVYNnj35uGim9phL5qbEjMWmLu7BMcKeSpEKSfTO7fnvLV+99MehPisq7DqFq9Md7tgSpeHjrYa3f8P051U0KJ3p3g1sQCnPncKPQnKBJv+jY6/A+MuXmCtciEi8/ovYSbcQglln6u3nXp30uUxkYm7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bsQNX1rVdzKHMxX;
	Wed, 30 Jul 2025 16:29:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 226B11A0AA0;
	Wed, 30 Jul 2025 16:28:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXkxPI14lokcLlBw--.17899S4;
	Wed, 30 Jul 2025 16:28:58 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: dlemoal@kernel.org,
	hare@suse.de,
	jack@suse.cz,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	yukuai3@huawei.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2 0/5] blk-mq-sched: support request batch dispatching for sq elevator
Date: Wed, 30 Jul 2025 16:22:02 +0800
Message-Id: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXkxPI14lokcLlBw--.17899S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXryfKr45ArW3uF4rJr43Wrg_yoW5AF45pF
	WfGanIyF4DX3ZIqF93uw17Jw1rGw4xZry3Grnxtr4SqwnrAr17AFn5Ja48ZFW7AryfWFsr
	Wr1qqrykWa4UWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes from v1:
 - the ioc changes are send separately;
 - change the patch 1-3 order as suggested by Damien;

Currently, both mq-deadline and bfq have global spin lock that will be
grabbed inside elevator methods like dispatch_request, insert_requests,
and bio_merge. And the global lock is the main reason mq-deadline and
bfq can't scale very well.

For dispatch_request method, current behavior is dispatching one request at
a time. In the case of multiple dispatching contexts, This behavior, on the
one hand, introduce intense lock contention:

t1:                     t2:                     t3:
lock                    lock                    lock
// grab lock
ops.dispatch_request
unlock
                        // grab lock
                        ops.dispatch_request
                        unlock
                                                // grab lock
                                                ops.dispatch_request
                                                unlock

on the other hand, messing up the requests dispatching order:
t1:

lock
rq1 = ops.dispatch_request
unlock
                        t2:
                        lock
                        rq2 = ops.dispatch_request
                        unlock

lock
rq3 = ops.dispatch_request
unlock

                        lock
                        rq4 = ops.dispatch_request
                        unlock

//rq1,rq3 issue to disk
                        // rq2, rq4 issue to disk

In this case, the elevator dispatch order is rq 1-2-3-4, however,
such order in disk is rq 1-3-2-4, the order for rq2 and rq3 is inversed.

While dispatching request, blk_mq_get_disatpch_budget() and
blk_mq_get_driver_tag() must be called, and they are not ready to be
called inside elevator methods, hence introduce a new method like
dispatch_requests is not possible.

In conclusion, this set factor the global lock out of dispatch_request
method, and support request batch dispatch by calling the methods
multiple time while holding the lock.

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

Test result: iops

|                 | deadline | bfq      |
| --------------- | -------- | -------- |
| before this set | 263k     | 124k     |
| after this set  | 475k     | 292k     |

Yu Kuai (5):
  blk-mq-sched: introduce high level elevator lock
  mq-deadline: switch to use elevator lock
  block, bfq: switch to use elevator lock
  blk-mq-sched: refactor __blk_mq_do_dispatch_sched()
  blk-mq-sched: support request batch dispatching for sq elevator

 block/bfq-cgroup.c   |   4 +-
 block/bfq-iosched.c  |  49 +++++----
 block/bfq-iosched.h  |   2 +-
 block/blk-mq-sched.c | 241 ++++++++++++++++++++++++++++++-------------
 block/blk-mq.h       |  21 ++++
 block/elevator.c     |   1 +
 block/elevator.h     |   4 +-
 block/mq-deadline.c  |  58 +++++------
 8 files changed, 248 insertions(+), 132 deletions(-)

-- 
2.39.2


