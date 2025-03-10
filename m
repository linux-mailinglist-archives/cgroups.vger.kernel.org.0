Return-Path: <cgroups+bounces-6909-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC9FA58A30
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 02:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA7116A0C3
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 01:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5528A189F36;
	Mon, 10 Mar 2025 01:59:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E968C16D9C2;
	Mon, 10 Mar 2025 01:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571953; cv=none; b=fRlokmNKtAwosn7N9xF9BN/aSETWrwjzqo017w/jWNtu0sdAd0nHm/rmLxEaCwSxm6Fi+QV9hx/OxbLfA3IpTzMSbU5hUsRsBOUUHK9faiFtDC004zQNZbFuNN0elaJsvJ7eRMuBRnUPNAuVogaqDdAk/CC9MyS/XyXBNQo/VEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571953; c=relaxed/simple;
	bh=z4U2Yepj8+Rxo+bbVZwMaxR9KQ3v6DWGnPNdRQjwXqU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LajjTEBg6GRiCR4u36SXBPewUFJ3vqRn79aj+BYbcpREpnt27iurLJFanHGNuaKhzPEwKU2jjUXpJXzXjmsNRzV32u3+Dd04o267FJ3zgQGQvmqX33C2bHmJIs4eNgwAKUuIYrLlzXSBou3XEZ4aUaK1EBjGhR5vPYtZjAUf3W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZB0Rc5ZxYz4f3lfZ;
	Mon, 10 Mar 2025 09:58:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 83CA71A15A4;
	Mon, 10 Mar 2025 09:59:00 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGBhR85n5aAwGA--.5165S3;
	Mon, 10 Mar 2025 09:58:58 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: support io merge over iops_limit
To: Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, axboe@kernel.dk, josef@toxicpanda.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250307090152.4095551-1-yukuai1@huaweicloud.com>
 <Z8sZyElaHQQwKqpB@slm.duckdns.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5fc124c9-e202-99ca-418d-0f52d027640f@huaweicloud.com>
Date: Mon, 10 Mar 2025 09:58:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z8sZyElaHQQwKqpB@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHrGBhR85n5aAwGA--.5165S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4fCr45Xr4rArWfJr1fWFg_yoW8KF13pF
	W2gFsakrZxJFnFk397uwn2qFWFy3y3CrW5AryrWrZxtan0yrnFyrWIvr1Yk3ykXF4fCay2
	qr1jqas5ua15Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

ÔÚ 2025/03/08 0:07, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Fri, Mar 07, 2025 at 05:01:52PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
>> support to account split IO for iops limit, because block layer provides
>> io accounting against split bio.
>>
>> However, io merge is still not handled, while block layer doesn't
>> account merged io for iops. Fix this problem by decreasing io_disp
>> if bio is merged, and following IO can use the extra budget. If io merge
>> concurrent with iops throttling, it's not handled if one more or one
>> less bio is dispatched, this is fine because as long as new slice is not
>> started, blk-throttle already preserve one extra slice for deviation,
>> and it's not worth it to handle the case that iops_limit rate is less than
>> one per slice.
>>
>> A regression test will be added for this case [1], before this patch,
>> the test will fail:
>>
>> +++ /root/blktests-mainline/results/nodev/throtl/007.out.bad
>> @@ -1,4 +1,4 @@
>>   Running throtl/007
>>   1
>> -1
>> +11
>>   Test complete
>>
>> [1] https://lore.kernel.org/all/20250307080318.3860858-2-yukuai1@huaweicloud.com/
> 
> For blk-throtl, iops limit has meant the number of bios issued. I'm not

Yes, but it's a litter hard to explain to users the differece between IO
split and IO merge, they just think IO split is the numer of IOs issued
to disk, and IO merge is the number of IOs issued from user.

> necessarily against this change but this is significantly changing what a
> given configuration means. Also, if we're now doing hardware request based
> throttling, maybe we should just move this under rq-qos. That has the
> problem of not supporting bio-based drivers but maybe we can leave
> blk-throtl in deprecation mode and slowly phase it out.

Yes, we discussed this before.

And there is another angle that might convince you for the patch, if the
user workload triggers a lot of IO merge, and iops limit is above the
actual iops on disk, then before this patch, blk-throttle will make IO
merge impossible and resulting in performance degradation.

> 
> Also, can you please make atomic_t conversion a separate patch and describe
> why that's being done?

Of course, the reason is that new helper will decrease the counter
outside lock.

Thanks,
Kuai

> 
> Thanks.
> 


