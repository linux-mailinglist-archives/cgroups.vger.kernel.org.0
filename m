Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E56751F6
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2019 16:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbfGYO7U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Jul 2019 10:59:20 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:50183 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387834AbfGYO7U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Jul 2019 10:59:20 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jul 2019 10:59:20 EDT
X-UUID: 68c8c96cfe82444895fc582f3966f561-20190725
X-UUID: 68c8c96cfe82444895fc582f3966f561-20190725
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1017426763; Thu, 25 Jul 2019 06:53:06 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 25 Jul 2019 22:27:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 25 Jul 2019 22:27:04 +0800
From:   <miles.chen@mediatek.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [RFC PATCH] mm: memcontrol: fix use after free in mem_cgroup_iter()
Date:   Thu, 25 Jul 2019 22:27:03 +0800
Message-ID: <20190725142703.27276-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BA133858E120E853044F975DFC7A41746A406CCD8C5E6AAF83D767E759F686B22000:8
X-MTK:  N
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Miles Chen <miles.chen@mediatek.com>

This RFC patch is sent to report an use after free in mem_cgroup_iter()
after merging commit: be2657752e9e "mm: memcg: fix use after free in
mem_cgroup_iter()".

I work with android kernel tree (4.9 & 4.14), and the commit:
be2657752e9e "mm: memcg: fix use after free in mem_cgroup_iter()" has
been merged to the trees. However, I can still observe use after free
issues addressed in the commit be2657752e9e.
(on low-end devices, a few times this month)

backtrace:
	css_tryget <- crash here
	mem_cgroup_iter
	shrink_node
	shrink_zones
	do_try_to_free_pages
	try_to_free_pages
	__perform_reclaim
	__alloc_pages_direct_reclaim
	__alloc_pages_slowpath
	__alloc_pages_nodemask

To debug, I poisoned mem_cgroup before freeing it:

static void __mem_cgroup_free(struct mem_cgroup *memcg)
	for_each_node(node)
	free_mem_cgroup_per_node_info(memcg, node);
	free_percpu(memcg->stat);
+       /* poison memcg before freeing it */
+       memset(memcg, 0x78, sizeof(struct mem_cgroup));
	kfree(memcg);
}

The coredump shows the position=0xdbbc2a00 is freed.

(gdb) p/x ((struct mem_cgroup_per_node *)0xe5009e00)->iter[8]
$13 = {position = 0xdbbc2a00, generation = 0x2efd}

0xdbbc2a00:     0xdbbc2e00      0x00000000      0xdbbc2800      0x00000100
0xdbbc2a10:     0x00000200      0x78787878      0x00026218      0x00000000
0xdbbc2a20:     0xdcad6000      0x00000001      0x78787800      0x00000000
0xdbbc2a30:     0x78780000      0x00000000      0x0068fb84      0x78787878
0xdbbc2a40:     0x78787878      0x78787878      0x78787878      0xe3fa5cc0
0xdbbc2a50:     0x78787878      0x78787878      0x00000000      0x00000000
0xdbbc2a60:     0x00000000      0x00000000      0x00000000      0x00000000
0xdbbc2a70:     0x00000000      0x00000000      0x00000000      0x00000000
0xdbbc2a80:     0x00000000      0x00000000      0x00000000      0x00000000
0xdbbc2a90:     0x00000001      0x00000000      0x00000000      0x00100000
0xdbbc2aa0:     0x00000001      0xdbbc2ac8      0x00000000      0x00000000
0xdbbc2ab0:     0x00000000      0x00000000      0x00000000      0x00000000
0xdbbc2ac0:     0x00000000      0x00000000      0xe5b02618      0x00001000
0xdbbc2ad0:     0x00000000      0x78787878      0x78787878      0x78787878
0xdbbc2ae0:     0x78787878      0x78787878      0x78787878      0x78787878
0xdbbc2af0:     0x78787878      0x78787878      0x78787878      0x78787878
0xdbbc2b00:     0x78787878      0x78787878      0x78787878      0x78787878
0xdbbc2b10:     0x78787878      0x78787878      0x78787878      0x78787878
0xdbbc2b20:     0x78787878      0x78787878      0x78787878      0x78787878
0xdbbc2b30:     0x78787878      0x78787878      0x78787878      0x78787878
0xdbbc2b40:     0x78787878      0x78787878      0x78787878      0x78787878
0xdbbc2b50:     0x78787878      0x78787878      0x78787878      0x78787878
0xdbbc2b60:     0x78787878      0x78787878      0x78787878      0x78787878
0xdbbc2b70:     0x78787878      0x78787878      0x78787878      0x78787878
0xdbbc2b80:     0x78787878      0x78787878      0x00000000      0x78787878
0xdbbc2b90:     0x78787878      0x78787878      0x78787878      0x78787878
0xdbbc2ba0:     0x78787878      0x78787878      0x78787878      0x78787878

In the reclaim path, try_to_free_pages() does not setup
sc.target_mem_cgroup and sc is passed to do_try_to_free_pages(), ...,
shrink_node().

In mem_cgroup_iter(), root is set to root_mem_cgroup because
sc->target_mem_cgroup is NULL.
It is possible to assign a memcg to root_mem_cgroup.nodeinfo.iter in
mem_cgroup_iter().

	try_to_free_pages
		struct scan_control sc = {...}, target_mem_cgroup is 0x0;
	do_try_to_free_pages
	shrink_zones
	shrink_node
		 mem_cgroup *root = sc->target_mem_cgroup;
		 memcg = mem_cgroup_iter(root, NULL, &reclaim);
	mem_cgroup_iter()
		if (!root)
			root = root_mem_cgroup;
		...

		css = css_next_descendant_pre(css, &root->css);
		memcg = mem_cgroup_from_css(css);
		cmpxchg(&iter->position, pos, memcg);

My device uses memcg non-hierarchical mode.
When we release a memcg: invalidate_reclaim_iterators() reaches only
dead_memcg and its parents. If non-hierarchical mode is used,
invalidate_reclaim_iterators() never reaches root_mem_cgroup.

static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
{
	struct mem_cgroup *memcg = dead_memcg;

	for (; memcg; memcg = parent_mem_cgroup(memcg)
	...
}

So the use after free scenario looks like:

CPU1						CPU2

try_to_free_pages
do_try_to_free_pages
shrink_zones
shrink_node
mem_cgroup_iter()
    if (!root)
    	root = root_mem_cgroup;
    ...
    css = css_next_descendant_pre(css, &root->css);
    memcg = mem_cgroup_from_css(css);
    cmpxchg(&iter->position, pos, memcg);

					invalidate_reclaim_iterators(memcg);
					...
					__mem_cgroup_free()
						kfree(memcg);

try_to_free_pages
do_try_to_free_pages
shrink_zones
shrink_node
mem_cgroup_iter()
    if (!root)
    	root = root_mem_cgroup;
    ...
    mz = mem_cgroup_nodeinfo(root, reclaim->pgdat->node_id);
    iter = &mz->iter[reclaim->priority];
    pos = READ_ONCE(iter->position);
    css_tryget(&pos->css) <- use after free

To avoid this, we should also invalidate root_mem_cgroup.nodeinfo.iter in
invalidate_reclaim_iterators().

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 mm/memcontrol.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cdbb7a84cb6e..578b02982c9a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1130,26 +1130,39 @@ void mem_cgroup_iter_break(struct mem_cgroup *root,
 		css_put(&prev->css);
 }
 
-static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
+static void __invalidate_reclaim_iterators(struct mem_cgroup *from,
+					struct mem_cgroup *dead_memcg)
 {
-	struct mem_cgroup *memcg = dead_memcg;
 	struct mem_cgroup_reclaim_iter *iter;
 	struct mem_cgroup_per_node *mz;
 	int nid;
 	int i;
 
-	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
-		for_each_node(nid) {
-			mz = mem_cgroup_nodeinfo(memcg, nid);
-			for (i = 0; i <= DEF_PRIORITY; i++) {
-				iter = &mz->iter[i];
-				cmpxchg(&iter->position,
-					dead_memcg, NULL);
-			}
+	for_each_node(nid) {
+		mz = mem_cgroup_nodeinfo(from, nid);
+		for (i = 0; i <= DEF_PRIORITY; i++) {
+			iter = &mz->iter[i];
+			cmpxchg(&iter->position,
+				dead_memcg, NULL);
 		}
 	}
 }
 
+static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
+{
+	struct mem_cgroup *memcg = dead_memcg;
+	int invalid_root = 0;
+
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
+		__invalidate_reclaim_iterators(memcg, dead_memcg);
+		if (memcg == root_mem_cgroup)
+			invalid_root = 1;
+	}
+
+	if (!invalid_root)
+		__invalidate_reclaim_iterators(root_mem_cgroup, dead_memcg);
+}
+
 /**
  * mem_cgroup_scan_tasks - iterate over tasks of a memory cgroup hierarchy
  * @memcg: hierarchy root
-- 
2.18.0

