Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F3839B6DA
	for <lists+cgroups@lfdr.de>; Fri,  4 Jun 2021 12:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhFDKRN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Jun 2021 06:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFDKRN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Jun 2021 06:17:13 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A680C06174A
        for <cgroups@vger.kernel.org>; Fri,  4 Jun 2021 03:15:14 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id z3so9260418oib.5
        for <cgroups@vger.kernel.org>; Fri, 04 Jun 2021 03:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXNZFynTVd7Tj+4yCTxPtCHUxkYVTA9YmlhLOcTv9i4=;
        b=dEDQHphBkeNVUUe/39lXpjzvRnF/sgMO3KCzRZcCyvEN5dcy6fameRkVnBdx5YMW9D
         F6S17iSrJMCDdY4PEat3HygCOzxMJQUYE/xZ2V/31MxzglUH8ATcba4Wj7BCxrlk3/jQ
         4lyIvJ8ao3l5q7NZQ0+z3C75iW9wobbdtOaZMNvT5RZUZHHiJbfREJoKWO8l8fdtUoNj
         0e8htveobhzcJ9iNG7nf6DYSY1sLMYNsnMcKkmxFHcMAdf6vUFLNau2pGGAjLegxisJQ
         K6Ai+UdGN9nQ8bh2lXQnzZaqMyDvE74QJXHgzVIbAcJsNQSFQ6Gh57SZPaBHxS/KBBxr
         fRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXNZFynTVd7Tj+4yCTxPtCHUxkYVTA9YmlhLOcTv9i4=;
        b=L8Uwc0oBLjK3ZG4jRLtCT/vR4HWysLrftYfbzYLvn8Ut006W5/jAVZVGVVZusu5Rgk
         PZFt2h+KMTK+aIgJPR7wK/vPIJAUU5Y1II2sPLFYVzxUjqEHX6QDFpGWcbQzc18z45wu
         WY+N0HqS3jEyxDmYo5MJXWHVTAmQ3hT3n/Latx9ETb4BW4phhe80/3Dsgzia9r7W+nDt
         zV26Z24IQpqpMkq5cHNADFuX4O6INDjhLVsdOy8w7DePnXUoVQoUDVH0j89KNZUMkOxg
         c6pMeVCePIE9BHzJhhK1p9yc+KAn1bfAZqpZcSy6/mOXczEnmS1TtUSiR9qi+29JL7fo
         d6dA==
X-Gm-Message-State: AOAM5333Ps5A7qxizYO4JggPPq0lleEuv369c8ocbdX3c0U0udDW9q53
        bkNGm9qy04ngGOHWkecCGvW+17TvIEi0TeYtrwM=
X-Google-Smtp-Source: ABdhPJwJ/Emo2MVhtgktwC7wSZnmnR53U7Rv0ZOTYYt25aE++p9ooPfh+CjDF6KsRnp+bIFL9TztPhrgAo2P9GvcIfI=
X-Received: by 2002:a05:6808:10d6:: with SMTP id s22mr10466980ois.96.1622801713604;
 Fri, 04 Jun 2021 03:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622043596.git.yuleixzhang@tencent.com> <CALvZod4SoCS6ym8ELTxWd6UwzUp8m_UUdw7oApAhW2WRq0BXqw@mail.gmail.com>
 <CACZOiM3VhYyzCTx4FbW=FF8WB=X46xaV53abqOVL+eHQOs8Reg@mail.gmail.com>
 <YLZIBpJFkKNBCg2X@chrisdown.name> <CACZOiM21STLrZgcnEwm8w2t82Qj3Ohy-BGbD5u62gTn=z4X3Lw@mail.gmail.com>
 <CALvZod7w1tzxvYCP54KHEo=k=qUd02UTkr+1+b5rTdn-tJt45w@mail.gmail.com>
 <CACZOiM3g6GhJgXurMPeE3A7zO8eUhoUPyUvyT3p2Kw98WkX8+g@mail.gmail.com> <YLi/UeS71mk12VZ3@chrisdown.name>
In-Reply-To: <YLi/UeS71mk12VZ3@chrisdown.name>
From:   yulei zhang <yulei.kernel@gmail.com>
Date:   Fri, 4 Jun 2021 18:15:02 +0800
Message-ID: <CACZOiM03toiqcbtEd8LT26T2GtPsDaFj89o8rjEfELTw=KPvfg@mail.gmail.com>
Subject: Re: [RFC 0/7] Introduce memory allocation speed throttle in memcg
To:     Chris Down <chris@chrisdown.name>
Cc:     Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <christian@brauner.io>,
        Cgroups <cgroups@vger.kernel.org>, benbjiang@tencent.com,
        Wanpeng Li <kernellwp@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 3, 2021 at 7:38 PM Chris Down <chris@chrisdown.name> wrote:
>
> yulei zhang writes:
> >Thanks. IMHO, there are differences between these two throttlings.
> >memory.high is a per-memcg throttle which targets to limit the memory
> >usage of the tasks in the cgroup. For the memory allocation speed throttle(MST),
> >the purpose is to avoid the memory burst in cgroup which would trigger
> >the global reclaim and affects the timing sensitive workloads in other cgroup.
> >For example, we have two pods with memory overcommit enabled, one includes
> >online tasks and the other has offline tasks, if we restrict the memory usage of
> >the offline pod with memory.high, it will lose the benefit of memory overcommit
> >when the other workloads are idle. On the other hand, if we don't
> >limit the memory
> >usage, it will easily break the system watermark when there suddenly has massive
> >memory operations. If enable MST in this case, we will be able to
> >avoid the direct
> >reclaim and leverage the overcommit.
>
> Having a speed throttle is a very primitive knob: it's hard to know what the
> correct values are for a user. That's one of the reasons why we've moved away
> from that kind of tunable for blkio.
>
> Ultimately, if you want work-conserving behaviour, why not use memory.low?

Thanks. But currently low and high are for cgroup v2 setting, do you
think we'd better
extend the same mechanism to cgroup v1?
