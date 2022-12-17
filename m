Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2227164F728
	for <lists+cgroups@lfdr.de>; Sat, 17 Dec 2022 03:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiLQCsa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Dec 2022 21:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiLQCs3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Dec 2022 21:48:29 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A3EA453;
        Fri, 16 Dec 2022 18:48:29 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NYr4l43ghz4f3jps;
        Sat, 17 Dec 2022 10:48:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgB3m9j5LZ1jmxh7CQ--.11469S4;
        Sat, 17 Dec 2022 10:48:26 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next 0/4] blk-cgroup: synchronize del_gendisk() with configuring cgroup policy
Date:   Sat, 17 Dec 2022 11:09:04 +0800
Message-Id: <20221217030908.1261787-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3m9j5LZ1jmxh7CQ--.11469S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKryxZw4DGryDJF47WFy8Zrb_yoWkurc_uF
        Z5J34Sgw1kWayakF97KF4DJFWrKr48Zr429Fy2qF9rWw1fJrnxJw4293WY9F43uF47GrW5
        XryrXr1kJrn2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1
        a9aPUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

iocost is initialized when it's configured the first time, and iocost
initializing can race with del_gendisk(), which will cause null pointer
dereference:

t1				t2
ioc_qos_write
 blk_iocost_init
  rq_qos_add
  				del_gendisk
  				 rq_qos_exit
  				 //iocost is removed from q->roqs
  blkcg_activate_policy
   pd_init_fn
    ioc_pd_init
     ioc = q_to_ioc(blkg->q)
     //can't find iocost and return null

And iolatency is about to switch to the same lazy initialization.

This patchset fix this problem by synchronize rq_qos_add() and
blkcg_activate_policy() with rq_qos_exit().

Yu Kuai (4):
  block/rq_qos: protect 'q->rq_qos' with queue_lock in rq_qos_exit()
  block/rq_qos: fail rq_qos_add() after del_gendisk()
  blk-cgroup: add a new interface blkcg_conf_close_bdev()
  blk-cgroup: synchronize del_gendisk() with configuring cgroup policy

 block/blk-cgroup.c     | 12 ++++++++++--
 block/blk-cgroup.h     |  1 +
 block/blk-iocost.c     |  8 ++++----
 block/blk-rq-qos.c     | 25 ++++++++++++++++++++-----
 block/blk-rq-qos.h     | 17 +++++++++++++----
 include/linux/blkdev.h |  1 +
 6 files changed, 49 insertions(+), 15 deletions(-)

-- 
2.31.1

