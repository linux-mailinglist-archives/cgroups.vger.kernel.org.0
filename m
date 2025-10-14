Return-Path: <cgroups+bounces-10712-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4606FBD8238
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 10:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9225F3E7D39
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 08:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4337A30F527;
	Tue, 14 Oct 2025 08:21:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A3E2DF6F9;
	Tue, 14 Oct 2025 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430098; cv=none; b=ocwxVipgsoPka/xBfcbVOZhCDZdJmfTEKFNPBp7DuAa4mwIMJjebsz0hqhBkXjMumP091QysCCCoyVUJ+limM1lbDYUkgAraQSjbXAL0fPWiLPd4AvMIpDLu6L8J3RRfzOWCsHYjRBifmvjOkisq/th27q4zaRL3v/WBcInOQ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430098; c=relaxed/simple;
	bh=473X0j9Ino9F9/5cmJpbLGotA7lNWkRoIJnwi/7Sn0o=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pxZR1+RheJn02pfJSsXEhHcowQBT+cn2bWwlgvsSHwF0eevj0/2aTsyPFoqVn1MM/IyoHaTYcIyGBxQFMk8jhO/1m6YUio7wVmdc1+45mYE8MwYID2lrfNMgPqAjs9D23ZRbV4dYRXv0VbnIh6ozrnXtA0156mLpZ27qwTteHvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cm6c405WVzYQtxM;
	Tue, 14 Oct 2025 16:20:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B53C51A141B;
	Tue, 14 Oct 2025 16:21:32 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP2 (Coremail) with SMTP id Syh0CgDnPUYKCO5oHndMAQ--.28256S3;
	Tue, 14 Oct 2025 16:21:32 +0800 (CST)
Subject: Re: [PATCH 1/4] blk-mq-debugfs: warn about possible deadlock
To: Ming Lei <ming.lei@redhat.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com,
 axboe@kernel.dk, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <20251014022149.947800-2-yukuai3@huawei.com> <aO4EniFy63IlWM_-@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <33c009e6-0cc3-bfc3-f7e5-8227cb467696@huaweicloud.com>
Date: Tue, 14 Oct 2025 16:21:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aO4EniFy63IlWM_-@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnPUYKCO5oHndMAQ--.28256S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyDZw15KF4DJF1fKF4rKrg_yoW8Kr1kpa
	yDGF15Gr40vrsxXasxZa17Jwnag3yvgF43CrWIkw4rArnxG3W3XF10vFWjkF93Zry8Gr40
	qr45trykCryUKa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/10/14 16:06, Ming Lei Ð´µÀ:
> On Tue, Oct 14, 2025 at 10:21:46AM +0800, Yu Kuai wrote:
>> Creating new debugfs entries can trigger fs reclaim, hence we can't do
>> this with queue freezed, meanwhile, other locks that can be held while
>> queue is freezed should not be held as well.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-mq-debugfs.c | 31 ++++++++++++++++++++++++-------
>>   1 file changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index 4896525b1c05..66864ed0b77f 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -608,9 +608,23 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
>>   	{},
>>   };
>>   
>> -static void debugfs_create_files(struct dentry *parent, void *data,
>> +static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
>> +				 void *data,
>>   				 const struct blk_mq_debugfs_attr *attr)
>>   {
>> +	/*
>> +	 * Creating new debugfs entries with queue freezed has the rist of
>> +	 * deadlock.
>> +	 */
>> +	WARN_ON_ONCE(q->mq_freeze_depth != 0);
>> +	/*
>> +	 * debugfs_mutex should not be nested under other locks that can be
>> +	 * grabbed while queue is freezed.
>> +	 */
>> +	lockdep_assert_not_held(&q->elevator_lock);
>> +	lockdep_assert_not_held(&q->rq_qos_mutex);
> 
> ->rq_qos_mutex use looks one real mess, in blk-cgroup.c, it is grabbed after
> queue is frozen. However, inside block/blk-rq-qos.c, the two are re-ordered,
> maybe we need to fix order between queue freeze and q->rq_qos_mutex first?
> Or move on by removing the above line?

Yeah, I see this reoder as well, and I tried to fix this in the other
thread for blkg configuration.

- queue is freezed by new helper blkg_conf_start(), and unfreezed after
   blkg_conf_end(), rq_qos_add() is now called between them.

And for wbt, there are two cases:
  - for blk-sysfs, queue is alredy freezed before rq_qos_add() as well;
  - for wbt_enable_default(), this looks still problemaic, we should fix
    the reorder seperatly.

Perhaps, should I fix this simple problem first, and then rebase the
thread to convert queue_lock to blkcg_mtuex?

Thanks,
Kuai


Thanks,
Kuai
> 
> Otherwise, this patch looks good.
> 
> 
> Thanks,
> Ming
> 
> 
> .
> 


