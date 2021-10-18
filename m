Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63D43190B
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhJRM3o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 08:29:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42150 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhJRM3o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Oct 2021 08:29:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1865A218ED;
        Mon, 18 Oct 2021 12:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634560052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AsSJ46fWPAV0IFj3qTLOgd+in0HeJw5bzRCwtXuU/Uk=;
        b=UJ6P3rvwwmuf+NLn07KFXlpInNHv/exUEHzjgL1dgEuXYvz97ilEtXh08qsdthN1U8Zwrp
        NssW+sFhiRJeGnFGAto9l78Z83ZoJk8R+tvT5xb6BZ8IJD2saeRQHvrdVIa1gbu+7jX28X
        h4bPccf2NNa1MJoiTPGUM96MCfWc3Oc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D24A1A3B90;
        Mon, 18 Oct 2021 12:27:31 +0000 (UTC)
Date:   Mon, 18 Oct 2021 14:27:31 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH memcg 0/1] false global OOM triggered by memcg-limited
 task
Message-ID: <YW1oMxNkUCaAimmg@dhcp22.suse.cz>
References: <9d10df01-0127-fb40-81c3-cc53c9733c3e@virtuozzo.com>
 <YW04jWSv6pQb2Goe@dhcp22.suse.cz>
 <6b751abe-aa52-d1d8-2631-ec471975cc3a@virtuozzo.com>
 <YW1gRz0rTkJrvc4L@dhcp22.suse.cz>
 <27dc0c49-a0d6-875b-49c6-0ef5c0cc3ac8@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27dc0c49-a0d6-875b-49c6-0ef5c0cc3ac8@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[restore the cc list]

On Mon 18-10-21 15:14:26, Vasily Averin wrote:
> On 18.10.2021 14:53, Michal Hocko wrote:
> > On Mon 18-10-21 13:05:35, Vasily Averin wrote:
> >> On 18.10.2021 12:04, Michal Hocko wrote:
> >> Here we call try_charge_memcg() that return success and approve the allocation,
> >> however then we hit into kmem limit and fail the allocation.
> > 
> > Just to make sure I understand this would be for the v1 kmem explicit
> > limit, correct?
> 
> yes, I mean this limit.

OK, thanks for the clarification. This is a known problem. Have a look
at I think we consider that one to 0158115f702b ("memcg, kmem: deprecate
kmem.limit_in_bytes"). We are reporting the deprecated and to-be removed
status since 2019 without any actual report sugested by the kernel
message. Maybe we should try and remove it and see whether that prompts
some pushback.

-- 
Michal Hocko
SUSE Labs
