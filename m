Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A643E8F7B
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2019 19:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbfJ2Sro (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Oct 2019 14:47:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:59344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729528AbfJ2Sro (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 29 Oct 2019 14:47:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96353AFF3;
        Tue, 29 Oct 2019 18:47:41 +0000 (UTC)
Date:   Tue, 29 Oct 2019 19:47:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Thelen <gthelen@google.com>,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com,
        elver@google.com
Subject: Re: [PATCH] mm: memcontrol: fix data race in
 mem_cgroup_select_victim_node
Message-ID: <20191029184739.GP31513@dhcp22.suse.cz>
References: <20191029005405.201986-1-shakeelb@google.com>
 <20191029090347.GG31513@dhcp22.suse.cz>
 <CALvZod648GRvjd_LqViFzLRwxnzSrLZzjaNBOJju4xkDQkvrXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod648GRvjd_LqViFzLRwxnzSrLZzjaNBOJju4xkDQkvrXw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 29-10-19 11:09:29, Shakeel Butt wrote:
> +Marco
> 
> On Tue, Oct 29, 2019 at 2:03 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 28-10-19 17:54:05, Shakeel Butt wrote:
> > > Syzbot reported the following bug:
> > >
> > > BUG: KCSAN: data-race in mem_cgroup_select_victim_node / mem_cgroup_select_victim_node
> > >
> > > write to 0xffff88809fade9b0 of 4 bytes by task 8603 on cpu 0:
> > >  mem_cgroup_select_victim_node+0xb5/0x3d0 mm/memcontrol.c:1686
> > >  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
> > >  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
> > >  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
> > >  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
> > >  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
> > >  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
> > >  swapgs_restore_regs_and_return_to_usermode+0x0/0x40
> > >
> > > read to 0xffff88809fade9b0 of 4 bytes by task 7290 on cpu 1:
> > >  mem_cgroup_select_victim_node+0x92/0x3d0 mm/memcontrol.c:1675
> > >  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
> > >  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
> > >  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
> > >  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
> > >  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
> > >  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
> > >  swapgs_restore_regs_and_return_to_usermode+0x0/0x40
> > >
> > > mem_cgroup_select_victim_node() can be called concurrently which reads
> > > and modifies memcg->last_scanned_node without any synchrnonization. So,
> > > read and modify memcg->last_scanned_node with READ_ONCE()/WRITE_ONCE()
> > > to stop potential reordering.
> >
> > I am sorry but I do not understand the problem and the fix. Why does the
> > race happen and why does _ONCE fixes it? There is still no
> > synchronization. Do you want to prevent from memcg->last_scanned_node
> > reloading?
> >
> 
> The problem is memcg->last_scanned_node can read and modified
> concurrently. Though to me it seems like a tolerable race and not
> worth to add an explicit lock.

Agreed

> My aim was to make KCSAN happy here to
> look elsewhere for the concurrency bugs. However I see that it might
> complain next on memcg->scan_nodes.

I would really refrain from adding whatever measure to silence some
tool without a deeper understanding of why that is needed. $FOO_ONCE
will prevent compiler from making funcy stuff. But this is an int and
I would be really surprised if $FOO_ONCE made any practical difference.

> Now taking a step back, I am questioning the whole motivation behind
> mem_cgroup_select_victim_node(). Since we pass ZONELIST_FALLBACK
> zonelist to the reclaimer, the shrink_node will be called for all
> potential nodes. Also we don't short circuit the traversal of
> shrink_node for all nodes on nr_reclaimed and we scan (size_on_node >>
> priority) for all nodes, I don't see the reason behind having round
> robin order of node traversal.
> 
> I am thinking of removing the whole mem_cgroup_select_victim_node()
> heuristic. Please let me know if there are any objections.

I would have to think more about this but this surely sounds like a
preferable way than adding $FOO_ONCE to silence the tool.

Thanks!
-- 
Michal Hocko
SUSE Labs
