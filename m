Return-Path: <cgroups+bounces-9550-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E26B3DB87
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 09:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050423A4DD1
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 07:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276042D7DC0;
	Mon,  1 Sep 2025 07:53:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE2C2475C2;
	Mon,  1 Sep 2025 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713231; cv=none; b=MZHm0YldvrPbqUQtVKeMiV72d9Y5BFn0sgE9E9xAoplVbsEyk5g0gr3XcC4cOFDYdE/xM3jTutEUrP/qCVD3BfP8/bz9ouufb5mt/9zJe+fPXXLSbXZyLtgsXBclhjEysMdbeK0WCMszpdQvKd5Kwozvsy9rz9KSFmRWRXui71s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713231; c=relaxed/simple;
	bh=iJHDLa0VqgYwP1aLAZ2cy4UC21bNmm3bSqcT/6etvmU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qy4swlwP87jgqQPaJSdEH7C7qxDeoSjzXCK1zXZ8tgaCPt6KEMN6vCmBBSlrGHTDBjBvHnVXONd2qK+xL3xW8SCNTPdS842wb3o4mQKeVYuyKLUMPLeXYOA3HMr4NfE93XCYCWsrGe5XVC5r/5TgqQVXvrBtnIeIAYEdWYqWo2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cFh2g3YHCzYQw16;
	Mon,  1 Sep 2025 15:53:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0091A1A1185;
	Mon,  1 Sep 2025 15:53:45 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Y0HUbVoRo0JBA--.61512S3;
	Mon, 01 Sep 2025 15:53:45 +0800 (CST)
Subject: Re: [PATCH RFC v3 03/15] md: fix mssing blktrace bio split events
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
 <20250901033220.42982-4-yukuai1@huaweicloud.com>
 <c7182d12-4b57-4133-9412-7587a98b86bd@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0431e4f2-5e9a-b172-bb65-3d355232e831@huaweicloud.com>
Date: Mon, 1 Sep 2025 15:53:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c7182d12-4b57-4133-9412-7587a98b86bd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8Y0HUbVoRo0JBA--.61512S3
X-Coremail-Antispam: 1UD129KBjvJXoWruw4xXw1DXFyruw4UGw1fCrg_yoW8Jr1kpr
	4xXa15tw1kXw1Fkwn5uF10va4rG3s8XFWfJ34xJr15X3sIg3WfWrWIqwsY9a4jqr4agasr
	WF1DWFZ5Cw1kXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRRBT5DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/01 14:30, Damien Le Moal 写道:
> On 9/1/25 12:32 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> If bio is split by internal chunksize of badblocks, the corresponding
> 
> badblocks ? Unclear.

This is due to raid1/10/5 internal processing, if read/write range
contain badblocks that are recorded in rdev, this bio will be split to
bypass the badblocks range, an example from raid1 is choose_bb_rdev()
will update max_sectors from read_balance(), and caller will split bio
by max_sectors.
> 
>> trace_block_split() is missing, causing blktrace can't catch the split
>> events and make it hader to analyze IO behavior.
> 
> maybe:
> 
> trace_block_split() is missing, resulting in blktrace inability to catch BIO
> split events and making it harder to analyze the BIO sequence.
> 
> would be better.
> 
OK,

>>
>> Fixes: 4b1faf931650 ("block: Kill bio_pair_split()")
> 
> Missing Cc: stable@vger.kernel.org
> 
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> With that,
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> (maybe drop the RFC on this patch series ? Sending a review tag for RFC patches
> is odd...)

Yes, I'll send the next version without RFC now. :)

Thanks,
Kuai

> 


