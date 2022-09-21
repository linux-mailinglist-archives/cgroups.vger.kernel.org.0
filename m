Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1BD5C0034
	for <lists+cgroups@lfdr.de>; Wed, 21 Sep 2022 16:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiIUOpV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Sep 2022 10:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiIUOpL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Sep 2022 10:45:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7DD27B3B;
        Wed, 21 Sep 2022 07:45:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v3-20020a1cac03000000b003b4fd0fe6c0so709429wme.5;
        Wed, 21 Sep 2022 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Lf5LYGsOy9w2pimVzOjMT59tZyyzJccX8FyNGOapJA0=;
        b=nXuWLyoKm9JEsGeMZHprR8y8IhAFmuvphrPxBHz/Xe5VA82lKthn7sQH/IQ4pFuQCY
         A/sYFvdbT3PmD7QhE2+guMQK6nzbxlyV4Nt349nGlH7klhpKze03D7MPScpGXKMzlFcQ
         L3GQdwb9xY5hSUaq4OZmJPextDDtBJgLobgg7SjzqLr2FKQeW0vw6LqhWLDReX5Hbdt7
         mW+1BQEEY7S1m3L65FcmTW6Z5Vh4c3KpwyUL3nrjoo6HJJQ2cKPKmFoDj8FQU9Q9RBMA
         jrIGdiT7n3nGon9Cpp2kh55bz9VNZGEiu6S5eZRSZeSKo7DrBm5kiyPLhUSTxRCI9qhk
         fAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Lf5LYGsOy9w2pimVzOjMT59tZyyzJccX8FyNGOapJA0=;
        b=be1JxFYyljvupL54qr3sGoQ1qp93eMNLTgub5YDpVeGOTZidCIYtulqKGQChNJbNAk
         4wBUHBSIFtzfRahkYuCAQ/elZNq70soKqsAk4Jvv6wEBa/G7A3tgeaWhKFuWWZmB9SOs
         KH7uxbWy/MgZ/lYelgdW6YVWVekiDx8OmLwcMDec/uqQ1UT7DfXUhFLZqFoEghYyTZwy
         cgx/det/w4MMe26pQiwLmmyycfoiEFPgoX8goMRFMAFKwOL5t7Zdq6oEjQv4ZkIPZZGb
         GvimLEg/MrMhfSPi2CSHqoxx4MrLpwE427v4lfkkyjwCvHZidwykItuuB1I0Qx0f3Fqf
         k5Hg==
X-Gm-Message-State: ACrzQf1ClpTKfNuQFD5yC/9uq/L/bVU6xqlwse0m4hT2/UWKZIQ1ybQa
        PAcMf2lHnhhAB2sZQdNe55P8x9RztzzA9pwLLFE=
X-Google-Smtp-Source: AMsMyM5iSt3YfygvoC+/skSuLlXuMWPKAGc2uTXHdORRNI67208BUh5GUDxAgFtrXD5ZBx6R0GcfrbZCk9NFk/rrN78=
X-Received: by 2002:a05:600c:3caa:b0:3b4:eff4:ab69 with SMTP id
 bg42-20020a05600c3caa00b003b4eff4ab69mr5823915wmb.104.1663771507951; Wed, 21
 Sep 2022 07:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
 <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org> <20220918092849.GA10314@u164.east.ru>
In-Reply-To: <20220918092849.GA10314@u164.east.ru>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Wed, 21 Sep 2022 17:44:56 +0300
Message-ID: <CADxRZqyyHAtzaaPjcKi8AichGew2yi-_vQcKoLoxPanLvXZL0g@mail.gmail.com>
Subject: Re: [sparc64] fails to boot, (was: Re: [PATCH memcg v6] net: set
 proper memcg for net_init hooks allocations)
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, cgroups@vger.kernel.org,
        Sparc kernel list <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Sep 18, 2022 at 12:39 PM Anatoly Pugachev <matorola@gmail.com> wrote:
>
>
> I'm unable to boot my sparc64 VM anymore (5.19 still boots, 6.0-rc1 does not),
> bisected up to this patch,
>
> mator@ttip:~/linux-2.6$ git bisect bad
> 1d0403d20f6c281cb3d14c5f1db5317caeec48e9 is the first bad commit
> commit 1d0403d20f6c281cb3d14c5f1db5317caeec48e9

reverting this patch makes my sparc64 box boot successfully.

mator@ttip:~$ uname -a
Linux ttip 6.0.0-rc6-00010-gb7f0f527dc3c #377 SMP Wed Sep 21 17:34:50
MSK 2022 sparc64 GNU/Linux
