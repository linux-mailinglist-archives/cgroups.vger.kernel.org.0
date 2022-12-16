Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CF364E627
	for <lists+cgroups@lfdr.de>; Fri, 16 Dec 2022 04:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiLPDNf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Dec 2022 22:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLPDNd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Dec 2022 22:13:33 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B363D2A715;
        Thu, 15 Dec 2022 19:13:31 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NYDh54zYGz4f4DxG;
        Fri, 16 Dec 2022 11:13:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAXiNVW4ptjHYxACQ--.50238S2;
        Fri, 16 Dec 2022 11:13:28 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     jack@suse.cz, paolo.valente@linaro.org, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        liuzhiqiang@26.com, shikemeng@huaweicloud.com
Subject: [PATCH v2 00/10] A few bugfix and cleancode patch for bfq
Date:   Fri, 16 Dec 2022 19:12:20 +0800
Message-Id: <20221216111230.3638832-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXiNVW4ptjHYxACQ--.50238S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4ftFyfXFWkur4kur4Uurg_yoWDCFX_GF
        WrWF93JrW8XFy5AFy2kr13Ja90qrZFq3WUKF9Yqr45Xr13t3ZxZwnFgrs7ZF4DZa1xAa95
        ZrsYv34rJrWkujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbakFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28lY4IEw2IIxx
        k0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK
        6xIIjxv20xvEc7CjxVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_
        WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
        IYCTnIWIevJa73UjIFyTuYvjTRNgAwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, this series contain two patches to fix bug in request injection
mechanism and some random cleancode patches.
Thanks!

---
v2:
 -improve git log.
---

Kemeng Shi (10):
  block, bfq: correctly raise inject limit in
    bfq_choose_bfqq_for_injection
  block, bfq: remove unsed parameter reason in bfq_bfqq_is_slow
  block, bfq: initialize bfqq->decrease_time_jif correctly
  block, bfq: use helper macro RQ_BFQQ to get bfqq of request
  block, bfq: remove unnecessary dereference to get async_bfqq
  block, bfq: remove redundant bfqd->rq_in_driver > 0 check in
    bfq_add_request
  block, bfq: remove redundant check in bfq_put_cooperator
  block, bfq: remove unnecessary goto tag in bfq_dispatch_rq_from_bfqq
  block, bfq: remove unused bfq_wr_max_time in struct bfq_data
  block, bfq: remove check of bfq_wr_max_softrt_rate which is always
    greater than 0

 block/bfq-iosched.c | 49 +++++++++++++++++----------------------------
 block/bfq-iosched.h |  2 --
 2 files changed, 18 insertions(+), 33 deletions(-)

-- 
2.30.0

