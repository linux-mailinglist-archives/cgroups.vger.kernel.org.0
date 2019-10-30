Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F653EA2CE
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2019 18:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfJ3RxK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Oct 2019 13:53:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:59652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727267AbfJ3RxK (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 30 Oct 2019 13:53:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A713AACEF;
        Wed, 30 Oct 2019 17:53:08 +0000 (UTC)
Date:   Wed, 30 Oct 2019 18:53:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm: vmscan: memcontrol: remove
 mem_cgroup_select_victim_node()
Message-ID: <20191030175302.GM31513@dhcp22.suse.cz>
References: <20191029234753.224143-1-shakeelb@google.com>
 <20191030174455.GA45135@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030174455.GA45135@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 30-10-19 13:44:55, Johannes Weiner wrote:
> On Tue, Oct 29, 2019 at 04:47:53PM -0700, Shakeel Butt wrote:
> > Since commit 1ba6fc9af35b ("mm: vmscan: do not share cgroup iteration
> > between reclaimers"), the memcg reclaim does not bail out earlier based
> > on sc->nr_reclaimed and will traverse all the nodes. All the reclaimable
> > pages of the memcg on all the nodes will be scanned relative to the
> > reclaim priority. So, there is no need to maintain state regarding which
> > node to start the memcg reclaim from. Also KCSAN complains data races in
> > the code maintaining the state.
> > 
> > This patch effectively reverts the commit 889976dbcb12 ("memcg: reclaim
> > memory from nodes in round-robin order") and the commit 453a9bf347f1
> > ("memcg: fix numa scan information update to be triggered by memory
> > event").
> > 
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > Reported-by: <syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com>
> 
> Excellent, thanks Shakeel!
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Just a request on this bit:
> 
> > @@ -3360,16 +3358,9 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> >  		.may_unmap = 1,
> >  		.may_swap = may_swap,
> >  	};
> > +	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
> >  
> >  	set_task_reclaim_state(current, &sc.reclaim_state);
> > -	/*
> > -	 * Unlike direct reclaim via alloc_pages(), memcg's reclaim doesn't
> > -	 * take care of from where we get pages. So the node where we start the
> > -	 * scan does not need to be the current node.
> > -	 */
> > -	nid = mem_cgroup_select_victim_node(memcg);
> > -
> > -	zonelist = &NODE_DATA(nid)->node_zonelists[ZONELIST_FALLBACK];
> 
> This works, but it *is* somewhat fragile if we decide to add bail-out
> conditions to reclaim again. And some numa nodes receiving slightly
> less pressure than others could be quite tricky to debug.
> 
> Can we add a comment here that points out the assumption that the
> zonelist walk is comprehensive, and that all nodes receive equal
> reclaim pressure?

Makes sense
 
> Also, I think we should use sc.gfp_mask & ~__GFP_THISNODE, so that
> allocations with a physical node preference still do node-agnostic
> reclaim for the purpose of cgroup accounting.

Do not we exclude that by GFP_RECLAIM_MASK already?

-- 
Michal Hocko
SUSE Labs
