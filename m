Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1ADA33C6C6
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 20:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhCOTZN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 15:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbhCOTYp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Mar 2021 15:24:45 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED34AC06174A
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 12:24:44 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z25so17639099lja.3
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/f9XDzNIvYjkey3GMR3Z4bha9CeQdt1BP03J0f875v4=;
        b=PpWndKMOuohcxOMFuTeXlpG64sQCd3ZU/cQ60Wm1qdLeMdXwSwBOaaPIq4BMw+LAS4
         KMi2z2s8zzwjzpplYncxfQBebjDw5eXXNOjWrTvwndD6OBstb99cPQXmE5Xor0dHAqTb
         N7NL2BmcnIfkAqui+DuNLMdOV1LXtEpGLly6qTkfAK1VD0hjDjhbj/tsz8P7dukD1Pwt
         03s15ZiJb7Y9vqgw9ZvEOGVFFj6b2G+Tv7Qef2TJekWIrLtUGyxVFKgFd+P10s0CdkZx
         PbgjJNzidVKLyEJyIfGA0t1M8rSxnGXg+aFtafRdUEkuYLfy1x8yOOqiukrROwasx1lc
         dsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/f9XDzNIvYjkey3GMR3Z4bha9CeQdt1BP03J0f875v4=;
        b=exsUpiZpo+/3uUG0BR6oOXRRJcU+jW2xcj9PlRm5WtXZsDTLdtUjkiK8O7+8ifGn7X
         JY/Z5pb2dcSRak1p80o2jUGotYyQD75HK3aVg3YCQk+wlBAlfsmQceDlZb2m2xuPEJVE
         xspc1QaHHGqhAmmmP49RCh8g8H8azkek9NIIFYotNhnrypIOEIA/YIW/3MfT7fwCx1oC
         E3zA3Kz4xecjKGe9BTKU/B2lX+yqH5A7sR3jvY6lHkJmx0NjTpx+4CVkFY0L4N+1nuGM
         sJwFrEyAEL91LVb8vZxr1cWZBkZ1j7iIFrPdO6SVJD1nVGu7qL0gZdfWQ5L3lwhr0wCL
         FDKA==
X-Gm-Message-State: AOAM5312MlLDpOLiBNiSDfOWmHwJUa0pg0FuWFiDFmVcyFinwYrzAZWb
        /f21bVDax8DgB147PwbbTGOXp5HKoZ22bucRGxf7rdf6GmI=
X-Google-Smtp-Source: ABdhPJy0NjnN+FMF8APlbSCEIAwZYmvUOqzVQJZCZumFdWQf4p/XUb0N0SlWRyZWxNKLYezMt31oTdWUOKVnhj33+lk=
X-Received: by 2002:a2e:9195:: with SMTP id f21mr329002ljg.160.1615836283259;
 Mon, 15 Mar 2021 12:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <YEnWUrYOArju66ym@dhcp22.suse.cz> <85b5f428-294b-af57-f496-5be5fddeeeea@virtuozzo.com>
 <20210315100942.3cc98bb4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210315100942.3cc98bb4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 15 Mar 2021 12:24:31 -0700
Message-ID: <CALvZod4ct6X_M1fzKufX1jKoO2JEE_ONwEmiDWTbpt-fut85yA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] memcg: accounting for fib6_nodes cache
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 15, 2021 at 10:09 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 15 Mar 2021 15:23:00 +0300 Vasily Averin wrote:
> > An untrusted netadmin inside a memcg-limited container can create a
> > huge number of routing entries. Currently, allocated kernel objects
> > are not accounted to proper memcg, so this can lead to global memory
> > shortage on the host and cause lot of OOM kiils.
> >
> > One such object is the 'struct fib6_node' mostly allocated in
> > net/ipv6/route.c::__ip6_ins_rt() inside the lock_bh()/unlock_bh() section:
> >
> >  write_lock_bh(&table->tb6_lock);
> >  err = fib6_add(&table->tb6_root, rt, info, mxc);
> >  write_unlock_bh(&table->tb6_lock);
> >
> > It this case is not enough to simply add SLAB_ACCOUNT to corresponding
> > kmem cache. The proper memory cgroup still cannot be found due to the
> > incorrect 'in_interrupt()' check used in memcg_kmem_bypass().
> > To be sure that caller is not executed in process contxt
> > '!in_task()' check should be used instead
>
> Sorry for a random question, I didn't get the cover letter.
>
> What's the overhead of adding SLAB_ACCOUNT?
>

The potential overhead is for MEMCG users where we need to
charge/account each allocation from SLAB_ACCOUNT kmem caches. However
charging is done in batches, so the cost is amortized. If there is a
concern about a specific workload then it would be good to see the
impact of this patch for that workload.

> Please make sure you CC netdev on series which may impact networking.
