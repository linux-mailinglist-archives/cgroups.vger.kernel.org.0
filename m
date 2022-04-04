Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4424F122A
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 11:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354442AbiDDJio (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 05:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354650AbiDDJil (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 05:38:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B73D3BFBC;
        Mon,  4 Apr 2022 02:36:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0F7091F37E;
        Mon,  4 Apr 2022 09:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649064995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LpYoL6AgjzJZ4tpGv3/xyzDAd+WQcpBXKtpN+zEEZ6M=;
        b=URZHSoRiL8o7b+yMQLyfEwpcnDVBQxC25DaiTXuXyRDL0IVDsBLTG0R5+BoVe4h2RwHe+8
        846rB9SKsGl/yDW1VzKHMBpdDywbpp7qqlqIszK75ScfGaGQ/nc4UbHX9VFyfjHiaxZssh
        AyAChWqakgt161TVz0sPrchh0q2dSMg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CC8C7A3B92;
        Mon,  4 Apr 2022 09:36:34 +0000 (UTC)
Date:   Mon, 4 Apr 2022 11:36:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
Message-ID: <Ykq8IXstIKoW8JE2@dhcp22.suse.cz>
References: <YkWR8t8yEe6xyzCM@dhcp22.suse.cz>
 <CAGWkznHxAD0757m1i1Csw1CVRDtQddfCL08dYf12fa47=-uYYQ@mail.gmail.com>
 <YkbjNYMY8VjHoSHR@dhcp22.suse.cz>
 <CAGWkznF7cSyPU0ceYwH6zweJzf-X1bQnS6AJ2-J+WEL0u8jzng@mail.gmail.com>
 <CAJuCfpHneDZMXO_MmQDPA+igAOdAPRUChiq+zftFXGfDzPHNhQ@mail.gmail.com>
 <CAGWkznFTQCm0cusVxA_55fu2WfT-w2coVHrT=JA1D_9_2728mQ@mail.gmail.com>
 <YkqxpEW4m6iU3zMq@dhcp22.suse.cz>
 <CAGWkznG4L3w=9bpZp8TjyWHmqFyZQk-3m4xCZ96zhHCLPawBgQ@mail.gmail.com>
 <CAGWkznGMRohE2_at4Qh8KbwSqNmNqOAG2N1EM+7uE9wKqzRm0A@mail.gmail.com>
 <Ykq7KUleuAg5QnNU@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykq7KUleuAg5QnNU@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 04-04-22 11:32:28, Michal Hocko wrote:
> On Mon 04-04-22 17:23:43, Zhaoyang Huang wrote:
> > On Mon, Apr 4, 2022 at 5:07 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> > >
> > > On Mon, Apr 4, 2022 at 4:51 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 04-04-22 10:33:58, Zhaoyang Huang wrote:
> > > > [...]
> > > > > > One thing that I don't understand in this approach is: why memory.low
> > > > > > should depend on the system's memory pressure. It seems you want to
> > > > > > allow a process to allocate more when memory pressure is high. That is
> > > > > > very counter-intuitive to me. Could you please explain the underlying
> > > > > > logic of why this is the right thing to do, without going into
> > > > > > technical details?
> > > > > What I want to achieve is make memory.low be positive correlation with
> > > > > timing and negative to memory pressure, which means the protected
> > > > > memcg should lower its protection(via lower memcg.low) for helping
> > > > > system's memory pressure when it's high.
> > > >
> > > > I have to say this is still very confusing to me. The low limit is a
> > > > protection against external (e.g. global) memory pressure. Decreasing
> > > > the protection based on the external pressure sounds like it goes right
> > > > against the purpose of the knob. I can see reasons to update protection
> > > > based on refaults or other metrics from the userspace but I still do not
> > > > see how this is a good auto-magic tuning done by the kernel.
> > > >
> > > > > The concept behind is memcg's
> > > > > fault back of dropped memory is less important than system's latency
> > > > > on high memory pressure.
> > > >
> > > > Can you give some specific examples?
> > > For both of the above two comments, please refer to the latest test
> > > result in Patchv2 I have sent. I prefer to name my change as focus
> > > transfer under pressure as protected memcg is the focus when system's
> > > memory pressure is low which will reclaim from root, this is not
> > > against current design. However, when global memory pressure is high,
> > > then the focus has to be changed to the whole system, because it
> > > doesn't make sense to let the protected memcg out of everybody, it
> > > can't
> > > do anything when the system is trapped in the kernel with reclaiming work.
> > Does it make more sense if I describe the change as memcg will be
> > protect long as system pressure is under the threshold(partially
> > coherent with current design) and will sacrifice the memcg if pressure
> > is over the threshold(added change)
> 
> No, not really. For one it is still really unclear why there should be any
> difference in the semantic between global and external memory pressure
> in general. The low limit is always a protection from the external
> pressure. And what should be the actual threshold? Amount of the reclaim
> performed, effectivness of the reclaim or what?

Btw. you might want to have a look at http://lkml.kernel.org/r/20220331084151.2600229-1-yosryahmed@google.com
where a new interface to allow pro-active memory reclaim is discussed.
I think that this might turn out to be a better fit then an automagic
kernel manipulation with a low limit. It will require a user agent to
drive the reclaim though.
-- 
Michal Hocko
SUSE Labs
