Return-Path: <cgroups+bounces-8992-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056B0B1C2C9
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 11:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96F117C894
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C5C28A1E0;
	Wed,  6 Aug 2025 09:04:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2746020E6E2;
	Wed,  6 Aug 2025 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471083; cv=none; b=k5Zhb/dYfCN0Dvz73R6Of+7vqGnTSwpMSPd1ZXejzIxXL/2mvvtra1SyOGCr3/VdQ+Bbo5j/fZlQTRyLIHzKF+pm2w89Fx5LwkjYj0sbl3LDzhgYo0qGQjUlzuyxLReXAOwHbo50J8VLVuzyxO13AbgM05aI0tXqg2ECmQIZUrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471083; c=relaxed/simple;
	bh=5VUROShXHTEJ7dlOCo3pa1N9HdPxh9TYP++XylwtxMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vEqT/aNcMnB5aAEP3+iJ3c9i2u1/mJoqCN6Ta0FC5nRIBBXmQ9hNn9d2tjootltfcv8wO6GUQosRJHPO7IZikqQGD6DI5xK4XfxClkP7iaAsbJJGqZHeRcekqZXhihy9WnBnby3W4MmoFgHI6fiug2kU5lA5oqJnI38JhpTsaLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bxkrR1P2FzKHMyK;
	Wed,  6 Aug 2025 17:04:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 426DD1A0C12;
	Wed,  6 Aug 2025 17:04:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgA3sxOjGpNowBAGCw--.58870S4;
	Wed, 06 Aug 2025 17:04:37 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: dlemoal@kernel.org,
	hare@suse.de,
	jack@suse.cz,
	bvanassche@acm.org,
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
Subject: [PATCH v3 0/5] blk-mq-sched: support request batch dispatching for sq elevator
Date: Wed,  6 Aug 2025 16:57:15 +0800
Message-Id: <20250806085720.4040507-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3sxOjGpNowBAGCw--.58870S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuF15tr1ftr1kAw1rur18uFg_yoWrXF4rpF
	WfW3ZIyF4DWwnIqwn7uw17JryrGw48Xry3Gr15tr4ftw1DAr47JFn5XFy8ZFW7JryfWFsr
	Ww1DXry8Wa4UWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	nIWIevJa73UjIFyTuYvjfUOv38UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes from v2:
 - add elevator lock/unlock macros in patch 1;
 - improve coding style and commit messages;
 - retest with a new environment
 - add test for scsi HDD and nvme;

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

Test Environment:
arm64 Kunpeng-920, with 4 nodes 128 cores
nvme: HWE52P431T6M005N
scsi HDD: MG04ACA600E attached to hisi_sas_v3

null_blk set up:

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

null_blk and nvme test script:

[global]
filename=/dev/{nullb0,nvme0n1}
rw=randwrite
bs=4k
iodepth=32
iodepth_batch_submit=8
iodepth_batch_complete=8
direct=1
ioengine=io_uring
time_based

[write]
numjobs=16
runtime=60

scsi HDD test script: noted this test aims to test if batch dispatch
will affect IO merge.

[global]
filename=/dev/sda
rw=write
bs=4k
iodepth=32
iodepth_batch_submit=1
direct=1
ioengine=libaio

[write]
offset_increment=1g
numjobs=128

Test Result:
1) nullblk: iops test with high IO pressue
|                 | deadline | bfq      |
| --------------- | -------- | -------- |
| before this set | 256k     | 153k     |
| after this set  | 594k     | 283k     |

2) nvme: iops test with high IO pressue
|                 | deadline | bfq      |
| --------------- | -------- | -------- |
| before this set | 258k     | 142k     |
| after this set  | 568k     | 214k     |

3) scsi HDD: io merge test, elevator is deadline
|                 | w/s   | %wrqm | wareq-sz | aqu-sz |
| --------------- | ----- | ----- | -------- | ------ |
| before this set | 92.25 | 96.88 | 128      | 129    |
| after this set  | 92.63 | 96.88 | 128      | 129    |

Yu Kuai (5):
  blk-mq-sched: introduce high level elevator lock
  mq-deadline: switch to use elevator lock
  block, bfq: switch to use elevator lock
  blk-mq-sched: refactor __blk_mq_do_dispatch_sched()
  blk-mq-sched: support request batch dispatching for sq elevator

 block/bfq-cgroup.c   |   6 +-
 block/bfq-iosched.c  |  53 +++++-----
 block/bfq-iosched.h  |   2 -
 block/blk-mq-sched.c | 246 ++++++++++++++++++++++++++++++-------------
 block/blk-mq.h       |  21 ++++
 block/elevator.c     |   1 +
 block/elevator.h     |  14 ++-
 block/mq-deadline.c  |  60 +++++------
 8 files changed, 263 insertions(+), 140 deletions(-)

-- 
2.39.2


