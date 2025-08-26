Return-Path: <cgroups+bounces-9396-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB0AB3507D
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 02:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8AD53AB88D
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 00:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA182367C9;
	Tue, 26 Aug 2025 00:51:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BDE946A;
	Tue, 26 Aug 2025 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756169504; cv=none; b=a5a9H25dAhMSJe8br3s0eRBekMtH6H2snQjha6e1S8xJAV3nkDihoNMkqvikbrJeNeDGi1xsYVI2/GC6GPY31UvaUij+edlEBi7NKcldnvVa9JsoIyrCDwle/5QkvWdr/uRsclfAaWWVH7+TMk1jxDU5ofzxJwIhA4VYRfoVhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756169504; c=relaxed/simple;
	bh=nYe6WiPQ/iQ3LISjWrcn/D6lzmcAjjnNS8+WP+HYA60=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DN22c/mSQkHNbYr5RptHFx3t+1EJn4tFzR+Sj/6E8eSwZv25J1EeMVbJtaGTjuEbOt13v3CHJpvE24HNkbkb1YwdrvuL6T1zjVzHMhpMLnBx3tkB3UOVzF1snOT4WjdLS7GSs35fdo91qBgfXUkLeWoB5Qn++8b6YlF9dWot+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c9pyN26DPzYQvnm;
	Tue, 26 Aug 2025 08:51:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CD9931A1517;
	Tue, 26 Aug 2025 08:51:38 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3QY4ZBa1o3OI5AQ--.16741S3;
	Tue, 26 Aug 2025 08:51:38 +0800 (CST)
Subject: Re: [PATCH RFC 1/7] block: export helper bio_submit_split()
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: colyli@kernel.org, hare@suse.de, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 akpm@linux-foundation.org, neil@brown.name, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-2-yukuai1@huaweicloud.com>
 <aKxApo1u8j-ZNOaI@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b128ed58-97d8-b3b2-f86f-6f50efd98db8@huaweicloud.com>
Date: Tue, 26 Aug 2025 08:51:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aKxApo1u8j-ZNOaI@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3QY4ZBa1o3OI5AQ--.16741S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4rCrW7JFWfZrW5Kr1rZwb_yoW8GF4Dpr
	4jgw1DJrZ5JFsI9w1qqa4Ut34kKrW5XrW2kryfX3WDJrnrtwnxKF1Igr1ruF1Fkr15C34x
	Jw18ua1rC3s8CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRJPE-UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/25 18:53, Christoph Hellwig Ð´µÀ:
> On Mon, Aug 25, 2025 at 05:36:54PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> No functional changes are intended, some drivers like mdraid will split
>> bio by internal processing, prepare to unify bio split codes.
> 
> Maybe name the exported helper bio_submit_split_bioset and keep
> bio_submit_split() as a wrapper that passes the default split
> bioset to keep the code a bit tidyer in blk-merge.c?
> 
Sure.

>> +struct bio *bio_submit_split(struct bio *bio, int split_sectors,
>> +			     struct bio_set *bs)
>>   {
>> +	struct bio *split;
>> +
>>   	if (unlikely(split_sectors < 0))
>>   		goto error;
>>   
>> -	if (split_sectors) {
>> -		struct bio *split;
>> +	if (!split_sectors)
>> +		return bio;
>>   
>> -		split = bio_split(bio, split_sectors, GFP_NOIO,
>> -				&bio->bi_bdev->bd_disk->bio_split);
>> -		if (IS_ERR(split)) {
>> -			split_sectors = PTR_ERR(split);
>> -			goto error;
>> -		}
>> -		split->bi_opf |= REQ_NOMERGE;
>> -		blkcg_bio_issue_init(split);
>> -		bio_chain(split, bio);
>> -		trace_block_split(split, bio->bi_iter.bi_sector);
>> -		WARN_ON_ONCE(bio_zone_write_plugging(bio));
>> -		submit_bio_noacct(bio);
> 
> Maybe skip the reformatting which makes this much harder to read?
> If you think it is useful it can be done in a separate patch.
> 
Please ignore this, I'll skip this.

Thanks for the review!
Kuai

> .
> 


