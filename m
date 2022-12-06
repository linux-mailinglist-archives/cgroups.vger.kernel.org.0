Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE3643DD4
	for <lists+cgroups@lfdr.de>; Tue,  6 Dec 2022 08:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiLFHxj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Dec 2022 02:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLFHxi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Dec 2022 02:53:38 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD42D14019;
        Mon,  5 Dec 2022 23:53:36 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NRCMv2CJhz4f3mTF;
        Tue,  6 Dec 2022 15:53:31 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgAXwa_79I5jZb6VBg--.47464S3;
        Tue, 06 Dec 2022 15:53:33 +0800 (CST)
Subject: Re: [PATCH -next v2 7/9] blk-iocost: fix UAF in ioc_pd_free
To:     Tejun Heo <tj@kernel.org>, Li Nan <linan122@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-8-linan122@huawei.com>
 <Y4fAJpKcVL7Q9hgY@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <aa924294-2f54-1b53-fc6e-e4f8fa019b14@huaweicloud.com>
Date:   Tue, 6 Dec 2022 15:53:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y4fAJpKcVL7Q9hgY@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAXwa_79I5jZb6VBg--.47464S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW7uF4fXry7ZFWUJr4Utwb_yoW8WryDpF
        WfGa1rKFZ5JFs7Can0qw12vFySgF4Dtr1UGr4fKrZxKF43Jr9Yqr4fZFWYkFZ8KFn8WrWY
        vrn7WF1kG3WUAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Tejun!

ÔÚ 2022/12/01 4:42, Tejun Heo Ð´µÀ:
> On Wed, Nov 30, 2022 at 09:21:54PM +0800, Li Nan wrote:
>> 	T1		     T2			T3
>>    //delete device
>>    del_gendisk
>>     bdi_unregister
>>      bdi_remove_from_list
>>       synchronize_rcu_expedited
>>
>> 		         //rmdir cgroup
>> 		         blkcg_destroy_blkgs
>> 		          blkg_destroy
>> 		           percpu_ref_kill
>> 		            blkg_release
>> 		             call_rcu
>>     rq_qos_exit
>>      ioc_rqos_exit
>>       kfree(ioc)
>> 					   __blkg_release
>> 					    blkg_free
>> 					     blkg_free_workfn
>> 					      pd_free_fn
>> 					       ioc_pd_free
>> 						spin_lock_irqsave
>> 						 ->ioc is freed
>>
>> Fix the problem by moving the operation on ioc in ioc_pd_free() to
>> ioc_pd_offline(), and just free resource in ioc_pd_free() like iolatency
>> and throttle.
>>
>> Signed-off-by: Li Nan <linan122@huawei.com>
> 
> I wonder what we really wanna do is pinning ioc while blkgs are still around
> but I think this should work too.
> 

I just found that this is not enough, other problems still exist:

t1:		
bio_init
  bio_associate_blkg
   //get blkg->refcnt
......
submit_bio
  blk_throtl_bio
  // bio is throttlled, user thread can exit
  			t2:
			// blkcg online_pin is zero
			blkcg_destroy_blkgs
			 blkg_destroy
			  ioc_pd_offline
			   list_del_init(&iocg->active_list)
t3:
ioc_rqos_throttle
  blkg_to_iocg
  // got the iocg that is offlined
   iocg_activate
   // acitvate the iocg again

For consequence, kernel can crash due to access unexpected
address. Fortunately, bfq already handle similar problem by checking
blkg->online in bfq_bio_bfqg(), this problem can be fixed by checking
it in iocg_activate().

BTW, I'm still working on checking if other policies have the same
problem.

Thanks,
Kuai

