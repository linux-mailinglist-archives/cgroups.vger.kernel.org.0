Return-Path: <cgroups+bounces-6655-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AD8A41E72
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 13:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99471709C1
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 12:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAE21C6FE5;
	Mon, 24 Feb 2025 12:03:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503D1863E;
	Mon, 24 Feb 2025 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398622; cv=none; b=lmenU6zdvTZFDSxyVsdbdA7GS4xaH1/Pak5Z8gw0/EtjiGfcsQbWArhMYiT7L6GAxN3aI1Eh+t9IBfv1+mFV0kf86LPT1uj98miz0g+wc73rgO+hvGL7QzhUAE76i1F/syxSn3nQYWXniQ1TfjntVG0r1aIwBZ2DKlsEFZQuMFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398622; c=relaxed/simple;
	bh=qj/7+h+YO4IWXDlyyrsl42hIMMDMHH7S0CosJ3X5eZQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LKA+QYZszfBfRVuvjilGbmgMzpL5Uj8KpB1WDC0Y40o8NgLJ54d0AYe/v8bUPc8WJ8BqpTxwhsGbN4mXVjgA6/rExvBb6IFZ+Z1UZcmyo2+ystaIqrPGqOrs2lPjBZQRnMn8gEXOFvkDYZ7dB54M2EJlSQQ7jRvlEOYz8uGo5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z1fWg4qBcz4f3lDF;
	Mon, 24 Feb 2025 20:03:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D6F481A0D90;
	Mon, 24 Feb 2025 20:03:34 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXu18UYLxnqgEOEw--.53849S3;
	Mon, 24 Feb 2025 20:03:34 +0800 (CST)
Subject: Re: [PATCH 2/2] blk-throttle: fix off-by-one jiffies wait_time
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250222092823.210318-1-yukuai1@huaweicloud.com>
 <20250222092823.210318-3-yukuai1@huaweicloud.com> <Z7nAJSKGANoC0Glb@fedora>
 <f2f54206-b5c0-7486-d607-337d29e9c145@huaweicloud.com>
 <Z7vnTyk6Y6X4JWQB@fedora>
 <e6a29a6a-f5ec-7953-14e9-2550a549f955@huaweicloud.com>
 <Z7w0P8ImJiZhRsPD@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <611f02a8-8430-16cf-46e5-e9417982b077@huaweicloud.com>
Date: Mon, 24 Feb 2025 20:03:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z7w0P8ImJiZhRsPD@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXu18UYLxnqgEOEw--.53849S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw17Jr15Cw1DJF4rJr1kKrg_yoW7Jr1UpF
	WayF4aga1DJFyxKFWFvw1Fvay0k3yfJryDJw1rJryUC34qgas7KF4Iyrs0kFy2vwn7uw4I
	vw1jqry3AF4jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
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

在 2025/02/24 16:56, Ming Lei 写道:
> On Mon, Feb 24, 2025 at 03:03:18PM +0800, Yu Kuai wrote:
>> Hi, Ming!
>>
>> 在 2025/02/24 11:28, Ming Lei 写道:
>>> throtl_trim_slice() returns immediately if throtl_slice_used()
>>> is true.
>>>
>>> And throtl_slice_used() checks jiffies in [start, end] via time_in_range(),
>>> so if `start <= jiffies <= end', it still returns false.
>>
>> Yes, I misread the code, by thinking throtl_slice_used() will return
>> true if the slice is still used. :(
>>
>>
>>>> BTW, throtl_trim_slice() looks like problematic:
>>>>
>>>> -       if (bytes_trim <= 0 && io_trim <= 0)
>>>> +       if (bytes_trim <= 0 || io_trim <= 0 ||
>>>> +           tg->bytes_disp[rw] < bytes_trim || tg->io_disp[rw] < io_trim)
>>>>                   return;
>>> That is exactly what my patch is doing, just taking deviation and
>>> timeout into account, also U64_MAX limit has to be excluded.
>> Yes, perhaps you can add some comments in the last two conditions of
>> your patch.
> 
> Yes, we need to add comment on the check, how about the following words?
> 
> ```
> 
> If actually rate doesn't match with expected rate, do not trim slice
> otherwise the present rate control info is lost, we don't have chance
> to compensate it in the following period of this slice any more.

So, I just give your patch a test, and result is 1.3s while 1s is
expected. While debuging, a new idea come up in mind. :)

How about keep at least one slice out of consideration from
throtl_trim_slice()? With following patch, the result is between
1.01-1.03s in my VM.

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8d149aff9fd0..5207c85098a5 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -604,9 +604,12 @@ static inline void throtl_trim_slice(struct 
throtl_grp *tg, bool rw)

         time_elapsed = rounddown(jiffies - tg->slice_start[rw],
                                  tg->td->throtl_slice);
-       if (!time_elapsed)
+       /* don't trim slice until at least 2 slice is used */
+       if (time_elapsed < tg->td->throtl_slice * 2)
                 return;

+       /* dispite the last slice, trim previous slice */
+       time_elapsed -= tg->td->throtl_slice;
         bytes_trim = calculate_bytes_allowed(tg_bps_limit(tg, rw),
                                              time_elapsed) +
                      tg->carryover_bytes[rw];

> 
> Add one deviation threshold since bio size is usually not divisible by
> present rate, and bio dispatch should be done or nothing
> 
> Also limit max slice size for avoiding to extend the window too big.
> 
> ```
> 
> 
>> I think maybe you're concerned about the case IO is
>> throttled by IOs and bytes_disp should really erase extra bytes that
>> does not reach bps_limit.
>>
>>>
>>> If you test the patch, it works just fine. My patch controls bytes_exp
>>> <= 1.5 * disp, then throtl/001 can be completed in 1.5sec, and if it is
>>> changed to 1.25 * disp, the test can be completed in 1.25sec.
>>>
>>> With this fix, why do we have to play the complicated carryover
>>> trick?
>>>
>>
>> I understand your code now. carryover_bytes in this case is wrong, as
>> long as new slice is not started, and trim slice doesn't erase extra
>> bytes by mistake, throttle time should be accurate over time because
>> bytes_disp is accurate.
> 
> Yes.
> 
> More or less wait for handling single bio can just affect instantaneous rate,
> but the algorithm is adaptive so it can adjust the following wait if the
> slice isn't over.
> 
>>
>> And root cause really is throtl_trim_slice().
>>
>> However, by code review, I think throtl_start_new_slice() should be
>> handled as well, the same as throtl_trim_slice(), if the old bio is
>> dispatched with one more jiffies wait time, issue a new bio in the same
>> jiffies will have the same problem. For example:
> 
> throtl_start_new_slice() is called when nothing is queued and the current
> slice is used, so probably it is fine.
> 
> throtl_start_new_slice_with_credit() is called when dispatching one
> bio, and it is still called when the current slice is used.
> 
>>
>> Caller do sync IO, with io size: (bps_limit / (HZ / throtl_slice) + 1),
> 
> This will cause wait for every single IO.
> 
> But once the IO is throttled because of the wait, throtl_start_new_slice()
> won't succeed any more, meantime throtl_trim_slice() will try to fix the
> rate control for the extra 1 jiffies.
> 
> So in-tree code with trim fix works just fine if consecutive IOs are
> coming.
> 
>> and caller will issue new IO when old IO is done. Then in this case,
>> each IO will start a new slice and wait for throtl_slice + 1 jiffies. I
>> believe this can be fixed as well so that BIOs after the first one will
>> only wait for throtl_silce jiffies.
> 
> I guess the above case only exists in theory when you submit new IO
> after the old IO is dispatched immediately. Not sure this case is really
> meaningful because submission period/latency is added/faked by user.

Yes, this case is just a theory, we don't need to care for now. :)

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


