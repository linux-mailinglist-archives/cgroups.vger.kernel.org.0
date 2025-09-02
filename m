Return-Path: <cgroups+bounces-9624-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B454FB40B97
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 19:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069201B63A0B
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E28342CBB;
	Tue,  2 Sep 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gmUtXwGt"
X-Original-To: cgroups@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99E341AAD;
	Tue,  2 Sep 2025 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832734; cv=none; b=X5JsHuWq6CbGhE+FQXmrf7qKQDAts63r8tXahg46KRjgqkk6hedKYEDK/z1/3fpJlCH/H0mP29Blxh4hhfraJGmQNRi/gIqsdzue9+o2a39ZXpe/wuZfqxnk66ArpzR09s2tJMAmPlUXpsOya7PnR9rcSuiJki6qSICt9MXgAG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832734; c=relaxed/simple;
	bh=xONthrjji6vKRhw6e85pV05NN6DI6/71a10JDK9876U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YM8lazEgzIlCwFV0/2R2IOclQud5JDzCGr/4DbHh5qnZineEVeVpO7s5rP6qn5O8IN9yD5ZtOgoJG7cUYsYU6L9dTTMjmVPUUMNIrrUIkxkppHbEwnEGI6H5ZeempGiowePSQ5bfHb8Hwr7N/aM/ejVDeuaBDJmKpUwNulWiW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gmUtXwGt; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cGXDp6RBhzm1Hbt;
	Tue,  2 Sep 2025 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1756832720; x=1759424721; bh=y184d36ks7oMNdUlaQU1eavx
	UyuvyD+XxgMYqThl0cw=; b=gmUtXwGtKk/48GeTPXfriRtd7cGG7luYUrYlHaaL
	uXLpgh9NIO8yRjxh/Q8FgUOxO4Anacx5HAnNWLRRKkpFK5p/Y06Ir2e6z/3ldH7s
	s3MnNl3Jv0aETRN3O28OMO3XYQ3Ve3pdvJKYOe7ZasM3zYKYp7FmoAbJFaoyfmlh
	UNFTp8He/KE/CZZyKqVH5EDoX/7SvGophmOyLN9RfG9jemqoRHhjSqR0CcArZGjZ
	+TAeMrwF6cFBx2oe1d2GFOCmpt/CT+6NjxiD3gDAF//4fNJuSK1qWbRivEI0PMbQ
	j+riqbTgwowQuBAHsPxaZDYOdhdRX3UU7U2Ll6+M7pNQjg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4QPOqC5sPT8e; Tue,  2 Sep 2025 17:05:20 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cGXDG6pgZzm2PdL;
	Tue,  2 Sep 2025 17:05:02 +0000 (UTC)
Message-ID: <8c960400-ef46-45aa-85d9-d0e1c60b9c0d@acm.org>
Date: Tue, 2 Sep 2025 10:05:01 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 02/15] block: add QUEUE_FLAG_BIO_ISSUE
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org, kmo@daterainc.com,
 satyat@google.com, ebiggers@google.com, neil@brown.name,
 akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250901033220.42982-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/25 8:32 PM, Yu Kuai wrote:
> @@ -372,7 +372,10 @@ static inline void blkg_put(struct blkcg_gq *blkg)
>   
>   static inline void blkcg_bio_issue_init(struct bio *bio)
>   {
> -	bio->issue_time_ns = blk_time_get_ns();
> +	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> +
> +	if (test_bit(QUEUE_FLAG_BIO_ISSUE, &q->queue_flags))
> +		bio->issue_time_ns = blk_time_get_ns();
>   }
>   
>   static inline void blkcg_use_delay(struct blkcg_gq *blkg)
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index 554b191a6892..c9b3bd12c87c 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -767,6 +767,7 @@ static int blk_iolatency_init(struct gendisk *disk)
>   	if (ret)
>   		goto err_qos_del;
>   
> +	blk_queue_flag_set(QUEUE_FLAG_BIO_ISSUE, disk->queue);
>   	timer_setup(&blkiolat->timer, blkiolatency_timer_fn, 0);
>   	INIT_WORK(&blkiolat->enable_work, blkiolatency_enable_work_fn);

Shouldn't QUEUE_FLAG_BIO_ISSUE be cleared when initializing
bio->issue_time_ns is no longer necessary?

Thanks,

Bart.

