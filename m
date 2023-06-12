Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297F772B5C9
	for <lists+cgroups@lfdr.de>; Mon, 12 Jun 2023 05:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjFLDNw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 11 Jun 2023 23:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjFLDNr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 11 Jun 2023 23:13:47 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415DDC4
        for <cgroups@vger.kernel.org>; Sun, 11 Jun 2023 20:13:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2566ed9328eso2419362a91.2
        for <cgroups@vger.kernel.org>; Sun, 11 Jun 2023 20:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686539625; x=1689131625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isvk/E9G1J5c+bipF9hN5zG+Nag5iOn+AJ5rYPC8Si8=;
        b=azPuT2b/FtHoAE095FDR2kcjtJf9/JJ1kwqBOO/u2aEEI3Upa/kUJnA5vvloGhQG7r
         Iq+fbnSJBqkhGGYeCBgoOWvSIujRe8NiJ3FYP1EHlVv7vrfk6oxNh8ZHXDfYsBuKotAy
         +5+Cpmfhr7aM9znnX2mKAAj3dqHQUyVUhQZN1OLISWBXX9O8eJHZ7BIZAYE5CXkzSFC6
         sZvc2fzdRRDexf2en3ztWWHCPpXkv4oj5GFlhfIkzBO3Xp/0g8psQ5l1YC4ye66gAwfH
         ghNd3rtQE07xppYBOMZIBJDrr4kp5uJ8mKIhAXPrM2LZE4peyAM6++6FZZ1os15mN2Ie
         Yedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686539625; x=1689131625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=isvk/E9G1J5c+bipF9hN5zG+Nag5iOn+AJ5rYPC8Si8=;
        b=fWdyL3GhoaeWzmVAALE2YqgciEctjIgduX4lkE8rjIjNBimmFl5RyXri45r6qzYcsz
         b/cDE2s4GxTHxQ82qVXnJulWquVPbJK2mWFEdMOZPmBOXdG8oVzwQjcuotbjarvVDzho
         qCnxs36/28iHRUvFfqdpAjcinDx9uAjgWHXooQKxtK6KuiTdBFPYR+HyATt3HTbBg66i
         7ZRSHzmFMIpLJqQlZr0b3iLzMOJ4Pa90gvpXIn7nbHKZh7oZ0GSBVUzN86OrZ7bnCSZk
         mkWWdSzZilk8T0gVF4H1OA3hIEtmgB4LBC2stEKCQFeH8HvkuvuiaPwlqX5Hq96QeIjZ
         K/SA==
X-Gm-Message-State: AC+VfDyyZmwT1dWF0cB5TAM4OngK8NeaKt2AB6tYoTUCK6W0xiVDffCP
        Z2dbc8xKUfOMtCi1dJvy3myp4A==
X-Google-Smtp-Source: ACHHUZ4+3GyKjWyJiTMgFWqIeax2k+2coVDDCLctZJq+F7ehqqhkVNUKOb3HU/wA9VbOPBh1S6xj+A==
X-Received: by 2002:a17:90b:3b52:b0:259:17ba:e89a with SMTP id ot18-20020a17090b3b5200b0025917bae89amr7216391pjb.34.1686539625689;
        Sun, 11 Jun 2023 20:13:45 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:11b7:189f:bf83:942e:7892? ([240e:694:e21:b::2])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a190e00b00259b729eea9sm6800414pjg.8.2023.06.11.20.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 20:13:45 -0700 (PDT)
Message-ID: <d6d19a61-a584-1839-e6cc-ea63479ca800@bytedance.com>
Date:   Mon, 12 Jun 2023 11:13:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [External] Re: [PATCH] cgroup: rstat: Simplified
 cgroup_base_stat_flush() update last_bstat logic
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230518124142.57644-1-jiahao.os@bytedance.com>
 <f39b9229-e59c-2b1c-7f3f-1aeedfad44dc@bytedance.com>
 <5g73i4yvi4ub4dqrf4dnq5qghkyckoygmgd2st6be3gg7twww2@w6zim6nxpt3b>
 <4d49f7e7-2488-9690-258e-34e617cfef6f@bytedance.com>
 <remnwctqmxleig7ywt6puhxnpmzjo7xm6hlfhpnul46ulfnw7j@36sbuxhuatto>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <remnwctqmxleig7ywt6puhxnpmzjo7xm6hlfhpnul46ulfnw7j@36sbuxhuatto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/5/24 Michal Koutný wrote:
> On Wed, May 24, 2023 at 02:54:10PM +0800, Hao Jia <jiahao.os@bytedance.com> wrote:
>> Yes, so we need @curr to record the bstat value after the sequence fetch is
>> completed.
> 
> No, I still don't see a problem that it solves. If you find incorrect
> data being reported, please explain it more/with an example.
> 
>> Yes, but it may not be obvious.
>> Another reason is that when we complete an update, we snapshot last_bstat as
>> the current bstat, which is better for readers to understand. Arithmetics is
>> somewhat obscure.
> 
> The readability here is subjective. It'd be interesting to have some
> data comparing arithmetics vs copying though.
> 

Sorry for replying you so late. I am using RDTSC on my machine (an Intel 
Xeon(R) Platinum 8260 CPU@2.40GHz machine with 2 NUMA nodes each of 
which has 24 cores with SMT2 enabled, so 96 CPUs in total.) to compare 
the time consumption of arithmetics vs copying. There is almost no 
difference in the time consumption between arithmetics and copying.



> HTH,
> Michal
