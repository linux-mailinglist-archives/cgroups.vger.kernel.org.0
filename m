Return-Path: <cgroups+bounces-3436-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0E791B55E
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 05:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3C71C21C5E
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 03:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8C31CFBE;
	Fri, 28 Jun 2024 03:17:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013B914F98;
	Fri, 28 Jun 2024 03:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544677; cv=none; b=QzxuM/qfQRGs09+7pIbMBBCJy00DSGs608lVMoNIjQ9xewhlkpdtHEuv2WkYyHhtbF4WnI8igGBhykNfbh0XfoVFmkYiymJbJrUBbS5iY5Jt8sXo0OkuVojRB76WDV3jXVum/eLCQ7mDtE5dMjHRAyYSTC0DvxwCHISE2Gac260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544677; c=relaxed/simple;
	bh=dMy4fHHtJeHBGQuTQc8XZeB7AVBx9rY1azNnkx0dm20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTiqauBNI9x00iyyQPFcC1uTv9kd5uMYGMaWs7sbCGr9tXXYdRtjGBjQpnyMRTzMfDVVlaKuPy3cWv95yyrxUf15EBqE5SYw3CzSNphd9SE0lZY0Cm7QjMN8WINKcM+RcT7CmubODQn0QVgi73QkZUkp4bafH+CB8GJzmKvKDTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W9LGc3kssz4f3jYb;
	Fri, 28 Jun 2024 11:17:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AA1121A0572;
	Fri, 28 Jun 2024 11:17:51 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP2 (Coremail) with SMTP id Syh0CgB34YZdK35mKJgzAg--.48554S3;
	Fri, 28 Jun 2024 11:17:51 +0800 (CST)
Message-ID: <6b4baf79-365f-946f-3d71-e78fafbd0988@huaweicloud.com>
Date: Fri, 28 Jun 2024 11:17:49 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH] blk-cgroup: don't clear stat in blkcg_reset_stats()
To: Waiman Long <longman@redhat.com>, tj@kernel.org, josef@toxicpanda.com,
 hch@lst.de, axboe@kernel.dk
Cc: ming.lei@redhat.com, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com, lilingfeng3@huawei.com, paolo.valente@unimore.it
References: <20240627090856.2345018-1-lilingfeng@huaweicloud.com>
 <66095664-5a14-422a-a703-dec437577a3d@redhat.com>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <66095664-5a14-422a-a703-dec437577a3d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB34YZdK35mKJgzAg--.48554S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1rtrW3Ar13KF45Cw18Grg_yoWrGF13pF
	WkC3W3C3yDKF1kJr10ga47XryF9ws5t34DJr15Xa4rKr1qyrySvF1DZrZY9FyUAFWxXr48
	Xr1jqr9rZay5K3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/


在 2024/6/28 5:03, Waiman Long 写道:
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
> You may be right that it may not be necessary in the mainline kernel, 
> it does fix the issue on distros with older kernels or some stable 
> releases where commit ad7c3b41e86b("blk-throttle: Fix io statistics 
> for cgroup v1") may not be present.
>
>>
>> Fixes: 6da668063279 ("blk-cgroup: fix list corruption from resetting 
>> io stat")
> I don't think there should be a fixes tag or it will be backported to 
> stable releases.
OK, I will remove it.
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
>>   -static void __blkg_clear_stat(struct blkg_iostat_set *bis)
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
I'm not sure if we can just remove blkcg_reset_stats() since
bfq_pd_reset_stats() may be called in it.

Thanks.
>
> Cheers,
> Longman


