Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D429EDA0
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 14:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgJ2Nwh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 09:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgJ2Nwh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 09:52:37 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D07C0613D2
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 06:52:37 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p10so3081515ile.3
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 06:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5MfKe3DP7slEVa5weBChPOdwKwukAel2TnvkgswMss4=;
        b=gcRq1IeIkaEAkPFS5WKi2EPbUk5OEhwyFRIn/uaI+vOq8JeipGnDYtfvu5hPSgvNMA
         +bd5ninFYWFlPInI6dcTy24RZXWatQtR7EajDSee3Gw76Ru+sshSeR7uDtaaOpAnzqht
         M+HgpBZJiUIUGmXcDxHju67QR5p3CRkGlQMQdbKGZLG0TkOfScdJMYnEufC4/tEPY/4K
         36jdPDiqUEOkLh48UffqE2EAsI0wugobZ32NeGkq7pT7eOzUNkCemRWkTzOHU0CRlptw
         IR7EEi5NU9fJ3XOP0eUD7clmNTAYd5R+/cBVDyhT6Xw0+1wkeWcHtkoC1f8c7KJBf+0e
         Kc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5MfKe3DP7slEVa5weBChPOdwKwukAel2TnvkgswMss4=;
        b=VYbgiZSA5xLuRee5+yZaN7s4ui6dqtXcgHfIK9cLAz4fkaO3Dw2Ro37ZDHmPZ1vkMf
         o7EXX7a/SoeRig5TBm2RSmnBroGcFVH8Mczts+1Wleyk6EIr1ABRVOHdOMPTHeyceUtE
         k6zzahnM93oaVaGPlEdgBhZWICdpF5jbk6qc4V6Fa+TZvvRHIXKLQyvg+u/4LtD884Cl
         P3+NBiUF8op5DrvEJJsCok5xE1FYIhV/E6WnUzAZ038pZsH2dlxUtTGdjwP/LDsnx4Sn
         GiJhhe26bYSMsOf1782PIxctR8SsbDR4skNHOY/NXD0c/hbPGe23pD9tJRbWkn3CLdl2
         8Hvw==
X-Gm-Message-State: AOAM5319eCbL+57hyNw4htbtdUO1TJ7AohQkV+YXHmUDFD9v2UjNnt54
        M6s4UDacIKx/dqT9HiC7sLA80w==
X-Google-Smtp-Source: ABdhPJz0XWo8QheEqFIqLHIMdoioU+V5spY7FVVmUawog+0XCjCMYK7pBDQO+KfqQnhZ0KUnFK0SYg==
X-Received: by 2002:a92:aa01:: with SMTP id j1mr3469159ili.301.1603979556570;
        Thu, 29 Oct 2020 06:52:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:536c])
        by smtp.gmail.com with ESMTPSA id m66sm3217846ill.69.2020.10.29.06.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 06:52:35 -0700 (PDT)
Date:   Thu, 29 Oct 2020 09:50:47 -0400
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
        shy828301@gmail.com
Subject: Re: [PATCH v20 04/20] mm/thp: use head for head page in
 lru_add_page_tail
Message-ID: <20201029135047.GE599825@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-5-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-5-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 06:44:49PM +0800, Alex Shi wrote:
> Since the first parameter is only used by head page, it's better to make
> it explicit.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/huge_memory.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 038db815ebba..93c0b73eb8c6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2346,19 +2346,19 @@ static void remap_page(struct page *page, unsigned int nr)
>  	}
>  }
>  
> -static void lru_add_page_tail(struct page *page, struct page *page_tail,
> +static void lru_add_page_tail(struct page *head, struct page *page_tail,

It may be better to pick either
	head and tail
or
	page_head and page_tail

?
