Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FFF3182A9
	for <lists+cgroups@lfdr.de>; Thu, 11 Feb 2021 01:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhBKAdr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Feb 2021 19:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhBKAdn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Feb 2021 19:33:43 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6D7C0613D6
        for <cgroups@vger.kernel.org>; Wed, 10 Feb 2021 16:33:03 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id r77so3684662qka.12
        for <cgroups@vger.kernel.org>; Wed, 10 Feb 2021 16:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FI7efxdLkrLWQRe2h+l+IMlmkcYgyIFOXgeNuZLjvTM=;
        b=bycQ5yJtXDWmNNXRP0PrIO2BHNarVUWpIj1Op4PnadIWfTeHUhFPgAVAcbNAQ64VpH
         gxfTtVSlBVO097jFW+zhdqSttQpMsvicByCNN7ar5id9u5oAPtspAY74GFvlnmfEHmhC
         t8nupXeSt7Clnsv4DhVPcmUssp3sYyq0AsWT54E4hPYnU/koqUJzG/qwNWS7vPgXQQN3
         YWn2m/e8g1FiLlSmgRgP3MF4D1d3AnGrxVkUC/yuiewY42CF582D/0HpJXSjfKINY+GG
         aznJdtOMmyCCHd6oHMiKgq5Dik+4n3pRGtSCdoMQnrDnBZbDWZpcoxLRCFe2ZPWjsB/A
         wG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FI7efxdLkrLWQRe2h+l+IMlmkcYgyIFOXgeNuZLjvTM=;
        b=OuQBCKvDdIlZqF3nzZb/RgUtw2BMTXXbaSXuzJEGPKNEAMBrbQE1rWippisJTaXSCE
         H88Rwo4jfQjT5RU8b0scgATZri0A4qb7UDe7hdn+m8ybYvD6xYxHkunDS3V+ejb1MqXY
         yUy393BbZZ6qqqlZoGfhHuyMN3oi7R/q3PJORjIMLoCaD8o1LrGTwyUtWueQeqpTEqkp
         1xOH8nJCrbdLtV0KnnBg20jIUw4UPCAACGbXyeKGOBWmgYxNGyrWjpkxGt8ikxaGLmRA
         uQcCugr6ocm+TkkZiYfz5get1dQrXKM5jWIjh1zFefivDC2T2XA78vdjmHom/UEZx+mK
         bTxQ==
X-Gm-Message-State: AOAM530Adi2q9whxtog+i/QsNGIuD1pQQUvbIGHb5cDvrjN+bEjLBN17
        l0EUjuen+C/Syo3801QOlf5J9Q==
X-Google-Smtp-Source: ABdhPJw+WsFyBoPTEFShXk5UTUgRaU16ZfG6UUUpxD9HG2LBLCdo8+nkKZw9gz+A1oHoP1MvCo9r/A==
X-Received: by 2002:a37:e20b:: with SMTP id g11mr6022864qki.292.1613003582320;
        Wed, 10 Feb 2021 16:33:02 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id p12sm2428519qtw.27.2021.02.10.16.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 16:33:01 -0800 (PST)
Date:   Wed, 10 Feb 2021 19:33:00 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Arjun Roy <arjunroy@google.com>
Subject: Re: [PATCH v2] mm: page-writeback: simplify memcg handling in
 test_clear_page_writeback()
Message-ID: <YCR7PMk4RAM1uVeM@cmpxchg.org>
References: <20210209214543.112655-1-hannes@cmpxchg.org>
 <alpine.LSU.2.11.2102092058290.7553@eggly.anvils>
 <alpine.LSU.2.11.2102100813050.8131@eggly.anvils>
 <YCQbYAWg4nvBFL6h@cmpxchg.org>
 <CALvZod6vgYcpgskf7NaRagH999L6VkfnVtD1UDb+JhQceCuUEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6vgYcpgskf7NaRagH999L6VkfnVtD1UDb+JhQceCuUEA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 10, 2021 at 02:59:32PM -0800, Shakeel Butt wrote:
> On Wed, Feb 10, 2021 at 9:44 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > From 5bcc0f468460aa2670c40318bb657e8b08ef96d5 Mon Sep 17 00:00:00 2001
> > From: Johannes Weiner <hannes@cmpxchg.org>
> > Date: Tue, 9 Feb 2021 16:22:42 -0500
> > Subject: [PATCH] mm: page-writeback: simplify memcg handling in
> >  test_clear_page_writeback()
> >
> > Page writeback doesn't hold a page reference, which allows truncate to
> > free a page the second PageWriteback is cleared. This used to require
> > special attention in test_clear_page_writeback(), where we had to be
> > careful not to rely on the unstable page->memcg binding and look up
> > all the necessary information before clearing the writeback flag.
> >
> > Since commit 073861ed77b6 ("mm: fix VM_BUG_ON(PageTail) and
> > BUG_ON(PageWriteback)") test_clear_page_writeback() is called with an
> > explicit reference on the page, and this dance is no longer needed.
> >
> > Use unlock_page_memcg() and dec_lruvec_page_state() directly.
> >
> > This removes the last user of the lock_page_memcg() return value,
> > change it to void. Touch up the comments in there as well. This also
> > removes the last extern user of __unlock_page_memcg(), make it
> > static. Further, it removes the last user of dec_lruvec_state(),
> > delete it, along with a few other unused helpers.
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > Acked-by: Hugh Dickins <hughd@google.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> 
> The patch looks fine. I don't want to spoil the fun but just wanted to
> call out that I might bring back __unlock_page_memcg() for the memcg
> accounting of zero copy TCP memory work where we are uncharging the
> page in page_remove_rmap().

That shouldn't be an issue. Just add it back if/when you need it and
we have a legitimate in-tree user for it again. It still helps to
remove it now; if someboy later goes through the git log to identify
dependencies, they'll find your patch adding it and can stop looking.

Thanks for the review!
