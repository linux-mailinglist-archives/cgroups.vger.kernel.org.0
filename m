Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4079E19
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2019 03:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbfG3Bsc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jul 2019 21:48:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37599 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730720AbfG3Bsc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jul 2019 21:48:32 -0400
X-UUID: 51f1828c0eb2432fbabe60239d3037f1-20190730
X-UUID: 51f1828c0eb2432fbabe60239d3037f1-20190730
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 959242115; Tue, 30 Jul 2019 09:48:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 30 Jul 2019 09:48:26 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 30 Jul 2019 09:48:26 +0800
Message-ID: <1564451306.18363.2.camel@mtkswgap22>
Subject: Re: [PATCH v2] mm: memcontrol: fix use after free in
 mem_cgroup_iter()
From:   Miles Chen <miles.chen@mediatek.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Tue, 30 Jul 2019 09:48:26 +0800
In-Reply-To: <20190729160646.GD21958@cmpxchg.org>
References: <20190726021247.16162-1-miles.chen@mediatek.com>
         <20190729160646.GD21958@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 2019-07-29 at 12:06 -0400, Johannes Weiner wrote:
> On Fri, Jul 26, 2019 at 10:12:47AM +0800, Miles Chen wrote:
> > This patch is sent to report an use after free in mem_cgroup_iter()
> > after merging commit: be2657752e9e "mm: memcg: fix use after free in
> > mem_cgroup_iter()".
> > 
> > I work with android kernel tree (4.9 & 4.14), and the commit:
> > be2657752e9e "mm: memcg: fix use after free in mem_cgroup_iter()" has
> > been merged to the trees. However, I can still observe use after free
> > issues addressed in the commit be2657752e9e.
> > (on low-end devices, a few times this month)
> > 
> > backtrace:
> > 	css_tryget <- crash here
> > 	mem_cgroup_iter
> > 	shrink_node
> > 	shrink_zones
> > 	do_try_to_free_pages
> > 	try_to_free_pages
> > 	__perform_reclaim
> > 	__alloc_pages_direct_reclaim
> > 	__alloc_pages_slowpath
> > 	__alloc_pages_nodemask
> > 
> > To debug, I poisoned mem_cgroup before freeing it:
> > 
> > static void __mem_cgroup_free(struct mem_cgroup *memcg)
> > 	for_each_node(node)
> > 	free_mem_cgroup_per_node_info(memcg, node);
> > 	free_percpu(memcg->stat);
> > +       /* poison memcg before freeing it */
> > +       memset(memcg, 0x78, sizeof(struct mem_cgroup));
> > 	kfree(memcg);
> > }
> > 
> > The coredump shows the position=0xdbbc2a00 is freed.
> > 
> > (gdb) p/x ((struct mem_cgroup_per_node *)0xe5009e00)->iter[8]
> > $13 = {position = 0xdbbc2a00, generation = 0x2efd}
> > 
> > 0xdbbc2a00:     0xdbbc2e00      0x00000000      0xdbbc2800      0x00000100
> > 0xdbbc2a10:     0x00000200      0x78787878      0x00026218      0x00000000
> > 0xdbbc2a20:     0xdcad6000      0x00000001      0x78787800      0x00000000
> > 0xdbbc2a30:     0x78780000      0x00000000      0x0068fb84      0x78787878
> > 0xdbbc2a40:     0x78787878      0x78787878      0x78787878      0xe3fa5cc0
> > 0xdbbc2a50:     0x78787878      0x78787878      0x00000000      0x00000000
> > 0xdbbc2a60:     0x00000000      0x00000000      0x00000000      0x00000000
> > 0xdbbc2a70:     0x00000000      0x00000000      0x00000000      0x00000000
> > 0xdbbc2a80:     0x00000000      0x00000000      0x00000000      0x00000000
> > 0xdbbc2a90:     0x00000001      0x00000000      0x00000000      0x00100000
> > 0xdbbc2aa0:     0x00000001      0xdbbc2ac8      0x00000000      0x00000000
> > 0xdbbc2ab0:     0x00000000      0x00000000      0x00000000      0x00000000
> > 0xdbbc2ac0:     0x00000000      0x00000000      0xe5b02618      0x00001000
> > 0xdbbc2ad0:     0x00000000      0x78787878      0x78787878      0x78787878
> > 0xdbbc2ae0:     0x78787878      0x78787878      0x78787878      0x78787878
> > 0xdbbc2af0:     0x78787878      0x78787878      0x78787878      0x78787878
> > 0xdbbc2b00:     0x78787878      0x78787878      0x78787878      0x78787878
> > 0xdbbc2b10:     0x78787878      0x78787878      0x78787878      0x78787878
> > 0xdbbc2b20:     0x78787878      0x78787878      0x78787878      0x78787878
> > 0xdbbc2b30:     0x78787878      0x78787878      0x78787878      0x78787878
> > 0xdbbc2b40:     0x78787878      0x78787878      0x78787878      0x78787878
> > 0xdbbc2b50:     0x78787878      0x78787878      0x78787878      0x78787878
> > 0xdbbc2b60:     0x78787878      0x78787878      0x78787878      0x78787878
> > 0xdbbc2b70:     0x78787878      0x78787878      0x78787878      0x78787878
> > 0xdbbc2b80:     0x78787878      0x78787878      0x00000000      0x78787878
> > 0xdbbc2b90:     0x78787878      0x78787878      0x78787878      0x78787878
> > 0xdbbc2ba0:     0x78787878      0x78787878      0x78787878      0x78787878
> > 
> > In the reclaim path, try_to_free_pages() does not setup
> > sc.target_mem_cgroup and sc is passed to do_try_to_free_pages(), ...,
> > shrink_node().
> > 
> > In mem_cgroup_iter(), root is set to root_mem_cgroup because
> > sc->target_mem_cgroup is NULL.
> > It is possible to assign a memcg to root_mem_cgroup.nodeinfo.iter in
> > mem_cgroup_iter().
> > 
> > 	try_to_free_pages
> > 		struct scan_control sc = {...}, target_mem_cgroup is 0x0;
> > 	do_try_to_free_pages
> > 	shrink_zones
> > 	shrink_node
> > 		 mem_cgroup *root = sc->target_mem_cgroup;
> > 		 memcg = mem_cgroup_iter(root, NULL, &reclaim);
> > 	mem_cgroup_iter()
> > 		if (!root)
> > 			root = root_mem_cgroup;
> > 		...
> > 
> > 		css = css_next_descendant_pre(css, &root->css);
> > 		memcg = mem_cgroup_from_css(css);
> > 		cmpxchg(&iter->position, pos, memcg);
> > 
> > My device uses memcg non-hierarchical mode.
> > When we release a memcg: invalidate_reclaim_iterators() reaches only
> > dead_memcg and its parents. If non-hierarchical mode is used,
> > invalidate_reclaim_iterators() never reaches root_mem_cgroup.
> > 
> > static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
> > {
> > 	struct mem_cgroup *memcg = dead_memcg;
> > 
> > 	for (; memcg; memcg = parent_mem_cgroup(memcg)
> > 	...
> > }
> > 
> > So the use after free scenario looks like:
> > 
> > CPU1						CPU2
> > 
> > try_to_free_pages
> > do_try_to_free_pages
> > shrink_zones
> > shrink_node
> > mem_cgroup_iter()
> >     if (!root)
> >     	root = root_mem_cgroup;
> >     ...
> >     css = css_next_descendant_pre(css, &root->css);
> >     memcg = mem_cgroup_from_css(css);
> >     cmpxchg(&iter->position, pos, memcg);
> > 
> > 					invalidate_reclaim_iterators(memcg);
> > 					...
> > 					__mem_cgroup_free()
> > 						kfree(memcg);
> > 
> > try_to_free_pages
> > do_try_to_free_pages
> > shrink_zones
> > shrink_node
> > mem_cgroup_iter()
> >     if (!root)
> >     	root = root_mem_cgroup;
> >     ...
> >     mz = mem_cgroup_nodeinfo(root, reclaim->pgdat->node_id);
> >     iter = &mz->iter[reclaim->priority];
> >     pos = READ_ONCE(iter->position);
> >     css_tryget(&pos->css) <- use after free
> > 
> > To avoid this, we should also invalidate root_mem_cgroup.nodeinfo.iter in
> > invalidate_reclaim_iterators().
> > 
> > Change since v1:
> > Add a comment to explain why we need to handle root_mem_cgroup separately.
> > Rename invalid_root to invalidate_root.
> > 
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > ---
> >  mm/memcontrol.c | 38 ++++++++++++++++++++++++++++----------
> >  1 file changed, 28 insertions(+), 10 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index cdbb7a84cb6e..09f2191f113b 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1130,26 +1130,44 @@ void mem_cgroup_iter_break(struct mem_cgroup *root,
> >  		css_put(&prev->css);
> >  }
> >  
> > -static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
> > +static void __invalidate_reclaim_iterators(struct mem_cgroup *from,
> > +					struct mem_cgroup *dead_memcg)
> >  {
> > -	struct mem_cgroup *memcg = dead_memcg;
> >  	struct mem_cgroup_reclaim_iter *iter;
> >  	struct mem_cgroup_per_node *mz;
> >  	int nid;
> >  	int i;
> >  
> > -	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
> > -		for_each_node(nid) {
> > -			mz = mem_cgroup_nodeinfo(memcg, nid);
> > -			for (i = 0; i <= DEF_PRIORITY; i++) {
> > -				iter = &mz->iter[i];
> > -				cmpxchg(&iter->position,
> > -					dead_memcg, NULL);
> > -			}
> > +	for_each_node(nid) {
> > +		mz = mem_cgroup_nodeinfo(from, nid);
> > +		for (i = 0; i <= DEF_PRIORITY; i++) {
> > +			iter = &mz->iter[i];
> > +			cmpxchg(&iter->position,
> > +				dead_memcg, NULL);
> >  		}
> >  	}
> >  }
> >  
> > +/*
> > + * When cgruop1 non-hierarchy mode is used, parent_mem_cgroup() does
> > + * not walk all the way up to the cgroup root (root_mem_cgroup). So
> > + * we have to handle dead_memcg from cgroup root separately.
> > + */
> > +static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
> > +{
> > +	struct mem_cgroup *memcg = dead_memcg;
> > +	int invalidate_root = 0;
> > +
> > +	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
> > +		__invalidate_reclaim_iterators(memcg, dead_memcg);
> > +		if (memcg == root_mem_cgroup)
> > +			invalidate_root = 1;
> > +	}
> > +
> > +	if (!invalidate_root)
> > +		__invalidate_reclaim_iterators(root_mem_cgroup, dead_memcg);
> 
> "invalidate_root" suggests we still have to invalidate the root, but
> the variable works the opposite way. How about dropping it altogether
> and moving the comment directly to where the decision is made:
> 
> 	struct mem_cgroup *memcg = dead_memcg;
> 
> 	do {
> 		__invalidate_reclaim_iterators(memcg, dead_memcg);
> 		last = memcg;
> 	} while ((memcg = parent_mem_cgroup(memcg)));
> 
> 	/*
> 	 * When cgruop1 non-hierarchy mode is used,
> 	 * parent_mem_cgroup() does not walk all the way up to the
> 	 * cgroup root (root_mem_cgroup). So we have to handle
> 	 * dead_memcg from cgroup root separately.
> 	 */
> 	if (last != root_mem_cgroup)
> 		__invalidate_reclaim_iterators(root_mem_cgroup, dead_memcg);

Thanks for the suggestion, the code is easier to read this way.
I'll submit patch v4 with this and the fixed tags.


Miles

