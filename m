Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B451C63442D
	for <lists+cgroups@lfdr.de>; Tue, 22 Nov 2022 20:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiKVS76 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Nov 2022 13:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiKVS75 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Nov 2022 13:59:57 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C400FD0F
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 10:59:56 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id l190so15363313vsc.10
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 10:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9DTsq3fTwNbT6i34craZmfTRExedmDHXASu4ap4JQWc=;
        b=euKH/+vJIk4jb5GYcwTIndpZtGrvZkOBeSQRk87xMjmZTH+RQ1pCNwnXJLB8r/oQO0
         x4NbvARykKT5UQRTYNFqc4c4y2HLtlQ0gwBrOUmgIYxYGKBvSsLiYFxxHey3fT3w/9Vj
         HOQ7Qj5hpRKUloDQyonDJ8F2dOblLZMmhxyUfbRFBcyPMZ2uFWy1Izg4UvFn7gsqx2n1
         ym1wloPvHbcVO13o21Vg+S93Kbo51YjBNfIYA2HBOkKEPJ/Z6SJ4/BP/QvHgGdHCxwvD
         QGOm47FEhjAWZAXMx2WhoKZKfiBjRMtZfj9QV6t+NhIB5xXw6qp1E8JC0TJGvherHUzh
         c4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DTsq3fTwNbT6i34craZmfTRExedmDHXASu4ap4JQWc=;
        b=LDUqkx90qbUr92cwgeLLRfE+fjzkgZQmhFlbTygkwulUPP3VOUp2ht7iMfYQ/rtR7y
         fm35AaK+eKW5yG5WZSpiG15FjOWS0aT4gyerLWXGs5Ml7zzh7zESo2bY092CicCCc39M
         ho30xkTMwki91CxhJdhwNgLnf/JOWjKlocghmC2a/8uaqpGxrIqDzbzGLHTcP+R6Vj+s
         iSR7Afl+YTuIaj3LtiHQlGznvsj2rfE684cOyVw98Au5MMAC5FQgV2lHXWdQ9VHL8jak
         Vd+sywsLyy6ptEsBV0PPVuCDEk5kYvd/Rdo5XX2FwygKPOSgf4n3E00bHnhjd1D6eWR7
         5u3A==
X-Gm-Message-State: ANoB5plpPgi50T8aZjC7nfspbuWJzd9wEBsvL9by9f5NqaMduzngvEVp
        ggiOnir7xbbU9Lh5ggMLR5IuLXYkYb9Atk7OBUk4OQ==
X-Google-Smtp-Source: AA0mqf7Uzxc/Jj31rG85oI1E9wRDLbPWhLS/I4nmAkG7IG1izVik37RCH407Iffcv4TAVFRK9egw/NuOlJWDujTFTMo=
X-Received: by 2002:a67:f8d4:0:b0:3aa:1a3a:6447 with SMTP id
 c20-20020a67f8d4000000b003aa1a3a6447mr4323889vsp.50.1669143595264; Tue, 22
 Nov 2022 10:59:55 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi0G7cyNFbndM-ELTDAR3x4Ngm0AehEp5aP0tfNkXUE+Uw@mail.gmail.com>
In-Reply-To: <CABWYdi0G7cyNFbndM-ELTDAR3x4Ngm0AehEp5aP0tfNkXUE+Uw@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 22 Nov 2022 11:59:18 -0700
Message-ID: <CAOUHufbQ_JjW=zXEi10+=LQOREOPHrK66Rqayr=sFUH_tQbW1w@mail.gmail.com>
Subject: Re: Low TCP throughput due to vmpressure with swap enabled
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, cgroups@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 21, 2022 at 5:53 PM Ivan Babrou <ivan@cloudflare.com> wrote:
>
> Hello,
>
> We have observed a negative TCP throughput behavior from the following commit:
>
> * 8e8ae645249b mm: memcontrol: hook up vmpressure to socket pressure
>
> It landed back in 2016 in v4.5, so it's not exactly a new issue.
>
> The crux of the issue is that in some cases with swap present the
> workload can be unfairly throttled in terms of TCP throughput.
>
> I am able to reproduce this issue in a VM locally on v6.1-rc6 with 8
> GiB of RAM with zram enabled.

Hi Ivan,

If it's not too much trouble, could you try again with the following?
  CONFIG_LRU_GEN=y
  CONFIG_LRU_GEN_ENABLED=y

I haven't tried it myself. But I'll fix whatever doesn't work for you,
since your team is on the top of my customer list :)

Thanks.
