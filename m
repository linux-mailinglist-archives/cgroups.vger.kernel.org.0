Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB3C1AE263
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2020 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDQQlS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Apr 2020 12:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgDQQlS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Apr 2020 12:41:18 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD0AC061A0C
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 09:41:17 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k28so2309146lfe.10
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 09:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KReP0BQ7R9kDWKVN2qYXZOSpqxd/RqsatXVhR8Hp+6M=;
        b=A+CXQpwUauVcRxKfmCkhrY+lO8YU2Of5TvIiYGM8+ZPQlQxaAlRsouUQvYIVuYEfo9
         tiFjNYW4sA8i7jeVhSr4CGPhlKpq3zNblY0JIHYp7mUhuPZ+nr52IAgv8ozW5UO4aCFr
         1xyOETsWR7Hu1Jy0boQWlTBoROvOK1qxhWVumIDprKpG6rUXf7Il+1RCub37qYG7s0i6
         vTd0fKn7UlV78sU6nxXxaEMbfUVFHOuAWNgVkcvgiz+OZCP4AOGXFdg2IzaPl2wF02Y5
         pvnB1XKmzAQb+B+OhYk2vHB5o71IRkdE8KQBO1A86zGoCa6jppakQhH1Tu7QZ7MRnUrh
         ufqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KReP0BQ7R9kDWKVN2qYXZOSpqxd/RqsatXVhR8Hp+6M=;
        b=DvJqNUQ5ZROzuQ0FhjQjxsRDRPBfDt3FyPgfqQj00NL6lFgHodCpPq046JPBzVGp2C
         FFKEAu1VzIWfoK+sY7IXq9XUBhoGDHlHiJAKoQd6/aOHsWERlFdZ1zUxVKAK2uM18Hcr
         NNvOiBXNdhp8w+fvAX4dIlcVDAJieJSoJ/u07UTO6l9DOP3XDmFw0L1RBUjSObrDtBn5
         IFVk+MascBikZO8uQaYvHNX2nC0jR9HpNCNVeThaZ6wzE10nrakXHRdPfBLKpPN2hWjk
         Cr5nEgyqWaNkcXiNi4LUFXzAsRVGFLYZTJD5Bs6OERGGkWVhdYWYC6Jtj7f2QXc5xREX
         fyVg==
X-Gm-Message-State: AGi0PuZb0KzoPO+4wCa+vr6oLtkdfBdDDq49qDE02p68uT26pYNqDNuu
        oKPHqZWj7a6iiPW0PD9q6rNG6aMj9duIGFCsaLQlaw==
X-Google-Smtp-Source: APiQypKsYQEjmk9jge5Ap9/TOaSDMsXV1vm37kJTAvdwzjqdzMAFBfGpUon2DIbYZM/d42XY8I0UZtNyvCwr2JhoxUQ=
X-Received: by 2002:a19:5206:: with SMTP id m6mr2620913lfb.33.1587141675828;
 Fri, 17 Apr 2020 09:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <1587134624-184860-1-git-send-email-alex.shi@linux.alibaba.com> <20200417155317.GS26707@dhcp22.suse.cz>
In-Reply-To: <20200417155317.GS26707@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 17 Apr 2020 09:41:04 -0700
Message-ID: <CALvZod7Xa4Xs=7zC8OZ7GOfvfDBv+yNbGCzBxeoMgAeRGRtw0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] memcg: folding CONFIG_MEMCG_SWAP as default
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 17, 2020 at 9:03 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 17-04-20 22:43:43, Alex Shi wrote:
> > This patch fold MEMCG_SWAP feature into kernel as default function. That
> > required a short size memcg id for each of page. As Johannes mentioned
> >
> > "the overhead of tracking is tiny - 512k per G of swap (0.04%).'
> >
> > So all swapout page could be tracked for its memcg id.
>
> I am perfectly OK with dropping the CONFIG_MEMCG_SWAP. The code that is
> guarded by it is negligible and the resulting code is much easier to
> read so no objection on that front. I just do not really see any real
> reason to flip the default for cgroup v1. Why do we want/need that?
>

Yes, the changelog is lacking the motivation of this change. This is
proposed by Johannes and I was actually expecting the patch from him.
The motivation is to make the things simpler for per-memcg LRU locking
and workingset for anon memory (Johannes has described these really
well, lemme find the email). If we keep the differentiation between
cgroup v1 and v2, then there is actually no point of this cleanup as
per-memcg LRU locking and anon workingset still has to handle the
!do_swap_account case.

Shakeel
