Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41B86636C5
	for <lists+cgroups@lfdr.de>; Tue, 10 Jan 2023 02:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjAJBjy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Jan 2023 20:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjAJBjx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Jan 2023 20:39:53 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63882027;
        Mon,  9 Jan 2023 17:39:50 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NrYQS2HGGz4f3tq5;
        Tue, 10 Jan 2023 09:39:44 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgBXxC7hwbxjr2xaBQ--.9417S3;
        Tue, 10 Jan 2023 09:39:46 +0800 (CST)
Subject: Re: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221227125502.541931-1-yukuai1@huaweicloud.com>
 <20221227125502.541931-2-yukuai1@huaweicloud.com>
 <Y7XzUee5Bq+DoIC1@slm.duckdns.org>
 <c63ee2ad-23d5-3be0-c731-28494398b391@huaweicloud.com>
 <Y7cX0SJ0y6+EIY5Q@slm.duckdns.org>
 <7dcdaef3-65c1-8175-fea7-53076f39697f@huaweicloud.com>
 <Y7iCId3pnEnLqY8G@slm.duckdns.org>
 <875eb43e-202d-5b81-0bff-ef0434358d99@huaweicloud.com>
 <Y7xbpidpq7+DqJan@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a71f997f-6cae-d57b-85dd-2fd499d238f6@huaweicloud.com>
Date:   Tue, 10 Jan 2023 09:39:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y7xbpidpq7+DqJan@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXxC7hwbxjr2xaBQ--.9417S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1DGF4kur4DXrWDtr1kZrb_yoW8Wr18pF
        Z3Gay3G39xtrySkr17Za1xXa4rtws5Ja45G3yfGw4rur45X3s3Aw1ayryfCF1DZFs5Za4j
        qr409FyDGr1qya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2023/01/10 2:23, Tejun Heo Ð´µÀ:
> Yeah, that's unfortunate. There are several options here:
> 
> 1. Do what you originally suggested - bypass to root after offline. I feel
>     uneasy about this. Both iolatency and throtl clear their configs on
>     offline but that's punting to the parent. For iocost it'd be bypassing
>     all controls, which can actually be exploited.
> 
> 2. Make all possible IO issuers use blkcg_[un]pin_online() and shift the
>     iocost shutdown to pd_offline_fn(). This likely is the most canonical
>     solution given the current situation but it's kinda nasty to add another
>     layer of refcnting all over the place.
> 
> 3. Order blkg free so that parents are never freed before children. You did
>     this by adding refcnts in iocost but shouldn't it be possible to simply
>     shift blkg_put(blkg->parent) in __blkg_release() to blkg_free_workfn()?

As I tried to explain before, we can make sure blkg_free() is called
in order, but blkg_free() from remove cgroup can concurrent with
deactivate policy, and we can't guarantee the order of ioc_pd_free()
that is called both from blkg_free() and blkcg_deactivate_policy().
Hence I don't think #3 is possible.

I personaly prefer #1, I don't see any real use case about the defect
that you described, and actually in cgroup v1 blk-throtl is bypassed to
no limit as well.

I'm not sure about #2, that sounds a possible solution but I'm not quite
familiar with the implementations here.

Consider that bfq already has such refcounting for bfqg, perhaps
similiar refcounting is acceptable?

Thanks,
Kuai

