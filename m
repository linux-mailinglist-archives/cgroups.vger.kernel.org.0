Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448934A2B1C
	for <lists+cgroups@lfdr.de>; Sat, 29 Jan 2022 02:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352113AbiA2Bvv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jan 2022 20:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352089AbiA2Bvp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jan 2022 20:51:45 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98522C06173B
        for <cgroups@vger.kernel.org>; Fri, 28 Jan 2022 17:51:45 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id z5so7748394plg.8
        for <cgroups@vger.kernel.org>; Fri, 28 Jan 2022 17:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3HAETZklYMRHOBMF4nZqSUVtbfOCXRHz+7u9x6rdHNk=;
        b=KdotavDnl39ndT7clf/ig6ckZcizJxpNLOerW7ygxH6m8J6LOd+Y69okHEcP764r5P
         dwq2DNviRFubvvn/eCYqrjpbkdg7JtZueRxpFK67Lj9+H5LB8tdiG4y0LosjH89ED0Fa
         /VGdGOuwT121ACmm+0o+QFBukGwqZqpmXP73IYCdPTb2dL/Ay2fCyTGFijwv2cXky5vJ
         6uQTU6iVTYa8ePLqI5Ijjne0AFuNPouLMMXzbJZ/+litaEcSV72lQeOub9t6EGdHmC0e
         3EHwPtb23R2Smae00Eg6//vzR5n2E0Nbm9Xf0cXbEqxhWC8hpRln8XeGaGiq9r858tWC
         vQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3HAETZklYMRHOBMF4nZqSUVtbfOCXRHz+7u9x6rdHNk=;
        b=di/irDlvlWXGeHySlLahQVoVLWbkUHKSoPzx2bOhSvz/HXpkWtR9IXmV1YpLn9tj86
         3IFmoQ5+SWx3teQHkeVm1OVTomKVxaCxxMgHx284bOYWmm/K1qdPV6Lk06hhmN0ijhK5
         dBakNiZtr/6VI8YPsysKu/KZkKsBwCRvSeunFiBgW4+RNz0mjLGp7wUvgu/yZZ54B6AP
         yKyjy1hchjfki4j78l/pr5iry3BpheohYUzFoKhAYZeqV4BBDT2kHqQG6FgLrx2xlX04
         XyIHVtYsUYr1Z0wMtWxWnByo2cWRR1RMbVgB1MciKdToMeNBJWCXuwjixIS4eGoWlygq
         8P3w==
X-Gm-Message-State: AOAM532XKdw8PyVIJ2VDQpTPLmGs4J97ns7pnEQr4vwW+V1pDKujSpR7
        0bAvR44e21uC0S1XFmz63OI/wg==
X-Google-Smtp-Source: ABdhPJxIAjqPrZg0Dh0AgczUDxeDVDYuUMiAhQxGCbZ0io601R9FaHnpIHoXrdalmoKZF9W0y06rMQ==
X-Received: by 2002:a17:903:404b:: with SMTP id n11mr11675278pla.42.1643421104746;
        Fri, 28 Jan 2022 17:51:44 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id 190sm10123225pfg.181.2022.01.28.17.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 17:51:44 -0800 (PST)
Subject: Re: [PATCH v3 0/3] block, bfq: minor cleanup and fix
To:     Yu Kuai <yukuai3@huawei.com>, paolo.valente@linaro.org,
        jack@suse.cz
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220129015924.3958918-1-yukuai3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7cb40388-02e9-712a-6a40-ccabd5605880@kernel.dk>
Date:   Fri, 28 Jan 2022 18:51:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220129015924.3958918-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/28/22 6:59 PM, Yu Kuai wrote:
> Changes in v3:
>  - fix a clerical error in patch 2
> 
> Chagnes in v2:
>  - add comment in patch 2
>  - remove patch 4, since the problem do not exist.
> 
> Yu Kuai (3):
>   block, bfq: cleanup bfq_bfqq_to_bfqg()
>   block, bfq: avoid moving bfqq to it's parent bfqg
>   block, bfq: don't move oom_bfqq
> 
>  block/bfq-cgroup.c  | 16 +++++++++++++++-
>  block/bfq-iosched.c |  4 ++--
>  block/bfq-iosched.h |  1 -
>  block/bfq-wf2q.c    | 15 ---------------
>  4 files changed, 17 insertions(+), 19 deletions(-)

I'm not even looking at this until you tell me that:

a) you've actually compiled this one. which, btw, I can't believe
   needs mentioning, particularly when you had enough time to keep
   pinging about this patchset.

b) it's actually be run. last one was clearly not.

-- 
Jens Axboe

