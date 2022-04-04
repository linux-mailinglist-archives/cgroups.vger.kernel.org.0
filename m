Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E51D4F1165
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 10:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbiDDIxq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 04:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbiDDIxp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 04:53:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810131E3D2;
        Mon,  4 Apr 2022 01:51:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3A8BF1F37E;
        Mon,  4 Apr 2022 08:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649062309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8dVesPMKaUut+TR+yGDooheAhutrkDr3IKERwS5AoSk=;
        b=llLqVXQVAuNVhRTxpopykvgOo5UDxL0+UVttQORgi7aeqOzxr0beKggQRRtiym8WzDZ4Qt
        GbJRJ10wLx240JOdmPbpx+/0eROIKFzQSN+bI6CSp2pTBrhNp1eNW3sGqfCOjn9fiS01bc
        30ovvrP+E6SgyIM6U5zj5D9JlKi04HM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B5AF2A3B87;
        Mon,  4 Apr 2022 08:51:48 +0000 (UTC)
Date:   Mon, 4 Apr 2022 10:51:48 +0200
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
Message-ID: <YkqxpEW4m6iU3zMq@dhcp22.suse.cz>
References: <1648713656-24254-1-git-send-email-zhaoyang.huang@unisoc.com>
 <YkVt0m+VxnXgnulq@dhcp22.suse.cz>
 <CAGWkznF4qb2EP3=xVamKO8qk08vaFg9JeHD7g80xvBfxm39Hkg@mail.gmail.com>
 <YkWR8t8yEe6xyzCM@dhcp22.suse.cz>
 <CAGWkznHxAD0757m1i1Csw1CVRDtQddfCL08dYf12fa47=-uYYQ@mail.gmail.com>
 <YkbjNYMY8VjHoSHR@dhcp22.suse.cz>
 <CAGWkznF7cSyPU0ceYwH6zweJzf-X1bQnS6AJ2-J+WEL0u8jzng@mail.gmail.com>
 <CAJuCfpHneDZMXO_MmQDPA+igAOdAPRUChiq+zftFXGfDzPHNhQ@mail.gmail.com>
 <CAGWkznFTQCm0cusVxA_55fu2WfT-w2coVHrT=JA1D_9_2728mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznFTQCm0cusVxA_55fu2WfT-w2coVHrT=JA1D_9_2728mQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 04-04-22 10:33:58, Zhaoyang Huang wrote:
[...]
> > One thing that I don't understand in this approach is: why memory.low
> > should depend on the system's memory pressure. It seems you want to
> > allow a process to allocate more when memory pressure is high. That is
> > very counter-intuitive to me. Could you please explain the underlying
> > logic of why this is the right thing to do, without going into
> > technical details?
> What I want to achieve is make memory.low be positive correlation with
> timing and negative to memory pressure, which means the protected
> memcg should lower its protection(via lower memcg.low) for helping
> system's memory pressure when it's high.

I have to say this is still very confusing to me. The low limit is a
protection against external (e.g. global) memory pressure. Decreasing
the protection based on the external pressure sounds like it goes right
against the purpose of the knob. I can see reasons to update protection
based on refaults or other metrics from the userspace but I still do not
see how this is a good auto-magic tuning done by the kernel.

> The concept behind is memcg's
> fault back of dropped memory is less important than system's latency
> on high memory pressure.

Can you give some specific examples?

> Please refer to my new version's test data
> for more detail.

Please note that sending new RFCs will just make the discussion spread
over several email threads which will get increasingly hard to follow.
So do not post another version until it is really clear what is the
actual semantic you are proposing.

-- 
Michal Hocko
SUSE Labs
