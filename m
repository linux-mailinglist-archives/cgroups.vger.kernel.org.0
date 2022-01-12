Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D175B48CD10
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 21:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357608AbiALUYA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jan 2022 15:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357605AbiALUX6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jan 2022 15:23:58 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01392C06173F;
        Wed, 12 Jan 2022 12:23:58 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id h1so5824070pls.11;
        Wed, 12 Jan 2022 12:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n6vNoI1/a0MDiqXuZ0zXzZQChQHHajU4edJoNcbDIdQ=;
        b=EYBoAiBSvbXwh/dJ5H4rNhojPuxcAibbjsPJvRAzDkRKcXllebozoVEKaSp/nQJpu/
         PAv1LWNyiMTdsL1r1GASsvdIAsGwCfl4jI664YuTM8ZkV/JB4SBEdANOJijQp3wU/CSF
         uU4pB0uPisW9xxGAtpS9g1OFpvBvS92rtOJXAK5Prk3QRLn+blfi6Pmwrb/BqHHeX95F
         85BbQPrXuFfinz5LJF1/9B5Dxf3ujA+ugfdRtIseKhCk4X9a/BJazZE9GjyLpHyveBhV
         tdA0SURCSyxHi416HaDCKFnaueOmPDRZm86kOAbhep7nEmvZLhV8XikCqilTvD1Wgosp
         DcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=n6vNoI1/a0MDiqXuZ0zXzZQChQHHajU4edJoNcbDIdQ=;
        b=xouL/4iX1FDRRR0qYAi7+eJrht64+huD0y+fkEpAvD1D8TJHb+a8cTLcU7eobrxKTg
         oa6S54gdHYvvkmufvLVMiCRQTqm/ZDlDOhKtIJ628c4/6fAuPsAj/LxhlKBEQjuJwPtR
         /9ooMiV78BGFsj5xxRyHwT1STY/zdpWFyuze0tHgKS0Za8+qQffMJYrut1mSoKCrohBC
         hFTlVD99fFRgQejRy9LOy3apSgs8AVwRm8aP9F0ykJFIju3y/oVh6gQtk+0DdbDSMCW6
         Y7GOrnSIEt9DFFFBvmvn9V7jYxlm1a3HyVZhNaIaFCQdIm48VdeRorduxA6/604TQ/Sz
         BQjw==
X-Gm-Message-State: AOAM531y0zq6HKIGEpOrlIffBtSPSLVYSgZ493P88mQtIGMjCSvVOp70
        L/3UHdMwuBIq0gaX9eX8FZs=
X-Google-Smtp-Source: ABdhPJzKaq+5xVjxDz281axC0oFdXS8BNkH8VUtt2uJd1FqQljInB/mLkMss+Juhqg+rOgnMOccALg==
X-Received: by 2002:a63:6908:: with SMTP id e8mr1097170pgc.587.1642019037459;
        Wed, 12 Jan 2022 12:23:57 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id u126sm441301pgc.22.2022.01.12.12.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 12:23:56 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Jan 2022 10:23:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cgroup: add cpu.stat_percpu
Message-ID: <Yd8429VrPCay9cn4@slm.duckdns.org>
References: <20220107234138.1765668-1-joshdon@google.com>
 <Yd189wHB2LJcK1Pv@hirez.programming.kicks-ass.net>
 <CABk29NuGs_9uxgbv678W=BGGinZNiUHO5T57FHGbOG+HP-FT2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NuGs_9uxgbv678W=BGGinZNiUHO5T57FHGbOG+HP-FT2g@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Jan 11, 2022 at 03:38:20PM -0800, Josh Don wrote:
> Is the concern there just the extra overhead from making multiple
> trips into this handler and re-allocating the buffer until it is large
> enough to take all the output? In that case, we could pre-allocate
> with a size of the right order of magnitude, similar to /proc/stat.
> 
> Lack of per-cpu stats is a gap between cgroup v1 and v2, for which v2
> can easily support this interface given that it already tracks the
> stats percpu internally. I opted to dump them all in a single file
> here, to match the consolidation that occurred from cpuacct->cpu.stat.

Yeah, nack on this. That part was dropped intentionally. These text pseudo
files aren't a great medium for this sort of (potentially large) data dump
and they scale really badly with new fields which we may want to expose in
the future. For detailed introspection, a better route would be using bpf
and if that's inconvenient for some reason trying to make them more
convenient.

Thanks.

-- 
tejun
