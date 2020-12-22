Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944CC2E0490
	for <lists+cgroups@lfdr.de>; Tue, 22 Dec 2020 04:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgLVDCc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Dec 2020 22:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgLVDCb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Dec 2020 22:02:31 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E00C0613D6
        for <cgroups@vger.kernel.org>; Mon, 21 Dec 2020 19:01:51 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l23so563933pjg.1
        for <cgroups@vger.kernel.org>; Mon, 21 Dec 2020 19:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xZEe9nKbt22VK8Tq7L3dwCEv8d6KPrIVgCMxlhwxx3Q=;
        b=ToNIvWYMRuu67rHR26AoZ8LITvFFxwKDzFXUBeCMHNVl9SKWs2JiL/rESRW/P6aWJy
         K6uYZlQtdKrjpUypOhtUEmTbzBVZ1JnAbGM/S6YJMjCxSnF+nSUXZCn3KOFY2LvCS6yz
         yc7Ey0QONEBlbY7YFA13knO/pXtKTn6amSjABq3fNCUIvqUyZI1X2Z8kVdkrs0YKXy/X
         dEzx3hydhKrzU/EAU6oDiekbRHBwAXYr4n9POMB0yGtPsLSNA9+Be7PDY1SzMd5y2a+n
         5SeCwkA5h823mfelQnl3wo05eq4v51qbunVKJ1C1tFvEVszIU8m/T2XG6s27myJXTfMl
         pMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xZEe9nKbt22VK8Tq7L3dwCEv8d6KPrIVgCMxlhwxx3Q=;
        b=l8xMLars0jUMfEvL9qJHOJ8dCXSynrWVAgGOzy0cTe9Ng3ILNW8UBFDRRyuU4qHfLh
         YTjDnfVkyO/B+N+tA0zzhXAF9iKaZ8D3JH94+d381OGcUrcUaVni65K3YJO67AgN+Xut
         Aai28bzkL6eVHCCOtQlBnJ+taFhm+ETSvkinqGsmfU1yTTeiKS717lyqHUEflPi5rxch
         spGE0XgRun4SpDSg2BowI0VtDQJg3cZVRdDcauVTAdLUPAemjrSqCu/lzBtfOD1X5meH
         iN9aNNRCmbEwRU1K/M2aoqp0+3TjnVJHjo7tcgopaGE4h6M0RjGrL1ZlgH8rjrolGPXw
         xFEg==
X-Gm-Message-State: AOAM5326UE0XaNuEsMbGI56lvtZWz0LclxkbwL2hRqkBGSIah4PsSMal
        dKtHLBWkRlmY6aqq33H1t7bXHQ==
X-Google-Smtp-Source: ABdhPJxQKMQbikVhTLg7WnCqu4OC1ZFMiEFMVD8hOqdAYJTeB8Tk5LqWtoWGAW9lEgvQaZgWv4IFDw==
X-Received: by 2002:a17:90a:d502:: with SMTP id t2mr19389131pju.131.1608606110682;
        Mon, 21 Dec 2020 19:01:50 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t22sm17623091pgm.18.2020.12.21.19.01.49
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 21 Dec 2020 19:01:49 -0800 (PST)
Date:   Mon, 21 Dec 2020 19:01:37 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/memcg: revise the using condition of lock_page_lruvec
 function series
In-Reply-To: <1608186532-81218-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2012211827560.1045@eggly.anvils>
References: <1608186532-81218-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 17 Dec 2020, Alex Shi wrote:

> The series function could be used under lock_page_memcg(), add this and
> a bit style changes following commit_charge().
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Hugh Dickins <hughd@google.com>

This patch, or its intention,
Acked-by: Hugh Dickins <hughd@google.com>
but rewording suggested below, and requested above -
which left me very puzzled before eventually I understood it.
I don't think we need to talk about "a bit style changes",
but the cross-reference to commit_charge() is helpful.

"
lock_page_lruvec() and its variants are safe to use under the same
conditions as commit_charge(): add lock_page_memcg() to the comment.
"

> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/memcontrol.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b80328f52fb4..e6b50d068b2f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1345,10 +1345,11 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
>   * lock_page_lruvec - lock and return lruvec for a given page.
>   * @page: the page
>   *
> - * This series functions should be used in either conditions:
> - * PageLRU is cleared or unset
> - * or page->_refcount is zero
> - * or page is locked.
> + * This series functions should be used in any one of following conditions:

These functions are safe to use under any of the following conditions:

> + * - PageLRU is cleared or unset
> + * - page->_refcount is zero
> + * - page is locked.

Remove that full stop...

> + * - lock_page_memcg()

... and, if you wish (I don't care), add full stop at the end of that line.

Maybe reorder those to the same order as listed in commit_charge().
Copy its text exactly? I don't think so, actually, I find your wording
(e.g. _refcount is zero) more explicit: good to have both descriptions.

>   */
>  struct lruvec *lock_page_lruvec(struct page *page)
>  {
> -- 
> 2.29.GIT
