Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A35340874
	for <lists+cgroups@lfdr.de>; Thu, 18 Mar 2021 16:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhCRPIs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Mar 2021 11:08:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:46802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230118AbhCRPIW (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 18 Mar 2021 11:08:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616080100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ncUCz/9q/k7wrnyqgIPb09YysKbcmuYLpNaPVidiTuU=;
        b=Suk1paUYjB0Y8cnUmQ8NVFYyG6SX9/QLobkqEIZr158GOH259BZArwdugjKK5FUeytaqgW
        gY8gdp13UnN20DRnZyaeOL5vIGxodkIGAX1gKiVkCPz1Ozfix8V1pbh09M34mx08PFFQto
        JHLvU3P1lMc/pIKWzAZapeYuZ2ADMtY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85C51AB8C;
        Thu, 18 Mar 2021 15:08:20 +0000 (UTC)
Date:   Thu, 18 Mar 2021 16:08:19 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] memcg: set page->private before calling swap_readpage
Message-ID: <YFNs46Yd6pOwotSt@dhcp22.suse.cz>
References: <20210318015959.2986837-1-shakeelb@google.com>
 <YFNdNeczjnmF55bm@dhcp22.suse.cz>
 <YFNreYne/27T9XA8@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFNreYne/27T9XA8@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 18-03-21 11:02:17, Johannes Weiner wrote:
> On Thu, Mar 18, 2021 at 03:01:25PM +0100, Michal Hocko wrote:
> > On Wed 17-03-21 18:59:59, Shakeel Butt wrote:
> > > The function swap_readpage() (and other functions it call) extracts swap
> > > entry from page->private. However for SWP_SYNCHRONOUS_IO, the kernel
> > > skips the swapcache and thus we need to manually set the page->private
> > > with the swap entry before calling swap_readpage().
> > 
> > One thing that is not really clear to me is whether/why this is only
> > needed with your patch. Can you expand a bit on that please? Maybe I am
> > just missing something obvious but I just do not see any connection.
> 
> It was always needed, his original patch erroneously removed it.

Ahh, I can see it now. I must have been blind. Thanks!

-- 
Michal Hocko
SUSE Labs
