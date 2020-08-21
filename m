Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289ED24D689
	for <lists+cgroups@lfdr.de>; Fri, 21 Aug 2020 15:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgHUNsv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Aug 2020 09:48:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:51934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbgHUNsq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 21 Aug 2020 09:48:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37F43B148;
        Fri, 21 Aug 2020 13:49:12 +0000 (UTC)
Date:   Fri, 21 Aug 2020 15:48:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nao.horiguchi@gmail.com,
        osalvador@suse.de, mike.kravetz@oracle.com
Subject: Re: [Resend PATCH 1/6] mm/memcg: warning on !memcg after readahead
 page charged
Message-ID: <20200821134842.GF32537@dhcp22.suse.cz>
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200820145850.GA4622@lca.pw>
 <20200821080127.GD32537@dhcp22.suse.cz>
 <20200821123934.GA4314@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821123934.GA4314@lca.pw>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 21-08-20 08:39:37, Qian Cai wrote:
> On Fri, Aug 21, 2020 at 10:01:27AM +0200, Michal Hocko wrote:
> > On Thu 20-08-20 10:58:51, Qian Cai wrote:
> > > On Tue, Aug 11, 2020 at 07:10:27PM +0800, Alex Shi wrote:
> > > > Since readahead page is charged on memcg too, in theory we don't have to
> > > > check this exception now. Before safely remove them all, add a warning
> > > > for the unexpected !memcg.
> > > > 
> > > > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > 
> > > This will trigger,
> > 
> > Thanks for the report!
> >  
> > > [ 1863.916499] LTP: starting move_pages12
> > > [ 1863.946520] page:000000008ccc1062 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1fd3c0
> > > [ 1863.946553] head:000000008ccc1062 order:5 compound_mapcount:0 compound_pincount:0
> > 
> > Hmm, this is really unexpected. How did we get order-5 page here? Is
> > this some special mappaing that sys_move_pages should just ignore?
> 
> Well, I thought everybody should be able to figure out where to find the LTP
> tests source code at this stage to see what it does. Anyway, the test simply
> migrate hugepages while soft offlining, so order 5 is expected as that is 2M
> hugepage on powerpc (also reproduced on x86 below). It might be easier to
> reproduce using our linux-mm random bug collection on NUMA systems.

OK, I must have missed that this was on ppc. The order makes more sense
now. I will have a look at this next week.

Thanks!
-- 
Michal Hocko
SUSE Labs
