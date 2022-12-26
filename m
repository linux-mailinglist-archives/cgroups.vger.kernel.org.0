Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE83655EFB
	for <lists+cgroups@lfdr.de>; Mon, 26 Dec 2022 02:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiLZBKv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 25 Dec 2022 20:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiLZBKu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 25 Dec 2022 20:10:50 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AC3C34;
        Sun, 25 Dec 2022 17:10:47 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NgKTr6cc0z4f3nTL;
        Mon, 26 Dec 2022 09:10:40 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLOR9KhjFu0ZAg--.46799S3;
        Mon, 26 Dec 2022 09:10:43 +0800 (CST)
Subject: Re: [PATCH -next 1/4] blk-iocost: track whether iocg is still online
To:     Christoph Hellwig <hch@infradead.org>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221217030527.1250083-1-yukuai1@huaweicloud.com>
 <20221217030527.1250083-2-yukuai1@huaweicloud.com>
 <Y6LhD8CEkcgLUJoQ@infradead.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <edb84ee2-3dd5-8bb4-4417-ed42744d793f@huaweicloud.com>
Date:   Mon, 26 Dec 2022 09:10:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y6LhD8CEkcgLUJoQ@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLOR9KhjFu0ZAg--.46799S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw1xCw48CF1kGrW7ZF4rAFb_yoWDWrg_Zw
        1Fva4akwsxKFZ3X34jyw1fXFZIkwn5Gr1kWFWrtasrCryUX3yfCa17ZrWfCa97Gw4xCrW3
        Cr98W3yxG34IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Christoph

ÔÚ 2022/12/21 18:33, Christoph Hellwig Ð´µÀ:
> On Sat, Dec 17, 2022 at 11:05:24AM +0800, Yu Kuai wrote:
>> @@ -459,6 +459,8 @@ struct ioc_gq {
>>   	struct blkg_policy_data		pd;
>>   	struct ioc			*ioc;
>>   
>> +	bool online;
> 
> Nit: maybe tab align this field like the fields above it.
> 
>> +static void ioc_pd_offline(struct blkg_policy_data *pd)
>> +{
>> +	struct ioc_gq *iocg = pd_to_iocg(pd);
>> +	struct ioc *ioc = iocg->ioc;
>> +	unsigned long flags;
>> +
>> +	if (ioc) {
> 
> How could ioc be NULL here?
> 

As I explained in another thread.. pd_offline_fn() can be called without
pd_init_fn(), which is a bug from upper layer...

blkcg_activate_policy
  spin_lock_irq(&q->queue_lock);
  list_for_each_entry_reverse(blkg, &q->blkg_list
   pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN,...) -> failed

   spin_unlock_irq(&q->queue_lock);
   // release queue_lock here is problematic, this will cause
pd_offline_fn called without pd_init_fn.
   pd_alloc_fn(__GFP_NOWARN,...)

Thanks,
Kuai
> .
> 

