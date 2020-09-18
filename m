Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DD426F966
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 11:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgIRJgi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 05:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgIRJgi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Sep 2020 05:36:38 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4028CC061756
        for <cgroups@vger.kernel.org>; Fri, 18 Sep 2020 02:36:38 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b6so6113492iof.6
        for <cgroups@vger.kernel.org>; Fri, 18 Sep 2020 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ofKvXByFD2eTX9fI7pI8+9B6s6meAkUWiXIy9ZfC+QY=;
        b=QxoMVdbJPeqrTlkx5f/73dhtxLUkgkyN+VruQyO1/DVhy0/tFaAQ+h9OKo3iWOdoAm
         //wddD5q8p90+WGg+WpJ94zSSO7WSg8M7myvdhtMW/wPMxjbFaUz/VVwVUtohFRSSNzk
         1vP3YbOMqaWT/Y8Qpd4XoChQlpnn/p4KVxLPWfl4+D4iZGVaorta3oTQbrw19jtEzHcO
         aSM/mYkvKe/uZTa17hL1VogxRTEkxyUKkzzpjeZ8MZk1SbbnJ5s5a0WQmGjIpQMkQNJV
         +bXdtgXRwCXPz/37ckHEp0MSHu3ks74ZlOBL4iTA1vT8q1rReyNciaVTNptTCYHYonx5
         GR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ofKvXByFD2eTX9fI7pI8+9B6s6meAkUWiXIy9ZfC+QY=;
        b=aBvZ6QQW/lqYCbbyThbWxbmAJ/4z+Z5jQdBFZ8nWS6mRL7T8PlCTMJ0D30Z0OOK08v
         tCSvX62mf0JICSua3qTCD8UFZvHo3K4TUJocTaVW4rLGQrtgahyLO6gCQ2jsjub4vEZ6
         b7EKKWeJFmQEAlrGiwhjzoxxrR9D16yeCs+n/CehqPcC3v1EgKaTVjlaR7/cCjrJpOWt
         MCIDqMx99qQ8qN948VH1YAPtxSKgBrIzRPbMffWsecLEA2TB5GKoB8dew1FKpPuPuyCN
         Gj/HEmJdiYzIF+ZSbhvcke6b9HDqSbpLp5YB7eHCYWeVviftiXmVv6AwEP+M0l/98Mm3
         WHPg==
X-Gm-Message-State: AOAM5302IaXCI/Cpq3dfR8hi1xyJv6IQ+lOT22n9w9zcoE/Kc9l90yOw
        utzC8wAJ7PCw3qBc+N9Ki3z0Zw==
X-Google-Smtp-Source: ABdhPJwAlkZO19slkH+E5oDOsW1m+REbN+IIcJ/oxJ2gQ8D4+tsQbVUGfeR7TiaIlDVMQVppOKvA1g==
X-Received: by 2002:a6b:590c:: with SMTP id n12mr27341321iob.25.1600421797222;
        Fri, 18 Sep 2020 02:36:37 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id x3sm1295974ilq.81.2020.09.18.02.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 02:36:36 -0700 (PDT)
Date:   Fri, 18 Sep 2020 03:36:31 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <20200918093631.GA987554@google.com>
References: <20200918030051.650890-1-yuzhao@google.com>
 <20200918074549.GG28827@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918074549.GG28827@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 18, 2020 at 09:45:49AM +0200, Michal Hocko wrote:
> On Thu 17-09-20 21:00:38, Yu Zhao wrote:
> > Hi Andrew,
> > 
> > I see you have taken this:
> >   mm: use add_page_to_lru_list()/page_lru()/page_off_lru()
> > Do you mind dropping it?
> > 
> > Michal asked to do a bit of additional work. So I thought I probably
> > should create a series to do more cleanups I've been meaning to.
> > 
> > This series contains the change in the patch above and goes a few
> > more steps farther. It's intended to improve readability and should
> > not have any performance impacts. There are minor behavior changes in
> > terms of debugging and error reporting, which I have all highlighted
> > in the individual patches. All patches were properly tested on 5.8
> > running Chrome OS, with various debug options turned on.
> > 
> > Michal,
> > 
> > Do you mind taking a looking at the entire series?
> 
> I have stopped at patch 3 as all patches until then are really missing
> any justification. What is the point for all this to be done? The code
> is far from trivial and just shifting around sounds like a risk. You are

I appreciate your caution, and if you let me know what exactly your
concerns are, we could probably work them out together.

> removing ~50 LOC which is always nice but I am not sure the resulting
> code is better maintainble or easier to read and understand. Just
> consider __ClearPageLRU moving to page_off_lru patch. What is the
> additional value of having the flag moved and burry it into a function
> to have even more side effects? I found the way how __ClearPageLRU is

Mind elaborating the side effects?

> nicely close to removing it from LRU easier to follow. This is likely
> subjective and other might think differently but as it is not clear what
> is your actual goal here it is hard to judge pros and cons.

I like this specific example from patch 3. Here is what it does: we
have three places using the same boilerplate, i.e., page_off_lru() +
__ClearPageLRU(), the patch moves __ClearPageLRU() into page_off_lru(),
which already does __ClearPageActive() and __ClearPageUnevictable().
Later on, we rename page_off_lru() to __clear_page_lru_flags() (patch
8).

Its point seems quite clear to me. Why would *anybody* want to use
two helper functions *repeatedly* when the job can be done with just
one? Nobody is paid by the number of lines they add, right? :) And
for that matter, why would anybody want any boilerplate to be open
coded from the same group of helper functions arranged in various
ways? I don't think the answer is subjective, but I don't expect
everybody to agree with me.

Now back to your general question: what's the point of this series?
Readability -- less error prone and easier to maintain. This series
consolidate open-coded boilerplate like the following in many places.
Take lru_lazyfree_fn() as an example:

-		bool active = PageActive(page);
 		int nr_pages = thp_nr_pages(page);
 
-		del_page_from_lru_list(page, lruvec,
-				       LRU_INACTIVE_ANON + active);
+		del_page_from_lru_list(page, lruvec);
 		ClearPageActive(page);
 		ClearPageReferenced(page);
		<snipped>
 		ClearPageSwapBacked(page);
-		add_page_to_lru_list(page, lruvec, LRU_INACTIVE_FILE);
+		add_page_to_lru_list(page, lruvec);

I hope this helps, but if it doesn't, I'd be more than happy to have
more discussions on the details. And not that I don't appreciate your
review, but please be more specific than 'sounds like a risk' or 'have
even more side effects' so I can address your concerns effectively.
