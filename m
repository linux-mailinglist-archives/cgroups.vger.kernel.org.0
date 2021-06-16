Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035B73A8E13
	for <lists+cgroups@lfdr.de>; Wed, 16 Jun 2021 03:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhFPBMJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Jun 2021 21:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhFPBMJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Jun 2021 21:12:09 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DD6C06175F
        for <cgroups@vger.kernel.org>; Tue, 15 Jun 2021 18:10:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p7so1310255lfg.4
        for <cgroups@vger.kernel.org>; Tue, 15 Jun 2021 18:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WkZWfoezrzK3YqSvjNFpximYFS+zPFkT6j8u2nQEHxw=;
        b=dnZC354fu9ggFFPybBFkrAKpJ+prc+VjiMY0E47wXoZTl70lO0k7nYMjJU+ZV3XOnM
         cSojlxv0PEOIvvodP7EyyNVyBIDb6VpotqSOH8P7zgKeN99TPu2eM8jtTC5q9GkVMOOm
         b8n1LUck5mzKRNIURbRp1PAEmcfLJJ6Oofoato99TY3lGZHKhH5BKFQ7LpvdQaSiY3ks
         8XqJgWXCw95vBde+156oMa/0O8Vezdj3dFRqsmV65VcAY4q1g4/XaEXHKGuGGv4cDCk7
         k59WzkDTvJnW4oE/NZKDqIjt26ezzGMMFYRpxTy8HV6zFdzzlgpdJBhwNO3hKG5oBQ2q
         Zfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkZWfoezrzK3YqSvjNFpximYFS+zPFkT6j8u2nQEHxw=;
        b=MVnM5NJbu4vL3Cjy05hvHCKdZeDssV0RQgzjycLOaaAZwpd75vpAKo/dmDawac5HcX
         jr8/G0SGnEOvj5ibmgYqzhUH+BwP2sWVc/GAzu0BDSqfi6Opi+l2gS4M8QjNYF5J7cEo
         /d9D/8JYdcq/gl/QPEf6wyotJKJW0wePxFNneRQ7+mV7Xm3KRFlNvTXY/yVbmp3JLR3l
         QU+Wys6cVdcwkp9/vH3rnLD+oitEKqm/12EXiLE6lST2Hx4TKwwBiUETxf/d1JCdJFXB
         uaeQlFzHlH2LwgObTBuX0n5SMJvdjBJ5qClHUE2xrgu7/ucz17KP8UrsXIUdbOciL+PV
         rtgQ==
X-Gm-Message-State: AOAM531Ngb2srk2Fm86K+DwHpJ65p8gVMfr8+UmKLDUfJBrVxo1cWuTN
        mcuhr5Jzw9LUmTjZphsV+Cfapv/JrQ76b478xqCyuA==
X-Google-Smtp-Source: ABdhPJzf4qJT4TeIuhj5pb3/BNFUHv6br3mhdn2UFHbIAcsSFEWV1evx9ybM06Xaj2HksP1lPhVlQir+fHv+GF9WmyE=
X-Received: by 2002:a19:7015:: with SMTP id h21mr1630748lfc.299.1623805800760;
 Tue, 15 Jun 2021 18:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <ac070cd90c0d45b7a554366f235262fa5c566435.1622716926.git.legion@kernel.org>
 <20210615113222.edzkaqfvrris4nth@wittgenstein> <20210615124715.nzd5we5tl7xc2n2p@example.org>
In-Reply-To: <20210615124715.nzd5we5tl7xc2n2p@example.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 15 Jun 2021 18:09:49 -0700
Message-ID: <CALvZod7po_fK9JpcUNVrN6PyyP9k=hdcyRfZmHjSVE5r_8Laqw@mail.gmail.com>
Subject: Re: [PATCH v1] proc: Implement /proc/self/meminfo
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 15, 2021 at 5:47 AM Alexey Gladkov <legion@kernel.org> wrote:
>
[...]
>
> I made the second version of the patch [1], but then I had a conversation
> with Eric W. Biederman offlist. He convinced me that it is a bad idea to
> change all the values in meminfo to accommodate cgroups. But we agreed
> that MemAvailable in /proc/meminfo should respect cgroups limits. This
> field was created to hide implementation details when calculating
> available memory. You can see that it is quite widely used [2].
> So I want to try to move in that direction.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/legion/linux.git/log/?h=patchset/meminfo/v2.0
> [2] https://codesearch.debian.net/search?q=MemAvailable%3A
>

Please see following two links on the previous discussion on having
per-memcg MemAvailable stat.

[1] https://lore.kernel.org/linux-mm/alpine.DEB.2.22.394.2006281445210.855265@chino.kir.corp.google.com/
[2] https://lore.kernel.org/linux-mm/alpine.DEB.2.23.453.2007142018150.2667860@chino.kir.corp.google.com/

MemAvailable itself is an imprecise metric and involving memcg makes
this metric even more weird. The difference of semantics of swap
accounting of v1 and v2 is one source of this weirdness (I have not
checked your patch if it is handling this weirdness). The lazyfree and
deferred split pages are another source.

So, I am not sure if complicating an already imprecise metric will
make it more useful.
