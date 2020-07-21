Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDE12288F5
	for <lists+cgroups@lfdr.de>; Tue, 21 Jul 2020 21:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgGUTNM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jul 2020 15:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbgGUTNM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jul 2020 15:13:12 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98290C061794
        for <cgroups@vger.kernel.org>; Tue, 21 Jul 2020 12:13:11 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k13so3314143lfo.0
        for <cgroups@vger.kernel.org>; Tue, 21 Jul 2020 12:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1+MBynaOaFc+TQGQ/+zLUDlbfNpuxAiueoXbqW+mHQ=;
        b=CnYKPb1Xv2Oa9t8RxiLG8qh5LFd1tQ4x4f0WjwYFg0GeyKeD8WtsbrK0ptSPAvEwl2
         p5N38bdjZsT11squqkQ1pPFLR9OGUwiDyFO1XbXZvTeA+Phru4E2ctuap9k6B7ovdktM
         c1hj9ICibOXamyVTIL9p8vYpWBYTXMAm08B9cKvi34M8bs+ahrGlrDUCP/R2c1BueQFN
         vDKbKpW7kZ9rqKt+fNxsj407lyPTEGwfMi3MMK8QZsqwyq6YDDGlB6I7vYjAl7jTwHsB
         /AdU0ePREeL3IVkKswnAQ8Vc0ueP/mNPN2/leFB8tSv5ukqw0EhQ0veO+jKqLwnXzr6L
         9ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1+MBynaOaFc+TQGQ/+zLUDlbfNpuxAiueoXbqW+mHQ=;
        b=kFT81Gv/789T1CPoB2NZNVhczPIVvfnCmpf6s29BFvz2NdAqiyTksc1oxnGI6rRm4g
         33UMpw3wfeI4WvhRzoHg7h018ECbmK/CV1CYxlvU0Wgl3CPOOIWCGlQVP+iJMGK8DR8T
         9k2Wp97cWdLUL6foKjlSZy4SZ7DXjxuK+YEIU6SIJ+hrxACM7kBZKTmmXYhMdtUz0287
         OmzGCtB2g2wVV2yFxJee34UA7Kh/XzeAqRR4GKjx1a+mVFxWjAw1S7dWqH3cGhywS+K2
         8SUTLsGMubXA56lBIqRfxWoIG2Y9ypy9Lqu0tWg8f3OHjOSH21rK2cauqgQd9iRz3bP0
         U1QQ==
X-Gm-Message-State: AOAM532C5FO7R7p/VIfk8jsHwbfe7ehDle9U+Fx1HK1TYC2kjkqsSscI
        iZztbHwoNH53QheTuCY/WMkE0r/GwHLr+VuKJLOQ5w==
X-Google-Smtp-Source: ABdhPJx4x3WE7/pXjDBRdRagnXwO29Oe/I8pts7edpG8D4QIOLnM3lnE0dfWuR25FRqWYY2Z3HPd7DX+8UxG3rCtJpQ=
X-Received: by 2002:a19:e61a:: with SMTP id d26mr14162136lfh.96.1595358789794;
 Tue, 21 Jul 2020 12:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <2E04DD7753BE0E4ABABF0B664610AD6F2620CAF7@dggeml528-mbx.china.huawei.com>
 <20200721174126.GA271870@cmpxchg.org> <20200721184959.GA8266@carbon.DHCP.thefacebook.com>
In-Reply-To: <20200721184959.GA8266@carbon.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 21 Jul 2020 12:12:58 -0700
Message-ID: <CALvZod6-sTBMzvo0ER+RkQ_OM7B4=PKUC-T9gXmQiB8mznunBg@mail.gmail.com>
Subject: Re: PROBLEM: cgroup cost too much memory when transfer small files to tmpfs
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, jingrui <jingrui@huawei.com>,
        "tj@kernel.org" <tj@kernel.org>, Lizefan <lizefan@huawei.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        caihaomin <caihaomin@huawei.com>,
        "Weiwei (N)" <wick.wei@huawei.com>, guro@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 21, 2020 at 11:51 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Jul 21, 2020 at 01:41:26PM -0400, Johannes Weiner wrote:
> > On Tue, Jul 21, 2020 at 11:19:52AM +0000, jingrui wrote:
> > > Cc: Johannes Weiner <hannes@cmpxchg.org> ; Michal Hocko <mhocko@kernel.org>; Vladimir Davydov <vdavydov.dev@gmail.com>
> > >
> > > Thanks.
> > >
> > > ---
> > > PROBLEM: cgroup cost too much memory when transfer small files to tmpfs.
> > >
> > > keywords: cgroup PERCPU/memory cost too much.
> > >
> > > description:
> > >
> > > We send small files from node-A to node-B tmpfs /tmp directory using sftp. On
> > > node-B the systemd configured with pam on like below.
> > >
> > > cat /etc/pam.d/password-auth | grep systemd
> > > -session     optional      pam_systemd.so
> > >
> > > So when transfer a file, a systemd session is created, that means a cgroup is
> > > created, then file saved at /tmp will associated with a cgroup object. After
> > > file transferred, session and cgroup-dir will be removed, but the file in /tmp
> > > still associated with the cgroup object. The PERCPU memory in cgroup/css object
> > > cost a lot(about 0.5MB/per-cgroup-object) on 200/cpus machine.
> >
> > CC Roman who had a patch series to free all this extended (percpu)
> > memory upon cgroup deletion:
> >
> > https://lore.kernel.org/patchwork/cover/1050508/
> >
> > It looks like it never got merged for some reason.
>
> The mentioned patchset can make the problem less noticeable, but can't solve it completely.
> It has never been merged, because the dying cgroup problem was mostly solved by other methods:
> slab memory reparenting and various reclaim fixes. So there was no more reason to complicate
> the code to release the memcg memory early.
>
> The overhead of creating and destroying a new memory cgroup for a transfer of a small
> file will be noticeable anyway. So IMO the solution is to use a single cgroup for all
> transfers. I don't know if systemd supports such mode out of the box, but it shouldn't
> be hard to add it.
>
> But also I wonder if we need a special tmpfs mount option, something like "noaccount".
> Not only for this specific case, but also for the case when tmpfs is extensively
> shared between multiple cgroups or if it's used to pass some data from one cgroup
> to another, or if we care about the performance more than about the accounting;
> in other words for cases where the accounting makes more harm than good.
>

Internally we actually have an tmpfs mount option "memcg=" which
charges all the memory of the tmpfs files on that mount to the given
memcg and the motivation is the shared tmpfs files between multiple
cgroups. One concrete use-case is the shared memory used for
communication between the application and the user space network
driver [1]. The "memcg=root" can be used as a "noaccount" option.

[1] https://sosp19.rcs.uwaterloo.ca/slides/marty.pdf
