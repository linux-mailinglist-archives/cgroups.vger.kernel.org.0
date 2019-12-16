Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8072120539
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2019 13:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfLPMOh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Dec 2019 07:14:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57468 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfLPMOg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Dec 2019 07:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cJuNyiJ6x2GmYYoz1Gvq9PWu1CKComrXo+DxXGJQ3kE=; b=WkHus4CkcBNFVoG84isWKSEOd
        RozRAuZWCdoYEDviJCWowXeaBRF2NBjp2g+BCGy2DbC7PxVBPdYxYC/qAoyQIJOe7P6Q7zPC1+W3x
        mqaVqhCaH6fkD4m5t+4LpI17CQ/4gIAYT8rrRhqSr67/+W5yl8xmfxFI35Ka0AQqf26tWwcArkM+w
        wPcKnDawJabaXS4XiexrIXicQ2YEHJFqKLfU8aYKGsQe4r8SyCAlzLfH8hkWOdrG72a+hDrm6C1Sl
        uYBbGjoOufC9SmziLadJpk/RWsLmyf8x9sp2PiMAwvfIz2NMAOzwxiCknWzlbJKiflpdzLncbh6aX
        LfVG7y3XQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igpGd-0000r1-I8; Mon, 16 Dec 2019 12:14:32 +0000
Date:   Mon, 16 Dec 2019 04:14:27 -0800
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
Subject: Re: [PATCH v6 02/10] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20191216121427.GZ32169@bombadil.infradead.org>
References: <1576488386-32544-1-git-send-email-alex.shi@linux.alibaba.com>
 <1576488386-32544-3-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576488386-32544-3-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 16, 2019 at 05:26:18PM +0800, Alex Shi wrote:
> -static void lock_page_lru(struct page *page, int *isolated)
> +static struct lruvec *lock_page_lru(struct page *page, int *isolated)
>  {
> -	pg_data_t *pgdat = page_pgdat(page);
> +	struct lruvec *lruvec = lock_page_lruvec_irq(page);
>  
> -	spin_lock_irq(&pgdat->lru_lock);
>  	if (PageLRU(page)) {
> -		struct lruvec *lruvec;
>  
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  		ClearPageLRU(page);
>  		del_page_from_lru_list(page, lruvec, page_lru(page));
>  		*isolated = 1;
>  	} else
>  		*isolated = 0;
> +
> +	return lruvec;
>  }

You still didn't fix this function.  Go back and look at my comment from
the last time you sent this patch set.
