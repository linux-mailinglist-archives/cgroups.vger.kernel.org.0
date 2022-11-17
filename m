Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0895762D962
	for <lists+cgroups@lfdr.de>; Thu, 17 Nov 2022 12:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiKQL27 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Nov 2022 06:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiKQL26 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Nov 2022 06:28:58 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D395242996;
        Thu, 17 Nov 2022 03:28:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NCd355dTcz4f3mH3;
        Thu, 17 Nov 2022 19:28:49 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgAn0a_zGnZjPOSPAg--.8579S3;
        Thu, 17 Nov 2022 19:28:52 +0800 (CST)
Subject: Re: [PATCH v2 4/5] blk-iocost: fix sleeping in atomic context
 warnning
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221104023938.2346986-1-yukuai1@huaweicloud.com>
 <20221104023938.2346986-5-yukuai1@huaweicloud.com>
 <Y3K8MSFWw8eTnxtm@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3da991c6-21e4-8ed8-ba75-ccb92059f0ae@huaweicloud.com>
Date:   Thu, 17 Nov 2022 19:28:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y3K8MSFWw8eTnxtm@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAn0a_zGnZjPOSPAg--.8579S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jry3WF13Jr47Wr48XFWxCrg_yoWfuFc_CF
        Wv9r4qq3Z8ZanY9FyUtFWDtrWrA34aqr1xWr48XF98tw1jvw15Ga17Jry0qw45JFWF9F4D
        CrW5Crsagr47XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
        VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Tejun!

ÔÚ 2022/11/15 6:07, Tejun Heo Ð´µÀ:

> 
> Any chance I can persuade you into updating match_NUMBER() helpers to not
> use match_strdup()? They can easily disable irq/preemption and use percpu
> buffers and we won't need most of this patchset.

Does the following patch match your proposal?

diff --git a/lib/parser.c b/lib/parser.c
index bcb23484100e..ded652471919 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -11,6 +11,24 @@
  #include <linux/slab.h>
  #include <linux/string.h>

+#define U64_MAX_SIZE 20
+
+static DEFINE_PER_CPU(char, buffer[U64_MAX_SIZE]);
+
+static char *get_buffer(void)
+{
+       preempt_disable();
+       local_irq_disable();
+
+       return this_cpu_ptr(buffer);
+}
+
+static void put_buffer(void)
+{
+       local_irq_enable();
+       preempt_enable();
+}
+

Then match_strdup() and kfree() in match_NUMBER() can be replaced with
get_buffer() and put_buffer().

Thanks,
Kuai
> 
> Thanks.
> 

