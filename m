Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77582A2D79
	for <lists+cgroups@lfdr.de>; Mon,  2 Nov 2020 15:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgKBO4q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Nov 2020 09:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgKBO4q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Nov 2020 09:56:46 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CABBC0617A6
        for <cgroups@vger.kernel.org>; Mon,  2 Nov 2020 06:56:46 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id c5so9350839qtw.3
        for <cgroups@vger.kernel.org>; Mon, 02 Nov 2020 06:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y0YbMA6MgS0VVP9wIqs606A+W5kzypLLo2uJ5yzWsp8=;
        b=1vhVi/TIRF7BDl6cNAGmMWQ9H4M2phsWWXLUY+8VngGCC6WkJ7vRPZNIkcIgeJ9jvM
         5tTwdWw/u00Bk92JyiLPxRLPS2Rt05dwhH2rAyGgzzzazKkXKAU+3yy37KckDYxXvGu3
         GZhiVeifeLhbd4cl833PsnioynbYERlWVuXrFXIBcgd2bpsFgWSNHUeP+a2aaWmIwBsM
         OHdTBVX/zEtZSuKU+cbInOiTtXvGRVLhUq7WMVe5cyjM54irjsvZPQsyw9JOpj72PPTK
         +QF/D3nTqK0nO8uQF4mXTohlgqWuEJTJWWhtVyeDiMRXtO9fo0k+jSoDtfkZldv0xd0I
         wJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y0YbMA6MgS0VVP9wIqs606A+W5kzypLLo2uJ5yzWsp8=;
        b=TiKXAzFOSI5+GDd6Fku3uBI+akX7SMhh0GRjiY4o1ADX5+5+ELM/EZRfFuFGKnuOTD
         bEax3La2wDHqa+TNKKYKgW+OQv1fNCmhcMPRqOACo94tT4XDQ2oecFO8gzSQy3Sm4C32
         KS5l4DbSZm2bB6xzLM3f1yniYlCRDaSj0Mt9g8muH+GICEqQ/uSYgZozOylvjuhp/aST
         v3bLklckUPIS2qJ8k41Tm3CQHMLPy+62b6rAU4wn2c68x9dlLE9o5WzPCdQlX6c+LgZt
         joIEZoTg5V8nNy7LGbjMb6P5MMKpOKUOh/RLyLwv6YntqZCme2nT+SXfy1hExZo4rGJR
         dN3Q==
X-Gm-Message-State: AOAM530bKL7lUg60wziTSQu2thU1Y2JLYehROKwNAVACpqVWU9t0m2XU
        Dv2sd9ek9onOAAxl9/A854ew6Q==
X-Google-Smtp-Source: ABdhPJw1ZdW/lqa6VECafrpbgJu7XEH+T2QMW3IofuNFTjhThZ39B/uFy2H2Ojo6YrZGmoX+m11GQg==
X-Received: by 2002:ac8:5909:: with SMTP id 9mr4991633qty.382.1604329005744;
        Mon, 02 Nov 2020 06:56:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2f6e])
        by smtp.gmail.com with ESMTPSA id k64sm8183844qkc.97.2020.11.02.06.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:56:45 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:55:00 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v20 13/20] mm/mlock: remove lru_lock on
 TestClearPageMlocked
Message-ID: <20201102145500.GF724984@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-14-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-14-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 06:44:58PM +0800, Alex Shi wrote:
> In the func munlock_vma_page, comments mentained lru_lock needed for
> serialization with split_huge_pages. But the page must be PageLocked
> as well as pages in split_huge_page series funcs. Thus the PageLocked
> is enough to serialize both funcs.
> 
> Further more, Hugh Dickins pointed: before splitting in
> split_huge_page_to_list, the page was unmap_page() to remove pmd/ptes
> which protect the page from munlock. Thus, no needs to guard
> __split_huge_page_tail for mlock clean, just keep the lru_lock there for
> isolation purpose.
> 
> LKP found a preempt issue on __mod_zone_page_state which need change
> to mod_zone_page_state. Thanks!
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
