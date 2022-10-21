Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9AA607C27
	for <lists+cgroups@lfdr.de>; Fri, 21 Oct 2022 18:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiJUQ0K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Oct 2022 12:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJUQ0K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Oct 2022 12:26:10 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910422690A3
        for <cgroups@vger.kernel.org>; Fri, 21 Oct 2022 09:26:04 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 63so3949302ybq.4
        for <cgroups@vger.kernel.org>; Fri, 21 Oct 2022 09:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sNPu8q/nEQ+Rmy7Su/VoleNiyJ0OnMotxKUK2gAU0uY=;
        b=C2vuIkV6NxalUVMmtDZIgEbOvdeVqSTHJ0CDZh5xIi5nemi4/4AGB8vtIe3vcfwk0v
         I/0iqJSeHSBkLwA9NbVxgEUEDoKNas8Z5qG8Ppw/t+HmWJAgmeQxPs9m38GX+WqH6N6K
         yhF3ahpKFBV+kqJ1PmU7xTOGIJD1fZ9O/xNiWNaLDuO/2R4aPx2fRDUKsb/NvyDLk8kG
         /sfsU6w01Yd0JP+yPp9nDlz4JBeKKBWm9vFd3z66ZGwiqw5vgQAoYp5rDN0bwO8O7HXQ
         5vka+zbV3IFXAK/reZ4c4Q1IZ/CsAwU408y7C9SycoR0nqeCvixEfv5+E6S5FnQsLjHE
         YDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNPu8q/nEQ+Rmy7Su/VoleNiyJ0OnMotxKUK2gAU0uY=;
        b=2rkFFjjTxaFoEH1iPUXkSZtJwGTjYlvcMzqDbGU108ITx62I9Ej1HLLTiNJ9hn2iek
         Ciiwg4XPWyQqTSKw5FqSJjB1qhCUcvTb4C1GKH3rEs7Rbt8l8zUJzTyQyzvsOaprobL4
         Pea4Dus48UkoVyVr2SakJfmc4FvfAfAxDsClF/SeaTE7u+e8zWe95R6erkFlRTKM2hxi
         JMaUwqUrwDuSjw1eZT888qiMIz7Lx/8d/lUYtl55LzAh9w3KUn/8qQwhMvKEgw4frSIl
         XSdLndZ8QIrQxX8GYn6rMFxAF6oTAtYGxS7wwofKcVd6m71fiAcNvCSnAaQkRz71GFSX
         KZHA==
X-Gm-Message-State: ACrzQf1w+hRNnRQ35r9JD5JDAa6av5JMX0JNXujwJ/iTPlMfS4WrD1rQ
        LAsIq6o6iyb5gdYp1bivzd9iByp7KYFlRh2ZBBM/IQ==
X-Google-Smtp-Source: AMsMyM51Wwi8FOc1Ubi7lsll0AnIeI6w/e11geLcPMNryQ1brrnLpKcVUsSSRF+oZJanThzMZuz2vx5IF5QAn+aBh/k=
X-Received: by 2002:a25:664b:0:b0:6ca:6c0c:9cb0 with SMTP id
 z11-20020a25664b000000b006ca6c0c9cb0mr3207178ybm.368.1666369563680; Fri, 21
 Oct 2022 09:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221021160304.1362511-1-kuba@kernel.org>
In-Reply-To: <20221021160304.1362511-1-kuba@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 21 Oct 2022 09:25:52 -0700
Message-ID: <CALvZod4eezAXpehT4jMiQry4JQ5igJs7Nwi1Q+YhVpDcQ8BMRA@mail.gmail.com>
Subject: Re: [PATCH net] net-memcg: avoid stalls when under memory pressure
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     edumazet@google.com, netdev@vger.kernel.org, davem@davemloft.net,
        pabeni@redhat.com, cgroups@vger.kernel.org,
        roman.gushchin@linux.dev, weiwan@google.com, ncardwell@google.com,
        ycheng@google.com
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

On Fri, Oct 21, 2022 at 9:03 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> As Shakeel explains the commit under Fixes had the unintended
> side-effect of no longer pre-loading the cached memory allowance.
> Even tho we previously dropped the first packet received when
> over memory limit - the consecutive ones would get thru by using
> the cache. The charging was happening in batches of 128kB, so
> we'd let in 128kB (truesize) worth of packets per one drop.
>
> After the change we no longer force charge, there will be no
> cache filling side effects. This causes significant drops and
> connection stalls for workloads which use a lot of page cache,
> since we can't reclaim page cache under GFP_NOWAIT.
>
> Some of the latency can be recovered by improving SACK reneg
> handling but nowhere near enough to get back to the pre-5.15
> performance (the application I'm experimenting with still
> sees 5-10x worst latency).
>
> Apply the suggested workaround of using GFP_ATOMIC. We will now
> be more permissive than previously as we'll drop _no_ packets
> in softirq when under pressure. But I can't think of any good
> and simple way to address that within networking.
>
> Link: https://lore.kernel.org/all/20221012163300.795e7b86@kernel.org/
> Suggested-by: Shakeel Butt <shakeelb@google.com>
> Fixes: 4b1327be9fe5 ("net-memcg: pass in gfp_t mask to mem_cgroup_charge_skmem()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: weiwan@google.com
> CC: shakeelb@google.com
> CC: ncardwell@google.com
> CC: ycheng@google.com
> ---
>  include/net/sock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 9e464f6409a7..22f8bab583dd 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2585,7 +2585,7 @@ static inline gfp_t gfp_any(void)
>
>  static inline gfp_t gfp_memcg_charge(void)
>  {
> -       return in_softirq() ? GFP_NOWAIT : GFP_KERNEL;
> +       return in_softirq() ? GFP_ATOMIC : GFP_KERNEL;
>  }
>

How about just using gfp_any() and we can remove gfp_memcg_charge()?
