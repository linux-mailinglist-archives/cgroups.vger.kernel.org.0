Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9CE2EB85C
	for <lists+cgroups@lfdr.de>; Wed,  6 Jan 2021 04:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbhAFDK4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jan 2021 22:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAFDK4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jan 2021 22:10:56 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E76C06134D
        for <cgroups@vger.kernel.org>; Tue,  5 Jan 2021 19:10:15 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 15so2009518oix.8
        for <cgroups@vger.kernel.org>; Tue, 05 Jan 2021 19:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=W/PpEKlUbN28jcfj5YrFvkIXjBCbIDL7mYlBH/tOtfs=;
        b=bmoh1VQZHSZjSrOM6u1ba6MIirJY9CfW1kYiAp9WYOf/riWyAnLCEGxk/5FH3HjjpE
         pYap8ubcX3zHFbkOERTsYBbzxYK7rH+ZsL88OuIAwJl2BWR2FyddP6Eb6+k8KfDnrLGd
         2fjyOIK+OXv5qRpdFTIJOC+SSSk6qdmSazk/6zHuESaSbyhyLWM8Nmn2MX5G/LkSdZu0
         i8d8eXZ+UG+wCxiHc4J8coLbNuOHX6k7dBvxkeTf2WdxrmLjb41ACPKpYp6SFcie82FK
         gLUHYI2dBDx0VRGINwGa1rxqAreOsOVQKJZmp2Eri5C1uU0UzFHGtSLXJwDBUD30L+lV
         nTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=W/PpEKlUbN28jcfj5YrFvkIXjBCbIDL7mYlBH/tOtfs=;
        b=Wjb03LoEiZLO/0w7jP+vXVtz1sKQLJThcPOqtGg1uJl9XUI08HGKokey0Iz7H19Xxw
         UKPuMPxnjvyG9+4gXhcHLYHD+IBsfuM4lM84P9YH7VYNaa5SgBn+wE7zo461+xKe+FV2
         LOVKosjcYPBgci2bZwcLy/oPzKZBurFN9ruds+mFugswK2BNtSWfNVh84qmjRihbq+j8
         NH/2cy1bxjao9k61/Q0BblImv3v4hPL8/re8zshP34T/YUG/DESVO7hWmtrfkkOJSDbI
         25Q/DPB9XhICTlDWp5n78piCKijWhT4ig+4X2v9f2qUoV8aZ7vkRZ+j2UJ46ef+/326u
         TKNQ==
X-Gm-Message-State: AOAM5307xlrk7epTHmSU3U/ldxKctJF4Hf3JRRCkRKaehKUIkuMUWpLx
        cXpuD+/hhea1D521WgiA8wMtNw==
X-Google-Smtp-Source: ABdhPJwfDgp3jhoh27r8VrRwITx2/zk4fqf+o+Wra6UnFfGPgOP3Lw3+1mTRais5hrS2Y3X1Q4S+mA==
X-Received: by 2002:aca:c697:: with SMTP id w145mr1828526oif.117.1609902614989;
        Tue, 05 Jan 2021 19:10:14 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i8sm341755oih.2.2021.01.05.19.10.12
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2021 19:10:14 -0800 (PST)
Date:   Tue, 5 Jan 2021 19:10:01 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Qian Cai <qcai@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kernel test robot <lkp@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        alexander.duyck@gmail.com,
        kernel test robot <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v21 00/19] per memcg lru lock
In-Reply-To: <f127c35a34a391d20b05c53c17adeb72464b28ee.camel@redhat.com>
Message-ID: <alpine.LSU.2.11.2101051834450.1361@eggly.anvils>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com> <aebcdd933df3abad378aeafc1a07dfe9bbb25548.camel@redhat.com> <CALvZod448Ebw7YE-HVCNXNSbtvTcTvQx+_EqcyxTVd_SZ4ATBA@mail.gmail.com> <49be27f2652d4658f80c95bea171142c35513761.camel@redhat.com>
 <alpine.LSU.2.11.2101051326410.6519@eggly.anvils> <f127c35a34a391d20b05c53c17adeb72464b28ee.camel@redhat.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 5 Jan 2021, Qian Cai wrote:
> On Tue, 2021-01-05 at 13:35 -0800, Hugh Dickins wrote:
> > This patchset went into mmotm 2020-11-16-16-23, so probably linux-next
> > on 2020-11-17: you'll have had three trouble-free weeks testing with it
> > in, so it's not a likely suspect.  I haven't looked yet at your report,
> > to think of a more likely suspect: will do.
> 
> Probably my memory was bad then. Unfortunately, I had 2 weeks holidays before
> the Thanksgiving as well. I have tried a few times so far and only been able to
> reproduce once. Looks nasty...

I have not found a likely suspect.

What it smells like is a defect in cloning anon_vma during fork,
such that mappings of the THP can get added even after all that
could be found were unmapped (tree lookup ordering should prevent
that).  But I've not seen any recent change there.

It would be very easily fixed by deleting the whole BUG() block,
which is only there as a sanity check for developers: but we would
not want to delete it without understanding why it has gone wrong
(and would also have to reconsider two related VM_BUG_ON_PAGEs).

It is possible that b6769834aac1 ("mm/thp: narrow lru locking") of this
patchset has changed the timing and made a pre-existing bug more likely
in some situations: it used to hold an lru_lock before that BUG() on
total_mapcount(), and now does not; but that's not a lock which should
be relevant to the check.

When you get more info (or not), please repost the bugstack in a
new email thread: this thread is not really useful for pursuing it.

Hugh
