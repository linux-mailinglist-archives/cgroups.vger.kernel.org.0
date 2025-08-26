Return-Path: <cgroups+bounces-9416-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55729B3589E
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 11:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703033AEC4F
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297C5305E1E;
	Tue, 26 Aug 2025 09:14:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3812F8BE7;
	Tue, 26 Aug 2025 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199652; cv=none; b=aNcxS/xuk1QhTZG/cIaibZoDzNoTfhaU4SEyommjMifPa1Qu2rNmhoBfV+FdFHGObuwTA3JhNfwWW+x7akGXTOrGjIH7NQJWeXWPlZhS5arYC7TEyEa6G3zyh2ON+3pCRL6BOqf8kzTIir7Kf7xCXkrYIzrMF/92NzCWUsSmv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199652; c=relaxed/simple;
	bh=/RgWeAmBiaSdiIAMnSe77oaifrRUTgjomq97aknow6Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=slFEDO+tTWo3Whqdf2bbdyuv4aXfPGJcYgFpjpKZPjVcRHcTZIGco2BhbA4V1LXcSwzWZOhPsJr1jU/LahIKWb6pHcWJXyn64XaPWEwZRBYWbrY9KWtt4UaFyncAEdAAGa1uuG0J30a0grfkbfFrHrnQO0UGK9q8nLeVKrZJqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cB2674Q9KzKHNCV;
	Tue, 26 Aug 2025 17:14:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 39EBE1A0ABF;
	Tue, 26 Aug 2025 17:14:07 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY7deq1ocPNhAQ--.26341S3;
	Tue, 26 Aug 2025 17:14:06 +0800 (CST)
Subject: Re: [PATCH RFC 4/7] md/raid10: convert read/write to use
 bio_submit_split()
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: colyli@kernel.org, hare@suse.de, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 akpm@linux-foundation.org, neil@brown.name, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, John Garry <john.g.garry@oracle.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-5-yukuai1@huaweicloud.com>
 <aKxCJT6ul_WC94-x@infradead.org>
 <6c6b183a-bce7-b01c-8749-6e0b5a078384@huaweicloud.com>
 <aK1ocfvjLrIR_Xf2@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <fe595b6a-8653-d1aa-0ae3-af559107ac5d@huaweicloud.com>
Date: Tue, 26 Aug 2025 17:14:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aK1ocfvjLrIR_Xf2@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnMY7deq1ocPNhAQ--.26341S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr47Xw13CrWrZryDKw17Wrg_yoW3ZrXEg3
	yqyrnxGwn2qF13A3yrK3ZxGrZ7AF4a9F15u3WUXF4fZ34rur9rCw47C39av3s5JF4jywsI
	9Fn8WrW5Ar929jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRi66wtUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/26 15:55, Christoph Hellwig Ð´µÀ:
> On Tue, Aug 26, 2025 at 09:13:41AM +0800, Yu Kuai wrote:
>>> The NULL return should only happen for REQ_NOWAIT here, so maybe
>>> give R10BIO_Returned a more descriptive name?  Also please document
>>> the flag in the header.
>>
>> And also atomic write here, if bio has to split due to badblocks here.
>> The flag is refer to raid1. I can add cocument for both raid1 and raid10
>> in this case.
> 
> Umm, that's actually a red flag.  If a device guarantees atomic behavior
> it can't just fail it.  So I think REQ_ATOMIC should be disallowed
> for md raid with bad block tracking.
> 

I agree that do not look good, however, John explained while adding this
that user should retry and fallback without REQ_ATOMIC to make things
work as usual.

Thanks,
Kuai

>>
> 
> .
> 


