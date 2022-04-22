Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8701550C102
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 23:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiDVVSR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 17:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiDVVSQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 17:18:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970782784DB
        for <cgroups@vger.kernel.org>; Fri, 22 Apr 2022 13:13:47 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x33so16159504lfu.1
        for <cgroups@vger.kernel.org>; Fri, 22 Apr 2022 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=B9p0FoMPwzRixWYKVWEjx56sWOvt3enSLFG849SajN4=;
        b=i1xRqM/AQD7+zHlviCXpKPZZPH+NCey1cLY0YH9FoGiR73p/X6PTLSYWksAgy2XKmM
         ksiRnL7gx+oyU+FNTO7SF58wlUemyiGD7RFZqO8+RoT1p8NIqoBwjr6bNOASrAsJ1UPa
         YEjor8or6jM8yb19a+Jv4wMbSUGBGFj1fsk8zUp+BhH4KT4geUPppJf+2cvULcwK594C
         Ify1KqH7eFxQGny0PELELVDTWBxzSbVh/a4r+fXHN5VQ7XPgWdPBC0veaqgeUbtBqSrI
         TFb6ms3NcP0CuGTa6PRcEB1utLkbyV3aUe24o+fgprm8x3rB5dwmvLiOnq5fX0atxqYg
         xUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=B9p0FoMPwzRixWYKVWEjx56sWOvt3enSLFG849SajN4=;
        b=qLIh9+DuFHmpbKTUPL06PdBpb+4Gh8aLK3LYUYvmf6ArQLOCX7pxKWBD9osM8kPjZL
         NSeOrXU87XHNTepe4i++hFzxa2Zr03QdoA/TNXc9uLBbKZ+x6lCJjaNmV8v0Ff4uAw2U
         56CVY78lm6jKHmi2t/XhSTYzoqPtR4gk6yTdO650YJKd+ZxSLUCi91sMw/tpaOugutdG
         bIriFtlUwxU3Lef0x0XbCH1nGIZsaaqHH5AxHBKL2e2URbKYfJYnVPVUqF4lTD7nUnHq
         YALmMrc6hNK1F/5BLbRQOAFpocr+8k6uYpJ05jSQ3F8p0xsVWkAv7tzxCBWeAQtx5OJ6
         yjrA==
X-Gm-Message-State: AOAM53364TOwI07ISEIuQdEe/5mz/Zts12ftsKDix//sEJGHgZ6Wu9dZ
        skQhUaiLA36nzzlwYvifKGQOPw==
X-Google-Smtp-Source: ABdhPJz/mlC+Za21idKmy1zP+GP4v28p+hBhHjrN0L2KdLEv46MDpRrVxcDXms2OUW+ufgEbuzzWAQ==
X-Received: by 2002:a19:6759:0:b0:46b:b99f:a7ac with SMTP id e25-20020a196759000000b0046bb99fa7acmr4160108lfj.312.1650658143962;
        Fri, 22 Apr 2022 13:09:03 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id a12-20020a19fc0c000000b00471c63ea0fcsm336510lfi.6.2022.04.22.13.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 13:09:03 -0700 (PDT)
Message-ID: <e9cd84f2-d2e9-33a8-d74e-edcf60d35236@openvz.org>
Date:   Fri, 22 Apr 2022 23:09:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH memcg RFC] net: set proper memcg for net_init hooks
 allocations
Content-Language: en-US
From:   Vasily Averin <vvs@openvz.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <46c1c59e-1368-620d-e57a-f35c2c82084d@linux.dev>
 <55605876-d05a-8be3-a6ae-ec26de9ee178@openvz.org>
 <CALvZod47PARcupR4P41p5XJRfCaTqSuy-cfXs7Ky9=-aJQuoFA@mail.gmail.com>
 <964ae72a-0484-67de-8143-a9a2d492a520@openvz.org>
In-Reply-To: <964ae72a-0484-67de-8143-a9a2d492a520@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/22/22 23:01, Vasily Averin wrote:
> On 4/21/22 18:56, Shakeel Butt wrote:
>> On Sat, Apr 16, 2022 at 11:39 PM Vasily Averin <vvs@openvz.org> wrote:
>>> @@ -1147,7 +1148,13 @@ static int __register_pernet_operations(struct list_head *list,
>>>                  * setup_net() and cleanup_net() are not possible.
>>>                  */
>>>                 for_each_net(net) {
>>> +                       struct mem_cgroup *old, *memcg = NULL;
>>> +#ifdef CONFIG_MEMCG
>>> +                       memcg = (net == &init_net) ? root_mem_cgroup : mem_cgroup_from_obj(net);
>>
>> memcg from obj is unstable, so you need a reference on memcg. You can
>> introduce get_mem_cgroup_from_kmem() which works for both
>> MEMCG_DATA_OBJCGS and MEMCG_DATA_KMEM. For uncharged objects (like
>> init_net) it should return NULL.
> 
> Could you please elaborate with more details?
> It seems to me mem_cgroup_from_obj() does everything exactly as you say:
> - for slab objects it returns memcg taken from according slab->memcg_data
> - for ex-slab objects (i.e. page->memcg_data & MEMCG_DATA_OBJCGS)
>     page_memcg_check() returns NULL
> - for kmem objects (i.e. page->memcg_data & MEMCG_DATA_KMEM) 
>     page_memcg_check() returns objcg->memcg
> - in another cases
>     page_memcg_check() returns page->memcg_data,
>     so for uncharged objects like init_net NULL should be returned.
> 
> I can introduce exported get_mem_cgroup_from_kmem(), however it should only
> call mem_cgroup_from_obj(), perhaps under read_rcu_lock/unlock.

I think I finally got your point:
Do you mean I should use css_tryget(&memcg->css) for found memcg,
like get_mem_cgroup_from_mm() does?

Thank you,
	Vasily Averin
