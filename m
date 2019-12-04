Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F1D113549
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2019 20:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfLDTAB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Dec 2019 14:00:01 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44007 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfLDTAB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Dec 2019 14:00:01 -0500
Received: by mail-oi1-f196.google.com with SMTP id t25so226581oij.10
        for <cgroups@vger.kernel.org>; Wed, 04 Dec 2019 11:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8pVC7qV/5hLdflmU5ex2OgiRPPfwk/VTZ/uEHwwVTUQ=;
        b=vU7eGe9JFT6IQUhYy7YbmdR1oy270ahRIPEfS4fpu0dTV7d21wleAOaNgO4xw+RgMI
         Yij8VFF7H5L1Tz0twKB9ks88JKDSFLvwqC3pqfOY9NjJIgsRj+0fH1lras+36pVLQ/5X
         fgNNwO1rlgPVrOiW8kQAyPfAf4Y8STGOMzo2SvFM5xjZ8b+ZtZ6DyTClxZUrGsSN1XvN
         5hx2oc0npf6C14geltgk/otdhFxGLTNlYgaOqnj0bcUa/cRhOG9wZbKCW0wHmty2BFBV
         JyWLHTddrYgO7/f6d+MoFg8snaAiUDLiQJSG9AZT+2+6OxcTjFeQ/AZqp0aCIAUyoH22
         JBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pVC7qV/5hLdflmU5ex2OgiRPPfwk/VTZ/uEHwwVTUQ=;
        b=jKevlR82WspNoG66arVv3Oqpo7DMdLPAOBEi1pR455NCH8Y6Lzms0zDVzUm5DXw0pd
         UP5oEEcvdcFM6LmQK8YEXCUKyXghSNQQGKsdEqoQHUBUTkg4LBCUOp7C1W1WcUhb9i1M
         WK0NfrUbyOP91bkVjawi4fJFHw6GZmZkRwCyXntTA+LWBzsdN2tJ3Hao6fasRRoTKGT7
         l4LwkFtONueN267M/ufrZ3+09hUYPaXgfXANN8JkrgO8f9IACGnE6PYqOLzsAu3oxfi5
         RUT/HWetN6JztAYsKtUPxv6WU/KC8yYhmbekfM6gEaYXHCyahiTmnvHyibHCVacqYQSU
         r/9Q==
X-Gm-Message-State: APjAAAUPZxLp5c8+E3b0QpYXBYLFDi7B0sujkjv6xWIfM+FkZNe+nfbw
        hUKiFbnJZ3wztdSdvZVXZrLhCa3OMxCrRvh/hEBv4vkz
X-Google-Smtp-Source: APXvYqzQcf34Q9BsMaVMHp4eV2r9ddG8E+9+O9qDNnanGhZ5kC9QsjfCsTZWoNcALubPXNYAIRnmMkxjy8PKPNNEHII=
X-Received: by 2002:a54:400a:: with SMTP id x10mr4031492oie.67.1575486000003;
 Wed, 04 Dec 2019 11:00:00 -0800 (PST)
MIME-Version: 1.0
References: <20191127124446.1542764-1-gscrivan@redhat.com> <20191203144602.GB20677@blackbody.suse.cz>
 <59c7e7a2-e8bb-c7b8-d7ec-1996ef350482@oracle.com> <CAHS8izOegERV08QJ=GgsvPLWmQieYcsNccwucyMY_HOuX12wRw@mail.gmail.com>
 <87fti0i7ip.fsf@redhat.com>
In-Reply-To: <87fti0i7ip.fsf@redhat.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 4 Dec 2019 10:59:49 -0800
Message-ID: <CAHS8izMEVsZQ-p3Hp6EQwbPgsz33_xjBseJz5234Ra=f6dTdWA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: hugetlb controller for cgroups v2
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 4, 2019 at 4:45 AM Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> >> Mina has been working/pushing the effort to add reservations to cgroup
> >> accounting and would be the one to ask.  However, it does seem that the
> >> names here should be created in anticipation of adding reservations in
> >> the future.  So, perhaps something like:
> >>
> >> hugetlb_usage.<hugepagesize>.current
> >>
> >> with the new functionality having names like
> >>
> >> hugetlb_reserves.<hugepagesize>.current
> >
> > I was thinking I'll just rebase my patches on top of this patch and
> > add the files for the reservations myself, since Guiseppe doesn't have
> > an implementation of that locally so the files would be dummies (or
> > maybe they would mirror the current counters).
> >
> > But if Guiseppe is adding them then that's fine too. I would prefer names:
> >
> > hugetlb.<hugepagesize>.current_reservations
> > hugetlb.<hugepagesize>.max_reservations
>
> I think it is better to add them as part of the patch that is also
> adding the functionality.
>
> I've fixed the issue with events and events.local Michal reported, now
> it works similarly to the memcg.
>
> I'll send the updated version once we agree on the file names to use.
>
> Are you fine if I keep these two file names?
>
> - hugetlb.<hugepagesize>.current
> - hugetlb.<hugepagesize>.max
>

Yep, looks fine to me. Thanks!

> Regards,
> Giuseppe
>
