Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50450E8F79
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2019 19:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfJ2Sq6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Oct 2019 14:46:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35519 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfJ2Sq6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Oct 2019 14:46:58 -0400
Received: by mail-ot1-f66.google.com with SMTP id z6so10711821otb.2
        for <cgroups@vger.kernel.org>; Tue, 29 Oct 2019 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ReWNXiQSJHk1Ohmt4ko0ZYhBstNAojS1cH/ggSlVoAI=;
        b=Kn3CZE3xBzziKVWaQmk/w5rlpZO2GbLA16umwkgVooj88NX/DmIyNIa6Isn2UqLS3F
         Fm+cD+GDopHSMsxgxlBeiPULD6tNKXBO67r0TMwCr/VOs30OEn5etwD5cMzd76l9ADJv
         bEPEN4IhS26FRzf4+PXqg5MERXrdSITqMRw5E2dC1/uboYjloD56iI96ELRsUrcpxLP5
         yc1s6tD8CjoBQyxKweBAhpoGiE7mzUtYafmLLspCafldR8G622VHkePlx/x8soweCzFX
         PCQ7ktRLpjSRRT04ctRSkLGV/puDZijKegMjGo+KDZNPPwCZYRTuI5e1XHQlrNwIo8QJ
         DbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ReWNXiQSJHk1Ohmt4ko0ZYhBstNAojS1cH/ggSlVoAI=;
        b=hPUA4svo0Szy06sb+RSLqqATGkSZ0fEe2fp8H7YYHpBblgGH1uBH63MOa07zT3J4lU
         SWBINRixbD93vDliX6xKtak8L9GFQFG1gqFTgT3lDJ6G3YhR/O9fKgnNQrwPakRpguB9
         pI1mKnc8YpNpha7QCRJodSoSJgjWVb3x5+6gWH80sBL7H1l8iTX/5engky3va7uNYmih
         rPu0WFGpabaOgj6ytPgm5TQG+5Rj6OIetzLBOK+LoG3EOlmaMWhOh+QYiJ7S3UhcsMjw
         N7I1lTg4aP56EjAer5sLilwp3uSlJtQnnIwTMNI7oZuy4NTWwb/zwVEeuSb2LLxuZtrw
         Jdow==
X-Gm-Message-State: APjAAAU82bLlSA4Yvp6LqQjupjnje9/N7RTdG1N4UMw04/JUsGhTA/HP
        HNFFJcp1i6ZrrKTpkKYJhLyvQJ9M4DgOrfPDxFq0tA==
X-Google-Smtp-Source: APXvYqwoXXMB6jQHL01y3ti03FRq/3phCHL6sPdA/P1ffR5g9Hi0PMIpVSujjn/UUi7eJJGETGQD8n0OnIo+4nmy1DA=
X-Received: by 2002:a05:6830:1e8c:: with SMTP id n12mr4813345otr.360.1572374817658;
 Tue, 29 Oct 2019 11:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191029005405.201986-1-shakeelb@google.com> <20191029090347.GG31513@dhcp22.suse.cz>
 <CALvZod648GRvjd_LqViFzLRwxnzSrLZzjaNBOJju4xkDQkvrXw@mail.gmail.com> <20191029182802.GA193152@google.com>
In-Reply-To: <20191029182802.GA193152@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 29 Oct 2019 11:46:46 -0700
Message-ID: <CALvZod7npAH0okM5HnsR-F6N6EF5eT6sfX-XVusrXVuBgZfh6Q@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix data race in mem_cgroup_select_victim_node
To:     Marco Elver <elver@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Thelen <gthelen@google.com>,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 29, 2019 at 11:28 AM Marco Elver <elver@google.com> wrote:
>
>
>
> On Tue, 29 Oct 2019, Shakeel Butt wrote:
>
> > +Marco
> >
> > On Tue, Oct 29, 2019 at 2:03 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Mon 28-10-19 17:54:05, Shakeel Butt wrote:
> > > > Syzbot reported the following bug:
> > > >
> > > > BUG: KCSAN: data-race in mem_cgroup_select_victim_node / mem_cgroup_select_victim_node
> > > >
> > > > write to 0xffff88809fade9b0 of 4 bytes by task 8603 on cpu 0:
> > > >  mem_cgroup_select_victim_node+0xb5/0x3d0 mm/memcontrol.c:1686
> > > >  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
> > > >  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
> > > >  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
> > > >  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
> > > >  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
> > > >  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
> > > >  swapgs_restore_regs_and_return_to_usermode+0x0/0x40
> > > >
> > > > read to 0xffff88809fade9b0 of 4 bytes by task 7290 on cpu 1:
> > > >  mem_cgroup_select_victim_node+0x92/0x3d0 mm/memcontrol.c:1675
> > > >  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
> > > >  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
> > > >  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
> > > >  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
> > > >  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
> > > >  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
> > > >  swapgs_restore_regs_and_return_to_usermode+0x0/0x40
> > > >
> > > > mem_cgroup_select_victim_node() can be called concurrently which reads
> > > > and modifies memcg->last_scanned_node without any synchrnonization. So,
> > > > read and modify memcg->last_scanned_node with READ_ONCE()/WRITE_ONCE()
> > > > to stop potential reordering.
>
> Strictly speaking, READ_ONCE/WRITE_ONCE alone avoid various bad compiler
> optimizations, including store tearing, load tearing, etc. This does not
> add memory barriers to constrain memory ordering.  (If this code needs
> some memory ordering guarantees w.r.t. previous loads/stores then this
> alone is not enough.)
>
> > > I am sorry but I do not understand the problem and the fix. Why does the
> > > race happen and why does _ONCE fixes it? There is still no
> > > synchronization. Do you want to prevent from memcg->last_scanned_node
> > > reloading?
> > >
> >
> > The problem is memcg->last_scanned_node can read and modified
> > concurrently. Though to me it seems like a tolerable race and not
> > worth to add an explicit lock. My aim was to make KCSAN happy here to
> > look elsewhere for the concurrency bugs. However I see that it might
> > complain next on memcg->scan_nodes.
>
> The plain concurrent reads/writes are a data race, which may manifest in
> various undefined behaviour due to compiler optimizations. The _ONCE
> will prevent these (KCSAN only reports data races).  Note that, "data
> race" does not necessarily imply "race condition"; some data races are
> race conditions (usually the more interesting bugs) -- but not *all*
> data races are race conditions. If there is no race condition here that
> warrants heavier synchronization (locking etc.), then this patch is all
> that should be needed.
>
> I can't comment on the rest.
>

Thanks Marco for the explanation.
