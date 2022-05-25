Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A10534483
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 21:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344225AbiEYTsJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 15:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiEYTsJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 15:48:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B15DA44
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 12:48:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id rs12so31971322ejb.13
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmLANCeR2PBZsVZiqw/kJbDCZhiOaUsRlXizangKGuM=;
        b=W45I5obeEI7ajyNaRmK7F98XyvnL8ynngJufR193cH3zV4BNBFW72hd3mnApPZbBnt
         kaniX920OyLHOWeWWyqIfxJ7GWqgvbMCQfrbEypEXciUjKaar6UHJbFV360LJ1SNoEVQ
         cCGkVRoYGALQzapuYDw2sIu/qrzwgxaG0bO1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmLANCeR2PBZsVZiqw/kJbDCZhiOaUsRlXizangKGuM=;
        b=1Fuz3SDNfom4qehAVqFMuiCgXb2iZMkmFcox/ZgZ1PDEP7jQBPb9GoA9m5fEj+6MeD
         fUPIq3QwI9Yxi1/uHbWF5WmDMBOnnO05iMmwcavJqYD2OEVa9O2owrs21i1efSDn01nY
         Mg/7KnU/jYpWfmHVP3a9cQYpDBCkn/oYDex06oHuxZBjH2jFlFjWcAliSc0vqGWQeXw0
         OWF9e2hzHaTWV77L/KZ7fkrrmRsNdei9vYCwDCSfBGT/TcJcx1XW3vf+wqELiun/Qto4
         CojgSWvyhPzZlzJxZ44ZN6aS9uws1wgVEQHPz7qsLrXzP8nTHLoCGni7cZb8JGGKY529
         v1lw==
X-Gm-Message-State: AOAM5318f+BgVnbtM/co2+c7puolC2EQPPyb7RjmMSHt6VBvzjyq/Hfu
        fg0gTvSx5duDcATbE3n5Gh+3uzMmFOZpubf9Vs0=
X-Google-Smtp-Source: ABdhPJxQsmox4eWJ7ibdGUN/fivsQI7VJLQ6tzOy79yTOzxjU/cD7piWvnbnwJVU3o5Z/1W+O5ld6Q==
X-Received: by 2002:a17:906:1cd5:b0:6ff:5e8:3abb with SMTP id i21-20020a1709061cd500b006ff05e83abbmr8858987ejh.329.1653508085904;
        Wed, 25 May 2022 12:48:05 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id n21-20020aa7c455000000b0042ac2705444sm10949556edr.58.2022.05.25.12.48.04
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 12:48:05 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso1732457wma.0
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 12:48:04 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0e:b0:397:6b94:7469 with SMTP id
 l14-20020a05600c4f0e00b003976b947469mr4471173wmq.145.1653508084639; Wed, 25
 May 2022 12:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <Yowcc/ZOBIIs2JtZ@slm.duckdns.org> <CAHk-=wiGsJgFTJ=yqYwWA2vcTWQy=2QQ6to6vd3ETutaE0cDxQ@mail.gmail.com>
 <Yo6HMpEodz36o4Dc@slm.duckdns.org>
In-Reply-To: <Yo6HMpEodz36o4Dc@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 12:47:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4Q2++KfQ4NhMtjmJF_1bjC-573U61o1acuHfqmsvCKA@mail.gmail.com>
Message-ID: <CAHk-=wj4Q2++KfQ4NhMtjmJF_1bjC-573U61o1acuHfqmsvCKA@mail.gmail.com>
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

On Wed, May 25, 2022 at 12:44 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hahaha, yeah, I lost my private key many years ago, so gotta get that sorted
> out first. Will do the signed pull from now on.

You have a pgp key for your kernel.org account, you can just use that. No?

(That way I'll also be able to just pick it up from the pgp key repo
that Konstantin maintains).

                Linus
