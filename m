Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F64682E9E
	for <lists+cgroups@lfdr.de>; Tue, 31 Jan 2023 15:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjAaOB1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 09:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbjAaOBU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 09:01:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B2F4B768
        for <cgroups@vger.kernel.org>; Tue, 31 Jan 2023 06:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675173615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sW7aiMox0CriK8aU+HN+jb3vaXSIy6HBnrk2aPiMthI=;
        b=CS7INI6UBU+XrplRHUlP2jUDASerlHTzc221Hr0D5vDtVH/UrqjBsNx17vQ7uHWhx8CwIj
        z2ZKLniN4vn5b9AYOvzk9gVvwzam+z3iPpuzoAXBGvDaqMk2vE+Lg6NHLHtIjAQgQjLG2N
        28sss/vH7tGw6U4T+dpPc+tSQ2ZWO1w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-321-Ad30qPciMiK9DtgxJJGXbg-1; Tue, 31 Jan 2023 09:00:12 -0500
X-MC-Unique: Ad30qPciMiK9DtgxJJGXbg-1
Received: by mail-wm1-f71.google.com with SMTP id o31-20020a05600c511f00b003dc53da325dso4559668wms.8
        for <cgroups@vger.kernel.org>; Tue, 31 Jan 2023 06:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sW7aiMox0CriK8aU+HN+jb3vaXSIy6HBnrk2aPiMthI=;
        b=gtlTUzmGB7HydYXW3yty5kbmSj9yuUqc84aDGplxyAR+idOvPBfQNMdNcOT6SMtLaQ
         hhKWt36eFuqoxsslPdiZY25foe3BAhVOfVzISp+CyNcOdw/64Q6aHBTu9ov1+8U1HS8w
         8BG0jw8U4/nzAv23TG0RfDawu4ymEFCdaKJNuDFsXBacjzdRIhhO5vpm6zF4SQ46oYRZ
         xu+t4zLET9RhPomMhFfonBn6Ejexg/cKZxejSq4dbEMBULNbA9WiX/E2eoCFgpQqytm0
         XgWCkFIHCJW7+nouM6WiYFNiMaC/9GfQ18Ua9wMlxW4QCxLFjbfw849b8TQuMxcp2Ivn
         0UkQ==
X-Gm-Message-State: AO0yUKWqIlFlCwKozpSHwEnmPqb8ZTgbjjI7o65Y9XqPcplGq+mKFh3d
        9cgZEFv4hF6HwW5kZJtmxZ2CACeYmbOgb6xl7iSzRYtBdqrrhSdReZSUNTxRhIxKy8CLtur3Daz
        sQLR5DtBehsBxL0ujiQ==
X-Received: by 2002:a05:600c:3b84:b0:3dc:1031:14c4 with SMTP id n4-20020a05600c3b8400b003dc103114c4mr3752224wms.14.1675173611364;
        Tue, 31 Jan 2023 06:00:11 -0800 (PST)
X-Google-Smtp-Source: AK7set94yYHCQtMUhLwwFZW2Tw85+OPCk5GgL8jU/FYp0b92bP94albwy2k0jgp6h4ZElMMLuWMq1g==
X-Received: by 2002:a05:600c:3b84:b0:3dc:1031:14c4 with SMTP id n4-20020a05600c3b8400b003dc103114c4mr3752186wms.14.1675173611028;
        Tue, 31 Jan 2023 06:00:11 -0800 (PST)
Received: from ?IPV6:2003:d8:2f0a:ca00:f74f:2017:1617:3ec3? (p200300d82f0aca00f74f201716173ec3.dip0.t-ipconnect.de. [2003:d8:2f0a:ca00:f74f:2017:1617:3ec3])
        by smtp.gmail.com with ESMTPSA id e38-20020a05600c4ba600b003dc434900e1sm11512963wmp.34.2023.01.31.06.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 06:00:10 -0800 (PST)
Message-ID: <658eda9c-d716-fcb7-ba0c-b36f646195f1@redhat.com>
Date:   Tue, 31 Jan 2023 15:00:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 01/19] mm: Introduce vm_account
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch, linuxppc-dev@lists.ozlabs.org,
        linux-fpga@vger.kernel.org, linux-rdma@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, io-uring@vger.kernel.org,
        bpf@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kselftest@vger.kernel.org
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <748338ffe4c42d86669923159fe0426808ecb04d.1674538665.git-series.apopple@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <748338ffe4c42d86669923159fe0426808ecb04d.1674538665.git-series.apopple@nvidia.com>
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

On 24.01.23 06:42, Alistair Popple wrote:
> Kernel drivers that pin pages should account these pages against
> either user->locked_vm or mm->pinned_vm and fail the pinning if
> RLIMIT_MEMLOCK is exceeded and CAP_IPC_LOCK isn't held.
> 
> Currently drivers open-code this accounting and use various methods to
> update the atomic variables and check against the limits leading to
> various bugs and inconsistencies. To fix this introduce a standard
> interface for charging pinned and locked memory. As this involves
> taking references on kernel objects such as mm_struct or user_struct
> we introduce a new vm_account struct to hold these references. Several
> helper functions are then introduced to grab references and check
> limits.
> 
> As the way these limits are charged and enforced is visible to
> userspace we need to be careful not to break existing applications by
> charging to different counters. As a result the vm_account functions
> support accounting to different counters as required.
> 
> A future change will extend this to also account against a cgroup for
> pinned pages.

The term "vm_account" is misleading, no? VM_ACCOUNT is for accounting 
towards the commit limit ....

-- 
Thanks,

David / dhildenb

