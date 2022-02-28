Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C984C6CA2
	for <lists+cgroups@lfdr.de>; Mon, 28 Feb 2022 13:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiB1MgJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Feb 2022 07:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiB1MgI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Feb 2022 07:36:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFC756764
        for <cgroups@vger.kernel.org>; Mon, 28 Feb 2022 04:35:29 -0800 (PST)
Date:   Mon, 28 Feb 2022 13:35:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646051727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NrXkZIXCIbcCdTt1MSpZIrgg4yhy+z0slRqeYoIDKJQ=;
        b=zfPFtUvutLYYHKGpmWQcWje1s6f2f+G6B8+9yNeAZwmQW7kJNPL43+vYWrB3aejmPeGdb5
        xP4ZBpfjp2h/ILzvE0WoYqRIl3nrhQyPkwRU1ooZp3C4TywyBL2VJENpXTLPOI2jF4InDn
        J0F6b8AhkbptW7hr+ABVOY4KcHJYrZzwdSR26BH2ZTrQpdvibthwj0YRMSlgOO3SqvG4yG
        5Ps8VMnMejBUqkgBNJOVIVu+baSAWusRHhfcssIi5vAoaBMaq5IHk9Ztp2wFRnD2/9kiAq
        usISL7szkGNL6DutISpY6xOorqvchmbakdZ7qSH8XdQP6sc5k461pvXHIDoBLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646051727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NrXkZIXCIbcCdTt1MSpZIrgg4yhy+z0slRqeYoIDKJQ=;
        b=siDmoQ6Xa3WguvR8ZjduUL4qXi7hQbJtZxBsk8HnrmRdRn4DpCdBK8kT53PBGqI0tj6Kav
        va+l7WlflT0jFTCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v5 3/6] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT where needed.
Message-ID: <YhzBjviBEMHlbIyA@linutronix.de>
References: <20220226204144.1008339-1-bigeasy@linutronix.de>
 <20220226204144.1008339-4-bigeasy@linutronix.de>
 <YhyCWQYL8vxRSLrd@dhcp22.suse.cz>
 <YhytODB1IQFLfx4h@linutronix.de>
 <YhywoBOPDuQmwmq0@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhywoBOPDuQmwmq0@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-02-28 12:23:12 [+0100], Michal Hocko wrote:
> On Mon 28-02-22 12:08:40, Sebastian Andrzej Siewior wrote:
> > On 2022-02-28 09:05:45 [+0100], Michal Hocko wrote:
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > 
> > > TBH I am not a fan of the counter special casing for the debugging
> > > enabled warnings but I do not feel strong enough to push you trhough an
> > > additional version round.
> > 
> > do you want to get rid of the warnings completely? Since we had the
> > check in memcg_stats_lock() it kinda felt useful to add something in
> > __memcg_stats_lock() case, too.
> 
> The thing that I dislike is that there is no other way for potential
> users of those counters to know these expectations. This is not
> documented anywhere so it mostly describes the _current_ state of the
> code which might change in the future. We can be more thorough and
> document counters wrt. to the context they can be used in which would
> make this less of a concern of course. But this can be done on top hence
> I do not want to push you for another versions. It is good to have your
> current work merged in the next merge window as long as there are no
> fallouts and for that it would be good to have it in the linux next and
> exposed for some more testing rather than dealing with this deatails.

Okay. Then I would suggest then I document the usage context of these
counters once things settled down. Now there is no validation at all, so
if someone uses the wrong context for a counter and you don't spot it
during the review then there will be no warning at runtime.

Sebastian
