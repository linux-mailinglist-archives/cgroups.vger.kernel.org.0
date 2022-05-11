Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF00523CE4
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 20:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346510AbiEKSva (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 14:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343820AbiEKSv3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 14:51:29 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F621E2532
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 11:51:27 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 185so2976792qke.7
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 11:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2M4Jyxc4ZhLMOpYVi4rOXmZMkxhNrB3SJA5cGP33wsw=;
        b=hIi47nK8NjD/G3LuJK2PAPk/bVzllp+fLuCexjLy4BH8rKTDb3JBxsVc6CiFPUlPYm
         RpZNxJsX1BtpycEgYFrmcIy0UVGH5dv8mOjYtvNKe9RPUDQdoiwdsJmIn2ep3UNfURjW
         E2QbN4oSEUFmANl6EfG54igt6AaiRFeW547fvOMgwfaYYttkG4s/xM7BvmDZEE+FR999
         PoZRqh0zXwAngexKVvPpKCphvB7Q5/CfbAIBTAJCimizzjDj+kdaFCYVEb9w5vWoA/4k
         vKDJcYdGNKq2txfo+LtyBaJ6k1DmnFn9pS7PeY4cEyEnaECtZ2cR9mfB3WB/92BT2wi0
         WG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2M4Jyxc4ZhLMOpYVi4rOXmZMkxhNrB3SJA5cGP33wsw=;
        b=UZn/1tRsFSnvdXDWlj7w+kD3WiF3uRi+aOqkjOpHcYZAFz2hHH9V+CmOMnj54j1ye6
         xUrRd+FdRamiGtKRqO5n/yQyrMDnmbi5FLlIlqTTUHfdIjmcKIZnNpiZsCtyGYRawTS6
         2TkL2I0emWONTcMsh4ICZLaZL7Dwcv45+vBb2taKtdGUXBBTH350q/7Fq/VgfBlMvWCQ
         fSrWxqNY9TTUdhS3eWVlqplIdvmuQOXVpjI9PddDVoemIRlxcBOptzlmXwWzQaWtO2zk
         dniw6oQzQ9QZUVcT0zes4Nvnpam7jv79tp2C7msS9PetPlXU924gxRXILo6On3TnR8u8
         v4xg==
X-Gm-Message-State: AOAM532wOzq9PuVbm1Xs1NBqTsxm4xpxn46vP57KSAIY0V36GoyTUIp9
        B7Z9YnGk+DPdSyyzQDuxV2cdqA==
X-Google-Smtp-Source: ABdhPJy8hfHIAyaLgeAGd1noKkDIygPLAvRQwGVbLxOKICyyA8xx5wGKdjyIYE/SOuJ7JDSHQk/GRQ==
X-Received: by 2002:a05:620a:2a04:b0:6a0:603f:4cd9 with SMTP id o4-20020a05620a2a0400b006a0603f4cd9mr14749226qkp.262.1652295086581;
        Wed, 11 May 2022 11:51:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:14fe])
        by smtp.gmail.com with ESMTPSA id k4-20020ae9f104000000b0069fc13ce205sm1596531qkg.54.2022.05.11.11.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 11:51:25 -0700 (PDT)
Date:   Wed, 11 May 2022 14:51:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 1/6] Documentation: filesystems: proc: update meminfo
 section
Message-ID: <YnwFraZlVWQoCjz3@cmpxchg.org>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
 <20220510152847.230957-2-hannes@cmpxchg.org>
 <7a6f8520-a496-e3c3-1fd9-8a30b7a12b14@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a6f8520-a496-e3c3-1fd9-8a30b7a12b14@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 11, 2022 at 07:11:06PM +0200, David Hildenbrand wrote:
> On 10.05.22 17:28, Johannes Weiner wrote:
> > Add new entries. Minor corrections and cleanups.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  Documentation/filesystems/proc.rst | 155 ++++++++++++++++++-----------
> >  1 file changed, 99 insertions(+), 56 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index 061744c436d9..736ed384750c 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -942,56 +942,71 @@ can be substantial.  In many cases there are other means to find out
> >  additional memory using subsystem specific interfaces, for instance
> >  /proc/net/sockstat for TCP memory allocations.
> >  
> > -The following is from a 16GB PIII, which has highmem enabled.
> > -You may not have all of these fields.
> > +Example output. You may not have all of these fields.
> >  
> >  ::
> >  
> >      > cat /proc/meminfo
> >  
> > -    MemTotal:     16344972 kB
> > -    MemFree:      13634064 kB
> > -    MemAvailable: 14836172 kB
> > -    Buffers:          3656 kB
> > -    Cached:        1195708 kB
> > -    SwapCached:          0 kB
> > -    Active:         891636 kB
> > -    Inactive:      1077224 kB
> > -    HighTotal:    15597528 kB
> > -    HighFree:     13629632 kB
> > -    LowTotal:       747444 kB
> > -    LowFree:          4432 kB
> > -    SwapTotal:           0 kB
> > -    SwapFree:            0 kB
> > -    Dirty:             968 kB
> > -    Writeback:           0 kB
> > -    AnonPages:      861800 kB
> > -    Mapped:         280372 kB
> > -    Shmem:             644 kB
> > -    KReclaimable:   168048 kB
> > -    Slab:           284364 kB
> > -    SReclaimable:   159856 kB
> > -    SUnreclaim:     124508 kB
> > -    PageTables:      24448 kB
> > -    NFS_Unstable:        0 kB
> > -    Bounce:              0 kB
> > -    WritebackTmp:        0 kB
> > -    CommitLimit:   7669796 kB
> > -    Committed_AS:   100056 kB
> > -    VmallocTotal:   112216 kB
> > -    VmallocUsed:       428 kB
> > -    VmallocChunk:   111088 kB
> > -    Percpu:          62080 kB
> > -    HardwareCorrupted:   0 kB
> > -    AnonHugePages:   49152 kB
> > -    ShmemHugePages:      0 kB
> > -    ShmemPmdMapped:      0 kB
> > +    MemTotal:       32858820 kB
> > +    MemFree:        21001236 kB
> > +    MemAvailable:   27214312 kB
> > +    Buffers:          581092 kB
> > +    Cached:          5587612 kB
> > +    SwapCached:            0 kB
> > +    Active:          3237152 kB
> > +    Inactive:        7586256 kB
> > +    Active(anon):      94064 kB
> > +    Inactive(anon):  4570616 kB
> > +    Active(file):    3143088 kB
> > +    Inactive(file):  3015640 kB
> > +    Unevictable:           0 kB
> > +    Mlocked:               0 kB
> > +    SwapTotal:             0 kB
> > +    SwapFree:              0 kB
> > +    Dirty:                12 kB
> > +    Writeback:             0 kB
> > +    AnonPages:       4654780 kB
> > +    Mapped:           266244 kB
> > +    Shmem:              9976 kB
> > +    KReclaimable:     517708 kB
> > +    Slab:             660044 kB
> > +    SReclaimable:     517708 kB
> > +    SUnreclaim:       142336 kB
> > +    KernelStack:       11168 kB
> > +    PageTables:        20540 kB
> > +    NFS_Unstable:          0 kB
> > +    Bounce:                0 kB
> > +    WritebackTmp:          0 kB
> > +    CommitLimit:    16429408 kB
> > +    Committed_AS:    7715148 kB
> > +    VmallocTotal:   34359738367 kB
> > +    VmallocUsed:       40444 kB
> > +    VmallocChunk:          0 kB
> > +    Percpu:            29312 kB
> > +    HardwareCorrupted:     0 kB
> > +    AnonHugePages:   4149248 kB
> > +    ShmemHugePages:        0 kB
> > +    ShmemPmdMapped:        0 kB
> > +    FileHugePages:         0 kB
> > +    FilePmdMapped:         0 kB
> > +    CmaTotal:              0 kB
> > +    CmaFree:               0 kB
> > +    HugePages_Total:       0
> > +    HugePages_Free:        0
> > +    HugePages_Rsvd:        0
> > +    HugePages_Surp:        0
> > +    Hugepagesize:       2048 kB
> > +    Hugetlb:               0 kB
> > +    DirectMap4k:      401152 kB
> > +    DirectMap2M:    10008576 kB
> > +    DirectMap1G:    24117248 kB
> >  
> >  MemTotal
> >                Total usable RAM (i.e. physical RAM minus a few reserved
> >                bits and the kernel binary code)
> >  MemFree
> > -              The sum of LowFree+HighFree
> > +              Total free RAM. On highmem systems, the sum of LowFree+HighFree
> >  MemAvailable
> >                An estimate of how much memory is available for starting new
> >                applications, without swapping. Calculated from MemFree,
> > @@ -1005,8 +1020,9 @@ Buffers
> >                Relatively temporary storage for raw disk blocks
> >                shouldn't get tremendously large (20MB or so)
> >  Cached
> > -              in-memory cache for files read from the disk (the
> > -              pagecache).  Doesn't include SwapCached
> > +              In-memory cache for files read from the disk (the
> > +              pagecache) as well as tmpfs & shmem.
> > +              Doesn't include SwapCached.
> >  SwapCached
> >                Memory that once was swapped out, is swapped back in but
> >                still also is in the swapfile (if memory is needed it
> > @@ -1018,6 +1034,11 @@ Active
> >  Inactive
> >                Memory which has been less recently used.  It is more
> >                eligible to be reclaimed for other purposes
> > +Unevictable
> > +              Memory that cannot be reclaimed, such as mlocked pages,
> > +              ramfs backing pages, secret memfd pages etc.
> 
> 
> A little imprecise, because this only includes memory to be mapped into
> user space. For example, all kernel allocations are unevictable but not
> accounted here.

True. How about the below?

> Apart from that
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 9749ff8c0ecf..5e9791457876 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1035,8 +1035,8 @@ Inactive
               Memory which has been less recently used.  It is more
               eligible to be reclaimed for other purposes
 Unevictable
-              Memory that cannot be reclaimed, such as mlocked pages,
-              ramfs backing pages, secret memfd pages etc.
+              Memory allocated for userspace which cannot be reclaimed, such
+              as mlocked pages, ramfs backing pages, secret memfd pages etc.
 Mlocked
               Memory locked with mlock().
 HighTotal, HighFree
