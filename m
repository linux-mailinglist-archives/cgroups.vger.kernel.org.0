Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A476465E2
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 01:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLHAbl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Dec 2022 19:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLHAbk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Dec 2022 19:31:40 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC57218B
        for <cgroups@vger.kernel.org>; Wed,  7 Dec 2022 16:31:39 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id z1-20020a17090a66c100b002196a0895a6so2174642pjl.5
        for <cgroups@vger.kernel.org>; Wed, 07 Dec 2022 16:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=phKzW+pnWcxpZMlO+OGC3q3KyWa3Ai371n7pkUjY42s=;
        b=GcvzBKZHxUPcMbsMIVs11wJmblKLng4iReNp1M5ibs/jGlVOlzs8gse33hKi0r80d3
         4py+w8LI+3nJYWK8ZHaSqhXB2Uiak2y9NhC7j3lJ6R1R69as73jNKJKxJH9LiwjI8e1d
         MetDnMkMhXBRBjs9blHiXf9td0dJKWvI6zm9E3odBEh/Q0aEDhi9QSdUDkbSJu0sBLf7
         GmD67NVPCz8BOXn9qmTnJmvuIfl7OIhCFLqkKxmDFJOjrSau5U5GhJqzKYp7SqdjHIFp
         NH630+6SYXOZNb0eEnqgRPAuNnT0GH0bcEZ+5l/9XRUIU/cBltRovIN/r4VTIfO5+EP9
         y2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phKzW+pnWcxpZMlO+OGC3q3KyWa3Ai371n7pkUjY42s=;
        b=aH5A36DLwynOpoQELHX7cp176wF53sZ3SRhoISdR4gJYHm8/kjfbk2r1VTJqFigJnE
         zf+N8AevyHgQskCwixaTLLrUwOC8uyn44gf0sT+jf9c7KqmjHaUI36O4//JMiFGgzslc
         8sXmTv1pCZXWjW8G+uzHKg7zNcM596/EwWAfMIgpP+kTeo9OLOOrq5OWJzR68B1+9WG2
         QR4/LpwOJ1CWdkRfC3Jf0rBNQxdwApv8kz3f3IiwMPmbUwDLv87sZGUlVIQy6LdiVX28
         EpO1miC5fy9pjQ5fOUV+Dqcb3BYKMscbcoN/IV0dmSpbNyvTevtRdiv5R58+E68opJp+
         SjRQ==
X-Gm-Message-State: ANoB5plwmb3ypzzD9V4lHuyOXmjw4s3NCm+rsQQ7w+rwys8NZT8df8gn
        gh3GOY3vY0Oygx/fCUCS4wdX93SvNSq9Bw==
X-Google-Smtp-Source: AA0mqf4slF5wuVDt7vcUdSy33m/cV+nfkgqPs0VJCJbPcJEf4NAvlhc1TSDJ3tuFkNkT3zZfDe6ynMVlPbiVGA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:902:9a8a:b0:189:58a9:14a4 with SMTP
 id w10-20020a1709029a8a00b0018958a914a4mr65845663plp.18.1670459498810; Wed,
 07 Dec 2022 16:31:38 -0800 (PST)
Date:   Thu, 8 Dec 2022 00:31:36 +0000
In-Reply-To: <Y5CMrPMDxngMZWN8@cmpxchg.org>
Mime-Version: 1.0
References: <CABWYdi3PqipLxnqeepXeZ471pfeBg06-PV0Uw04fU-LHnx_A4g@mail.gmail.com>
 <CABWYdi0qhWs56WK=k+KoQBAMh+Tb6Rr0nY4kJN+E5YqfGhKTmQ@mail.gmail.com>
 <Y4T43Tc54vlKjTN0@cmpxchg.org> <CABWYdi0z6-46PrNWumSXWki6Xf4G_EP1Nvc-2t00nEi0PiOU3Q@mail.gmail.com>
 <CABWYdi25hricmGUqaK1K0EB-pAm04vGTg=eiqRF99RJ7hM7Gyg@mail.gmail.com>
 <Y4+RPry2tfbWFdSA@cmpxchg.org> <CANn89iJfx4QdVBqJ23oFJoz5DJKou=ZwVBNNXFNDJRNAqNvzwQ@mail.gmail.com>
 <Y4+rNYF9WZyJyBQp@cmpxchg.org> <20221206231049.g35ltbxbk54izrie@google.com> <Y5CMrPMDxngMZWN8@cmpxchg.org>
Message-ID: <20221208003136.fxm6msgiswl2xdac@google.com>
Subject: Re: Low TCP throughput due to vmpressure with swap enabled
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, cgroups@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 07, 2022 at 01:53:00PM +0100, Johannes Weiner wrote:
[...]
> 
> I don't mind doing that if necessary, but looking at the code I don't
> see why it would be.
> 
> The socket code sets protocol memory pressure on allocations that run
> into limits, and clears pressure on allocations that succeed and
> frees. Why shouldn't we do the same thing for memcg?
> 

I think you are right. Let's go with whatever you have for now as this
will reduce vmpressure dependency.

However I think there are still open issues that needs to be addressed
in the future:

1. Unlike TCP memory accounting, memcg has to account/charge user
memory, kernel memory and tcp/netmem. So, it might make more sense to
enter the pressure state in try_charge_memcg() function. This means
charging of user memory or kernel memory can also put the memcg under
socket pressure.

2. On RX path, the memcg charge can succeed due to GFP_ATOMIC flag.
Should we reset the pressure state in that case?

3. On uncharge path, unlike network stack, should we unconditionally
reset the socket pressure state?

Shakeel
