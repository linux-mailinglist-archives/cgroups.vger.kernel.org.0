Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A0649BF7A
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 00:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiAYXVw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jan 2022 18:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiAYXVw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jan 2022 18:21:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD7BC06173B
        for <cgroups@vger.kernel.org>; Tue, 25 Jan 2022 15:21:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 874AFB81B7E
        for <cgroups@vger.kernel.org>; Tue, 25 Jan 2022 23:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE92DC340E0;
        Tue, 25 Jan 2022 23:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643152908;
        bh=Os2MWz5br1ib2WiO76xCA8LnZuVKJFmC7RaP9N/4r0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yfnDC4j/A3Ze/Yu/Lo5vpOBBSb7WGzqzIQfb9aBKBYXUanxENNOYdhS5qgb+Snw2a
         Oo1sOfxKasHmBVZuza4/zG7vu2H3IWuBcYnNK9ooYWsgLOX359S4eIfxKjNvLsWJd6
         YIUFWvRtN68ay6Si4EByHUpFRiDgoz0U8tfpUMss=
Date:   Tue, 25 Jan 2022 15:21:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 0/4] mm/memcg: Address PREEMPT_RT problems instead of
 disabling it.
Message-Id: <20220125152146.d7e25afe3b8a6807df6fee3f@linux-foundation.org>
In-Reply-To: <20220125164337.2071854-1-bigeasy@linutronix.de>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 25 Jan 2022 17:43:33 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Hi,
> 
> this series is a follow up to the initial RFC
>     https://lore.kernel.org/all/20211222114111.2206248-1-bigeasy@linutronix.de
> 
> and aims to enable MEMCG for PREEMPT_RT instead of disabling it.
> 
> where it has been suggested that I should try again with memcg instead
> of simply disabling it.
> 
> Changes since the RFC:
> - cgroup.event_control / memory.soft_limit_in_bytes is disabled on
>   PREEMPT_RT. It is a deprecated v1 feature. Fixing the signal path is
>   not worth it.
> 
> - The updates to per-CPU counters are usually synchronised by disabling
>   interrupts. There are a few spots where assumption about disabled
>   interrupts are not true on PREEMPT_RT and therefore preemption is
>   disabled. This is okay since the counter are never written from
>   in_irq() context.
> 
> Patch #2 deals with the counters.
> 
> Patch #3 is a follow up to
>    https://lkml.kernel.org/r/20211214144412.447035-1-longman@redhat.com
> 
> Patch #4 restricts the task_obj usage to !PREEMPTION kernels. Based on
> the numbers in 
>    https://lore.kernel.org/all/YdX+INO9gQje6d0S@linutronix.de

This isn't a terribly useful [0/n], sorry.  It would be better to have
something self-contained which doesn't require that the reader chase
down increasingly old links and figure out what changed during
successive iterations.

> I tested them on CONFIG_PREEMPT_NONE + CONFIG_PREEMPT_RT with the
> tools/testing/selftests/cgroup/* tests. It looked good except for the
> following (which was also there before the patches):
> - test_kmem sometimes complained about:
>  not ok 2 test_kmem_memcg_deletion

Is this a new issue?

Does this happen with these patches when CONFIG_PREEMPT_RT=n?

> - test_memcontrol complained always about
>  not ok 3 test_memcg_min
>  not ok 4 test_memcg_low
>  and did not finish.

Similarly, is this caused by these patches?  Is it only triggered under
preempt_rt?

> - lockdep complains were triggered by test_core and test_freezer (both
>   had to run):

Ditto.


