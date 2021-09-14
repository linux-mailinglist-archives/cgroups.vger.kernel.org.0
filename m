Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6164A40B8BD
	for <lists+cgroups@lfdr.de>; Tue, 14 Sep 2021 22:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhINUMZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Sep 2021 16:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhINUMY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Sep 2021 16:12:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E847C061764
        for <cgroups@vger.kernel.org>; Tue, 14 Sep 2021 13:11:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so982901lfu.5
        for <cgroups@vger.kernel.org>; Tue, 14 Sep 2021 13:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WNWKwD/mZ8dmcHnPyLauepOSjhSOQ4h/50JmWkiv3s0=;
        b=EcGBNwXJXCtEjbiAqZ5SCobVNFat6cwVYl7UZrpcqRZjt6YQEX6uXqQn+h8Hur7RBP
         6Lf5fTjpJCmj8IvaaOplqMgXBBuH+tHM8BEY2eJbEt2CZkmxcK439Q5LYO665Vl+hepx
         U9uY2EfFCOyAcN720RTBPvT3JSy7zWXr5WL7kA4HRZZKTZaGILl/Fuo6ZgtZz8wkakTE
         bKU8KjiEsTo2dhRmKNviX8IQnNZk8d6Rla/TZwPNDuABbhWsQCKglo8WsadZhoars8AK
         wy5nMe2NRGbjEAOl5/WMffpVQdI12t6deZP3nc/5+R5qrjM6c9cJZ73AeuPhuI6PD293
         OWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WNWKwD/mZ8dmcHnPyLauepOSjhSOQ4h/50JmWkiv3s0=;
        b=ATCXVz0sZtVSlnR0xX42NcI/fJ3iTQCvU/AgapILIhIh4DmQXB24IDYbknYlgvRSMm
         JxFvj8vX0pXoeyoztMkfGPPQWgufDaPNrYVMT7IUvQNedP3rTWhCWQKmYc1q14i0tKux
         gnFsT3k21LH3jC5lHI7QyqWWSxhD3o0lnwg5CsX3ztzQBDMbpvwCKJNDNBiQZkfTLvOe
         1VtCnwRepdlzbIh19iZIjoc8BvbKMjk/pcuMpTXWy4wexggHU+WPdez4NK4Mw9V3uXCS
         C1ZQowbT3WGXREk0bgpYpSwEUIXHQjqZwV7ZwDq1Dt/DP7U0de2PyayTYougvwgOLXPB
         VCTA==
X-Gm-Message-State: AOAM531I1jnH0saJI/zEZvCi+DJGKqTOEKixRPpxTVwfJ9P1wXvcQEve
        xvKJEeMsgav6blmtPx+WqF0Tpsmjd66Lg/nv6GnnaA==
X-Google-Smtp-Source: ABdhPJwJhIZ7snNccUlf5HKWs3aKulgAz8Bz80UW1co9+ZsFlqTZY3qTz0PjV970lQ+di9xtI/9sOs58qbg+Py7MwnA=
X-Received: by 2002:a05:6512:31d3:: with SMTP id j19mr1698923lfe.368.1631650264534;
 Tue, 14 Sep 2021 13:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <50b83893065acaef2a9bc3f91c03812dc872f316.1631504710.git.brookxu@tencent.com>
 <CAHVum0dmTULvzD6dhr4Jzow-M1ATi-ubDkO5wQR=RQmWtt_78w@mail.gmail.com> <b62597e9-72c4-563e-fdc7-3315569502f0@gmail.com>
In-Reply-To: <b62597e9-72c4-563e-fdc7-3315569502f0@gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 14 Sep 2021 13:10:28 -0700
Message-ID: <CAHVum0dd5dw1rkcf0U7OjW2GX4VTZi4RCcbTph99qDftd=2taA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] misc_cgroup: introduce misc.events and misc_events.local
To:     brookxu <brookxu.cn@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, mkoutny@suse.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 13, 2021 at 7:24 PM brookxu <brookxu.cn@gmail.com> wrote:
>
> Thanks for your time.
>
> Vipin Sharma wrote on 2021/9/14 12:51 =E4=B8=8A=E5=8D=88:
> > On Sun, Sep 12, 2021 at 10:01 PM brookxu <brookxu.cn@gmail.com> wrote:
> >>
> >> From: Chunguang Xu <brookxu@tencent.com>
> >>
> >> Introduce misc.events and misc.events.local to make it easier for
> >
> > I thought Tejun only gave go ahead for misc.events and not for
> > misc.events.local.
> >
>
> Maybe I missed something. I think events.local is somewhat useful. For
> example, the events of node A is large. If we need to determine whether
> it is caused by the max of node A, if there is no events.local, then we
> need to traverse the events of the child nodes and compare them with
> node A. This is a bit complicated. If there is events.local, we can do
> it very easily. Should we keep the events.local interface=EF=BC=9F

Tejun mentioned in his previous email that he prefers the hierarchical
one. https://lore.kernel.org/lkml/YTuX6Cpv1kg+DHmJ@slm.duckdns.org/

I agree with you that it's easier to identify the constraint cgroup
with the local file. However, there is one downside also, which is if
a cgroup gets deleted then that local information is lost, we will
need a hierarchical reporting to observe the resource constraint. I
will be fine with both files but if I have to choose one I am now more
inclined towards hierarchical (events).

Thanks
Vipin
