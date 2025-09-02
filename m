Return-Path: <cgroups+bounces-9628-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E31B40BE1
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 19:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7CD3BDE15
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2926343207;
	Tue,  2 Sep 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kuv6Z+LX"
X-Original-To: cgroups@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99A341ACA;
	Tue,  2 Sep 2025 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833633; cv=none; b=YscCKgrSvEdF8lfvZYuts5QHjlARa+Gzbov55uMTL/RAMv8z3dcbR27P18duguK94MvrAK7+6UyJheqK5g8+5ePnoMTvQrp//AHefPqAa7CN3hECEYADQHMQXdB+EZTfQFu+azIwol5hCO2ghz2dLaNpccmdqw6Uy8kfYOqh0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833633; c=relaxed/simple;
	bh=qFgUF1osgygwZFYC4PkjJp8wVytK5yqc9LO2RtSM53I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvaFI8U63RRrxsuTpDsLo9fBF3pzZIZX5HEdAUYoHp0Va92N6t5GTzFaGtsn+RpV1CAlEaGMnKlVVi3vGZ2saMVtnIh08u47Sxf7F0vsnSTozna1ISDVq6SGVa7RchhIKQmakJHxQTl5aZKeM0x5VB8cq3ZsXhb/BIEcViqEQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kuv6Z+LX; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cGXZ55w6fzlgqTy;
	Tue,  2 Sep 2025 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1756833619; x=1759425620; bh=rcSijRL9UwJ1dqStpHuM/dG4
	cStBkvWYCMMHl+1+Cng=; b=kuv6Z+LXNqYSNDJyvl7uARidzAC19sCPS6KL6G1p
	M8fhGmlrK2Z49g3QBos4UVN2YoLuej2iYl5UsvkDjhx2GXD3pq7hFgNvar5F4UPC
	6qWExCu8zuds5EdbkrKfQ0IzEWiHTwwWZG0wqYH0jy7W0LasbDKCfjWR464ED2dI
	NM7mfNxseG8tqAYTkN8z+yrNxVaAtaZoWzeiIl2nUAuqdNKPrT7GLhri6m+jyTYY
	x6NbsMi+m5aU4PwM65iOWeUEIU/Nw4xJwc0huuHzQJ/VyWuX1Azn7jAjRSEW6/xg
	B/gTSQoxwoNQAXNBIF6prjeukG26kEOXWL5z/Lou8sfyIA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1Ok1mpBqzuq7; Tue,  2 Sep 2025 17:20:19 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cGXYb0pNTzlgqyB;
	Tue,  2 Sep 2025 17:20:02 +0000 (UTC)
Message-ID: <e40b076d-583d-406b-b223-005910a9f46f@acm.org>
Date: Tue, 2 Sep 2025 10:20:01 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 14/15] block: fix disordered IO in the case
 recursive split
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org, kmo@daterainc.com,
 satyat@google.com, ebiggers@google.com, neil@brown.name,
 akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-15-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250901033220.42982-15-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/25 8:32 PM, Yu Kuai wrote:
> -void submit_bio_noacct_nocheck(struct bio *bio)
> +void submit_bio_noacct_nocheck(struct bio *bio, bool split)
>   {
>   	blk_cgroup_bio_start(bio);
>   	blkcg_bio_issue_init(bio);
> @@ -745,12 +745,16 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>   	 * to collect a list of requests submited by a ->submit_bio method while
>   	 * it is active, and then process them after it returned.
>   	 */
> -	if (current->bio_list)
> -		bio_list_add(&current->bio_list[0], bio);
> -	else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO))
> +	if (current->bio_list) {
> +		if (split && !bdev_is_zoned(bio->bi_bdev))
> +			bio_list_add_head(&current->bio_list[0], bio);
> +		else
> +			bio_list_add(&current->bio_list[0], bio);

The above change will cause write errors for zoned block devices. As I
have shown before, also for zoned block devices, if a bio is split
insertion must happen at the head of the list. See e.g.
"Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio 
submission order"
(https://lore.kernel.org/linux-block/a0c89df8-4b33-409c-ba43-f9543fb1b091@acm.org/)

Thanks,

Bart.

