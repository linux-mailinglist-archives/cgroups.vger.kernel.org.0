Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38AA341E0D
	for <lists+cgroups@lfdr.de>; Fri, 19 Mar 2021 14:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCSNXI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 09:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCSNWq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Mar 2021 09:22:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911E5C06174A;
        Fri, 19 Mar 2021 06:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2KS9BVm2N7BFC51UrW+/8IGJ0MRGc1xx7mmgTk+g7Ck=; b=n3IUUh3aXo0JWD2wwOFW2ef/JX
        7he8eoKNWqSKvmwXduCO9vGrHKcg6SnwHcWTHJz45edEUqaq/hk8q727hY2kq9y+jTFam61GWQrhG
        fmfHy5usrFG5GE9yqN8jAw8ePQ6miFu5YdhdXtNUwb1GYKYsbxiX8h/xOTD7qgAT3ZAhYH9G+vjhe
        L8g1fXJrm4rd3vUE4Ho2bTvg3vU4DixQcHhX1a/yYR/xYepeqAIlRcNguEJRERXQcB9jfShsBIsie
        liOlvmtwm1KYswYxVtFGkUXreaphaYAvVDtIZ/CKukhYqlB5DpNYwgkol/zsXmaXvINPWvHH8E2V3
        H2OmBNDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNF4L-004Rbo-Ez; Fri, 19 Mar 2021 13:21:42 +0000
Date:   Fri, 19 Mar 2021 13:21:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: page_alloc: fix memcg accounting leak in speculative
 cache lookup
Message-ID: <20210319132137.GZ3420@casper.infradead.org>
References: <20210319071547.60973-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319071547.60973-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 19, 2021 at 03:15:47AM -0400, Johannes Weiner wrote:
> When the freeing of a higher-order page block (non-compound) races
> with a speculative page cache lookup, __free_pages() needs to leave
> the first order-0 page in the chunk to the lookup but free the buddy
> pages that the lookup doesn't know about separately.

Thanks.
