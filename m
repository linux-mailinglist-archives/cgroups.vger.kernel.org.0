Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B060053446E
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 21:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345769AbiEYTne (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 15:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345740AbiEYTnc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 15:43:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA20066F8D
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 12:43:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h11so27169149eda.8
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2so5Mzc6/Anj+eAb5PeB2pn0wQd0Ui5hrmZSPShUJSk=;
        b=ClAeyv25erXN5fpKcHwk4B8YWpXUehQeunEBVPSwb07wr0kbkKr02a6OwiYbxyOabm
         tHJtW2HEqZbHj1o2OTY/PAcEDKegqBNws8JTasC+43LHXgY1lRrN3DzuoPvJ/sxSloCD
         J+MDtDglojRRImuuzXr14wwumcd5JskHn5378=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2so5Mzc6/Anj+eAb5PeB2pn0wQd0Ui5hrmZSPShUJSk=;
        b=7QDiaepKVFWtXApkc00EMrBW/YSrpKAhceFUm0EXNYlvbq3dFNdq+nbZCmDi10OoIq
         ppgYQsoaLOQ8QzYWD5y5jHVJ9tOTuZpJSVc2PG535qkNqLMFKgj2+REkEYrRjxxsNhOS
         Vv4XtOg2NLGCGGrJXWpIfkWnTdVr0gbnylmtZOfnjTqSjQ+n90bJb/O2U93pAEHOFQ5R
         c8LtbwYyJS48dRBnSWBt1X+x0LVjcxWf4XBCzfo4x09lJik6MyHdFUSDnbhRk/mUJivV
         jx+f2HJZynZ7ZUHL8wViURs55QYE26CHLs/d8MYYz2NORPvKyG0TYmP/RQa0ZKZyspnW
         ZSzg==
X-Gm-Message-State: AOAM531wiRvs/pPZWqzqc25BW+egvUpiPfE0ry2KgJt58xlcwIsh6qiv
        qLiOLWd1x8eC3szW5Nk6vKNGeTExdReji0NSkrQ=
X-Google-Smtp-Source: ABdhPJx0jEfnwHeMqW+OAwZTU6Tu6ijIh6+ESNO4EZVn4ziV7RPosNehk/ord0Cn9V9esAz925DUEg==
X-Received: by 2002:aa7:d0d3:0:b0:42b:b1b9:726e with SMTP id u19-20020aa7d0d3000000b0042bb1b9726emr7182031edo.268.1653507806015;
        Wed, 25 May 2022 12:43:26 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id yl16-20020a17090693f000b006f3ef214e3bsm8396826ejb.161.2022.05.25.12.43.25
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 12:43:25 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id e2so19884340wrc.1
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 12:43:25 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr17441487wrf.193.1653507805043; Wed, 25
 May 2022 12:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <Yowcc/ZOBIIs2JtZ@slm.duckdns.org>
In-Reply-To: <Yowcc/ZOBIIs2JtZ@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 12:43:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGsJgFTJ=yqYwWA2vcTWQy=2QQ6to6vd3ETutaE0cDxQ@mail.gmail.com>
Message-ID: <CAHk-=wiGsJgFTJ=yqYwWA2vcTWQy=2QQ6to6vd3ETutaE0cDxQ@mail.gmail.com>
Subject: Re: [GIT PULL] cgroup changes for v5.19-rc1
To:     Tejun Heo <tj@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 23, 2022 at 4:44 PM Tejun Heo <tj@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.19

Your two pulls sadly broke the perfect signed tag streak that we had
this merge window up until just now.

I'm very happy to see how people have started doing signed tags for
everything, but that only makes your pull requests stand out even
more.

So yeah, despite not requiring it for kernel.org pulls, I'd _really_
like to make using signed tags just be the standard behavior for all
the kernel pull requests.

Can we try to aim for that next time? Please?

               Linus
