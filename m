Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7293F49CC88
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 15:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbiAZOk7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 09:40:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33018 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbiAZOk4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 09:40:56 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D8CE51F3B2;
        Wed, 26 Jan 2022 14:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643208054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikVGucglYY6adaWYk1tsxONRaOQuLmugr5KPZRiegJs=;
        b=FB53ozzCG75iUCc1fuk8x9gf645bOEnHQTfs7mxB6POtWIUBPVvLD7lzOkV9/hm1dz9NuJ
        imh9GgjUMVjAE1u8VmWiOr8F2DwE7YRaPnWZjh8TDG4aWCtmKd773P0dTj2UruRixxYbEH
        aMM8usYypLjnN4bg8nLwKrE+k3/0g50=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A9074A3B83;
        Wed, 26 Jan 2022 14:40:54 +0000 (UTC)
Date:   Wed, 26 Jan 2022 15:40:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/4] mm/memcg: Disable threshold event handlers on
 PREEMPT_RT
Message-ID: <YfFddqkAhd1YKqX9@dhcp22.suse.cz>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220125164337.2071854-2-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 25-01-22 17:43:34, Sebastian Andrzej Siewior wrote:
> During the integration of PREEMPT_RT support, the code flow around
> memcg_check_events() resulted in `twisted code'. Moving the code around
> and avoiding then would then lead to an additional local-irq-save
> section within memcg_check_events(). While looking better, it adds a
> local-irq-save section to code flow which is usually within an
> local-irq-off block on non-PREEMPT_RT configurations.
> 
> The threshold event handler is a deprecated memcg v1 feature. Instead of
> trying to get it to work under PREEMPT_RT just disable it. There should
> be no users on PREEMPT_RT. From that perspective it makes even less
> sense to get it to work under PREEMPT_RT while having zero users.
> 
> Make memory.soft_limit_in_bytes and cgroup.event_control return
> -EOPNOTSUPP on PREEMPT_RT. Make an empty memcg_check_events() and
> memcg_write_event_control() which return only -EOPNOTSUPP on PREEMPT_RT.
> Document that the two knobs are disabled on PREEMPT_RT. Shuffle the code around
> so that all unused function are in on #ifdef block.
> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Suggested-by: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I still support this approach but the patch is much larger than
necessary. The code moving shouldn't be really necessary and a simple
"do not allow" to set any thresholds or soft limit should be good
enough. 

While in general it is better to disable the unreachable code I do not
think this is worth the code churn here.

> ---
>  .../admin-guide/cgroup-v1/memory.rst          |   2 +
>  mm/memcontrol.c                               | 788 +++++++++---------
>  2 files changed, 404 insertions(+), 386 deletions(-)
-- 
Michal Hocko
SUSE Labs
