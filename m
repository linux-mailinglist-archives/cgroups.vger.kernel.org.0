Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC59442A398
	for <lists+cgroups@lfdr.de>; Tue, 12 Oct 2021 13:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbhJLLtp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Oct 2021 07:49:45 -0400
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:47717 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232665AbhJLLtp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Oct 2021 07:49:45 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Oct 2021 07:49:45 EDT
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 2907A146022
        for <cgroups@vger.kernel.org>; Tue, 12 Oct 2021 12:38:06 +0100 (IST)
Received: (qmail 17393 invoked from network); 12 Oct 2021 11:38:06 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Oct 2021 11:38:05 -0000
Date:   Tue, 12 Oct 2021 12:38:04 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH memcg] mm/page_alloc.c: avoid statistic update with 0
Message-ID: <20211012113804.GT3959@techsingularity.net>
References: <b2371951-bb8a-e62e-8d33-10830bbf6275@virtuozzo.com>
 <29155011-f884-b0e5-218e-911039568acb@suse.cz>
 <f52c5cd3-9b74-0fd5-2b7b-83ca21c52b2a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <f52c5cd3-9b74-0fd5-2b7b-83ca21c52b2a@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 12, 2021 at 01:42:41PM +0300, Vasily Averin wrote:
> On 08.10.2021 14:47, Vlastimil Babka wrote:
> > On 10/8/21 11:24, Vasily Averin wrote:
> >> __alloc_pages_bulk can call __count_zid_vm_events and zone_statistics
> >> with nr_account = 0.
> > 
> > But that's not a bug, right? Just an effective no-op that's not commonly
> > happening, so is it worth the check?
> 
> Why not?
> 
> Yes, it's not a bug, it just makes the kernel a bit more efficient in a very unlikely case.

At the cost of an additional branch in the likely case that may be
mispredicted.

> However, it looks strange and makes uninformed code reviewers like me worry about possible
> problems inside the affected functions. No one else calls these functions from 0.
>  

The accounting functions should still work with a 0 delta.

-- 
Mel Gorman
SUSE Labs
