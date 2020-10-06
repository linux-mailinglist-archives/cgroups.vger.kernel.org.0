Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0BD28503B
	for <lists+cgroups@lfdr.de>; Tue,  6 Oct 2020 18:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgJFQ4B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Oct 2020 12:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFQz6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Oct 2020 12:55:58 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86598C0613D1
        for <cgroups@vger.kernel.org>; Tue,  6 Oct 2020 09:55:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i2so542517ljg.4
        for <cgroups@vger.kernel.org>; Tue, 06 Oct 2020 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6FMgIEmm68X+8barBvlty/GsDrmbyTvteiUC/zViSzM=;
        b=E+fs5Kb6ZtKcDpUZvLnSB08EOAVj2XhAZad69x+W3WhY0TvKQs7HLnWuX1DalOm5k3
         75g0XMp7neiJ0e9OM6kSd7eBrufBh65ij0geSUYX+V5pNfDC72uq3vfmfDr0gtlZMpbJ
         DcQ0L1pYWRcCDJNfvgKMXtdc4EmejdC6A7ZExgxw+UxR0Ojc0g9NL1qIJs/8vB0fMhdJ
         x1JgRTLTqvDnnjFkkyrjySeMyl+r5ulpW2pQVTHhS4Ehu9+aX8n2CePeR3tUCCaBQ07T
         OQZfOuGO2gJWiGAternLPjoBUgE1ZZbuHrHcPcpP/ZzCWyLa8C6aBNI8lPQeSibLV3XP
         Y+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6FMgIEmm68X+8barBvlty/GsDrmbyTvteiUC/zViSzM=;
        b=qL0/Sie1vJGPPz5v7z6XZYkAP1hug4/2oRuJmAPeNdWwMiYfKAi00a+kYHpJK1HxtS
         /NW+wgbiVkM3G0OzTz853xmbceSGWvT6SxhmtdzuVdnTycSLW0DIJ4gqnvWSSO6uBgt6
         7F20+s7QzG1W/yLIvyLYsl7wlOzFb+wrxUXBJE89ptVStOvKhjvdC/UjPprBDKCgWLYr
         VDqWVUVv8pDhe0l7gVZt6ufqoIdZL3PwowGst4VZMICNILopyGexqvfTREtz/RvjUKtY
         axVHvHp8ofppnIKYEruQaxdc9G3HhDb6AdamNuyrs0ew3IGjqMbSa9thzKtKjEcNr+an
         lkiA==
X-Gm-Message-State: AOAM530RPnmHpB+Itnnilq74PZ6mmrKZJ8bOXV+gjCHYgIkJ+n68LjLj
        +POm/0tHtmEn1ge1oB+NfB1uWDuaODizOVn18Ej2zA==
X-Google-Smtp-Source: ABdhPJxwPjYlCjbDVgEIVph5gkze3H34vaF29xYPgo2Wf3p+vlcIihMw4jCo164Pl8sUFSMayqXA9/r5NmYncb6z2LE=
X-Received: by 2002:a2e:3c0e:: with SMTP id j14mr1670185lja.332.1602003354535;
 Tue, 06 Oct 2020 09:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200909215752.1725525-1-shakeelb@google.com> <20200928210216.GA378894@cmpxchg.org>
 <20200929150444.GG2277@dhcp22.suse.cz> <20200929215341.GA408059@cmpxchg.org>
 <CALvZod5eN0PDtKo8SEp1n-xGvgCX9k6-OBGYLT3RmzhA+Q-2hw@mail.gmail.com> <20201001143149.GA493631@cmpxchg.org>
In-Reply-To: <20201001143149.GA493631@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 6 Oct 2020 09:55:43 -0700
Message-ID: <CALvZod59cU40A3nbQtkP50Ae3g6T2MQSt+q1=O2=Gy9QUzNkbg@mail.gmail.com>
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        SeongJae Park <sjpark@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 1, 2020 at 7:33 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
[snip]
> > >    So instead of asking users for a target size whose suitability
> > >    heavily depends on the kernel's LRU implementation, the readahead
> > >    code, the IO device's capability and general load, why not directly
> > >    ask the user for a pressure level that the workload is comfortable
> > >    with and which captures all of the above factors implicitly? Then
> > >    let the kernel do this feedback loop from a per-cgroup worker.
> >
> > I am assuming here by pressure level you are referring to the PSI like
> > interface e.g. allowing the users to tell about their jobs that X
> > amount of stalls in a fixed time window is tolerable.
>
> Right, essentially the same parameters that psi poll() would take.

I thought a bit more on the semantics of the psi usage for the
proactive reclaim.

Suppose I have a top level cgroup A on which I want to enable
proactive reclaim. Which memory psi events should the proactive
reclaim should consider?

The simplest would be the memory.psi at 'A'. However memory.psi is
hierarchical and I would not really want the pressure due limits in
children of 'A' to impact the proactive reclaim. PSI due to refaults
and slow IO should be included or maybe only those which are caused by
the proactive reclaim itself. I am undecided on the PSI due to
compaction. PSI due to global reclaim for 'A' is even more
complicated. This is a stall due to reclaiming from the system
including self. It might not really cause more refaults and IOs for
'A'. Should proactive reclaim ignore the pressure due to global
pressure when tuning its aggressiveness.

Am I overthinking here?
