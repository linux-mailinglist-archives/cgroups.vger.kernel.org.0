Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAEB52C64A
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 00:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiERWb6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 18:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiERWb6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 18:31:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3679A2873E
        for <cgroups@vger.kernel.org>; Wed, 18 May 2022 15:31:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f10so3430136pjs.3
        for <cgroups@vger.kernel.org>; Wed, 18 May 2022 15:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=thG3qSgnZW+qUMLaaxOPkQALuH6P7RbZ23MHltmMGlE=;
        b=AQkqPj3D0tdfs64sN8mLJd9diiGRGQDbqzoTBkPKxEszGHSW23pLd3DZLq1t7J1BaH
         N9Dc9tw3fZhqvdD7K5lreOPHKrd45AK941vaNu1U6kmB0u/LHeGMLIh4oh/lBCmsuM/R
         nT++BAX42jIVpVd2Cbc0IDNOSqTH4QxG9Nid9TMDGCoIPhTqZxONNkMk58Jq/wMtOPZn
         FR121zdv/+aGTq1DPhIOuVGzvj3hKtit/Buc/d9k5941ePSeMzytuGUKs98ffe6KJ8yI
         O4tYIxZQsAbIvPWbv/KXPvXLRccYsR4v+/q7YR/qrq7ooDJjsiO24fAzsrF642GuT1FQ
         Z4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=thG3qSgnZW+qUMLaaxOPkQALuH6P7RbZ23MHltmMGlE=;
        b=KBosCJHtX/iwVi1DNQ4Z0dH1mg+ovwrdJzYTrqmDVyeweFe+gEO8aby6YTQuxZOAmT
         8LNEM2lKaDjBaBJYYT6fyVHRfAeiJaoGFgHGChJAqnFE2WedHl8ec0uSx1UeHtNte9ai
         PCF20TKO1MapKhAIqed+2gsINO94ITks5PwIDJqL7wBpmW3EtFnVT/KYDAQ0PODf4oP4
         ApRqs59sw3T1nCKajnFCsRmvBcLYNPl1jckjlu0YNQAHPYst7LfZIKlJ6fKc2jsyB2SF
         6o1MBDvQUMYJ+oZKaH6ryWdiZ+YrIssCSOzqgUHagU/uYe6SMfPqyb64bGtxUb7H/B1C
         GK0A==
X-Gm-Message-State: AOAM533AWHxn27dslROxrt0dFQDTC0fxZl89UO3qKGHQ641h/kDdRKq+
        zX7yFAoPyGUYioaPJ0mAeNysog==
X-Google-Smtp-Source: ABdhPJxkM5dIjxffREWV17PoskbyG+tIqaT0rCNzAEMnjsyNnVjB3wANcJQX1M94VA+U2oCPAiV1OQ==
X-Received: by 2002:a17:902:b684:b0:156:80b4:db03 with SMTP id c4-20020a170902b68400b0015680b4db03mr1626285pls.16.1652913115359;
        Wed, 18 May 2022 15:31:55 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h1-20020a62de01000000b005181409a78esm2397294pfg.110.2022.05.18.15.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 15:31:54 -0700 (PDT)
Message-ID: <de6b0f81-67e1-b167-a618-193c2303f149@kernel.dk>
Date:   Wed, 18 May 2022 16:31:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] blk-cgroup: Remove unnecessary rcu_read_lock/unlock()
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Marek Szyprowski <m.szyprowski@samsung.com>, bh1scw@gmail.com,
        tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220516173930.159535-1-bh1scw@gmail.com>
 <CGME20220518192850eucas1p1458c00d4917c5ed39f2c37c9eb30cd46@eucas1p1.samsung.com>
 <46253c48-81cb-0787-20ad-9133afdd9e21@samsung.com>
 <1dad86bb-ae31-5bf8-5810-9e81c68be8ff@kernel.dk>
In-Reply-To: <1dad86bb-ae31-5bf8-5810-9e81c68be8ff@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/18/22 4:29 PM, Jens Axboe wrote:
> On 5/18/22 1:28 PM, Marek Szyprowski wrote:
>> On 16.05.2022 19:39, bh1scw@gmail.com wrote:
>>> From: Fanjun Kong <bh1scw@gmail.com>
>>>
>>> spin_lock_irq/spin_unlock_irq contains preempt_disable/enable().
>>> Which can serve as RCU read-side critical region, so remove
>>> rcu_read_lock/unlock().
>>>
>>> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
>>
>> This patch landed in today's linux next-20220518 as commit 77c570a1ea85 
>> ("blk-cgroup: Remove unnecessary rcu_read_lock/unlock()").
>>
>> Unfortunately it triggers the following warning on ARM64 based Raspberry 
>> Pi 4B board:>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at block/blk-cgroup.c:301 blkg_create+0x398/0x4e0
> 
> Should this use rcu_read_lock_any_held() rather than
> rcu_read_lock_held()?

I think the better alternative is just to delete the WARN_ON(), we have
a:

lockdep_assert_held(&q->queue_lock);

right after it. Since the queue_lock is IRQ disabling, having two checks
serves no purpose. I'll kill the line.

-- 
Jens Axboe

