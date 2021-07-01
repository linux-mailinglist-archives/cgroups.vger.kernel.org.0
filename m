Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04AB3B8E17
	for <lists+cgroups@lfdr.de>; Thu,  1 Jul 2021 09:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhGAHSz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jul 2021 03:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbhGAHSz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jul 2021 03:18:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EEDC061756
        for <cgroups@vger.kernel.org>; Thu,  1 Jul 2021 00:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=mW9SyOz/AChaORZcbuh5K65wt+
        /NPWit8FVCVcM/ZsioJsURaVA7Wa3h2tykTk9j8T8XCzL6X8zBD3r5ngp7YlEmA2UlW7wb//U52Uo
        +GQiBRSUvCQRkMMy995wbtivpuIEKm8Zs5P2ZK3+RlEbrhf6gkOGlV0bUuhEDYctdydc8YHAwszYM
        1q7ZmT1lZQhxXThirKX6rKsmDUHrqRF+F4O+FHLZ1uD5gUoE3wsakRXpRiv12ih/otMkx/I3YSBRv
        LEbbl72TWIt9QaNLVa0kR21Xlu1I3OjvH9ahBEJ4VNsC04YjO2jP4DeYpvy3XbASxLQ313hzM47ks
        ow6zKHog==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyqvB-006Hiz-IK; Thu, 01 Jul 2021 07:16:00 +0000
Date:   Thu, 1 Jul 2021 08:15:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 09/18] mm/memcg: Convert uncharge_page() to
 uncharge_folio()
Message-ID: <YN1rmQLAAJ+PD3Ls@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-10-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
