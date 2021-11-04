Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6F3445C05
	for <lists+cgroups@lfdr.de>; Thu,  4 Nov 2021 23:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhKDWML (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Nov 2021 18:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhKDWMK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Nov 2021 18:12:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141A7C061203
        for <cgroups@vger.kernel.org>; Thu,  4 Nov 2021 15:09:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y26so14789273lfa.11
        for <cgroups@vger.kernel.org>; Thu, 04 Nov 2021 15:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ODhjY+JjkYpUpFv09zJB9aBghMhLyhOS/H4FgA78QU8=;
        b=JHVS8Ow1HVeUipVMLT11yHlvnxUVD2nceGQ5AKOw+p77/NeUjmgxc/oFiHSOxrbrpy
         Is/GwTZWZuoxrsC80rpbv/2Y8AaAq/cFI3MhtzhNbqZ2SeltjziPfSnhXJUAjXXzuneh
         06pZbRk62NEQyFwifnDmYhpdXaj5WIbqygNh018AToErjr1rpOAMHzMlLBgBnFYYWmsM
         n3epCtFUKoO951mcxkIQfDT2Ez/LVEgPNqs68kV3L8jvbEOgor4J5JFG089J8+xV4Vwu
         lLYjqTpUdsD5O3nUSnHNlw2U5elxiK5a1njy2kFnY+pVVBcnd9VbIH0GJWibXuXHxCHT
         qOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ODhjY+JjkYpUpFv09zJB9aBghMhLyhOS/H4FgA78QU8=;
        b=bpGsmWNQb9JgpvVXIM7nK0IqCO3JG820Pi5bc08E2ETZeGtwkrOfUzW4qCIRA65Km9
         x6X/6BWFZDdoejZG32r8YdFuCakLb4Unec9sI9I3BlK5VUwKIHcC/YcZp9agwCpeL0QL
         tEg2diSj7u8cJJC2WWVozOxigXbHT4OlZuM0IcaegX4SXrPvUtI4DZwC6m3noQb38AG5
         Ff/XUnnxDFxDBAZh9unt9FwGG1eL4h/tgegZ7A3DPG+/YH+lGBSr0qZyg/sIZGh/Rbhm
         M9hCqskLLKLfQvMxCo0TEWQ7wYH3DMLKLP3MiyXBNsxg3Xg0irUzOqb+/YpQYq/0L74l
         wLVw==
X-Gm-Message-State: AOAM533qYl03qeC+qrXXdXjt2iZN2+6wvwJnbqi+FBp3iUDPrzCOupo9
        h0knSDHi7QhrFm4BreadRMV+mPOY6WMguoHSQgfqNg==
X-Google-Smtp-Source: ABdhPJyCySNfwv75WoGWFSPYJQ9LqbdrCPdqJpHKt8D7zE+l3mpEMxyt3SFexC6VWMES75d4HEuprj4x5ybvSm5jjD4=
X-Received: by 2002:a19:740f:: with SMTP id v15mr29475880lfe.184.1636063770123;
 Thu, 04 Nov 2021 15:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211013180130.GB22036@blackbody.suse.cz> <20211014163146.2177266-1-shakeelb@google.com>
 <20211104142751.5ab290d5cf4be1749c9c87ed@linux-foundation.org>
In-Reply-To: <20211104142751.5ab290d5cf4be1749c9c87ed@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 4 Nov 2021 15:09:18 -0700
Message-ID: <CALvZod5xT2Mi2wktD-OTS0xkChNzArnMCLBNy7cg0dVupSOhXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] memcg: flush stats only if updated
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mkoutny@suse.com, cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 4, 2021 at 2:27 PM Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>
> On Thu, 14 Oct 2021 09:31:46 -0700 Shakeel Butt <shakeelb@google.com> wro=
te:
>
> > Hi Michal,
> >
> > On Wed, Oct 13, 2021 at 11:01 AM Michal Koutn=C3=BD <mkoutny@suse.com> =
wrote:
> > >
> > > On Fri, Oct 01, 2021 at 12:00:39PM -0700, Shakeel Butt <shakeelb@goog=
le.com> wrote:
> > > > In this patch we kept the stats update codepath very minimal and le=
t the
> > > > stats reader side to flush the stats only when the updates are over=
 a
> > > > specific threshold.  For now the threshold is (nr_cpus * CHARGE_BAT=
CH).
> > >
> > > BTW, a noob question -- are the updates always single page sized?
> > >
> > > This is motivated by apples vs oranges comparison since the
> > >         nr_cpus * MEMCG_CHARGE_BATCH
> > > suggests what could the expected error be in pages (bytes). But it's =
mostly
> > > wrong since: a) uncertain single-page updates, b) various counter
> > > updates summed together. I wonder whether the formula can serve to
> > > provide at least some (upper) estimate.
> > >
> >
> > Thanks for your review. This forces me to think more on this because ea=
ch
> > update does not necessarily be a single page sized update e.g. adding a=
 hugepage
> > to an LRU.
> >
> > Though I think the error is time bounded by 2 seconds but in those 2 se=
conds
> > mathematically the error can be large.
>
> Sounds significant?

Yes it can be.

>
> > What do you think of the following
> > change? It will bound the error better within the 2 seconds window.
>
> This didn't seem to go anywhere.  I'll send "memcg: flush stats only if
> updated" Linuswards, but please remember to resurrect this idea soonish
> (this month?) if you think such a change is desirable.
>

Yes, I will follow up on this soon.
