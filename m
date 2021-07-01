Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2C03B8DFC
	for <lists+cgroups@lfdr.de>; Thu,  1 Jul 2021 08:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhGAHBU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jul 2021 03:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbhGAHBT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jul 2021 03:01:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED9BC061756
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BSVgnYAxe2R8PoaegIcaOoM7XZhNbeX1pTTSxEBVoac=; b=t2TBq0380ll/0c0dnlNJtyZH4Q
        pZ3uqtk2mYqILxxYvHtGcznBcCHp0665VeItnTBAzfFHNF3MBv7Fbg6qF+X0RZJGPqitmulCAESR8
        +yUfMbKqkpwCHAT+t5yQJ764GhUa5eoV2iO2rybbGnSK4BAEQOnfJOxKpoewRHjXSqbOZ7A30wLzb
        VK2FDWW602qB1Pnp7QK6g/y7oJd18Dj9OgPOUDt2VvOoCqFrbK3sYJg3wGpmotD5Em8lCMvht0Axu
        LQlBP8UbAZPT5raIsKeXxztu6i8DFuVQWh6y1F6TL4T475qRkSW0oCA5c9XTVG+JHdpVNsySgfvCw
        Uu9os80Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyqdr-006GrK-EC; Thu, 01 Jul 2021 06:58:00 +0000
Date:   Thu, 1 Jul 2021 07:57:43 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 03/18] mm/memcg: Use the node id in
 mem_cgroup_update_tree()
Message-ID: <YN1nZ2O86Qa9DOk2@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 30, 2021 at 05:00:19AM +0100, Matthew Wilcox (Oracle) wrote:
> By using the node id in mem_cgroup_update_tree(), we can delete
> soft_limit_tree_from_page() and mem_cgroup_page_nodeinfo().  Saves 42
> bytes of kernel text on my config.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
