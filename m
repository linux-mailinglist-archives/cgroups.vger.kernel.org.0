Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0C5399ED7
	for <lists+cgroups@lfdr.de>; Thu,  3 Jun 2021 12:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFCKVW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Jun 2021 06:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFCKVW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Jun 2021 06:21:22 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DADC06174A
        for <cgroups@vger.kernel.org>; Thu,  3 Jun 2021 03:19:30 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id h15-20020a4ad00f0000b0290245a068aae6so1268430oor.12
        for <cgroups@vger.kernel.org>; Thu, 03 Jun 2021 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6RNWFHjnK95WvTFB33SdSxX9jSbolNBF1nLUGKTdCNQ=;
        b=jF+aXbEyX05XO3P7/FYCOozuLw09MHxAlxMp9y0xUT5WS5Sl5zBKk6ndg8Dzvmwxn4
         0R0MrBJrEkfpDnnEMEUCH66SjMuvRwBvxCI62/0C19KDtXmexOMCXpS5cDpbT90O9jep
         87qA24eUczfRMT6kiKYDCFb39Kw29iLJzn8k5O36SR4j/NQq0ODZlwj27jWfyqqldqz2
         hNGkhrLTf7bplojEx5pTL+HDi6NZsJcJ+WMCX5LSLz/osvmuGaZ4+/eOQKqvDuURYX36
         f0iSR6wNaH62+K8S4DpimTW/uDPObdY+Q2mxWIq5JN9taHqJcnl8uqJjj364DLaE47FS
         IWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RNWFHjnK95WvTFB33SdSxX9jSbolNBF1nLUGKTdCNQ=;
        b=CIcKCuDIzmFKSgL4sw6aFR0dLgueE08k0zav7jDT1RAgXaD12fzUGkE28uS5Ir61VF
         JZ8twcFb6+iwU7W/xnn9Wi3r5gfez6yXBC07FYOz3eo6Rq/HzugWbnl3AoQcav2/U8Pf
         c+HESS4PSMZgwD6IozboQUXnFmoiQEkljrOolYwkfIdyEjSqpjJJ3pZWMRZSkT7li/dI
         nWJUll/EXYIptE3o5Hb5XRMTJamRZnYfzTIpD5q47ztWgdbhp7iaS095lCJxi7N8eoMa
         Caqj4DiiNLcRc7PGtrnYkFkZtutV9pWi/ALPlKqohGzyB6Gh+sUeGSxIMCmKopi/Tz0u
         JPTw==
X-Gm-Message-State: AOAM532tpk00WfVJq4fsv+UKlMWS4xDOBjeaxsKC2ywVT+jaaK/ot2nn
        +lCDx9XeqiCXJuM5741TXYm5dhn41p4iKa6RtFg=
X-Google-Smtp-Source: ABdhPJwN/tOwGpC5wSWtYlXgOnnJkF2W9Km3j1z8KbXFDVx6wWD8nLUiyptTx2t52cwoYrEJvMLxc4wNaXiEXI540bY=
X-Received: by 2002:a4a:d4c7:: with SMTP id r7mr28522472oos.85.1622715569622;
 Thu, 03 Jun 2021 03:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622043596.git.yuleixzhang@tencent.com> <CALvZod4SoCS6ym8ELTxWd6UwzUp8m_UUdw7oApAhW2WRq0BXqw@mail.gmail.com>
 <CACZOiM3VhYyzCTx4FbW=FF8WB=X46xaV53abqOVL+eHQOs8Reg@mail.gmail.com>
 <YLZIBpJFkKNBCg2X@chrisdown.name> <CACZOiM21STLrZgcnEwm8w2t82Qj3Ohy-BGbD5u62gTn=z4X3Lw@mail.gmail.com>
 <CALvZod7w1tzxvYCP54KHEo=k=qUd02UTkr+1+b5rTdn-tJt45w@mail.gmail.com>
In-Reply-To: <CALvZod7w1tzxvYCP54KHEo=k=qUd02UTkr+1+b5rTdn-tJt45w@mail.gmail.com>
From:   yulei zhang <yulei.kernel@gmail.com>
Date:   Thu, 3 Jun 2021 18:19:18 +0800
Message-ID: <CACZOiM3g6GhJgXurMPeE3A7zO8eUhoUPyUvyT3p2Kw98WkX8+g@mail.gmail.com>
Subject: Re: [RFC 0/7] Introduce memory allocation speed throttle in memcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
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

On Wed, Jun 2, 2021 at 11:39 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Jun 2, 2021 at 2:11 AM yulei zhang <yulei.kernel@gmail.com> wrote:
> >
> > On Tue, Jun 1, 2021 at 10:45 PM Chris Down <chris@chrisdown.name> wrote:
> > >
> > > yulei zhang writes:
> > > >Yep, dynamically adjust the memory.high limits can ease the memory pressure
> > > >and postpone the global reclaim, but it can easily trigger the oom in
> > > >the cgroups,
> > >
> > > To go further on Shakeel's point, which I agree with, memory.high should
> > > _never_ result in memcg OOM. Even if the limit is breached dramatically, we
> > > don't OOM the cgroup. If you have a demonstration of memory.high resulting in
> > > cgroup-level OOM kills in recent kernels, then that needs to be provided. :-)
> >
> > You are right, I mistook it for max. Shakeel means the throttling
> > during context switch
> > which uses memory.high as threshold to calculate the sleep time.
> > Currently it only applies
> > to cgroupv2.  In this patchset we explore another idea to throttle the
> > memory usage, which
> > rely on setting an average allocation speed in memcg. We hope to
> > suppress the memory
> > usage in low priority cgroups when it reaches the system watermark and
> > still keep the activities
> > alive.
>
> I think you need to make the case: why should we add one more form of
> throttling? Basically why memory.high is not good for your use-case
> and the proposed solution works better. Though IMO it would be a hard
> sell.

Thanks. IMHO, there are differences between these two throttlings.
memory.high is a per-memcg throttle which targets to limit the memory
usage of the tasks in the cgroup. For the memory allocation speed throttle(MST),
the purpose is to avoid the memory burst in cgroup which would trigger
the global reclaim and affects the timing sensitive workloads in other cgroup.
For example, we have two pods with memory overcommit enabled, one includes
online tasks and the other has offline tasks, if we restrict the memory usage of
the offline pod with memory.high, it will lose the benefit of memory overcommit
when the other workloads are idle. On the other hand, if we don't
limit the memory
usage, it will easily break the system watermark when there suddenly has massive
memory operations. If enable MST in this case, we will be able to
avoid the direct
reclaim and leverage the overcommit.
.
