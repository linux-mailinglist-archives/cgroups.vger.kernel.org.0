Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 837D41105B5
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2019 21:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfLCUJw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Dec 2019 15:09:52 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43617 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLCUJw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Dec 2019 15:09:52 -0500
Received: by mail-qv1-f66.google.com with SMTP id p2so2095693qvo.10
        for <cgroups@vger.kernel.org>; Tue, 03 Dec 2019 12:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8j5eaTbArjU+gt/UFtQsGIvW7rflsGybMnC0YTzcNT0=;
        b=suNwMn3Y2gXVzpQ5Ip6UH7UmtwKaEHQM3JEssF8a2/qJNMy+Y3KOkDr31LTRJKOKF6
         FmRrud+5h+JL0GTQukwkBA/2MHM3YXSP8rGoAAq9gj1+kX7OGBlit8Q7uaFFJJcG4Ubq
         f+feuvLIiqDxVOYBDNYXcGmkANdVjFfZP2CD8fOpmD3pgEkAyjOB3hlTHEheOOBpmMy7
         xPbmXR2k90U4Q/FDO2c5vJH+hnkHyqvl09RQMnXKs3ehSu51Jn5QyXFJ1LVFjqXzzR74
         0CPWJ7BbddTVBhrUUSyXlH+2wOZtiy+jh43wmodpq+9zrz5uHZzI4AFQb36y6IDjkkL2
         le1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8j5eaTbArjU+gt/UFtQsGIvW7rflsGybMnC0YTzcNT0=;
        b=pJIwj540EKXODzKnnJ5IYDGiaWb8BEqkurMi851MAnvamWVwkAM6pzJJY0r+Trh0S7
         85C5wLOUMBY64s5XzPixu/PFm340nh6rRy6a/PVMnziQY0IDX7GG5TKqvtoQYUHRAJjH
         CcxddA+8HE1ykGDEYf8Cyi79vYbkzxZNdHkEDBKBRFlkvE2owK9s8w+uPE+P7nHiN2tI
         ObTLf0M636TECRqxr50oUZ3i5XG1tK7zejSHfHhyjrFUttgmkzAwznTCwjnbIoCO64bD
         ciZHuLHykrwpYtlt4YCvPWBcnv2eLJw86AMLmDR3K7+RnfnIBuqIjj44aumzEeDA6lOH
         q2qQ==
X-Gm-Message-State: APjAAAVK0q1zbeXLJKlcDkuiuHl2+QWvgrn+g+4Re41/4r50/ICjQadi
        XJDoGZkpT7QeV2CKu8qFR8C4Pw==
X-Google-Smtp-Source: APXvYqzOxsL7Hjtn21Q+m787V9Gv8BM/WLP3V8fGhMA3plOM9Nea9qSTrseec71+IsZp8t3OwsxFiQ==
X-Received: by 2002:a0c:ec08:: with SMTP id y8mr7175041qvo.13.1575403791387;
        Tue, 03 Dec 2019 12:09:51 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:cbfe])
        by smtp.gmail.com with ESMTPSA id d25sm2342905qtm.67.2019.12.03.12.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 12:09:50 -0800 (PST)
Date:   Tue, 3 Dec 2019 15:09:49 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        almasrymina@google.com
Subject: Re: [PATCH v3] mm: hugetlb controller for cgroups v2
Message-ID: <20191203200949.GA1619@cmpxchg.org>
References: <20191127124446.1542764-1-gscrivan@redhat.com>
 <20191203144602.GB20677@blackbody.suse.cz>
 <59c7e7a2-e8bb-c7b8-d7ec-1996ef350482@oracle.com>
 <87pnh5i3zn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnh5i3zn.fsf@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 03, 2019 at 08:49:32PM +0100, Giuseppe Scrivano wrote:
> Mike Kravetz <mike.kravetz@oracle.com> writes:
> 
> > On 12/3/19 6:46 AM, Michal Koutný wrote:
> >> Hello.
> >> 
> >> On Wed, Nov 27, 2019 at 01:44:46PM +0100, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> >>> - hugetlb.<hugepagesize>.current
> >>> - hugetlb.<hugepagesize>.max
> >>> - hugetlb.<hugepagesize>.events
> >> Just out of curiosity (perhaps addressed to Mike), does this naming
> >> account for the potential future split between reservations and
> >> allocations charges?
> >
> > Mina has been working/pushing the effort to add reservations to cgroup
> > accounting and would be the one to ask.  However, it does seem that the
> > names here should be created in anticipation of adding reservations in
> > the future.  So, perhaps something like:
> >
> > hugetlb_usage.<hugepagesize>.current
> >
> > with the new functionality having names like
> >
> > hugetlb_reserves.<hugepagesize>.current
> 
> that seems to be very different than other cgroup v2 file names.

Yes, let's not add two separate controller names.

> Should it be something like?
> 
> hugetlb.<hugepagesize>.current_usage
> hugetlb.<hugepagesize>.current_reserves

Why not

hugetlb.<hugepagesize>.current to indicate memory actively in use by
allocations and

hugetlb.<hugepagesize>.reserve to indicate explicit reserves by the
hugetlb subsystem?
