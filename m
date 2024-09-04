Return-Path: <cgroups+bounces-4683-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E0B96ADEF
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 03:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A829F284F36
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 01:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4B8945A;
	Wed,  4 Sep 2024 01:32:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6232C6FB0;
	Wed,  4 Sep 2024 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413555; cv=none; b=D+/gA2o1/0JDXgmsfC/91izlfElB6Rs624/VEgWzXSpUA6Jk8TdhpYWi0cRbbnF1d+/5wfXoVN3JQCexg8/oCinRmieaHnzVaVvrH/xYRTKJTuHYVc+1GwRGUqg2gIMPmN2KJxXoSTUyPfemPx00YjX6o2NHr+f/XdIWErP284Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413555; c=relaxed/simple;
	bh=c/g2fCijm7vhDTdVi4X08YHtHo3UXqy7FGKcKnLcHM0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GH0vZ2GZN9l+upqR8Bhe9kAOqfMTKd/4W88a9Y3aplPM41YhK/xmigi6I1DHaN5XjVat6xG4260efbKVI310yTqppboFTV+WUbUIMwZSA8rb+otCVrgLXcbBDMohVCzAHLtEAJ8y1iKeUVuDTMpO3eUfJT0zrktJEzZLzaCzIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wz4jT68gZz4f3jdV;
	Wed,  4 Sep 2024 09:32:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D0D7D1A17B1;
	Wed,  4 Sep 2024 09:32:28 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCn28equNdm2sdRAQ--.21474S3;
	Wed, 04 Sep 2024 09:32:28 +0800 (CST)
Subject: Re: [PATCH for-6.12 0/4] block, bfq: fix corner cases related to bfqq
 merging
To: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai1@huaweicloud.com>,
 jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, paolo.valente@unimore.it,
 mauro.andreolini@unimore.it, avanzini.arianna@gmail.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
 <2ee05037-fb4f-4697-958b-46f0ae7d9cdd@kernel.dk>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c2a6d239-aa96-f767-9767-9e9ea929b014@huaweicloud.com>
Date: Wed, 4 Sep 2024 09:32:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2ee05037-fb4f-4697-958b-46f0ae7d9cdd@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn28equNdm2sdRAQ--.21474S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWDuw1DGFyDWrWUKF48Zwb_yoW8JF4xpF
	ZxKa1YkF1kKr9xAa4fC3W7tryft3yxZry3tw13t34xZryUZF13KFn0y3409FySgrn2gwn8
	Ww43JF95WF1kAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2024/09/03 23:51, Jens Axboe 写道:
> On 9/2/24 7:03 AM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Our syzkaller report a UAF problem(details in patch 1), however it can't
>> be reporduced. And this set are some corner cases fix that might be
>> related, and they are found by code review.
>>
>> Yu Kuai (4):
>>    block, bfq: fix possible UAF for bfqq->bic with merge chain
>>    block, bfq: choose the last bfqq from merge chain in
>>      bfq_setup_cooperator()
>>    block, bfq: don't break merge chain in bfq_split_bfqq()
>>    block, bfq: use bfq_reassign_last_bfqq() in bfq_bfqq_move()
>>
>>   block/bfq-cgroup.c  |  7 +------
>>   block/bfq-iosched.c | 17 +++++++++++------
>>   block/bfq-iosched.h |  2 ++
>>   3 files changed, 14 insertions(+), 12 deletions(-)
> 
> BFQ is effectively unmaintained, and has been for quite a while at
> this point. I'll apply these, thanks for looking into it, but I think we
> should move BFQ to an unmaintained state at this point.

Sorry to hear that, we would be willing to take on the responsibility of
maintaining this code, please let me know if there are any specific
guidelines or processes we should follow. We do have customers are using
bfq in downstream kernels, and we are still running lots of test for
bfq.

Thanks,
Kuai


> 


