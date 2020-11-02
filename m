Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089B52A2DC4
	for <lists+cgroups@lfdr.de>; Mon,  2 Nov 2020 16:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgKBPL4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Nov 2020 10:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgKBPL4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Nov 2020 10:11:56 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0756C0617A6
        for <cgroups@vger.kernel.org>; Mon,  2 Nov 2020 07:11:54 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id t5so804882qtp.2
        for <cgroups@vger.kernel.org>; Mon, 02 Nov 2020 07:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UPtv4U9PJYklpaVPZSIF4wy6HpZ+y+9XSdus7akqhs8=;
        b=fvxCbUcg/TaoIHaH+KHaeKyaSujnKcSUTkmfqyKh/QkKJK9U7Sv6hkYTJZuE9PsDOH
         qf1Tnz2zslvTItDBBEGYItyQGojO3aAIR8eUaSJpcqXBn5EEyU5wQLTeRy6/NiByQvOL
         tc249Rsimsi+EMBEKIonliNDNG5ojtn9hnKe3eyWzN95l7neNpaTO8/2yelL57HdyFM/
         ttrYwXC6tcJvxMjYh9r4+Qoj8BFXE/p+GN5LA2/SoF5V7ZReJ2GkiN1jq3m35x2uvVDc
         xTtw2g7qK6VknF3fnO5bwz2y19yw58hf79Y22XgqerPNif0SPlCz8eN78jXHIUeirN0M
         2Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UPtv4U9PJYklpaVPZSIF4wy6HpZ+y+9XSdus7akqhs8=;
        b=nNr/wcfdBcK1JxUny7eGSWQ/+317wHPO6lSIH0WGsju2XrVzleOyBs/84ZfACgSQiW
         xym+xub+6hwSJ3lEdOIMkWBcYYB2dmzG/PSxikBAodZuP4iHzCtRXHIawtPK8nJ7qhGh
         bVkwM1cnU4VU1X5b2VMXjQkthvVWYW7BsJU3oz89CxMBtUSbr85DAlEGPGtRys3rIoBB
         3nXfdwVcluiXQsoLbdGLVzVHK6/3dpaCNgn2XtEomkcH+pff5GP8XwFadWqgZMk67nyu
         LT0GWHXJKxO6jE65xm1jemRhupJwLnmmFB9DENlLTuTSsEHBbvBRocJZXaoCFSuX2GbK
         uujg==
X-Gm-Message-State: AOAM532g/xXMhH18hTuVTXdxyVmxwPG77bI66fSbSjipTGTO4t0ai5PA
        M/fx33mSP0jaVUgBz31RXba1SA==
X-Google-Smtp-Source: ABdhPJxGgGlrJP934R5ihqM55D4zloX84/xMg/6bsipL0oceVlXCG3ieSqhwKu6fQ7ldx9JiYp4Lng==
X-Received: by 2002:aed:3943:: with SMTP id l61mr14846566qte.195.1604329913801;
        Mon, 02 Nov 2020 07:11:53 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2f6e])
        by smtp.gmail.com with ESMTPSA id t70sm8003983qke.119.2020.11.02.07.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 07:11:53 -0800 (PST)
Date:   Mon, 2 Nov 2020 10:10:08 -0500
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
        shy828301@gmail.com, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v20 15/20] mm/lru: introduce TestClearPageLRU
Message-ID: <20201102151008.GH724984@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-16-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-16-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 06:45:00PM +0800, Alex Shi wrote:
> Currently lru_lock still guards both lru list and page's lru bit, that's
> ok. but if we want to use specific lruvec lock on the page, we need to
> pin down the page's lruvec/memcg during locking. Just taking lruvec
> lock first may be undermined by the page's memcg charge/migration. To
> fix this problem, we could clear the lru bit out of locking and use
> it as pin down action to block the page isolation in memcg changing.

Small nit, but the use of "could" in this sentence sounds like you're
describing one possible solution that isn't being taken, when in fact
you are describing the chosen locking mechanism.

Replacing "could" with "will" would make things a bit clearer IMO.

> So now a standard steps of page isolation is following:
> 	1, get_page(); 	       #pin the page avoid to be free
> 	2, TestClearPageLRU(); #block other isolation like memcg change
> 	3, spin_lock on lru_lock; #serialize lru list access
> 	4, delete page from lru list;
> The step 2 could be optimzed/replaced in scenarios which page is
> unlikely be accessed or be moved between memcgs.

This is a bit ominous. I'd either elaborate / provide an example /
clarify why some sites can deal with races - or just remove that
sentence altogether from this part of the changelog.

> This patch start with the first part: TestClearPageLRU, which combines
> PageLRU check and ClearPageLRU into a macro func TestClearPageLRU. This
> function will be used as page isolation precondition to prevent other
> isolations some where else. Then there are may !PageLRU page on lru
> list, need to remove BUG() checking accordingly.
> 
> There 2 rules for lru bit now:
> 1, the lru bit still indicate if a page on lru list, just in some
>    temporary moment(isolating), the page may have no lru bit when
>    it's on lru list.  but the page still must be on lru list when the
>    lru bit set.
> 2, have to remove lru bit before delete it from lru list.
> 
> As Andrew Morton mentioned this change would dirty cacheline for page
> isn't on LRU. But the lost would be acceptable in Rong Chen
> <rong.a.chen@intel.com> report:
> https://lore.kernel.org/lkml/20200304090301.GB5972@shao2-debian/
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
