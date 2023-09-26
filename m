Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5E87AE6D6
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 09:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjIZHaS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 03:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjIZHaR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 03:30:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C103EDC;
        Tue, 26 Sep 2023 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VB02rfAqrCwJrrIDo94dHomdWocZV8cYbgBNccAUQMk=; b=ETp0JudbYO6jWOHR8dt1yjNuuo
        ANXen3hdy7Mz22SUO98P7L9/e4iniE1lGCr1mPQXHUkSKDEIyC8GY8Su3mmKooq6UR8d6xFR85zcx
        //zTrG/P1LfB768hKeFtlJYLjY1/58D/ZAf3KCd5yCxzkYcLzfmAHHJvTw7e2NyONn1XN2fQJr2uK
        1uTsOWjHzM8iM2ZucnmHgkM4qVJOq36oRA7/r5QB4Nrisp3bzJzsRfSdJd/TJhlS3ToCjWIUHuDxb
        tl+k39Lts3qdYVgNiAWcnvm4qw3dYglXtHRpPYpchgRBAglGDQn3Nc9zQA5wO31Lc1qe7EsvI8gd/
        d3wjnD1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ql2W5-00FnWf-1E;
        Tue, 26 Sep 2023 07:29:57 +0000
Date:   Tue, 26 Sep 2023 00:29:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm, memcg: expose swapcache stat for memcg v1
Message-ID: <ZRKIdTE+4cm0KDCI@infradead.org>
References: <20230902100728.3850149-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902100728.3850149-1-liushixin2@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Sep 02, 2023 at 06:07:28PM +0800, Liu Shixin wrote:
> Since commit b6038942480e ("mm: memcg: add swapcache stat for memcg v2")
> adds swapcache stat for the cgroup v2, it seems there is no reason to
> hide it in memcg v1. Conversely, with swapcached it is more accurate to
> evaluate the available memory for memcg.

Why are we adding new features to the long deprecated cgroup v1?

