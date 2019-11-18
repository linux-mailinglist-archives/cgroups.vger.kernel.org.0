Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47231008EA
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2019 17:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfKRQL3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Nov 2019 11:11:29 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41135 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfKRQL3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Nov 2019 11:11:29 -0500
Received: by mail-qv1-f68.google.com with SMTP id g18so6756814qvp.8
        for <cgroups@vger.kernel.org>; Mon, 18 Nov 2019 08:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j0SqAQT8llYIw4e/49l3a9ohNbFeVl5zPNeEm/Wp4s0=;
        b=D4nk0Siou5s/cqdoqRqvYGa8zjueKxO+SjyVZm6/zT83sFfDUd2SnGh1k9QnwDRDrx
         CH6WGIyRKE0rF+mnWZMd8pHyYqF+YLfdNHGtqMo/fOoR4AXXtBL0Cj7J0CMVPjVHqH1A
         5p89M+K8M+qZDQsxCDXAtPbwLRRrKzSr3XyWyZ95bNw/QI/aHZbmCL8249BGxWEd1uNi
         NmxnkCqIoZnTJ4pMiiNzMsyDF7nPDvcgoyhCtivfuijsRgBIc92NpnNww90o0JoHuJom
         W1UH6Cibz2Uc69M0LwpMJivjKj1PUsQuKOhtJZg9yyVl2bQ6Et0jog0H3A2vuFx+O7mN
         fvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j0SqAQT8llYIw4e/49l3a9ohNbFeVl5zPNeEm/Wp4s0=;
        b=IXPdEQZQzxMy+0V6Pu1JEYMavNFasRzXE27REU1Z1R38eEKeHT/fSy/AFI9ogJBokr
         XI4/Z4qDPL0bd4PJ+sXfxQbUNsAyDwmDs655ngRPKpXVE3jodnIP/3FXWltIQCKnYNe7
         qWDHDXzgmFs+aTFaa27rdADs3Glp4h7MqWSRyJ98NOFLRq8T9XbsIT3uCQcCiHziwDKi
         iZluLzJThZRxcW4bdcGdwMjXsaX2OJ+hYrQZa7Up1h7TNwFenyBfl/KR3gSS539Nbisc
         PzDWwJ76gTLlj1RvMObLf6co8zZ6La7QAN8YSwZLnO6u+1+c9uCgyuksoWa+2xKqiQjL
         gnnQ==
X-Gm-Message-State: APjAAAV8J1jaCq+mdwF0jS8WbPgbXRQhpeSvgn65FmbseW6lTXijw/IM
        LsX8b8Y1nR8bCHvPx4XcSkTgaQ==
X-Google-Smtp-Source: APXvYqyvK7ktIXppKh1dR704A5mqOwl/diTd0Fr4GO7WaTkdgkBup/M3IW20e4uuZ1GlgXiw9mZ32w==
X-Received: by 2002:a0c:fa50:: with SMTP id k16mr10774204qvo.172.1574093487963;
        Mon, 18 Nov 2019 08:11:27 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:1113])
        by smtp.gmail.com with ESMTPSA id i4sm10125597qtp.57.2019.11.18.08.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 08:11:26 -0800 (PST)
Date:   Mon, 18 Nov 2019 11:11:26 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
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
Message-ID: <20191118161126.GB365174@cmpxchg.org>
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573874106-23802-4-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573874106-23802-4-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Nov 16, 2019 at 11:15:02AM +0800, Alex Shi wrote:
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 62470325f9bc..cf274739e619 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1246,6 +1246,42 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>  	return lruvec;
>  }
>  
> +struct lruvec *lock_page_lruvec_irq(struct page *page,
> +					struct pglist_data *pgdat)
> +{
> +	struct lruvec *lruvec;
> +
> +again:
> +	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +	spin_lock_irq(&lruvec->lru_lock);

This isn't safe. Nothing prevents the page from being moved to a
different memcg in between these two operations, and the lruvec having
been freed by the time you try to acquire the spinlock.

You need to use the rcu lock to dereference page->mem_cgroup and its
lruvec when coming from the page like this.

You also need to use page_memcg_rcu() to insert the appropriate
lockless access barriers, which mem_cgroup_page_lruvec() does not do
since it's designed for use with pgdat->lru_lock.
