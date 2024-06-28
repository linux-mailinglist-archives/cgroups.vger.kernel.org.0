Return-Path: <cgroups+bounces-3437-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C40A91B568
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 05:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90C21F22A17
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 03:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2121A1BF47;
	Fri, 28 Jun 2024 03:22:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA77814F98;
	Fri, 28 Jun 2024 03:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544966; cv=none; b=jGXPhYgKop+rWJ/6jUScjoS/hR/1VdDpUDdLrCyCMriHryKddrP51QXdczrBrCBqCIUnXLdA40Snx1iEtCtV1mgQVblvhv2DTNsWZ1gJoWdOmydhxIcgN6GWxYahcnaJvkeqzbgAtBT2ggQHXVYm2uyy1v1xC3Filh6UN8PdgHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544966; c=relaxed/simple;
	bh=X3DDj5nKV7vyVW3xzt8Y7s2vBu30dSCShq2mPzQc9fs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MfY33cqmzVksQiH6HOg3gGk7+g3C5G8MszhMv9nBn0OEiA3jknLqla/dj00qDfiZvF9bRGfH8yAijMKxm7qav9Op84Y/36Jvv1c1wKywqEJLOs1tJMlunF2yjgyS2yUSQm9tHzqNokNb906iBHr0Wh83p6Bnk8poE0sEMStyvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W9LN51w2Hz4f3jdq;
	Fri, 28 Jun 2024 11:22:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2D2991A016E;
	Fri, 28 Jun 2024 11:22:40 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP2 (Coremail) with SMTP id Syh0CgAHvoN+LH5m+ukzAg--.65441S3;
	Fri, 28 Jun 2024 11:22:39 +0800 (CST)
Subject: Re: [PATCH] blk-cgroup: don't clear stat in blkcg_reset_stats()
To: Waiman Long <longman@redhat.com>, Li Lingfeng
 <lilingfeng@huaweicloud.com>, tj@kernel.org, josef@toxicpanda.com,
 hch@lst.de, axboe@kernel.dk
Cc: ming.lei@redhat.com, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com, lilingfeng3@huawei.com, jack@suse.cz,
 Paolo VALENTE <paolo.valente@unimore.it>, "yukuai (C)" <yukuai3@huawei.com>
References: <20240627090856.2345018-1-lilingfeng@huaweicloud.com>
 <66095664-5a14-422a-a703-dec437577a3d@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c3303c93-bb66-c267-4e00-3a19a1ce01a0@huaweicloud.com>
Date: Fri, 28 Jun 2024 11:22:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <66095664-5a14-422a-a703-dec437577a3d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHvoN+LH5m+ukzAg--.65441S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1rtrW3Ar13KF45Cw18Grg_yoWrAw1xpF
	Wvk3W3C3yDKF1kAr10gayIqFyFkws5t3s8Jr15Xa4rKr1qyr9YvF1DZrZY9FyUCFWIqr48
	Jr45ZrZruayYgFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUAxhLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

+CC Jan and Paolo for bfq part.

在 2024/06/28 5:03, Waiman Long 写道:
> 
> On 6/27/24 05:08, Li Lingfeng wrote:
>> From: Li Lingfeng <lilingfeng3@huawei.com>
>>
>> The list corruption described in commit 6da668063279 ("blk-cgroup: fix
>> list corruption from resetting io stat") has no effect. It's unnecessary
>> to fix it.
>>
>> As for cgroup v1, it does not use iostat any more after commit
>> ad7c3b41e86b("blk-throttle: Fix io statistics for cgroup v1"), so using
>> memset to clear iostat has no real effect.
>> As for cgroup v2, it will not call blkcg_reset_stats() to corrupt the
>> list.
>>
>> The list of root cgroup can be used by both cgroup v1 and v2 while
>> non-root cgroup can't since it must be removed before switch between
>> cgroup v1 and v2.
>> So it may has effect if the list of root used by cgroup v2 was corrupted
>> after switching to cgroup v1, and switch back to cgroup v2 to use the
>> corrupted list again.
>> However, the root cgroup will not use the list any more after commit
>> ef45fe470e1e("blk-cgroup: show global disk stats in root cgroup 
>> io.stat").
>>
>> Although this has no negative effect, it is not necessary. Remove the
>> related code.
> You may be right that it may not be necessary in the mainline kernel, it 
> does fix the issue on distros with older kernels or some stable releases 
> where commit ad7c3b41e86b("blk-throttle: Fix io statistics for cgroup 
> v1") may not be present.
> 
>>
>> Fixes: 6da668063279 ("blk-cgroup: fix list corruption from resetting 
>> io stat")
> I don't think there should be a fixes tag or it will be backported to 
> stable releases.

Yes, and probably it's better to add:
Depends-on: ad7c3b41e86b ("blk-throttle: Fix io statistics for cgroup v1")
Depends-on: 0416f3be58c6 ("blk-cgroup: don't update io stat for root 
cgroup")

>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   block/blk-cgroup.c | 24 ------------------------
>>   1 file changed, 24 deletions(-)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 37e6cc91d576..1113c398a742 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -629,29 +629,6 @@ static void blkg_iostat_set(struct blkg_iostat 
>> *dst, struct blkg_iostat *src)
>>       }
>>   }
>> -static void __blkg_clear_stat(struct blkg_iostat_set *bis)
>> -{
>> -    struct blkg_iostat cur = {0};
>> -    unsigned long flags;
>> -
>> -    flags = u64_stats_update_begin_irqsave(&bis->sync);
>> -    blkg_iostat_set(&bis->cur, &cur);
>> -    blkg_iostat_set(&bis->last, &cur);
>> -    u64_stats_update_end_irqrestore(&bis->sync, flags);
>> -}
>> -
>> -static void blkg_clear_stat(struct blkcg_gq *blkg)
>> -{
>> -    int cpu;
>> -
>> -    for_each_possible_cpu(cpu) {
>> -        struct blkg_iostat_set *s = per_cpu_ptr(blkg->iostat_cpu, cpu);
>> -
>> -        __blkg_clear_stat(s);
>> -    }
>> -    __blkg_clear_stat(&blkg->iostat);
>> -}
>> -
>>   static int blkcg_reset_stats(struct cgroup_subsys_state *css,
>>                    struct cftype *cftype, u64 val)
>>   {
>> @@ -668,7 +645,6 @@ static int blkcg_reset_stats(struct 
>> cgroup_subsys_state *css,
>>        * anyway.  If you get hit by a race, retry.
>>        */
>>       hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
>> -        blkg_clear_stat(blkg);
>>           for (i = 0; i < BLKCG_MAX_POLS; i++) {
>>               struct blkcg_policy *pol = blkcg_policy[i];
> 
> If you are saying that iostat is no longer used in cgroup v1, why not 
> remove the blkcg_reset_stats() and its supporting functions and 
> deprecate the v1 reset_stats control file. The file should still be 
> there to avoid userspace regression, but it will be a nop.

No, this is not correct, blkg->iostat is not used in cgroup v1, however,
bfq(and probably blk-throtl) has it's only stats, and they rely on
pd_reset_stats_fn() from blkcg_reset_stats() to clear the stats. I don't
think remove it is a good idea for now, bfq maintainer must agree with
this.

Thanks,
Kuai
> 
> Cheers,
> Longman
> 
> 
> .
> 


