Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB2B44D3
	for <lists+cgroups@lfdr.de>; Tue, 17 Sep 2019 02:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfIQARD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Sep 2019 20:17:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44632 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbfIQARD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Sep 2019 20:17:03 -0400
Received: by mail-ot1-f68.google.com with SMTP id 21so1432263otj.11
        for <cgroups@vger.kernel.org>; Mon, 16 Sep 2019 17:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwaobm4013s4vZ793e0Q0coPvAuNlCS4dwgLxU/kSl8=;
        b=F/I6TnZ3a/2TPfGZhern/iGJOdxbIc8gdVk2J27bGA+ISJy9VBdWmRi/9yn3DOn6VW
         ueVInKZpZQ6Th2gqgIomkq8HiE05ZYrYCFXRq5acaeyDFi0jWAeHR/DqdB8DJLHJx6T7
         187NW7MNd2EhrgL1VwJGFfC5tdeqPOa3sVp8l/NGmtIK+ps7hGTD6csmOudD28L3Ln5T
         PMS16xJzq0Aa70OQuk+mYwnDKYRPSSmSTRpKor6fyulK0D2KYh3w4QLJ3gHzu+SSRuck
         AbDXs8t2um5i1TFD+5dLCPQp64a0KtSpx7Tev4EQIrVrLYKQ41aHT4WWIQpMhS//rNHZ
         NkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwaobm4013s4vZ793e0Q0coPvAuNlCS4dwgLxU/kSl8=;
        b=R3bNpXKop3bzirwZK6lPAMMbjVlvEbHPAM66QNkpp7vcubp6UROh757utwe01vPMU2
         FaWfb2ChhQS5KC6eh/IwcHDUwDw3manjDft7HjhQZpTCTcQZm0rC7JtqBPBSm7aKkUPo
         LUtkALhhwFRMV1zD5I+TrmYQe8+XxMgNKpi0ucev3u/KJH2jsVwt6ulei/RYDgWAkNpb
         irz94Y3ZA/oIHSp3epRg2uIILrCDYFi60AJI4YVKnLME6Xt0D7jNLElwCzups4XWouds
         vfFoNNoWeUfe+T7RZCd8xupogqB7WMi3MW0czaOEupFUTSSom/PQygbf8ePq7PLPzMCi
         9xkA==
X-Gm-Message-State: APjAAAVhbV8YbkDRak2MXf3Ykkq9y1/bJuYSvXAm2+QS60lvBg5XCAK0
        iQQLc4WOZaJNw1s4LVcxwzDc+oP0sdoOvNt5dUvNog==
X-Google-Smtp-Source: APXvYqzZSsfpjpMTadPZhZb7SUTwDEQvBgSQESfurSBFz47FNKKrb813cd51n4secgL4dxWAccV7dqf6q2NqTtIJFxc=
X-Received: by 2002:a9d:441:: with SMTP id 59mr708184otc.355.1568679421652;
 Mon, 16 Sep 2019 17:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190910233146.206080-1-almasrymina@google.com>
 <20190910233146.206080-7-almasrymina@google.com> <abe11781-7267-e54e-0b81-46dc4ea6d5a4@oracle.com>
In-Reply-To: <abe11781-7267-e54e-0b81-46dc4ea6d5a4@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 16 Sep 2019 17:16:50 -0700
Message-ID: <CAHS8izMTdq0L8QNLE+QVKhJDHEDjGraZFGCX57BqcpTTOP0KWw@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] hugetlb: disable region_add file_region coalescing
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 16, 2019 at 4:57 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 9/10/19 4:31 PM, Mina Almasry wrote:
> > A follow up patch in this series adds hugetlb cgroup uncharge info the
> > file_region entries in resv->regions. The cgroup uncharge info may
> > differ for different regions, so they can no longer be coalesced at
> > region_add time. So, disable region coalescing in region_add in this
> > patch.
> >
> > Behavior change:
> >
> > Say a resv_map exists like this [0->1], [2->3], and [5->6].
> >
> > Then a region_chg/add call comes in region_chg/add(f=0, t=5).
> >
> > Old code would generate resv->regions: [0->5], [5->6].
> > New code would generate resv->regions: [0->1], [1->2], [2->3], [3->5],
> > [5->6].
> >
> > Special care needs to be taken to handle the resv->adds_in_progress
> > variable correctly. In the past, only 1 region would be added for every
> > region_chg and region_add call. But now, each call may add multiple
> > regions, so we can no longer increment adds_in_progress by 1 in region_chg,
> > or decrement adds_in_progress by 1 after region_add or region_abort. Instead,
> > region_chg calls add_reservation_in_range() to count the number of regions
> > needed and allocates those, and that info is passed to region_add and
> > region_abort to decrement adds_in_progress correctly.
>
> Hate to throw more theoretical examples at you but ...
>
> Consider an existing reserv_map like [3-10]
> Then a region_chg/add call comes in region_chg/add(f=0, t=10).
> The region_chg is going to return 3 (additional reservations needed), and
> also out_regions_needed = 1 as it would want to create a region [0-3].
> Correct?
> But, there is nothing to prevent another thread from doing a region_del [5-7]
> after the region_chg and before region_add.  Correct?
> If so, it seems the region_add would need to create two regions, but there
> is only one in the cache and we would BUG in get_file_region_entry_from_cache.
> Am I reading the code correctly?
>
> The existing code wants to make sure region_add called after region_chg will
> never return error.  This is why all needed allocations were done in the
> region_chg call, and it was relatively easy to do in existing code when
> region_chg would only need one additional region at most.
>
> I'm thinking that we may have to make region_chg allocate the worst case
> number of regions (t - f)/2, OR change to the code such that region_add
> could return an error.

Yep you are right, I missed reasoning about the region_del punch hole
into the reservations case. Let me consider these 2 options.

> --
> Mike Kravetz
