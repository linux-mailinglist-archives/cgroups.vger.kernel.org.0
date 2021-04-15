Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEE93610D3
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 19:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhDORL7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 13:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDORL7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 13:11:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A41C061574;
        Thu, 15 Apr 2021 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YwgbDheT+MJJ4trDHQZMYorZHJyXvzB0bzY8L8H53Zg=; b=pqDZ5QWhUwnCMzzTpH+57MdG8e
        g0vSEvFaeMGsKZ8bh0uo5UlIzHiiUgtJXiYwSvzacGqhh6T6NUMa7H0FmZtHyRyC3p6SM9J82c7nt
        wJ42qJWzFe26oOKJIu3NFrFYbbArdbYa6HooTaeAKc+NP3I6rczNl963yeZNi4aDr08izYDfRM3GD
        lb8BDY8K66PWBgEDvI5KTaFM7dI7gmB3dxzh0jphKMJR33jYTh5zvGwlqJWJriDwVOvk8EUzYHs4K
        WlLbiUz0IBvw1/FZNpfVY943UN1CCV+CB9CaByZSj9Jt8m13uHY+rBW34SoQuSqLRa7q6/dbT68+r
        T9a1b7tg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lX5Vj-008r8z-8x; Thu, 15 Apr 2021 17:10:41 +0000
Date:   Thu, 15 Apr 2021 18:10:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v3 0/5] mm/memcg: Reduce kmemcache memory accounting
 overhead
Message-ID: <20210415171035.GB2531743@casper.infradead.org>
References: <20210414012027.5352-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414012027.5352-1-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 13, 2021 at 09:20:22PM -0400, Waiman Long wrote:
> With memory accounting disable, the run time was 2.848s. With memory
> accounting enabled, the run times with the application of various
> patches in the patchset were:
> 
>   Applied patches   Run time   Accounting overhead   Overhead %age
>   ---------------   --------   -------------------   -------------
>        None          10.800s         7.952s              100.0%
>         1-2           9.140s         6.292s               79.1%
>         1-3           7.641s         4.793s               60.3%
>         1-5           6.801s         3.953s               49.7%

I think this is a misleading way to report the overhead.  I would have said:

			10.800s		7.952s		279.2%
			 9.140s		6.292s		220.9%
			 7.641s		4.793s		168.3%
			 6.801s		3.953s		138.8%

