Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDBC3B8E15
	for <lists+cgroups@lfdr.de>; Thu,  1 Jul 2021 09:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhGAHRH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jul 2021 03:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbhGAHRH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jul 2021 03:17:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537DFC061756
        for <cgroups@vger.kernel.org>; Thu,  1 Jul 2021 00:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=kfGWG7hzfK/7CWSfeCOfHhOX5l
        2z2Pkj/A2GB1yLOl+LikHofKAxneM6iOkd+7kuc3BXeUA0Dk61NhnmqoVBNbVeQJbXn4gvFdQplS2
        y0iBZ/3qPA4Q8/76B0Ntm0yL8iRJrOGY1EjoHPZ39s5JwqpKDu1zZB9NUGqaizzK5DRvKSShFv5T0
        JUPsn+fV1km3Ls2/COtkP4Nir2G7VZDrlVc63qUu3D4sPHGo3MDAm5yOr6aBHHP1ZxunfmVjZSLnO
        sc1ttjnsFSkm1begW8vsnvskdTniEK8gs69rCXUaua/s4dyLEwA55wxkeGbA5QSOzo7mrBI0qg/wM
        3IufDI4g==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyqtJ-006HdV-Ey; Thu, 01 Jul 2021 07:14:00 +0000
Date:   Thu, 1 Jul 2021 08:13:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 08/18] mm/memcg: Convert mem_cgroup_charge() to take a
 folio
Message-ID: <YN1rJSfL4XTu8G9e@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
