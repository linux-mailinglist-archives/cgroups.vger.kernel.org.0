Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00B0327850
	for <lists+cgroups@lfdr.de>; Mon,  1 Mar 2021 08:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhCAHj0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Mar 2021 02:39:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:36288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232496AbhCAHjY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 1 Mar 2021 02:39:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614584364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=34KjJW6+smFTvdlwXxTHDLwnzuvbuoymQf/sE3k7JDk=;
        b=vU+v0gpxQZomsgNvE8gpmxUfse2pH+A/rl+TVwbFGvyrWd8cPG1s4z3QEmjtqqVzhvUOGz
        CNOgbtrM+9vHwXEKis5Iw6Dx2e/rVoIweBr7mXZ+roPJJXen8HgAP06WQiIoWY0oB3d4Cv
        uQmB3+xzn6iXB4207y2xgFbDmKCiDR4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E026AF11;
        Mon,  1 Mar 2021 07:39:24 +0000 (UTC)
Date:   Mon, 1 Mar 2021 08:39:23 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm: Force update of mem cgroup soft limit tree on
 usage excess
Message-ID: <YDyaK2wSKc80c4vM@dhcp22.suse.cz>
References: <YC+ApsntwnlVfCuK@dhcp22.suse.cz>
 <884d7559-e118-3773-351d-84c02642ca96@linux.intel.com>
 <YDNuAIztiGJpLEtw@dhcp22.suse.cz>
 <e132f836-b5d5-3776-22d6-669e713983e4@linux.intel.com>
 <YDQBh5th9txxEFUm@dhcp22.suse.cz>
 <cf5ca7a1-7965-f307-22e1-e216316904cf@linux.intel.com>
 <YDY+PydRUGQpHNaJ@dhcp22.suse.cz>
 <b5b1944d-846b-3212-fe4a-f10f5fcb87d7@linux.intel.com>
 <YDi2udQqIML6Vdpo@dhcp22.suse.cz>
 <781634ee-ffb9-598d-fdb6-0ae6067448b7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <781634ee-ffb9-598d-fdb6-0ae6067448b7@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 26-02-21 16:56:28, Tim Chen wrote:
> 
> 
> On 2/26/21 12:52 AM, Michal Hocko wrote:
> 
> >>
> >> Michal,
> >>
> >> Let's take an extreme case where memcg 1 always generate the
> >> first event and memcg 2 generates the rest of 128*8-1 events
> >> and the pattern repeat.
> > 
> > I do not follow. Events are per-memcg, aren't they?
> > 	__this_cpu_read(memcg->vmstats_percpu->targets[target]);
> > 	[...]
> > 	__this_cpu_write(memcg->vmstats_percpu->targets[target], next);
> > 
> 
> You are right. My previous reasoning is incorrect as the sampling is done per memcg.
> I'll do some additional debugging on why memcg is not on the tree.

OK, thanks for the confirmation. I think we want to do 2 things. Remove
the soft limit specific threshold and stay with a single one and
recognize THPs.
-- 
Michal Hocko
SUSE Labs
