Return-Path: <cgroups+bounces-9548-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC22B3DA52
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 08:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB051189AD2A
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 06:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B1925A2C8;
	Mon,  1 Sep 2025 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjsqXfGQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB232243954;
	Mon,  1 Sep 2025 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709662; cv=none; b=HrqO5f+etBwGin+VrUECY9na2s3JALmEUj8XUhCOoDxu0haW3WN2nGILwpmsmCOSUXyWZTES8UVm3vhNytAElFZCSatVyFB7bsa66b+liMuktk/mrS7y3JW9V+EzHQJobVfAg40ws3t2Zmi4MieILc18xJn567FbJLfoVwtA4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709662; c=relaxed/simple;
	bh=sCw2gAOLAJLjgjK+B0A5V+mqXAjIw0cxeSqE/aokZ5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFntVjiixF8vqzLagK5F2t0SAXl1+1MU2RTaqvBjEhmai3TqYt0Y4GliPPI19ryXCcrKOQA3IwHSuEt0/HJrRJpuR1kQTBhk3/CDnxs2o0JH7TLMqXW7H/bMra7WEj/IVovVrscw7SCkMGiv79WvKnNb8VuEwuoBJnZR9duYCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjsqXfGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC35BC4CEF0;
	Mon,  1 Sep 2025 06:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756709660;
	bh=sCw2gAOLAJLjgjK+B0A5V+mqXAjIw0cxeSqE/aokZ5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GjsqXfGQDhaG/yA7JMq60k6ytVuesM49PBQ0QhNsutDyYq4A6Sio3ySORUSdnfh0d
	 3ZLbZUeFR1f1tEX+VTUVX219xULwgf0tudaq8Y95gzPdEVNb413r4+hIfQ64r7dkLR
	 FJV8LkkwROh2DI1jH1ApIfTIyQT4FOlw6Y0cD78Y5+4v2FjMmrAAr1FvJILEFLnwdT
	 ZNRWE1M6iP299mJHeOxrKW/mvfU2+ayLlqaw2PUQtoKQ3chGU0Viy94n42dirtfaup
	 h9LMY/RBV2NyAdfpD0r/x6+2MKfCtkGch68teO8En3/ZlqRtU0gr20vUCRF5D920ir
	 qYYU4HNANTU8g==
Message-ID: <73ce25dd-ce6e-4482-8537-b4f2166bbc47@kernel.org>
Date: Mon, 1 Sep 2025 15:51:23 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 09/10] block: fix disordered IO in the case
 recursive split
To: Yu Kuai <yukuai1@huaweicloud.com>, Yu Kuai <hailan@yukuai.org.cn>,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 neil@brown.name, akpm@linux-foundation.org, hch@infradead.org,
 colyli@kernel.org, hare@suse.de, tieren@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
 <20250828065733.556341-10-yukuai1@huaweicloud.com>
 <23872034-2b36-4a71-91b9-e599976902b6@kernel.org>
 <79aae55c-a2fe-465c-9204-44dce9a80256@yukuai.org.cn>
 <5417dfdd-f558-2d5e-43b1-043c6bd30041@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <5417dfdd-f558-2d5e-43b1-043c6bd30041@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/1/25 11:40 AM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/30 12:28, Yu Kuai 写道:
>>>> @@ -745,12 +745,16 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>>>>        * to collect a list of requests submited by a ->submit_bio method while
>>>>        * it is active, and then process them after it returned.
>>>>        */
>>>> -    if (current->bio_list)
>>>> -        bio_list_add(&current->bio_list[0], bio);
>>>> -    else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO))
>>>> +    if (current->bio_list) {
>>>> +        if (split)
>>>> +            bio_list_add_head(&current->bio_list[0], bio);
>>>> +        else
>>>> +            bio_list_add(&current->bio_list[0], bio);
>>> This really needs a comment clarifying why we do an add at tail instead of
>>> keeping the original order with a add at head. I am also scared that this may
>>> break sequential write ordering for zoned devices.
>>
>> I think add at head is exactly what we do here to keep the orginal order for
>> the case bio split. Other than split, if caller do generate multiple sequential
>> bios, we should keep the order by add at tail.
>>
>> Not sure about zoned devices for now, I'll have a look in details.
> 
> For zoned devices, can we somehow trigger this recursive split? I
> suspect bio disordered will apear in this case but I don't know for
> now and I can't find a way to reporduce it.

dm-linear can be stacked on e.g. dm-crypt, or the reverse. So recursive
splitting may be possible. Though since for DM everything is zone aligned, it
may be hard to find a reproducer. Though dm-crypt will always split BIOs to
BIO_MAX_VECS << PAGE_SECTORS_SHIFT sectors, so it may be possible with very
large BIOs. Would need to try, but really overloaded with other things right now.

> 
> Perhaps I can bypass zoned devices for now, and if we really met the
> recursive split case and there is a problem, we can fix it later:
> 
> if (split && !bdev_is_zoned(bio->bi_bdev))
>     bio_list_add_head()
> 
> Thanks,
> Kuai
> 


-- 
Damien Le Moal
Western Digital Research

