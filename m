Return-Path: <cgroups+bounces-6709-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2062CA43D2A
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 12:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFE616F1C7
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 11:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825EA267AE1;
	Tue, 25 Feb 2025 11:09:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23892676F7;
	Tue, 25 Feb 2025 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481780; cv=none; b=V6ZuS+P5bCXKP3TBv8K6hh2MeTBZ+a2mN1LcuTzpTLMBggk0a4fNKn0a9V5GqqEue+CEunqFX+9SnDW991cOyKKNPsPa9b3rduGfKrHhEZGGC3KS+dY3N94MVa4bD0qt3hH2zOghSeHsLz9/oceYYwrmkrVyWYW5kKoXnnLo7ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481780; c=relaxed/simple;
	bh=d1JecBOd39KaxgofY9dObpdwKr5wka7PaavQk7GYTxo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YuGP3Bc/ChnLvFAy7nI3H1bXXZgwlPsB0qUuuj/D1Z3iwLo98m7Rg1A7N91RhveecVSQCxaxB8218GrB+URVJrE5FBMtctElyGheQxZUI/PtVLUBsajGoyQynDdN0uFi/YJEgSeT6OQoCDc7WUYSehVS85ZymUhgd3WOhSzLJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z2FH00sZCz4f3jt0;
	Tue, 25 Feb 2025 19:09:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9294A1A0DE0;
	Tue, 25 Feb 2025 19:09:32 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB321_qpL1nVnlrEw--.6688S3;
	Tue, 25 Feb 2025 19:09:32 +0800 (CST)
Subject: Re: [PATCH 2/2] blk-throttle: fix off-by-one jiffies wait_time
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <Z7nAJSKGANoC0Glb@fedora>
 <f2f54206-b5c0-7486-d607-337d29e9c145@huaweicloud.com>
 <Z7vnTyk6Y6X4JWQB@fedora>
 <e6a29a6a-f5ec-7953-14e9-2550a549f955@huaweicloud.com>
 <Z7w0P8ImJiZhRsPD@fedora>
 <611f02a8-8430-16cf-46e5-e9417982b077@huaweicloud.com>
 <Z70btzRaN83FbTJp@fedora>
 <8473fca2-16ab-b2a6-ede7-d1449aa7d463@huaweicloud.com>
 <Z70qvZEBdq6L3-Yb@fedora>
 <084e25a1-5ed7-3097-5bae-b87addeaf01f@huaweicloud.com>
 <Z719gj8GOl0itRwV@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <dc2b3a40-b33b-0bc5-3a73-18b288b4283f@huaweicloud.com>
Date: Tue, 25 Feb 2025 19:09:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z719gj8GOl0itRwV@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB321_qpL1nVnlrEw--.6688S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW3WF4rGr13KrW3Jw47urg_yoW8Zr4DpF
	Waqrn0kr4YqFn7KF4Fv3Z8Wa48AayDWr98Gw4DJrWxA3WDCw1xtF12kFs0kF9ayFn7Cr4j
	va4rXFy3AFy8ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2025/02/25 16:21, Ming Lei 写道:
> On Tue, Feb 25, 2025 at 11:12:24AM +0800, Yu Kuai wrote:
>> Hi, Ming!
>>
>> 在 2025/02/25 10:28, Ming Lei 写道:
>>> Can you explain in details why it signals that the rate is expected now?
>>>
>>> If rate isn't expected, it will cause trouble to trim, even just the
>>> previous part.
>>
>> Ok, for example, assume bps_limit is 1000bytes, 1 jiffes is 10ms, and
>> slice is 20ms(2 jiffies).
>>
> 
> We all know how it works, but I didn't understand the behind idea why it
> is correct. Now I figured it out:
> 
> 1) increase default slice window to 2 * td->throttle_slice
> 
> 2) slice window is set as [jiffies - td->throttle_slice, jiffies + td->throttle_slice]
> 
> 3) initialize td->bytes_disp[]/td->io_dis[] as actual dispatched bytes/ios
> done [jiffies - td->throttle_slice, 0]
> 
> This approach looks smart, and it should work well for any deviation which is <= 1
> throttle_slice.
> 
> Probably it is enough for fixing the issue in throtl/001, even though 2 jiffies
> timer drift still may be observed, see the below log collected in my VM(HZ_100)
> by just running one time of blktests './check throtl':
> 
> @timer_expire_delay:
> [1, 2)               387 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [2, 3)                11 |@                                                   |
> 
> bpftrace -e 'kfunc:throtl_pending_timer_fn { @timer_expire_delay = lhist(jiffies - args->t->expires, 0, 16, 1);}'
> 
> 
> Also I'd suggest to remove ->carryover_bytes/ios since blk-throttle algorithm is
> supposed to be adaptive, and the approach I suggested may cover this area,
> what do you think of this cleanup? I have one local patchset, which can
> pass all blktest throtl tests with removing ->carryover_bytes/ios.
> 

It's always welcome for such cleanup. BTW, do you have plans to support
bio merge for iops limit in blk-throttle? Since bio split is handled. I
was thinking about using carryover_ios, perhaps you can handle this as
well.

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


