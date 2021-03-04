Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B533132D86A
	for <lists+cgroups@lfdr.de>; Thu,  4 Mar 2021 18:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbhCDRN4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Mar 2021 12:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239110AbhCDRNu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Mar 2021 12:13:50 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1CAC06175F
        for <cgroups@vger.kernel.org>; Thu,  4 Mar 2021 09:13:10 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id t9so5111372ljt.8
        for <cgroups@vger.kernel.org>; Thu, 04 Mar 2021 09:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFk60/R93j/Ir+3OsIDPm87BVki6b+umgOzaexWfu9Y=;
        b=ipdNXv2W0+m0TzGiGZv/k4LwVFCEWWmyFxoH/AYPwJo5e7snO6Lo6WhFIf4StYPudv
         GF9t8QFsvY8w/m8QsKaAe0JtnyI0ZJu5wRBt06IVJepz0mdCB+sbU1pTGeIhTSV3Uo3t
         vhbPl5N0Dsl+fvA8jy4KGdhnFFRyfHlAlW2C1NycxnBBiNxtGh0trXgrjheABWbzzsof
         3fXEIY1DSd9tR61ancM308v6eKm7y1ZzOTwT5dxGaUcNRgiJ+JsA96KnOafSct7wzL/n
         C5xuzppV407zHw2hxKpg8PpdWFTC+RdKXnxOam+nmXN1eVa6X7ttbeaX6q8YdcGBMNos
         aotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFk60/R93j/Ir+3OsIDPm87BVki6b+umgOzaexWfu9Y=;
        b=LWoIhEBB5j5M2Vgr7kUvVUcjQckCRNtzeXrwUbzY1Chl72grQHJMWD+1gbvpfK02sF
         dSiOiA1qs/pW5/JBUv0tdNt3BDsjUWlPf1opdY7Mi//lFmHHN32aI1MvQN1Ux/ZRCuBH
         driHOgFKFIKWvwrvwP34DkKg+Wej/tWVz2quLmspd5UYb5u04DZLRPdLWAZlUqYl25Ux
         j2WtNxG4dd9L6L+BgeVSVfTfQluD/8lCVRLNCHWerSH/0ycDR9B83eaJmvyNKdpirUDu
         xARNVufhw45eTjygA62Pc3PO7lrOfrZ/T2YXLIHZfCu12zBGiAStJeqG88eqL0VmrowK
         AeGQ==
X-Gm-Message-State: AOAM533CTXFQ7CHLbce6+oRkdl4M/nh8g3jvjJnpoWRRR2Zoeyaj3TRh
        E8Ml37awp1ldxC7+tq+F1C4h+pY553mf0v7+t18i7Q==
X-Google-Smtp-Source: ABdhPJwd/9rGKR+1GgvpMgGk8rXue/ZLv08tWsIm+I/pEInOeNK57UG4fTTeUXVNpCEnlOZUqQgjLqVDgQntILSRdBk=
X-Received: by 2002:a2e:9cc4:: with SMTP id g4mr2891774ljj.34.1614877988461;
 Thu, 04 Mar 2021 09:13:08 -0800 (PST)
MIME-Version: 1.0
References: <20210304014229.521351-1-shakeelb@google.com> <YEEBTm/NIugjQWG5@cmpxchg.org>
In-Reply-To: <YEEBTm/NIugjQWG5@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 4 Mar 2021 09:12:57 -0800
Message-ID: <CALvZod5TjuOjLN6FWvMvwFHC2BaGg=3+yuaCdnp-DfabUioQVg@mail.gmail.com>
Subject: Re: [PATCH v3] memcg: charge before adding to swapcache on swapin
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 4, 2021 at 7:48 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Mar 03, 2021 at 05:42:29PM -0800, Shakeel Butt wrote:
> > Currently the kernel adds the page, allocated for swapin, to the
> > swapcache before charging the page. This is fine but now we want a
> > per-memcg swapcache stat which is essential for folks who wants to
> > transparently migrate from cgroup v1's memsw to cgroup v2's memory and
> > swap counters. In addition charging a page before exposing it to other
> > parts of the kernel is a step in the right direction.
> >
> > To correctly maintain the per-memcg swapcache stat, this patch has
> > adopted to charge the page before adding it to swapcache. One
> > challenge in this option is the failure case of add_to_swap_cache() on
> > which we need to undo the mem_cgroup_charge(). Specifically undoing
> > mem_cgroup_uncharge_swap() is not simple.
> >
> > To resolve the issue, this patch introduces transaction like interface
> > to charge a page for swapin. The function mem_cgroup_charge_swapin_page()
> > initiates the charging of the page and mem_cgroup_finish_swapin_page()
> > completes the charging process. So, the kernel starts the charging
> > process of the page for swapin with mem_cgroup_charge_swapin_page(),
> > adds the page to the swapcache and on success completes the charging
> > process with mem_cgroup_finish_swapin_page().
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> The patch looks good to me, I have just a minor documentation nit
> below. But with that addressed, please add:
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks.

>
[...]
>
> It's possible somebody later needs to change things around in the
> swapin path and it's not immediately obvious when exactly these two
> functions need to be called in the swapin sequence.
>
> Maybe add here and above that charge_swapin_page needs to be called
> before we try adding the page to the swapcache, and finish_swapin_page
> needs to be called when swapcache insertion has been successful?

I will update the comments and send v4 after a day or so to see if
someone else has any comments.
