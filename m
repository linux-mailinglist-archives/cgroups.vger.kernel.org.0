Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED4C29F194
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 17:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgJ2QeB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 12:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgJ2QdG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 12:33:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FAFC0613D2
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 09:33:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e15so2786423pfh.6
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNp60uz7U6o1WyBX9AAMogQVRcPxcfAiqCLR+bSZ8wY=;
        b=f6D+/uNPO6HW47eS+XdsuzOWR1OMKIbf1tDWGNa/eHlbdNS1fFyq73++vFXANcz6x2
         ytHLCE17oAxpQhTZeiOQrmqhH4JsQDnMKEzIq5jZmBroArNr7f6GsZp52FWH2KkhY3sM
         H8KsLn2uIX0lXXKFtXSbrA4roiZkm9N/rx+aLZ7Z/aAg0vhgc/QNYZtvX+naxEa054tr
         J0G6xItBIlWQ5zhq1bPzfF1wq31Xu/yYiQL3OtYyEzqwyevlKs28VqyQLH4Vw4YcJ7ti
         8EQJyl5qnkFrglTZQ6jMXOEWKksSQAolyC8ztjX4eIQqPqjYVEB+NEeUU6DztL2Vnx9B
         0Pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNp60uz7U6o1WyBX9AAMogQVRcPxcfAiqCLR+bSZ8wY=;
        b=kufIY4glXT28PzqLqx4pzhajZ+wXgvc1NgDlfobvR7kjROlB6Cn5AH0v2O1YtYr3Yu
         UXkNdYH556NuFSE3+gfzcYR3uSZbwj37YWjOCDSdxZwk1Hhb7wCZbKu3eAcVnIkSIGh3
         hGV0Pyu0HbT0Z48QKmZ5GX4OvNx/INT9slb3PmMpYBnEC/kXB6d+QlT/EahP1zassK6T
         UVqeOGYjd7yUqnkbtAUeZSyjNkKhyGTGGnOODJ3G87qNXHbAqPNJ2s5pSjmBFum9Ty/7
         M0gVmj1wMmYGjGqSPPtYtMuNrtWVPLtYQxddBHfWACo2JWKFotbExcG3him8lPQwQRaw
         sIPA==
X-Gm-Message-State: AOAM530lR/tJeER7N/lRXl1sLYNTz1FpRsPYcxLpOYbhKtbHuMQapQ+I
        pzY4BU4XVBuXyoMBLZBoqr9ZdCaFxD+vVGJTIcCa9g==
X-Google-Smtp-Source: ABdhPJy1+WefzaCmcrBy2LFwrFD2Wq5MJeAwQJ74F2m6AHO5xCmR0PebTW6H1Op74Lq4+jARizRrOxwrObc2Oo0XhDY=
X-Received: by 2002:a17:90b:198d:: with SMTP id mv13mr599421pjb.13.1603989183738;
 Thu, 29 Oct 2020 09:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201028035013.99711-1-songmuchun@bytedance.com>
 <CALvZod6p_y2fTEK5fzAL=JfPsguqYbttgWC4_GPc=rF1PsN6TQ@mail.gmail.com>
 <CAMZfGtW38sFcdpnx3Xx+RgRL37WzpQsq8qvfdnmhbh4H9Ex0cg@mail.gmail.com> <CALvZod68HooK_bnaxFLEBL_neVybVRECkHJyb6r8LHWqwTOe5Q@mail.gmail.com>
In-Reply-To: <CALvZod68HooK_bnaxFLEBL_neVybVRECkHJyb6r8LHWqwTOe5Q@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 30 Oct 2020 00:32:26 +0800
Message-ID: <CAMZfGtUCXAzvjQ60VUEdOj1OocqUxGNZkikr-Lch2w-dkmQTwg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm: memcg/slab: Fix return child memcg
 objcg for root memcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>, areber@redhat.com,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 30, 2020 at 12:18 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Oct 29, 2020 at 9:09 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Thu, Oct 29, 2020 at 11:48 PM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Tue, Oct 27, 2020 at 8:50 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > > Consider the following memcg hierarchy.
> > > >
> > > >                     root
> > > >                    /    \
> > > >                   A      B
> > > >
> > > > If we get the objcg of memcg A failed,
> > >
> > > Please fix the above statement.
> >
> > Sorry, could you be more specific, I don't quite understand.
>
> Fix the grammar. Something like "If we failed to get the reference on
> objcg of memcg A..."

Got it. Sorry for my poor English, Thanks.

-- 
Yours,
Muchun
