Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F25105C6E
	for <lists+cgroups@lfdr.de>; Thu, 21 Nov 2019 23:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKUWGT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Nov 2019 17:06:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42844 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfKUWGR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Nov 2019 17:06:17 -0500
Received: by mail-qt1-f193.google.com with SMTP id t20so5469518qtn.9
        for <cgroups@vger.kernel.org>; Thu, 21 Nov 2019 14:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Bf3zXVc8JgyndN70CrFb4zsWDVt1DI2cOBZZ54QutII=;
        b=crXpS16brbj5wcwSGg8ZUNW+WnFbky+6ndEsBKBBwqewLUyZC2KtPR06bmxf6kVV0x
         +XADaSG7XVEs8kl8hGMFWn6z4G/S2iNrNg+CMACl4gcVvkcOBydeqNL2Ns+YzhGMxGgS
         PoyNNpLZLqeT5y44r7ouxVEZyHJ+9xp1ZwgERCu3+/9v7foYL77J2/4FdM7VxPoiZyJa
         MQOkloOGTfuv5odbW2dAfcsnjD9UseKW3xuJTuBllUg9O4YX5BV24NY2VWje8XU4rsVe
         mSOlipeQetbcpiGdNL2OdQpEQoycht9RyfCrvg+Blyffk8wGm/bGCfNnrb2BBpuB75nf
         +Ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Bf3zXVc8JgyndN70CrFb4zsWDVt1DI2cOBZZ54QutII=;
        b=lcOG3zZeGd4v1VL0YHp3jdWMn/PZn1Q9Eg2es/mYwiMWdKG5LIrgtm8efAQJ9Cf4Di
         puUeKHhNmHDmovW2GAVeKuvC6C619S7H3ft5ITMA0mRNmv+6XcfLpZGnZVfSA0beFhOp
         QA9ZGzFzF+ysECPUmJs+3+oxwbq+AB8AOeD0Rd2HkICsd7lUV96Qq/Ucnru5T/tkKiXk
         paFRBRHmod3eGbReBJ7TO8k1FKejJ6idJenozqorlKOJb960wGkkFtEU/BmM/qyw8bTw
         zhFQT8ugrnTmzTf6m0pKzlVwOPQrlv2h4wqLC8Mm/qsLIryEYwxr4Zcm2X1hfOBx1fNt
         yb4w==
X-Gm-Message-State: APjAAAXT9vpXRtvbOPoX7hHr4EHai3y6RDPn3Dwn3Y73z+tkdyy0pLyw
        4lYqt+Ola+pgu61mhBPOdoT96A==
X-Google-Smtp-Source: APXvYqxMpQc7gkZFWT+4X1cGXGSebkY7gn/oAh6KeV78J6HsT1HgUuAZ7/0lsXcViU0bjQOBOqSvYQ==
X-Received: by 2002:ac8:c4e:: with SMTP id l14mr1732376qti.87.1574373975657;
        Thu, 21 Nov 2019 14:06:15 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:dbed])
        by smtp.gmail.com with ESMTPSA id j89sm2282706qte.72.2019.11.21.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 14:06:14 -0800 (PST)
Date:   Thu, 21 Nov 2019 17:06:13 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, Michal Hocko <mhocko@kernel.org>,
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
Message-ID: <20191121220613.GB487872@cmpxchg.org>
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
 <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com>
 <20191119160456.GD382712@cmpxchg.org>
 <bcf6a952-5b92-50ad-cfc1-f4d9f8f63172@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcf6a952-5b92-50ad-cfc1-f4d9f8f63172@linux.alibaba.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 20, 2019 at 07:41:44PM +0800, Alex Shi wrote:
> 在 2019/11/20 上午12:04, Johannes Weiner 写道:
> >> @@ -1246,6 +1245,46 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
> >>  	return lruvec;
> >>  }
> >>  
> >> +struct lruvec *lock_page_lruvec_irq(struct page *page,
> >> +					struct pglist_data *pgdat)
> >> +{
> >> +	struct lruvec *lruvec;
> >> +
> >> +again:
> >> +	rcu_read_lock();
> >> +	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> >> +	spin_lock_irq(&lruvec->lru_lock);
> >> +	rcu_read_unlock();
> > The spinlock doesn't prevent the lruvec from being freed
> > 
> > You deleted the rules from the mem_cgroup_page_lruvec() documentation,
> > but they still apply: if the page is already !PageLRU() by the time
> > you get here, it could get reclaimed or migrated to another cgroup,
> > and that can free the memcg/lruvec. Merely having the lru_lock held
> > does not prevent this.
> 
> 
> Forgive my idiot, I still don't know the details of unsafe lruvec here.
> From my shortsight, the spin_lock_irq(embedded a preempt_disable) could block all rcu syncing thus, keep all memcg alive until the preempt_enabled in unspinlock, is this right?
> If so even the page->mem_cgroup is migrated to others cgroups, the new and old cgroup should still be alive here.

You are right about the freeing part, I missed this. And I should have
read this email here before sending out my "fix" to the current code;
thankfully Hugh re-iterated my mistake on that thread. My apologies.

But I still don't understand how the moving part is safe. You look up
the lruvec optimistically, lock it, then verify the lookup. What keeps
page->mem_cgroup from changing after you verified it?

lock_page_lruvec():				mem_cgroup_move_account():
again:
rcu_read_lock()
lruvec = page->mem_cgroup->lruvec
						isolate_lru_page()
spin_lock_irq(&lruvec->lru_lock)
rcu_read_unlock()
if page->mem_cgroup->lruvec != lruvec:
  spin_unlock_irq(&lruvec->lru_lock)
  goto again;
						page->mem_cgroup = new cgroup
						putback_lru_page() // new lruvec
						  SetPageLRU()
return lruvec; // old lruvec

The caller assumes page belongs to the returned lruvec and will then
change the page's lru state with a mismatched page and lruvec.

If we could restrict lock_page_lruvec() to working only on PageLRU
pages, we could fix the problem with memory barriers. But this won't
work for split_huge_page(), which is AFAICT the only user that needs
to freeze the lru state of a page that could be isolated elsewhere.

So AFAICS the only option is to lock out mem_cgroup_move_account()
entirely when the lru_lock is held. Which I guess should be fine.
