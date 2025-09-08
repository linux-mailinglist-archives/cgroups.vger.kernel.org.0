Return-Path: <cgroups+bounces-9781-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3125FB48872
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 11:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06063C4BE9
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 09:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F62F28E5;
	Mon,  8 Sep 2025 09:29:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7942F069D;
	Mon,  8 Sep 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323771; cv=none; b=q/tCF1VRUys7kEQt24BCEtrbbii1Q2XWfOl997UP+LCDnH8l1bwuIihm7n5LyCSBR1kcPREY2/raYLp9cUhUbgCLdyVQ8GgimMWWoluKl9TR/bn1/XC0AUsFE9GHjkhHqy9FkblggKpNrDaEFVOsUrJ6Bb+yscQn4TN1fWPYaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323771; c=relaxed/simple;
	bh=WzCrMAhkDA+aG0BGBU3kEEBYjaDMJw7LyiiNySBW7NY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q97d0hmcCctMRDUNKwePsknbTEX42XvV1RyCH/tkqjmFH9E1ch/oXWVcll1T2r/309/Hdt9EX0zcGzMwIZDcP55Yf+/NwNHR1PreqBVhQKic6vpKTRlUY+/XEnZdS+xcXRW4K9m9Xz//kH5DQB6vY/yzARgGgtm2JzTQ73lMR3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cL1qp0cCwzKHLv3;
	Mon,  8 Sep 2025 17:29:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2FA9E1A1751;
	Mon,  8 Sep 2025 17:29:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIzzob5oGjMyBw--.46699S4;
	Mon, 08 Sep 2025 17:29:25 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: dlemoal@kernel.org,
	hare@suse.de,
	bvanassche@acm.org,
	ming.lei@redhat.com,
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
Subject: [PATCH v4 for-6.18/block 0/5] blk-mq-sched: support request batch dispatching for sq elevator
Date: Mon,  8 Sep 2025 17:20:02 +0800
Message-Id: <20250908092007.3796967-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYIzzob5oGjMyBw--.46699S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW3uF13Kr45tF4DXFWDArb_yoWrAryDpF
	WfW3ZIkF4DW3ZIqwn7uw17Jr1rGw48X345Gr15tr4ft3WDAr47JFn5XFy8ZFW7JryfWFsr
	Ww1DXry8Wa4UWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbmsjUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Chagnes from v3:
 - add a helper elevator_dispatch_lock/unlock, and flag
 ELEVATOR_FLAG_DISPATCH_IRQ, so that mq-deadline don't have to disable
 irq like bfq while dispatching;
 - rebase for-6.18/block

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
 block/bfq-iosched.c  |  54 +++++-----
 block/bfq-iosched.h  |   2 -
 block/blk-mq-sched.c | 246 ++++++++++++++++++++++++++++++-------------
 block/blk-mq.h       |  18 ++++
 block/elevator.c     |   1 +
 block/elevator.h     |  31 +++++-
 block/mq-deadline.c  |  60 +++++------
 8 files changed, 278 insertions(+), 140 deletions(-)

-- 
2.39.2


