Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C7243F851
	for <lists+cgroups@lfdr.de>; Fri, 29 Oct 2021 09:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhJ2IBb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Oct 2021 04:01:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42826 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhJ2IBa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Oct 2021 04:01:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1C2982170C;
        Fri, 29 Oct 2021 07:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635494341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=odAS8sgFS/yEmejWu7NJNIJLSMk/FVvAVCyrDC5g/Vg=;
        b=tARIzmNRgXCWQw3SqRLM4bM+8BOcV8c26nHWRLEbv5UMpbdC7IM8l2j7fKveYfhp8gG/iF
        tL/wlOiibrOaSq6rbrbEhp+7ap7CV2JAwrJiJ+pLBlJWmNVycJdhoPNUXMPhRQ8IatfB+z
        dZSPt9wxYTmhbIxaU8JZj6jUv5ulxIg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 353ECA3B84;
        Fri, 29 Oct 2021 07:59:00 +0000 (UTC)
Date:   Fri, 29 Oct 2021 09:58:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH memcg v3 3/3] memcg: prohibit unconditional exceeding the
 limit of dying tasks
Message-ID: <YXupw761Qtoppm7X@dhcp22.suse.cz>
References: <YXJ/63kIpTq8AOlD@dhcp22.suse.cz>
 <cover.1634994605.git.vvs@virtuozzo.com>
 <8f5cebbb-06da-4902-91f0-6566fc4b4203@virtuozzo.com>
 <YXZ6qaMJBomVfV8O@dhcp22.suse.cz>
 <20211027153608.9910f7db99d5ef574045370e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027153608.9910f7db99d5ef574045370e@linux-foundation.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 27-10-21 15:36:08, Andrew Morton wrote:
> On Mon, 25 Oct 2021 11:36:41 +0200 Michal Hocko <mhocko@suse.com> wrote:
> 
> > My view on stable backport is similar to the previous patch. If we want
> > to have it there then let's wait for some time to see whether there are
> > any fallouts as this patch depends on the PF_OOM change.
> 
> It's strange that [1/3] doesn't have cc:stable, but [2/3] and [3/3] do
> not.  What is the thinking here?
> 
> I expect we'd be OK with merging these into 5.16-rc1.  This still gives
> another couple of months in -rc to shake out any problems.  But I
> suspect the -stable maintainers will merge and release the patches
> before they are released in 5.16.
> 
> In which case an alternative would be not to mark these patches
> cc:stable and to somehow remember to ask the -stable maintainers to
> merge them after 5.16 has been on the streets for a suitable period.

My take on stable backports is http://lkml.kernel.org/r/YXZ6FMzJLEz4TA2d@dhcp22.suse.cz
-- 
Michal Hocko
SUSE Labs
