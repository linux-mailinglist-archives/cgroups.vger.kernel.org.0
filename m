Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2331005B3
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2019 13:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfKRMey (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Nov 2019 07:34:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfKRMey (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Nov 2019 07:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=85/7YFaxkit/qDvj6KxyLGhebHuLl4W62LvFcfhY4kc=; b=iwsSa4k8B14FS+/bfhQjei4YR5
        p4nLcN8rzX2+c5PHXqOvWXOMGdQKwODjRXJzL7WiJ+1gPKNDP8qwt7PknNKKYYAxfVFsGtTbX3zdD
        X07M3Ir8GiCktqJhJ9aIfFAhbyZ2LaFADcQBTG8hWf+5GGMUHLcMkKkyOC6iwGpwQakuRgWLJRjUc
        9+LGJ8149NvYnR5LJQK1sF4mzZuuoeQHeSdvD/DBhjFeyWCpeba0eYyM5mkpSShF6rcuaqP7s1kK/
        4aeo5CpuO7AzGdLFUuIGo04tIq0+RRDKRWppDEobOktjrY7l8JcY/3+Ch4zuMfUQWq55T72LK/5ky
        iQZF+pKw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iWgF2-000374-Rg; Mon, 18 Nov 2019 12:34:52 +0000
Date:   Mon, 18 Nov 2019 04:34:52 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v3 3/7] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20191118123452.GM20752@bombadil.infradead.org>
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573874106-23802-4-git-send-email-alex.shi@linux.alibaba.com>
 <20191116043806.GD20752@bombadil.infradead.org>
 <0bfa9a03-b095-df83-9cfd-146da9aab89a@linux.alibaba.com>
 <20191118121451.GG20752@bombadil.infradead.org>
 <296c7202-930e-4027-2e92-b8c64a908d88@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <296c7202-930e-4027-2e92-b8c64a908d88@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 18, 2019 at 08:31:50PM +0800, Alex Shi wrote:
> 
> 
> 在 2019/11/18 下午8:14, Matthew Wilcox 写道:
> >> Hi Matthew,
> >>
> >> Thanks for comments!
> >>
> >> Here, the irqflags is bound, and belong to lruvec, merging them into together helps us to take them as whole, and thus reduce a unnecessary code clues.
> > It's not bound to the lruvec, though.  Call chain A uses it and call chain
> > B doesn't.  If it was always used by every call chain, I'd see your point,
> > but we have call chains which don't use it, and so it adds complexity.
> 
> Where is the call chain B, please?

Every call chain that uses lock_page_lruvec_irq().

> >> As your concern for a 'new' caller, since __split_huge_page is a static helper here, no distub for anyothers.
> > Even though it's static, there may be other callers within the same file.
> > Or somebody may decide to make it non-static in the future.  I think it's
> > actually clearer to keep the irqflags as a separate parameter.
> > 
> 
> But it's no one else using this function now. and no one get disturb, right? It's non sense to consider a 'possibility' issue.

It is not nonsense to consider the complexity of the mm!  Your patch makes
it harder to understand unnecessarily.  Please be considerate of the other
programmers who must build on what you have created.

