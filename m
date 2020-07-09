Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215C921A418
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2020 17:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgGIPzj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Jul 2020 11:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGIPzj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Jul 2020 11:55:39 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B12FC08C5DC
        for <cgroups@vger.kernel.org>; Thu,  9 Jul 2020 08:55:39 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c11so1439478lfh.8
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2020 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ko2toLCZVcB1lleYvRhScChtwEJOK0oSQV22Yurja2Q=;
        b=Uc4CCtMLCs3lO9xhdmBONzGWRiRwT9i1ZMePGIYt4l0xaGLYpohw0IerOblGgyhLoW
         AT5UmJkwwuxoQRcctui1mXrBp211sfFdtr7d5kPb5DLJKl327ienkkdxSaj8OuYdeb0V
         gD1sYjx5U1/q4X6Lx2NbhLKuVFaBneMzUK5o+BllCwhWYGnXAbgfroWFhQSbqErEmWDK
         +AP91wv6In/CR0I+dXAnClibT5z9pp3YulfddtucRksexscSOh1ki4NY5LEcEYtJB1y0
         5GdX3YRnyOvUjqVkLqhHFf5V1TWpqXAIYide9TRITdEoQ58rlC8+trgvboocTbHdQGcQ
         dI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ko2toLCZVcB1lleYvRhScChtwEJOK0oSQV22Yurja2Q=;
        b=qtrXbj80Q+UJwqb4JSrjfZMpwMCjxL7kepaWlrODZ/xhXoRMxYUSgY37NS3ten/NBm
         eMC1aqjIzE9OnawxRF3YO0H/5SfT/UqvdjeuaqvEtX7mby1Wlzly3WD6SRW5cpuKmZ5h
         LD0o1NC2dTteoQmMsl9jGLWT5d8m1XwgC/VOEn0Sb1W1CJlp8szaxSFKoOx0GUn+nMLx
         GQQkTWCIVLZQRAicodsqUwA+FhzUEOjKo5E2xycMaRMBC2R9jv6qZurL9YU3/XqpYcSa
         O+ZXuiKg5FvUNnLBsh7Jka8zgERfP5ZMUrHRJ/N12tiOjUlotfB7/0YX+pUsdDZJvnd4
         707A==
X-Gm-Message-State: AOAM532SKx9bKKv44eDJwFacP5eFU8GuvI2ijt7EVv7XQLWnf27fxSEl
        sDPvrpOsFHbdihJudXSJ6LBiwg==
X-Google-Smtp-Source: ABdhPJz4tCeIwbs8YS4yldpnaa+nxdD/inUHg/Ru6+3qcswHKG+9xwpsXiqVxAdhy33UuaZPpmiZ1Q==
X-Received: by 2002:a05:6512:250:: with SMTP id b16mr39400876lfo.67.1594310137811;
        Thu, 09 Jul 2020 08:55:37 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q21sm933168ljj.67.2020.07.09.08.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 08:55:37 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BD87510222B; Thu,  9 Jul 2020 18:55:38 +0300 (+03)
Date:   Thu, 9 Jul 2020 18:55:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: Re: [PATCH v15 05/21] mm/thp: move lru_add_page_tail func to
 huge_memory.c
Message-ID: <20200709155538.mf3gxutgckz7p67i@box>
References: <1594122412-28057-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594122412-28057-6-git-send-email-alex.shi@linux.alibaba.com>
 <9fa2cf92-c4a0-02ca-1f02-7ef71952de18@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fa2cf92-c4a0-02ca-1f02-7ef71952de18@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 07, 2020 at 08:00:11PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/7/7 下午7:46, Alex Shi 写道:
> >  
> > +static void lru_add_page_tail(struct page *page, struct page *page_tail,
> > +				struct lruvec *lruvec, struct list_head *list)
> > +{
> > +	VM_BUG_ON_PAGE(!PageHead(page), page);
> > +	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
> > +	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
> > +	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
> > +
> > +	if (!list)
> > +		SetPageLRU(page_tail);
> > +
> > +	if (likely(PageLRU(page)))
> > +		list_add_tail(&page_tail->lru, &page->lru);
> > +	else if (list) {
> > +		/* page reclaim is reclaiming a huge page */
> > +		get_page(page_tail);
> > +		list_add_tail(&page_tail->lru, list);
> > +	} else {
> > +		/*
> > +		 * Head page has not yet been counted, as an hpage,
> > +		 * so we must account for each subpage individually.
> > +		 *
> > +		 * Put page_tail on the list at the correct position
> > +		 * so they all end up in order.
> > +		 */
> > +		add_page_to_lru_list_tail(page_tail, lruvec,
> > +					  page_lru(page_tail));
> 
> 
> I missed some points for this function, since in the call chain:
> split_huge_page() to lru_add_page_tail, the head page's lru won't be
> set when !PageLRU(head). But the other page_tail are add to lru list here
> Is it ok for this situation?

It doesn't differ from the situation when some pages are isolated from
LRU. Tail page has become completely on its own after
__split_huge_page_tail() has completed, it's not tied to the head page.

-- 
 Kirill A. Shutemov
