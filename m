Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FAF3B8DF0
	for <lists+cgroups@lfdr.de>; Thu,  1 Jul 2021 08:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhGAG7b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jul 2021 02:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbhGAG7b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jul 2021 02:59:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20204C061756
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 23:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=AgYv3eVv0xvsLDo0HnmAr3kYRe
        l0WMswRmdCB1AuL9DPWQ42bnc0vdylSbP0rYvlA6GhuF64OTAacVA9qh0Kav/P9Y8yCw8m5UjvQPW
        L1oFEYscb7roSY8GdSTm29ktTnFIPeRtB83l6WgIIHraMOX9MfhB6u+PeQRLshnfqTFctjLtTUJPw
        ROh/SQFtX/pg6kLYJMG0ESvdEMdvwL/3+t3ivtG6A5cMRKxsjbzJ7v6bmvIjM8JYMrODh430qK3Ck
        6AlphtOVKCF6evmOovPOc4A/1ZLlBWfRlplYw8Qyr5xMVwLHRtlF4OHDVgwoKAaXgAXiPyfbHYpys
        46BAXDMw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyqcY-006GkW-HG; Thu, 01 Jul 2021 06:56:29 +0000
Date:   Thu, 1 Jul 2021 07:56:22 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 01/18] mm: Add folio_nid()
Message-ID: <YN1nFlmsBe0d10nX@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
