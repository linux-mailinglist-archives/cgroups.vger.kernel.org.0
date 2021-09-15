Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7497140C56F
	for <lists+cgroups@lfdr.de>; Wed, 15 Sep 2021 14:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhIOMnY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Sep 2021 08:43:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59720 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbhIOMnX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Sep 2021 08:43:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 42BE32005E;
        Wed, 15 Sep 2021 12:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631709724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c8ppzFWYneNjhYnOY61IFfVXjIUkdpqvAGrP3jiPXNY=;
        b=BU4gFvgZPXkgGkeAZA8Isz6d5VIGuDlC1iEhdFHcFYBMvbzqGNNT/soHXwDsAwBQuBvjDf
        PaM78JTRR+b08B3QWTBdEVKo1cMHvWjhAZyhditBPCQ3KPHBFhxjSR300DGu5hNG6wKqn8
        zpVkPRYhrZ3HPkNYakZy/QOugYICdsw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 01B8EA3B8F;
        Wed, 15 Sep 2021 12:42:03 +0000 (UTC)
Date:   Wed, 15 Sep 2021 14:42:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     yongw.pur@gmail.com
Cc:     tj@kernel.org, peterz@infradead.org, wang.yong12@zte.com.cn,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, yang.yang29@zte.com.cn
Subject: Re: [PATCH v2] vmpressure: wake up work only when there is
 registration event
Message-ID: <YUHqG0P6Ahs8FvN+@dhcp22.suse.cz>
References: <1631635551-8583-1-git-send-email-wang.yong12@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631635551-8583-1-git-send-email-wang.yong12@zte.com.cn>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 14-09-21 09:05:51, yongw.pur@gmail.com wrote:
> From: wangyong <wang.yong12@zte.com.cn>
> 
> Use the global variable num_events to record the number of vmpressure
> events registered by the system, and wake up work only when there is
> registration event.
> Usually, the vmpressure event is not registered in the system, this patch
> can avoid waking up work and doing nothing.

I have asked in the previous version and this changelog doesn't that
explain again. Why don't you simply bail out early in vmpressure()
entry?

> Test with 5.14.0-rc5-next-20210813 on x86_64 4G ram.
> Consume cgroup memory until it is about to be reclaimed, then execute
> "perf stat -I 2000 malloc.out" command to trigger memory reclamation
> and get performance results.
> The context-switches is reduced by about 20 times.

Is this test somewhere available so that it can be reproduced by
others. Also while the number of context switches can be an interesting
it is not really clear from this evaluation whether that actually
matters or not. E.g. what does an increase of task-clock and twice as
many instructions recorded tell us?

> unpatched:
> Average of 10 test results
> 582.4674048	task-clock(msec)
> 19910.8		context-switches
> 0		cpu-migrations
> 1292.9		page-faults
> 414784733.1	cycles

> <not supported>	stalled-cycles-frontend
> <not supported>	stalled-cycles-backend

Why is this a part of the data?

> 580070698.4	instructions
> 125572244.7	branches
> 2073541.2	branch-misses
> 
> patched
> Average of 10 test results
> 973.6174796	task-clock(msec)
> 988.6		context-switches
> 0		cpu-migrations
> 1785.2		page-faults
> 772883602.4	cycles
> <not supported>	stalled-cycles-frontend
> <not supported>	stalled-cycles-backend
> 1360280911	instructions
> 290519434.9	branches
> 3378378.2	branch-misses
> 
> Tested-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: wangyong <wang.yong12@zte.com.cn>
> ---
> 
[...]
> @@ -272,6 +277,9 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>  		return;
>  
>  	if (tree) {
> +		if (!static_branch_unlikely(&num_events))
> +			return;

We usually hide the change behind a static inline helper (e.g.
vmpressure_disabled()). I would also put it to the beginning of
vmpressure or put an explanation why it makes sense only in this branch.
-- 
Michal Hocko
SUSE Labs
