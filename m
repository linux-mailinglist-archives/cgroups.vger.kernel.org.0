Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3799927074C
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 22:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgIRUrF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 16:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgIRUrF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Sep 2020 16:47:05 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23EFC0613CF
        for <cgroups@vger.kernel.org>; Fri, 18 Sep 2020 13:47:04 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w16so8597711oia.2
        for <cgroups@vger.kernel.org>; Fri, 18 Sep 2020 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2ZugjWO+M2gB8NAEaOpinUsTCy83ITVXPQJJCuUh0tk=;
        b=WjGWRtLtK/iF2JBGFvAFhBIIWnfYlGitLxgWOb55+90M8NWyeyAYHjMqullm40yEpn
         lmqlNP/RdMdof/dlgrXD7LIEh4QFBziiZqBFLkYpx6nqO0LhGPGEOc0jUI2Om0ofv1UI
         S/Hy5kwkEn3elzHAQrdsgG/Q9wGl2K6SM0TmW2KTpFSeBnGKYLHA64mphmfHRP2oHqcu
         Nw/MpK/R0Xy+kPNtblr1tupxRaInMGtJ8M9fnfZcWJFSLNg21CPbG28w+j/zksLAp7Vl
         8clu8q+f9R+5RyuSHTYM6Cv81znd/ZP0aNzgFVSvrVYxc8q3XTCLKcwPTT/gq68bMO0y
         Um1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2ZugjWO+M2gB8NAEaOpinUsTCy83ITVXPQJJCuUh0tk=;
        b=GLsaa6jVOiLmv18fm/JGr5WAH8un4cN/IVV6ESp65sYn0XQlXI0XOzvd6ZuzJHxoXL
         F+HJSKcfDakeG/BUrXnlQS89aKyA2sub9aU3uiwolRcilINjaW2Ni7pCxI/YA2UiiYZI
         Pyz12HnNEUDcyxuO9cBXpzAmtG6zTWDxto0Q3233U3pP4ZEsGRymmPRxyXbaIBSZkJvy
         yA8NSZwLL9gXmN/QYrmyIPNE226FMeJd92nlvUkvkPs+a7y2gd2qWe+La6I2t+xYKvRz
         p3lCfl7zNhbIzeDchWa7P5apcD/bMKFfBileyjpLTtIP/rjLlewe3k4OKxH5K8yEcjdg
         MXuw==
X-Gm-Message-State: AOAM533mjb8hm0EDh/kVH3FlSEo5xG9M8XcwMZlqA/AobASNgV38f0lW
        q8cDXBWIbnbq9G6BhHvo9+yOUw==
X-Google-Smtp-Source: ABdhPJxhcH3QXqNAiG7aPKPSB6t+sNO8rx1LG/17sQfL1FrCEcHVAqnygmkDHVSAZLGwrxyv727Pkg==
X-Received: by 2002:aca:3e08:: with SMTP id l8mr9960330oia.152.1600462023374;
        Fri, 18 Sep 2020 13:47:03 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s5sm3116602otr.42.2020.09.18.13.47.00
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 18 Sep 2020 13:47:02 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:46:59 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yu Zhao <yuzhao@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
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
In-Reply-To: <20200918030051.650890-1-yuzhao@google.com>
Message-ID: <alpine.LSU.2.11.2009181317350.11298@eggly.anvils>
References: <20200918030051.650890-1-yuzhao@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 17 Sep 2020, Yu Zhao wrote:

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
> 
> Thank you.
> 
> Yu Zhao (13):
>   mm: use add_page_to_lru_list()
>   mm: use page_off_lru()
>   mm: move __ClearPageLRU() into page_off_lru()
>   mm: shuffle lru list addition and deletion functions
>   mm: don't pass enum lru_list to lru list addition functions
>   mm: don't pass enum lru_list to trace_mm_lru_insertion()
>   mm: don't pass enum lru_list to del_page_from_lru_list()
>   mm: rename page_off_lru() to __clear_page_lru_flags()
>   mm: inline page_lru_base_type()
>   mm: VM_BUG_ON lru page flags
>   mm: inline __update_lru_size()
>   mm: make lruvec_lru_size() static
>   mm: enlarge the int parameter of update_lru_size()
> 
>  include/linux/memcontrol.h     |  14 ++--
>  include/linux/mm_inline.h      | 115 ++++++++++++++-------------------
>  include/linux/mmzone.h         |   2 -
>  include/linux/vmstat.h         |   2 +-
>  include/trace/events/pagemap.h |  11 ++--
>  mm/compaction.c                |   2 +-
>  mm/memcontrol.c                |  10 +--
>  mm/mlock.c                     |   2 +-
>  mm/swap.c                      |  53 ++++++---------
>  mm/vmscan.c                    |  28 +++-----
>  10 files changed, 95 insertions(+), 144 deletions(-)
> 
> -- 
> 2.28.0.681.g6f77f65b4e-goog

Sorry, Yu, I may be out-of-line in sending this: but as you know,
Alex Shi has a long per-memcg lru_lock series playing in much the
same area (particularly conflicting in mm/swap.c and mm/vmscan.c):
a patchset that makes useful changes, that I'm very keen to help
into mmotm a.s.a.p (but not before I've completed diligence).

We've put a lot of effort into its testing, I'm currently reviewing
it patch by patch (my general silence indicating that I'm busy on that,
but slow as ever): so I'm a bit discouraged to have its stability
potentially undermined by conflicting cleanups at this stage.

If there's general agreement that your cleanups are safe and welcome
(Michal's initial reaction sheds some doubt on that), great: I hope
that Andrew can fast-track them into mmotm, then Alex rebase on top
of them, and I then re-test and re-review.

But if that quick agreement is not forthcoming, may I ask you please
to hold back, and resend based on top of Alex's next posting?

Thanks,
Hugh
