Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 669CFE8F5A
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2019 19:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfJ2Seb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Oct 2019 14:34:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42272 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfJ2Seb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Oct 2019 14:34:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so15043052qts.9
        for <cgroups@vger.kernel.org>; Tue, 29 Oct 2019 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uIU7OLCPQwf11UO7remUH85e2MdSUd0Df/No5kThl+Q=;
        b=xUtlmgfTX/z8VFSs9NdfjYD2h7uC3bxMX9c2AFApAHuLU7LT6V7ubs5uXk74wKkkx/
         PJ2uLnbqAvx+8TOq/4JkQXCvAYH/t2uV1hkfDxQQv4ceHZH7Ta/AjZmchGgfTanNnlp5
         NtrxxujwR8dWyTNdCfJSiSCza6w//XxLj2TpNNhUvb8PYNxuf7QXmDzvi7i+ppvNcF2G
         Y//gF7lM27cJmeZ9XiwN2vLDy0qpLyjKuI6ydePXHTokzd0Wa9uzNwMCIAebJUNtY7e4
         mo4P1zqBlD5wVxm/X3fGz8j9J9XPnHJRFFY3NYkb+aB0UfDSVhLMAK8uAJiD1a1xHjlm
         xwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uIU7OLCPQwf11UO7remUH85e2MdSUd0Df/No5kThl+Q=;
        b=JaxV1o1+RaSosQpDXvbcmdG4BHi64NDHtmpu6C7ZhxHTe61tDyOyKn8JgOb1asa5jb
         6uJ8d5fTawwl4+ybuRcFwM1yQSqRERpdCfG+lxGeylrttsCQp2OoAahd13YTVPdP/66X
         b8uDIb93gyprkiz2GMQAhCEMAhyDtNrA++vvTA5ruu6cJf37YtAbxv9uf9G2qu+s8icu
         KipRnBxVKHdMMNwlU+WYlkh5mB2QkWCgtRPytsyFeugkbatoO+C4kKj1mslISWlLZJyw
         1w7SfoybABXNS9cmZ8Fur45rIuiiAYRD1t8FCKSPlQQJLFUmS0r2lfsLhLLkyzrAFZOQ
         kEkA==
X-Gm-Message-State: APjAAAVLze2LNAHXefoTSxrRDxyBnc+/5D5mwqS6lWLgw/2ZASdJnJwe
        /u32WofZPo9+vMmqLKCQUXQ3iw==
X-Google-Smtp-Source: APXvYqz9kg4EYQY0RLUVbwPGIGxrPWbJ4IxQP3b9gI4g2nGc6loAjVWiGAcg76RCo1vI30uYda0BWw==
X-Received: by 2002:a05:6214:803:: with SMTP id df3mr24777703qvb.215.1572374070331;
        Tue, 29 Oct 2019 11:34:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::7081])
        by smtp.gmail.com with ESMTPSA id g25sm9088353qtc.90.2019.10.29.11.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 11:34:29 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:34:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
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
Message-ID: <20191029183428.GA38233@cmpxchg.org>
References: <20191029005405.201986-1-shakeelb@google.com>
 <20191029090347.GG31513@dhcp22.suse.cz>
 <CALvZod648GRvjd_LqViFzLRwxnzSrLZzjaNBOJju4xkDQkvrXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod648GRvjd_LqViFzLRwxnzSrLZzjaNBOJju4xkDQkvrXw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 29, 2019 at 11:09:29AM -0700, Shakeel Butt wrote:
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
> worth to add an explicit lock. My aim was to make KCSAN happy here to
> look elsewhere for the concurrency bugs. However I see that it might
> complain next on memcg->scan_nodes.
> 
> Now taking a step back, I am questioning the whole motivation behind
> mem_cgroup_select_victim_node(). Since we pass ZONELIST_FALLBACK
> zonelist to the reclaimer, the shrink_node will be called for all
> potential nodes. Also we don't short circuit the traversal of
> shrink_node for all nodes on nr_reclaimed and we scan (size_on_node >>
> priority) for all nodes, I don't see the reason behind having round
> robin order of node traversal.

It's actually only very recently that we don't bail out of the reclaim
loop anymore - if I'm not missing anything, it was only 1ba6fc9af35b
("mm: vmscan: do not share cgroup iteration between reclaimers") that
removed the last bailout condition on sc->nr_reclaimed.

> I am thinking of removing the whole mem_cgroup_select_victim_node()
> heuristic. Please let me know if there are any objections.

In the current state, I don't see any reason to keep it, either. We
can always just start the zonelist walk from the current node.

A nice cleanup, actually. Good catch!
