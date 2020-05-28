Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9E21E5C78
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 11:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbgE1J5L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 05:57:11 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:47511 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387432AbgE1J5L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 05:57:11 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MPGJh-1jNYOn19Pp-00Pco1; Thu, 28 May 2020 11:56:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: memcontrol: fix an unused-function warning
Date:   Thu, 28 May 2020 11:56:26 +0200
Message-Id: <20200528095640.151454-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MmnweMcrIlQS31C4Eojn+fisoHH6xccQrSm5HEQ7Cg4yek9PYGC
 +ghSiDQyJqsxnlMJfWbmBK2Qu6dq6unBLwpvZ0yHILOPW/ria1qeOlXncbIGyYc5lvWAzZ1
 7GmpBcr+r0Cnb3BVV8dej8SDqtMZZYqtv6KdgWZ0SpUaVNyg1GdFQXpiM62/hST9SV3t5jh
 PRjOjacy/S1rObEnr+NBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tt63NLnuUFg=:a9faJh4it/EFiD6fj/M/gH
 t2D0WyESVdFmjjor8z9UwmI7Q+RS2KcFEZzAL6ThJP0jbq1dtr08eDCfcLfoZewsKiENs5HGs
 f904rkJoqqc9tDLq2ebhaa2vyAdXxJXL7AwR7Yn7niUqSGwg+BGvh41903eG5wyEPK1QjfjEl
 t7SnlC3ZXpH6Ce/fcLrYSgu5JNSt3BBttO6XHI7hluh6+4gKyezMJ1F7TtALflb7k+6bCGqah
 hyy/XZSz50UeCny1mM63SE/grrMlyggkSWzQGqRQQQ5C/noZKGnZTojlSKKDMe1Kx46OlLxgf
 aR1QJvSnQG9yM2zdoYpb0qGCZXHzz6k9rwD7FNu0Ydnd5eLbCXuD3H/T6zn5/zYtpsYRq7osQ
 IRvYYuSrabVOdOSk7VyKYn4B7+Jyktf0mWo3AwmByDaUiLDM23iUWYD06tk1d25TbsEuYG0G4
 daI/VBZTJLAEHYMR5JDkVI20cq5LX26WTN8RWnq3eFcobjBn7+wUhO88U0bkc5vQGvgf+tcNV
 TcZQoQ50WncZArEdeBiE7+Ukn1NgRl/Z5WRuHphG9OZtAbHl9YNOyGxWauVlq+MtUASFw4fvC
 go/YA8vF2ZSp1pj9J+jsumw5JcuUeGSsxnM1LKxOHn8qcnoA6cGg29cbXnOxvu470Lu+Je9eg
 UKEJPfAFwqtM6OVmaBo0t/2uSmHGMOmZaXukJvKJh39tp4UD9m3+msIM4PAmMWLoa0MqHCR/7
 GivQCT+5COGnL9/9d4eCoo+xGlF+TXYfJiFmie0eElWHsdzkKqP4GVBCb5k3uPvs2M/pvYNEc
 xJbZdSxQZf/3Zot/JszCFO0aN3yBf9Fw3pb91iw7CtSpsMjlkw=
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On NOMMU kernels without CONFIG_MEMCG_KMEM, we now get a harmless
warning about an unused function:

mm/memcontrol.c:2595:13: error: unused function 'cancel_charge' [-Werror,-Wunused-function]

Hide this function in a matching #ifdef.

Fixes: 5bd144bf764c ("mm: memcontrol: drop unused try/commit/cancel charge API")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f14da7a7348b..7bfca0abb8e1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2592,6 +2592,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return 0;
 }
 
+#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MMU)
 static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	if (mem_cgroup_is_root(memcg))
@@ -2603,6 +2604,7 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 	css_put_many(&memcg->css, nr_pages);
 }
+#endif
 
 static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 {
-- 
2.26.2

