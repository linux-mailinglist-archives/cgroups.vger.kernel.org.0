Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC6717092A
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2020 21:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgBZUCq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Feb 2020 15:02:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36263 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgBZUCp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Feb 2020 15:02:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id j20so666872otq.3
        for <cgroups@vger.kernel.org>; Wed, 26 Feb 2020 12:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYPZLk9fblhfI7X9fM3xbDPsnJvljmxVNytskCU+vlA=;
        b=UyP5fnk2tcq/pPIf8UiuwxkR5072gZy0q/BJ2uagssjQU8qPl2XlFZef/INcAqm/G/
         AIzv7Fc+eTguGy7/felWPoIFpMQfSwUovQC59vXMK3nK9Vld9VdxSJVDicbvgWOoN9Hc
         lp6Ttr3B2PC+IVX+BU48YAaEoSpQUtEPZEVOyu252uIIjzfQutowIm9kF5gwglA+Mga6
         WWmBOfvwOmDJ4tDldTih3mXrVaeidJaV15tBRGEoVRZ4mnxtChsEM3sWHWTcRg38Tv9P
         1liVai5ZMM8MDyDZbBiD/OsEkAEtf+9uLwxyaxcV1jCFl7V2wMCKotF0lyMmLkNbF9cb
         35sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYPZLk9fblhfI7X9fM3xbDPsnJvljmxVNytskCU+vlA=;
        b=PuZ3jQT/mbZY5ltoIqt7FDNP4K9CrmJ0LZ4NG2i0YXtdFaV7fgN3t+vO0polqQzw8L
         N/2BeKFAjdcZD8636PJaCJD1fUhGt1fQU9wk5+QGEHrjpyMedhbu3E1Ynq7PfI9q3DBR
         Eou9CFgPn+IoAc0UjthMDXs2aJ10wtmxNVIR/uXdpLO+x09UVdYkSlFMYIobuCuQJ6ff
         3IAMPVy9JRTFTq7P6tXaYPMHc4nFQk+tUf/vEyhDvQofHFfZ9qwlO3lHHOamB4H87HXD
         hTXKuJ6lMLvPPHXCUZDYFX4acwaq9dLwT88eID7OLqIFxMZkqfQ1xaXcRUt31N8w6sHu
         PWbw==
X-Gm-Message-State: APjAAAXY5GSQHMDRuWItXPZ9IK70l1ZByI8PPXT4L5ysd9K8Tb361PLo
        tC2PMXWYqvZ3yiC0wPykrpQ8xTZTklk/wd5rzmXtWQ==
X-Google-Smtp-Source: APXvYqwWb32V/0K0pdQElKXeofe1I4diMq4dFnLk2SNlKDa4ZAncUqcmsHgASgI17lp4ZQoieYvDqTld7vL+VECLrE4=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr356628otq.191.1582747362553;
 Wed, 26 Feb 2020 12:02:42 -0800 (PST)
MIME-Version: 1.0
References: <20200221014604.126118-1-shakeelb@google.com> <20200226.110749.77396284962321904.davem@davemloft.net>
In-Reply-To: <20200226.110749.77396284962321904.davem@davemloft.net>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 Feb 2020 12:02:31 -0800
Message-ID: <CALvZod5TsauERhaCqa1OZp4FaX4nq_UBL84=siESEG=Uk4LYuQ@mail.gmail.com>
Subject: Re: [PATCH v3] cgroup: memcg: net: do not associate sock with
 unrelated cgroup
To:     David Miller <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 26, 2020 at 11:07 AM David Miller <davem@davemloft.net> wrote:
>
> From: Shakeel Butt <shakeelb@google.com>
> Date: Thu, 20 Feb 2020 17:46:04 -0800
>
> > We are testing network memory accounting in our setup and noticed
> > inconsistent network memory usage and often unrelated cgroups network
> > usage correlates with testing workload. On further inspection, it
> > seems like mem_cgroup_sk_alloc() and cgroup_sk_alloc() are broken in
> > IRQ context specially for cgroup v1.
> >
> > mem_cgroup_sk_alloc() and cgroup_sk_alloc() can be called in IRQ context
> > and kind of assumes that this can only happen from sk_clone_lock()
> > and the source sock object has already associated cgroup. However in
> > cgroup v1, where network memory accounting is opt-in, the source sock
> > can be unassociated with any cgroup and the new cloned sock can get
> > associated with unrelated interrupted cgroup.
> >
> > Cgroup v2 can also suffer if the source sock object was created by
> > process in the root cgroup or if sk_alloc() is called in IRQ context.
> > The fix is to just do nothing in interrupt.
> >
> > WARNING: Please note that about half of the TCP sockets are allocated
> > from the IRQ context, so, memory used by such sockets will not be
> > accouted by the memcg.
>
> Then if we do this then we have to have some kind of subsequent change
> to attach these sockets to the correct cgroup, right?

Currently we can potentially charge wrong cgroup. With this patch that
will be fixed but potentially half of sockets remain unaccounted. I
have a followup (incomplete) patch [1] to fix that. I will send the
next version soon.

[1] https://lore.kernel.org/linux-mm/20200222010456.40635-1-shakeelb@google.com/
