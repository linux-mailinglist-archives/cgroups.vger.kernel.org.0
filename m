Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A358F121C23
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2019 22:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfLPVtg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Dec 2019 16:49:36 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43816 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLPVtg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Dec 2019 16:49:36 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so10891979oth.10
        for <cgroups@vger.kernel.org>; Mon, 16 Dec 2019 13:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+EjRJwHt/LAfJhPRKK4r1UkgDw/jOYI3+ZAKM8fJx0=;
        b=UbFKC68NQVf7tn6kdUjrdu/7ePEasDzlgxI37hW+zhL1comIK33MTfN1YVvFfndjLE
         jFVct/SvkiDYjeDa5sMtPSf3hND6b29SAXM/IM29fJq41JljAyPTLCSsDFCi1sUSpJHr
         TjuT2Hy2PxPwiCwwPwRobIuXqRW4ivj3tx4V6PPhgtaGF3ZpYbmrmSuRQgDZtXFSU9i7
         4zAMyq/8w4xH47BpOyOd6jUnZtWRTmMI2C/K9b2ZBJ2r+1Grti/dmoBDsQ5tFvNpnthA
         3UDAkzzGGPYGUzMS3PZEduyleaeY0JwfS+Csr3cDl0W7Ui3J2Y54e0YjMQRnJVvPos6g
         99lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+EjRJwHt/LAfJhPRKK4r1UkgDw/jOYI3+ZAKM8fJx0=;
        b=NPg7tjnu+2mH1fOf5RGt7h1EhziIRHpd+Wo6NAj8xb9ySjS6NsbGc00FDpfW72gpru
         eiOUTlPh54OOpP+zFZXbXITLwFdWAryAFkRjN5rGXjh4UpblpGIAn0lFF9rcXL7LzFwa
         teh/EcjD3puZos3PU6To0245GshPGwaaY297koapqX1PmwVEqBeSmpUMBIfdmD5ZasPO
         N+5prXKa+CFLojU/sBDSDSPU8O2p3b7c8QKLFYFG7ndsJMCTpvypJjpTZd6AyVWkgR37
         Sk0sskGJ9957oXEcPvkjqWxfv3FLPh451psNovaYQpYplVWaChARK6FBWAo/sT4tGxwa
         CV2Q==
X-Gm-Message-State: APjAAAWhUCilTx5DqBxmMnsxDu9GchleYwf68QCrj/ttHYGJDVIqokGY
        SCHRb3sZvihLJgkqTE5pZYsX2dfplU45xCRLAMbhdQ==
X-Google-Smtp-Source: APXvYqw6GtNBbveXCCmFNz2SFV+hbVSFPDB1a/h0bkgiMyX1V+H/FT9bEzAE8t7+CHWAEGPHcN+rjga/cQe8t9H9v5o=
X-Received: by 2002:a9d:2028:: with SMTP id n37mr35667916ota.127.1576532975240;
 Mon, 16 Dec 2019 13:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20191216193831.540953-1-gscrivan@redhat.com> <20191216204348.GF2196666@devbig004.ftw2.facebook.com>
 <20191216132747.1f02af9da0d7fa6a3e5e6c70@linux-foundation.org>
In-Reply-To: <20191216132747.1f02af9da0d7fa6a3e5e6c70@linux-foundation.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 16 Dec 2019 13:49:24 -0800
Message-ID: <CAHS8izP1hrDOyjjWOu2xoy=-8Jz_in3ZiMVzvXb+pReOAyLc8w@mail.gmail.com>
Subject: Re: [PATCH v6] mm: hugetlb controller for cgroups v2
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Giuseppe Scrivano <gscrivan@redhat.com>,
        cgroups@vger.kernel.org, Mike Kravetz <mike.kravetz@oracle.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 16, 2019 at 1:27 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 16 Dec 2019 12:43:48 -0800 Tejun Heo <tj@kernel.org> wrote:
>
> > On Mon, Dec 16, 2019 at 08:38:31PM +0100, Giuseppe Scrivano wrote:
> > > In the effort of supporting cgroups v2 into Kubernetes, I stumped on
> > > the lack of the hugetlb controller.
> > >
> > > When the controller is enabled, it exposes four new files for each
> > > hugetlb size on non-root cgroups:
> > >
> > > - hugetlb.<hugepagesize>.current
> > > - hugetlb.<hugepagesize>.max
> > > - hugetlb.<hugepagesize>.events
> > > - hugetlb.<hugepagesize>.events.local
> > >
> > > The differences with the legacy hierarchy are in the file names and
> > > using the value "max" instead of "-1" to disable a limit.
> > >
> > > The file .limit_in_bytes is renamed to .max.
> > >
> > > The file .usage_in_bytes is renamed to .current.
> > >
> > > .failcnt is not provided as a single file anymore, but its value can
> > > be read through the new flat-keyed files .events and .events.local,
> > > through the "max" key.
> > >
> > > Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> >
> > Acked-by: Tejun Heo <tj@kernel.org>
> >
> > This can go through either the mm tree or the cgroup tree.  If Andrew
> > doesn't pick it up in several days, I'll apply it to cgroup/for-5.6.
> >
>
> Thanks, I grabbed it.
>
> Giuseppe, yuo presumably have test code lying around.  Do you have
> something which can be tossed together for tools/testing/selftests/?
> Presumably under cgroup/.
>
> We don't seem to have much in the way of selftest code for cgroups.  I
> wonder why.

Just FYI I have a patch series in review that does a hefty bit of
modifications to hugetlb_cgroup, and that comes with a decent bit of
tests for hugetlb cgroup (and only hugetlb cgroups, I'm not looking
into memcg tests or cgroup tests in general):
https://lkml.org/lkml/2019/10/29/1203

If Giuseppe adds tests for hugetlb cgroup v2 that would be great, but
if not, a decent bit of hugetlb cgroup tests should be coming your way
as my series gets reviewed.
