Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF221028B6
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2019 16:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfKSP5K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Nov 2019 10:57:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfKSP5J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Nov 2019 10:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W1uhPT3svlAF0ny/aKL/GHGJkaklH1eD5N8ZBRDMDjQ=; b=Xfdf/vrhOYcquHoQNoWpTcYtN
        kuKDO7Bj0HAO9PGeYCNBHKD8xBrQdnj0NBMreHHZsj6FewQ1lt2CJRl5hZh7TsQLGgENhL3m9Y2vg
        hgFjZX+aDnEaE4AoEMRRRAl7sFpRoDW7RF27nGb6Djf9AI9Tj5n16mNuwfZMKDqQd48sFww3pKSoO
        A3tzKcDLGANz00inclHZMDPUpgPNRT5lBfyG4pYvTruFLURextxyUhR1r2/NAqX65anAsLCtSBbTG
        fcpQx31yG7SOO80NCnOArA/EM6w9iLaF4Y5dqIt2zQua0YL/9XPDRqNicbv1QzgepjAfcZST2eANh
        LdHbfPRqw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iX5sG-0003B8-Ga; Tue, 19 Nov 2019 15:57:05 +0000
Date:   Tue, 19 Nov 2019 07:57:04 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, shakeelb@google.com,
        hannes@cmpxchg.org, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
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
Subject: Re: [PATCH v4 3/9] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20191119155704.GP20752@bombadil.infradead.org>
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
 <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 19, 2019 at 08:23:17PM +0800, Alex Shi wrote:
> +static inline struct lruvec *lock_page_lruvec_irqsave(struct page *page,
> +				struct pglist_data *pgdat, unsigned long *flags)
> +{
> +	struct lruvec *lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +
> +	spin_lock_irqsave(&lruvec->lru_lock, *flags);
> +
> +	return lruvec;
> +}

This should be a macro, not a function.  You basically can't do this;
spin_lock_irqsave needs to write to a variable which can then be passed
to spin_unlock_irqrestore().  What you're doing here will dereference the
pointer in _this_ function, but won't propagate the modified value back to
the caller.  I suppose you could do something like this ...

static inline struct lruvec *lock_page_lruvec_irqsave(struct page *page,
			struct pglist_data *pgdat, unsigned long *flagsp)
{
	unsigned long flags;
	struct lruvec *lruvec = mem_cgroup_page_lruvec(page, pgdat);

	spin_lock_irqsave(&lruvec->lru_lock, flags);
	*flagsp = flags;

	return lruvec;
}

Almost certainly easier to write a macro though.

You shouldn't need the two prior patches with this kind of change.
