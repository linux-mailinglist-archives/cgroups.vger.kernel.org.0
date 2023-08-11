Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9476C7789A5
	for <lists+cgroups@lfdr.de>; Fri, 11 Aug 2023 11:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjHKJXK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 05:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjHKJXJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 05:23:09 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0780110;
        Fri, 11 Aug 2023 02:23:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RMdcm5YGwz4f3v4j;
        Fri, 11 Aug 2023 17:23:04 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6n4_dVk9EbMAQ--.45074S3;
        Fri, 11 Aug 2023 17:23:05 +0800 (CST)
Subject: Re: [PATCH -next v3] block: remove init_mutex and open-code
 blk_iolatency_try_init
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Lingfeng <lilingfeng@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linan122@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230810035111.2236335-1-lilingfeng@huaweicloud.com>
 <6637e6cd-20aa-110a-40ae-53ecd6eb4184@huaweicloud.com>
 <d4050f7e-d491-c111-3e26-160e7d5a4208@huaweicloud.com>
 <dtobag743cbzb3rxzldu36wszqtnbayz2grpyj2cctptfybtt3@66ico6n2clrr>
 <60dbff4b-d823-5dc9-ff8e-36648ddf7207@huaweicloud.com>
 <fwzsn3wyqpthfkegnlq7obl3uy6hhodobvcswena2z42ndzmzp@izv4k6wy6opt>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b3409889-bb8a-d664-a495-c8cd34e501f3@huaweicloud.com>
Date:   Fri, 11 Aug 2023 17:23:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fwzsn3wyqpthfkegnlq7obl3uy6hhodobvcswena2z42ndzmzp@izv4k6wy6opt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6n4_dVk9EbMAQ--.45074S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFW5WryfKryrZw4rJFy3XFb_yoWfZrX_uw
        4ktFsrGw48GayFkw4Skr98Xa9YqayUWryUGryFgFW7uw1vvF4rCr4DCr9avFy5G3yfGFs0
        yFs8ua4rJryIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
        Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Michal

在 2023/08/11 17:17, Michal Koutný 写道:
> On Fri, Aug 11, 2023 at 04:53:44PM +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>> Yes, it'm implemented in the upper layer that rq_qos_add() and
>> blkcg_activate_policy() should be atmoic, and currently there is no
>> comments for that.
> 
> The check (iolat_rq_qos()) and use (activating the policy) should be the
> atomic pair.
> 
>> Perhaps it's better to add some comments like following in rq_qos_add()
>> instead?
> 
> Honestly, I find the current variant (v3) good as it is -- closest to
> the pair of the operations.
> 
> (But it's merely a comment so ¯\_(ツ)_/¯)

Yes, it's just a comment.

Lingfeng, can you resend this patch with the following fixed?

 > lockdep_assert_held(ctx.bdev->bd_queue->rq_qos_mutex);

should be:
lockdep_assert_held(&ctx.bdev->bd_queue->rq_qos_mutex);

And you can keep my review tag.

Thanks,
Kuai

> 
> Michal
> 

