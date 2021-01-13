Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD87B2F40C0
	for <lists+cgroups@lfdr.de>; Wed, 13 Jan 2021 01:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392146AbhAMAnF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Jan 2021 19:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392307AbhAMATi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Jan 2021 19:19:38 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E177EC061575
        for <cgroups@vger.kernel.org>; Tue, 12 Jan 2021 16:18:57 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id x23so558052lji.7
        for <cgroups@vger.kernel.org>; Tue, 12 Jan 2021 16:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xDSBLu/dQ/DU7FQZj8b6YPh8lI8akCH+mH01uvaPees=;
        b=oKYBO4SPdgSBJUsDMIW5CP9v8Ehx9/bCarB8oGP/mHA4+sLd3xf01hYN8meRfn3Z/C
         VRExJAQITYqEfrJHkfEK/+BUy2bi9V125dcXdPXwnGIrz1gChJ8Eagc6sfu5NxDOsM7Q
         s4JHrGiTwBj0egpN48LNdJhwOkgrQljcrnDdfzV8s4tuYkxOP5J3ifDaVQItl+uBWKRi
         hjaQ04uwbDzWLPPYGOzdK8OrUuidnmRBgEslg8HxcWMOGc+R2HncERyeNHOejDUAcGLp
         U6ugLoGlBW/HnCUEp1wdREM2Q0knqc9CwXOGdVRuSBw5YniV+N1wwskoAEZ2xBEOuVvD
         3xUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xDSBLu/dQ/DU7FQZj8b6YPh8lI8akCH+mH01uvaPees=;
        b=Ax+dPiS4gnSTVgn+SsqtBwtVdd9MKpUBvyPZI58T9Dtm+tCmoO1tVzXYNXzRTcdIgi
         uxb0mCgG07d+904ui9N2j7nrOm/wFfZRLSPcI4N/P64jv0n9qaPRpCRKNTTrs/v5JlTe
         yaTU8mCCzFowzyAv4t13+7pEvJNvbUVKoX07ThznhS7eO4u0jWl22rUY4XIEcGGqHCn5
         yyZ+8j2ma9gPdjUDV3BtmdRUP0DgvgrOM9JRZE/sAPYMRjWuOCob1u2AoveLtQ8IXtOw
         vEMTWoGAt2ag+vPTJnhTue5xCszaoj7kWRyuzaWdWwZngnfV1YHMykzYTB2AZHSEbWTb
         tisQ==
X-Gm-Message-State: AOAM531K+fYFy4kbOKQA1azTt/mcpehndZL61NNbL34Ab1u2CJeE5JDg
        fmynHxWrw0z57D/uBRc+DVWpEvTpqtwH4cbroWoYHw==
X-Google-Smtp-Source: ABdhPJzLMkGXD6keBgkD1QE7S34ntTTrgx2rICPfCSovNaFVK6UFbwtZ7AQr2ENR3QwGr5QWxwVbsZua9hjphAbv6aQ=
X-Received: by 2002:a2e:9a84:: with SMTP id p4mr715148lji.160.1610497136091;
 Tue, 12 Jan 2021 16:18:56 -0800 (PST)
MIME-Version: 1.0
References: <20210112214105.1440932-1-shakeelb@google.com> <20210112233108.GD99586@carbon.dhcp.thefacebook.com>
 <CAOFY-A3=mCvfvMYBJvDL1LfjgYgc3kzebRNgeg0F+e=E1hMPXA@mail.gmail.com>
 <20210112234822.GA134064@carbon.dhcp.thefacebook.com> <CAOFY-A2YbE3_GGq-QpVOHTmd=35Lt-rxi8gpXBcNVKvUzrzSNg@mail.gmail.com>
In-Reply-To: <CAOFY-A2YbE3_GGq-QpVOHTmd=35Lt-rxi8gpXBcNVKvUzrzSNg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 12 Jan 2021 16:18:44 -0800
Message-ID: <CALvZod4am_dNcj2+YZmraCj0+BYHB9PnQqKcrhiOnV8gzd+S3w@mail.gmail.com>
Subject: Re: [PATCH] mm: net: memcg accounting for TCP rx zerocopy
To:     Arjun Roy <arjunroy@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 12, 2021 at 4:12 PM Arjun Roy <arjunroy@google.com> wrote:
>
> On Tue, Jan 12, 2021 at 3:48 PM Roman Gushchin <guro@fb.com> wrote:
> >
[snip]
> > Historically we have a corresponding vmstat counter to each charged page.
> > It helps with finding accounting/stastistics issues: we can check that
> > memory.current ~= anon + file + sock + slab + percpu + stack.
> > It would be nice to preserve such ability.
> >
>
> Perhaps one option would be to have it count as a file page, or have a
> new category.
>

Oh these are actually already accounted for in NR_FILE_MAPPED.
