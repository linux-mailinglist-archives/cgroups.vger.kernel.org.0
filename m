Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A4A682EFF
	for <lists+cgroups@lfdr.de>; Tue, 31 Jan 2023 15:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjAaOQi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 09:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjAaOQi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 09:16:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977BD4A213
        for <cgroups@vger.kernel.org>; Tue, 31 Jan 2023 06:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675174553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlcHXaQO4YJH3Te+lxRyNGl+ktaDXyBM2nbmHql0yqk=;
        b=MIKl9uWbqj9xBP3ys3vf2ljohv9hcP8PLPqIjFEs8fbcUGVzRy1TD0AcEL6C6mM2x9Fu0t
        ADxAnDMhCaj4BYZ7idf5WZAho5fNVghFx1FwxGf6fJ9qHppKNCxPn+LU2oLxwatK0LpIoL
        EPCFvajf65uFZvTtcTDLMuS+CVUC6nY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-152-hc9YSrzJMxal91_dLgcr2A-1; Tue, 31 Jan 2023 09:15:52 -0500
X-MC-Unique: hc9YSrzJMxal91_dLgcr2A-1
Received: by mail-wm1-f72.google.com with SMTP id l5-20020a1ced05000000b003db300f2e1cso5944758wmh.0
        for <cgroups@vger.kernel.org>; Tue, 31 Jan 2023 06:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DlcHXaQO4YJH3Te+lxRyNGl+ktaDXyBM2nbmHql0yqk=;
        b=aWFvuCeQHZsJf5TdRCCNswjYP9Dv4xRpHbQwwahv1xRSlQvTt095B3Q8XYvWs20mY5
         QZTw32RrreI8yP68iJp2+TF9npzX1rzkVV+AJt0pB3t1huhc5oEJYwd/VCg5CnHKJNxC
         dsAcrSadzofjM9AeDlaTkabQB8WCxHLJaHTPVaWYjXFGPY4s9eT9jxmS2353xe/TnwHz
         nbjComMNJMg0EuzcKGE4EXZhjS//nlqNGdADVCVh8Kh/l1fdYc+wMerggQLIZN5TwVLV
         Oa/KzQB2A05AUTJ4yo3Uz6LFYHU61EoktkeedgBskvjJxuGxcabqq45w4XZEk2vQvDLY
         yTgg==
X-Gm-Message-State: AO0yUKXXQrNl5K9nN/2fg32WMHOH5GhUhUDo8KZ3HD4TQqvz3cuosexQ
        WZU/X+NsHg8owPyeJeCVsXjcaYSVxI0n/9/YvRO3FBuSi7onN686NMMCvRiL8r8n4kVNVGHpFjX
        3yluomtNQeqIqPwdU9Q==
X-Received: by 2002:a7b:c847:0:b0:3dc:53da:329b with SMTP id c7-20020a7bc847000000b003dc53da329bmr9316164wml.17.1675174551201;
        Tue, 31 Jan 2023 06:15:51 -0800 (PST)
X-Google-Smtp-Source: AK7set9tJhTCTQiOCCJmRQUEFW0MtCCti9k25veReRKJe5i8NLQaVODOpaIHUBrY+NNTucqf1KkbZg==
X-Received: by 2002:a7b:c847:0:b0:3dc:53da:329b with SMTP id c7-20020a7bc847000000b003dc53da329bmr9316135wml.17.1675174550848;
        Tue, 31 Jan 2023 06:15:50 -0800 (PST)
Received: from ?IPV6:2003:d8:2f0a:ca00:f74f:2017:1617:3ec3? (p200300d82f0aca00f74f201716173ec3.dip0.t-ipconnect.de. [2003:d8:2f0a:ca00:f74f:2017:1617:3ec3])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c379000b003dc49e0132asm10585172wmr.1.2023.01.31.06.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 06:15:50 -0800 (PST)
Message-ID: <1a2417bc-f3ac-3e63-a930-bdefaab2578e@redhat.com>
Date:   Tue, 31 Jan 2023 15:15:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 00/19] mm: Introduce a cgroup to limit the amount of
 locked and pinned memory
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <Y9A7kDjm3ZFAttRR@nvidia.com>
 <6369225e-3522-341b-cd20-d95b1f11ea71@redhat.com>
 <Y9kfn4YX59PIxj7+@nvidia.com>
 <2e78d261-9ae9-d203-446e-eaa3c652ca6e@redhat.com>
 <Y9khYwunmC/xdXT9@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y9khYwunmC/xdXT9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 31.01.23 15:10, Jason Gunthorpe wrote:
> On Tue, Jan 31, 2023 at 03:06:10PM +0100, David Hildenbrand wrote:
>> On 31.01.23 15:03, Jason Gunthorpe wrote:
>>> On Tue, Jan 31, 2023 at 02:57:20PM +0100, David Hildenbrand wrote:
>>>
>>>>> I'm excited by this series, thanks for making it.
>>>>>
>>>>> The pin accounting has been a long standing problem and cgroups will
>>>>> really help!
>>>>
>>>> Indeed. I'm curious how GUP-fast, pinning the same page multiple times, and
>>>> pinning subpages of larger folios are handled :)
>>>
>>> The same as today. The pinning is done based on the result from GUP,
>>> and we charge every returned struct page.
>>>
>>> So duplicates are counted multiple times, folios are ignored.
>>>
>>> Removing duplicate charges would be costly, it would require storage
>>> to keep track of how many times individual pages have been charged to
>>> each cgroup (eg an xarray indexed by PFN of integers in each cgroup).
>>>
>>> It doesn't seem worth the cost, IMHO.
>>>
>>> We've made alot of investment now with iommufd to remove the most
>>> annoying sources of duplicated pins so it is much less of a problem in
>>> the qemu context at least.
>>
>> Wasn't there the discussion regarding using vfio+io_uring+rdma+$whatever on
>> a VM and requiring multiple times the VM size as memlock limit?
> 
> Yes, but iommufd gives us some more options to mitigate this.
> 
> eg it makes some of logical sense to point RDMA at the iommufd page
> table that is already pinned when trying to DMA from guest memory, in
> this case it could ride on the existing pin.

Right, I suspect some issue is that the address space layout for the 
RDMA device might be completely different. But I'm no expert on IOMMUs 
at all :)

I do understand that at least multiple VFIO containers could benefit by 
only pinning once (IIUC that mgiht have been an issue?).

> 
>> Would it be the same now, just that we need multiple times the pin
>> limit?
> 
> Yes

Okay, thanks.


It's all still a big improvement, because I also asked for TDX 
restrictedmem to be accounted somehow as unmovable.

-- 
Thanks,

David / dhildenb

