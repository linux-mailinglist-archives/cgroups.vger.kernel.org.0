Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F076697FC7
	for <lists+cgroups@lfdr.de>; Wed, 15 Feb 2023 16:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBOPma (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Feb 2023 10:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjBOPm0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Feb 2023 10:42:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7691B39CC7;
        Wed, 15 Feb 2023 07:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rDZl/5EEHbOPpxdRh+6glISWcS2OPg5HePgxkDGiegQ=; b=Tn7w5yBgAzqBzJkXZoFI1LG/rg
        yhJaeStJwyI5ZMuALThvIPfaeRFlm9/DzsDFX5jNKaGaUw3/3nhuDwj0Jv8nIwcdtKvkYU1FO39E1
        /u8L/iKTU+OtZncNwkUahyDKyTaYB3+Sd4h9AKw/xwKJjB1M/RIYi7Kps3Teqky7NWc+1pJ6nRdHQ
        NjiIT0soE9Ek/jdpFhzNrDJYJyEL3OYeMAtB5og4LtYkiCYHPZ3hvaVLtxx7vliCGTEsHhvDRQD0R
        TXljirgf5gUdnTogAeb9x3WxJ0/yCUuapR3MBByX9SGu398gW0Nbo+hVhNuxkvrUxA9pzbU9XHBtC
        briV317g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSJub-007aG4-Cf; Wed, 15 Feb 2023 15:41:37 +0000
Date:   Wed, 15 Feb 2023 15:41:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        sj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
        mike.kravetz@oracle.com, damon@lists.linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mm: hugetlb: change to return bool for
 isolate_hugetlb()
Message-ID: <Y+z9MSpKioRsWvKj@casper.infradead.org>
References: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
 <12a287c5bebc13df304387087bbecc6421510849.1676424378.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12a287c5bebc13df304387087bbecc6421510849.1676424378.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 15, 2023 at 06:39:36PM +0800, Baolin Wang wrote:
> Now the isolate_hugetlb() only returns 0 or -EBUSY, and most users did not
> care about the negative value, thus we can convert the isolate_hugetlb()
> to return a boolean value to make code more clear when checking the
> hugetlb isolation state. Moreover converts 2 users which will consider
> the negative value returned by isolate_hugetlb().
> 
> No functional changes intended.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
