Return-Path: <cgroups+bounces-9399-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B902B350DA
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 03:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16DA3A7A41
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 01:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB4B27EFEE;
	Tue, 26 Aug 2025 01:13:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0F6EEB3;
	Tue, 26 Aug 2025 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756170829; cv=none; b=DGvIchkI0VJUqTK1tMsUOlWPZiX9hIvEAdAH4o06kyDz7vqJQF1N90rh7kWmVGztjk7X7OiDgALF9jqbtQasOdvjiuCivG5ratHjsU4erNKYK4iyfQuF4TI2z7msvVbj6VTjRKIrReZDm2INcQrU+sQzMIu6WMsRl4GtC/GDEGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756170829; c=relaxed/simple;
	bh=uYeSPzsHIsxz+8nyRlCJqM83j7Yjqnd/xdIaUxaSMcc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JeOXIYM9i+wsZ+90zho2h+jYwKBkAjvtry0hjxfKLewWDneeAaFFhLcO9MyKHbB4ct1CZ+y4hzDSVO6Or6GAI6iVfW/6arlKMt/eHJMFNGAB65hL56S3ekUxZamGiKP6oWAsrYR5GccTqqW3tCcD4SNYlScGvohSM+EJKJ99qu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c9qRr4V7gzYQvyJ;
	Tue, 26 Aug 2025 09:13:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2A5F01A0F83;
	Tue, 26 Aug 2025 09:13:43 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCX4o5FCq1oDbE7AQ--.16416S3;
	Tue, 26 Aug 2025 09:13:42 +0800 (CST)
Subject: Re: [PATCH RFC 4/7] md/raid10: convert read/write to use
 bio_submit_split()
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: colyli@kernel.org, hare@suse.de, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 akpm@linux-foundation.org, neil@brown.name, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-5-yukuai1@huaweicloud.com>
 <aKxCJT6ul_WC94-x@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6c6b183a-bce7-b01c-8749-6e0b5a078384@huaweicloud.com>
Date: Tue, 26 Aug 2025 09:13:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aKxCJT6ul_WC94-x@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCX4o5FCq1oDbE7AQ--.16416S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4rGw1fKFyUuF15tw18Xwb_yoW3Jrg_G3
	98tryDGryDZ3Z3tay3Krn3A393CFs8CF1j9F4jqw43Z3s0g397AF48WrZ5X343JF1IvF4S
	g347WFWFyrn29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRJPE-UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/25 18:59, Christoph Hellwig Ð´µÀ:
>>   		allow_barrier(conf);
>> +		bio = bio_submit_split(bio, max_sectors, &conf->bio_split);
>>   		wait_barrier(conf, false);
>> +
>> +		if (!bio) {
>> +			set_bit(R10BIO_Returned, &r10_bio->state);
>> +			goto err_handle;
>> +		}
> 
> The NULL return should only happen for REQ_NOWAIT here, so maybe
> give R10BIO_Returned a more descriptive name?  Also please document
> the flag in the header.

And also atomic write here, if bio has to split due to badblocks here.
The flag is refer to raid1. I can add cocument for both raid1 and raid10
in this case.

> 
> Any maybe yhe code wants a splitting helper instead of open coding
> setting this flag in multiple places?
> .
> 
Yes.

Thanks,
Kuai


