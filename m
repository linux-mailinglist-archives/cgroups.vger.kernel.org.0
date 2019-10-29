Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 204CCE8F01
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2019 19:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbfJ2SJn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Oct 2019 14:09:43 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36267 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfJ2SJm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Oct 2019 14:09:42 -0400
Received: by mail-oi1-f193.google.com with SMTP id j7so9743104oib.3
        for <cgroups@vger.kernel.org>; Tue, 29 Oct 2019 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjPIA2E/5Fq521b+ML0SLUvafFSbqxin1BmVqwTUyt8=;
        b=GEgloQHTa6D4+gvI9CNAFRP6KGQEIM5wYH9xmQxYFJxfmoN/S3HWvbO9fc4WkqwO8K
         MG7DPxKv6o190npOhAGGHq3gCmMduti7dve9KfbZB2DfW36Cuq4+A1E7qa9lGiGGpeP9
         7c3IlpH2WU+nd0YxdB7l0cCemIePL2VcRnTvilGoBfIzq/WNuOI+XckME9mhWzF6B8SQ
         sMHJ5zTJyG6lFU+MIp78cZLi9LgZGLJuBMm8KE6loBZqSPX+OG1Wk01Ac9awzUC9hH9s
         GXfrdcRAhmPUrh/5C6lfXiyTDhZd3J+C3rphT1vV0JR6Zx0HuunJMzyrHMeDp8ZScoWY
         sehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjPIA2E/5Fq521b+ML0SLUvafFSbqxin1BmVqwTUyt8=;
        b=MismboFj7Ht88WH24gURSLELh6DCWoc7LEXkigUV7iEhsN4UqMRA+W9ffB664UKKcm
         5obyljz9ACPUJCyKFmjMsFqkLvBeYX3xLXsGTU+QPg6AAYuobgYHLgqfFuBAjAHnwHq2
         RE0d8BvX95JN/r/3H1OcaNPnegWvCzUnnFdi3w7yz/Nj8vT8fxbW5N5SiLzrM3yzzzfi
         CZ1HFGxl4iQ4F7iUNNzrAcJCVjApFFOJAcx82Bp1rfICxHT2ab4ld70UXhXRCoz7QgZv
         TgEEgZWNNcEPLYOr/NxNNr1mVS+hW66/FMC2AyJo8DfnFVRTf0ysrneuYrSWATE7QCNp
         rTrQ==
X-Gm-Message-State: APjAAAXJetoHud5m3P9Sag/RN1r0Wmd5j90RcqwEFG7iSzRZhFI69qFh
        PHeAudXIHxwrdBgFjQruHvuwkXcJVHJGpILSGbNgtA==
X-Google-Smtp-Source: APXvYqxf+4np1mY9GDrvb3MwI60Z5G648uXhlHqOf9rZZpiCD5i1uBsR6EE+QlrYh1JGuYcUnXUvq7Z+5wJWCE2URVE=
X-Received: by 2002:aca:7516:: with SMTP id q22mr5083282oic.144.1572372580060;
 Tue, 29 Oct 2019 11:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191029005405.201986-1-shakeelb@google.com> <20191029090347.GG31513@dhcp22.suse.cz>
In-Reply-To: <20191029090347.GG31513@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 29 Oct 2019 11:09:29 -0700
Message-ID: <CALvZod648GRvjd_LqViFzLRwxnzSrLZzjaNBOJju4xkDQkvrXw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix data race in mem_cgroup_select_victim_node
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Thelen <gthelen@google.com>,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com,
        elver@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+Marco

On Tue, Oct 29, 2019 at 2:03 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 28-10-19 17:54:05, Shakeel Butt wrote:
> > Syzbot reported the following bug:
> >
> > BUG: KCSAN: data-race in mem_cgroup_select_victim_node / mem_cgroup_select_victim_node
> >
> > write to 0xffff88809fade9b0 of 4 bytes by task 8603 on cpu 0:
> >  mem_cgroup_select_victim_node+0xb5/0x3d0 mm/memcontrol.c:1686
> >  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
> >  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
> >  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
> >  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
> >  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
> >  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
> >  swapgs_restore_regs_and_return_to_usermode+0x0/0x40
> >
> > read to 0xffff88809fade9b0 of 4 bytes by task 7290 on cpu 1:
> >  mem_cgroup_select_victim_node+0x92/0x3d0 mm/memcontrol.c:1675
> >  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
> >  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
> >  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
> >  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
> >  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
> >  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
> >  swapgs_restore_regs_and_return_to_usermode+0x0/0x40
> >
> > mem_cgroup_select_victim_node() can be called concurrently which reads
> > and modifies memcg->last_scanned_node without any synchrnonization. So,
> > read and modify memcg->last_scanned_node with READ_ONCE()/WRITE_ONCE()
> > to stop potential reordering.
>
> I am sorry but I do not understand the problem and the fix. Why does the
> race happen and why does _ONCE fixes it? There is still no
> synchronization. Do you want to prevent from memcg->last_scanned_node
> reloading?
>

The problem is memcg->last_scanned_node can read and modified
concurrently. Though to me it seems like a tolerable race and not
worth to add an explicit lock. My aim was to make KCSAN happy here to
look elsewhere for the concurrency bugs. However I see that it might
complain next on memcg->scan_nodes.

Now taking a step back, I am questioning the whole motivation behind
mem_cgroup_select_victim_node(). Since we pass ZONELIST_FALLBACK
zonelist to the reclaimer, the shrink_node will be called for all
potential nodes. Also we don't short circuit the traversal of
shrink_node for all nodes on nr_reclaimed and we scan (size_on_node >>
priority) for all nodes, I don't see the reason behind having round
robin order of node traversal.

I am thinking of removing the whole mem_cgroup_select_victim_node()
heuristic. Please let me know if there are any objections.

thanks,
Shakeel
