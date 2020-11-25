Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E7C2C4083
	for <lists+cgroups@lfdr.de>; Wed, 25 Nov 2020 13:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgKYMtd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Nov 2020 07:49:33 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7988 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKYMtd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Nov 2020 07:49:33 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Ch1161SpnzhhMs;
        Wed, 25 Nov 2020 20:49:14 +0800 (CST)
Received: from [10.174.179.62] (10.174.179.62) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Nov 2020 20:49:20 +0800
Subject: Re: [RFC PATCH] blk-cgroup: prevent rcu_sched detected stalls
 warnings in blkg_destroy_all()
To:     Tejun Heo <tj@kernel.org>
CC:     <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <houtao1@huawei.com>
References: <20201121083420.3857433-1-yukuai3@huawei.com>
 <X75O8BNVSX3ZE86w@mtj.duckdns.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <a24c48a3-6f17-98ac-47ad-770dd7e775ec@huawei.com>
Date:   Wed, 25 Nov 2020 20:49:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <X75O8BNVSX3ZE86w@mtj.duckdns.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.62]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2020/11/25 20:32, Tejun Heo wrote:
> Hello,
> 
> Thanks for the fix. A couple comments below.
> 
> On Sat, Nov 21, 2020 at 04:34:20PM +0800, Yu Kuai wrote:
>> +#define BLKG_DESTROY_BATH 4096
> 
> I think you meant BLKG_DESTROY_BATCH.
> 
>>   static void blkg_destroy_all(struct request_queue *q)
>>   {
>>   	struct blkcg_gq *blkg, *n;
>> +	int count = BLKG_DESTROY_BATH;
> 
> But might as well just write 4096 here.
> 
>>   	spin_lock_irq(&q->queue_lock);
>>   	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
>>   		struct blkcg *blkcg = blkg->blkcg;
>>   
>> +		/*
>> +		 * If the list is too long, the loop can took a long time,
>> +		 * thus relese the lock for a while when a batch of blkcg
>> +		 * were destroyed.
>> +		 */
>> +		if (!(--count)) {
>> +			count = BLKG_DESTROY_BATH;
>> +			spin_unlock_irq(&q->queue_lock);
>> +			cond_resched();
>> +			spin_lock_irq(&q->queue_lock);
> 
> You can't continue iteration after dropping both locks. You'd have to jump
> out of loop and start list_for_each_entry_safe() again.

Thanks for your review, it's right. On the other hand
blkcg_activate_policy() and blkcg_deactivate_policy() might have the
same issue. My idea is that inserting a bookmark to the list, and
restard from here.

By the way, I found that blk_throtl_update_limit_valid() is called from
throtl_pd_offline(). If CONFIG_BLK_DEV_THROTTLING_LOW is off, lower
limit will always be zero, therefor a lot of time will be wasted to
iterate descendants to find a nonzero lower limit.

Do you think it's ok to do such modification:

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b771c4299982..d52cac9f3a7c 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -587,6 +587,7 @@ static void throtl_pd_online(struct blkg_policy_data 
*pd)
         tg_update_has_rules(tg);
  }

+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
  static void blk_throtl_update_limit_valid(struct throtl_data *td)
  {
         struct cgroup_subsys_state *pos_css;
@@ -607,6 +608,11 @@ static void blk_throtl_update_limit_valid(struct 
throtl_data *td)

         td->limit_valid[LIMIT_LOW] = low_valid;
  }
+#else
+static inline void blk_throtl_update_limit_valid(struct throtl_data *td)
+{
+}
+#endif

  static void throtl_upgrade_state(struct throtl_data *td);
  static void throtl_pd_offline(struct blkg_policy_data *pd)

Thanks!
Yu Kuai
