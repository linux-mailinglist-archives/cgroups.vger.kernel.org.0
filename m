Return-Path: <cgroups+bounces-9397-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB4AB350C1
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 03:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0334244F6C
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 01:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643C926CE25;
	Tue, 26 Aug 2025 01:08:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207331BD9F0;
	Tue, 26 Aug 2025 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756170528; cv=none; b=AJEC3FzmMFjciBxm8kPiRGMP1N5VozO0iaxGzoXEp4tbGKqmgJELlHPg6+u5e2tj3sN0gBBN2XNTHnYBh+5uRJk1G4PWv658xpEcISpmw6oK+6UV3Y+KtZxnqUiV7Ot6no9SGmHVA1lsFLeOoKhZvdC9lre1PCfSeYZYtMvSRlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756170528; c=relaxed/simple;
	bh=C2ieMfVSDrwXSZyfJh6OVBPjqfZX0hjWlJVAx3ERtCQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EmhoDpdEWwzbWZTvqMIxuhO1vh/D5/CnHae8Luo5jha7GlaIYkRP9qqB719l6Bj/LBdca5pt5OpQCdLRrsj+q3dgcmqyYuFE4LyWC3smThxnxsplLxJElwEYN9NSQ6g/pQS5P1FkonCQVr9oI6PoGlBEPhHEWgz0rAN96pVTBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9qKw3WS3zKHMmc;
	Tue, 26 Aug 2025 09:08:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 19C0C1A126A;
	Tue, 26 Aug 2025 09:08:36 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCn8IwRCa1oKUY7AQ--.14338S3;
	Tue, 26 Aug 2025 09:08:35 +0800 (CST)
Subject: Re: [PATCH RFC 2/7] md/raid0: convert raid0_handle_discard() to use
 bio_submit_split()
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: colyli@kernel.org, hare@suse.de, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 akpm@linux-foundation.org, neil@brown.name, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-3-yukuai1@huaweicloud.com>
 <aKxBgNQXphpa1BNt@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2984b719-f555-7588-fa2a-1f78d2691e8a@huaweicloud.com>
Date: Tue, 26 Aug 2025 09:08:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aKxBgNQXphpa1BNt@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8IwRCa1oKUY7AQ--.14338S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4xJw1UZr1rur17ArW5ZFb_yoWxKwbEg3
	4SqFWDWrnrG3s7t3ZxtFn8Z395K3s8Kry7XF1UZanrX34kAF9rAFWkJrZrXFn0qr4IyrZ0
	yryYgryfXr1I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRidbbtUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/25 18:57, Christoph Hellwig Ð´µÀ:
> On Mon, Aug 25, 2025 at 05:36:55PM +0800, Yu Kuai wrote:
>> +		bio = bio_submit_split(bio,
>> +				zone->zone_end - bio->bi_iter.bi_sector,
>> +				&mddev->bio_set);
> 
> Do you know why raid0 and linear use mddev->bio_set for splitting
> instead of their own split bio_sets like raid1/10/5?  Is this safe?
> 

I think it's not safe, as mddev->bio_split pool size is just 2, reuse
this pool to split multiple times before submitting will need greate
pool size to make this work.

By the way, do you think it's better to increate disk->bio_split pool
size to 4 and convert all mdraid internal split to use disk->bio_split
directly?

Thanks,
Kuai

> Otherwise this looks nice.
> .
> 


