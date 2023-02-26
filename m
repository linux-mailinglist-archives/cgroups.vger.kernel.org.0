Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009356A33EC
	for <lists+cgroups@lfdr.de>; Sun, 26 Feb 2023 21:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBZUSm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Feb 2023 15:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBZUSl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Feb 2023 15:18:41 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083272D40
        for <cgroups@vger.kernel.org>; Sun, 26 Feb 2023 12:18:39 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id i10so4698991plr.9
        for <cgroups@vger.kernel.org>; Sun, 26 Feb 2023 12:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1677442718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WfnsNCyMqf3Mvd4sjmsuEBgREKEXaVYDac63SQuhJJw=;
        b=xeercA6ozu6jEy9thlUQk8vkH/YTR96f0IViO1Dd3uXuyyLB5NfTBmcFVhKTngRvRA
         2f49+/lo4TiAE5KvzX4q24Kev36C8ojQTFOy3X0UVnx5eQmylfgENGtw+ncKQkT0ZdyE
         6hZjQ446RbHXB1Hmyepo7E4f0NwGfkaEqriZeqSCXeU0TIvRyTeXRyUHyyccIRd8GmgE
         ji0ET9Rqclso4EgTnJTLDQbWOXCxCau7rIEHHSrvWAMjZYSZ1wMH12bhIn50gjdy4SLF
         hUV2keahta5WiQtrQ/UQbOi5RWdMIdZGA4HFHXeVYq1MtXOR8ZKdWS7X3UekCO5qKh3h
         cw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677442718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfnsNCyMqf3Mvd4sjmsuEBgREKEXaVYDac63SQuhJJw=;
        b=EbzLPti93qZifNwWuLx3SJrl64ve2WAqsK0F3v06M5OyEgB2FJqhbJcHUqRJdSbX8+
         OZfjWYEUIQV6RX30BYIGNyQPYMz7bqaZVAecuK+8z384yBf6BZJWQybo+jJIj3klMI3L
         KupL3sLTX4TpSWqthjQzsxMWWXMzir9sDlPFRMwbfpRXFKpNWMSY8zhf3/Ijg9iEx8Zn
         C035MbhRx0MXZpMKVF0WJhhkeLp/AqYFXgZOMcvqcR5ng0Z0+vinAoFHs4PQFnqbX6Cd
         r2v+L4CAhMm7diqOSrAca/wIhoZXhp6E+mUKydIY100OLyLDT8OCJatGpM4P+G2xX3St
         gufw==
X-Gm-Message-State: AO0yUKU2+PffbUsSVhXVRLtiNM00k438DmffyAMJcPmGxHVVULDDKPjD
        LkrwGX8W981L98mGW6evQDXucQ==
X-Google-Smtp-Source: AK7set/NKoCQKyOK9Tjmqh9lx6pUyZta2wpOHwrNO4eLt0JKw7PWAHd/dpA5RW1uXGrfn2GnDji9CQ==
X-Received: by 2002:a17:90a:fd8e:b0:230:dc97:9da2 with SMTP id cx14-20020a17090afd8e00b00230dc979da2mr19308012pjb.1.1677442718485;
        Sun, 26 Feb 2023 12:18:38 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090a088e00b002311c4596f6sm4651060pjc.54.2023.02.26.12.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 12:18:38 -0800 (PST)
Message-ID: <99297e45-e5d7-e582-ed66-4080baf5c884@kernel.dk>
Date:   Sun, 26 Feb 2023 13:18:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] blk-iocost: initialize rqos before accessing it
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Breno Leitao <leitao@debian.org>
Cc:     josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, aherrmann@suse.de,
        linux-kernel@vger.kernel.org, hch@lst.de, leit@fb.com
References: <20230224160714.172884-1-leitao@debian.org>
 <Y/uPFT7w+XQ9l0XE@slm.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y/uPFT7w+XQ9l0XE@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/26/23 9:55 AM, Tejun Heo wrote:
> Hello, Breno.
> 
> On Fri, Feb 24, 2023 at 08:07:14AM -0800, Breno Leitao wrote:
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index ff534e9d92dc..6cced8a76e9c 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
>> @@ -2878,11 +2878,6 @@ static int blk_iocost_init(struct gendisk *disk)
>>  	atomic64_set(&ioc->cur_period, 0);
>>  	atomic_set(&ioc->hweight_gen, 0);
>>  
>> -	spin_lock_irq(&ioc->lock);
>> -	ioc->autop_idx = AUTOP_INVALID;
>> -	ioc_refresh_params(ioc, true);
>> -	spin_unlock_irq(&ioc->lock);
>> -
>>  	/*
>>  	 * rqos must be added before activation to allow ioc_pd_init() to
>>  	 * lookup the ioc from q. This means that the rqos methods may get
>> @@ -2893,6 +2888,11 @@ static int blk_iocost_init(struct gendisk *disk)
>>  	if (ret)
>>  		goto err_free_ioc;
>>  
>> +	spin_lock_irq(&ioc->lock);
>> +	ioc->autop_idx = AUTOP_INVALID;
>> +	ioc_refresh_params(ioc, true);
>> +	spin_unlock_irq(&ioc->lock);
>> +
> 
> I'm a bit worried about registering the rqos before ioc_refresh_params() as
> that initializes all the internal parameters and letting IOs flow through
> without initializing them can lead to subtle issues. Can you please instead
> explicitly pass @q into ioc_refresh_params() (and explain why we need it
> passed explicitly in the function comment)?

Sorry missed this, I'll drop it for now.

-- 
Jens Axboe


