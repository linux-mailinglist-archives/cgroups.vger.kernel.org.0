Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5B0123550
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 19:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfLQS7L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 13:59:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43463 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLQS7L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 13:59:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so14868572oth.10
        for <cgroups@vger.kernel.org>; Tue, 17 Dec 2019 10:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GuEcWgmH8GSMgVXr9VICJPrCyyD1ZEQYnQQLjsft8o=;
        b=rl/oAX4qVCMrFffhXlv/5htCZYq7vkckVH30ic55rGb/8tSMrnECYFFPjs8MToYwrw
         t2AT7/auNaL5lsEOaDh/BxRUa6D+c76fYeBlqBEx8ka8uvBMzQ8dnIOkalTgGfhopW05
         JLsXZwZMFfEvKEm+Ecpfv0c8lXSzi/IPh+jKbuIZUtSzKl4NQ2dJndvBhhXB/i5T3c8u
         61pvKy4QF0cE0NYkEJHG5ZJI0tpoWpeiGJ5p24iGpUppkaAgKJtDfk0gUoLH3D1Q7eX8
         +QcD6pFIJIzxU4g21JHuGG7s5I4KmPiLLKEIZqYYPz/L36QQdOZZa+aWrqszuSn99y+P
         Yerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GuEcWgmH8GSMgVXr9VICJPrCyyD1ZEQYnQQLjsft8o=;
        b=L+hKAHwWJmY6E5brPCr32TxfLFUWaBlEjnUtgzKUMrjAShaKSBUnoZc/0JgiQRsesI
         2nYB9dPgB4jx1/oS1xMii3POl/P4NVMlYc2txxXY30+olEwpNs967bJdZz9IwZRleUOZ
         Ajef2AJgt6KsAguCAPimogQf2KLLFgN+ZE8osK6bSgpWRvF7GyEZN34ebu7sqW1ZikCx
         LXHyUPwPs4BvZV2rcbBlCHBr6Kf3/hWQiHdmTOXlITBCmu/ZuNAGiOY5xyNhB84qH27i
         LENkR7zCXqCXm/uEpyaIo2M95ki+xfOFLiEvhi58NY5ivdlY8lsB1gnuiIT2GvLyaaSr
         8Dew==
X-Gm-Message-State: APjAAAXSHX/9sD1yC29PvTR0xi1msSAbGBKKDaSFN0JBEQhwr3o8fI49
        zuwB0zKzPpCRmE6355XrQ6GIad1D5e5gr3gQq5B5Sw==
X-Google-Smtp-Source: APXvYqzn14cgZdbrNiNKGP2PLVEDxr0Kc8DyA/BuA8A2jwNgB7dwZN6iX18f1r9MbTrDThnbL9srwzVqCzIbZN6BnQE=
X-Received: by 2002:a9d:2028:: with SMTP id n37mr41096073ota.127.1576609149853;
 Tue, 17 Dec 2019 10:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20191216193831.540953-1-gscrivan@redhat.com> <20191216204348.GF2196666@devbig004.ftw2.facebook.com>
 <20191216132747.1f02af9da0d7fa6a3e5e6c70@linux-foundation.org>
 <CAHS8izP1hrDOyjjWOu2xoy=-8Jz_in3ZiMVzvXb+pReOAyLc8w@mail.gmail.com> <87bls7jfwc.fsf@redhat.com>
In-Reply-To: <87bls7jfwc.fsf@redhat.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 17 Dec 2019 10:58:58 -0800
Message-ID: <CAHS8izM8oFmAKpH4gSotyrLy6tBUqGiO+Kxx-bAes=ceEbjorw@mail.gmail.com>
Subject: Re: [PATCH v6] mm: hugetlb controller for cgroups v2
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 17, 2019 at 4:27 AM Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > On Mon, Dec 16, 2019 at 1:27 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >>
> >> On Mon, 16 Dec 2019 12:43:48 -0800 Tejun Heo <tj@kernel.org> wrote:
> >>
> >> > On Mon, Dec 16, 2019 at 08:38:31PM +0100, Giuseppe Scrivano wrote:
> >> > > In the effort of supporting cgroups v2 into Kubernetes, I stumped on
> >> > > the lack of the hugetlb controller.
> >> > >
> >> > > When the controller is enabled, it exposes four new files for each
> >> > > hugetlb size on non-root cgroups:
> >> > >
> >> > > - hugetlb.<hugepagesize>.current
> >> > > - hugetlb.<hugepagesize>.max
> >> > > - hugetlb.<hugepagesize>.events
> >> > > - hugetlb.<hugepagesize>.events.local
> >> > >
> >> > > The differences with the legacy hierarchy are in the file names and
> >> > > using the value "max" instead of "-1" to disable a limit.
> >> > >
> >> > > The file .limit_in_bytes is renamed to .max.
> >> > >
> >> > > The file .usage_in_bytes is renamed to .current.
> >> > >
> >> > > .failcnt is not provided as a single file anymore, but its value can
> >> > > be read through the new flat-keyed files .events and .events.local,
> >> > > through the "max" key.
> >> > >
> >> > > Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> >> >
> >> > Acked-by: Tejun Heo <tj@kernel.org>
> >> >
> >> > This can go through either the mm tree or the cgroup tree.  If Andrew
> >> > doesn't pick it up in several days, I'll apply it to cgroup/for-5.6.
> >> >
> >>
> >> Thanks, I grabbed it.
> >>
> >> Giuseppe, yuo presumably have test code lying around.  Do you have
> >> something which can be tossed together for tools/testing/selftests/?
> >> Presumably under cgroup/.
> >>
> >> We don't seem to have much in the way of selftest code for cgroups.  I
> >> wonder why.
> >
> > Just FYI I have a patch series in review that does a hefty bit of
> > modifications to hugetlb_cgroup, and that comes with a decent bit of
> > tests for hugetlb cgroup (and only hugetlb cgroups, I'm not looking
> > into memcg tests or cgroup tests in general):
> > https://lkml.org/lkml/2019/10/29/1203
> >
> > If Giuseppe adds tests for hugetlb cgroup v2 that would be great, but
> > if not, a decent bit of hugetlb cgroup tests should be coming your way
> > as my series gets reviewed.
>
> I've some code I've used to test the hugetlb cgroup that I can clean up
> and include in the selftests.
>
> Mina, are you going to rebase your patchset?  I can add new tests for
> cgroup v2 on top of yours.
>

Yep, I'm working on that now and addressing comments from my last
iteration. I should be able to send it out for review before the end
of the week.

> Regards,
> Giuseppe
>
