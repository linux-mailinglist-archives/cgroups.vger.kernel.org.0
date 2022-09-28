Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBEB5EE1C2
	for <lists+cgroups@lfdr.de>; Wed, 28 Sep 2022 18:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiI1QXW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Sep 2022 12:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiI1QWw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Sep 2022 12:22:52 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C38AE3693
        for <cgroups@vger.kernel.org>; Wed, 28 Sep 2022 09:22:48 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-12c8312131fso17957856fac.4
        for <cgroups@vger.kernel.org>; Wed, 28 Sep 2022 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=RNYkwlzjSBs38E+/5XUZn4xEpIcCbwJSOmIImzP0KC4=;
        b=dog9Z6dDOTNjNFT3nVOx9AVPuy15Elp3ZH1zdCjCde6M2ULSae/opQ9DTfOXDMmbAa
         P+6LBTDdLGVRv5jOg/iz4bxV7IlENeLPwn7ylPWsm51mAwmjnoIsREm8CaqozryOClR0
         KNJ4Xcyi+JNTc4nXU8Coc6tODlMLmMSrhyKFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RNYkwlzjSBs38E+/5XUZn4xEpIcCbwJSOmIImzP0KC4=;
        b=UG3/MvHHyQUQ6cNaNMepO1NuTk/NAxtV821MCDcd3o63U3AjPQNiuZQs6PZqopolG1
         Wqt0wFXjeSsza79rlVnE/CzfLAJmGS+7vNcYsLmHwbu+EoUEKKJWOLZO0C5z+pdm9X4U
         Be3lDgpqH46hKvCDfesTYteT/+QX9kfvdiEE4o35a0ybZjPYD1VIlyvgJvQKXAm9eRTd
         S8JrLKzggmJTUbwEkCs/HUUagsufbXwLFBtmnGRvexrY6cTVNIefrYd7gOTxb56s0VqO
         0xkmh8XvTXu/kDNCXYz4yoiBjUNUI6wdInrd3hfRM6FiBJxY8KbG0guGIov2yLFDJ3Lb
         YxnA==
X-Gm-Message-State: ACrzQf2/uiqwKm2TUkiawgRCzebkuK3BCnoX5mN04BGVpB8AgRjCHAMo
        OmprtSMWu2ndkab6zbYsAY2T/3n9Kb7LXQ==
X-Google-Smtp-Source: AMsMyM5QxNhcgDfA8xLETt1TMStfgYUvU5I0dgmwOqO4jztbgpPyySTx0Lr13++W7frOXfNYz4vHVQ==
X-Received: by 2002:a05:6870:5810:b0:127:a331:1e76 with SMTP id r16-20020a056870581000b00127a3311e76mr6029764oap.292.1664382166427;
        Wed, 28 Sep 2022 09:22:46 -0700 (PDT)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com. [209.85.160.43])
        by smtp.gmail.com with ESMTPSA id w69-20020aca3048000000b0034fbbce2932sm2017608oiw.42.2022.09.28.09.22.42
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 09:22:43 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-13175b79807so7854050fac.9
        for <cgroups@vger.kernel.org>; Wed, 28 Sep 2022 09:22:42 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr5762894oad.126.1664382162560; Wed, 28
 Sep 2022 09:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220926195931.2497968-1-shakeelb@google.com>
In-Reply-To: <20220926195931.2497968-1-shakeelb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Sep 2022 09:22:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2DnK9RAJXJnrSa7WQdKhTXiHNoawCUcxGjk8TdCtJcw@mail.gmail.com>
Message-ID: <CAHk-=wj2DnK9RAJXJnrSa7WQdKhTXiHNoawCUcxGjk8TdCtJcw@mail.gmail.com>
Subject: Re: [PATCH] Revert "net: set proper memcg for net_init hooks allocations"
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anatoly Pugachev <matorola@gmail.com>,
        Vasily Averin <vvs@openvz.org>,
        Jakub Kicinski <kuba@kernel.org>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 26, 2022 at 1:00 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> This reverts commit 1d0403d20f6c281cb3d14c5f1db5317caeec48e9.
>
> Anatoly Pugachev reported that the commit 1d0403d20f6c ("net: set proper
> memcg for net_init hooks allocations") is somehow causing the sparc64
> VMs failed to boot and the VMs boot fine with that patch reverted. So,
> revert the patch for now and later we can debug the issue.

Just FYI for the involved people - I've noq applied this directly to my tree.

                 Linus
