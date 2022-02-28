Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ADF4C6A37
	for <lists+cgroups@lfdr.de>; Mon, 28 Feb 2022 12:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiB1LX6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Feb 2022 06:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiB1LX5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Feb 2022 06:23:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C383E5DF
        for <cgroups@vger.kernel.org>; Mon, 28 Feb 2022 03:23:18 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D451B1F895;
        Mon, 28 Feb 2022 11:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646047396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KR6yo3C6hJQk5k7SpkBMoRJDBxwgQp2yNNIt116CbC8=;
        b=LjHmtuP3WDYlvPgswTQU7/wTCdZoXJ1pFMe8y4EoxX49PehbYAMD7AHzqyREGFBNGmBAqi
        ELrQuydUDJEL9gAnbxWYbqBjnyq7RHgn/TOd6EYCgpHndNmiXudczQnjR3HjDu9TaRCQhG
        0ru55ZKi/CMeP62MvOCMIHLrP15v+ek=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 882A2A3B81;
        Mon, 28 Feb 2022 11:23:16 +0000 (UTC)
Date:   Mon, 28 Feb 2022 12:23:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v5 3/6] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT where needed.
Message-ID: <YhywoBOPDuQmwmq0@dhcp22.suse.cz>
References: <20220226204144.1008339-1-bigeasy@linutronix.de>
 <20220226204144.1008339-4-bigeasy@linutronix.de>
 <YhyCWQYL8vxRSLrd@dhcp22.suse.cz>
 <YhytODB1IQFLfx4h@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhytODB1IQFLfx4h@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 28-02-22 12:08:40, Sebastian Andrzej Siewior wrote:
> On 2022-02-28 09:05:45 [+0100], Michal Hocko wrote:
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > TBH I am not a fan of the counter special casing for the debugging
> > enabled warnings but I do not feel strong enough to push you trhough an
> > additional version round.
> 
> do you want to get rid of the warnings completely? Since we had the
> check in memcg_stats_lock() it kinda felt useful to add something in
> __memcg_stats_lock() case, too.

The thing that I dislike is that there is no other way for potential
users of those counters to know these expectations. This is not
documented anywhere so it mostly describes the _current_ state of the
code which might change in the future. We can be more thorough and
document counters wrt. to the context they can be used in which would
make this less of a concern of course. But this can be done on top hence
I do not want to push you for another versions. It is good to have your
current work merged in the next merge window as long as there are no
fallouts and for that it would be good to have it in the linux next and
exposed for some more testing rather than dealing with this deatails.
-- 
Michal Hocko
SUSE Labs
