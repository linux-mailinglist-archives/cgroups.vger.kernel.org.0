Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9EC41F945
	for <lists+cgroups@lfdr.de>; Sat,  2 Oct 2021 03:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhJBB4E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Oct 2021 21:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhJBB4E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Oct 2021 21:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633139659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0xoezi4Z/qOe9rLHxMxM8UOrRHkvWYCakknTRmKZYE=;
        b=L4OzxGCMpLspgfnkHdx/rKaUYqyDQLMoFZfS7wTquXSiK7k6Fz6Ttz9Olbgs9JH4+P6rXf
        kCvXVL5/ylpP2WL7YfqfwkzB5GM1m0p7/P38qf1Z7SFe0muyCsbZWQ0DcSVO7W4HXdN1oD
        AXoEC3Af8b6zrzej85x7SsvW/34S1Tk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-K2z04bRONQGE-OgjA6yemg-1; Fri, 01 Oct 2021 21:54:16 -0400
X-MC-Unique: K2z04bRONQGE-OgjA6yemg-1
Received: by mail-qk1-f200.google.com with SMTP id s20-20020a05620a0bd400b0045e893f2ed8so5779986qki.11
        for <cgroups@vger.kernel.org>; Fri, 01 Oct 2021 18:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=O0xoezi4Z/qOe9rLHxMxM8UOrRHkvWYCakknTRmKZYE=;
        b=6Wee5kX65DobtCjTdtcI2CK706VOknYiJO8kXeMjntgTqL0m4b0RBWCQPjQbjl8cV6
         SIUSdLFTqCIi/JwHdiQ3BXpR/5IkvMx0j7fHIh4xaWMDYRJqRX5ei/2siVF5l2ODZTxc
         /MlROjt3Y884/mGB9kOJvRO1UXqW4yEnR/0Ipml3+whO2F/Xl3LmjakmPUlg2Ig8KFw6
         5R30HEAYebar1CHZE+csMPB8Mdtt1sosauACncCgrmbvmG/ANhTE/oa1ADtgSbOpi+lo
         NSRKOySbcKN0wz38q2yQU5Oo9PdxuvJVqL5iWzRmuoFsA2RCY8rmcLfKY9prT/LwZlVB
         xPWg==
X-Gm-Message-State: AOAM531GUpSbehsfCT34TRps28cgdFz2eb0K+r+imY0ATfwNkjCrsEiy
        DkDSxWjbgt3sKUACqv2r9870gNq1eAkrvLhKgtUKkhSpnp8wSl8MLMCa3oWuY1h4oz6U5n5XYEV
        efL/nbagnf7aI/80joA==
X-Received: by 2002:a0c:f094:: with SMTP id g20mr12055307qvk.55.1633139656505;
        Fri, 01 Oct 2021 18:54:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypmZTsFfQss8HzuioAd9a68ABkXlfCgwp7JFvKvJhWuAFJ3fhhyjrAnxkHYQyoxyzrSDDJJA==
X-Received: by 2002:a0c:f094:: with SMTP id g20mr12055294qvk.55.1633139656287;
        Fri, 01 Oct 2021 18:54:16 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id v7sm3966408qkd.41.2021.10.01.18.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 18:54:16 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/3] mm, memcg: Don't put offlined memcg into local stock
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20211001190938.14050-1-longman@redhat.com>
 <20211001190938.14050-2-longman@redhat.com>
 <YVefHLo1+6lgw3aB@carbon.dhcp.thefacebook.com>
Message-ID: <6296d44d-a728-973a-0fc3-b5e30a09f920@redhat.com>
Date:   Fri, 1 Oct 2021 21:54:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVefHLo1+6lgw3aB@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/1/21 7:51 PM, Roman Gushchin wrote:
> On Fri, Oct 01, 2021 at 03:09:36PM -0400, Waiman Long wrote:
>> When freeing a page associated with an offlined memcg, refill_stock()
>> will put it into local stock delaying its demise until another memcg
>> comes in to take its place in the stock. To avoid that, we now check
>> for offlined memcg and go directly in this case to the slowpath for
>> the uncharge via the repurposed cancel_charge() function.
> Hi Waiman!
>
> I'm afraid it can make a cleanup of a dying cgroup slower: for every
> released page we'll potentially traverse the whole cgroup tree and
> decrease atomic page counters.
>
> I'm not sure I understand the benefits we get from this change which
> do justify the slowdown on the cleanup path.

I am debugging a problem where some dying memcgs somehow stay around for 
a long time leading to gradual increase in memory consumption over time. 
I see the per-cpu stock as one of the places where a reference to a 
dying memcg may be present. Anyway, I agree that it may not help much. I 
am going to drop it if you think it is not a good idea.

Cheers,
Longman

