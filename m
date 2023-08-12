Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C26877A027
	for <lists+cgroups@lfdr.de>; Sat, 12 Aug 2023 15:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjHLNes (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Aug 2023 09:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjHLNer (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Aug 2023 09:34:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5AE1FDD
        for <cgroups@vger.kernel.org>; Sat, 12 Aug 2023 06:34:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-26890669c8eso645257a91.1
        for <cgroups@vger.kernel.org>; Sat, 12 Aug 2023 06:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691847290; x=1692452090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zu6KYCTe3yYV+vjD7U9dsfBkqKtCevBqbtEfY4AodYs=;
        b=vgi9tpHvmPpSDbFGy6DqAGQh4+ePr41OZKekFkPcbZ+gCbQud6GMIL4bXNWm1rG9UD
         vOv2Odm8719ixKdi4QDjO0Iilweec8ic3O48BuH63MHZNHDPsMmlW6142m4JuVJAFeiq
         GO+KgxkHbV1b4pO+Q8Udb7KWG7npl2uuxIe1ZhQAzVrMWTpqren0W8aKz60b1yW5LIdx
         0tUcUCOK5SGHIo9OL0sxX3AZ8AZnx/TbC4gFvywiXbQgjMAF7mjCAty2DHfjGIq5OYUF
         m6YW4mZh0+eYukwyZsE69r7WeRS/HcKPJH5YLs6kSuqb8FuBiL7ape57rq9XBdc7dkmR
         R1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691847290; x=1692452090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zu6KYCTe3yYV+vjD7U9dsfBkqKtCevBqbtEfY4AodYs=;
        b=aWqt0wlDFk/M+8qBcXaTSKieJWkNJ0c3zZ1EYfjV+YAs98eo8CKFojlX/YarfkFtVI
         Bp95X2vC+TdUkryCLiFpQXcnVwYDi/5kcCNvQZLnf4z2TEiwHFxiwjkMF05kmOy50U8p
         Bm5zQZcIupfZAAbrJiFSSoLjvzHl6LmcqhZgaL4Lnq2XLWjZQIqBREJrkEtNCyk9S8Pl
         Vxh0fbQGfzO0HdihcOFON9vgHwHG/NntTcBL/ElKPYeSfSjQ3S81bDGNDtmdMwEcAfW2
         zsGfm8zlCy9Lt2ayG7+U1qAdjX4/lC8D3JE7/UUvIiy+Pwe1HbyymnThcz4MbIqZTXJ2
         ogsg==
X-Gm-Message-State: AOJu0YyD5t85doiOBdHDzm/8GKmfP+Bb/hLa9EwwNyWa1WEKaae5//JX
        XG6/0fMxhSWXVJfKZgbQbMCZog==
X-Google-Smtp-Source: AGHT+IHmmp8Sl0831SmcXnwg3VeF7EIfBZyskBepfFEfxDeOUFJ50O0HAMnGzKLfNXsbUN1PIXIZhA==
X-Received: by 2002:a17:903:32c7:b0:1b8:17e8:5472 with SMTP id i7-20020a17090332c700b001b817e85472mr5817852plr.1.1691847289948;
        Sat, 12 Aug 2023 06:34:49 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902ea9400b001b9de67285dsm5845999plb.156.2023.08.12.06.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 06:34:49 -0700 (PDT)
Message-ID: <00c3ae48-98c5-470d-ac0e-6096a06b7086@kernel.dk>
Date:   Sat, 12 Aug 2023 07:34:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3] block: remove init_mutex and open-code
 blk_iolatency_try_init
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, tj@kernel.org,
        Li Lingfeng <lilingfeng@huaweicloud.com>
Cc:     josef@toxicpanda.com, mkoutny@suse.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linan122@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230810035111.2236335-1-lilingfeng@huaweicloud.com>
 <169176317573.160467.10047297090390573799.b4-ty@kernel.dk>
 <b93e426e-d9b6-34df-be28-90b715c7a711@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b93e426e-d9b6-34df-be28-90b715c7a711@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/11/23 7:42 PM, Yu Kuai wrote:
> Hi, Jens
> 
> ? 2023/08/11 22:12, Jens Axboe ??:
>>
>> On Thu, 10 Aug 2023 11:51:11 +0800, Li Lingfeng wrote:
>>> Commit a13696b83da4 ("blk-iolatency: Make initialization lazy") adds
>>> a mutex named "init_mutex" in blk_iolatency_try_init for the race
>>> condition of initializing RQ_QOS_LATENCY.
>>> Now a new lock has been add to struct request_queue by commit a13bd91be223
>>> ("block/rq_qos: protect rq_qos apis with a new lock"). And it has been
>>> held in blkg_conf_open_bdev before calling blk_iolatency_init.
>>> So it's not necessary to keep init_mutex in blk_iolatency_try_init, just
>>> remove it.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] block: remove init_mutex and open-code blk_iolatency_try_init
>>        commit: 4eb44d10766ac0fae5973998fd2a0103df1d3fe1
> 
> This version has a minor problem that pss in mutex for
> lockdep_assert_held() is not a pointer:
> 
>> lockdep_assert_held(ctx.bdev->bd_queue->rq_qos_mutex);
> 
> should be:
> lockdep_assert_held(&ctx.bdev->bd_queue->rq_qos_mutex);

Yes, looked like that patch didn't get compiled... Shame.

> Perhaps can you drop this patch for now, and Lingfeng can send a v4?

I did fix that up 2 days ago myself.

-- 
Jens Axboe

