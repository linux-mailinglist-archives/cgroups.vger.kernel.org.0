Return-Path: <cgroups+bounces-9635-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743D0B41181
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 02:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AB93B42B2
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 00:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A10194A44;
	Wed,  3 Sep 2025 00:54:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14DE169AE6;
	Wed,  3 Sep 2025 00:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756860881; cv=none; b=DIjlOx14hJTca44b9HnF+QoZh43LksJrD44dr2t3l2D2N24hFIgE9gp6svzthlGuCuhwyFtYj+WBbZB96bbVhbp6uu+gcPWDx8LIyI+sGe/zbM2Ci1A8zdH+91G85lEDuSxDQKcEafwY0qeJnqMy6XmqasBJRGaIBR3r+u3rpn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756860881; c=relaxed/simple;
	bh=uM0/KISybEmjyjN+7+M5GOMNINEyW3Uac8ns2FKIlew=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OVMSCeGghA7GFcBLHMectVPpNXVBwAwgxV9/9SzSRTRpD0HpICf9e4STd35v4qbYPZsQaKwhaJxYFw+Ta5O++n91fRgwnpB4lDAMPPWEHcWO8k4NxqPdSxXp326amidWxQiw3AgmkJKSbczor+zfEc4owjRflxIZ8SMk/t4gmG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cGkf43yjwzKHMdB;
	Wed,  3 Sep 2025 08:54:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6A9491A19E7;
	Wed,  3 Sep 2025 08:54:36 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Y3JkbdoBGHNBA--.44518S3;
	Wed, 03 Sep 2025 08:54:36 +0800 (CST)
Subject: Re: [PATCH RFC v3 02/15] block: add QUEUE_FLAG_BIO_ISSUE
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 hch@infradead.org, colyli@kernel.org, hare@suse.de, dlemoal@kernel.org,
 tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 song@kernel.org, kmo@daterainc.com, satyat@google.com, ebiggers@google.com,
 neil@brown.name, akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-3-yukuai1@huaweicloud.com>
 <8c960400-ef46-45aa-85d9-d0e1c60b9c0d@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8307c778-cdda-d6b0-9302-d466187e2399@huaweicloud.com>
Date: Wed, 3 Sep 2025 08:54:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8c960400-ef46-45aa-85d9-d0e1c60b9c0d@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8Y3JkbdoBGHNBA--.44518S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4fXF1fXF4rur4ftr1DZFb_yoW8XrW5pr
	4kXry7t345K3ykWF18ta1DAryUGr4qka43Gw1FyayfJr4xuryjqF18ZFyvgFWkZF4kur15
	ZF1FqFs5ur4rG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/03 1:05, Bart Van Assche 写道:
> On 8/31/25 8:32 PM, Yu Kuai wrote:
>> @@ -372,7 +372,10 @@ static inline void blkg_put(struct blkcg_gq *blkg)
>>   static inline void blkcg_bio_issue_init(struct bio *bio)
>>   {
>> -    bio->issue_time_ns = blk_time_get_ns();
>> +    struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>> +
>> +    if (test_bit(QUEUE_FLAG_BIO_ISSUE, &q->queue_flags))
>> +        bio->issue_time_ns = blk_time_get_ns();
>>   }
>>   static inline void blkcg_use_delay(struct blkcg_gq *blkg)
>> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
>> index 554b191a6892..c9b3bd12c87c 100644
>> --- a/block/blk-iolatency.c
>> +++ b/block/blk-iolatency.c
>> @@ -767,6 +767,7 @@ static int blk_iolatency_init(struct gendisk *disk)
>>       if (ret)
>>           goto err_qos_del;
>> +    blk_queue_flag_set(QUEUE_FLAG_BIO_ISSUE, disk->queue);
>>       timer_setup(&blkiolat->timer, blkiolatency_timer_fn, 0);
>>       INIT_WORK(&blkiolat->enable_work, blkiolatency_enable_work_fn);
> 
> Shouldn't QUEUE_FLAG_BIO_ISSUE be cleared when initializing
> bio->issue_time_ns is no longer necessary?
> 

iolatency can never be freed after it's initialized, however, I can add
and clear this flag in blkiolatency_enable_work_fn() instead, when
iolatency is really enabled or discabled.

Thanks,
Kuai

> Thanks,
> 
> Bart.
> 
> .
> 


