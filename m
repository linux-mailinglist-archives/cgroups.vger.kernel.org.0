Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C72D145B9B
	for <lists+cgroups@lfdr.de>; Wed, 22 Jan 2020 19:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgAVSbS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Jan 2020 13:31:18 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39744 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAVSbR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Jan 2020 13:31:17 -0500
Received: by mail-qv1-f66.google.com with SMTP id y8so225419qvk.6
        for <cgroups@vger.kernel.org>; Wed, 22 Jan 2020 10:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KsSmCaLhw2eH8Ck1bfIH7ogc6/ppRHUB+hk51YkiZzE=;
        b=u0FpVPQrv4MeJj0uTvYpr+Sr33hV6aI1K+Gy8Mixj42CY52n6sZTaMWDIYtZSSCP24
         mk9AQBCjBEZZe/npyXvADUGSV7Bm/VG+E0ISXV7nQTLQINJU53OZm0CsA7WB6ZEmjmRK
         pO0ElN1AQ3/y67SssU92eOrzZRg0MKD3ME3UblFkLpoa73KGxdADtGQrWy9scDLLZEn1
         cBQjulW+4DY/St0t8MIpZkDxNDNaQ6UYuWCw+oUB3dFEwi8KBcScjaWaD0a22oqbJREl
         xzWXKZUcI7ERm13Gre8OHCeZmsTaUtphwjUy+FCbkLULIvv3cbrV+hnaYWW+HYDN+Tso
         qRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KsSmCaLhw2eH8Ck1bfIH7ogc6/ppRHUB+hk51YkiZzE=;
        b=Gr/eQSS94mWcu3u9cgShLLVNUQTIfoBJnxQL8HUVXBQ6/Skqo4ZsRiupbpmHQKaAVQ
         Px43CC+DLLDYthnYo6L+dpbfF9m6N6ZNydp4A/BuZ2Q9kvODf/Msn3i4T6Y95QgSf4pr
         qJXLzFB68mKpTvJlpqk+eDe6RNnC2L6Y0Yzp1wDNRHNRYIyP+ft2GHlQTWX5PAlJ9Tp6
         gZ+VARH/6/yvE8eKL3mGK9lBGayreV+kKohx/aqtNyzr+xX20Ah8snViv3R4dhTq4e9F
         CZc2GtAeO0HqpGAtwms1jqQ4JkfGkXTMU0W7hjvfCZDRSmx+9mdnxGkMW3mxO6FLHgD1
         Z0eQ==
X-Gm-Message-State: APjAAAXPJtSwf0NRojJw291Pi2XjZojdVIRW3l9DXbAEfCILBR0sHSov
        ALjg0recXrfpkI7m8WkqeTkiow==
X-Google-Smtp-Source: APXvYqxy5nz3O1ZcaVlvpMPrQvwHVVq/hD6LsggY1jWvqsQCA/JvE8PXN7YnabEslIy3Dhx0ZUE6xg==
X-Received: by 2002:a05:6214:982:: with SMTP id dt2mr11565088qvb.174.1579717875415;
        Wed, 22 Jan 2020 10:31:15 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:203c])
        by smtp.gmail.com with ESMTPSA id x3sm21488705qts.35.2020.01.22.10.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 10:31:14 -0800 (PST)
Date:   Wed, 22 Jan 2020 13:31:13 -0500
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
Subject: Re: [PATCH v8 03/10] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20200122183113.GA98452@cmpxchg.org>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
 <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
 <20200116215222.GA64230@cmpxchg.org>
 <9ee80b68-a78f-714a-c727-1f6d2b4f87ea@linux.alibaba.com>
 <20200121160005.GA69293@cmpxchg.org>
 <0bd0a561-93cc-11b6-1eae-24b450b0f033@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd0a561-93cc-11b6-1eae-24b450b0f033@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 22, 2020 at 08:01:29PM +0800, Alex Shi wrote:
> Yes I understand isolatation would exclusive by PageLRU, but forgive my
> stupid, I didn't figure out how a new page lruvec adding could be blocked.

I don't see why we would need this. Can you elaborate where you think
this is a problem?

If compaction races with charging for example, compaction doesn't need
to prevent a new page from being added to an lruvec. PageLRU is only
set after page->mem_cgroup is updated, so there are two race outcomes:

1) TestClearPageLRU() fails. That means the page isn't (fully) created
yet and cannot be migrated. We goto isolate_fail before even trying to
lock the lruvec.

2) TestClearPageLRU() succeeds. That means the page was fully created
and page->mem_cgroup has been set up. Anybody who now wants to change
page->mem_cgroup needs PageLRU, but we have it, so lruvec is stable.

I.e. cgroup charging does this:

	page->mem_cgroup = new_group

	lock(pgdat->lru_lock)
	SetPageLRU()
	add_page_to_lru_list()
	unlock(pgdat->lru_lock)

and compaction currently does this:

	lock(pgdat->lru_lock)
	if (!PageLRU())
		goto isolate_fail
	// __isolate_lru_page:
	if (!get_page_unless_zero())
		goto isolate_fail
	ClearPageLRU()
	del_page_from_lru_list()
	unlock(pgdat->lru_lock)

We can replace charging with this:

	page->mem_cgroup = new_group

	lock(lruvec->lru_lock)
	add_page_to_lru_list()
	unlock(lruvec->lru_lock)

	SetPageLRU()

and the compaction sequence with something like this:

	if (!get_page_unless_zero())
		goto isolate_fail

	if (!TestClearPageLRU())
		goto isolate_fail_put

	// We got PageLRU, so charging is complete and nobody
	// can modify page->mem_cgroup until we set it again.

	lruvec = mem_cgroup_page_lruvec(page, pgdat)
	lock(lruvec->lru_lock)
	del_page_from_lru_list()
	unlock(lruvec->lru_lock)

