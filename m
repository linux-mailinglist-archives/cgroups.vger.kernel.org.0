Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2813634112C
	for <lists+cgroups@lfdr.de>; Fri, 19 Mar 2021 00:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhCRXq3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Mar 2021 19:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233333AbhCRXq1 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 18 Mar 2021 19:46:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E71564E81;
        Thu, 18 Mar 2021 23:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1616111187;
        bh=Q6IwZMnHQrWqg5zWmgJf0Ebi8/XOyNEUBJCBBfeMwho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pkyU/9SsaUegsBiyD056d2/968LCZGIbrcp4noID/iGWNue/gnKHUnWbmuzrgA3Sc
         IG3OtZdi84KVr6ugmWi4ktkMLMz9PqX7sUR+xzB6moH5TdMx09O1HExrMGhhkUmSzZ
         JEDDvYTUz6Su6h3nJl/Du6zeBIbKIgEjWAXP9Ot8=
Date:   Thu, 18 Mar 2021 16:46:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [PATCH v10 0/3] Charge loop device i/o to issuing cgroup
Message-Id: <20210318164625.1018062b042e540bd83bb08e@linux-foundation.org>
In-Reply-To: <8c32421c-4bd8-ec46-f1d0-25996956f4da@kernel.dk>
References: <20210316153655.500806-1-schatzberg.dan@gmail.com>
        <7ca79335-026f-2511-2b58-0e9f32caa063@kernel.dk>
        <CALvZod6tvrZ_sj=BnM4baQepexwvOPREx3qe5ZJrmqftrqwBEA@mail.gmail.com>
        <8c32421c-4bd8-ec46-f1d0-25996956f4da@kernel.dk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 18 Mar 2021 10:00:17 -0600 Jens Axboe <axboe@kernel.dk> wrote:

> On 3/18/21 9:53 AM, Shakeel Butt wrote:
> > On Wed, Mar 17, 2021 at 3:30 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 3/16/21 9:36 AM, Dan Schatzberg wrote:
> >>> No major changes, just rebasing and resubmitting
> >>
> >> Applied for 5.13, thanks.
> >>
> > 
> > I have requested a couple of changes in the patch series. Can this
> > applied series still be changed or new patches are required?
> 
> I have nothing sitting on top of it for now, so as far as I'm concerned
> we can apply a new series instead. Then we can also fold in that fix
> from Colin that he posted this morning...

The collision in memcontrol.c is a pain, but I guess as this is mainly
a loop patch, the block tree is an appropriate route.

Here's the collision between "mm: Charge active memcg when no mm is
set" and Shakeels's
https://lkml.kernel.org/r/20210305212639.775498-1-shakeelb@google.com


--- mm/memcontrol.c
+++ mm/memcontrol.c
@@ -6728,8 +6730,15 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 		rcu_read_unlock();
 	}
 
-	if (!memcg)
-		memcg = get_mem_cgroup_from_mm(mm);
+	if (!memcg) {
+		if (!mm) {
+			memcg = get_mem_cgroup_from_current();
+			if (!memcg)
+				memcg = get_mem_cgroup_from_mm(current->mm);
+		} else {
+			memcg = get_mem_cgroup_from_mm(mm);
+		}
+	}
 
 	ret = try_charge(memcg, gfp_mask, nr_pages);
 	if (ret)


Which I resolved thusly:

int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
{
	struct mem_cgroup *memcg;
	int ret;

	if (mem_cgroup_disabled())
		return 0;

	if (!mm) {
		memcg = get_mem_cgroup_from_current();
		(!memcg)
			memcg = get_mem_cgroup_from_mm(current->mm);
	} else {
		memcg = get_mem_cgroup_from_mm(mm);
	}
				
	ret = __mem_cgroup_charge(page, memcg, gfp_mask);
	css_put(&memcg->css);

	return ret;
}


