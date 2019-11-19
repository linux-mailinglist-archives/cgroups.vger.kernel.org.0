Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05DDC1029BC
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2019 17:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfKSQts (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Nov 2019 11:49:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35775 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbfKSQtr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Nov 2019 11:49:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id c14so11482617oth.2
        for <cgroups@vger.kernel.org>; Tue, 19 Nov 2019 08:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xTSI3K4thH+dUGZBU/j6hslBPPzRGNTIfM5lXqXhgmU=;
        b=nLO0j7Gg0I4t2Cwt7ZY4AmeHh+8e+5HrEz65UbBvjuE5gjjl3g0SEF2i93MCVB5gXA
         lUjFrjYHHZ7qMKnUMS2tkQoUfe4RU1yx/FVi/vXctllao1EVx0erNqphH2gvvXJ5UpVA
         /hKrFLc5Xolw/tcSpWvt4E0vbM4C/jjPTyEBxD0otVIUPDDIx0YJqEFYifVydKMdXpCO
         gRUeqP0Sy82tWw8eQvh3FsOyJCZisrf6vHeAPfBaszfGzxBfr+lRZ7e/jZVslvWlTRzS
         0QSvsOKyOb9RJ4mxNzlRl/c39ddBbBmkFzZ9JREw7bhXl1xIsXnIx2f1K0nQ8iQIXiad
         UdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xTSI3K4thH+dUGZBU/j6hslBPPzRGNTIfM5lXqXhgmU=;
        b=RAXqzDZMs37fYGXrrTd2YffnhJ50zEVqQALmVwXapieK20dMayf0xDGmSmcgoDE0Sr
         01m4BBwReyQKV0iRZmr11WEz+cDHSGSgKMnb+iDuTRPdr09eV3jadmJsZQoROP0L5Kg8
         JkVWuW8URATMxhhuVN3eiixvnbgUGBZJI+4HU16qoTW5ukgEsNAcJblEhT1NslxndD0B
         7Etb4n7IYBmmPB6Yc5Pqa5Evb6yoQ0TArCS1vxYqBmucvIFap7QR742TwhlTVHzU6iaz
         a5U3Z5dVeLkkD4K344jpyRblfdjWe/7hSsyQByNsglmmW7CBnV9U2WcJ4kVcTBDCsLRy
         ZV2Q==
X-Gm-Message-State: APjAAAUxEMavFpysRCGaZNbvtU57JG4iJX2cSTgKEfSH9z2LMzRj/nIo
        yYOc7rMH980LG+xf9Gvqh9O57dyrC0fU6mSr4HEBlw==
X-Google-Smtp-Source: APXvYqwAE11CUIy9LnUeViWxpKB9m7ISi4+FxiJw+lLBnb3jjNIWkNkBlbwyd+Z1Vsn6B0MkoMl6OcFbHjQiLwALxLU=
X-Received: by 2002:a9d:66d9:: with SMTP id t25mr4780662otm.30.1574182186119;
 Tue, 19 Nov 2019 08:49:46 -0800 (PST)
MIME-Version: 1.0
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com> <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 19 Nov 2019 08:49:34 -0800
Message-ID: <CALvZod7QDv4UtS9Xi4EPqynfUxe8qP3qJjrwxHEb4EnZO27kfg@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 19, 2019 at 4:24 AM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
> This patchset move lru_lock into lruvec, give a lru_lock for each of
> lruvec, thus bring a lru_lock for each of memcg per node.
>
> This is the main patch to replace per node lru_lock with per memcg
> lruvec lock.
>
> We introduce function lock_page_lruvec, it's same as vanilla pgdat lock
> when memory cgroup unset, w/o memcg, the function will keep repin the
> lruvec's lock to guard from page->mem_cgroup changes in page
> migrations between memcgs. (Thanks Hugh Dickins and Konstantin
> Khlebnikov reminder on this. Than the core logical is same as their
> previous patchs)
>
> According to Daniel Jordan's suggestion, I run 64 'dd' with on 32
> containers on my 2s* 8 core * HT box with the modefied case:
>   https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/=
tree/case-lru-file-readtwice
>
> With this and later patches, the dd performance is 144MB/s, the vanilla
> kernel performance is 123MB/s. 17% performance increased.
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: swkhack <swkhack@gmail.com>
> Cc: "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Nikolay Borisov <nborisov@suse.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Yafang Shao <laoar.shao@gmail.com>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org

This patch (and series) still have unsafe accesses to lruvec.

Alex, I was hoping that you would drop this series in favor of Hugh's
patches. Anyways I will post Hugh patches for review to be considered
for 5.6. I will run a couple of performance experiments.

Shakeel
