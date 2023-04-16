Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537BB6E3B82
	for <lists+cgroups@lfdr.de>; Sun, 16 Apr 2023 21:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjDPTZo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 16 Apr 2023 15:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDPTZn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 16 Apr 2023 15:25:43 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED022123
        for <cgroups@vger.kernel.org>; Sun, 16 Apr 2023 12:25:40 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54fbb713301so156457617b3.11
        for <cgroups@vger.kernel.org>; Sun, 16 Apr 2023 12:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681673140; x=1684265140;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MaaXUmWYMUrm34mHy8xc1MH5y2IuXmSQmwypNMLJjoU=;
        b=1vkT+hAAWPKcBqQRjg5UlEuk7b/6YGv9MDW7ocM6tyOydCQ8m188DAXZgYCjKYgskz
         l2WmKzdeIvIpplhACjFYmHbx53zO0q+HQwzxe5p5dKYP/zmwWfGPKSW0Q6ocK17IlorQ
         1REaf9+uusXPEJOfHMzNR92oZiPCgN9+CpKgjJiggkmT1hrE0wOb4HuizMvt/FoHbDu4
         Fh2t5T36T1jcZkgepypMcH846gV0XmKgrwg7pWOvbDi70FzRnFDqg+rD/t6DVFm4hbEO
         s4xbCAgP8S4lH5NxtnThScJmZrax+zspeTnS9Sdsb2y0uWGlWTFSmrYV93/N2wFbgS+V
         0+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681673140; x=1684265140;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MaaXUmWYMUrm34mHy8xc1MH5y2IuXmSQmwypNMLJjoU=;
        b=j9dT1NSjDle1A5KGM4od8d5P2DrfjXcIwPlO0bk6EIMjUQqB+OHcqIXvS7YAcHGP2L
         KVVzyK8dW4qnSI4T4rMcs0Iv0+Qb6boj0z0ZSf7AHBV6Nj/RHsPdD8pK7W6mXTvGcDNg
         H0jAhEDoKvGg84o40bTW5VeJSHvpbT9Jfb5fjJxW9vNmY8MQiHgmvRtHIWvzwk4x7JIL
         9RH0mo+MqhEaOZTcQ0zhpzsjxn2n1jRrPoMWWNrc5zSiEADqEY7hEwGAnBRbVWi4G1nX
         qWZIfc0j/nGgJDZDYB+Iiu1SADni2AXLSOXeiqXlx8W/+p/JxM2vjOXEEx/dpMrqS8z2
         pHRQ==
X-Gm-Message-State: AAQBX9cMHv7pOkD0sXoCDbkrA0Zg4yiAMgFxoF64OmIM7UealwU7g3nC
        5oxuHISz6olfXligJDsp6H6hKA==
X-Google-Smtp-Source: AKy350ZQaC5PHvOTs/Ci+GGGlU987ym/CM5N0qzNMVlGoxzf3xpQizKJqUG6Xt6FbOcsrYeS4JwNDA==
X-Received: by 2002:a81:4644:0:b0:54e:dcf2:705b with SMTP id t65-20020a814644000000b0054edcf2705bmr12031663ywa.47.1681673139695;
        Sun, 16 Apr 2023 12:25:39 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b186-20020a811bc3000000b0054eff15530asm2641407ywb.90.2023.04.16.12.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 12:25:39 -0700 (PDT)
Date:   Sun, 16 Apr 2023 12:25:37 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Zi Yan <ziy@nvidia.com>
cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?ISO-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Zach O'Keefe <zokeefe@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 5/7] mm: thp: split huge page to any lower order
 pages.
In-Reply-To: <20230403201839.4097845-6-zi.yan@sent.com>
Message-ID: <26723f25-609a-fe9c-a41a-e692634d892@google.com>
References: <20230403201839.4097845-1-zi.yan@sent.com> <20230403201839.4097845-6-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 3 Apr 2023, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
> 
> To split a THP to any lower order pages, we need to reform THPs on
> subpages at given order and add page refcount based on the new page
> order. Also we need to reinitialize page_deferred_list after removing
> the page from the split_queue, otherwise a subsequent split will see
> list corruption when checking the page_deferred_list again.
> 
> It has many uses, like minimizing the number of pages after
> truncating a huge pagecache page. For anonymous THPs, we can only split
> them to order-0 like before until we add support for any size anonymous
> THPs.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
...
> @@ -2754,14 +2798,18 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  			if (folio_test_swapbacked(folio)) {
>  				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
>  							-nr);
> -			} else {
> +			} else if (!new_order) {
> +				/*
> +				 * Decrease THP stats only if split to normal
> +				 * pages
> +				 */
>  				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
>  							-nr);
>  				filemap_nr_thps_dec(mapping);
>  			}
>  		}

This part is wrong.  The problem I've had is /proc/sys/vm/stat_refresh 
warning of negative nr_shmem_hugepages (which then gets shown as 0 in
vmstat or meminfo, even though there actually are shmem hugepages).

At first I thought that the fix needed (which I'm running with) is:

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2797,17 +2797,16 @@ int split_huge_page_to_list_to_order(str
 			int nr = folio_nr_pages(folio);
 
 			xas_split(&xas, folio, folio_order(folio));
-			if (folio_test_swapbacked(folio)) {
-				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
-							-nr);
-			} else if (!new_order) {
-				/*
-				 * Decrease THP stats only if split to normal
-				 * pages
-				 */
-				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
-							-nr);
-				filemap_nr_thps_dec(mapping);
+			if (folio_test_pmd_mappable(folio) &&
+			    new_order < HPAGE_PMD_ORDER) {
+				if (folio_test_swapbacked(folio)) {
+					__lruvec_stat_mod_folio(folio,
+							NR_SHMEM_THPS, -nr);
+				} else {
+					__lruvec_stat_mod_folio(folio,
+							NR_FILE_THPS, -nr);
+					filemap_nr_thps_dec(mapping);
+				}
 			}
 		}
 
because elsewhere the maintenance of NR_SHMEM_THPS or NR_FILE_THPS
is rightly careful to be dependent on folio_test_pmd_mappable() (and,
so far as I know, we shall not be seeing folios of order higher than
HPAGE_PMD_ORDER yet in mm/huge_memory.c - those would need more thought).

But it may be more complicated than that, given that patch 7/7 appears
(I haven't tried) to allow splitting to other orders on a file opened
for reading - that might be a bug.

The complication here is that we now have four kinds of large folio
in mm/huge_memory.c, and the rules are a bit different for each.

Anonymous THPs: okay, I think I've seen you exclude those with -EINVAL
at a higher level (and they wouldn't be getting into this "if (mapping) {"
block anyway).

Shmem (swapbacked) THPs: we are only allocating shmem in 0-order or
HPAGE_PMD_ORDER at present.  I can imagine that in a few months or a
year-or-so's time, we shall want to follow Matthew's folio readahead,
and generalize to other orders in shmem; but right now I'd really
prefer not to have truncation or debugfs introducing the surprise
of other orders there.  Maybe there's little that needs to be fixed,
only the THP_SWPOUT and THP_SWPOUT_FALLBACK statistics have come to
mind so far (would need to be limited to folio_test_pmd_mappable());
though I've no idea how well intermediate orders will work with or
against THP swapout.

CONFIG_READ_ONLY_THP_FOR_FS=y file THPs: those need special care,
and their filemap_nr_thps_dec(mapping) above may not be good enough.
So long as it's working as intended, it does exclude the possibility
of truncation splitting here; but if you allow splitting via debugfs
to reach them, then the accounting needs to be changed - for them,
any order higher than 0 has to be counted in nr_thps - so splitting
one HPAGE_PMD_ORDER THP into multiple large folios will need to add
to that count, not decrement it.  Otherwise, a filesystem unprepared
for large folios or compound pages is in danger of meeting them by
surprise.  Better just disable that possibility, along with shmem.

mapping_large_folio_support() file THPs: this category is the one
you're really trying to address with this series, they can already
come in various orders, and it's fair for truncation to make a
different choice of orders - but is what it's doing worth doing?
I'll say more on 6/7.

Hugh
