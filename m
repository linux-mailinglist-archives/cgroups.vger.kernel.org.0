Return-Path: <cgroups+bounces-6953-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D798A5B714
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 04:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AD4E7A6B04
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 03:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048031E833F;
	Tue, 11 Mar 2025 03:08:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784321C5799;
	Tue, 11 Mar 2025 03:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741662494; cv=none; b=kcNVauMN4wiylfJImIkbinFn/EbMcAMM5P+KaWxdmwSEZSA1RZYr+iXbpmGfxpwWKpZK2HtrgxoAO5UioTdSakQhqOV5hJdlxEhjVlUo4UjXrGyhbi4kKnNBLneSKQg9lLQ75ErIQfiGg5ULCs9hdsWjjYS5fSog0ReutYjmaFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741662494; c=relaxed/simple;
	bh=SEjKj02X+kopJyS649zkKcEN6zxqJ1THnjbFT3fKYRc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=axI+LdnZfZ8yjW5struJR1FRuyJFNyJ0EnQTgkGCZ0p1jMksTsWQX3m6VNuwYo40QZRrFfAYrjCuRjxMIAKBzWentezNtafn3WmbQPx2du7XXKtMhHVTo2P0UGSoIMNsaOquiS65Sf3hHY2xEud/HmYcnfnq3onlVWiUWH6ljEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZBdwq6Pjxz4f3jcm;
	Tue, 11 Mar 2025 11:07:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3911B1A06D7;
	Tue, 11 Mar 2025 11:08:02 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXe18Qqc9nUbWWGA--.13861S3;
	Tue, 11 Mar 2025 11:08:02 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: support io merge over iops_limit
To: Tejun Heo <tj@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, josef@toxicpanda.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250307090152.4095551-1-yukuai1@huaweicloud.com>
 <Z8sZyElaHQQwKqpB@slm.duckdns.org>
 <5fc124c9-e202-99ca-418d-0f52d027640f@huaweicloud.com>
 <Z85LjhvkCzlqBVZy@fedora> <Z88K5JtR4rhhIFsY@slm.duckdns.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <baba2f82-6c35-8c24-847c-32a002009b63@huaweicloud.com>
Date: Tue, 11 Mar 2025 11:08:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z88K5JtR4rhhIFsY@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe18Qqc9nUbWWGA--.13861S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr43GF13WFyfCw1Dur1xXwb_yoW8Wr4Dpa
	yS93WDKrn7Xr17Kwn7Zws2q3yvy34xWryrCryrtry09rs8JrnxtrWfZr45uFWDurWxuw12
	va42qF1ruw4DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/03/10 23:53, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Mon, Mar 10, 2025 at 10:16:46AM +0800, Ming Lei wrote:
> ...
>>> Yes, but it's a litter hard to explain to users the differece between IO
>>> split and IO merge, they just think IO split is the numer of IOs issued
>>> to disk, and IO merge is the number of IOs issued from user.
>>
>> Here it is really one trouble.
>>
>> a) Sometimes people think IOs wrt. IOPS means that the read/write IO
>> submitted from application, one typical example is `fio`.
>>
>> b) Sometimes people think it is the data observed from `iostat`.
>>
>> In a), io merge/split isn't taken into account, but b) does cover io
>> merge and split.
>>
>> So question is that what is the correct way for user to observe IOPS
>> wrt. iops throttle?
> 
> If we could go back in time, I think the right metric to use is
> hardware-seen IOPS as that's better correlated with the actual capacity
> available (the correlation is very flawed but still better) and the number
> of issued bio's can easily change depending on kernel implementation
> details.

Yes, I agree the right metric is to use b), which cover IO merge and
split(and also filesystem meta and log).

> 
> That said, I'm not sure about changing the behavior now. blk-throtl has
> mostly used the number of bios as long as it has existed and given that
> there can be a signficant difference between the two metrics, I'm not sure
> the change is justified at this point.

If we really concern about the behavior change, can we consider a new
flag that can switch to the old behavior? We'll see if any user will
complain.

Thanks,
Kuai

> 
> Thanks.
> 


