Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F70E77720
	for <lists+cgroups@lfdr.de>; Sat, 27 Jul 2019 08:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfG0GAY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Jul 2019 02:00:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:18229 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726806AbfG0GAX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Jul 2019 02:00:23 -0400
X-UUID: 1eea9145784f470d9884114190e9f9bb-20190727
X-UUID: 1eea9145784f470d9884114190e9f9bb-20190727
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1416853248; Sat, 27 Jul 2019 14:00:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 27 Jul 2019 14:00:10 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 27 Jul 2019 14:00:10 +0800
Message-ID: <1564207210.19817.9.camel@mtkswgap22>
Subject: Re: [PATCH v2] mm: memcontrol: fix use after free in
 mem_cgroup_iter()
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Sat, 27 Jul 2019 14:00:10 +0800
In-Reply-To: <1564184878.19817.5.camel@mtkswgap22>
References: <20190726021247.16162-1-miles.chen@mediatek.com>
         <20190726124933.GN6142@dhcp22.suse.cz>
         <20190726125533.GO6142@dhcp22.suse.cz>
         <1564184878.19817.5.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, 2019-07-27 at 07:47 +0800, Miles Chen wrote:
> On Fri, 2019-07-26 at 14:55 +0200, Michal Hocko wrote:
> > On Fri 26-07-19 14:49:33, Michal Hocko wrote:
> > > On Fri 26-07-19 10:12:47, Miles Chen wrote:
> > > > This patch is sent to report an use after free in mem_cgroup_iter()
> > > > after merging commit: be2657752e9e "mm: memcg: fix use after free in
> > > > mem_cgroup_iter()".
> > > > 
> > > > I work with android kernel tree (4.9 & 4.14), and the commit:
> > > > be2657752e9e "mm: memcg: fix use after free in mem_cgroup_iter()" has
> > > > been merged to the trees. However, I can still observe use after free
> > > > issues addressed in the commit be2657752e9e.
> > > > (on low-end devices, a few times this month)
> > > > 
> > > > backtrace:
> > > > 	css_tryget <- crash here
> > > > 	mem_cgroup_iter
> > > > 	shrink_node
> > > > 	shrink_zones
> > > > 	do_try_to_free_pages
> > > > 	try_to_free_pages
> > > > 	__perform_reclaim
> > > > 	__alloc_pages_direct_reclaim
> > > > 	__alloc_pages_slowpath
> > > > 	__alloc_pages_nodemask
> > > > 
> > > > To debug, I poisoned mem_cgroup before freeing it:
> > > > 
> > > > static void __mem_cgroup_free(struct mem_cgroup *memcg)
> > > > 	for_each_node(node)
> > > > 	free_mem_cgroup_per_node_info(memcg, node);
> > > > 	free_percpu(memcg->stat);
> > > > +       /* poison memcg before freeing it */
> > > > +       memset(memcg, 0x78, sizeof(struct mem_cgroup));
> > > > 	kfree(memcg);
> > > > }
> > > > 
> > > > The coredump shows the position=0xdbbc2a00 is freed.
> > > > 
> > > > (gdb) p/x ((struct mem_cgroup_per_node *)0xe5009e00)->iter[8]
> > > > $13 = {position = 0xdbbc2a00, generation = 0x2efd}
> > > > 
> > > > 0xdbbc2a00:     0xdbbc2e00      0x00000000      0xdbbc2800      0x00000100
> > > > 0xdbbc2a10:     0x00000200      0x78787878      0x00026218      0x00000000
> > > > 0xdbbc2a20:     0xdcad6000      0x00000001      0x78787800      0x00000000
> > > > 0xdbbc2a30:     0x78780000      0x00000000      0x0068fb84      0x78787878
> > > > 0xdbbc2a40:     0x78787878      0x78787878      0x78787878      0xe3fa5cc0
> > > > 0xdbbc2a50:     0x78787878      0x78787878      0x00000000      0x00000000
> > > > 0xdbbc2a60:     0x00000000      0x00000000      0x00000000      0x00000000
> > > > 0xdbbc2a70:     0x00000000      0x00000000      0x00000000      0x00000000
> > > > 0xdbbc2a80:     0x00000000      0x00000000      0x00000000      0x00000000
> > > > 0xdbbc2a90:     0x00000001      0x00000000      0x00000000      0x00100000
> > > > 0xdbbc2aa0:     0x00000001      0xdbbc2ac8      0x00000000      0x00000000
> > > > 0xdbbc2ab0:     0x00000000      0x00000000      0x00000000      0x00000000
> > > > 0xdbbc2ac0:     0x00000000      0x00000000      0xe5b02618      0x00001000
> > > > 0xdbbc2ad0:     0x00000000      0x78787878      0x78787878      0x78787878
> > > > 0xdbbc2ae0:     0x78787878      0x78787878      0x78787878      0x78787878
> > > > 0xdbbc2af0:     0x78787878      0x78787878      0x78787878      0x78787878
> > > > 0xdbbc2b00:     0x78787878      0x78787878      0x78787878      0x78787878
> > > > 0xdbbc2b10:     0x78787878      0x78787878      0x78787878      0x78787878
> > > > 0xdbbc2b20:     0x78787878      0x78787878      0x78787878      0x78787878
> > > > 0xdbbc2b30:     0x78787878      0x78787878      0x78787878      0x78787878
> > > > 0xdbbc2b40:     0x78787878      0x78787878      0x78787878      0x78787878
> > > > 0xdbbc2b50:     0x78787878      0x78787878      0x78787878      0x78787878
> > > > 0xdbbc2b60:     0x78787878      0x78787878      0x78787878      0x78787878
> > > > 0xdbbc2b70:     0x78787878      0x78787878      0x78787878      0x78787878
> > > > 0xdbbc2b80:     0x78787878      0x78787878      0x00000000      0x78787878
> > > > 0xdbbc2b90:     0x78787878      0x78787878      0x78787878      0x78787878
> > > > 0xdbbc2ba0:     0x78787878      0x78787878      0x78787878      0x78787878
> > > > 
> > > > In the reclaim path, try_to_free_pages() does not setup
> > > > sc.target_mem_cgroup and sc is passed to do_try_to_free_pages(), ...,
> > > > shrink_node().
> > > > 
> > > > In mem_cgroup_iter(), root is set to root_mem_cgroup because
> > > > sc->target_mem_cgroup is NULL.
> > > > It is possible to assign a memcg to root_mem_cgroup.nodeinfo.iter in
> > > > mem_cgroup_iter().
> > > > 
> > > > 	try_to_free_pages
> > > > 		struct scan_control sc = {...}, target_mem_cgroup is 0x0;
> > > > 	do_try_to_free_pages
> > > > 	shrink_zones
> > > > 	shrink_node
> > > > 		 mem_cgroup *root = sc->target_mem_cgroup;
> > > > 		 memcg = mem_cgroup_iter(root, NULL, &reclaim);
> > > > 	mem_cgroup_iter()
> > > > 		if (!root)
> > > > 			root = root_mem_cgroup;
> > > > 		...
> > > > 
> > > > 		css = css_next_descendant_pre(css, &root->css);
> > > > 		memcg = mem_cgroup_from_css(css);
> > > > 		cmpxchg(&iter->position, pos, memcg);
> > > > 
> > > > My device uses memcg non-hierarchical mode.
> > > > When we release a memcg: invalidate_reclaim_iterators() reaches only
> > > > dead_memcg and its parents. If non-hierarchical mode is used,
> > > > invalidate_reclaim_iterators() never reaches root_mem_cgroup.
> > > > 
> > > > static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
> > > > {
> > > > 	struct mem_cgroup *memcg = dead_memcg;
> > > > 
> > > > 	for (; memcg; memcg = parent_mem_cgroup(memcg)
> > > > 	...
> > > > }
> > > > 
> > > > So the use after free scenario looks like:
> > > > 
> > > > CPU1						CPU2
> > > > 
> > > > try_to_free_pages
> > > > do_try_to_free_pages
> > > > shrink_zones
> > > > shrink_node
> > > > mem_cgroup_iter()
> > > >     if (!root)
> > > >     	root = root_mem_cgroup;
> > > >     ...
> > > >     css = css_next_descendant_pre(css, &root->css);
> > > >     memcg = mem_cgroup_from_css(css);
> > > >     cmpxchg(&iter->position, pos, memcg);
> > > > 
> > > > 					invalidate_reclaim_iterators(memcg);
> > > > 					...
> > > > 					__mem_cgroup_free()
> > > > 						kfree(memcg);
> > > > 
> > > > try_to_free_pages
> > > > do_try_to_free_pages
> > > > shrink_zones
> > > > shrink_node
> > > > mem_cgroup_iter()
> > > >     if (!root)
> > > >     	root = root_mem_cgroup;
> > > >     ...
> > > >     mz = mem_cgroup_nodeinfo(root, reclaim->pgdat->node_id);
> > > >     iter = &mz->iter[reclaim->priority];
> > > >     pos = READ_ONCE(iter->position);
> > > >     css_tryget(&pos->css) <- use after free
> > > 
> > > Thanks for the write up. This is really useful.
> > > 
> > > > To avoid this, we should also invalidate root_mem_cgroup.nodeinfo.iter in
> > > > invalidate_reclaim_iterators().
> > > 
> > > I am sorry, I didn't get to comment an earlier version but I am
> > > wondering whether it makes more sense to do and explicit invalidation.
> > > 
> 
> I think we should keep the original v2 version, the reason is the 
> !use_hierarchy does not imply we can reach root_mem_cgroup:

Sorry I want to correct myself:

(dead_memcg->use_hierarchy == true) does not guarantee that we can
reach root_mem_cgroup by parent_mem_cgroup(dead_memcg)

> cd /sys/fs/cgroup/memory/0
> mkdir 1
> cd /sys/fs/cgroup/memory/0/1
> echo 1 > memory.use_hierarchy // only 1 and its children has
> use_hierarchy set
> mkdir 2
> 
> rmdir 2 // parent_mem_cgroup(2) goes up to 1
> 
> > > [...]
> > > > +static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
> > > > +{
> > > > +	struct mem_cgroup *memcg = dead_memcg;
> > > > +	int invalidate_root = 0;
> > > > +
> > > > +	for (; memcg; memcg = parent_mem_cgroup(memcg))
> > > > +		__invalidate_reclaim_iterators(memcg, dead_memcg);
> > > 
> > > 	/* here goes your comment */
> > > 	if (!dead_memcg->use_hierarchy)
> > > 		__invalidate_reclaim_iterators(root_mem_cgroup,	dead_memcg);
> > > > +
> > > > +}
> > > 
> > > Other than that the patch looks good to me.
> > > 
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > Btw. I believe we want to push this to stable trees as well. I think it
> > goes all the way down to 5ac8fb31ad2e ("mm: memcontrol: convert reclaim
> > iterator to simple css refcounting"). Unless I am missing something a
> > Fixes: tag would be really helpful.
> 
> No problem. I'll add the fix tag to patch v3.
> Fixes: 5ac8fb31ad2e ("mm: memcontrol: convert reclaim iterator to simple
> css refcounting")
> 
> 
> Miles
> 
> 


