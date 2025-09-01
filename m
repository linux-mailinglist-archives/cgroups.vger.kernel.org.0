Return-Path: <cgroups+bounces-9542-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7BBB3D9D1
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 08:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9AAC3B6EB3
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 06:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626FD25333F;
	Mon,  1 Sep 2025 06:23:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914F203706;
	Mon,  1 Sep 2025 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707787; cv=none; b=l8y0hJXySk8aBCVynib1HtTocG0HO0nDQFpylF916HN3EgtnBlasDwd4Ufr5/iH5RfI1HnbL7YvZF4V42fuZTdCUJ+YiFH4Q8YSKpE01LIJDzwkotEQAt/ja0n/C63Qg0Nn3Mx23g5JYA6GGqfcQj89WlD/rTgs11bwkPysw4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707787; c=relaxed/simple;
	bh=W2Z++sDS9nUnLNBneF07oL8yJ0fb58gxs1WgCjdwSOE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pM0aw/yF82Utg1IIbemYTxVeJoziDWytX0wOmGK8HI8iwP3Qo9OoaGmIYP5zlW5ys9NXywvrUI81nme2BX9fnT60C5+MgxaeEK5xYlJWwcsjgpzwHkOp5Gl13esUXjB8LbHnGrOyYZIZdEl0C0Jac/EkmJiRlodOC/QTfNdCw0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cFf1y5R3GzYQvlf;
	Mon,  1 Sep 2025 14:23:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3FC261A084B;
	Mon,  1 Sep 2025 14:23:01 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCn8IzCO7VoyUICBA--.57685S3;
	Mon, 01 Sep 2025 14:23:00 +0800 (CST)
Subject: Re: [PATCH RFC v3 01/15] block: cleanup bio_issue
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 hch@infradead.org, colyli@kernel.org, hare@suse.de, tieren@fnnas.com,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 kmo@daterainc.com, satyat@google.com, ebiggers@google.com, neil@brown.name,
 akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-2-yukuai1@huaweicloud.com>
 <7ef5c6dc-5eae-41a7-9403-0d8616668c4b@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2fc7611b-ed38-7006-580d-f18b12c24ae7@huaweicloud.com>
Date: Mon, 1 Sep 2025 14:22:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7ef5c6dc-5eae-41a7-9403-0d8616668c4b@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8IzCO7VoyUICBA--.57685S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw4xXw1rZr4kAw1ktFyrZwb_yoW3XrX_WF
	sYkrZ2yw17X3Wxtwn5tFnxZ3ykGw4fXryUXrWxG3WfG3WkArWktFs5Jrs8Xw4Uu397J34r
	Krn0gwsxJr1IqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
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
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/01 11:43, Damien Le Moal 写道:
> On 9/1/25 12:32 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Now that bio->bi_issue is only used by io-latency to get bio issue time,
>> replace bio_issue with u64 time directly and remove bio_issue to make
>> code cleaner.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> It seems that this patch is completely independent of the series.
> Maybe post it separately not as an RFC ?
> 

Actually, functionaly patch 1,2 must be applied before the following
cleanup, otherwise bio_submit_split_bioset() will add unnecessary
blk_time_get_ns() from blkcg_bio_issue_init() for mdraid, because
iolatency can never be initialized for mdraid, which is bio based.

Thanks,
Kuai


