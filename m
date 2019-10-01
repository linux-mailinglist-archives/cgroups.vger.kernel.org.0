Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC65CC3AA2
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2019 18:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfJAQgh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Oct 2019 12:36:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38541 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfJAQgh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Oct 2019 12:36:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so8389323pfe.5
        for <cgroups@vger.kernel.org>; Tue, 01 Oct 2019 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHMFw+xpbq6Flta24J2hzTDxt/C/G/wkt9n5+ff6Syg=;
        b=R3PPoTfkYjm55Usvkap+EtoXUf5HVNBlhI8mau+Mc5cS3RRZ3i3i4xcKmMlhslCnRk
         wKr/l+Q5TujIFf7DvN0yU8XV25ZAntQ5u07Ioac5iArFq2covqObD/FHRplQDhtCKzaz
         I369JfzpF9rzCwNJokHteHQFva3hWd+aSj941pR+DBaK676oi3sZCTTOrOFW2HDm2D3T
         iWIg1YBr/Ero51hEPo9rNXn1VhlMIfpVB5WVaHWXD0eAAwTkseCUOaoGpjnEckwIQIwE
         XE9q4CoZnGeeF8k5aEwyfwP6nS9x5VSJTFl6U+9Vagz+qqtlvojsx2qKaa0jZCiD35pG
         o77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHMFw+xpbq6Flta24J2hzTDxt/C/G/wkt9n5+ff6Syg=;
        b=S3/DBr33PKrlLOXR8LUvTE80/q0isHWEG9CmELJ54Peqr2pQsr9jr0VKGbHVtpyy0M
         3Jt6pzni9nBr8KTn0HdViTUQMZsvZvp+NsZ/FeOiQW6ASh3VWeC0A+YHoL3hbGguna6e
         Coz3yL0qKcdga6quDShSPqRaXy6u8zjhAskiISdw+V0bGv2220Sg4pqSYwPRAbvA3rJ4
         ShZS6Ekqfz6Nj+O+SklIbd+6CbLtxFYg8EgbpY4p3oSFldI9p1ex9mxfB/SWCCstq7Gt
         omjQ+//4SZ6qaIlCP/mdcNe8lX2u/Q7JdiRMfJw4pjDd8lH1DqZAEg9NrlXncVPFZPd0
         jNyg==
X-Gm-Message-State: APjAAAX/NEb1TPPZA6DKoF5h2YhbbkqCc7I/oZe9FXuvuTX+LjFJCc3t
        fl7Zegd4M3rgRLP6xoSL7y02TUm0KCqcsZPbhPndgQ==
X-Google-Smtp-Source: APXvYqyko40OZ04X6xSuPAOAtRZAh3FOBHZRVF+R8vBkvFaLnxVIbcyNokxXCTUmztr0eLX5WJZn0HuNWs7rxTynnCQ=
X-Received: by 2002:a63:7153:: with SMTP id b19mr30478989pgn.10.1569947795665;
 Tue, 01 Oct 2019 09:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191001142227.1227176-1-arnd@arndb.de>
In-Reply-To: <20191001142227.1227176-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Oct 2019 09:36:24 -0700
Message-ID: <CAKwvOdn7J6bvF=58UkeXA8LVAMt-g76EDFT+j5EWc0LdsyX_CQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol.c: fix another unused function warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 1, 2019 at 7:22 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Removing the mem_cgroup_id_get() stub function introduced a new warning
> of the same kind when CONFIG_MMU is disabled:
>
> mm/memcontrol.c:4929:13: error: unused function 'mem_cgroup_id_get_many' [-Werror,-Wunused-function]
>
> Address this using a __maybe_unused annotation.
>
> Note: alternatively, this could be moved into an #ifdef block.  Marking it

Hi Arnd,
Thank you for the patch!  I would prefer to move the definition to the
correct set of #ifdef guards rather than __maybe_unused.  Maybe move
the definition of mem_cgroup_id_get_many() to just before
__mem_cgroup_clear_mc()?  I find __maybe_unused to be a code smell.

> 'static inline' would not work here as that would still produce the
> warning on clang, which only ignores unused inline functions declared
> in header files instead of .c files.
>
> Fixes: 4d0e3230a56a ("mm/memcontrol.c: fix a -Wunused-function warning")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/memcontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c313c49074ca..5f9f90e3cef8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4921,7 +4921,8 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
>         }
>  }
>
> -static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
> +static void __maybe_unused
> +mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
>  {
>         refcount_add(n, &memcg->id.ref);
>  }
> --

-- 
Thanks,
~Nick Desaulniers
