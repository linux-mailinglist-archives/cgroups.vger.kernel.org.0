Return-Path: <cgroups+bounces-8959-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48994B16EBE
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 11:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302603AB9E6
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D328FFE3;
	Thu, 31 Jul 2025 09:33:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F59F4FA;
	Thu, 31 Jul 2025 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954412; cv=none; b=eYCYP1JWT5zPpVNsvJ6SC1NyU7ycm5X9vwL4B9/nmvTS4WJ/phrZgXNQDQM2RKsZQQhn9AlZ7UD/nmN09Y9UbvB6biyHkzS5o2vIZ+Ge1UsjgxUMa42rwlKFNjs9ZObiWj4dNgyThpbV3vM+vd5VPXtI+Pn8/9XL36FhteEfnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954412; c=relaxed/simple;
	bh=XfmPVg/mvL3MWChrcAUmO0YKTEzyAfS/xROi6W9TdzQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uK5ft+aj7H0gB02meO2Cj5BuzBYIOw+PKVwJNaWSdbJX+7uJutSdMCj7mQmOGph7EuwXEFsFQqA5NSxFuUqaydlrzg77j6MSFEA8KhzhHg9AJjY+cdAsBsJKrseowC4rzRsNYd4OpkKmq0cDGyGUT2OSiSWnKvPwT8EVfpVeVBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bt3mR4vKwzYQvp9;
	Thu, 31 Jul 2025 17:33:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5C1F51A1728;
	Thu, 31 Jul 2025 17:33:26 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBn4hJkOItoZ4BaCA--.64756S3;
	Thu, 31 Jul 2025 17:33:26 +0800 (CST)
Subject: Re: [PATCH v2 0/5] blk-mq-sched: support request batch dispatching
 for sq elevator
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: dlemoal@kernel.org, hare@suse.de, jack@suse.cz, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <aIsmvj_lxLA6ZaWe@fedora>
 <99e9aa7e-b33c-ce2e-bf0f-0021434690e8@huaweicloud.com>
 <aIs2e3wJpMmCHeZk@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <da726ac2-28be-6fc6-d723-3277b2dd7011@huaweicloud.com>
Date: Thu, 31 Jul 2025 17:33:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aIs2e3wJpMmCHeZk@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBn4hJkOItoZ4BaCA--.64756S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urWrWFW8XFy3Gw17ZFyUAwb_yoW8GFWkpr
	WftFnIkw4DJry2vw1xAa1xX34FkFWfGrZ8CryrKr97Arn8WFy8Jr1fAFsYgFZrWr4kWF4a
	yFW8Xr93Xa48ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/07/31 17:25, Ming Lei 写道:
> On Thu, Jul 31, 2025 at 04:42:10PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/07/31 16:18, Ming Lei 写道:
>>> batch dispatch may hurt io merge performance which is important for
>>> elevator, so please provide test data on real HDD. & SSD., instead of
>>> null_blk only, and it can be perfect if merge sensitive workload
>>> is evaluated.
>>
>> Ok, I'll provide test data on HDD and SSD that I have for now.
>>
>> For the elevator IO merge case, what I have in mind is that we issue
>> small sequential IO one by one with multiple contexts, so that bios
>> won't be merged in plug, and this will require IO issue > IO done, is
>> this case enough?
> 
> Long time ago, I investigated one such issue which is triggered in qemu
> workload, but not sure if I can find it now.
> 
> Also many scsi devices may easily run into queue busy, then scheduler merge
> starts to work, and it may perform worse if you dispatch more in this
> situation.

I think we won't dispatch more in this case, on the one hand we will get
budgets first, to make sure never dispatch more than queue_depth; on the
onther hand, in the case hctx->dispatch_busy is set, we still fallback
to the old case to dispatch one at a time;

So if the IO merge start because many rqs are accumulated inside
elevator and the driver if full, I will expect IO merge will behave the
same with this set. I'll have a test to check.

Thanks,
Kuai

> 
> Thanks,
> Ming
> 
> 
> .
> 


