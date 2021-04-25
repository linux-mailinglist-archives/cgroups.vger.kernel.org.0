Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4A36A607
	for <lists+cgroups@lfdr.de>; Sun, 25 Apr 2021 11:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhDYJXV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 25 Apr 2021 05:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhDYJXV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 25 Apr 2021 05:23:21 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF253C061574
        for <cgroups@vger.kernel.org>; Sun, 25 Apr 2021 02:22:41 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f12so39554136qtf.2
        for <cgroups@vger.kernel.org>; Sun, 25 Apr 2021 02:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ugedal.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHqJw4XM6KNvFgd+6eDTbM0uYiK/qMr9nT+Gi0khnDA=;
        b=SAOjTqPoCFTcLZj5stQfJeMd/KGGLv5NxQXsZbWoxuvzKg6ZsmT9fWWd8MGgtBcvPu
         C746UW5yMeE1fk++7oSPbZBrLMjXIlZiBJn7Yogfhd0++JsS8iBnbvw4owZ+EKCr0dtd
         JzbX4TuLaaFDQ3R/KT3yyP9FtwgNgIQv7hGQde2hyYyHEhzZy++K+SpA4qerlNOhfFVB
         OmVkWixn8WHVbbUkDaGoJdRGGhas98j/koleU/Bg/7Sj7dtWFxGLOzlGAjP8gfZuP6h0
         RAkSiUEOSMZmSIwG8Hi5UeUxKFc6UgPv07ysBz2EMZ0XxdEtW4Ls2MKAEF72JeBswMjF
         DCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHqJw4XM6KNvFgd+6eDTbM0uYiK/qMr9nT+Gi0khnDA=;
        b=qSTdwFFnww0Qaw/MzsP7asnTT34j8Yr1QxaJ4oHvcQmlfiReuA2ixFJfYIKDC84CQB
         CafC/eAqJG7uzIKHpPKJW7U1/K3P5gmDGxTUGBibYaLRuGxv/8vxmU6QLx1R+yx57d0Y
         YEAt1bt5dNSV+3cidRMPHW8Z3S4ZD7DjwZDbIsQOoDdLuHiV1sF8miOQBb5kBUkfvNNM
         Wn99OOFl5kGyMgJzGc2UpO/DIV81vF3DkrrTkkoqXcaOzXhpLUOVO30kjSTwwcPR5BoE
         +QoMdIqgIMA4CkiSBuG97swUriFGeCm3KpCxNJbnKFbvYI14JJRtwrWon1t0Q7zlIliU
         fVMg==
X-Gm-Message-State: AOAM531vsi4wQ5fHRmCDeEW6ammtgk4AHxYfmSIi7iyRJPcn7OarD6jP
        joGzBp91y77t6VWO6crOwaVnv0vRTjAMLJUmsx1AUw==
X-Google-Smtp-Source: ABdhPJz+CpGWp3z6KtFJnKnrWirHyoSvnFfQhQ0xnhfu43WTI+sxJJZP9GsIKoGP8IrQfjVQl++aHKWThvkRQtw+KTo=
X-Received: by 2002:ac8:5a52:: with SMTP id o18mr12065400qta.138.1619342561124;
 Sun, 25 Apr 2021 02:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210416141146.542786-1-odin@uged.al> <YHn3cifQv1FUOqfU@slm.duckdns.org>
 <YH2Y9FucBW2GLLLQ@cmpxchg.org>
In-Reply-To: <YH2Y9FucBW2GLLLQ@cmpxchg.org>
From:   Odin Ugedal <odin@ugedal.com>
Date:   Sun, 25 Apr 2021 11:22:09 +0200
Message-ID: <CAFpoUr2+8aftSG0bok5--p+LaeoAPZ-kNGpk29LHsXp-T+AHBw@mail.gmail.com>
Subject: Re: [RFC] docs/admin-guide/cgroup-v2: Add hugetlb rsvd files
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Odin Ugedal <odin@uged.al>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> My preference would be to first try to write a version of the doc in
> cgroup2's briefer style, and then, depending on how that works out,
> see whether we can delete (replace with link) the cgroup1 text, or
> keep it for archiving purposes.

Thanks! That sounds like the best way to do it! Will take a look, and
post an updated patch.

Odin
