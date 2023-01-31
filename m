Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250D9682ED5
	for <lists+cgroups@lfdr.de>; Tue, 31 Jan 2023 15:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjAaOHP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 09:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjAaOHP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 09:07:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711C24DE17
        for <cgroups@vger.kernel.org>; Tue, 31 Jan 2023 06:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675173975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9t7OLLXi4skInjN2+18+qU6/sB4l5NfmMr6BbX3yli0=;
        b=fQTsmn4zVqyGhJ7TlKr4VUe0XfDtdkHxqHI/vHmx91h41V/Sg2ie1MJTPqmrB26lgG8dv2
        buBQpA+U5IMGwmDeL3cMVywwW3dx/PDpazu2LLDCcM626oEgwOPIjifHaeTiwP0ntxsATI
        0jwM2xCubggFA/yUV0aRjUIriHfrMVo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-300-qaXsn3cbPaOjpM7n1rPP5w-1; Tue, 31 Jan 2023 09:06:14 -0500
X-MC-Unique: qaXsn3cbPaOjpM7n1rPP5w-1
Received: by mail-lj1-f198.google.com with SMTP id o26-20020a2e9b5a000000b0028e4072ac58so3209258ljj.15
        for <cgroups@vger.kernel.org>; Tue, 31 Jan 2023 06:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9t7OLLXi4skInjN2+18+qU6/sB4l5NfmMr6BbX3yli0=;
        b=bujmqj27MdnoR81MGuFyKKrUdyPj8WcY3Tyv4ySI3ur/cj2InWOka66eJjHb2Lz/2a
         u64S8bmEqIfaJKcxsYjq00S/rTvxCCPFtz7MHWHRHRVIxI/7HBnor2eo91ikT9JCQgn7
         UpQ1z8fkytXafuKRlSLBcrlouDMQ8kcoR5C+NY5O1MEn8qkEuhyHhImpZpIHVQrq6Nx0
         3FzNB7bS+IXyduhWIiGcB40IlFCFXmsyf4YBP1CVFnmSaWaDY+7MpF8TOsNKGKCx5dMW
         q7j6MG2jWREsqIelhCXfxN9uXm4CZ6hExO9GdCKKWLhdaEaxUggtSROzZWyiQLNQC/MJ
         J28w==
X-Gm-Message-State: AFqh2kqAUYvELn0kJ5/e/YU1SjfYeOlyHmsu8vnlrnYLIqY/gdGcMSx7
        G/ouIHVOAXFRSq6nTrOHO6o9qIkH68ZktMncqdXfZfzB0XVw1mi0KgL/JHK2sFGGGVy2LxupunV
        92RoBd7aEMO3XGPGiIQ==
X-Received: by 2002:ac2:44a7:0:b0:4b5:580f:2497 with SMTP id c7-20020ac244a7000000b004b5580f2497mr12384940lfm.17.1675173972608;
        Tue, 31 Jan 2023 06:06:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtA0p71nxA5Z0/5H9aAiSX6mfy5IKwcV36g3anoGiNtTFdcpz/YNCVXKyXo4vEMIRkqH8QCdQ==
X-Received: by 2002:ac2:44a7:0:b0:4b5:580f:2497 with SMTP id c7-20020ac244a7000000b004b5580f2497mr12384914lfm.17.1675173972161;
        Tue, 31 Jan 2023 06:06:12 -0800 (PST)
Received: from ?IPV6:2003:d8:2f0a:ca00:f74f:2017:1617:3ec3? (p200300d82f0aca00f74f201716173ec3.dip0.t-ipconnect.de. [2003:d8:2f0a:ca00:f74f:2017:1617:3ec3])
        by smtp.gmail.com with ESMTPSA id m2-20020a056000180200b002bfb5618ee7sm14804139wrh.91.2023.01.31.06.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 06:06:11 -0800 (PST)
Message-ID: <2e78d261-9ae9-d203-446e-eaa3c652ca6e@redhat.com>
Date:   Tue, 31 Jan 2023 15:06:10 +0100
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y9kfn4YX59PIxj7+@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 31.01.23 15:03, Jason Gunthorpe wrote:
> On Tue, Jan 31, 2023 at 02:57:20PM +0100, David Hildenbrand wrote:
> 
>>> I'm excited by this series, thanks for making it.
>>>
>>> The pin accounting has been a long standing problem and cgroups will
>>> really help!
>>
>> Indeed. I'm curious how GUP-fast, pinning the same page multiple times, and
>> pinning subpages of larger folios are handled :)
> 
> The same as today. The pinning is done based on the result from GUP,
> and we charge every returned struct page.
> 
> So duplicates are counted multiple times, folios are ignored.
> 
> Removing duplicate charges would be costly, it would require storage
> to keep track of how many times individual pages have been charged to
> each cgroup (eg an xarray indexed by PFN of integers in each cgroup).
> 
> It doesn't seem worth the cost, IMHO.
> 
> We've made alot of investment now with iommufd to remove the most
> annoying sources of duplicated pins so it is much less of a problem in
> the qemu context at least.

Wasn't there the discussion regarding using vfio+io_uring+rdma+$whatever 
on a VM and requiring multiple times the VM size as memlock limit? Would 
it be the same now, just that we need multiple times the pin limit?

-- 
Thanks,

David / dhildenb

