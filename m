Return-Path: <cgroups+bounces-6700-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF00A432D2
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 03:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E112E189E502
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 02:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2A9126C10;
	Tue, 25 Feb 2025 02:07:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721862C9D;
	Tue, 25 Feb 2025 02:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449241; cv=none; b=TrNLsgdDc8owy94/aWtz5V7aciZeon0r5F6EPDMBmOR5zRh0Id/Lipd14euagUo6j/CkOdn5x8xNGwd1UFZTK5A6TtMCSMVcz/tQyDeEPT8SNEqShri/1sTs4ZIot2hWRQkztJKcOgqPdsG5iR4DV1D0FzAUWQTPRkc01o3LjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449241; c=relaxed/simple;
	bh=SsLY6n4liZpIkY9P30QAzYdo/JNgpF0lSeiOF6WkJTM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nNkBHkZFh0V3M7wkaw+OoQXh2H3PSjU23CU+R8iTfqtuMOR49XVRA4es1g0ApASMtZIZXs9A+klrZwUhcA+sXQTjO2AwzLacFearOkY8OXOCccgsmg2m/l3HCs4krclCdhZJbdqvw7pgf/wkO+MbmoYZa1o/eFnvR3O0DCMnAKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z21F14H1Rz4f3jMF;
	Tue, 25 Feb 2025 10:06:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C132C1A12BD;
	Tue, 25 Feb 2025 10:07:08 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2DKJb1nZ4xGEw--.61251S3;
	Tue, 25 Feb 2025 10:07:08 +0800 (CST)
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
 <611f02a8-8430-16cf-46e5-e9417982b077@huaweicloud.com>
 <Z70btzRaN83FbTJp@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8473fca2-16ab-b2a6-ede7-d1449aa7d463@huaweicloud.com>
Date: Tue, 25 Feb 2025 10:07:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z70btzRaN83FbTJp@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2DKJb1nZ4xGEw--.61251S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GrykWw4UJF45Jw13Cry5twb_yoWDJFb_Cr
	9FkFs3J3y8Ar4qyF15Gwn0vrZakFWrWryDJr4DXw12qryIyF48Zr4kWryqqF1Dta1ftrs8
	urs8J348Kr9FgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/02/25 9:24, Ming Lei 写道:
>> -       if (!time_elapsed)
>> +       /* don't trim slice until at least 2 slice is used */
>> +       if (time_elapsed < tg->td->throtl_slice * 2)
>>                  return;
> 
> If you just want to fix throtl/001, the above patch might
> work(sometimes, it might not, and timer may expire by 2 jiffies), but it
> is easy to fail other tests, such as, reduce the bps limit a bit, and
> increase BS a bit to make the IO cross exactly two slices.

That's fine, the key point is the following code, above code is
just to make sure there is still at least one slice to trim after
removing the last slice.

+       /* dispite the last slice, trim previous slice */
+       time_elapsed -= tg->td->throtl_slice;

In this case, if one BIO cross 1+ slices, the rate is the same as
expected in the previous slices, we can trim them without any negative
impact.

Thanks,
Kuai

> 
> Also the big question is that how you can make sure that rate is always
> good when the window is >= 2 slice?
> 
> 
> Thanks,
> Ming
> 
> 
> .
> 


