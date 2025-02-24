Return-Path: <cgroups+bounces-6650-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C34FFA4139E
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 03:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28B067A5A34
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 02:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EDF17BEC6;
	Mon, 24 Feb 2025 02:39:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B074A08;
	Mon, 24 Feb 2025 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740364765; cv=none; b=nZJqQ9MO6OkShMOehF+B4JZ84kPYs8CH0m5L8tG8yxU1lwOo/ZtOGYpOe0IOXnzs/P4u9TmwC87OTu+PILvg0EyFzHF7Xw4FL8h4EdjGnctFNvViVmQpKhDX7k3MiuLcxqCQzfo00ba08MbklBZn9jBdepd0VHKgdYRbvX4rs9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740364765; c=relaxed/simple;
	bh=5RjiauYnaslNsItaZZ0Uctw9AJB1BDMVFgZTuq49+0I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qaKH1G4dOg8mjG/OsjeTSFywBgcmFeg2uDmTEV2eysNsZUNT9uAm/cyiCo2e9CUaBfxhuIPNj3AT5lA7ejUYU61Jw7+M2qN5p+V5g/0NQKmT3O9Zj4JEwgUjEwoD6Nn//coTsFbB1C0M8r8+FbKijWbXDmCBkXmMvk29ZHW1i8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z1Q0Z3zQhz4f3lDh;
	Mon, 24 Feb 2025 10:38:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B79B61A1381;
	Mon, 24 Feb 2025 10:39:17 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2DS27tnOKXnEg--.44611S3;
	Mon, 24 Feb 2025 10:39:15 +0800 (CST)
Subject: Re: [PATCH 2/2] blk-throttle: fix off-by-one jiffies wait_time
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250222092823.210318-1-yukuai1@huaweicloud.com>
 <20250222092823.210318-3-yukuai1@huaweicloud.com> <Z7nAJSKGANoC0Glb@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f2f54206-b5c0-7486-d607-337d29e9c145@huaweicloud.com>
Date: Mon, 24 Feb 2025 10:39:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z7nAJSKGANoC0Glb@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2DS27tnOKXnEg--.44611S3
X-Coremail-Antispam: 1UD129KBjvAXoW3KrykGFyxtrW8JF48tFyDGFg_yoW8GFW7Ao
	WfAF4Iq34xJryIywsrZF9rJF13J34vyr1Syrs5Zrs5JF12ga1Yq3y7WFy5X3Z3GFW2kFWI
	ka4Dt34Yyr4xJa1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYX7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWx
	JVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
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

ÔÚ 2025/02/22 20:16, Ming Lei Ð´µÀ:
> Hi Yukuai,
> 
> On Sat, Feb 22, 2025 at 05:28:23PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> wait_time is based on jiffies, and the calculation is:
>>
>> wait_time = extra_bytes * HZ / bps_limit;
>>
>> If wait time is not zero, the remainder is ignored, means wait time is
>> short by at most 1 jiffes; On the other hand, if wait time is zero, it
>> will be used as 1 jiffies, means it's excessive by at most 1 jiffes.
>>
>> This way causes blktests throtl/001 failure in case of CONFIG_HZ_100=y,
>> fix the problem by recording remainder as debt, and repay the debt
>> later.
> 
> After further analysis, I figured out that this one extra jiffy isn't the
> only reason for throtl/001 failure.
> 
> In blktests throtl/001, bps_limit is 1MB/sec, and BS is 4k, and
> COFIG_HZ=100, and default throttle slice is 2 jiffies(20ms):
> 
> - 20ms can submit 5 bios: 1024K/50(5*4k=20KB)
> 
> - the 6th bio is throttled, and the calculated wait is 1 jiffy from
> tg_within_bps_limit()
> 
> - given all the 6 bios are handled in the time of jiffies A, so A + 1(wait) + 2(slice)
> is programmed to start pending timer for scheduling dispatch
> 
> - when the pending timer is expired, the 6th bio is submitted, then the
>    current slice is trim/reset since the throttled 6th bio is dispatched.
> 
> Now in the whole throttle slice period, 6 bios(24KB) are submitted, and 3
> jiffies are taken, so 256 bios will take (256/6) * 30ms = 1.3sec.
> 
> But blktests throtl/001 still should pass since the allowed deviation is 0.5sec,
> and 1.3 < 1.5.
> 
> Actually there is another reason of timer delay, looks one extra jiffy is
> delayed when the timer is triggered, which can be observed reliably by:
> 
> bpftrace -e 'kfunc:throtl_pending_timer_fn { @timer_expire_delay = lhist(jiffies - args->t->expires, 0, 16, 1);}'
> 
> Then 256 bios will take (256/6) * 40ms = 1.7sec, which does match with
> observation in throtl/001.

Thanks for the detailed explanation.
> 
> Yeah, killing one jiffy may pass blktests throtl/001, but, ...
> 
>>
>> Reported-and-tested-by: Ming Lei <ming.lei@redhat.com>
>> Closes: https://lore.kernel.org/all/20250220111735.1187999-1-ming.lei@redhat.com/
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-throttle.c | 24 +++++++++++++++++-------
>>   block/blk-throttle.h | 12 ++++++++----
>>   2 files changed, 25 insertions(+), 11 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 0096e486b1e3..3828c6535605 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -703,9 +703,10 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
>>   }
>>   
>>   static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
>> -				u64 bps_limit)
>> +				u64 bps_limit, bool *has_debt)
>>   {
>>   	bool rw = bio_data_dir(bio);
>> +	long long carryover_bytes;
>>   	long long bytes_allowed;
>>   	u64 extra_bytes;
>>   	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
>> @@ -730,10 +731,16 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
>>   
>>   	/* Calc approx time to dispatch */
>>   	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
>> -	jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
>> -
>> -	if (!jiffy_wait)
>> -		jiffy_wait = 1;
>> +	jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit, &carryover_bytes);
>> +	if (carryover_bytes) {
>> +		/*
>> +		 * If extra_bytes is not divisible, the remainder is recorded as
>> +		 * debt. Caller must ensure the current slice has at least 1
>> +		 * more jiffies to repay the debt.
>> +		 */
>> +		*has_debt = true;
>> +		tg->carryover_bytes[rw] -= div64_u64(carryover_bytes, HZ);
>> +	}
> 
> Thinking of further, it may not be good to use ->carryover_bytes[]:
> 
> - if tg_within_bps_limit() returns 0 and the bio is dispatched
>    immediately, throtl_trim_slice() is called and ->carryover_bytes[]
>    is cleared.
> 
I think this should not happen, because:

If the slice is extended in consideration of carryover_bytes,
throtl_slice_used() is checked first in throtl_trim_slice().

> - if tg_within_bps_limit() returns >0, this bio will be throttled, and
>    tg_within_bps_limit() may be called more than one time, so
>    tg->carryover_bytes[] could be over-counted.
> 
Yes, carryover_bytes can be over-counted with this patch. For now, the
only way that I can think of to fix this is to handle carryover_bytes
from the caller of tg_may_dispatch():
  - tg_within_limit(), only handle if bio is dispatched directly;
  - tg_update_disptime(), never handle;
  - throtl_dispatch_tg(), always handle;

The idea is that only handle when bio is dispatched, like following
patch(not tested yet):

[yukuai@localhost linux-next]$ git diff
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 3828c6535605..20f6bab07960 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -703,10 +703,9 @@ static unsigned long tg_within_iops_limit(struct 
throtl_grp *tg, struct bio *bio
  }

  static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct 
bio *bio,
-                               u64 bps_limit, bool *has_debt)
+                               u64 bps_limit, long long *carryover_bytes)
  {
         bool rw = bio_data_dir(bio);
-       long long carryover_bytes;
         long long bytes_allowed;
         u64 extra_bytes;
         unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
@@ -731,16 +730,7 @@ static unsigned long tg_within_bps_limit(struct 
throtl_grp *tg, struct bio *bio,

         /* Calc approx time to dispatch */
         extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
-       jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit, 
&carryover_bytes);
-       if (carryover_bytes) {
-               /*
-                * If extra_bytes is not divisible, the remainder is 
recorded as
-                * debt. Caller must ensure the current slice has at least 1
-                * more jiffies to repay the debt.
-                */
-               *has_debt = true;
-               tg->carryover_bytes[rw] -= div64_u64(carryover_bytes, HZ);
-       }
+       jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit, 
carryover_bytes);

         /*
          * This wait time is without taking into consideration the rounding
@@ -755,13 +745,12 @@ static unsigned long tg_within_bps_limit(struct 
throtl_grp *tg, struct bio *bio,
   * of jiffies to wait before this bio is with-in IO rate and can be 
dispatched
   */
  static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
-                           unsigned long *wait)
+                           unsigned long *wait, long long *carryover_bytes)
  {
         bool rw = bio_data_dir(bio);
         unsigned long bps_wait = 0, iops_wait = 0, max_wait = 0;
         u64 bps_limit = tg_bps_limit(tg, rw);
         u32 iops_limit = tg_iops_limit(tg, rw);
-       bool has_debt = false;

         /*
          * Currently whole state machine of group depends on first bio
@@ -792,20 +781,18 @@ static bool tg_may_dispatch(struct throtl_grp *tg, 
struct bio *bio,
         else
                 throtl_extend_slice(tg, rw, jiffies + 
tg->td->throtl_slice);

-       bps_wait = tg_within_bps_limit(tg, bio, bps_limit, &has_debt);
+       bps_wait = tg_within_bps_limit(tg, bio, bps_limit, carryover_bytes);
         iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
         if (bps_wait + iops_wait == 0) {
                 if (wait)
                         *wait = 0;
-               if (has_debt)
-                       throtl_extend_slice(tg, rw, jiffies + 1);
                 return true;
         }

         max_wait = max(bps_wait, iops_wait);
         if (wait)
                 *wait = max_wait;
-       throtl_extend_slice(tg, rw, jiffies + max_wait + has_debt);
+       throtl_extend_slice(tg, rw, jiffies + max_wait);

         return false;
  }
@@ -858,19 +845,33 @@ static void throtl_add_bio_tg(struct bio *bio, 
struct throtl_qnode *qn,
         throtl_enqueue_tg(tg);
  }

+static void handle_tg_carryover_bytes(struct throtl_grp *tg,
+                                     long long carryover_bytes, int rw)
+{
+       if (carryover_bytes == 0)
+               return;
+       /*
+        * IO is dispatched without waiting for @carryover_bytes, make sure
+        * current slice has 1 more jiffies to repay the debt.
+        */
+       tg->carryover_bytes[rw] -= carryover_bytes;
+       throtl_extend_slice(tg, rw, tg->slice_end[rw] + 1);
+}
+
  static void tg_update_disptime(struct throtl_grp *tg)
  {
         struct throtl_service_queue *sq = &tg->service_queue;
         unsigned long read_wait = -1, write_wait = -1, min_wait = -1, 
disptime;
+       long long carryover_bytes = 0;
         struct bio *bio;

         bio = throtl_peek_queued(&sq->queued[READ]);
         if (bio)
-               tg_may_dispatch(tg, bio, &read_wait);
+               tg_may_dispatch(tg, bio, &read_wait, &carryover_bytes);

         bio = throtl_peek_queued(&sq->queued[WRITE]);
         if (bio)
-               tg_may_dispatch(tg, bio, &write_wait);
+               tg_may_dispatch(tg, bio, &write_wait, &carryover_bytes);

         min_wait = min(read_wait, write_wait);
         disptime = jiffies + min_wait;
@@ -943,12 +944,15 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
         unsigned int nr_reads = 0, nr_writes = 0;
         unsigned int max_nr_reads = THROTL_GRP_QUANTUM * 3 / 4;
         unsigned int max_nr_writes = THROTL_GRP_QUANTUM - max_nr_reads;
+       long long carryover_bytes = 0;
         struct bio *bio;

         /* Try to dispatch 75% READS and 25% WRITES */

         while ((bio = throtl_peek_queued(&sq->queued[READ])) &&
-              tg_may_dispatch(tg, bio, NULL)) {
+              tg_may_dispatch(tg, bio, NULL, &carryover_bytes)) {
+               handle_tg_carryover_bytes(tg, carryover_bytes, READ);
+               carryover_bytes = 0;

                 tg_dispatch_one_bio(tg, READ);
                 nr_reads++;
@@ -958,7 +962,9 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
         }

         while ((bio = throtl_peek_queued(&sq->queued[WRITE])) &&
-              tg_may_dispatch(tg, bio, NULL)) {
+              tg_may_dispatch(tg, bio, NULL, &carryover_bytes)) {
+               handle_tg_carryover_bytes(tg, carryover_bytes, WRITE);
+               carryover_bytes = 0;

                 tg_dispatch_one_bio(tg, WRITE);
                 nr_writes++;
@@ -1613,11 +1619,18 @@ void blk_throtl_cancel_bios(struct gendisk *disk)

  static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, 
bool rw)
  {
+       long long carryover_bytes = 0;
+
         /* throtl is FIFO - if bios are already queued, should queue */
         if (tg->service_queue.nr_queued[rw])
                 return false;

-       return tg_may_dispatch(tg, bio, NULL);
+       if (tg_may_dispatch(tg, bio, NULL, &carryover_bytes)) {
+               handle_tg_carryover_bytes(tg, carryover_bytes, rw);
+               return true;
+       }
+
+       return false;
  }

  static void tg_dispatch_in_debt(struct throtl_grp *tg, struct bio 
*bio, bool rw)


> Actually this patch changes tg_within_bps_limit() to one stateful function...
> 
>>   
>>   	/*
>>   	 * This wait time is without taking into consideration the rounding
>> @@ -754,6 +761,7 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>>   	unsigned long bps_wait = 0, iops_wait = 0, max_wait = 0;
>>   	u64 bps_limit = tg_bps_limit(tg, rw);
>>   	u32 iops_limit = tg_iops_limit(tg, rw);
>> +	bool has_debt = false;
>>   
>>   	/*
>>    	 * Currently whole state machine of group depends on first bio
>> @@ -784,18 +792,20 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>>   	else
>>   		throtl_extend_slice(tg, rw, jiffies + tg->td->throtl_slice);
>>   
>> -	bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
>> +	bps_wait = tg_within_bps_limit(tg, bio, bps_limit, &has_debt);
>>   	iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
>>   	if (bps_wait + iops_wait == 0) {
>>   		if (wait)
>>   			*wait = 0;
>> +		if (has_debt)
>> +			throtl_extend_slice(tg, rw, jiffies + 1);
>>   		return true;
>>   	}
>>   
>>   	max_wait = max(bps_wait, iops_wait);
>>   	if (wait)
>>   		*wait = max_wait;
>> -	throtl_extend_slice(tg, rw, jiffies + max_wait);
>> +	throtl_extend_slice(tg, rw, jiffies + max_wait + has_debt);
>>   
>>   	return false;
>>   }
>> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
>> index 1a36d1278eea..56dcb5ce412f 100644
>> --- a/block/blk-throttle.h
>> +++ b/block/blk-throttle.h
>> @@ -110,10 +110,14 @@ struct throtl_grp {
>>   	unsigned int last_io_disp[2];
>>   
>>   	/*
>> -	 * The following two fields are updated when new configuration is
>> -	 * submitted while some bios are still throttled, they record how many
>> -	 * bytes/ios are waited already in previous configuration, and they will
>> -	 * be used to calculate wait time under new configuration.
>> +	 * The following two fields are updated when:
>> +	 * 1) new configuration is submitted while some bios are still
>> +	 * throttled, they record how many bytes/ios are waited already in
>> +	 * previous configuration;
>> +	 * 2) IOs which may cause priority inversions are dispatched while tg is
>> +	 * over limit, these IOs will be dispatched directly;
>> +	 * 3) While calculating wait_time for IO, extra_bytes * HZ is not
>> +	 * divisible by bps_limit, the remainder will be recorded;
>>   	 */
> 
> blk-throttle takes token bucket algorithm, and the implementation
> shouldn't be sensitive with the above two factors, because the bps
> rate is controlled over the whole bucket(slice). Meantime it is still
> tricky to maintain ->carryover_bytes during slice cycle, which can't
> cover timer delay too.
> 
> Another way is to avoid to trim slice too soon in case of owning too
> much debt, something like the following does avoid this issue:


> 
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 8d149aff9fd0..a778ebbb6887 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -615,6 +615,14 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>   	if (bytes_trim <= 0 && io_trim <= 0)
>   		return;
>   
> +	if (tg_bps_limit(tg, rw) != U64_MAX) {
> +		long long disp = tg->bytes_disp[rw];
> +
> +		if (bytes_trim > disp && (bytes_trim - disp) > disp / 2 && time_elapsed <
> +				8 * tg->td->throtl_slice)
> +			return;
> +	}

I'm not sure why we need this, why will there be too much debt? debt
from remainder should be at most 1 jiffies, new debt can only happen
when old debt is paid.

If you mean we don't clear debt in time, and the historical debt
accumulated too much, then we might want to trim slice sooner and a new
branch try to clear historical debt.

BTW, throtl_trim_slice() looks like problematic:

-       if (bytes_trim <= 0 && io_trim <= 0)
+       if (bytes_trim <= 0 || io_trim <= 0 ||
+           tg->bytes_disp[rw] < bytes_trim || tg->io_disp[rw] < io_trim)
                 return;

Otherwise, debt can be ignored.

Thanks,
Kuai

> +
>   	tg->carryover_bytes[rw] = 0;
>   	if ((long long)tg->bytes_disp[rw] >= bytes_trim)
>   		tg->bytes_disp[rw] -= bytes_trim;
> 
> 
> Thanks,
> Ming
> 
> 
> .
> 


