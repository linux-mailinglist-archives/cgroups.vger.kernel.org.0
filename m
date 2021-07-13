Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64E53C70E5
	for <lists+cgroups@lfdr.de>; Tue, 13 Jul 2021 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhGMNG4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Jul 2021 09:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbhGMNG4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Jul 2021 09:06:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFB8C0613DD;
        Tue, 13 Jul 2021 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YR7NATxyKSxd5HD27IiNLrRjQZNsZ/ojvafQvUdLxNY=; b=CN0WbhvMWKDho8nug9H1cMQrn/
        56K6kuqZIyHLhPL3Tzt3IbD00nRBJ3r9EO31MguM4nAxpGWRZXFWWwplLgxg9UEIkyJm33PcooHd1
        GoGT0lt19FtzGSzJMlxE5tq44Apaq3hqGiDFdK8xgk+Yg/QgH6E/RsI7auFZb+P91zm/EMT4rkHIZ
        Wyp5DyhCDs0HW71HNtFImlHC7l7tkk8WBJRJemKDMaL4zGUwgyM0CIcJa6gkr8lcr7a8bIkxo/ISD
        qiY8p5z9FvQl1LKw148A6zpwrrqI1IJBeAs4LSYJfES33bEWmcsOMcEuPqbC30D7v0AZMMCTt0tWf
        aibAwPWQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3I4r-0017PJ-SV; Tue, 13 Jul 2021 13:03:58 +0000
Date:   Tue, 13 Jul 2021 14:03:57 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v13 17/18] mm/memcg: Add folio_lruvec_relock_irq() and
 folio_lruvec_relock_irqsave()
Message-ID: <YO2PPZE7gQqvQRl1@infradead.org>
References: <20210712194551.91920-1-willy@infradead.org>
 <20210712194551.91920-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712194551.91920-18-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 12, 2021 at 08:45:50PM +0100, Matthew Wilcox (Oracle) wrote:
> These are the folio equivalents of relock_page_lruvec_irq() and
> folio_lruvec_relock_irqsave().  Also convert page_matches_lruvec()
> to folio_matches_lruvec().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
