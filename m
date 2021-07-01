Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7EF3B8E20
	for <lists+cgroups@lfdr.de>; Thu,  1 Jul 2021 09:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhGAHXZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jul 2021 03:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbhGAHXY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jul 2021 03:23:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88C9C061756
        for <cgroups@vger.kernel.org>; Thu,  1 Jul 2021 00:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2/0xo8Pb2WVfKAJOsLbHqk9I4cw9p84KsjkT2rmHhdw=; b=R5AkJKPBcNT43NaRbYf0jqvU9m
        1pT10ur4pPswKyKqwkn4ubcJ6ym1IujcGo++cl9hANZrzu/0kfr1cJC3qlxj4vcGvunviq5sh9RfU
        7F2v5vSWuNYNhuZ5CzgA79cl02CXH3yWJgdqbEiuv4QEeBg/G4JBz2KUB2AcGLn80qFQdV8/q9cfK
        UWt0qxe4Zo/EcNo1nBVbW2yipSoNKfv4NSuTidnNnfrFNVMAQgCsr6TaXtxAYtyDVrBOKGOTioIZP
        DcnElL1R7AuMpLIAiZx7jKVtoVPqn1E0H9/cJdIlEGjLcwuA95HYTgnczT9m2f9sXUY1NEtnTL8Ro
        15HVzzAA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyqzV-006I3R-Lv; Thu, 01 Jul 2021 07:20:25 +0000
Date:   Thu, 1 Jul 2021 08:20:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 11/18] mm/memcg: Convert mem_cgroup_migrate() to take
 folios
Message-ID: <YN1spXpTskTdLE6y@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-12-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 30, 2021 at 05:00:27AM +0100, Matthew Wilcox (Oracle) wrote:
> Convert all callers of mem_cgroup_migrate() to call page_folio() first.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
