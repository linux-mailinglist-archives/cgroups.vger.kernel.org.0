Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9BE268A0E
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 13:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgINL2g (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 07:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgINL2D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 07:28:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A57C06174A;
        Mon, 14 Sep 2020 04:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3a9YiCRLSdfxT+zjyDP/va2bUubeehwvzanOvcg0GxQ=; b=ZnFpgSWDEryPzF8z+fHhQ7Shl2
        hBFm8DenBw+/t889jQOCGrpQ0rDHOLM5QHUJqsC7TICkw+13dTLpYnqWx0CdPTLoOyu8laVcTlmOI
        yxVmM2AFdyZUGoWpMbvqHA5MZw4ppabm02Qyz8GBvL0/8wsASVW0xm3Y+5PhYEfz90lpQXdG97AoZ
        /tzQ02AOeLp7eJnKP/zIe+sMez7ySzubAluHZ3CsL8xYtrxf6O0oJArjOA4k1S28+zlTh5aIiJELq
        b2uZ3guQq9luXS2rnz4d3U2dyMC2M1lebD8l63wWox7AXf2XZ0FgL6q14dyqyK+5EkK3hNS7GkwPW
        wkHTxNDA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHme2-0005if-Uf; Mon, 14 Sep 2020 11:27:39 +0000
Date:   Mon, 14 Sep 2020 12:27:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 2037ab69a5: BUG:KASAN:null-ptr-deref_in_t
Message-ID: <20200914112738.GM6583@casper.infradead.org>
References: <20200910183318.20139-7-willy@infradead.org>
 <20200914085545.GB28738@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914085545.GB28738@shao2-debian>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 14, 2020 at 04:55:45PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 2037ab69a5cd8afe58347135010f6160ea368dd0 ("mm: Convert find_get_entry to return the head page")

Thank you!

diff --git a/mm/swap_state.c b/mm/swap_state.c
index c2fb62f660a5..a22c2430e80c 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -427,6 +427,8 @@ struct page *find_get_incore_page(struct address_space *mapping, pgoff_t index)
 	struct swap_info_struct *si;
 	struct page *page = find_get_entry(mapping, index);
 
+	if (!page)
+		return page;
 	if (!xa_is_value(page))
 		return find_subpage(page, index);
 	if (!shmem_mapping(mapping))

