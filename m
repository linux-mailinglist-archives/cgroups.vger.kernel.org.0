Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A4629F11B
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 17:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgJ2QS6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 12:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgJ2QS6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 12:18:58 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35EAC0613CF
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 09:18:57 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id l2so4097107lfk.0
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9EtR8ay+CFHP0VWhr60l9Agx6oBhnBUNvO58Pm5n2c=;
        b=ZypFrwHFGFdiH3//0NKW6vQX1p5u1pLj9CchSpsY8VglCbaO2vGBx2uveHOn+HSxzq
         O9Uwvtp1dzgD56WgMNXb2hhjjdjiSi/B1wQtiI6Ap/p4ZUtD3xctBS+5x3BZ2cOEhSSg
         +nX9mb4w+MOOeGPQM6MbQXVpUd2uhKi+z1z7Xtf6A07T8HHVYZ8i3zH4begi4U/VBCuX
         Yn2KWTFJa0FSTi3LiRcT1LGfcNUBE8/Mza2QMwPBACfFLoCzE6DaLbauBuPCkbTQgTWr
         QDTXah3K6U8HNIb/ifAcYX6mB4g+Nsw837iHGB7rnB488OMnyCTszLAZZ84zKoyFiCZ6
         VzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9EtR8ay+CFHP0VWhr60l9Agx6oBhnBUNvO58Pm5n2c=;
        b=Nj2LlR4ZiZFXNn1Rpi6kwL18ZjI6m8jzOjplniYJUwZTWbm0i6zMSh3GBHdkuH8Dg3
         cKFHINPuJMH+L5slBoVa0fdsPWa1xyxS+FfQcObLQ7l00mnoyltFTEuYVTMfwksaZvrE
         0/XKVeYtIaCJ4Ma3XSwqkdTOh0YMWL5DjRIHbx3t4rB3wxycB/bVCNKBeyXcJVelgymD
         rVkL4i+9zj3gY0GL1N9NSuHxarCXqD4T8SygJqj4izJAkgqtDLravMWn/BN/MyAHT6wy
         zOLFuguZxS8Lo90pYTVSeBvydiF+mcAhCj/cJhJreLihO0+zn/M/1OLU36iXJ4mIX1cR
         AzQA==
X-Gm-Message-State: AOAM530Jheh9oj4mEEdIrakevVqW9XE+Nu5xIoFMZOVTiNey5Jy6Z52u
        HdD3DG78l8fJwLE4UrAvxQAzUVReiMfXQKAR8XFoTA==
X-Google-Smtp-Source: ABdhPJwDUMPMP12s120vl/5u2CihW7CO4f8+IgmIiwZd79+cJvWwOZSSCzYSedlU15A8/2stmps0+QqOjNwIgwF0euA=
X-Received: by 2002:a19:7719:: with SMTP id s25mr1785670lfc.521.1603988336095;
 Thu, 29 Oct 2020 09:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201028035013.99711-1-songmuchun@bytedance.com>
 <CALvZod6p_y2fTEK5fzAL=JfPsguqYbttgWC4_GPc=rF1PsN6TQ@mail.gmail.com> <CAMZfGtW38sFcdpnx3Xx+RgRL37WzpQsq8qvfdnmhbh4H9Ex0cg@mail.gmail.com>
In-Reply-To: <CAMZfGtW38sFcdpnx3Xx+RgRL37WzpQsq8qvfdnmhbh4H9Ex0cg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 29 Oct 2020 09:18:45 -0700
Message-ID: <CALvZod68HooK_bnaxFLEBL_neVybVRECkHJyb6r8LHWqwTOe5Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm: memcg/slab: Fix return child memcg
 objcg for root memcg
To:     Muchun Song <songmuchun@bytedance.com>
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

On Thu, Oct 29, 2020 at 9:09 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Thu, Oct 29, 2020 at 11:48 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Tue, Oct 27, 2020 at 8:50 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > Consider the following memcg hierarchy.
> > >
> > >                     root
> > >                    /    \
> > >                   A      B
> > >
> > > If we get the objcg of memcg A failed,
> >
> > Please fix the above statement.
>
> Sorry, could you be more specific, I don't quite understand.

Fix the grammar. Something like "If we failed to get the reference on
objcg of memcg A..."
