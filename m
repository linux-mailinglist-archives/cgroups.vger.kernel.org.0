Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AF767FC10
	for <lists+cgroups@lfdr.de>; Sun, 29 Jan 2023 02:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjA2BSV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 28 Jan 2023 20:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjA2BSR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 28 Jan 2023 20:18:17 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9972516336;
        Sat, 28 Jan 2023 17:18:14 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4P4D2n2YBLz4f3mJ6;
        Sun, 29 Jan 2023 09:18:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR9SydVj2wd2CQ--.45901S3;
        Sun, 29 Jan 2023 09:18:11 +0800 (CST)
Subject: Re: [PATCH] block, bfq: fix uaf for bfqq in bic_set_bfqq()
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230113094410.2907223-1-yukuai3@huawei.com>
 <20230124000925.pfosl6pfuhjyggbp@shindev>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <38b5d9a6-bed6-c139-404b-94aca49f38c6@huaweicloud.com>
Date:   Sun, 29 Jan 2023 09:18:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230124000925.pfosl6pfuhjyggbp@shindev>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR9SydVj2wd2CQ--.45901S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYq7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2js
        IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
        5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
        CFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxG
        xcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2023/01/24 8:09, Shinichiro Kawasaki Ð´µÀ:
> 
> Yu, thanks for posting this fix, but it can not be applied to v6.2-rc5. The
> hunk above looks different from the patch I tested. Could you take a look?
> 

This patch was rebased with following patch that add a new param for
bic_set_bfqq():

51ec2387623a block, bfq: split sync bfq_queues on a per-actuator basis

Thanks,
Kuai

