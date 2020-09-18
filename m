Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D7326F745
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 09:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgIRHpw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 03:45:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:45642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgIRHpw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 18 Sep 2020 03:45:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=cantorsusede;
        t=1600415150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fw/5e3KjQ1JIQKMCyH0O6Rh1ECmtPNhDeEZeres5Xb4=;
        b=sfui7gRkKIyRKYHVuphifZvgiC4A7ar5kIcwddsQBim9lQg9xNqF5k7WwgFsRi2FhO9QXR
        /LzANXQtSVL28jbiDz87FhuxgDpu/eDrqeAwZsMH6jwiVWML9yHdxu/sMYLPWSzqRywZj1
        xGhIXwj7aVfXu4Dj0sQBJEn7g4fMgaA7PZ4zZ2+VW4RWpSVK4X0NkxviUEgBBYZnguFeYQ
        flfCpBTMvAKzndECK3yIGFCDtuvM32LW7uTC7LpuFkCfmK9NtIGPNXu9SnssvbgK/DcfvD
        itNo+D1sk7aM9rM2I42D66UQcLnKnz0Tr+JyM2PiHigRccWlc0X0s0iQu2JJCw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C865BAC4D;
        Fri, 18 Sep 2020 07:46:24 +0000 (UTC)
Date:   Fri, 18 Sep 2020 09:45:49 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] mm: clean up some lru related pieces
Message-ID: <20200918074549.GG28827@dhcp22.suse.cz>
References: <20200918030051.650890-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918030051.650890-1-yuzhao@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 17-09-20 21:00:38, Yu Zhao wrote:
> Hi Andrew,
> 
> I see you have taken this:
>   mm: use add_page_to_lru_list()/page_lru()/page_off_lru()
> Do you mind dropping it?
> 
> Michal asked to do a bit of additional work. So I thought I probably
> should create a series to do more cleanups I've been meaning to.
> 
> This series contains the change in the patch above and goes a few
> more steps farther. It's intended to improve readability and should
> not have any performance impacts. There are minor behavior changes in
> terms of debugging and error reporting, which I have all highlighted
> in the individual patches. All patches were properly tested on 5.8
> running Chrome OS, with various debug options turned on.
> 
> Michal,
> 
> Do you mind taking a looking at the entire series?

I have stopped at patch 3 as all patches until then are really missing
any justification. What is the point for all this to be done? The code
is far from trivial and just shifting around sounds like a risk. You are
removing ~50 LOC which is always nice but I am not sure the resulting
code is better maintainble or easier to read and understand. Just
consider __ClearPageLRU moving to page_off_lru patch. What is the
additional value of having the flag moved and burry it into a function
to have even more side effects? I found the way how __ClearPageLRU is
nicely close to removing it from LRU easier to follow. This is likely
subjective and other might think differently but as it is not clear what
is your actual goal here it is hard to judge pros and cons.

-- 
Michal Hocko
SUSE Labs
