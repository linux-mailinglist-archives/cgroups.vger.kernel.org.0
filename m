Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A2F2EB3F0
	for <lists+cgroups@lfdr.de>; Tue,  5 Jan 2021 21:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbhAEUMn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jan 2021 15:12:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727591AbhAEUMn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jan 2021 15:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609877477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9lHUJ5BbT3/c3BacIKOhpQG6gVZEznCUigJp41xFTx4=;
        b=DsyJ8EIQt1uNC+OSLfA7GzykRp7sdK/tMW+8Cgd+XT0dI+oQ+Y9HR5+ipx5yvfxHNnrNvA
        W6FUn7Urts89RciD1VN/wMfV09tTQao2G8cfP+sxD7sYTJQFmSCw09WA8wyV7QYPo7S/8a
        9pIoBYruSHhq3eBO6cRi3dlgB3LGtkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-pLySCTB8O5mF_ok-1ZACSw-1; Tue, 05 Jan 2021 15:11:13 -0500
X-MC-Unique: pLySCTB8O5mF_ok-1ZACSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80594DBBD;
        Tue,  5 Jan 2021 20:11:10 +0000 (UTC)
Received: from ovpn-115-104.rdu2.redhat.com (ovpn-115-104.rdu2.redhat.com [10.10.115.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 679751002393;
        Tue,  5 Jan 2021 20:11:07 +0000 (UTC)
Message-ID: <49be27f2652d4658f80c95bea171142c35513761.camel@redhat.com>
Subject: Re: [PATCH v21 00/19] per memcg lru lock
From:   Qian Cai <qcai@redhat.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
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
Date:   Tue, 05 Jan 2021 15:11:06 -0500
In-Reply-To: <CALvZod448Ebw7YE-HVCNXNSbtvTcTvQx+_EqcyxTVd_SZ4ATBA@mail.gmail.com>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
         <aebcdd933df3abad378aeafc1a07dfe9bbb25548.camel@redhat.com>
         <CALvZod448Ebw7YE-HVCNXNSbtvTcTvQx+_EqcyxTVd_SZ4ATBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 2021-01-05 at 11:42 -0800, Shakeel Butt wrote:
> On Tue, Jan 5, 2021 at 11:30 AM Qian Cai <qcai@redhat.com> wrote:
> > On Thu, 2020-11-05 at 16:55 +0800, Alex Shi wrote:
> > > This version rebase on next/master 20201104, with much of Johannes's
> > > Acks and some changes according to Johannes comments. And add a new patch
> > > v21-0006-mm-rmap-stop-store-reordering-issue-on-page-mapp.patch to support
> > > v21-0007.
> > > 
> > > This patchset followed 2 memcg VM_WARN_ON_ONCE_PAGE patches which were
> > > added to -mm tree yesterday.
> > > 
> > > Many thanks for line by line review by Hugh Dickins, Alexander Duyck and
> > > Johannes Weiner.
> > 
> > Given the troublesome history of this patchset, and had been put into linux-
> > next
> > recently, as well as it touched both THP and mlock. Is it a good idea to
> > suspect
> > this patchset introducing some races and a spontaneous crash with some mlock
> > memory presume?
> 
> This has already been merged into the linus tree. Were you able to get
> a similar crash on the latest upstream kernel as well?

No, I seldom test the mainline those days. Before the vacations, I have tested
linux-next up to something like 12/10 which did not include this patchset IIRC
and never saw any crash like this. I am still trying to figure out how to
reproduce it fast, so I can try a revert to confirm.

