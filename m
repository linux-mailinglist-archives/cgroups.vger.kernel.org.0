Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF5BE10299B
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2019 17:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfKSQov (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Nov 2019 11:44:51 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43025 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfKSQov (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Nov 2019 11:44:51 -0500
Received: by mail-qt1-f196.google.com with SMTP id j5so23891519qtn.10
        for <cgroups@vger.kernel.org>; Tue, 19 Nov 2019 08:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zDBiRfFmubevLJV/wK2eb+YrsoC2fdQK9RvQnh7Da5M=;
        b=oDIPg4xCvt+FI8k7NV6RunpeXQu5TzDO2AQca/h0guGU4mgiq1YtDvI6V7LBxsaqq1
         uwfSLg0IcO4TaXVfotXy+i7rNoLMt0PZ6I8K3ThD3VGWQID8Fjl83+9XEhUriUJx3+g0
         0CzUtYPbOLTHDP3iDEv1yEzYoD7v8IpCbpfdiQsdXs/GiCDtuzmhZBqcY/rWbYwSADGR
         +RDSDa21cGwXkTrArBpw1fWESvOV6UzVqxuufjvGN2nrtcT8w6dlObbUyiIMeo9ilkLr
         Oz36AFMlb8Hm5Y3i2tJb2unF7k/PcMNsjY1DWl4W379Z/mzSC61zlxVa4JkS9/CCc4x7
         M/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zDBiRfFmubevLJV/wK2eb+YrsoC2fdQK9RvQnh7Da5M=;
        b=qatupq6Q8P3Wt4K+F8pfunJfHRdWZA225dtI98DF60nRhz6lNR28gHneEETy5IVmbW
         GXUQIyg31bIu/GpTwykBZchDo+JE76gL1XuM2Fg5Eul+ijoxihz50leezz8+ZhWbw+m6
         ytFvPEOu5JNVrMmwCSfi+FWGY075ZZBzvq1v/7+ZG9AJnlj5ibDlw1kcUkzp9zrgSt0X
         BrHNzeps9nV4ZL9mwcLs+ZOzMPVwMex5yoH3eyhOAYZxO/9B/0Au2WAA1otqSwfwWNTr
         YNUohF+cCqu4FvIwVyOvuM4LkvV4FNslvostZUavKl5akMwkdJKdl4rX9DeGO0vd4K2W
         n6uA==
X-Gm-Message-State: APjAAAXWkRBE1/XtSX+enDt3y19/6DW6M4K8yrTBGTmYptEQctzUmlFF
        KkJifR0SFu4VcHrLb4b3QPENMg==
X-Google-Smtp-Source: APXvYqxgmrLsmMboCARtAfImqR9bUj+VTIOGRHcKUgwpjiS+UrPWRbOHVzpRwyE3DKy85K3bVtEgnQ==
X-Received: by 2002:ac8:724f:: with SMTP id l15mr34060653qtp.234.1574181890609;
        Tue, 19 Nov 2019 08:44:50 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::c7ac])
        by smtp.gmail.com with ESMTPSA id j7sm10286220qkd.46.2019.11.19.08.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 08:44:49 -0800 (PST)
Date:   Tue, 19 Nov 2019 11:44:48 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
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
Message-ID: <20191119164448.GA396644@cmpxchg.org>
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
 <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com>
 <20191119155704.GP20752@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119155704.GP20752@bombadil.infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 19, 2019 at 07:57:04AM -0800, Matthew Wilcox wrote:
> On Tue, Nov 19, 2019 at 08:23:17PM +0800, Alex Shi wrote:
> > +static inline struct lruvec *lock_page_lruvec_irqsave(struct page *page,
> > +				struct pglist_data *pgdat, unsigned long *flags)
> > +{
> > +	struct lruvec *lruvec = mem_cgroup_page_lruvec(page, pgdat);
> > +
> > +	spin_lock_irqsave(&lruvec->lru_lock, *flags);
> > +
> > +	return lruvec;
> > +}
> 
> This should be a macro, not a function.  You basically can't do this;
> spin_lock_irqsave needs to write to a variable which can then be passed
> to spin_unlock_irqrestore().  What you're doing here will dereference the
> pointer in _this_ function, but won't propagate the modified value back to
> the caller.  I suppose you could do something like this ...

This works because spin_lock_irqsave and local_irq_save() are
macros. It boils down to '*flags = arch_local_irq_save()' in this
function, and therefor does the right thing.

We exploit that in quite a few places:

$ git grep 'spin_lock_irqsave(.*\*flags' | wc -l
39
