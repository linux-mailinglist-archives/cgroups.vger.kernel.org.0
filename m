Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CCE410291
	for <lists+cgroups@lfdr.de>; Sat, 18 Sep 2021 03:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhIRB2n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Sep 2021 21:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhIRB2m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Sep 2021 21:28:42 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6F2C061574;
        Fri, 17 Sep 2021 18:27:20 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e16so10781107pfc.6;
        Fri, 17 Sep 2021 18:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dq5NAUNnuQNz4xykRs3WCZJi29irBQGvaHlCZa+2iL0=;
        b=ZMx3BcEsTREXr2zFDd4dWEB/1hW4z4yKEKIJHajsDhjJTlx7vYAT06Tcrbck05mSpx
         4TnoszT1uZUsSTJHsmR/7NlPGUf06c3sUSmZOfEc0W6lnVYjyn17l+KmAHVNhfYNzAUP
         vMaOZUPbUMAGhhUlbqpj8WODuQNaMIF83can/QlZVYveu/eqopuo8o7cAZBfZW8BzUaR
         W4fiiDo2BcKDfAJ4FunyGfeM4cXJIabjtg6iuJF8VxaG7uo1nX6e3SMxXKJq9ZWmkebc
         qKAaQZme5Pih44UhxvjlgeaRDp6fEbJeES6vT67pwKpx/yEI2eiXEnQCtsJVfC7GVop4
         89VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dq5NAUNnuQNz4xykRs3WCZJi29irBQGvaHlCZa+2iL0=;
        b=l65nBrZsi5eBjJBmIIElkVpnO9xI5SmqxgfjFUo7FeUSdfwkcyUkxmOtN4zlZphQjL
         KEEOR6/CpR10kWE113VTP48cFhDLvVHfe4q2oU23JFulGhHf7VD3q5IZXUWT7tNjXGaq
         Irt19AjFpX8wF02RKO3CGELyHMaU7AYhkqOUvyOUslqYIdqx1spHTpLmuOnkN1eutkOw
         J/HjWCDbGbi/QKck2l0LAXY/J73/eMxdRIQsfb8S/Cx7cXGnBRaS9GizZgJUXtcVN9at
         Gg8b8yUPTNNeWjNYdg44LQ0QzXcyg/+elQzpIoy5er3qo+um7mXDmX/y82yFTVt/yrOE
         Esbw==
X-Gm-Message-State: AOAM532qC6MX3V2hpG8wmppd10tZ8QmJQXsl65tOu1l/25XbJsC4hpR+
        RAYrDnh16rmvhuRCoMiDZPGoDySwHAxo6cKZfg==
X-Google-Smtp-Source: ABdhPJwUf3y14j1joGFAgM7rztei2JvsxkhXnW+ZhxShQURZC+sQxnjcapY1QjQSxkvJEj7PsxseHLrallI5d4cTxuM=
X-Received: by 2002:a05:6a00:2449:b0:43c:4a5e:55a6 with SMTP id
 d9-20020a056a00244900b0043c4a5e55a6mr13586668pfj.43.1631928439621; Fri, 17
 Sep 2021 18:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsbPVdkub=e-E-p1WBOLxS515ith-53SFdmFHWV_QMo40w@mail.gmail.com>
 <20210917164123.GA13346@blackbody.suse.cz>
In-Reply-To: <20210917164123.GA13346@blackbody.suse.cz>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Sat, 18 Sep 2021 09:27:08 +0800
Message-ID: <CACkBjsZnp8Kf26tR3anbcLQNiMJ9=bqYMJ66tKBvXO6tkV3qyw@mail.gmail.com>
Subject: Re: KCSAN: data-race in cgroup_rstat_flush_locked / cgroup_rstat_updated
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, hannes@cmpxchg.org,
        lizefan.x@bytedance.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

Michal Koutn=C3=BD <mkoutny@suse.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8818=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:41=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello Hao.
>
> On Thu, Sep 16, 2021 at 09:53:55PM +0800, Hao Sun <sunhao.th@gmail.com> w=
rote:
> > KCSAN reported the following data race during the kernel booting when
> > using Healer to fuzz the latest Linux kernel.
> > [...]
> >  cgroup_rstat_cpu_pop_updated kernel/cgroup/rstat.c:139 [inline]
> >  [...]
> >  cgroup_rstat_updated+0x53/0x1b0 kernel/cgroup/rstat.c:38
>
> FWIW, it's a "safe" race between updaters and flushers (possibly
> missing the latest update(s)). This is expected as explained in
> cgroup_rstat_updated() comment.
>

Would it be better to add a `data_race` macro to the corresponding
location so that the false report can be disabled?
See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/memory-model/Documentation/access-marking.txt#n58
for more details.
Currently, fuzzer can not test the kernel with KCSAN enabled for a
long time, because cgroups setup is the basic step before executing
any test case.

Regards
Hao
