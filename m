Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CC977D7B2
	for <lists+cgroups@lfdr.de>; Wed, 16 Aug 2023 03:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbjHPBa4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Aug 2023 21:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241113AbjHPBaw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Aug 2023 21:30:52 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4AC1BF8;
        Tue, 15 Aug 2023 18:30:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQVvX1wtfz4f3mHp;
        Wed, 16 Aug 2023 09:30:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAH5KbHJtxkQuVAAw--.55976S4;
        Wed, 16 Aug 2023 09:30:49 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v2 0/4] cleanup and fixes for 'carryover_ios/bytes'
Date:   Wed, 16 Aug 2023 09:27:04 +0800
Message-Id: <20230816012708.1193747-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAH5KbHJtxkQuVAAw--.55976S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWrCF18AFWrKw1DWr48JFb_yoWfCFg_uF
        ykta4rCF1UJayIyFWxAr9xZryrWw4UXw1jg3WDGFW7Ary7Xrn8Gr1fJF4vvFsxuan0krs7
        trs8Za1xAr1agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        XdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

changes in v2:
 - fix missing adjustment in throtl_log().

Patch 1 print signed value for 'carryover_ios/bytes' to user.

Patch 2 fix that comparation ”unsigned value < negative value“ will
pass, causing that io won't be throttled in the silce.

Patch 3,4 fix that 'carryover_ios/bytes' is not cleared while
'io/bytes_disp' is cleared, causing that throttle is not accurate.

Yu Kuai (4):
  blk-throttle: print signed value 'carryover_bytes/ios' for user
  blk-throttle: fix wrong comparation while 'carryover_ios/bytes' is
    negative
  blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()
  blk-throttle: consider 'carryover_ios/bytes' in throtl_trim_slice()

 block/blk-throttle.c | 112 +++++++++++++++++++++----------------------
 block/blk-throttle.h |   4 +-
 2 files changed, 58 insertions(+), 58 deletions(-)

-- 
2.39.2

