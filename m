Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 266B8E570
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2019 16:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfD2Owz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Apr 2019 10:52:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:58660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728339AbfD2Owy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 29 Apr 2019 10:52:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B56CAAF61;
        Mon, 29 Apr 2019 14:52:52 +0000 (UTC)
Date:   Mon, 29 Apr 2019 10:52:49 -0400
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg, oom: no oom-kill for __GFP_RETRY_MAYFAIL
Message-ID: <20190429145249.GN21837@dhcp22.suse.cz>
References: <20190428235613.166330-1-shakeelb@google.com>
 <20190429122214.GK21837@dhcp22.suse.cz>
 <CALvZod6-EOAkcuiuBpoE6uR2DFNUkUY8syHxenFEAZTxhgNMhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6-EOAkcuiuBpoE6uR2DFNUkUY8syHxenFEAZTxhgNMhQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 29-04-19 07:37:08, Shakeel Butt wrote:
> On Mon, Apr 29, 2019 at 5:22 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Sun 28-04-19 16:56:13, Shakeel Butt wrote:
> > > The documentation of __GFP_RETRY_MAYFAIL clearly mentioned that the
> > > OOM killer will not be triggered and indeed the page alloc does not
> > > invoke OOM killer for such allocations. However we do trigger memcg
> > > OOM killer for __GFP_RETRY_MAYFAIL. Fix that.
> >
> > An example of __GFP_RETRY_MAYFAIL memcg OOM report would be nice. I
> > thought we haven't been using that flag for memcg allocations yet.
> > But this is definitely good to have addressed.
> 
> Actually I am planning to use it for memcg allocations (specifically
> fsnotify allocations).

OK, then articulate it in the changelog please.

> > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> >
> > Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
