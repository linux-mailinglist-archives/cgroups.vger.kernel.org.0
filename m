Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171F763E78A
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 03:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiLACMW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 21:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLACMV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 21:12:21 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF6254465;
        Wed, 30 Nov 2022 18:12:19 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NN02N574Rz4f3s8m;
        Thu,  1 Dec 2022 10:12:12 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgC3YK99DYhjepV1BQ--.2209S3;
        Thu, 01 Dec 2022 10:12:15 +0800 (CST)
Subject: Re: [PATCH -next v2 8/9] block: fix null-pointer dereference in
 ioc_pd_init
To:     Tejun Heo <tj@kernel.org>, Li Nan <linan122@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-9-linan122@huawei.com>
 <Y4fCE7XxcpDfWyDJ@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9ca2b7ab-7fd3-a9a3-12a6-021a78886b54@huaweicloud.com>
Date:   Thu, 1 Dec 2022 10:12:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y4fCE7XxcpDfWyDJ@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgC3YK99DYhjepV1BQ--.2209S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4DCFWrZw4rZr1kWF17Jrb_yoW8Ww4UpF
        WfWF1Yy34jqrs3t3WDAw4xAryYqrs5WF1fZ3s8A3sI9FZruw1Yq3W2kFWqgayxZrs8Zr1F
        qayjqw17Xry0yrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2022/12/01 4:50, Tejun Heo Ð´µÀ:
> On Wed, Nov 30, 2022 at 09:21:55PM +0800, Li Nan wrote:
>> Remove block device when iocost is initializing may cause
>> null-pointer dereference:
>>
>> 	CPU1				   CPU2
>>    ioc_qos_write
>>     blkcg_conf_open_bdev
>>      blkdev_get_no_open
>>       kobject_get_unless_zero
>>      blk_iocost_init
>>       rq_qos_add
>>    					del_gendisk
>>    					 rq_qos_exit
>>    					  q->rq_qos = rqos->next
>>    					   //iocost is removed from q->roqs
>>        blkcg_activate_policy
>>         pd_init_fn
>>          ioc_pd_init
>>    	 ioc = q_to_ioc(blkg->q)
>>   	  //cant find iocost and return null
>>
>> Fix problem by moving rq_qos_exit() to disk_release(). ioc_qos_write() get
>> bd_device.kobj in blkcg_conf_open_bdev(), so disk_release will not be
>> actived until iocost initialization is complited.
> 
> I think it'd be better to make del_gendisk wait for these in-flight
> operations because this might fix the above particular issue but now all the
> policies are exposed to request_queue in a state it never expected before.
> 
> del_gendisk() is quiescing the queue around rq_qos_exit(), so maybe we can
> piggyback on that and update blkcg_conf_open_bdev() to provide such
> exclusion?

Let del_gendisk waiting for that sounds good, but I'm litter confused
how to do that. Following are what I think about:

1) By mentioning that "del_gendisk() is quiescing the queue", do you
suggest to add rcu_read_lock()? This seems wrong because blk_iocost_init
requires memory allocation.

2) Hold gendisk open mutex

3) Use q_usage_counter, and in the meantime, rq_qos_add() and
blkcg_activate_policy() will need refactoring to factor out freeze
queue.

4) Define a new metux

Thanks,
Kuai
> 
> Thanks.
> 

