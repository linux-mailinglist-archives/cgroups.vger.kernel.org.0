Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5299B24A6C7
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 21:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHSTV2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 15:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSTV1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 15:21:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB5DC061757;
        Wed, 19 Aug 2020 12:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KY/ct6DqDgE0xj6ePem8K1ZoSkwZfEz10n8fdqExt64=; b=ZjgtOAiMlD359oZ7PFqMt7m/N/
        HsV4xtxiFIMnMzoxngiRO9ToNhKnv+UqlargZIB9w8jJqXk/dqR9dfqj4tNwNFP5CTQkepb8vQLYd
        N6edGz+ukH9jxmgqOu+htrf4lkXBUtKapGiqzye8JfwY6EW+FDYiOi0ZBCowk7p28IJHqU2YdYM9Z
        N8xN1Pxiw6OAKzEqtWpYx9FTR1tDWShrK0WIO7VUupr7ifwcRs75x6fTzuXimm3s/Gh+R3mKKNZwL
        JXxo/oXSSodiI2qvrWAzPpqT89upwfqcvAYv1QajyLDfP9rE7MFO+DAyBvBsaEz4zb53yYXFjw6z3
        V7MxvCGw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8Te1-0000um-Sd; Wed, 19 Aug 2020 19:21:09 +0000
Date:   Wed, 19 Aug 2020 20:21:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mm: Factor find_get_swap_page out of mincore_page
Message-ID: <20200819192109.GI17456@casper.infradead.org>
References: <20200819184850.24779-1-willy@infradead.org>
 <20200819184850.24779-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819184850.24779-2-willy@infradead.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 19, 2020 at 07:48:43PM +0100, Matthew Wilcox (Oracle) wrote:
> Provide this functionality from the swap cache.  It's useful for
> more than just mincore().

The build bot showed I was missing this for some configs:

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 986b4e3d3bad..92a1f40be589 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -21,6 +21,7 @@
 #include <linux/vmalloc.h>
 #include <linux/swap_slots.h>
 #include <linux/huge_mm.h>
+#include <linux/shmem_fs.h>
 #include "internal.h"
 
 /*

I'll wait for more feedback before reposting the series in ~24 hours.
