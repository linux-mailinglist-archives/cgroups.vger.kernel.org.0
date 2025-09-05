Return-Path: <cgroups+bounces-9749-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB226B464E4
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 22:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E2467B9893
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE26F283FFB;
	Fri,  5 Sep 2025 20:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="O++r3LDB"
X-Original-To: cgroups@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF1B2AE8E;
	Fri,  5 Sep 2025 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105178; cv=none; b=AXZp7w/DTUEBUn8koqYsMTgD5oXcdfXNf9ve5TRSI1fVpWUu2WpkjSByn5L5dVOyUnDnpX5B4Fc90WkvOBCpHIUQyjZC+1Xm2mA557+Tzzapw8SK3MGbRC0MLQ0BTVI+mEqdxjq6WRnMzqYVT0C7p4P/WWoa6dmwYlSJYtwZbFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105178; c=relaxed/simple;
	bh=mkFjpmoRUVlSWiPU0PnTTJe+EoGoQpjcE+zwBNDV8DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0y3Sg/LXTemxQoLvRSca1nFeVrMx/baoihAJVYla04lGlS8EcuWHyA4+XrAj0lGVPuer7MHBH+/Xyiftt5yin/pvd2Rd8TIcUjOw1hPe/wUhslbwY3sGR8TpHJXkCcfN/UlYF6tJu41nePM1udGQGrrkngDCwsrDFxxjd9lljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=O++r3LDB; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cJT0165qczlgqV6;
	Fri,  5 Sep 2025 20:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1757105159; x=1759697160; bh=49ZMriIrA3r15RD5QUnMUA9O
	mXjln5FSYBFkAUnhoNs=; b=O++r3LDBO3Seeif1ewknDcCUNIIY6dfFmtHQ5IFL
	DgGsH3tLj6AKnBkc5qCMjPcX4+p3VG9I3ZxzTFhRmpapCB3EWlUP1J78392Mc/0n
	q/93Lu9uK5J2c/kv8iJDsBJp3/EcojTn7oG8WtzvTI2Mz2Ce2WZGsyjczMbe9ZCQ
	6PrgHPbDJjayUeC8lv/XLeF3v5ng2cCJDpkNjDq9VMT0pC1Rpt7MQlQvJosqzkb5
	HOjUFa8Gh1XQK1ELz5rIGVvZiaY3yFQHZG5usWwvKPqQowClXFZDAvGzqr9g9MZF
	6jq6gAH5nDZKAWOlUINfHbN0vUJxIR/N+AN5/m6dyJJF1g==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WnCRaqUE1CcX; Fri,  5 Sep 2025 20:45:59 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cJSzT2WhczlgqVX;
	Fri,  5 Sep 2025 20:45:40 +0000 (UTC)
Message-ID: <e6ed7605-53c6-45f4-9e6a-078353104cef@acm.org>
Date: Fri, 5 Sep 2025 13:45:39 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 05/16] blk-crypto: fix missing blktrace bio
 split events
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org, yukuai3@huawei.com,
 satyat@google.com, ebiggers@google.com, kmo@daterainc.com,
 akpm@linux-foundation.org, neil@brown.name
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-6-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250905070643.2533483-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/25 12:06 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> trace_block_split() is missing, resulting in blktrace inability to catch
> BIO split events and making it harder to analyze the BIO sequence.
> 
> Cc: stable@vger.kernel.org
> Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-crypto-fallback.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index 005c9157ffb3..1f9a4c33d2bd 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -18,6 +18,7 @@
>   #include <linux/module.h>
>   #include <linux/random.h>
>   #include <linux/scatterlist.h>
> +#include <trace/events/block.h>
>   
>   #include "blk-cgroup.h"
>   #include "blk-crypto-internal.h"
> @@ -231,7 +232,9 @@ static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
>   			bio->bi_status = BLK_STS_RESOURCE;
>   			return false;
>   		}
> +
>   		bio_chain(split_bio, bio);
> +		trace_block_split(split_bio, bio->bi_iter.bi_sector);
>   		submit_bio_noacct(bio);
>   		*bio_ptr = split_bio;
>   	}

Ah, here it is. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


