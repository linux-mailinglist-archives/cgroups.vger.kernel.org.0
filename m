Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9154D140FE4
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2020 18:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgAQRa3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jan 2020 12:30:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39378 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgAQRa3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jan 2020 12:30:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so8448639wmj.4
        for <cgroups@vger.kernel.org>; Fri, 17 Jan 2020 09:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s/Igl7jec5R8DMF3nyQFihy0XoNH7LpzgEc781wHBbE=;
        b=IfI2V2VjiHDEyMxVeB6DJUwZfuJaVSwdWaVbiW2tG1VzG5iMe4Fmndr3Dh8Y5KaF7g
         SbVP5Ca373H4SpjZNwlaPj0ajlmO5/0RXj4cboBUBjlynN2ihp0sj5+LxlF9hYR3Gs5D
         5Qv2rZh4Yzvc8lS4UP3Ac5LRe5cw1v+Y0yJdR8pwwdPPusdbhjfrDBsi13y8DYwoaakI
         cuAz6BXfPrsKPA1w9FiWbzNzE9zzgpb3Rr4pw20A0bJZFGooUMKUtslJ3QXvxVnMh650
         IIszWgCEmch4wXJw0b3IsDeqswH27TUpZ2/KnyYvteCdFYD5butLob8faQQd6VS5iI6D
         fZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s/Igl7jec5R8DMF3nyQFihy0XoNH7LpzgEc781wHBbE=;
        b=uQZxyaQJesqBqohN17ycUJt/HaYZb6Jk7rpFMuKkzrCY3K0JwKLiFhG/UXZiJAH24c
         aEKNq2v67RR7WGv8DwusQJXb99YnCpp3utshay/OW6YbnxV8PZdZH5Qt3zR1dpIlh/jq
         cBB+xnJfwZmMWuMay349uMvzfN0n7ppHz7fqCP1pF1Aqs1bYdAtxrQ7RRDU5LPnLM0Aq
         wfANXlM/ig4xN5cxYDS+MTdX/xjUCYQGtR/gdTSDDIoYqL4BGvMLDZXyK/X5WAi+vEz9
         geWfTF7dPKM9X6orNCQbPorFRWSMwR2LkvBvs48wMFJ187X+Q2vc3XkbZehiosn/EN9w
         80uw==
X-Gm-Message-State: APjAAAWdAPUahnPevEnr+MdSekrPBsq/QCck6kh1JWoLm0kSwnPsuAt6
        eWDHMhPxGgY9plCfbi/zD8/MK74o9XJPren+FPBJAw==
X-Google-Smtp-Source: APXvYqzRUf0wuugbvneoW29gNcVYmOiCM6ix6iVR1pyh/dPBzXnBInYEBfLi/RQ7RKNXoAYeNH1N+QN4jkAc1zvQ3nI=
X-Received: by 2002:a1c:7e0b:: with SMTP id z11mr5822249wmc.88.1579282226314;
 Fri, 17 Jan 2020 09:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20200116043612.52782-1-surenb@google.com> <20200117151533.12381-1-mkoutny@suse.com>
In-Reply-To: <20200117151533.12381-1-mkoutny@suse.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 17 Jan 2020 09:30:15 -0800
Message-ID: <CAJuCfpHkOz1LmygyxC9VxXux8_TFmEGr-BsAs-EadKt=AkZyiQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] cgroup: Iterate tasks that did not finish do_exit()
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     cgroups mailinglist <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        alex.shi@linux.alibaba.com, Roman Gushchin <guro@fb.com>,
        kernel-team <kernel-team@android.com>,
        JeiFeng Lee <linger.lee@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        shuah@kernel.org, Tom Cherry <tomcherry@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On Fri, Jan 17, 2020 at 7:15 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> Hi,
> I was looking into the issue and came up with an alternative solution tha=
t
> changes task iteration to be consistent with cgroup_is_populated() check =
and
> moving the responsibility to check PF_EXITING on the consumers of iterato=
r API.

Yeah, that was my first thought which basically reverts a part of
c03cd7738a83. When I first brought up this issue in the other email
thread, Tejun's comment was "the right thing to do is allowing
destruction of cgroups w/ only
dead processes in it". I assumed, maybe incorrectly, that the desire
here is not to include dying processes into cgroup.procs but to allow
cgroups with dying processes to be deleted.

To be clear, either way is fine with me since both ways solve the
issue and this way the code is definitely simpler. I'll rerun the
tests with your patches just to confirm the issue is gone.
Thanks!

> I haven't check your approach thoroughly, however, it appears to me it
> complicates (already non-trivial) cgroup destruction path. I ran your sel=
ftest
> on the iterators approach and it proved working.
>
>
> Michal Koutn=C3=BD (2):
>   cgroup: Unify css_set task lists
>   cgroup: Iterate tasks that did not finish do_exit()
>
> Suren Baghdasaryan (1):
>   kselftest/cgroup: add cgroup destruction test
>
>  include/linux/cgroup-defs.h                |  15 ++-
>  include/linux/cgroup.h                     |   4 +-
>  kernel/cgroup/cgroup.c                     |  86 ++++++++--------
>  kernel/cgroup/debug.c                      |  16 ++-
>  tools/testing/selftests/cgroup/test_core.c | 113 +++++++++++++++++++++
>  5 files changed, 176 insertions(+), 58 deletions(-)
>
> --
> 2.24.1
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
