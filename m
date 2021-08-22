Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76573F3EEC
	for <lists+cgroups@lfdr.de>; Sun, 22 Aug 2021 12:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhHVKG6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 22 Aug 2021 06:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhHVKG5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 22 Aug 2021 06:06:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50A3C061575;
        Sun, 22 Aug 2021 03:06:13 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id z20so30181907ejf.5;
        Sun, 22 Aug 2021 03:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lDNBGIq+xGdVYw1TUBg1mZGiYyDFgWVG+GX+moPobUw=;
        b=czNcR77rw/X56j3Zar4Kopj/sUheukLLzJQWR+1pmlT99701iQkSSg0UgAVn0Y9+iY
         ylQLwbDLvKww8h65MzXNUl7vU72Njq70cP9MPI5Ebg+3ZWgMOj+7mXct1RhyLdtjvMRK
         AUgCmab2SKk7y+BtB614dhhP0ehHirc9NiSMlqtX4cJyM33u3F6dsCCx+1rX8QYQFLtE
         U/FjAXG/VhwnTeFyjZTq0O1icCvLC6RRAkXfolLTIZovp/bG5NPvE+XEXqskkNg3Jfc6
         EBtNJxdBcGw5oMxCgqkK+Jx4q4Yh3Y6/zNR51GOPYKGhXr9VJf1D+jpUJm9wziX6x9OZ
         faWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lDNBGIq+xGdVYw1TUBg1mZGiYyDFgWVG+GX+moPobUw=;
        b=qESLC4H4nk6jQ4p64+OMgT+wYBOc6qTbELGUxZv5Ew9R2x9fO6NRgKhw7D7IgXcZAe
         BJSomMRVRQaIYDdRG+SLpYOgXcW5RvHmp9ZfP6GOEDKUkvQ3dOb59IdU2mAUXiLGNU/n
         d5hRSI7WqVZa77Tnas2tdk2b3t452Klu0dzUx1F7kMrBNCcR4n9PnAAacZo1wVKN1h7W
         56ooUIfWw2GLbpuF2IcwtlFLQJzH42ecpS2XK9cjafdQz+jheHOKiWy0S5pk1wvMMHcC
         zEwV1U5Nn/iop/pYOCTpNkZYHX8pcf9AJC+zuWdsiSYCz8iAcMlisl1ZrWdlV6g5oP/K
         alsQ==
X-Gm-Message-State: AOAM530EqSjqHd7P22fPgT9eK7c6jVogqk/WqwS7fTXdJKn+YuAgBiKA
        HppfRA+09tTRXH1hqLie0hb71zSz/lV49WX8iTg=
X-Google-Smtp-Source: ABdhPJwM28Y6tOVIUwHzDZsMLViJQBLmV74+c9NknAMPcnKlC5q+2TlV9KJm7u5imxL5BSM3d3X2G4Umy6NFLpLDdX4=
X-Received: by 2002:a17:906:93e8:: with SMTP id yl8mr3892304ejb.524.1629626771746;
 Sun, 22 Aug 2021 03:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <1629417219-74853-1-git-send-email-wang.yong12@zte.com.cn>
 <CALvZod5usW9OEsJSbeGYBnSGVDNLLKqMoGAx-JQrX6s62r-XiA@mail.gmail.com> <CAOH5QeCf6+xiT_Wjtw=BegCYWc2H52qeKVsTh2aha0SG2xyU5w@mail.gmail.com>
In-Reply-To: <CAOH5QeCf6+xiT_Wjtw=BegCYWc2H52qeKVsTh2aha0SG2xyU5w@mail.gmail.com>
From:   yong w <yongw.pur@gmail.com>
Date:   Sun, 22 Aug 2021 18:06:00 +0800
Message-ID: <CAOH5QeCGunHAnYD=s8vDZ1krnruoCV9kbpEikTcHsxcC+KXoow@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add configuration to control whether vmpressure
 notifier is enabled
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>, alexs@kernel.org,
        Wei Yang <richard.weiyang@gmail.com>, Hui Su <sh_def@163.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        wang.yong12@zte.com.cn, Cgroups <cgroups@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn,
        wangyong <wang.yong@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, I find the code of socket pressure and vmpressure are related.
And there are two ways to be discussed
1. The calculation of socket pressure is handed over to the psi.
2. Vmpresssure and psi update socket pressure respectively, and are
configured separately.

Thanks.

yong w <yongw.pur@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8820=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8810:29=E5=86=99=E9=81=93=EF=BC=9A
>
> Shakeel Butt <shakeelb@google.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=887:42=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Aug 19, 2021 at 4:54 PM <yongw.pur@gmail.com> wrote:
> > >
> > > From: wangyong <wang.yong@zte.com.cn>
> > >
> > > Inspired by PSI features, vmpressure inotifier function should
> > > also be configured to decide whether it is used, because it is an
> > > independent feature which notifies the user of memory pressure.
> > >
> >
> > It is also used by the networking stack to check memory pressure. See
> > mem_cgroup_under_socket_pressure().
>
>  Thanks for your replly, mem_cgroup_under_socket_pressure does use vmpres=
sue,
>  I'll check it.
