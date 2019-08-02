Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A83B27F465
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2019 12:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391721AbfHBJkc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Aug 2019 05:40:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:37470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391717AbfHBJkb (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 2 Aug 2019 05:40:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 30C32AE50;
        Fri,  2 Aug 2019 09:40:30 +0000 (UTC)
Date:   Fri, 2 Aug 2019 11:40:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
Message-ID: <20190802094028.GG6461@dhcp22.suse.cz>
References: <156431697805.3170.6377599347542228221.stgit@buzz>
 <20190729154952.GC21958@cmpxchg.org>
 <20190729185509.GI9330@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729185509.GI9330@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 29-07-19 20:55:09, Michal Hocko wrote:
> On Mon 29-07-19 11:49:52, Johannes Weiner wrote:
> > On Sun, Jul 28, 2019 at 03:29:38PM +0300, Konstantin Khlebnikov wrote:
> > > --- a/mm/gup.c
> > > +++ b/mm/gup.c
> > > @@ -847,8 +847,11 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
> > >  			ret = -ERESTARTSYS;
> > >  			goto out;
> > >  		}
> > > -		cond_resched();
> > >  
> > > +		/* Reclaim memory over high limit before stocking too much */
> > > +		mem_cgroup_handle_over_high(true);
> > 
> > I'd rather this remained part of the try_charge() call. The code
> > comment in try_charge says this:
> > 
> > 	 * We can perform reclaim here if __GFP_RECLAIM but let's
> > 	 * always punt for simplicity and so that GFP_KERNEL can
> > 	 * consistently be used during reclaim.
> > 
> > The simplicity argument doesn't hold true anymore once we have to add
> > manual calls into allocation sites. We should instead fix try_charge()
> > to do synchronous reclaim for __GFP_RECLAIM and only punt to userspace
> > return when actually needed.
> 
> Agreed. If we want to do direct reclaim on the high limit breach then it
> should go into try_charge same way we do hard limit reclaim there. I am
> not yet sure about how/whether to scale the excess. The only reason to
> move reclaim to return-to-userspace path was GFP_NOWAIT charges. As you
> say, maybe we should start by always performing the reclaim for
> sleepable contexts first and only defer for non-sleeping requests.

In other words. Something like patch below (completely untested). Could
you give it a try Konstantin?

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ba9138a4a1de..53a35c526e43 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2429,8 +2429,12 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 				schedule_work(&memcg->high_work);
 				break;
 			}
-			current->memcg_nr_pages_over_high += batch;
-			set_notify_resume(current);
+			if (gfpflags_allow_blocking(gfp_mask)) {
+				reclaim_high(memcg, nr_pages, GFP_KERNEL);
+			} else {
+				current->memcg_nr_pages_over_high += batch;
+				set_notify_resume(current);
+			}
 			break;
 		}
 	} while ((memcg = parent_mem_cgroup(memcg)));
-- 
Michal Hocko
SUSE Labs
