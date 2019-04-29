Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB92E380
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2019 15:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfD2NPy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Apr 2019 09:15:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:37300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726321AbfD2NPy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 29 Apr 2019 09:15:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E2D5AD31;
        Mon, 29 Apr 2019 13:15:53 +0000 (UTC)
Date:   Mon, 29 Apr 2019 09:15:49 -0400
From:   Michal Hocko <mhocko@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org,
        Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH] memcg: make it work on sparse non-0-node systems
Message-ID: <20190429131549.GL21837@dhcp22.suse.cz>
References: <359d98e6-044a-7686-8522-bdd2489e9456@suse.cz>
 <20190429105939.11962-1-jslaby@suse.cz>
 <20190429112916.GI21837@dhcp22.suse.cz>
 <465a4b50-490c-7978-ecb8-d122b655f868@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <465a4b50-490c-7978-ecb8-d122b655f868@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 29-04-19 13:55:26, Jiri Slaby wrote:
> On 29. 04. 19, 13:30, Michal Hocko wrote:
> > On Mon 29-04-19 12:59:39, Jiri Slaby wrote:
> > [...]
> >>  static inline bool list_lru_memcg_aware(struct list_lru *lru)
> >>  {
> >> -	/*
> >> -	 * This needs node 0 to be always present, even
> >> -	 * in the systems supporting sparse numa ids.
> >> -	 */
> >> -	return !!lru->node[0].memcg_lrus;
> >> +	return !!lru->node[first_online_node].memcg_lrus;
> >>  }
> >>  
> >>  static inline struct list_lru_one *
> > 
> > How come this doesn't blow up later - e.g. in memcg_destroy_list_lru
> > path which does iterate over all existing nodes thus including the
> > node 0.
> 
> If the node is not disabled (i.e. is N_POSSIBLE), lru->node is allocated
> for that node too. It will also have memcg_lrus properly set.
> 
> If it is disabled, it will never be iterated.
> 
> Well, I could have used first_node. But I am not sure, if the first
> POSSIBLE node is also ONLINE during boot?

I dunno. I would have to think about this much more. The whole
expectation that node 0 is always around is simply broken. But also
list_lru_memcg_aware looks very suspicious. We should have a flag or
something rather than what we have now.

I am still not sure I have completely understood the problem though.
I will try to get to this during the week but Vladimir should be much
better fit to judge here.
-- 
Michal Hocko
SUSE Labs
