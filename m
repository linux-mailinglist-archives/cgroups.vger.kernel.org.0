Return-Path: <cgroups+bounces-9551-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C1AB3DB9C
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 09:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47ED3170C64
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765CF2EDD60;
	Mon,  1 Sep 2025 07:57:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1CA1E47A5;
	Mon,  1 Sep 2025 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713475; cv=none; b=Hl2errw2FhW4koBSclbWnksGhGJagEqUM4kT3iZfWSLuv4f/3RrkdtvOtRILNL+xWYc+DVkVh+OJNkq5jFj/LGatbWkppzz06xZrdtFkGCFxA64NrX1neIhKPjR0EI7/i7eGUpsmMTpQ5x2FhSQaJI0Xp7qZNjaNZAPteI7ayKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713475; c=relaxed/simple;
	bh=PlDNu0vyyfAgzhE6DJYYD36LhPxLYwoNBumGEaacPr0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=E/2sTfO/zZmEeQTQhnUV9NBCwlhkjtbcSxVvNbsNIWmFDS2e/6w/gYuqMY2RCEhftGgiU6IFaL95kc11PmQ8+f81/wx7jy8Ot65jSxlo9IbraRl+M5T9DGhV/rVJ3uZAqXxh7+PQK23iTvbWtGwZcVkUIs7I3ppzDt/Lx7L7ZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cFh7N6285zYQw3M;
	Mon,  1 Sep 2025 15:57:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 54A6C1A0F80;
	Mon,  1 Sep 2025 15:57:51 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY79UbVoC+EJBA--.61424S3;
	Mon, 01 Sep 2025 15:57:50 +0800 (CST)
Subject: Re: [PATCH RFC v3 06/15] md/raid0: convert raid0_handle_discard() to
 use bio_submit_split_bioset()
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
 <20250901033220.42982-7-yukuai1@huaweicloud.com>
 <aa6b1a62-787e-4365-aca5-d03c6b94545f@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f940eac3-bfd9-596d-0349-6d5e9738cdfe@huaweicloud.com>
Date: Mon, 1 Sep 2025 15:57:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aa6b1a62-787e-4365-aca5-d03c6b94545f@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnMY79UbVoC+EJBA--.61424S3
X-Coremail-Antispam: 1UD129KBjvJXoWruw4xXw4rWFyDJr1fAFWUJwb_yoW8Jr4fpa
	yagan3tF4kArnY9wsru3W7ta4kAa1kWF43Xr98GrW7Gr9IvF4FkFW7Kw43Wa45GrZ5Kw40
	gF1UAas5Krn8A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRRbyCPUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/01 14:37, Damien Le Moal 写道:
> On 9/1/25 12:32 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Unify bio split code, and prepare to fix disordered split IO
> 
> Missing the period at the end of the above sentence.
> 
>>
>> Noted commit 319ff40a5427 ("md/raid0: Fix performance regression for large
>> sequential writes") already fix disordered split IO by converting bio to
>> underlying disks before submit_bio_noacct(), with the respect
>> md_submit_bio() already split by sectors, and raid0_make_request() will
>> split at most once for unaligned IO. This is a bit hacky and we'll convert
>> this to solution in general later.
> 
> I do not see how this is relevant to this patch. The patch is a simple
> straightforward conversion of hard-coded BIO split to using
> bio_submit_split_bioset(). So I would just say that.

This is just a note that why bio_split() from read/write is not
converted now, because disordered problem is fixed by above commit
already.

Later patch 15 will convert bio_split() from read/write.
> 
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> With the above addressed, this looks OK to me.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 

Thanks,
Kuai


