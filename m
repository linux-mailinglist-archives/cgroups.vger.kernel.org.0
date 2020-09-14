Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8951A269227
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgINQxD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 12:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgINQun (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 12:50:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EBAC06174A;
        Mon, 14 Sep 2020 09:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ONEBRln/W01sImpX9+NYKevjldL0jmS6ROdAPg7RGBo=; b=d20rYKoM3MFFGhKV+vJP3AYgTj
        mwiFsplmERWLiFhdGa/edRGM+Qj9ahLzBKxByDwrrNrodrlLBFd+1uxwJNSncFSR/DD/F8eYJ5rpd
        EWsrP4oBnQqVW69V09WhLgJDPlKrXa8ft32xDOYXKu7Bgk67FVD/8Jbrd6iHTXw2MTrw/1EsWJ3ne
        U0zv3kyDd+IGx1DtSu4NHxadm7YDbRJCUD6CifAvTitUWGFAaXv+75kmqz8whwirQbRHFU2JP0SQa
        20qFkwfkN4dRDAt7KOAwTrSVq9FT/o5iGlEJyqm8QeKBfLHUzYc5Q4s1ILBQr52OTeC3zWItAqCYw
        TLiYM1yg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHrgX-0001cn-28; Mon, 14 Sep 2020 16:50:33 +0000
Date:   Mon, 14 Sep 2020 17:50:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@redhat.com>
Cc:     linux-mm@kvack.org, intel-gfx@lists.freedesktop.org,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Auld <matthew.auld@intel.com>
Subject: Re: [PATCH v2 3/8] mm: Optimise madvise WILLNEED
Message-ID: <20200914165032.GS6583@casper.infradead.org>
References: <20200910183318.20139-1-willy@infradead.org>
 <20200910183318.20139-4-willy@infradead.org>
 <c48c5eaa09d1ea5b78b12b545c034d1e937c49ba.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c48c5eaa09d1ea5b78b12b545c034d1e937c49ba.camel@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 14, 2020 at 12:17:07PM -0400, Qian Cai wrote:
> Reverting the "Return head pages from find_*_entry" patchset [1] up to this
> patch fixed the issue that LTP madvise06 test [2] would trigger endless soft-
> lockups below. It does not help after applied patches fixed other separate
> issues in the patchset [3][4].

Thanks for the report.  Could you try this?

diff --git a/mm/madvise.c b/mm/madvise.c
index 96189acd6969..2d9ceccb338d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -234,6 +234,7 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 
 		if (!xa_is_value(page))
 			continue;
+		xas_pause(&xas);
 		rcu_read_unlock();
 
 		swap = radix_to_swp_entry(page);
@@ -243,7 +244,6 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 			put_page(page);
 
 		rcu_read_lock();
-		xas_reset(&xas);
 	}
 	rcu_read_unlock();
 
