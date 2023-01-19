Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9882C673107
	for <lists+cgroups@lfdr.de>; Thu, 19 Jan 2023 06:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjASFNO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Jan 2023 00:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjASFMe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Jan 2023 00:12:34 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4796D24128;
        Wed, 18 Jan 2023 21:11:26 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ny7HX4Tmnz4f3xcK;
        Thu, 19 Jan 2023 11:23:04 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R+Zt8hj+1ZBBw--.54593S3;
        Thu, 19 Jan 2023 11:23:06 +0800 (CST)
Subject: Re: [PATCH -next v2 3/3] blk-cgroup: synchronize pd_free_fn() from
 blkg_free_workfn() and blkcg_deactivate_policy()
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230118123152.1926314-1-yukuai1@huaweicloud.com>
 <20230118123152.1926314-4-yukuai1@huaweicloud.com>
 <Y8gm0BVh5d83lVXN@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9a9b6f38-9d1b-b007-96d7-2cda433763f4@huaweicloud.com>
Date:   Thu, 19 Jan 2023 11:23:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y8gm0BVh5d83lVXN@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R+Zt8hj+1ZBBw--.54593S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWkCF4xAFWkJrWfGryUJrb_yoW5tw1rpr
        ZxGas8trZ5tr4Ik3Wjvr13Wr9agw4rtrWUG3yrGa4Ykr4Y9rsYqFnrCrWvkFWxAFs5GF4f
        Zr4DKFnxGw48GrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2023/01/19 1:05, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Wed, Jan 18, 2023 at 08:31:52PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently parent pd can be freed before child pd:
>>
>> t1: remove cgroup C1
>> blkcg_destroy_blkgs
>>   blkg_destroy
>>    list_del_init(&blkg->q_node)
>>    // remove blkg from queue list
>>    percpu_ref_kill(&blkg->refcnt)
>>     blkg_release
>>      call_rcu
>>
>> t2: from t1
>> __blkg_release
>>   blkg_free
>>    schedule_work
>> 			t4: deactivate policy
>> 			blkcg_deactivate_policy
>> 			 pd_free_fn
>> 			 // parent of C1 is freed first
>> t3: from t2
>>   blkg_free_workfn
>>    pd_free_fn
>>
>> If policy(for example, ioc_timer_fn() from iocost) access parent pd from
>> child pd after pd_offline_fn(), then UAF can be triggered.
>>
>> Fix the problem by delaying 'list_del_init(&blkg->q_node)' from
>> blkg_destroy() to blkg_free_workfn(), and use a new disk level mutex to
>                                              ^
>                                              using
> 
>> protect blkg_free_workfn() and blkcg_deactivate_policy).
>    ^                                                     ^
>    synchronize?                                          ()
> 
>> @@ -118,16 +118,26 @@ static void blkg_free_workfn(struct work_struct *work)
>>   {
>>   	struct blkcg_gq *blkg = container_of(work, struct blkcg_gq,
>>   					     free_work);
>> +	struct request_queue *q = blkg->q;
>>   	int i;
>>   
>> +	if (q)
>> +		mutex_lock(&q->blkcg_mutex);
> 
> A comment explaining what the above is synchronizing would be useful.
> 
>> +
>>   	for (i = 0; i < BLKCG_MAX_POLS; i++)
>>   		if (blkg->pd[i])
>>   			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
>>   
>>   	if (blkg->parent)
>>   		blkg_put(blkg->parent);
>> -	if (blkg->q)
>> -		blk_put_queue(blkg->q);
>> +
>> +	if (q) {
>> +		if (!list_empty(&blkg->q_node))
> 
> We can drop the above if.
> 
>> +			list_del_init(&blkg->q_node);
>> +		mutex_unlock(&q->blkcg_mutex);
>> +		blk_put_queue(q);
>> +	}
>> +
>>   	free_percpu(blkg->iostat_cpu);
>>   	percpu_ref_exit(&blkg->refcnt);
>>   	kfree(blkg);
>> @@ -462,9 +472,14 @@ static void blkg_destroy(struct blkcg_gq *blkg)
>>   	lockdep_assert_held(&blkg->q->queue_lock);
>>   	lockdep_assert_held(&blkcg->lock);
>>   
>> -	/* Something wrong if we are trying to remove same group twice */
>> -	WARN_ON_ONCE(list_empty(&blkg->q_node));
>> -	WARN_ON_ONCE(hlist_unhashed(&blkg->blkcg_node));
>> +	/*
>> +	 * blkg is removed from queue list in blkg_free_workfn(), hence this
>> +	 * function can be called from blkcg_destroy_blkgs() first, and then
>> +	 * before blkg_free_workfn(), this function can be called again in
>> +	 * blkg_destroy_all().
> 
> How about?
> 
> 	 * blkg stays on the queue list until blkg_free_workfn(), hence this
> 	 * function can be called from blkcg_destroy_blkgs() first and again
> 	 * from blkg_destroy_all() before blkg_free_workfn().
> 
>> +	 */
>> +	if (hlist_unhashed(&blkg->blkcg_node))
>> +		return;
>>   
>>   	for (i = 0; i < BLKCG_MAX_POLS; i++) {
>>   		struct blkcg_policy *pol = blkcg_policy[i];
>> @@ -478,8 +493,11 @@ static void blkg_destroy(struct blkcg_gq *blkg)
>>   
>>   	blkg->online = false;
>>   
>> +	/*
>> +	 * Delay deleting list blkg->q_node to blkg_free_workfn() to synchronize
>> +	 * pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy().
>> +	 */
> 
> So, it'd be better to add a more comprehensive comment in blkg_free_workfn()
> explaining why we need this synchronization and how it works and then point
> to it from here.
> 
> Other than comments, it looks great to me. Thanks a lot for your patience
> and seeing it through.
Thanks for the suggestions, I'll send a new patch based on your
suggestions.

Kuai
> 

