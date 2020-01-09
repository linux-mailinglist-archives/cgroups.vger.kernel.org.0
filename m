Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB37813546E
	for <lists+cgroups@lfdr.de>; Thu,  9 Jan 2020 09:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgAIIgq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Jan 2020 03:36:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53254 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgAIIgp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Jan 2020 03:36:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so1874959wmc.3;
        Thu, 09 Jan 2020 00:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=irB8OwBwqnqvkz6oPuoYuPz/4sdsl2cn2yoMzkHZKsE=;
        b=E+mK9SMT4VK3gJ+srIhmUFRmH/+Qi70v3KbEIInUGaPlke27x7LTFQ1VwYjDK1NLes
         8i8OCQSmWdisJQymqpsUotupbrBDpSTJLwBlkIyUTxxoXP3X47L6RTJRosQfkqDH7Wja
         mw6IGDzY2w1uSXdHiInYMNfTFlNI73A/CQn+j3nv7yxs+Bs50AO4tIKWNeSZuQdUJy+u
         rkBKELQ73W0QvKdPimQ6DfybgFr1MESHDX5XKBqwkNDKUp4KVlTnyCYAXLgPAft2QQvo
         Js6dQmiKw4LJPn/onYvuT2mF8Pj5fSlOYDuZeRzxEu0Lrp2403/hHPAXUQu1R7Gf+zLR
         OZfQ==
X-Gm-Message-State: APjAAAUplvat70r4tQ3DSbArM7SCsW7sq7hqzudsLqwI8RE0BXghXxGx
        Riczl73VEeEI0m9QRXn2rSM=
X-Google-Smtp-Source: APXvYqxVrlpShOHKCN8yEhJUcjRM9COE6D3pIqi7f+50M6t/OB6+GYR4eImi9/P/9Jo42r8+8SbClQ==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr3322499wmd.102.1578559003876;
        Thu, 09 Jan 2020 00:36:43 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id t81sm2055898wmg.6.2020.01.09.00.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 00:36:43 -0800 (PST)
Date:   Thu, 9 Jan 2020 09:36:41 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200109083641.GH4951@dhcp22.suse.cz>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com>
 <20200106102345.GE12699@dhcp22.suse.cz>
 <20200107012241.GA15341@richard>
 <20200107083808.GC32178@dhcp22.suse.cz>
 <20200108003543.GA13943@richard>
 <20200108094041.GQ32178@dhcp22.suse.cz>
 <20200109031821.GA5206@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109031821.GA5206@richard>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 09-01-20 11:18:21, Wei Yang wrote:
> On Wed, Jan 08, 2020 at 10:40:41AM +0100, Michal Hocko wrote:
> >On Wed 08-01-20 08:35:43, Wei Yang wrote:
> >> On Tue, Jan 07, 2020 at 09:38:08AM +0100, Michal Hocko wrote:
> >> >On Tue 07-01-20 09:22:41, Wei Yang wrote:
> >> >> On Mon, Jan 06, 2020 at 11:23:45AM +0100, Michal Hocko wrote:
> >> >> >On Fri 03-01-20 22:34:07, Wei Yang wrote:
> >> >> >> As all the other places, we grab the lock before manipulate the defer list.
> >> >> >> Current implementation may face a race condition.
> >> >> >
> >> >> >Please always make sure to describe the effect of the change. Why a racy
> >> >> >list_empty check matters?
> >> >> >
> >> >> 
> >> >> Hmm... access the list without proper lock leads to many bad behaviors.
> >> >
> >> >My point is that the changelog should describe that bad behavior.
> >> >
> >> >> For example, if we grab the lock after checking list_empty, the page may
> >> >> already be removed from list in split_huge_page_list. And then list_del_init
> >> >> would trigger bug.
> >> >
> >> >And how does list_empty check under the lock guarantee that the page is
> >> >on the deferred list?
> >> 
> >> Just one confusion, is this kind of description basic concept of concurrent
> >> programming? How detail level we need to describe the effect?
> >
> >When I write changelogs for patches like this I usually describe, what
> >is the potential race - e.g.
> >	CPU1			CPU2
> >	path1			path2
> >	  check			  lock
> >	  			    operation2
> >				  unlock
> >	    lock
> >	    # check might not hold anymore
> >	    operation1
> >	    unlock
> >
> >and what is the effect of the race - e.g. a crash, data corruption,
> >pointless attempt for operation1 which fails with user visible effect
> >etc.
> 
> Hi, Michal, here is my attempt for an example. Hope this one looks good to
> you.
> 
> 
>     For example, the potential race would be:
>     
>         CPU1                      CPU2
>         mem_cgroup_move_account   split_huge_page_to_list
>           !list_empty
>                                     lock
>                                     !list_empty
>                                     list_del
>                                     unlock
>           lock
>           # !list_empty might not hold anymore
>           list_del_init
>           unlock
>     
>     When this sequence happens, the list_del_init() in
>     mem_cgroup_move_account() would crash since the page is already been
>     removed by list_del in split_huge_page_to_list().

Yes this looks much more informative. I would just add that this will
crash if CONFIG_DEBUG_LIST.

Thanks!
-- 
Michal Hocko
SUSE Labs
