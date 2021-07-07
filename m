Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521EC3BF042
	for <lists+cgroups@lfdr.de>; Wed,  7 Jul 2021 21:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhGGTbf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Jul 2021 15:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGGTbf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Jul 2021 15:31:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7875EC061574
        for <cgroups@vger.kernel.org>; Wed,  7 Jul 2021 12:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BhBZWEYcFlxuVvSAsmS5gv8zy8o+jsEbcEExhMSd3eo=; b=BrPBSSUj/JX65304k1+dRXGvWR
        dZhuNplsCU/8NOxj2QAX23zHkqjvzASJDGZg9JyRcV6Cggsd2/MeFuRbiL0eRTUP4PhIj9Mr7yIM5
        TBGA+az2hYFZMGC393mxnuIdzaH1Y7Okd1BcyLFr80krULTUd+KyPgCX6mZixz0u5Sr1oDXSTcpFd
        +/Kh0a8SgbvSh9BrcomsmviViFOmBCj4Fp8PFpXZ7VJ6ebhTa/NbNygM/CrC0DOnNubdwA067oYGJ
        y3tpw/EJXLXdKKnIPurDGyowfgMbQv0JNYXzfA1yly44GzPsN3wC6QW18Vc1jrps8hW25w2SsSFbr
        Uf7efN7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1DDr-00Ck4p-C0; Wed, 07 Jul 2021 19:28:42 +0000
Date:   Wed, 7 Jul 2021 20:28:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 13/18] mm/memcg: Add folio_memcg_lock() and
 folio_memcg_unlock()
Message-ID: <YOYAZ5+xDFK0Slc8@casper.infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-14-willy@infradead.org>
 <YOXfozcU8M/x2RQ4@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOXfozcU8M/x2RQ4@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 07, 2021 at 01:08:51PM -0400, Johannes Weiner wrote:
> On Wed, Jun 30, 2021 at 05:00:29AM +0100, Matthew Wilcox (Oracle) wrote:
> > -static void __unlock_page_memcg(struct mem_cgroup *memcg)
> > +static void __memcg_unlock(struct mem_cgroup *memcg)
> 
> This is too generic a name. There are several locks in the memcg, and
> this one only locks the page->memcg bindings in the group.

Fair.  __memcg_move_unlock looks like the right name to me?
