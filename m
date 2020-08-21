Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B98124DADA
	for <lists+cgroups@lfdr.de>; Fri, 21 Aug 2020 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgHUQ3H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Aug 2020 12:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgHUQ2Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Aug 2020 12:28:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB64C061755
        for <cgroups@vger.kernel.org>; Fri, 21 Aug 2020 09:28:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g6so2482165ljn.11
        for <cgroups@vger.kernel.org>; Fri, 21 Aug 2020 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASBotJZ8EZpsI/eCx5HlBKysI3NgkGBSfRhPo944ZDA=;
        b=mvQsNqxvDRfKY9x4pIZgEPhlpB930QAuNErYXzNPLu7IhTBgokTUR97DSKDApKmNfS
         cibjePU5QCWO42UFsCRWQwMu/X9Q9pISUETSOyLv8GDQ7qwMEl4Ib/H3WWqJjSRry3xl
         9TU6msunmhJlIGiYjWcVH7a2M3X4BhkWw0G2xvXyrrXNTBchQ9LtnRpmS8/pffU/upUX
         /kFJp8461OeN+P7fP/3Y2HmjrCgDZQYrsQfpcRdb/+ho08gxWAK1CegzesM559po/s7S
         QS3/ic98qpHNV6+NY5HcH0fd2uQX7y1u6cKBRJq2fY9JRNDQP1Z7JMuCbauUj7xPMwgM
         dTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASBotJZ8EZpsI/eCx5HlBKysI3NgkGBSfRhPo944ZDA=;
        b=tNP6+/DzvgswsEt+K7SfbTnSR6cbWdh/Pw/LRQ+rw9L+1eGzaW40/szsT4p8qJasmQ
         zp+dhQjGhLghNVk8wydqzYc3e219sWmg2IbhZQIzAsDQaqzKtu5aTsWTmWKfewAanbAa
         sjeoruHXQATYQQA5tBw8q+B3Yc5cBY/K0dPvdndWWGxUO1dry202bKBAOoDNJTK+Zard
         ysVxW8UehYNc7PGcYt2GNpbo5IJ3cJfCONS6V+z40IVjw7HpoJMA7zs2DubmZw5Sqg7B
         fJFzQxSVqNmeS8pURO0SffQZChQTRiuur3SgPnJLygGXuz/TUDgaJF+/YCmwOrQYdcq7
         7bZQ==
X-Gm-Message-State: AOAM531oax61tLyOSvMIpCJPaYUFYYO3EBnp7Pkjc49LurbiMsmApt9+
        svnT0hvTUOL+Mw0XxdpGguuE2DTLMmqRIGtq4JoCuA==
X-Google-Smtp-Source: ABdhPJxBJx48eP7IauIXH6HjOknwmi0SBAJ//UG77vmKK+pXc4hy+ku162ReCSBX43dsu2Kih9HINa4PcVbhBog5/lU=
X-Received: by 2002:a2e:96c3:: with SMTP id d3mr1932135ljj.270.1598027287929;
 Fri, 21 Aug 2020 09:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200528135444.11508-1-schatzberg.dan@gmail.com>
 <CALvZod655MqFxmzwCf4ZLSh9QU+oLb0HL-Q_yKomh3fb-_W0Vg@mail.gmail.com>
 <20200821150405.GA4137@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com> <20200821160128.GA2233370@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200821160128.GA2233370@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 21 Aug 2020 09:27:56 -0700
Message-ID: <CALvZod69w5UoCjfWcqVAejpKWzRAUxX7dEPzqDUknHhUFV_XEA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Charge loop device i/o to issuing cgroup
To:     Roman Gushchin <guro@fb.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 21, 2020 at 9:02 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Aug 21, 2020 at 11:04:05AM -0400, Dan Schatzberg wrote:
> > On Thu, Aug 20, 2020 at 10:06:44AM -0700, Shakeel Butt wrote:
> > > On Thu, May 28, 2020 at 6:55 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> > > >
> > > > Much of the discussion about this has died down. There's been a
> > > > concern raised that we could generalize infrastructure across loop,
> > > > md, etc. This may be possible, in the future, but it isn't clear to me
> > > > how this would look like. I'm inclined to fix the existing issue with
> > > > loop devices now (this is a problem we hit at FB) and address
> > > > consolidation with other cases if and when those need to be addressed.
> > > >
> > >
> > > What's the status of this series?
> >
> > Thanks for reminding me about this. I haven't got any further
> > feedback. I'll bug Jens to take a look and see if he has any concerns
> > and if not send a rebased version.
>
> Just as a note, I stole a patch from this series called
> "mm: support nesting memalloc_use_memcg()" to use for the bpf memory accounting.
> I rewrote the commit log and rebased to the tot with some trivial changes.
>
> I just sent it upstream:
> https://lore.kernel.org/bpf/20200821150134.2581465-1-guro@fb.com/T/#md7edb6b5b940cee1c4d15e3cef17aa8b07328c2e
>
> It looks like we need it for two independent sub-systems, so I wonder
> if we want to route it first through the mm tree as a standalone patch?
>

Another way is to push that patch to 5.9-rc2 linus tree, so both block
and mm branches for 5.10 will have it. (Not sure if that's ok.)
