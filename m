Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 134B382C51
	for <lists+cgroups@lfdr.de>; Tue,  6 Aug 2019 09:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbfHFHHb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Aug 2019 03:07:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:54586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731734AbfHFHHa (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 6 Aug 2019 03:07:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6827ADD9;
        Tue,  6 Aug 2019 07:07:29 +0000 (UTC)
Date:   Tue, 6 Aug 2019 09:07:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
Message-ID: <20190806070728.GB11812@dhcp22.suse.cz>
References: <156431697805.3170.6377599347542228221.stgit@buzz>
 <20190729154952.GC21958@cmpxchg.org>
 <20190729185509.GI9330@dhcp22.suse.cz>
 <20190802094028.GG6461@dhcp22.suse.cz>
 <105a2f1f-de5c-7bac-3aa5-87bd1dbcaed9@yandex-team.ru>
 <20190802114438.GH6461@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802114438.GH6461@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 02-08-19 13:44:38, Michal Hocko wrote:
[...]
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index ba9138a4a1de..53a35c526e43 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2429,8 +2429,12 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > >   				schedule_work(&memcg->high_work);
> > >   				break;
> > >   			}
> > > -			current->memcg_nr_pages_over_high += batch;
> > > -			set_notify_resume(current);
> > > +			if (gfpflags_allow_blocking(gfp_mask)) {
> > > +				reclaim_high(memcg, nr_pages, GFP_KERNEL);
> 
> ups, this should be s@GFP_KERNEL@gfp_mask@
> 
> > > +			} else {
> > > +				current->memcg_nr_pages_over_high += batch;
> > > +				set_notify_resume(current);
> > > +			}
> > >   			break;
> > >   		}
> > >   	} while ((memcg = parent_mem_cgroup(memcg)));
> > > 

Should I send an official patch for this?
-- 
Michal Hocko
SUSE Labs
