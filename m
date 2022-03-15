Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECF34D96CF
	for <lists+cgroups@lfdr.de>; Tue, 15 Mar 2022 09:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiCOIzs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Mar 2022 04:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346236AbiCOIzr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Mar 2022 04:55:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3826164
        for <cgroups@vger.kernel.org>; Tue, 15 Mar 2022 01:54:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2DBF11F37E;
        Tue, 15 Mar 2022 08:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647334475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k31i3YTYOknR6WudpStCLK3nsIiTUhJ3ISWvBqEKH3c=;
        b=MbRJiBppXoWjXQRAq5YT4P81gpSS9nnDeHUj39iWUP03PZNHRGvEtD9vEojB4gfNUXN5Tk
        q1LeMjApOhbLSoOL8PiC0wlPgYbx+84b9+vVeLizG7aHNkZNeY/f8eATrszIWFxIJgUrmx
        cpuR7rDMXVxNY37C7t4Yl3/HUvYFjDw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EBC00A3B87;
        Tue, 15 Mar 2022 08:54:34 +0000 (UTC)
Date:   Tue, 15 Mar 2022 09:54:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [Patch v2 3/3] mm/memcg: add next_mz back to soft limit tree if
 not reclaimed yet
Message-ID: <YjBUSqh07BIfxbl5@dhcp22.suse.cz>
References: <20220312071623.19050-1-richard.weiyang@gmail.com>
 <20220312071623.19050-3-richard.weiyang@gmail.com>
 <Yi8NudEX/sZsO2nO@dhcp22.suse.cz>
 <20220314230548.wo4colcwqxhhf3mx@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314230548.wo4colcwqxhhf3mx@master>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 14-03-22 23:05:48, Wei Yang wrote:
> On Mon, Mar 14, 2022 at 10:41:13AM +0100, Michal Hocko wrote:
> >On Sat 12-03-22 07:16:23, Wei Yang wrote:
> >> When memory reclaim failed for a maximum number of attempts and we bail
> >> out of the reclaim loop, we forgot to put the target mem_cgroup chosen
> >> for next reclaim back to the soft limit tree. This prevented pages in
> >> the mem_cgroup from being reclaimed in the future even though the
> >> mem_cgroup exceeded its soft limit.
> >> 
> >> Let's say there are two mem_cgroup and both of them exceed the soft
> >> limit, while the first one is more active then the second. Since we add
> >> a mem_cgroup to soft limit tree every 1024 event, the second one just
> >> get a rare chance to be put on soft limit tree even it exceeds the
> >> limit.
> >
> >yes, 1024 could be just 4MB of memory or 2GB if all the charged pages
> >are THPs. So the excess can build up considerably.
> >
> >> As time goes on, the first mem_cgroup was kept close to its soft limit
> >> due to reclaim activities, while the memory usage of the second
> >> mem_cgroup keeps growing over the soft limit for a long time due to its
> >> relatively rare occurrence.
> >> 
> >> This patch adds next_mz back to prevent this sceanrio.
> >> 
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >
> >Even though your changelog is different the change itself is identical to
> >https://lore.kernel.org/linux-mm/8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com/
> >In those cases I would preserve the the original authorship by
> >From: Tim Chen <tim.c.chen@linux.intel.com>
> >and add his s-o-b before yours.
> 
> TBH I don't think this is fair.
> 
> I didn't see his original change before I sent this patch. This is a
> coincidence we found the same point for improvement.
> 
> It hurts me if you want to change authorship. Well, if you really thinks this
> is what it should be, please remove my s-o-b.

OK, fair enough.
-- 
Michal Hocko
SUSE Labs
