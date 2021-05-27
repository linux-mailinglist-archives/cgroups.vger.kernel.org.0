Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC52392E21
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 14:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhE0MkK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 08:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbhE0MkK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 May 2021 08:40:10 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2ACC061760
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 05:38:37 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 124so394635qkh.10
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 05:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwvbasvBOX0hzBGm5Zl9wzQzyyw7RNsFGaMnYzuAUBc=;
        b=U4DejL5EQrp4AVnlNyPMNfq3M6zCVPE3epzkWBDinKSXB8K1yi9zqxIRHw4ARtt0cy
         8BowHOAC+R4vGcbmbv4LzoFHvJvxReKO/TKnhHCNcfr6Z+OWRcr6oSbxaW/qsBGC3gDS
         zAqHLVvYQEHefC/I1q2sz81CdFH7xki6LnCUXrNg/cd9qdXsRsEZO1mOpeL0mjD419fd
         8+L7myRumMth515bFh17f2YmkrBphiQqErllSKgOEpx2Vz8t4deHVbTRlTvq/g5foknQ
         bBPEQFsL2VpuEHSpAVx7BPfZ0gFt91v8+7QtMwPJFHoLSE79vRy4DLvLYObbbOS4YTIf
         OiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwvbasvBOX0hzBGm5Zl9wzQzyyw7RNsFGaMnYzuAUBc=;
        b=omPGs5RoitCfKWh9fmuea9HQp7dJfdhg4PU9/AM5HtYsmVWPS6+qa8/mHJnwCMDyNT
         sbMMl0ZFZi1/Xnu1SjBUpW/zxEVJHi/0jyIdl8cU20TGa7lfG2cB7TT3fUh0KCbux1dg
         5gzz/UF8/QIJ0tO+ENWb9zWTpNBghdrqNt8alWofXg1ihKk/ZLeM6H3CCBD3xgPF6zcH
         7pqPWkMFyF/b4cMh5a8RhfcpCTbd7j3jZr2CphDIXA6+ntQIcdTe6duJVDsdviX6RSfl
         jPO+2eIXPyJsJUvUgy75eQQqHUaFv+PvMxz7KfMxg7zs07jFw0Itj0+75ouffFuy1Zhs
         SiMw==
X-Gm-Message-State: AOAM531Qr8rNQnXxdb8haRM7w3AiPB5qUxfiaMJIngQBCn0VJUD8/oJu
        IWs46m77sn9lDaolzwcpvKejkqF/d0T1VI83AUzELw==
X-Google-Smtp-Source: ABdhPJzxot1fMgytftsD2mbMkecwS+naTojpGHrJMb28VI+moQKg8jpov8X0D99Gt2yncegr3RT15V73daV5zi2E5ZM=
X-Received: by 2002:a05:620a:56a:: with SMTP id p10mr3212767qkp.238.1622119116303;
 Thu, 27 May 2021 05:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-2-odin@uged.al>
 <CAKfTPtCCZhjOCZR6DMSxb9qffG2KceWONP_MzoY6TpYBmWp+hg@mail.gmail.com>
 <CAFpoUr0f50hKUtWvpTy221xT+pUocY7LXCMCo3cPJupjgMtotg@mail.gmail.com>
 <CAKfTPtCaZOSEzRXVN9fTR2vTxGiANEARo6iDNMFiQV5=qAA4Tw@mail.gmail.com>
 <CAKfTPtAFn3=anfTCxKTDXF0wpttpEiAhksLvcEPdSiYZTj38_A@mail.gmail.com>
 <CAFpoUr1zGNf9vTbWjwsfY9E8YBjyE5xJ0SwzLebPiS7b=xz_Zw@mail.gmail.com>
 <CAKfTPtDRdFQqphysOL+0g=befwtJky0zixyme_V5eDz71hC5pQ@mail.gmail.com>
 <CAFpoUr0SOqyGifT5Lpf=t+A+REWdWezR-AY2fM_u1-CCs8KFYQ@mail.gmail.com> <CAKfTPtArj_XkgPXRJKZxN0MM2+v=3+RjAVVkmbpB1gBLCuzJvA@mail.gmail.com>
In-Reply-To: <CAKfTPtArj_XkgPXRJKZxN0MM2+v=3+RjAVVkmbpB1gBLCuzJvA@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Thu, 27 May 2021 14:37:57 +0200
Message-ID: <CAFpoUr2NM9RHE=jdbi5aNj2LeVr4iKJ3thMPUNhp_SnCe7tnfg@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Add tg_load_contrib cfs_rq decay checking
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi again,

Saw your patchset now, and that is essentially the same as I did. I
guess you want to keep that patchset instead of me updating this
series then?

Also, could you take a look at patch 2 and 3 in this series? Should I
resend those in a new series, or?

Odin
