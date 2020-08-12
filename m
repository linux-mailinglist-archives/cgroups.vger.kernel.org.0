Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7522243035
	for <lists+cgroups@lfdr.de>; Wed, 12 Aug 2020 22:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHLUry (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Aug 2020 16:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHLUrx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Aug 2020 16:47:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BC4C061383
        for <cgroups@vger.kernel.org>; Wed, 12 Aug 2020 13:47:53 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id w14so3781106ljj.4
        for <cgroups@vger.kernel.org>; Wed, 12 Aug 2020 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YMlwqJSUWt1i6F6iEK9tCz9nN1m89EegznfYz1dxWM0=;
        b=Is7wIv1rlekdHNR2ib1o3cMo7WVrmIWWC+LnWxvZAwG92uGCGXtX+YtRbd5ROD2lgh
         Mpge5B1FXl6BaNj26hyaOzPPnA/QNeUNdczVSHNUJaIOR0yCrpT0DSqce2Ygglc5BYhQ
         ro0sx555IRcMIxwNlNfuI02xPmAvGNvYsb++W590hadWc97jyGgtLkvZHj2gF8ZOzG++
         n115EKAR5i7tUZQBbP7f9U2RCDZrj6qoW32soFk4Ha4K37OBfgrq3+Bw86zdjTYqLCu4
         ZPqFwWhZ0aQtyUiu/o3CIhSt6o8RAzjriZE/ElCU67i76Ue+4gB1Brnbzon9m2IGI/Lx
         /H7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YMlwqJSUWt1i6F6iEK9tCz9nN1m89EegznfYz1dxWM0=;
        b=VKTV+6aQfFhRRL7zFbiA0WggR8F/YQbMlCBmAZJmKg7JUsqyCURSTeYE8NNi0AOV/X
         HIsod5UD5oGu+ZeJMGyWmXWKdsvDKIP0U9z6dkFBukQRAHwFSLuNC5s+TqR3McjJrrC8
         QbrwkG9X354zmgs98n8FEJqIek+CoCGEdBAiVmWcL9Bb33D6JGf0as7tUsIddijIh3Pc
         F0ZwDhkQNjFAp6AoiniCIyeDZC9nGRLDU0ITLDGzG00onRTFACNQLN9dIroIuEjMAPBb
         4aIyb1mGFrkoL6zSa20eSRfj4dPyhNdBFPHWxT7f5QvsnMEhISOqrBXocU//SGRA17MQ
         au7Q==
X-Gm-Message-State: AOAM532Nt/LK57i95N4sJbt8h/y10LXkF8/H134RmcETOAjW64MWwRUv
        99M6+Y2bTkH7aWvBFglQe9mEOp4XIRsCkpQ3UeJRWg==
X-Google-Smtp-Source: ABdhPJzdFOd56sO3fLqOrp2lhWBF4iWcxurm5bqT8H2lGb+JKbkDtwS66QTjNiURfm9n7xaOsbyj9XgtOxBCZhFiPyc=
X-Received: by 2002:a05:651c:330:: with SMTP id b16mr461290ljp.77.1597265270865;
 Wed, 12 Aug 2020 13:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200702152222.2630760-1-shakeelb@google.com> <20200703063548.GM18446@dhcp22.suse.cz>
 <CALvZod5gthVX5m6o50OiYsXa=0_NpXK-tVvjTF42Oj4udr4Nuw@mail.gmail.com>
 <20200707121422.GP5913@dhcp22.suse.cz> <CALvZod5ty=piw6czyVyMhxQMBWGghC3ujxbrkVPr0fzwqogwrw@mail.gmail.com>
 <20200811173626.GA58879@blackbook>
In-Reply-To: <20200811173626.GA58879@blackbook>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 12 Aug 2020 13:47:39 -0700
Message-ID: <CALvZod4+urCc-fFcjkoNOoLLyzcAW=hr14XgmBMAP+RnEyRyfw@mail.gmail.com>
Subject: Re: [RFC PROPOSAL] memcg: per-memcg user space reclaim interface
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On Tue, Aug 11, 2020 at 10:36 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrot=
e:
>
> Hi Shakeel.
>
> On Tue, Jul 07, 2020 at 10:02:50AM -0700, Shakeel Butt <shakeelb@google.c=
om> wrote:
> > > Well, I was talkingg about memory.low. It is not meant only to protec=
t
> > > from the global reclaim. It can be used for balancing memory reclaim
> > > from _any_ external memory pressure source. So it is somehow related =
to
> > > the usecase you have mentioned.
> > >
> >
> > For the uswapd use-case, I am not concerned about the external memory
> > pressure source but the application hitting its own memory.high limit
> > and getting throttled.
> FTR, you can transform own memory.high into "external" pressure with a
> hierarchy such as
>
>   limit-group                   memory.high=3DN+margin memory.low=3D0
>   `- latency-sensitive-group    memory.low=3DN
>   `- regular-group              memory.low=3D0
>
> Would that ensure the latency targets?
>

My concern was not "whom to reclaim from" but it was "If I use
memory.high for reclaim, processes running in that memcg can hit
memory.high and get throttled". However Roman has reduced the window
where that can happen. Anyways I will send the next version after this
merge window closes.

Shakeel
