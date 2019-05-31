Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D2030883
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2019 08:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEaG25 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 May 2019 02:28:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:59148 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbfEaG25 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 31 May 2019 02:28:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CFF82AF8A;
        Fri, 31 May 2019 06:28:55 +0000 (UTC)
Date:   Fri, 31 May 2019 08:28:54 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH REBASED] mm, memcg: Make scan aggression always exclude
 protection
Message-ID: <20190531062854.GG6896@dhcp22.suse.cz>
References: <20190228213050.GA28211@chrisdown.name>
 <20190322160307.GA3316@chrisdown.name>
 <20190530061221.GA6703@dhcp22.suse.cz>
 <20190530064453.GA110128@chrisdown.name>
 <20190530065111.GC6703@dhcp22.suse.cz>
 <20190530205210.GA165912@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530205210.GA165912@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 30-05-19 13:52:10, Chris Down wrote:
> Michal Hocko writes:
> > On Wed 29-05-19 23:44:53, Chris Down wrote:
> > > Michal Hocko writes:
> > > > Maybe I am missing something so correct me if I am wrong but the new
> > > > calculation actually means that we always allow to scan even min
> > > > protected memcgs right?
> > > 
> > > We check if the memcg is min protected as a precondition for coming into
> > > this function at all, so this generally isn't possible. See the
> > > mem_cgroup_protected MEMCG_PROT_MIN check in shrink_node.
> > 
> > OK, that is the part I was missing, I got confused by checking the min
> > limit as well here. Thanks for the clarification. A comment would be
> > handy or do we really need to consider min at all?
> 
> You mean as part of the reclaim pressure calculation? Yeah, we still need
> it, because we might only set memory.min, but not set memory.low.

But then the memcg will get excluded as well right?
-- 
Michal Hocko
SUSE Labs
