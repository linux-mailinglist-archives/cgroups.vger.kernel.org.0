Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8013B8E09
	for <lists+cgroups@lfdr.de>; Thu,  1 Jul 2021 09:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhGAHL6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jul 2021 03:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbhGAHL6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jul 2021 03:11:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB34C061756
        for <cgroups@vger.kernel.org>; Thu,  1 Jul 2021 00:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=50uiSuVXb7YRWg4xmPpIJvUycemcgynDMzy6r4j5vw0=; b=TgBSC4NNc2oE0SQcaRdVKhuZIj
        p3ITr1LECpUxNWf21zenVH8kh1LlcOTqWL4W8D/Eb/HsjNWaju2z3AaWyt3FS8MlQbavBIkSVlxWR
        AhQCOxMAYWts8he5zs9Q6ulfHRdwj7Y5A9EkJ9BBd9zDsqWNS6dn1ZftYusR9Q91vg6Z9vqUoQGMM
        J47oVTYtOUpuHmr8fAYmcuGKeOOYoQb7U0cRVf2FwawAN4LQvLjuH2sMS8skiihK8+0CumkJkkOSU
        ArplK9Vxo1mhDF8rjS9ojXPLuihLJguFGXsumsk1VK4ccvK3NxMOtA6MvbXKe7aKw0PVO9ogIrLbh
        1kI01A3Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyqov-006HOh-Qv; Thu, 01 Jul 2021 07:09:12 +0000
Date:   Thu, 1 Jul 2021 08:09:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 04/18] mm/memcg: Remove soft_limit_tree_node()
Message-ID: <YN1qFcKFNYWvHnM6@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 30, 2021 at 05:00:20AM +0100, Matthew Wilcox (Oracle) wrote:
> Opencode this one-line function in its three callers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
