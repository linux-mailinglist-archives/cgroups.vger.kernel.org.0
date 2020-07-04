Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC49E21458E
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgGDLmj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 4 Jul 2020 07:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgGDLmj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 4 Jul 2020 07:42:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6B4C061794;
        Sat,  4 Jul 2020 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MXpoH39hkfx8lgKVBovhjF5ANO4ljnFW8iWeu9q4FtE=; b=iP6/CNSCbNXBo+C/p41wEdgqOs
        Jr4msbp5S/4stoYRzupozCzahdW4W5qLA9rFE/jAJGafZzoTOWq/BtD0LPnMvRdZAJXEUXzA010OC
        wmYNupFLw0kEnngYZDcewEmwgTgPupAdv71XGlf8Mli9TxBAj3g1tIWPIqU6Ez+Mzr9aAiNExKS4u
        0qsXJLoqJ4SlS2+zhU2Orlh37xa8EOmq3xh8FAAwnSgBjB8F6fpRecx3YR4bpQWAo03LZDvzg7EzF
        uVwk2cwG0r3ZxLCtnYzOPq/50Uy2RS5XDCduvq5ZvNsXbvtvqqJLPEFMyhEKEOQ7cZk/omxY9Zx5R
        vwdW2zOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrgWG-0007pl-O0; Sat, 04 Jul 2020 11:39:44 +0000
Date:   Sat, 4 Jul 2020 12:39:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        =?utf-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0KXQu9C10LHQvdC40LrQvtCy?= 
        <khlebnikov@yandex-team.ru>, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, Johannes Weiner <hannes@cmpxchg.org>,
        lkp@intel.com, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, shakeelb@google.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, richard.weiyang@gmail.com
Subject: Re: [PATCH v14 15/20] mm/swap: serialize memcg changes during
 pagevec_lru_move_fn
Message-ID: <20200704113944.GN25523@casper.infradead.org>
References: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
 <1593752873-4493-16-git-send-email-alex.shi@linux.alibaba.com>
 <CALYGNiOkA_ZsycF_hqm3XLk55Ek1Mo9w1gO=6EeE35fUtA0i_w@mail.gmail.com>
 <56e395c6-81e7-7163-0d4f-42b91573289f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56e395c6-81e7-7163-0d4f-42b91573289f@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 04, 2020 at 07:34:59PM +0800, Alex Shi wrote:
> That's a great idea! Guess what the new struct we need would be like this?
> I like to try this. :)
> 
> 
> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
> index 081d934eda64..d62778c8c184 100644
> --- a/include/linux/pagevec.h
> +++ b/include/linux/pagevec.h
> @@ -20,7 +20,7 @@
>  struct pagevec {
>         unsigned char nr;
>         bool percpu_pvec_drained;
> -       struct page *pages[PAGEVEC_SIZE];
> +       struct list_head veclist;
>  };

pagevecs are used not just for LRU.  If you want to use a list_head for
LRU then define a new structure.

