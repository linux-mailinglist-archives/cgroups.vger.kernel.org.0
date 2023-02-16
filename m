Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B391D69929B
	for <lists+cgroups@lfdr.de>; Thu, 16 Feb 2023 12:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjBPLCj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Feb 2023 06:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBPLCh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Feb 2023 06:02:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549571BF5
        for <cgroups@vger.kernel.org>; Thu, 16 Feb 2023 03:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676545307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RT3I0H8bP1HeewuPOTi34AMMwE+sGnWigdoFWwsEuUo=;
        b=FVn8S7/2Wj28Zj0Ty1m6tPXTbIeBn3wHG7D2mh1enYTMRiwyJi2XjzoySHrRVm1Nhpry4l
        GdNVwPDiRlv8FgHi+4sMWpow1yIzs+KVMgUR/1emLCZUbmmBUsempa9hnN7aut/o+D+YmR
        PLayxokyW78umRIko8Gc1ISqeAY8drk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-208-yXRXvvXaNSWlu-ZdRqUb3g-1; Thu, 16 Feb 2023 06:01:46 -0500
X-MC-Unique: yXRXvvXaNSWlu-ZdRqUb3g-1
Received: by mail-wr1-f72.google.com with SMTP id r11-20020a5d498b000000b002c5588d962fso194746wrq.10
        for <cgroups@vger.kernel.org>; Thu, 16 Feb 2023 03:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RT3I0H8bP1HeewuPOTi34AMMwE+sGnWigdoFWwsEuUo=;
        b=llBm5CAHzl/HTfjNFzosuh3ipr5tGTgXQGL+8zHmR+zbBTVS31VlB3EkXgy4qrDU/I
         k1WU4+Pemq6M1aXS/CGKmW3+sJZdZR/r1m3LFtTemffb4UOP7TwMYxqe3oefXb7BU0TF
         plDfEp92aTtB4jjp7LkGUnWwOas3ndsRREtQbtQuxNQ99TWfsWY1vyQpSR9linUjwEPI
         1vXcowolxBpCtjUe/SwTYqP0Awsq3LbCioHcVogI2r6wtyeGcSogN/DyLkQFn+ImWsMk
         fRExfJKcsSL3ENe8d4OkiCNrF+OyZUlVADiTP9QrhcgcvGDwDTePm5Pz50cQwi7LskaW
         hMKg==
X-Gm-Message-State: AO0yUKVZT5XpdDdvdY9sdrgZdVXqdJ7sxv/BiNLz5vjoXfdedsgVndSl
        K9WEV/hv08aeS94FQagjeFoWamm8Ws62UzQUgS9PZl34tKJmNEGXOVoxEDCPRem3xjshgq0Ngbw
        FqanSYSaZdpQRX9WVZA==
X-Received: by 2002:a05:600c:91d:b0:3e2:668:3ed7 with SMTP id m29-20020a05600c091d00b003e206683ed7mr3338190wmp.1.1676545305251;
        Thu, 16 Feb 2023 03:01:45 -0800 (PST)
X-Google-Smtp-Source: AK7set+OFHhrzLoDINOIw5SqQtAninJ8ylAaeCFlYtZeD42IvN4cWNCvjf+X25DXWAkpUabrQ87eYw==
X-Received: by 2002:a05:600c:91d:b0:3e2:668:3ed7 with SMTP id m29-20020a05600c091d00b003e206683ed7mr3338154wmp.1.1676545304870;
        Thu, 16 Feb 2023 03:01:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:bc00:2acb:9e46:1412:686a? (p200300cbc708bc002acb9e461412686a.dip0.t-ipconnect.de. [2003:cb:c708:bc00:2acb:9e46:1412:686a])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003dc4aae4739sm4815014wmc.27.2023.02.16.03.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 03:01:44 -0800 (PST)
Message-ID: <fdd3bd7d-526d-d441-00f1-e8321441174e@redhat.com>
Date:   Thu, 16 Feb 2023 12:01:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 00/19] mm: Introduce a cgroup to limit the amount of
 locked and pinned memory
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 06.02.23 08:47, Alistair Popple wrote:
> Having large amounts of unmovable or unreclaimable memory in a system
> can lead to system instability due to increasing the likelihood of
> encountering out-of-memory conditions. Therefore it is desirable to
> limit the amount of memory users can lock or pin.
> 
>  From userspace such limits can be enforced by setting
> RLIMIT_MEMLOCK. However there is no standard method that drivers and
> other in-kernel users can use to check and enforce this limit.
> 
> This has lead to a large number of inconsistencies in how limits are
> enforced. For example some drivers will use mm->locked_mm while others
> will use mm->pinned_mm or user->locked_mm. It is therefore possible to
> have up to three times RLIMIT_MEMLOCKED pinned.
> 
> Having pinned memory limited per-task also makes it easy for users to
> exceed the limit. For example drivers that pin memory with
> pin_user_pages() it tends to remain pinned after fork. To deal with
> this and other issues this series introduces a cgroup for tracking and
> limiting the number of pages pinned or locked by tasks in the group.
> 
> However the existing behaviour with regards to the rlimit needs to be
> maintained. Therefore the lesser of the two limits is
> enforced. Furthermore having CAP_IPC_LOCK usually bypasses the rlimit,
> but this bypass is not allowed for the cgroup.
> 
> The first part of this series converts existing drivers which
> open-code the use of locked_mm/pinned_mm over to a common interface
> which manages the refcounts of the associated task/mm/user
> structs. This ensures accounting of pages is consistent and makes it
> easier to add charging of the cgroup.
> 
> The second part of the series adds the cgroup controller and converts
> core mm code such as mlock over to charging the cgroup before finally
> introducing some selftests.
> 
> Rather than adding onto an exisiting cgroup controller such as memcg
> we introduce a new controller. This is primarily because we wish to
> limit the total number of pages tasks within a cgroup may pin/lock.
> 
> As I don't have access to systems with all the various devices I
> haven't been able to test all driver changes. Any help there would be
> appreciated.
> 
> Note that this series is based on v6.2-rc5 and
> https://lore.kernel.org/linux-rdma/20230201115540.360353-1-bmt@zurich.ibm.com/
> which makes updating the siw driver easier (thanks Bernard).
> 
> Changes from initial RFC:
> 
>   - Fixes to some driver error handling.
> 
>   - Pages charged with vm_account will always increment mm->pinned_vm
>     and enforce the limit against user->locked_vm or mm->pinned_vm
>     depending on initialisation flags.
> 
>   - Moved vm_account prototypes and struct definitions into a separate header.
> 
>   - Minor updates to commit messages and kernel docs (thanks to Jason,
>     Christoph, Yosry and T.J.).
> 
> Outstanding issues:
> 
>   - David H pointed out that the vm_account naming is potentially
>     confusing and I agree. However I have yet to come up with something
>     better so will rename this in a subsequent version of this series
>     (suggestions welcome).


vm_lockaccount ? vm_pinaccount ?

Less confusing than reusing VM_ACCOUNT which translates to "commit 
accounting".

Might also make sense to rename VM_ACCOUNT to VM_COMMIT or sth like that.

-- 
Thanks,

David / dhildenb

