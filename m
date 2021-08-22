Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6463F3EE4
	for <lists+cgroups@lfdr.de>; Sun, 22 Aug 2021 11:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhHVJrE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 22 Aug 2021 05:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhHVJrE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 22 Aug 2021 05:47:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5343DC061575;
        Sun, 22 Aug 2021 02:46:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id me10so1789047ejb.11;
        Sun, 22 Aug 2021 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0e3vNQgHPFxuVsKWr/oiMNC9HxWPWcJlOWQMgnCyZR0=;
        b=fc7l3zQQBiTvLtZ8kw7ugWuyAEkBM9yOfrxUda3mcyP2YOK/iuevz3ldkBdbTGAFLR
         NjU2QWLhmeb4es1ZtlCij3Ejl4pkK4OIqFC1XRUgurK338ndY3KSx9Ql/OZeNNPQ0LRs
         srT8tXDwVj5+QHv0uUcPx9Vn7se2owBwg+f4hXjPxOx9gKWu8t7LY/ycUcicpxdPei5r
         VKO9/Qm5WAZshb3BK5bPL2m6uAtiVFURCJ5iD97XSPCW2mc1sai0KIr3XVgvPUzeBCFB
         Gblig3buVPTC0GFSM7kZXGvulIrou6p8bsvPfTNH9k/SwYk/E6YhPasCoj9jpPr6utP+
         T09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0e3vNQgHPFxuVsKWr/oiMNC9HxWPWcJlOWQMgnCyZR0=;
        b=Lwq1cBWK3A9ne2VfTtbbxHT2L/bTtG7k+CLNHH+9+Re1gp75b3YOuAmhvK/JuzBOai
         b+u3CYcaItxUPlK8cCoz+WlFPbgWgEdMV/XEFQQV3IS4Z0jw2syALoixO5BHNVrkPeV+
         aW+Y8LAy0laOWNoPqyhGzE0QTVS9U1l21mwYzxkMVERW/lIxVOlXo6M+eW7Vw0B/NaVc
         sYUYuwEBm+iEFzVv1TOU0Ln+Nf3mMrAMiWVBOo7x5tuI+IkN1iJIGhi1XAO/HcmqMydm
         pzjJLDBGx7FbhTsqyq+RkazdZGFONpV8gaDnHiLLudiDanDT7OGigK6u+agE6WKhSrSB
         Lrdg==
X-Gm-Message-State: AOAM532HelauJyv3sG32qQz2hqNlY0XGJ0K0kHpSRPq7u4cu+k7usPaZ
        0J5GfsDhYiMkJ2O7en8oOlkA4g4TYl74jqQnhto=
X-Google-Smtp-Source: ABdhPJxVfiwhlP4JKkL/U2DXMsUbZPLWOJO1lrKtf4l/kc1VMF0+3F69CLJDWAl1TEhXs1BicZrGGWQtMPGdL+zUMr8=
X-Received: by 2002:a17:906:a18b:: with SMTP id s11mr30974716ejy.8.1629625581682;
 Sun, 22 Aug 2021 02:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <1629417219-74853-1-git-send-email-wang.yong12@zte.com.cn>
 <YR+Rc9HC6OqlEq4I@dhcp22.suse.cz> <CAOH5QeCfwF0hX3XpoThEtwnddtOFEU9Jtp0Hoj+Q37D4Q6HC0Q@mail.gmail.com>
 <YR/NRJEhPKRQ1r22@dhcp22.suse.cz>
In-Reply-To: <YR/NRJEhPKRQ1r22@dhcp22.suse.cz>
From:   yong w <yongw.pur@gmail.com>
Date:   Sun, 22 Aug 2021 17:46:08 +0800
Message-ID: <CAOH5QeDUUqrMnuws6cnBDU_oub4cK6KsHeX39p7Eikr4Bcjcnw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add configuration to control whether vmpressure
 notifier is enabled
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, alexs@kernel.org,
        Wei Yang <richard.weiyang@gmail.com>, Hui Su <sh_def@163.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        wang.yong12@zte.com.cn, Cgroups <cgroups@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> All those reasons should be a part of the changelog.
>....
> I am not sure these are sufficient justifications but that is something
> to discuss. And hence it should be a part of the changelog.
>
OK, These reasons will be added to the patch notesin later versions.

> > 3. In the case where the user does not need vmpressure,  vmpressure
> > calculation is additional overhead.
>
> You should quantify that and argue why that overhead cannot be further
> reduced without config/boot time knobs.
>
The test results of the previously used PFT tool may not be obvious.
Is there a better way to quantify it?

> > In some special scenes with tight memory, vmpressure will be executed
> > frequently.we use "likely" and "inline"
> > to improve the performance of the kernel, why not reduce some
> > unnecessary calculations?
>
> I am all for improving the code. Is it possible to do it by other means?
> E.g. reduce a potential overhead when there no events registered?
Yes, the method you mentioned may be feasible, but it does not conflict
with this patch.

Thanks.
