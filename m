Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690451C46FC
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2020 21:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgEDTYI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 15:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgEDTYG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 15:24:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1D7C061A0E
        for <cgroups@vger.kernel.org>; Mon,  4 May 2020 12:24:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so10881128ljn.7
        for <cgroups@vger.kernel.org>; Mon, 04 May 2020 12:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPSIuUKl40zjMTrFqmrp2gFzjgO0Cf6BRDzGoK+tDWg=;
        b=GbV667a2pWz8YlwID7RIjSxS3EhvbGG2eVTfjeZbnaIQt36eX7hiNgbdWKkgMsOAkc
         Pd4c3Z36tS9zp5i+DSGGNzKx3LApW78iueZL2oOKHKQNXDEONAYw9/ZwJiiU/GAIcLEA
         IqcfxVY1ivCJBbIP2ttRlcjLxsjcr/HGVZqBdV7VXMRvuze/dDQrmnz2PCC0tEfr2wGb
         GlO3dsxskMpwBK8J2EqhuA7PAfU5gFeu1qFNUvc5mLxqLM98jDrtc9gQJG8j1w9P435i
         7YmVNH9IMNHBLHEYXaU5eSxODFeYdzQ8b6i7xQ8eLdZfq67RRTA5e8VMKA/kl+4zKZjE
         Murw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPSIuUKl40zjMTrFqmrp2gFzjgO0Cf6BRDzGoK+tDWg=;
        b=aBe7wGds4aLadXEYrWDohasphldvkbC68JPNgQaLt0bA/Uo/RkaD3UU6zQmVAEGRV1
         PEB2Vx6oAN3lcITtq7cokwhHyytlpbpHyFDrk9V5x8LuHqsB530qufuRmYiSpp4+PVbg
         qKROv6oz2vmRowxIgXtug9uTHFDJtM+Ioaly9Np0z1PrfBiy9a+XXaOWm//CDwy3Y6wH
         EsoRh4fQEzknlnLXT3QrUxW+KjN+P9rCnAr83gcdIYJKfU6VF+mla43GNMdWNauXCtNi
         C7/Cgo/ZwCdzz8v6E93PMCaHMMciN+uUYMV5B76Z0ZIHOpB98k2b3sYs3scP8jgC+rYS
         zxTw==
X-Gm-Message-State: AGi0PubsiQACw/qL3wkMvx39pxwts52jU1XGMfLJY8Tp+fbl0yUYuF2I
        rd11mYWHQrz2ERE0tzNFgThCPyWEtY3RRvHfLABUmg==
X-Google-Smtp-Source: APiQypK4k05/C2I/yimUeRPIsrYih0ut0hSKIXH2CCGt3+KnrSP6gGhNuIc5dVPg4hLorIO9oSIUzNKPjU1zs0K4BW4=
X-Received: by 2002:a2e:9255:: with SMTP id v21mr11042631ljg.222.1588620243090;
 Mon, 04 May 2020 12:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com> <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
 <20200504141136.GR22838@dhcp22.suse.cz> <CALvZod7Ls7rTDOr5vXwEiPneLqbq3JoxfFBxZZ71YWgvLkNr5A@mail.gmail.com>
 <20200504150052.GT22838@dhcp22.suse.cz> <CALvZod7EeQm-T4dsBddfMY_szYw3m8gRh5R5GfjQiuQAtCocug@mail.gmail.com>
 <20200504160613.GU22838@dhcp22.suse.cz>
In-Reply-To: <20200504160613.GU22838@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 4 May 2020 12:23:51 -0700
Message-ID: <CALvZod79hWns9366B+8ZK2Roz8c+vkdA80HqFNMep56_pumdRQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 4, 2020 at 9:06 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 04-05-20 08:35:57, Shakeel Butt wrote:
> > On Mon, May 4, 2020 at 8:00 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Mon 04-05-20 07:53:01, Shakeel Butt wrote:
> [...]
> > > > I am trying to see if "no eligible task" is really an issue and should
> > > > be warned for the "other use cases". The only real use-case I can
> > > > think of are resource managers adjusting the limit dynamically. I
> > > > don't see "no eligible task" a concerning reason for such use-case.
> > >
> > > It is very much a concerning reason to notify about like any other OOM
> > > situation due to hard limit breach. In this case it is worse in some
> > > sense because the limit cannot be trimmed down because there is no
> > > directly reclaimable memory at all. Such an oom situation is
> > > effectivelly conserved.
> > > --
> >
> > Let me make a more precise statement and tell me if you agree. The "no
> > eligible task" is concerning for the charging path but not for the
> > writer of memory.max. The writer can read the usage and
> > cgroup.[procs|events] to figure out the situation if needed.
>
> I really hate to repeat myself but this is no different from a regular
> oom situation.

Conceptually yes there is no difference but there is no *divine
restriction* to not make a difference if there is a real world
use-case which would benefit from it.

> Admin sets the hard limit and the kernel tries to act
> upon that.
>
> You cannot make any assumption about what admin wanted or didn't want
> to see.

Actually we always make assumptions on how the feature we implement
will be used and as new use-cases come the assumptions evolve.

> We simply trigger the oom killer on memory.max and this is a
> documented behavior. No eligible task or no task at all is a simply a
> corner case

For "sweep before tear down" use-case this is not a corner case.

> when the kernel cannot act and mentions that along with the
> oom report so that whoever consumes that information can debug or act on
> that fact.
>
> Silencing the oom report is simply removing a potentially useful
> aid to debug further a potential problem.

*Potentially* useful for debugging versus actually beneficial for
"sweep before tear down" use-case. Also I am not saying to make "no
dumps for memory.max when no eligible tasks" a set in stone rule. We
can always reevaluate when such information will actually be useful.

Johannes/Andrew, what's your opinion?
