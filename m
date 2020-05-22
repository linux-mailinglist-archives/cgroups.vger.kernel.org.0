Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0221DED3C
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2020 18:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgEVQ2C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 May 2020 12:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730031AbgEVQ2B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 May 2020 12:28:01 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE15C061A0E;
        Fri, 22 May 2020 09:28:01 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j2so11258681ilr.5;
        Fri, 22 May 2020 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TysnkmOIkLeX9KxlHLPL4xK1JYCC9XQVpNTteD8sJWI=;
        b=lfm2XyuLMBYBEMicKkNUBvKtTqemJXPbmFBeN/eDLNIxq1Id68/49Ne+gIoDwSCuxt
         PeZotFigJ3ZPSD9p6jTGhATFunfQ9qsPYh76th8MHBQeNDElh3K4ig7cWIiYTF1beD9I
         ZhK/eAXZzgrN6Zfj6BDIp8VMQbVyI5viIJjrVpBW/BnSbFVqqUN0n3+xKKdukU2d4JTt
         ocbVEWftg/opspRtHbRTG3DtRVxzVSXWHlF/bgAKDT0g/A+frfgtgjGZZy2+xfX+Hu+f
         3xn7ErM5jt3GoVN0OtIsP+1x1V9o3ktTP2HTuxHEsbtjlbdMByZrDzBW/vFnZKr6Qwz8
         CEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TysnkmOIkLeX9KxlHLPL4xK1JYCC9XQVpNTteD8sJWI=;
        b=RNcWtUyzQu0dAIV3mrUoCPA0+jEL+CzEvqkXcEgaQdgvzFMnXy38/hYPyn6SL1ugT4
         8lmPf/bNpchpCJ3E4F0pdhIpylR6iifBWmXCBDf0KMr/jNerjIM29IbzN3w3tMb5SV0b
         1S6CuevfmpPwmA1ITWXFSYR4TiQKwIBy4Zk9kmP7UbiKdoERUfpqePY16q+x02rKHGOD
         K+rc/cum0CCTL+CfPtgax255iydtZTZZTwiPhy8H2bedaPWAWIqwjn4j8W1gSb78pA/0
         tA/OB0xQ7KSH5/KpIj01fgIgdLxXx3jqHdSsA3xSHzrRZlOEmQoCUVEaZ5AHHzIWttPT
         basw==
X-Gm-Message-State: AOAM530fGigfXKBXFpasQBoZwda9SC3gGpItA7CvVm3EYAix3Io+4qHi
        VvQ3DcLa7ZqRHFVL73P9BOPdDFR1cqYEf13cLX8=
X-Google-Smtp-Source: ABdhPJygTKEZ0/3slz2Qencuk56A3Fa5sc0tQiWlaV/GUulZeY6LWuJ4x6zRNvb/rdBY6V2nkBUTiyiv1Exd1hFGk1E=
X-Received: by 2002:a92:10a:: with SMTP id 10mr14145774ilb.203.1590164880781;
 Fri, 22 May 2020 09:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200505084127.12923-1-laoar.shao@gmail.com> <20200505084127.12923-3-laoar.shao@gmail.com>
 <CA+G9fYseWc_7yq0M5Onju_HxbFid6DbuuaEFf-KUpqfxdF-QTg@mail.gmail.com>
 <CALOAHbBTt1pMo0kwheWqPfU7RTXcDHWJ-x8=5mpw327uiy2qzA@mail.gmail.com>
 <CA+G9fYtmpjunUetTmf2yquB1rwZA+nnWOiueWbAMx483c0wUvQ@mail.gmail.com>
 <CALOAHbCdXrU1AeLd4pWubutuG6HP4xKvxRkXeOv=sd_MMW58rg@mail.gmail.com>
 <20200522160626.GB1112005@chrisdown.name> <20200522160709.GC1112005@chrisdown.name>
In-Reply-To: <20200522160709.GC1112005@chrisdown.name>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 23 May 2020 00:27:24 +0800
Message-ID: <CALOAHbArZ3NsuR3mCnx_kbSF8ktpjhUF2kaaTa7Mb7ocJajsQg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm, memcg: Decouple e{low,min} state mutations
 from protection checks
To:     Chris Down <chris@chrisdown.name>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, linux-mm <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, May 23, 2020 at 12:07 AM Chris Down <chris@chrisdown.name> wrote:
>
> Chris Down writes:
> >Yafang Shao writes:
> >>I will do it.
> >>If no one has objection to my proposal, I will send it tomorrow.
> >
> >If the fixup patch works, just send that. Otherwise, sure.
>
> Oh, I see the other reply from Naresh now saying it didn't help.
>
> Sure, feel free to do that for now then while we work out what the real problem
> is.

Regarding the root cause, my guess is it makes a similar mistake that
I tried to fix in the previous patch that the direct reclaimer read a
stale protection value.  But I don't think it is worth to add another
fix. The best way is to revert this commit.

-- 
Thanks
Yafang
