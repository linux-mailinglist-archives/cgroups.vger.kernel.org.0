Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C859E3E4BAC
	for <lists+cgroups@lfdr.de>; Mon,  9 Aug 2021 20:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhHISAp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Aug 2021 14:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbhHISAm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Aug 2021 14:00:42 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5641EC0619CE
        for <cgroups@vger.kernel.org>; Mon,  9 Aug 2021 10:57:44 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id a7-20020a9d5c870000b029050333abe08aso5137456oti.13
        for <cgroups@vger.kernel.org>; Mon, 09 Aug 2021 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CQFaNzQzJrk6MErWJ+eofTzgW919Cz/LICK5EdRu2O4=;
        b=OCsdWUkSNnhvzgS8bElHmmkjdbZS0zrbwwpAMlwY9cuFhsHQ8eDrMpfxpLsGR3WgKe
         tEU0/IEcBigi6V5cP+32KnLPrhFSzKQ9Zq62XuNJUf3GbAzBnYMfPnYxQT2bqMYv37gH
         jdppPqPVoZhuLhW8EN4nS7nE6aghrJvxPRTaTaepALonKUIde0paOsDMbo/8Y57uZw/Z
         zu/Z0xoSyMKC0lvkuPA/esnGbaon/tFO/jxgLqhLAm5b/E3cuE+nmXUirHzWH7Od59y8
         tDOpM5ut/q+/WvWAWxyP8KPIOl77vqpfjlJhxNe1icfxml6qI1k9LjIuCqnih/ERPyue
         a6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CQFaNzQzJrk6MErWJ+eofTzgW919Cz/LICK5EdRu2O4=;
        b=tHIDcXQyVLRzxGYpdo1ktKow1k8DFH/zrJioajv6raI+ZLTGVXTP3LCyJ3LqOxUFVR
         xDLOLZGwV0ukg2BUvYsA1IH0XteycFbkLUZxbO11g1qgZgjrLNO2o3e687qeCwTdCXx2
         uIwWcDCgtqYhhBtA1Vq2ONgzBre/YgYXLcolUxD2bGCY4fIJ4BondYTF6bFQQddL1gJS
         7FzZDgiYczx2WU9RTWsfp8B66uj1VVK2J5geYq/NdUyw4S8NT17XDJAT6NWMh29AOl5k
         UYOEdZiVkH2rbaM9Uu7Pb6OF4pmWGRxOFyqFXqkxil+MHM9vMxN3wTpMzaM1+faWaNXk
         Ld+w==
X-Gm-Message-State: AOAM531mANgES93q0aWalxPQlhY5Wt1OWpBF+upu3tzdG5F1SvhRRGkq
        fyNqo5YT+MNJXGdm9JyY7+omDg==
X-Google-Smtp-Source: ABdhPJzFgHS0/Ao51EjGoMRZW6DDDktpHc29Tn8/9efV7V4JDaWK1V1d/jyRlPbzikJeCMarsdZZ7g==
X-Received: by 2002:a05:6830:1bf3:: with SMTP id k19mr14626324otb.335.1628531863729;
        Mon, 09 Aug 2021 10:57:43 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e19sm3380805oii.39.2021.08.09.10.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 10:57:43 -0700 (PDT)
Subject: Re: [PATCH 4/5] block: move the bdi from the request_queue to the
 gendisk
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210809141744.1203023-1-hch@lst.de>
 <20210809141744.1203023-5-hch@lst.de> <20210809154728.GH30319@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2c007f99-b8f1-3f84-7575-cb6934704388@kernel.dk>
Date:   Mon, 9 Aug 2021 11:57:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210809154728.GH30319@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/9/21 9:47 AM, Jan Kara wrote:
> On Mon 09-08-21 16:17:43, Christoph Hellwig wrote:
>> The backing device information only makes sense for file system I/O,
>> and thus belongs into the gendisk and not the lower level request_queue
>> structure.  Move it there.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks mostly good. I'm just unsure whether some queue_to_disk() calls are
> safe.
> 
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 2c4ac51e54eb..d2725f94491d 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -525,7 +525,7 @@ void blk_mq_free_request(struct request *rq)
>>  		__blk_mq_dec_active_requests(hctx);
>>  
>>  	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
>> -		laptop_io_completion(q->backing_dev_info);
>> +		laptop_io_completion(queue_to_disk(q)->bdi);
>>
> 
> E.g. cannot this get called for a queue that is without a disk?

Should be fine, as it's checking for passthrough. Maybe famous last
words, but we should not be seeing regular IO before disk is setup.

>> @@ -359,8 +359,8 @@ static void wb_timer_fn(struct blk_stat_callback *cb)
>>  
>>  	status = latency_exceeded(rwb, cb->stat);
>>  
>> -	trace_wbt_timer(rwb->rqos.q->backing_dev_info, status, rqd->scale_step,
>> -			inflight);
>> +	trace_wbt_timer(queue_to_disk(rwb->rqos.q)->bdi, status,
>> +			rqd->scale_step, inflight);
>>  
>>  	/*
>>  	 * If we exceeded the latency target, step down. If we did not,
> 
> Or all these calls - is wbt guaranteed to only be setup for a queue with
> disk?

Same for this one.

-- 
Jens Axboe

