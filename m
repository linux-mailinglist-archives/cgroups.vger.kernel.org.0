Return-Path: <cgroups+bounces-3438-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B38C691B57C
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 05:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402C71F2251F
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 03:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6B31CF8A;
	Fri, 28 Jun 2024 03:32:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880A1ED8;
	Fri, 28 Jun 2024 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719545529; cv=none; b=Dk4rt1R7+F/EDM3XBjSB8ksQ3MYfvPEbXGRh5FjoJAtwHX8VOYmzmKIkiM/zU1F+YGRwvXkRDYEqbotBoCLoqKqSxivLOYRh593+alp3xqT+86SueOXqRieSqAFD8wTJk2YyHTi8yyDUtfShlgqq9TDJN2NO2B0O5+QnWrJv6fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719545529; c=relaxed/simple;
	bh=SN5WVXE1VNw6N18wV4A63jungztaD4wzJVYG2Ldjwk0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kom4i1cShHwy5vRfkahDabCKkuj09s4lnwiWu8d/HbP+e4Cq1ncza9AIJgmBToPi08sVnrOSfQMzGZduMSFGAN3qTGFn6kQw8aejqDCRjYfqaSnRu6OQcBnnLO+MpxX9FbhlvIHl40ifwCfERgdZm1jGi9v2gaRXfVBh5CM2Ye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W9LZv050hz4f3kw4;
	Fri, 28 Jun 2024 11:31:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3DA0A1A058E;
	Fri, 28 Jun 2024 11:32:03 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP2 (Coremail) with SMTP id Syh0CgBXwIWxLn5mMIo0Ag--.47596S3;
	Fri, 28 Jun 2024 11:32:03 +0800 (CST)
Subject: Re: [PATCH v2] block: flush all throttled bios when deleting the
 cgroup
To: Li Lingfeng <lilingfeng@huaweicloud.com>, Tejun Heo <tj@kernel.org>
Cc: josef@toxicpanda.com, hch@lst.de, axboe@kernel.dk, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, yukuai1@huaweicloud.com,
 houtao1@huawei.com, yi.zhang@huawei.com, lilingfeng3@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240627142606.3709394-1-lilingfeng@huaweicloud.com>
 <Zn3O47DUoLliwbWm@slm.duckdns.org>
 <c9802312-d9c9-f262-e1d3-9d3343255b6b@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <da861d63-58c6-3ca0-2535-9089993e9e28@huaweicloud.com>
Date: Fri, 28 Jun 2024 11:32:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c9802312-d9c9-f262-e1d3-9d3343255b6b@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXwIWxLn5mMIo0Ag--.47596S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urWUtw4UuF1xGr4ktw1fWFg_yoW8Zr1fpF
	WrZa4UKF1DJr9I9F4Syrs3ZrWFvrWkJrs8AryrG34UJrWYqr1xtFWfKrW09FyYqF93Cw1Y
	vr1Fyr9xuF4jkFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/06/28 10:04, Li Lingfeng 写道:
> 
> 在 2024/6/28 4:43, Tejun Heo 写道:
>> Hello, Li.
>>
>> On Thu, Jun 27, 2024 at 10:26:06PM +0800, Li Lingfeng wrote:
>>> From: Li Lingfeng <lilingfeng3@huawei.com>
>>>
>>> When a process migrates to another cgroup and the original cgroup is 
>>> deleted,
>>> the restrictions of throttled bios cannot be removed. If the 
>>> restrictions
>>> are set too low, it will take a long time to complete these bios.
>>>
>>> Refer to the process of deleting a disk to remove the restrictions and
>>> issue bios when deleting the cgroup.
>>>
>>> This makes difference on the behavior of throttled bios:
>>> Before: the limit of the throttled bios can't be changed and the bios 
>>> will
>>> complete under this limit;
>>> Now: the limit will be canceled and the throttled bios will be flushed
>>> immediately.
>> I'm not necessarily against this but the description doesn't explain why
>> this is better either. Can you please detail why this behavior is better?
> I think it may be more appropriate to remove the limit of bios after the
> cgroup is deleted, rather than let the bios continue to be throttled by a
> non-existent cgroup.

The backgroud is that our test found this, by:

1) setting a low limit in one cgroup;
2) bind a task in the cgroup and issue lots of IO;
3) migrate the task to root cgroup;
4) delete the cgroup;

And oops, unless the disk is deleted, IO will hang for a long time and
there is no way to recover.

The good thing is that after flushing throttled bio while deleting the
cgroup, this "IO hang" can be avoided. However, I'm not sure for this
change, because user may still want the BIO to be throttled. Anyway,
I don't think this will be a problem in reallife.

Thanks,
Kuai

> 
> If the limit is set too low, and the original cgourp has been deleted, we
> now have no way to make the bios complete immediately, but to wait for the
> bios to slowly complete under the limit.
> 
> Thanks.
> 
>>
>> Thanks.
>>
> 
> 
> .
> 


