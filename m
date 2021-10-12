Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6407742A85D
	for <lists+cgroups@lfdr.de>; Tue, 12 Oct 2021 17:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbhJLPiR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Oct 2021 11:38:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44590 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbhJLPiQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Oct 2021 11:38:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D4EC8221AB;
        Tue, 12 Oct 2021 15:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634052973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z4t443UJiJ2rcoEB8L8cMpLE3EGEoriZGHhNtpCV59o=;
        b=LCAWful78QuPBIVafj5uLFJo72ALVVdM8BR8Gp5+khkEphWBJoq8TBmZSTM0EVae88QNRP
        As50/6u8kW+DCDHqOrREg4u2ReEWtBd2xfSfWu8Qfx6P9Df+h+++WUYuIDlZWa3YSQSWP3
        uhiTrgTiXOhkCCm/pagqt/x87mWJrik=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 98B00A3B81;
        Tue, 12 Oct 2021 15:36:13 +0000 (UTC)
Date:   Tue, 12 Oct 2021 17:36:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH mm v3] memcg: enable memory accounting in
 __alloc_pages_bulk
Message-ID: <YWWrai/ChIgycgCo@dhcp22.suse.cz>
References: <0baa2b26-a41b-acab-b75d-72ec241f5151@virtuozzo.com>
 <60df0efd-f458-a13c-7c89-749bdab21d1d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60df0efd-f458-a13c-7c89-749bdab21d1d@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 12-10-21 17:58:21, Vasily Averin wrote:
> Enable memory accounting for bulk page allocator.

ENOCHANGELOG
 
And I have to say I am not very happy about the solution. It adds a very
tricky code where it splits different charging steps apart.

Would it be just too inefficient to charge page-by-page once all pages
are already taken away from the pcp lists? This bulk should be small so
this shouldn't really cause massive problems. I mean something like

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..8bcd69195ef5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5308,6 +5308,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 	local_unlock_irqrestore(&pagesets.lock, flags);
 
+	if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT)) {
+		/* charge pages here */
+	}
+
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
-- 
Michal Hocko
SUSE Labs
