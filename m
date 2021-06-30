Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF313B891B
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 21:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhF3TVh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 15:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbhF3TVh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 15:21:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082D7C061756
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 12:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MsrlUX4klm+FZH6y60kQ4JaEGGQ1KiVKPX9RLosVC/A=; b=oWqhqkrj/cGxMBXJ0t4A7GnsgF
        tzd1jjKb5Jh73NmQgh8pGHPiFZfe1ypWOP3t77n30a3B9TKgK2UvmUt2RSOAx1AHlzGe7nRmtyykH
        1mCpYJSItTlWNiXMPthvzGh4/cMCYhngz0QBrOp4JICQve+BsCJUJeBtGbV52/IbMT7LwvTcvaRaO
        LNguFtTihlOOpYTb0S8/CA9UlGW5FXWFFmna8CdF/4Kmh9+Nk6rDDqiIifK3TN7yCeETVTyFvDEER
        CcjWHjwdytU2FhuibAsB9XVx9yfygHaiby4NRz3EZzziZYsTi21MFe5X7JnvsLBmU+vxnSD6MiJ4J
        HwC/C3CQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyfjF-005hO6-Rc; Wed, 30 Jun 2021 19:18:45 +0000
Date:   Wed, 30 Jun 2021 20:18:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 15/18] mm/memcg: Add mem_cgroup_folio_lruvec()
Message-ID: <YNzDiTFZpRgKY0CE@casper.infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-16-willy@infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 30, 2021 at 05:00:31AM +0100, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of mem_cgroup_page_lruvec().

I'm just going through and removing the wrappers.

Why is this function called this?  There's an odd mix of

lock_page_memcg()
page_memcg()
count_memcg_page_event()
split_page_memcg()

vs

mem_cgroup_charge()
mem_cgroup_swapin_charge_page()
mem_cgroup_lruvec()
mem_cgroup_from_task()

I'd really like to call this function folio_lruvec().  It happens to
behave differently if the folio is part of a memcg, but conceptually,
lruvecs aren't particularly tied to memcgs.


... are there any other functions you'd like to rename while I'm
changing pages to folios?
