Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295731A3218
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 11:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDIJqT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Apr 2020 05:46:19 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:42212 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIJqT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Apr 2020 05:46:19 -0400
Received: by mail-wr1-f50.google.com with SMTP id f10so1481221wrr.9
        for <cgroups@vger.kernel.org>; Thu, 09 Apr 2020 02:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LId4DAWOHvNuMMutRw21LME3ewUa/DnUdtIKzTRHI7w=;
        b=p/d7M06SIMb1YjiA997FrR5g6ljjCN6L+r8cv3nzdLTDA40GP76qboVaXUJute9pT2
         k+B2if0v7fatbMflb9TrMyChtDHvmijLuq0Q5t+vrpYNd/NIw/jF4ibaAjpWCNK28yb3
         OpP2/TSBQQHcONuQZVRJFZ6828nXrbvCPI1KP204de3Fm5VDj/B2QRWJvdjxFriZ51Y8
         pJjXKUAnxrSFMQkZh8dUE1ZR/664Z1uFBWwov6nsNMO2Cimtt73ZXBlCZ6GOPqaVd/GH
         N/YUHEp7pjubWa0rzTcRYbFazoHDEz260CSlSFthccCC+GuUTPlS52UF9xGVU+rA2fpo
         AKHA==
X-Gm-Message-State: AGi0PubUkWU4gft7TL64lrrJWPw9eBFlHOsz954LCDxmY25RKE0ComMz
        nnCjbgXPklCFtRQtvvxXzWI=
X-Google-Smtp-Source: APiQypKT0yoHVLUSTGGMtIqSXhW/xasf+pY1RxvSukiHoF9vE4Tpujs3PAnahafjfhq0Sk6rcv5J2A==
X-Received: by 2002:adf:e282:: with SMTP id v2mr13177978wri.329.1586425578442;
        Thu, 09 Apr 2020 02:46:18 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id c4sm3185981wmb.5.2020.04.09.02.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 02:46:17 -0700 (PDT)
Date:   Thu, 9 Apr 2020 11:46:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Chris Down <chris@chrisdown.name>
Subject: Re: Memory CG and 5.1 to 5.6 uprade slows backup
Message-ID: <20200409094615.GE18386@dhcp22.suse.cz>
References: <20200409112505.2e1fc150@hemera.lan.sysophe.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409112505.2e1fc150@hemera.lan.sysophe.eu>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[Cc Chris]

On Thu 09-04-20 11:25:05, Bruno Prémont wrote:
> Hi,
> 
> Upgrading from 5.1 kernel to 5.6 kernel on a production system using
> cgroups (v2) and having backup process in a memory.high=2G cgroup
> sees backup being highly throttled (there are about 1.5T to be
> backuped).

What does /proc/sys/vm/dirty_* say? Is it possible that the reclaim is
not making progress on too many dirty pages and that triggers the back
off mechanism that has been implemented recently in  5.4 (have a look at 
0e4b01df8659 ("mm, memcg: throttle allocators when failing reclaim over
memory.high") and e26733e0d0ec ("mm, memcg: throttle allocators based on
ancestral memory.high").

Keeping the rest of the email for reference.

> Most memory usage in that cgroup is for file cache.
> 
> Here are the memory details for the cgroup:
> memory.current:2147225600
> memory.events:low 0
> memory.events:high 423774
> memory.events:max 31131
> memory.events:oom 0
> memory.events:oom_kill 0
> memory.events.local:low 0
> memory.events.local:high 423774
> memory.events.local:max 31131
> memory.events.local:oom 0
> memory.events.local:oom_kill 0
> memory.high:2147483648
> memory.low:33554432
> memory.max:2415919104
> memory.min:0
> memory.oom.group:0
> memory.pressure:some avg10=90.42 avg60=72.59 avg300=78.30 total=298252577711
> memory.pressure:full avg10=90.32 avg60=72.53 avg300=78.24 total=295658626500
> memory.stat:anon 10887168
> memory.stat:file 2062102528
> memory.stat:kernel_stack 73728
> memory.stat:slab 76148736
> memory.stat:sock 360448
> memory.stat:shmem 0
> memory.stat:file_mapped 12029952
> memory.stat:file_dirty 946176
> memory.stat:file_writeback 405504
> memory.stat:anon_thp 0
> memory.stat:inactive_anon 0
> memory.stat:active_anon 10121216
> memory.stat:inactive_file 1954959360
> memory.stat:active_file 106418176
> memory.stat:unevictable 0
> memory.stat:slab_reclaimable 75247616
> memory.stat:slab_unreclaimable 901120
> memory.stat:pgfault 8651676
> memory.stat:pgmajfault 2013
> memory.stat:workingset_refault 8670651
> memory.stat:workingset_activate 409200
> memory.stat:workingset_nodereclaim 62040
> memory.stat:pgrefill 1513537
> memory.stat:pgscan 47519855
> memory.stat:pgsteal 44933838
> memory.stat:pgactivate 7986
> memory.stat:pgdeactivate 1480623
> memory.stat:pglazyfree 0
> memory.stat:pglazyfreed 0
> memory.stat:thp_fault_alloc 0
> memory.stat:thp_collapse_alloc 0
> 
> Numbers that change most are pgscan/pgsteal
> Regularly the backup process seems to be blocked for about 2s, but not
> within a syscall according to strace.
> 
> Is there a way to tell kernel that this cgroup should not be throttled
> and its inactive file cache given up (rather quickly).
> 
> The aim here is to avoid backup from killing production task file cache
> but not starving it.
> 
> 
> If there is some useful info missing, please tell (eventually adding how
> I can obtain it).
> 
> 
> On a side note, I liked v1's mode of soft/hard memory limit where the
> memory amount between soft and hard could be used if system has enough
> free memory. For v2 the difference between high and max seems almost of
> no use.
> 
> A cgroup parameter for impacting RO file cache differently than
> anonymous memory or otherwise dirty memory would be great too.
> 
> 
> Thanks,
> Bruno

-- 
Michal Hocko
SUSE Labs
