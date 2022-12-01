Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D333D63ED9A
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 11:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLAKXp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 05:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiLAKXd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 05:23:33 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA7C97923;
        Thu,  1 Dec 2022 02:23:19 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NNBwy3q3Gz4f3mSw;
        Thu,  1 Dec 2022 18:23:14 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgBHO6qUgIhjvN6HBQ--.58718S3;
        Thu, 01 Dec 2022 18:23:17 +0800 (CST)
Subject: Re: [PATCH -next v2 8/9] block: fix null-pointer dereference in
 ioc_pd_init
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Nan <linan122@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-9-linan122@huawei.com>
 <Y4fCE7XxcpDfWyDJ@slm.duckdns.org>
 <9ca2b7ab-7fd3-a9a3-12a6-021a78886b54@huaweicloud.com>
 <Y4h94m8QMPtS4xJV@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <431dcb3f-4572-7fd0-9e5d-90b6c34d577c@huaweicloud.com>
Date:   Thu, 1 Dec 2022 18:23:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y4h94m8QMPtS4xJV@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHO6qUgIhjvN6HBQ--.58718S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZry3Jw43Ww4rKF4kZF1kXwb_yoWkGwb_uw
        4vvw10kw15Ga97A3ZIyF4xXrWvgrs5Jr47X39IgFWfWr9YkasxWFZrZry3WFW5K3WI93Wa
        kr1DGry5W3y29jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
        04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2022/12/01 18:11, Tejun Heo Ð´µÀ:
> On Thu, Dec 01, 2022 at 10:12:13AM +0800, Yu Kuai wrote:
>> 1) By mentioning that "del_gendisk() is quiescing the queue", do you
>> suggest to add rcu_read_lock()? This seems wrong because blk_iocost_init
>> requires memory allocation.
> 
> Quiescing uses SRCU so that should be fine but I'm not sure whether this is
> the right one to piggyback on. Jens should have a better idea.
> 
> Thanks.
> 

Currently SRCU is used if BLK_MQ_F_BLOCKING set, otherwise RCU is used.

dispatch:
#define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) \
do {                                                            \
         if ((q)->tag_set->flags & BLK_MQ_F_BLOCKING) {          \
                 int srcu_idx;                                   \
                                                                 \
                 might_sleep_if(check_sleep);                    \
                 srcu_idx = srcu_read_lock((q)->tag_set->srcu);  \
                 (dispatch_ops);                                 \
                 srcu_read_unlock((q)->tag_set->srcu, srcu_idx); \
         } else {                                                \
                 rcu_read_lock();                                \
                 (dispatch_ops);                                 \
                 rcu_read_unlock();                              \
         }                                                       \
} while (0)

quiesce:
void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set)
{
         if (set->flags & BLK_MQ_F_BLOCKING)
                 synchronize_srcu(set->srcu);
         else
                 synchronize_rcu();
}

Thanks,
Kuai

