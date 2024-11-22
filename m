Return-Path: <cgroups+bounces-5664-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCB79D5ADE
	for <lists+cgroups@lfdr.de>; Fri, 22 Nov 2024 09:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C9D284A19
	for <lists+cgroups@lfdr.de>; Fri, 22 Nov 2024 08:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A593A176AB6;
	Fri, 22 Nov 2024 08:16:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6F171E6E;
	Fri, 22 Nov 2024 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732263378; cv=none; b=cNRY9vz0fZfh9rOFWIRHGGLIhBhZb0oVc5zEpCB3FdrKjGv3isdFt1OQED1QtEbMZNDmnrWpqZzrdGirj/FbEPUSymU3D429Qg6IX/vvDAnRqBAnyJNC3F4DG8GYT+DV03dBJFmmE1M6iY4oWgMUtPq/GW+ZG86dsTNNr4xSpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732263378; c=relaxed/simple;
	bh=B/umVHltx40EK9tLtMFoyBigt7N5JcyxpAQHcxVBg2Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KcNeJbxvZsHzfEsPEVUtJsDQuz/r0f1hMi9gVhT5NQgVdmZG8HBs26fpLAMfxCgPUYo4fhdkSilyGCp4jcqZDzCtaqT5V16YQxczGstRZudvpSmP1+h6rAp6Vb8y7XyNHbP4bltB8Q6gjS+Msz4411sjH6KlqjP6Z+3TXbvEJ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xvnwl2Q3sz4f3jYB;
	Fri, 22 Nov 2024 16:15:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E05841A07B6;
	Fri, 22 Nov 2024 16:16:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgB3U4fIPUBnhmj+CQ--.60080S3;
	Fri, 22 Nov 2024 16:16:09 +0800 (CST)
Subject: Re: [PATCH] block: iocost: ensure hweight_inuse is at least 1
To: Kunhai Dai <daikunhai@didiglobal.com>, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20241122072609.29429-1-daikunhai@didiglobal.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <29ebfb70-87de-dd75-5ff2-0ca49ec35cf1@huaweicloud.com>
Date: Fri, 22 Nov 2024 16:16:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241122072609.29429-1-daikunhai@didiglobal.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3U4fIPUBnhmj+CQ--.60080S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry3WFWxAw15Zw1kWFykZrb_yoW8Wr4kpr
	y5W3WYyry7GF4I93WrKw1jkw15Zws3WF4Iqrnav3y3Cr4xJ3sIkr4xJr4DGa4rXrs3Xr4I
	qr17tFy8G3y3Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUot
	CzDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/11/22 15:26, Kunhai Dai Ð´µÀ:
> The hweight_inuse calculation in transfer_surpluses() could potentially
> result in a value of 0, which would lead to division by zero errors in
> subsequent calculations that use this value as a divisor.
> 
> Signed-off-by: Kunhai Dai <daikunhai@didiglobal.com>
> ---
>   block/blk-iocost.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 384aa15e8260..65cdb55d30cc 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -1999,9 +1999,10 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
>   		parent = iocg->ancestors[iocg->level - 1];
>   
>   		/* b' = gamma * b_f + b_t' */
> -		iocg->hweight_inuse = DIV64_U64_ROUND_UP(
> -			(u64)gamma * (iocg->hweight_active - iocg->hweight_donating),
> -			WEIGHT_ONE) + iocg->hweight_after_donation;
> +		iocg->hweight_inuse = max_t(u64, 1,
> +			DIV64_U64_ROUND_UP(
> +				(u64)gamma * (iocg->hweight_active - iocg->hweight_donating),
> +				WEIGHT_ONE) + iocg->hweight_after_donation);

I'm confused, how could DIV64_U64_Round_UP() end up less than 1?

#define DIV64_U64_ROUND_UP(ll, d)       \
         ({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })

AFAIK, the only case that could happen is that
iocg->hweight_active - iocg->hweight_donating is 0, then I don't
get it now how cound active iocg donate all the hweight, if this
really happend perhaps the better solution is to avoid such case.

Thanks,
Kuai

>   
>   		/* w' = s' * b' / b'_p */
>   		inuse = DIV64_U64_ROUND_UP(
> 


