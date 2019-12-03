Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B10311060F
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2019 21:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfLCUjt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Dec 2019 15:39:49 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45099 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfLCUjs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Dec 2019 15:39:48 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so4176926otp.12
        for <cgroups@vger.kernel.org>; Tue, 03 Dec 2019 12:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TGmijfS6iSqM9KNxZcHiJyNkLTmThtV5XCWkRCQWVYs=;
        b=f5o1+0L0Sf9SKSSXRpltKFpUmDY9v9d4OPBGeUL1tcWG+ntceFhAKBbGAS+Ka1VsCj
         rNeGx8TbAC9xCPqZg2UuaDrSkWW6eUN/hR+Rl24bkP76jRN8y654xHICahZ3HYWRLXWP
         oQTybo7NQhmDI+GONXRHzF3oHXVJssbIiNDyy9vPrMHgsy8Ifwn2KGt0vUggugFH7Cs1
         3wMIOdAaNA3X98P7iq4G8y7vlNtpyz4buqs2Pg9vH/0fRoSBl+ILozwVGi/kJ3QpyFpD
         kB7AaiO+kPYH5TwQbgAYdRntoQHic6wBwu4phx/nJ5eOyFap0uCo3aTAC294Ig/Epxtl
         9VtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TGmijfS6iSqM9KNxZcHiJyNkLTmThtV5XCWkRCQWVYs=;
        b=tEoLd2CeBcdlpbhx550kEbld6wqtxiYfFEvCvGFCv+SZpaTQ0/FkIlkodzavNdhRIa
         gvFZ73RNCVwZFEBUZPNEGm1m2ohkOFYws4sUhUNCgyHhMI8AsBsuJzcdmGWkAXWo25gg
         Ych3KqFbjpxD3kVxlQIgVjZmuHnShRjPVuyF/96ei3fVR/f9CGb5eBTNSb6SqrYxZ3xp
         J3c6tzGKXpWwIUXIGKsnotoDCCMddjAB3FVkaWM3keBORbbRpUheQyNak1YJTRAp6IWn
         CEVh2lP+/zoHfyOGEMl+nSLoVseVIysfNPmtrqN455bDOVnZ2YaVPyuF8xbJhw8EUq1Y
         wrFA==
X-Gm-Message-State: APjAAAXk//NqpFEI4PXvqyN0WyJaipmF8phibXQwnN+prE1seu8ZpFV/
        meTBfD2tA0E2OwIIJLRvA6YdQLTRZbRrE9UussESyw==
X-Google-Smtp-Source: APXvYqxRQ1EMVWDoiegNksxCbye5qpsxZFjdFdiVzEUPYQ0cFOskn77EmlKD4CK80tz8VoFKDnYVNyTRN1RSUatqEnQ=
X-Received: by 2002:a9d:6649:: with SMTP id q9mr4620266otm.313.1575405587532;
 Tue, 03 Dec 2019 12:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20191127124446.1542764-1-gscrivan@redhat.com> <20191203144602.GB20677@blackbody.suse.cz>
 <59c7e7a2-e8bb-c7b8-d7ec-1996ef350482@oracle.com>
In-Reply-To: <59c7e7a2-e8bb-c7b8-d7ec-1996ef350482@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 3 Dec 2019 12:39:36 -0800
Message-ID: <CAHS8izOegERV08QJ=GgsvPLWmQieYcsNccwucyMY_HOuX12wRw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: hugetlb controller for cgroups v2
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 3, 2019 at 11:43 AM Mike Kravetz <mike.kravetz@oracle.com> wrot=
e:
>
> On 12/3/19 6:46 AM, Michal Koutn=C3=BD wrote:
> > Hello.
> >
> > On Wed, Nov 27, 2019 at 01:44:46PM +0100, Giuseppe Scrivano <gscrivan@r=
edhat.com> wrote:
> >> - hugetlb.<hugepagesize>.current
> >> - hugetlb.<hugepagesize>.max
> >> - hugetlb.<hugepagesize>.events
> > Just out of curiosity (perhaps addressed to Mike), does this naming
> > account for the potential future split between reservations and
> > allocations charges?
>
> Mina has been working/pushing the effort to add reservations to cgroup
> accounting and would be the one to ask.  However, it does seem that the
> names here should be created in anticipation of adding reservations in
> the future.  So, perhaps something like:
>
> hugetlb_usage.<hugepagesize>.current
>
> with the new functionality having names like
>
> hugetlb_reserves.<hugepagesize>.current

I was thinking I'll just rebase my patches on top of this patch and
add the files for the reservations myself, since Guiseppe doesn't have
an implementation of that locally so the files would be dummies (or
maybe they would mirror the current counters).

But if Guiseppe is adding them then that's fine too. I would prefer names:

hugetlb.<hugepagesize>.current_reservations
hugetlb.<hugepagesize>.max_reservations

Note that reservations need both a current and a max that is distinct
from the allocation current and max, because users may want to set a
limit on only the reservation counter or allocation counter.

> --
> Mike Kravetz
