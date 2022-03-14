Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0034B4D7A6C
	for <lists+cgroups@lfdr.de>; Mon, 14 Mar 2022 06:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiCNFgy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Mar 2022 01:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiCNFgx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Mar 2022 01:36:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D210224BE3;
        Sun, 13 Mar 2022 22:35:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so16335568pjb.4;
        Sun, 13 Mar 2022 22:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C2/3lb1hdkF97hNbei7dfXomt9xkrDDtfYf9ru8Gdm4=;
        b=oNVR0qUtUkejwD2PE40U3m3bOfecNXxVeKkVp9fOm+3Me77M45+NPeo55ubqZlKq7r
         MB7tiA63/q1i44rKG6d5ltclJzQv3Qz6hhh3RVq9xq7IO4ncnICocd4C9j5XVYHLTf1H
         0t37CbsvKjlG0aLe8uQgii2HaQrObeg3Am1odGPvV1Uc+c31V9C/Ju30rReVHe8B7ESC
         epUdibdIm8U4Wa6yuG/J9mGpJ520zSl63IpEll5h0ZCNatE7cUD1FFvlYx5LP4BamLZT
         MjTkoUVR2DYc65MSqHiATmVgOUcADjVgzLehE3W1M6UCy8UGQSH8LXrnv7gEq+fTE4Gr
         17Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=C2/3lb1hdkF97hNbei7dfXomt9xkrDDtfYf9ru8Gdm4=;
        b=10k7a/U6S8tMvKNESyEt9tPkD1U0DwqlBy344/5TidHAVPVBN4nusEbZ7qRgcj5s+x
         ofvp22B/Q/5LauGxygPGBoC2YNzpTlKnjjwOUtutSTMjBxxkP7zIiZGaQqwWECi+Q+2V
         w9pAqjO3mTIxDFyrt/iTzVDb08tnKCtG0nrXVZEFCxhNUKIPJP0ao4iiLZB/ucIeVtih
         OlI6aFSOnDVnkN3+2GcOuBZ1Lzd3AiHpbTmVtFcD16yXEdSiHvzQHUl//Sgzd8l3ZEtx
         uO81svBZ5ata3OPARgFO1u/7gx2eJcAYhdrfDadd9ICkhDkYUXAxB+IYW1x6RLcL2+b4
         WhKw==
X-Gm-Message-State: AOAM531vudLLSBxINPPcTeTQQjKLyytt/iFMkDFbXJO9Y/Vws/1kIpAM
        kBzrn+GzdYOPc+kjtcx3M+Hs/sEXr4yU0w==
X-Google-Smtp-Source: ABdhPJxQfuJzNpaxaFptAzT4ZYgj4ZR/5PodW1CaO6QpMn1QABgOB9VGxTKEOuE8CeSaQvplRfChPw==
X-Received: by 2002:a17:903:244e:b0:151:e3e2:cc09 with SMTP id l14-20020a170903244e00b00151e3e2cc09mr21625163pls.70.1647236144220;
        Sun, 13 Mar 2022 22:35:44 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id j67-20020a636e46000000b003740d689ca9sm14830191pgc.62.2022.03.13.22.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 22:35:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 13 Mar 2022 19:35:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>, bpf@vger.kernel.org,
        KP Singh <kpsingh@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC bpf-next] Hierarchical Cgroup Stats Collection Using BPF
Message-ID: <Yi7ULpR70HatVP/8@slm.duckdns.org>
References: <CAJD7tkbQNpeX8MGw9dXa5gi6am=VNXwgwUoTd6+K=foixEm1fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbQNpeX8MGw9dXa5gi6am=VNXwgwUoTd6+K=foixEm1fw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Mar 09, 2022 at 12:27:15PM -0800, Yosry Ahmed wrote:
...
> These problems are already addressed by the rstat aggregation
> mechanism in the kernel, which is primarily used for memcg stats. We

Not that it matters all that much but I don't think the above statement is
true given that sched stats are an integrated part of the rstat
implementation and io was converted before memcg.

> - For every cgroup, we will either use flags to distinguish BPF stats
> updates from normal stats updates, or flush both anyway (memcg stats
> are periodically flushed anyway).

I'd just keep them together. Usually most activities tend to happen
together, so it's cheaper to aggregate all of them in one go in most cases.

> - Provide flags to enable/disable using per-cpu arrays (for stats that
> are not updated frequently), and enable/disable hierarchical
> aggregation (for non-hierarchical stats, they can still make benefit
> of the automatic entries creation & deletion).
> - Provide different hierarchical aggregation operations : SUM, MAX, MIN, etc.
> - Instead of an array as the map value, use a struct, and let the user
> provide an aggregator function in the form of a BPF program.

I'm more partial to the last option. It does make the usage a bit more
compilcated but hopefully it shouldn't be too bad with good examples.

I don't have strong opinions on the bpf side of things but it'd be great to
be able to use rstat from bpf.

Thanks.

-- 
tejun
