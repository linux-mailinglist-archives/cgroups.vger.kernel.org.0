Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE471A32D0
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 12:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDIKuv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Apr 2020 06:50:51 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:35833 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgDIKuu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Apr 2020 06:50:50 -0400
Received: by mail-wr1-f54.google.com with SMTP id g3so11423873wrx.2
        for <cgroups@vger.kernel.org>; Thu, 09 Apr 2020 03:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=v38bfbui8k5a6UTKAOOaJuah7JdF2f/erdWIs/iN2qA=;
        b=HW+Knoxg6d/dZG9qisjLcg2gnNliKCOWd8p3/R5jwqedJAeqw6sTWQbY7DRl6EP5qj
         Z0oIN4Gj+z5uafDfWB1vhxgYIt/IayuZXkSSHsYKgPNRr7lUaBAkhFpAiYGbcjTm/08J
         ogsOuGxSUOM8UjBOW/f8+EmhnUm5ARNpntjQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v38bfbui8k5a6UTKAOOaJuah7JdF2f/erdWIs/iN2qA=;
        b=sRdt7Sx09XzPEr6EQzyXCWlb/dokkyicwtTZIGhCpkpJVX0wfA94O5GTWceR3cRFE4
         YM+ZZSBgdjtdHRd7h39h4hfKMf1saqrcBX1BEDeLJNbunWXkPEHo6YdcUkxWLoWkiyKv
         JrGo2DZ4Rhxd6vtuheQ9DDnnm5doipiFnLBU5ZLJLm72P3grU3m6HxDXn2l/97ias1/p
         W6fl1L9kXYGPVnywp8i9BZEijgIlcAGhgvFb2ReQeNQ3BZCldsGGFfGKokIFDB3OvQdE
         IQ0BOFbvIKyAv7GlXAGpq/GB2zObwl9c+sfwjVCctsBiYrcwpSkkeFnTiPQrs2VuY4/x
         le0A==
X-Gm-Message-State: AGi0PubDHBoPikHWrBwsnaaoV/VfqPt9bRsrba7jetzL/ryfZVtQYGqH
        j2MdlhX4SXjGvPiGq7RgFo0F3g==
X-Google-Smtp-Source: APiQypIwos1LrzxkTlY2XcsPKtu0+SZVjP9Xy4WHuHSvnmvsEMTjhb8qp4dTm5GmIwSVsr1AiAddXg==
X-Received: by 2002:adf:ea06:: with SMTP id q6mr10945520wrm.301.1586429449692;
        Thu, 09 Apr 2020 03:50:49 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:9ebe])
        by smtp.gmail.com with ESMTPSA id p22sm3206693wmc.42.2020.04.09.03.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 03:50:49 -0700 (PDT)
Date:   Thu, 9 Apr 2020 11:50:48 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Memory CG and 5.1 to 5.6 uprade slows backup
Message-ID: <20200409105048.GA1040020@chrisdown.name>
References: <20200409112505.2e1fc150@hemera.lan.sysophe.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409112505.2e1fc150@hemera.lan.sysophe.eu>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Bruno,

Bruno Prémont writes:
>Upgrading from 5.1 kernel to 5.6 kernel on a production system using
>cgroups (v2) and having backup process in a memory.high=2G cgroup
>sees backup being highly throttled (there are about 1.5T to be
>backuped).

Before 5.4, memory usage with memory.high=N is essentially unbounded if the 
system is not able to reclaim pages for some reason. This is because all 
memory.high throttling before that point is just based on forcing direct 
reclaim for a cgroup, but there's no guarantee that we can actually reclaim 
pages, or that it will serve as a time penalty.

In 5.4, my patch 0e4b01df8659 ("mm, memcg: throttle allocators when failing 
reclaim over memory.high") changes kernel behaviour to actively penalise 
cgroups exceeding their memory.high by a large amount. That is, if reclaim 
fails to reclaim pages and bring the cgroup below the high threshold, we 
actively deschedule the process running for some number of jiffies that is 
exponential to the amount of overage incurred. This is so that cgroups using 
memory.high cannot simply have runaway memory usage without any consequences.

This is the patch that I'd particularly suspect is related to your problem. 
However:

>Most memory usage in that cgroup is for file cache.
>
>Here are the memory details for the cgroup:
>memory.current:2147225600
>[...]
>memory.events:high 423774
>memory.events:max 31131
>memory.high:2147483648
>memory.max:2415919104

Your high limit is being exceeded heavily and you are failing to reclaim. You 
have `max` events here, which mean your application is at least at some point 
using over 268 *mega*bytes over its memory.high.

So yes, we will penalise this cgroup heavily since we cannot reclaim from it. 
The real question is why we can't reclaim from it :-)

>memory.low:33554432

You have a memory.low set, which will bias reclaim away from this cgroup based 
on overage. It's not very large, though, so it shouldn't change the semantics 
here, although it's worth noting since it also changed in another one of my 
patches, 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim"), 
which is also in 5.4.

In 5.1, as soon as you exceed memory.low, you immediately lose all protection.  
This is not ideal because it results in extremely binary, back-and-forth 
behaviour for cgroups using it (see the changelog for more information). This 
change means you will still receive some small amount of protection based on 
your overage, but it's fairly insignificant in this case (memory.current is 
about 64x larger than memory.low). What did you intend to do with this in 5.1? 
:-)

>memory.stat:anon 10887168
>memory.stat:file 2062102528
>memory.stat:kernel_stack 73728
>memory.stat:slab 76148736
>memory.stat:sock 360448
>memory.stat:shmem 0
>memory.stat:file_mapped 12029952
>memory.stat:file_dirty 946176
>memory.stat:file_writeback 405504
>memory.stat:anon_thp 0
>memory.stat:inactive_anon 0
>memory.stat:active_anon 10121216
>memory.stat:inactive_file 1954959360
>memory.stat:active_file 106418176
>memory.stat:unevictable 0
>memory.stat:slab_reclaimable 75247616
>memory.stat:slab_unreclaimable 901120
>memory.stat:pgfault 8651676
>memory.stat:pgmajfault 2013
>memory.stat:workingset_refault 8670651
>memory.stat:workingset_activate 409200
>memory.stat:workingset_nodereclaim 62040
>memory.stat:pgrefill 1513537
>memory.stat:pgscan 47519855
>memory.stat:pgsteal 44933838
>memory.stat:pgactivate 7986
>memory.stat:pgdeactivate 1480623
>memory.stat:pglazyfree 0
>memory.stat:pglazyfreed 0
>memory.stat:thp_fault_alloc 0
>memory.stat:thp_collapse_alloc 0

Hard to say exactly why we can't reclaim using these statistics, usually if 
anything the kernel is *over* eager to drop cache pages than anything.

If the kernel thinks those file pages are too hot, though, it won't drop them. 
However, we only have 106M active file, compared to 2GB memory.current, so it 
doesn't look like this is the issue.

Can you please show io.pressure, io.stat, and cpu.pressure during these periods 
compared to baseline for this cgroup and globally (from /proc/pressure)? My 
suspicion is that we are not able to reclaim fast enough because memory 
management is getting stuck behind a slow disk.

Swap availability and usage information would also be helpful.

>Regularly the backup process seems to be blocked for about 2s, but not
>within a syscall according to strace.

2 seconds is important, it's the maximum time we allow the allocator throttler 
to throttle for one allocation :-)

If you want to verify, you can look at /proc/pid/stack during these stalls -- 
they should be in mem_cgroup_handle_over_high, in an address related to 
allocator throttling.

>Is there a way to tell kernel that this cgroup should not be throttled

Huh? That's what memory.high is for, so why are you using if it you don't want 
that?

>and its inactive file cache given up (rather quickly).

I suspect the kernel is reclaiming as far as it can, but is being stopped from 
doing so for some reason, which is why I'd like to see io.pressure and 
cpu.pressure.

>On a side note, I liked v1's mode of soft/hard memory limit where the
>memory amount between soft and hard could be used if system has enough
>free memory. For v2 the difference between high and max seems almost of
>no use.

For that use case, that's more or less what we've designed memory.low to do. 
The difference is that v1's soft limit almost never worked: the heuristics are 
extremely complicated, so complicated in fact that even we as memcg maintainers 
cannot reason about them. If we cannot reason about them, I'm quite sure it's 
not really doing what you expect :-)

In this case everything looks like it's working as intended, just this is all 
the result of memory.high becoming less broken in 5.4. From your description, 
I'm not sure that memory.high is what you want, either.

>A cgroup parameter for impacting RO file cache differently than
>anonymous memory or otherwise dirty memory would be great too.

We had vm.swappiness in v1 and it manifested extremely poorly. I won't go too 
much into the details of that here though, since we already discussed it fairly 
comprehensively here[0].

Please feel free to send over the io.pressure, io.stat, cpu.pressure, and swap 
metrics at baseline and during this when possible. Thanks!

0: https://lore.kernel.org/patchwork/patch/1172080/
