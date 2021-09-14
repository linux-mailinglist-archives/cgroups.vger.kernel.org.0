Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B36940B0AE
	for <lists+cgroups@lfdr.de>; Tue, 14 Sep 2021 16:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhINOdk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Sep 2021 10:33:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58200 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbhINOdj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Sep 2021 10:33:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A6C1822100;
        Tue, 14 Sep 2021 14:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631629940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8cl6i/Xuxe8x3+G+xdschhZeDxTx8TVhW/IfLYXe8g=;
        b=ic/UhyEZIPK10iNW01IYfzvu+rOZxxQP19bKkTCbeUetDCBq7x25/tljIRbq7E9Xf9yWGs
        s1bw70mn5grnjbE5rrWFcN1ivU/qIVXWNtsGAW1jnxtmK4IQ+JdSTcoHnFf1puZhFpQT/B
        Uv5QTCrnI+Y9RByFJ7YrBZRk/5q8nU4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7AAB1A3B9F;
        Tue, 14 Sep 2021 14:32:20 +0000 (UTC)
Date:   Tue, 14 Sep 2021 16:32:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH] ipc: remove memcg accounting for sops objects in
 do_semtimedop()
Message-ID: <YUCydCo+N8XFdyTU@dhcp22.suse.cz>
References: <90e254df-0dfe-f080-011e-b7c53ee7fd20@virtuozzo.com>
 <YT8NrsaztWNDpKXk@dhcp22.suse.cz>
 <CALvZod7Y4pC4XvqVp+tJ==CnS5Ay8YPqrxeUzA8tMLu+0U3hjQ@mail.gmail.com>
 <YUBLrJOL6DGxmira@dhcp22.suse.cz>
 <20210914142316.GA23024@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210914142316.GA23024@blackbody.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 14-09-21 16:23:16, Michal Koutny wrote:
> On Tue, Sep 14, 2021 at 09:13:48AM +0200, Michal Hocko <mhocko@suse.com> wrote:
> > "
> > This object can consume up to 2 pages, syscall is sleeping one,
> > size and duration can be controlled by user, and this allocation
> > can be repeated by many thread at the same time.
> > "
> > 
> > It sounds like a problem, except it is not because? A worst case
> > scenario evaluation would be beneficial for example
> 
> AFAICS, the offending allocation is in place only during the duration of
> the syscall. So it's basically O(#tasks).
> Considering at least 2 pages for task_struct + 2 pages for kernel stack,
> back of the envelope calculation gives me the footprint amplification is
> <1.5.
> The factor would IMO be interesting if it was >> 2 (from the PoV of
> excessive (ab)use, fine-grained accounting seems to be currently
> unfeasible due to performance impact).

Yes this sounds exactly like something I would appreciate in the
changelog. With that or similar feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks a lot Michal for this clarification! 

> The commit message can be more explicit about this but to the patch
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
-- 
Michal Hocko
SUSE Labs
