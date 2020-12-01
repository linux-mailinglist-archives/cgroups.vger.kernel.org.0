Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1DD2C9D23
	for <lists+cgroups@lfdr.de>; Tue,  1 Dec 2020 10:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbgLAJTe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Dec 2020 04:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388729AbgLAJJo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Dec 2020 04:09:44 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8376C0613D4
        for <cgroups@vger.kernel.org>; Tue,  1 Dec 2020 01:09:03 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id f23so2578810ejt.8
        for <cgroups@vger.kernel.org>; Tue, 01 Dec 2020 01:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S+Ngn4W/oQtuMxlBFu4kHeU3p7nhm6p8xjw9712a+hg=;
        b=a1xDBC0NB1WegU5JwLnZPeJz2v97WB28CL0vAfurTSZNAoShRCXmC95d3JszRXT8V2
         t47DSCSTXBLukV4RQqIXsQnrhr/HM/xRMmAlJs5xV8uW8100Cy9Z++tUUSqc9mt/66r+
         C7zlSHICvqkcIRc7XolTcgpJitMlO1FBjS1utDfmAwsQkNaZVOZEyw2JFuyf0w+WfxLT
         e2I8DpbCs7yCV7cmmNDt4SphJREPbyXf81PsCX3pEukIGegJ1hbWRaWt89vhrqdqhFyK
         oAjflrkxgLhtnaAtj0D13J65wTDkcPV++R8Dc3ox0c3PdP1EchtZPQlqRlCsdZXqesef
         TA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S+Ngn4W/oQtuMxlBFu4kHeU3p7nhm6p8xjw9712a+hg=;
        b=ozDwJF1a/ranyskpXXD1lUCItAlCqkp9Omk5S1jO8vK8pM/3Qg27+xT4IxkrwVPKDj
         LgamHJn8MJko9uc20eDQzR8F3C3pIBDtetsSfjBAmp+BrpQcHhmSTM/Ar/ongNtJRHov
         2/oBDqGoJAb48SigJL3LqJ3c7sOfNlCNhT1wrlmhN5R86BRt3sdV/AZR7sufHP2bAB6L
         SDB+a/0vLivUPiZK8uhWIToU7I+J2doG0aGO9rdeACcFIEs9WmhtguuZunQ1j0oMUoyi
         OORlU81lSo5DtY2ZRO9JQvelr3uXaf3hPXdXBnyfJ9obhVz2/2XObkLvPLYFQ6o89xNp
         DlxA==
X-Gm-Message-State: AOAM530sG85yotnaHc8DbB8yg2+U7TPdqwppEKxUYOiMeYh7qvkzdRDV
        axQDyHiPdY10fhdUfiQCcJ3GMqbbTZXOC5ylLCQLWg==
X-Google-Smtp-Source: ABdhPJz9Uhhox7ZTrrku2Jm0H/oZM/zXk9l4/6aLl25sq93H6GDa8EkVqs78ul1nVveVbLKnNiLpc/83txz7DeAOR9c=
X-Received: by 2002:a17:906:1498:: with SMTP id x24mr2014665ejc.170.1606813742234;
 Tue, 01 Dec 2020 01:09:02 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtk3fKy7ct-rT=T8iFDhE4CbjGgdfxsOBrKT9y8ntwXyg@mail.gmail.com>
 <58f66f22-fd5f-685d-e608-99c35d89c1a3@linux.alibaba.com>
In-Reply-To: <58f66f22-fd5f-685d-e608-99c35d89c1a3@linux.alibaba.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 1 Dec 2020 14:38:50 +0530
Message-ID: <CA+G9fYs8jzvh6c3sfaMoCetQydtSrzsmcUvG4DpPW33bad7Q0A@mail.gmail.com>
Subject: Re: BUG: KASAN: null-ptr-deref in workingset_eviction+0xf2/0x1e0
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     inux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Muchun Song <songmuchun@bytedance.com>,
        alexander.h.duyck@linux.intel.com,
        Yafang Shao <laoar.shao@gmail.com>, richard.weiyang@gmail.co,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Alex,

On Tue, 1 Dec 2020 at 13:14, Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
>
>
> =E5=9C=A8 2020/12/1 =E4=B8=8A=E5=8D=883:52, Naresh Kamboju =E5=86=99=E9=
=81=93:
> > Crash log:
> > -----------
> > ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg1
> > [  285.862123] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [  285.863025] BUG: KASAN: null-ptr-deref in workingset_eviction+0xf2/0=
x1e0
> > [  285.863025] Read of size 4 at addr 00000000000000c8 by task kswapd0/=
245
>
> Hi Naresh,
>
> Good to know you again. :)

Same here :)

>
> Would you like to use command to check whichh line cause the panic:
>
> scripts/faddr2line vmlinux workingset_eviction+0xf2/0x1e0

scripts/faddr2line vmlinux workingset_eviction+0xf2/0x1e0
workingset_eviction+0xf2/0x1e0:
workingset_eviction at ??:?


vmlinux and system.map files available in this location,
https://builds.tuxbuild.com/1l0FDtgxYSNunuG5ERIXtvPjZ7R/

>
> I can't reproduce it. and my gcc version mismatch with yours.

Please run below easy steps to reproduce.
you may install docker and tuxmake.

Please share if you have any debug patch or proposed fix patch,
I would be happy to test.

Steps to reproduce:
--------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.

# tuxmake --runtime docker --target-arch x86_64 --toolchain gcc-9 \
--kconfig defconfig \
--kconfig-add https://builds.tuxbuild.com/1l0FDtgxYSNunuG5ERIXtvPjZ7R/confi=
g

# run LTP
# cd /opt/ltp
# ./runltp -s ioctl_sg01
# you see below crash

- Naresh
