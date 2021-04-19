Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F22D364CFF
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 23:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhDSVZB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 17:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230326AbhDSVY4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Apr 2021 17:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618867465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wmgc0BS4/Q3289dtVfzWyet+zhdbOakz2oUo7zL63L8=;
        b=dhFcRLXV2tXDrv2zLjNLZw4Y1P79aL4shmksee6prNMqIt4sQhOp1zTfDSXPaEdM83mdlD
        /nxW/cpmcyrvKF+hKM3/Bh/4tAAcFfAmxCQIJyYSJ4iD83+qPkzRf9/eQM/vPLECAmpV9L
        2+Rph6tzZFPjVeA19GkhzZ+Z+yrq4o8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-h0xBvUCLNz6cQFBIW8iZFQ-1; Mon, 19 Apr 2021 17:24:24 -0400
X-MC-Unique: h0xBvUCLNz6cQFBIW8iZFQ-1
Received: by mail-qt1-f198.google.com with SMTP id a11-20020ac85b8b0000b02901a69faebe0cso9792592qta.6
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 14:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Wmgc0BS4/Q3289dtVfzWyet+zhdbOakz2oUo7zL63L8=;
        b=TAz3NoMosGk3ZRbdpm3DRjCcrpk8tJcQukcgQf4GiKnX8LFzOKE4Ha6IIUnPDxOJUy
         gMLi5hxokiCztH4ve7BMr4AC//tKO8OMCQbnCIYgdBXzwFQsaw04ktBcNrCwrCCbEUtm
         fHAYblbU/LqD8h/LKmQSxh7wxhkbHl09MdowWll+Sr7XBRolKMOwtMoH0dc5vdplaloe
         eZ7c+/X10Muqj6KoIxSDSN+hrrjtscXpjFsudR9DDCGZmFcwarI2wW6WZnheWCCPu5wK
         NE7Zjl+TEy55MC0xtfPuJl9w7CJaFFbHyF0AoJC/iQXXe20pSc8GnPg+XfolOwJChq6B
         KZjQ==
X-Gm-Message-State: AOAM530jUxtZlRw8Xh45W0tcqUN0/NBoD5Nj8CnkBPzOS/gRr6pXN1E3
        IXncxA0yW5ekkdssVbjEI54xztiRsY9JjbXPZhSNoqZntKhCIeBaBW+DplPEP4nMLG4RWvyChKb
        xgVInuKFxjJ/8uTpQKA==
X-Received: by 2002:a37:8184:: with SMTP id c126mr14086901qkd.353.1618867463396;
        Mon, 19 Apr 2021 14:24:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4FLubBFrEkXj33csDxvgbw+/gusWYsbykbD8A8Hymwn6ZZwBB+TSD06sOCo/kXS0LWCU1pg==
X-Received: by 2002:a37:8184:: with SMTP id c126mr14086886qkd.353.1618867463222;
        Mon, 19 Apr 2021 14:24:23 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id q23sm10293947qtl.25.2021.04.19.14.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 14:24:22 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 1/5] mm/memcg: Move mod_objcg_state() to memcontrol.c
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <llong@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210419000032.5432-1-longman@redhat.com>
 <20210419000032.5432-2-longman@redhat.com> <YH2eT+JCII48hX80@cmpxchg.org>
 <ffb5705e-8629-808d-9d09-0c9c7f509326@redhat.com>
 <140444ea-14e7-b305-910f-f23fafe45488@redhat.com>
 <YH26RrMBOxLaMg4l@cmpxchg.org>
 <b7c8e209-3311-609b-9b61-5602a89a8313@redhat.com>
 <d1c36f26-b958-49e0-ae44-1cf6334fa4c5@redhat.com>
 <YH3yCZn9EeSPKKGY@cmpxchg.org>
Message-ID: <18fc7f4c-d44e-8651-6593-a3e89147e230@redhat.com>
Date:   Mon, 19 Apr 2021 17:24:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YH3yCZn9EeSPKKGY@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/19/21 5:11 PM, Johannes Weiner wrote:
>
>> BTW, have you ever thought of moving the cgroup-v1 specific functions out
>> into a separate memcontrol-v1.c file just like kernel/cgroup/cgroup-v1.c?
>>
>> I thought of that before, but memcontrol.c is a frequently changed file and
>> so a bit hard to do.
> I haven't looked too deeply at it so far, but I think it would make
> sense to try.
>
> There are indeed many of the entry paths from the MM code that are
> shared between cgroup1 and cgroup2, with smaller branches here and
> there to adjust behavior. Those would throw conflicts, but those we
> should probably keep in the main memcontrol.c for readability anyway.
>
> But there is also plenty of code that is exclusively about cgroup1,
> and which actually doesn't change much in a long time. Moving that
> elsewhere shouldn't create difficult conflicts - maybe a few line
> offset warnings or fuzz-- Rafael
>
>
>   in the diff context of unrelated changes:
>
> - the soft limit tree and soft limit reclaim
>
> - the threshold and oom event notification stuff
>
> - the charge moving code
>
> - remaining v1 interface files, as well as their helper functions
>
>  From a quick scan, this adds up to ~2,500 lines of old code with no
> actual dependencies from the common code or from v2, and which could
> be moved out of the way without disrupting ongoing development much.
>
Right.

Currently memcontrol.c has over 7000 lines of code and keep growing. 
That makes it harder to read, navigate and update. If we can cut out 
2000 lines or more from memcontrol.c, it will make it more manageable.

Cheers,
Longman

