Return-Path: <cgroups+bounces-3830-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33FA937FAB
	for <lists+cgroups@lfdr.de>; Sat, 20 Jul 2024 09:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9EFBB213F3
	for <lists+cgroups@lfdr.de>; Sat, 20 Jul 2024 07:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C1451004;
	Sat, 20 Jul 2024 07:17:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D451A28B;
	Sat, 20 Jul 2024 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721459850; cv=none; b=UHeRgUOH41zne6peqmB0UcA23jyb00k8nQUQB8o0v1wQfwm+O4+C3xvu/gwEe0jVVRrxSGh+Pt7sCbi06yR+y4VjZW5wceUc4F7pFZRyKN82RgBO/NuddBM8K9yrRVxlmbaNbZ320h+uDYcD5cnEB3irhgC4+V5l6Mn5Y76ZzKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721459850; c=relaxed/simple;
	bh=g33cO39/dECaVib2E4a0T9tP60uC6g8GGtd/8FIiKsw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mQX5jLBb8hf2ykBTp7apFJei6VJqOHhQsBWXT9MoQSt/A7SMGr6BcJWPgQBEEF2i+DYHbzsq2b4xtPjWQzPsluIQoBC46bZSlmXF4ikXuTiE1ZJSISnJ8FGJMwLFwEaKficNhGTULgqMXFV8XVUWnrkF6L9TUNtpMufwX/Cqc34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQyXl2wnRz4f3kvw;
	Sat, 20 Jul 2024 15:17:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BD85E1A07E8;
	Sat, 20 Jul 2024 15:17:24 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgA3GzmCZJtmyCyWAg--.45887S3;
	Sat, 20 Jul 2024 15:17:24 +0800 (CST)
Subject: Re: [PATCH v2 1/3] blk-cgroup: check for pd_(alloc|free)_fn in
 blkcg_activate_policy()
To: Bart Van Assche <bvanassche@acm.org>,
 Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240719023431.3800647-1-yukuai1@huaweicloud.com>
 <20240719023431.3800647-2-yukuai1@huaweicloud.com>
 <Zpn5zvcC4TbDxeKU@infradead.org>
 <ab8f117b-0e0a-4157-b261-471328f6b4e3@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <febb4bcb-5908-382f-db9a-42b62347aa7e@huaweicloud.com>
Date: Sat, 20 Jul 2024 15:17:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ab8f117b-0e0a-4157-b261-471328f6b4e3@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3GzmCZJtmyCyWAg--.45887S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKw43Gw1DGry8CF13Wry7Awb_yoWDCFb_Ww
	s8ury2g3srJw40yayDtr1qvrZ7Kryrtr18Xr15CFW5GFs0gas5Gr15Xwn5Gw1fGw4jvryU
	C390vayayr429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
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

在 2024/07/20 0:25, Bart Van Assche 写道:
> On 7/18/24 10:29 PM, Christoph Hellwig wrote:
>> On Fri, Jul 19, 2024 at 10:34:29AM +0800, Yu Kuai wrote:
>>> +    /*
>>> +     * Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs, and 
>>> policy
>>> +     * without pd_alloc_fn/pd_free_fn can't be activated.
>>> +     */
>>>       if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
>>>           (!pol->pd_alloc_fn ^ !pol->pd_free_fn))
>>>           goto err_unlock;
>>> -- 
>>
>> I know this is existing code, but can you fix up the incorrect
>> indentation while you touch this:
>>
>>       if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
>>           (!pol->pd_alloc_fn ^ !pol->pd_free_fn))
> 
> Using xor (^) for booleans seems weird to me. Is there any preference in
> Linux kernel code whether to use ^ or != to check whether to booleans
> are different?

I don't know, but I feel more comfortable to use '!=' myself.

Thanks,
Kuai

> 
> Thanks,
> 
> Bart.
> 
> .
> 


