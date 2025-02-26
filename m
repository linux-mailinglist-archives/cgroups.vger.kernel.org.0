Return-Path: <cgroups+bounces-6719-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCB6A45AF2
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2025 10:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80EC7A2E7A
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2025 09:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C90238157;
	Wed, 26 Feb 2025 09:56:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072BB23816C;
	Wed, 26 Feb 2025 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563774; cv=none; b=i5/mrFMYnviRFrtdxJ1M44tCE//S6bbKajiT9eRDRv6aJDU6drZPFdJrBN0CBFXqJCULfBUxxtv2ZcQUjD09fNrlQhmGkY/ECDvF9FHqe07C2jTMgJYhN6XRtv0HFbG4CV4zCmd1YY+ZdbyjU+UbrU6QEOhILCZe+m5eHk/TAlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563774; c=relaxed/simple;
	bh=ACfxlLi96pq3LwoFRbPH7LVakUiixUCwz36+zU6xyXY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=boHFqlJ7LFuoFYnoxWrXz3iEf9PrZRhzBby35bJ9IyNucDDHUmwvKPzVta6PWRd90SiwXmW56rOI2fNxF2TBowDJDKhownypKBeGd91KG4wPcDvXkVLNf+ek4elwm2W5Y+a/PzVk9/ESjDrZy6IGfQOG8cgo6fuoNKiM1B1VIDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z2qbh09NTz4f3lVs;
	Wed, 26 Feb 2025 17:55:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 49F631A06D7;
	Wed, 26 Feb 2025 17:56:07 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXul4z5b5nbYzHEw--.15301S3;
	Wed, 26 Feb 2025 17:56:05 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: fix lower bps rate by throtl_trim_slice()
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, vgoyal@redhat.com,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250226011627.242912-1-yukuai1@huaweicloud.com>
 <Z77R_rqgDdAvFVgP@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <021e6495-11e5-3b39-2786-d69cc4bf24f7@huaweicloud.com>
Date: Wed, 26 Feb 2025 17:56:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z77R_rqgDdAvFVgP@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul4z5b5nbYzHEw--.15301S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1kAFWxGr1kAF15Kw4xXrb_yoWrAF4xpF
	W3AFWF9Fs8XFyIkFW3X3Z3tayjk3yfGFyUGw15Cr48Awn8Cr1fKFnxAw4Y9a4rAas3uw4F
	v3WDXry7Cr12vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/02/26 16:34, Ming Lei Ð´µÀ:
> On Wed, Feb 26, 2025 at 09:16:27AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> The bio submission time may be a few jiffies more than the expected
>> waiting time, due to 'extra_bytes' can't be divided in
>> tg_within_bps_limit(), and also due to timer wakeup delay. In this
>> case, adjust slice_start to jiffies will discard the extra wait time,
>> causing lower rate than expected.
>>
>> This problem will cause blktests throtl/001 failure in case of
>> CONFIG_HZ_100=y, fix it by preserving one finished slice in
>> throtl_trim_slice() and allowing deviation between [0, 2 slices).
> 
> I think it only can cover single default slice deviation, since
> throtl_trim_slice() just keeps dispatch data in the previous single
> default slice. Or can you add words on how to allow 2 default slices
> deviation?
> 
>>
>> For example, assume bps_limit is 1000bytes, 1 jiffes is 10ms, and
>> slice is 20ms(2 jiffies), expected rate is 1000 / 1000 * 20 = 20 bytes
>> per slice.
>>
>> If user issues two 21 bytes IO, then wait time will be 30ms for the
>> first IO:
>>
>> bytes_allowed = 20, extra_bytes = 1;
>> jiffy_wait = 1 + 2 = 3 jiffies
>>
>> and consider
>> extra 1 jiffies by timer, throtl_trim_slice() will be called at:
>>
>> jiffies = 40ms
>> slice_start = 0ms, slice_end= 40ms
>> bytes_disp = 21
>>
>> In this case, before the patch, real rate in the first two slices is
>> 10.5 bytes per slice, and slice will be updated to:
>>
>> jiffies = 40ms
>> slice_start = 40ms, slice_end = 60ms,
>> bytes_disp = 0;
>>
>> Hence the second IO will have to wait another 30ms;
>>
>> With the patch, the real rate in the first slice is 20 bytes per slice,
>> which is the same as expected, and slice will be updated:
>>
>> jiffies=40ms,
>> slice_start = 20ms, slice_end = 60ms,
>> bytes_disp = 1;
>>
>> And now, there is still 19 bytes allowed in the second slice, and the
>> second IO will only have to wait 10ms;
>>
>> Fixes: e43473b7f223 ("blkio: Core implementation of throttle policy")
>> Reported-by: Ming Lei <ming.lei@redhat.com>
>> Closes: https://lore.kernel.org/linux-block/20250222092823.210318-3-yukuai1@huaweicloud.com/
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-throttle.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 8d149aff9fd0..cb472cf7b6b6 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -599,14 +599,23 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>>   	 * sooner, then we need to reduce slice_end. A high bogus slice_end
>>   	 * is bad because it does not allow new slice to start.
>>   	 */
>> -
>>   	throtl_set_slice_end(tg, rw, jiffies + tg->td->throtl_slice);
>>   
>>   	time_elapsed = rounddown(jiffies - tg->slice_start[rw],
>>   				 tg->td->throtl_slice);
>> -	if (!time_elapsed)
>> +	/* Don't trim slice until at least 2 slices are used */
>> +	if (time_elapsed < tg->td->throtl_slice * 2)
>>   		return;
>>   
>> +	/*
>> +	 * The bio submission time may be a few jiffies more than the expected
>> +	 * waiting time, due to 'extra_bytes' can't be divided in
>> +	 * tg_within_bps_limit(), and also due to timer wakeup delay. In this
>> +	 * case, adjust slice_start to jiffies will discard the extra wait time,
>> +	 * causing lower rate than expected. Therefore, one slice is preserved,
>> +	 * allowing deviation that is less than two slices.
>> +	 */
>> +	time_elapsed -= tg->td->throtl_slice;
> 
> Please document that default slice window size is doubled actually in
> this way.

I said two slices because there is a round down:

 >>   	time_elapsed = rounddown(jiffies - tg->slice_start[rw],
 >>   				 tg->td->throtl_slice);

Hence the deviation is actually between [1 ,2) jiffies, depends on the
time start to wait and how long the delay is.

If start to wait at slice_start + n * throtl_slice - 1, the deviation is
*at most 1 slice*

If start to wait at slice_stat + n * throtl_slice, the max deviation is
*less than 2 slices* (2 slices not included)

Now, I agree allowing deviation at most 1 slice is more appropriate. :)

Thanks,
Kuai

> 
> 
> Thanks,
> Ming
> 
> 
> .
> 


