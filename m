Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A1D44C4E1
	for <lists+cgroups@lfdr.de>; Wed, 10 Nov 2021 17:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhKJQRU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Nov 2021 11:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhKJQRU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Nov 2021 11:17:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C70C061764;
        Wed, 10 Nov 2021 08:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NjWp/DEt+8bVHPs1gmDRocuQVRMShr5c3n+CoKHRG3Y=; b=FgTPGGCfgvuH/hxPJ+BKPW63ZY
        2h9xXsa8BCA8uE7nrHtXOFynwE/3wW600gdD7y23kFti+2gx0Or+nKJxcni9NEVgR0taz97mPYEwp
        +cNTH7BvpALxKGQpA4TsoBMFRlLoVyadyWiCwQ9vvSeW5hfnXKo50OoDN++CzUlZVDE3HjH23IcrL
        HK8VVB4CTu5vahV/VTUIQYs1Twx3h/kEYMVYls/xN4Zx0oWdCTc9we4AunzgYMPXeGO5uENnHDIX2
        jFW+u6R9AOPytdq+Oe9GnVSUx7948uS3hWAUxAWg3zy+Xr6uhbsOX+NS1tGx15JkaiUxUTYH1Lj8q
        gdv9DCKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkqEf-00FInD-11; Wed, 10 Nov 2021 16:14:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7BD0986972; Wed, 10 Nov 2021 17:14:02 +0100 (CET)
Date:   Wed, 10 Nov 2021 17:14:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     hannes@cmpxchg.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, mingo@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        mhocko@kernel.org, vdavydov.dev@gmail.com, tj@kernel.org,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, djakov@kernel.org
Subject: Re: [RFC] psi: Add additional PSI counters for each type of memory
 pressure
Message-ID: <20211110161402.GB174703@worktop.programming.kicks-ass.net>
References: <1636558597-248294-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636558597-248294-1-git-send-email-quic_c_gdjako@quicinc.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 10, 2021 at 07:36:37AM -0800, Georgi Djakov wrote:
> @@ -21,7 +19,18 @@ enum psi_task_count {
>  	 * don't have to special case any state tracking for it.
>  	 */
>  	NR_ONCPU,
> -	NR_PSI_TASK_COUNTS = 4,
> +	NR_BLK_CGROUP_THROTTLE,
> +	NR_BIO,
> +	NR_COMPACTION,
> +	NR_THRASHING,
> +	NR_CGROUP_RECLAIM_HIGH,
> +	NR_CGROUP_RECLAIM_HIGH_SLEEP,
> +	NR_CGROUP_TRY_CHARGE,
> +	NR_DIRECT_COMPACTION,
> +	NR_DIRECT_RECLAIM,
> +	NR_READ_SWAPPAGE,
> +	NR_KSWAPD,
> +	NR_PSI_TASK_COUNTS = 16,
>  };
>  

> @@ -51,9 +80,20 @@ enum psi_states {
>  	PSI_MEM_FULL,
>  	PSI_CPU_SOME,
>  	PSI_CPU_FULL,
> +	PSI_BLK_CGROUP_THROTTLE,
> +	PSI_BIO,
> +	PSI_COMPACTION,
> +	PSI_THRASHING,
> +	PSI_CGROUP_RECLAIM_HIGH,
> +	PSI_CGROUP_RECLAIM_HIGH_SLEEP,
> +	PSI_CGROUP_TRY_CHARGE,
> +	PSI_DIRECT_COMPACTION,
> +	PSI_DIRECT_RECLAIM,
> +	PSI_READ_SWAPPAGE,
> +	PSI_KSWAPD,
>  	/* Only per-CPU, to weigh the CPU in the global average: */
>  	PSI_NONIDLE,
> -	NR_PSI_STATES = 7,
> +	NR_PSI_STATES = 18,
>  };

Have you considered what this does to psi_group_cpu's size and layout
and the impact thereof on performance?
