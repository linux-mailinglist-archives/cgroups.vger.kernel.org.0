Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738683B9F2B
	for <lists+cgroups@lfdr.de>; Fri,  2 Jul 2021 12:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhGBKnE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jul 2021 06:43:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57614 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhGBKnE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Jul 2021 06:43:04 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lzGb0-0000us-Sr
        for cgroups@vger.kernel.org; Fri, 02 Jul 2021 10:40:30 +0000
Received: by mail-ej1-f70.google.com with SMTP id k1-20020a17090666c1b029041c273a883dso3399476ejp.3
        for <cgroups@vger.kernel.org>; Fri, 02 Jul 2021 03:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OR6WjwPbbFIFhDonpm4AQaAwK32w3oXxzxHcnLwLZew=;
        b=p8MuK+AWXuH2GqIMUiSe28bnD8HDQ+MpwiWNyGITftovSGDTJImEwFzEgW4Rd2+bPy
         eBNPt/umEHn/r8k9bmg3m6EuvApMY+Banb3yX4qjxe4bymWnAJv45BRW//BvilMK4M/q
         6zm+bGtOTNYHz7rNum0UsH9u8K6nF9wPmH7tTEQyryCbOPbwb2Is1yYOj6EcOHVcT3v7
         J7wof+E8SNMnUc01Y1eIxwK98jGHZanCxZ1PRL3MNKqpSRzxHvsVRhV4s0CWQxehZZaV
         00xZ3OuUIUF4lDX3pHmU5odWkOP47aRCSRNryGX0vvsqf3XQKXyspH65OtE/blIcGhML
         pvUA==
X-Gm-Message-State: AOAM532yMPlxsfAtKA9t1vuv1mBRSP4PeYNUbrDmGKUimNmlJK6VL3wu
        2Ea72gQCfhNkUieiDLqAn0DnAXBxYlfRdxUPT2s3Ok8AIRpTq/UjDZ+ezmxvHJsjat7guJm9Oim
        0EId2HCjTs2IAEoz+IGhii4MgpN+fE/0AFSY=
X-Received: by 2002:aa7:d413:: with SMTP id z19mr5907609edq.37.1625222430345;
        Fri, 02 Jul 2021 03:40:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0IUtpnbrLKHbt0KupmEL3fvtTCZOa0qAkasNQJvQvbEvFFgPaoPxxOpALo+M8FkUcL26Ikw==
X-Received: by 2002:aa7:d413:: with SMTP id z19mr5907601edq.37.1625222430186;
        Fri, 02 Jul 2021 03:40:30 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id x2sm1142545edv.61.2021.07.02.03.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 03:40:29 -0700 (PDT)
Subject: Re: Process memory accounting (cgroups) accuracy
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <69ffd3a0-2cb7-8baa-17d0-ae45a52595af@canonical.com>
 <YN7XgzB4bE2K9int@dhcp22.suse.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <85b8a4f9-b9e9-a6ca-5d0c-c1ecb8c11ef3@canonical.com>
Date:   Fri, 2 Jul 2021 12:40:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YN7XgzB4bE2K9int@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 02/07/2021 11:08, Michal Hocko wrote:
> On Fri 02-07-21 09:50:11, Krzysztof Kozlowski wrote:
> [...]
>> The questions: How accurate are now the cgroup counters?
> 
> The precision depends on the number of CPUs the workload is running on
> as we do a per-cpu charge caching to optimize the accounting. This is
> MEMCG_CHARGE_BATCH (32) pages currently. You can learn more by checking
> try_charge function (mm/memcontrol.c).

This explains the 32 pages, thanks!

> 
>> I understood they should charge only pages allocated by the process, so
>> why mmap(4 kB) causes max_usage_in_bytes=132 kB?
> 
> Please note that kernel allocations (marked by __GFP_ACCOUNT) are
> accounted as well so this is not only about mmaped memory.
> 
>> Why mmap(4 MB) causes max_usage_in_bytes=4 MB + 34 pages?
> 
> The specific number will depend on the executing - e.g. use up all but 3
> pages from CPU0 batch and have 31 pages on another cpu.
> 
>> What is being accounted there (stack guards?)?
>>
>> Or maybe the entire LTP test checking so carefully memcg limits is useless?
> 
> Well, I haven't really checked details of those tests and their
> objective but aiming for an absolute precision is not really something
> that is very useful IMHO. We are very likely to do optimizations like
> the one mentioned above as the runtime tends to be much more important
> than to-the-page precision.
> 
> Hope this clarifies this a bit.

Yes, thanks!


Best regards,
Krzysztof
