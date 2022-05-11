Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAFD523B27
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 19:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345326AbiEKRL1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 13:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345382AbiEKRLO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 13:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 396146D84F
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652289071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RYPmGtyjBZOHGfPmY4qtA0SgpPfAbbk9gSbu0qqBm3I=;
        b=bA8bhxMFDHqc2dyDX1/HqqfbW+9KvoBp5MDUA43f5CREItuBe7eMfKXvr2dPLR1lYcXA8V
        tE3aTDTp7/6jenOlLOIBj0SZwuwa+/3mx+Hw1Ee2LoXg1TLO+sIGtIbvYyMjjlTJPXrgQu
        HHBXjK/WLQga7dDoQuEHOZ5IpKVE6Jg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-xFQO_m6PMP-IrbLGhO_jtg-1; Wed, 11 May 2022 13:11:10 -0400
X-MC-Unique: xFQO_m6PMP-IrbLGhO_jtg-1
Received: by mail-wm1-f72.google.com with SMTP id bi5-20020a05600c3d8500b0039489e1d18dso3100356wmb.5
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 10:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=RYPmGtyjBZOHGfPmY4qtA0SgpPfAbbk9gSbu0qqBm3I=;
        b=hfWTm5geLXERcfWB8tov50iskep++zBddsUjUbazFHJao158sQIYi7Lqa51c1n26q6
         qZRdYL/Otui22c8t3DBUfMIxy4WThwjx4d547GL+D91kC+Db3oDC3+klvqohdRDyJ5th
         TdTX32WqUZ6Vl1CKVvgP71m0lYulhfsqgTnK4tRI+GZ8RtOEyNIDQ2eDftSVN3ITNofW
         /j/Br88CBXB409c6JCvq1wkXod7KQc3+8aoe+GdqkvA6vtXHfEgJWAqwQrhZIyb+U6VR
         pU1tOnfBDZzuGHMpMnx0aLJIOarp3l97AR9i125KVu+FjXmpuQR1zrTbT3JIRmoq01Vl
         FvCQ==
X-Gm-Message-State: AOAM530mELaRUeat0r9RHIkoweJvry0rS9ilELz0Gcs7saHxi8nFw4eQ
        phmtg1LQM/joUTHWyGigyrAddT8x6ZZTZSLmPpIyNwdUZVobCC425v8KInZ7lXrOVqeTXW7iAut
        ocqXabo23Ek1tM5d2Rw==
X-Received: by 2002:a05:600c:3490:b0:394:5616:ac78 with SMTP id a16-20020a05600c349000b003945616ac78mr5919708wmq.80.1652289068825;
        Wed, 11 May 2022 10:11:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq5jNCuQAE/2P1K2Xd92ct8LNOTPLsJdA5hRksmYydeW1s0prGqaJ3eDb/l2LfogizjFGjSQ==
X-Received: by 2002:a05:600c:3490:b0:394:5616:ac78 with SMTP id a16-20020a05600c349000b003945616ac78mr5919675wmq.80.1652289068477;
        Wed, 11 May 2022 10:11:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:700:2393:b0f4:ef08:bd51? (p200300cbc70107002393b0f4ef08bd51.dip0.t-ipconnect.de. [2003:cb:c701:700:2393:b0f4:ef08:bd51])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d684e000000b0020c6a524fd5sm2443707wrw.99.2022.05.11.10.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:11:07 -0700 (PDT)
Message-ID: <7a6f8520-a496-e3c3-1fd9-8a30b7a12b14@redhat.com>
Date:   Wed, 11 May 2022 19:11:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/6] Documentation: filesystems: proc: update meminfo
 section
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20220510152847.230957-1-hannes@cmpxchg.org>
 <20220510152847.230957-2-hannes@cmpxchg.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220510152847.230957-2-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10.05.22 17:28, Johannes Weiner wrote:
> Add new entries. Minor corrections and cleanups.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  Documentation/filesystems/proc.rst | 155 ++++++++++++++++++-----------
>  1 file changed, 99 insertions(+), 56 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 061744c436d9..736ed384750c 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -942,56 +942,71 @@ can be substantial.  In many cases there are other means to find out
>  additional memory using subsystem specific interfaces, for instance
>  /proc/net/sockstat for TCP memory allocations.
>  
> -The following is from a 16GB PIII, which has highmem enabled.
> -You may not have all of these fields.
> +Example output. You may not have all of these fields.
>  
>  ::
>  
>      > cat /proc/meminfo
>  
> -    MemTotal:     16344972 kB
> -    MemFree:      13634064 kB
> -    MemAvailable: 14836172 kB
> -    Buffers:          3656 kB
> -    Cached:        1195708 kB
> -    SwapCached:          0 kB
> -    Active:         891636 kB
> -    Inactive:      1077224 kB
> -    HighTotal:    15597528 kB
> -    HighFree:     13629632 kB
> -    LowTotal:       747444 kB
> -    LowFree:          4432 kB
> -    SwapTotal:           0 kB
> -    SwapFree:            0 kB
> -    Dirty:             968 kB
> -    Writeback:           0 kB
> -    AnonPages:      861800 kB
> -    Mapped:         280372 kB
> -    Shmem:             644 kB
> -    KReclaimable:   168048 kB
> -    Slab:           284364 kB
> -    SReclaimable:   159856 kB
> -    SUnreclaim:     124508 kB
> -    PageTables:      24448 kB
> -    NFS_Unstable:        0 kB
> -    Bounce:              0 kB
> -    WritebackTmp:        0 kB
> -    CommitLimit:   7669796 kB
> -    Committed_AS:   100056 kB
> -    VmallocTotal:   112216 kB
> -    VmallocUsed:       428 kB
> -    VmallocChunk:   111088 kB
> -    Percpu:          62080 kB
> -    HardwareCorrupted:   0 kB
> -    AnonHugePages:   49152 kB
> -    ShmemHugePages:      0 kB
> -    ShmemPmdMapped:      0 kB
> +    MemTotal:       32858820 kB
> +    MemFree:        21001236 kB
> +    MemAvailable:   27214312 kB
> +    Buffers:          581092 kB
> +    Cached:          5587612 kB
> +    SwapCached:            0 kB
> +    Active:          3237152 kB
> +    Inactive:        7586256 kB
> +    Active(anon):      94064 kB
> +    Inactive(anon):  4570616 kB
> +    Active(file):    3143088 kB
> +    Inactive(file):  3015640 kB
> +    Unevictable:           0 kB
> +    Mlocked:               0 kB
> +    SwapTotal:             0 kB
> +    SwapFree:              0 kB
> +    Dirty:                12 kB
> +    Writeback:             0 kB
> +    AnonPages:       4654780 kB
> +    Mapped:           266244 kB
> +    Shmem:              9976 kB
> +    KReclaimable:     517708 kB
> +    Slab:             660044 kB
> +    SReclaimable:     517708 kB
> +    SUnreclaim:       142336 kB
> +    KernelStack:       11168 kB
> +    PageTables:        20540 kB
> +    NFS_Unstable:          0 kB
> +    Bounce:                0 kB
> +    WritebackTmp:          0 kB
> +    CommitLimit:    16429408 kB
> +    Committed_AS:    7715148 kB
> +    VmallocTotal:   34359738367 kB
> +    VmallocUsed:       40444 kB
> +    VmallocChunk:          0 kB
> +    Percpu:            29312 kB
> +    HardwareCorrupted:     0 kB
> +    AnonHugePages:   4149248 kB
> +    ShmemHugePages:        0 kB
> +    ShmemPmdMapped:        0 kB
> +    FileHugePages:         0 kB
> +    FilePmdMapped:         0 kB
> +    CmaTotal:              0 kB
> +    CmaFree:               0 kB
> +    HugePages_Total:       0
> +    HugePages_Free:        0
> +    HugePages_Rsvd:        0
> +    HugePages_Surp:        0
> +    Hugepagesize:       2048 kB
> +    Hugetlb:               0 kB
> +    DirectMap4k:      401152 kB
> +    DirectMap2M:    10008576 kB
> +    DirectMap1G:    24117248 kB
>  
>  MemTotal
>                Total usable RAM (i.e. physical RAM minus a few reserved
>                bits and the kernel binary code)
>  MemFree
> -              The sum of LowFree+HighFree
> +              Total free RAM. On highmem systems, the sum of LowFree+HighFree
>  MemAvailable
>                An estimate of how much memory is available for starting new
>                applications, without swapping. Calculated from MemFree,
> @@ -1005,8 +1020,9 @@ Buffers
>                Relatively temporary storage for raw disk blocks
>                shouldn't get tremendously large (20MB or so)
>  Cached
> -              in-memory cache for files read from the disk (the
> -              pagecache).  Doesn't include SwapCached
> +              In-memory cache for files read from the disk (the
> +              pagecache) as well as tmpfs & shmem.
> +              Doesn't include SwapCached.
>  SwapCached
>                Memory that once was swapped out, is swapped back in but
>                still also is in the swapfile (if memory is needed it
> @@ -1018,6 +1034,11 @@ Active
>  Inactive
>                Memory which has been less recently used.  It is more
>                eligible to be reclaimed for other purposes
> +Unevictable
> +              Memory that cannot be reclaimed, such as mlocked pages,
> +              ramfs backing pages, secret memfd pages etc.


A little imprecise, because this only includes memory to be mapped into
user space. For example, all kernel allocations are unevictable but not
accounted here.

Apart from that

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

