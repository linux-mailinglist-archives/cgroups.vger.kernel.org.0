Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3466B408A79
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 13:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbhIMLrK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 07:47:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57584 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhIMLrJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 07:47:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 172D11FD80;
        Mon, 13 Sep 2021 11:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631533553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K9dCuBt4QfWDaiyVseqAXTLwg5tivUhElKwzeZdH8rA=;
        b=HmQaX/MAFOCAkKpj5IHDKzk3hkmOgMcy4FeOGFw/4ugdvRfFBzHPWfchrdkvKP6xp82Mbd
        0DTEr7TZD5MKD7tPpRcK0tJVtbtgowQc9yKU7u0k4Vqfuk5cL2Jk6gKJlO4F5rPMDiPm/f
        KXMLAmUwZOnr9qTD/arkSNKPsuy646g=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7928EA3B81;
        Mon, 13 Sep 2021 11:45:52 +0000 (UTC)
Date:   Mon, 13 Sep 2021 13:45:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: detect allocation forbidden by cpuset
 and bail out early
Message-ID: <YT8576cL4tSqmUKI@dhcp22.suse.cz>
References: <1631518709-42881-1-git-send-email-feng.tang@intel.com>
 <YT8WygPhuORJC6Pn@dhcp22.suse.cz>
 <20210913113423.GC56674@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913113423.GC56674@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 13-09-21 19:34:23, Feng Tang wrote:
> On Mon, Sep 13, 2021 at 11:15:54AM +0200, Michal Hocko wrote:
[...] 
> > > +/* Whether the 'nodes' are all movable nodes */
> > > +static inline bool movable_only_nodes(nodemask_t *nodes)
> > > +{
> > > +	struct zonelist *zonelist;
> > > +	struct zoneref *z;
> > > +
> > > +	zonelist = &(first_online_pgdat())->node_zonelists[ZONELIST_FALLBACK];
> > 
> > This will work but it just begs a question why you haven't chosen a node
> > from the given nodemask. So I believe it would be easier to read if you
> > did
> > 	zonelist = NODE_DATA(first_node(nodes))->node_zonelists[ZONELIST_FALLBACK]
> 
> This was also my first try to get the 'zonelist', but from the
> update_nodemask(), the nodemask could be NULL.

I guess you meant to say s@NULL@empty@
While this complicates things a bit it is nothing really hard to work
around. You simply check for nodes_empty() and return false because such
a nodemask cannot by definition be movable only.
-- 
Michal Hocko
SUSE Labs
