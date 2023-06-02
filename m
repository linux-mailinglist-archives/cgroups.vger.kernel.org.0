Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03EE720A79
	for <lists+cgroups@lfdr.de>; Fri,  2 Jun 2023 22:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjFBUmE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jun 2023 16:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjFBUmD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Jun 2023 16:42:03 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9C5E42
        for <cgroups@vger.kernel.org>; Fri,  2 Jun 2023 13:42:02 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b05714b3bfso11773895ad.0
        for <cgroups@vger.kernel.org>; Fri, 02 Jun 2023 13:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685738521; x=1688330521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A3JKXYSTKUDDfkWw2z2gFFNkpbBKNRDNZFCjBvxP6b8=;
        b=4ap8xeEQ+RrljIBH8n4l6V33lwJ2Ruabow/MOb1HhRfUfARoCeT4iYuXw+5l0SCo1w
         BsWI8/x9bXZBOvdJo1nG7sA5se5dE+HdTPScOynYnBPtujmO+2mbGH4y5vJQKw9v4rOw
         gnCthwhPd2SORL80DDL7SINMo9fZkjj3SDmP7dBoTn46ljI83h1VbWJv1ptjzK9lEU7z
         RVshQ+BK50eYyTbWnyILBZv6qnaHQde490IuSaMFd+guECLHZM6vbGCTl5FKCAnymjwt
         izJA+opMgbMAg1shFiX9Oa0hTgWiLoDPb09pts6sfLXPjsl4VWV7Z79pkFnOGtx0Vak5
         7wJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685738521; x=1688330521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3JKXYSTKUDDfkWw2z2gFFNkpbBKNRDNZFCjBvxP6b8=;
        b=Laz2C5Wssc+sHVefB/Xfjs3ryc0pmCzLs9F3I5O8oe+TW7qE+pjaZQMM0HvC60zqy0
         41cEiioUsZemmDOgfv82V4gLFlWs8Pfx8DJncLKxROfjcoy6HB3obQJrudUR6kWw3Eth
         pXE1VYjJCP6ljGmqZh2FKBu/vh2vrG0Mnvf20euNsCREw6sGIPZJ9fzpCMOMQxvuzbcS
         H/QH1ZlXaEWUXfavPQvn4kTfeYSMU3v8Rp9/kquz0qSaTU+aGgQGiijwzEKdcLAFqNmm
         UphQifz28Kwdh5Fqiuqd+R6LQ0mV7UrSSj+Lv7Xpt2+StlxUg4KYhBBir72oKcDZC1vc
         exgA==
X-Gm-Message-State: AC+VfDyaerYP4teFiU8JY0HhQSfUbuyXp+ca6CD3kWOOTx5SLdcbXNGq
        mTcenrcaRuqZ0Uu0AZHcCFwTlEHG4QNsvQ==
X-Google-Smtp-Source: ACHHUZ7ba/Xh7elxe6ChoVnSNP5RVMN2e2mldGZEh0c1L4GkyqYouIgLvWoGBnJnoNCHtKgu17h/DRA0j3+evg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:903:3291:b0:1ad:e1a3:919 with SMTP id
 jh17-20020a170903329100b001ade1a30919mr237956plb.8.1685738521194; Fri, 02 Jun
 2023 13:42:01 -0700 (PDT)
Date:   Fri, 2 Jun 2023 20:41:59 +0000
In-Reply-To: <20230602081135.75424-3-wuyun.abel@bytedance.com>
Mime-Version: 1.0
References: <20230602081135.75424-1-wuyun.abel@bytedance.com> <20230602081135.75424-3-wuyun.abel@bytedance.com>
Message-ID: <20230602204159.vo7fmuvh3y2pdfi5@google.com>
Subject: Re: [PATCH net-next v5 2/3] sock: Always take memcg pressure into consideration
From:   Shakeel Butt <shakeelb@google.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <muchun.song@linux.dev>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+Willem

On Fri, Jun 02, 2023 at 04:11:34PM +0800, Abel Wu wrote:
> The sk_under_memory_pressure() is called to check whether there is
> memory pressure related to this socket. But now it ignores the net-
> memcg's pressure if the proto of the socket doesn't care about the
> global pressure, which may put burden on its memcg compaction or
> reclaim path (also remember that socket memory is un-reclaimable).
> 
> So always check the memcg's vm status to alleviate memstalls when
> it's in pressure.
> 

This is interesting. UDP is the only protocol which supports memory
accounting (i.e. udp_memory_allocated) but it does not define
memory_pressure. In addition, it does have sysctl_udp_mem. So
effectively UDP supports a hard limit and ignores memcg pressure at the
moment. This patch will change its behavior to consider memcg pressure
as well. I don't have any objection but let's get opinion of UDP
maintainer.

> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  include/net/sock.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 3f63253ee092..ad1895ffbc4a 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1411,13 +1411,11 @@ static inline bool sk_has_memory_pressure(const struct sock *sk)
>  
>  static inline bool sk_under_memory_pressure(const struct sock *sk)
>  {
> -	if (!sk->sk_prot->memory_pressure)
> -		return false;
> -
>  	if (mem_cgroup_under_socket_pressure(sk->sk_memcg))
>  		return true;
>  
> -	return !!*sk->sk_prot->memory_pressure;
> +	return sk->sk_prot->memory_pressure &&
> +		*sk->sk_prot->memory_pressure;
>  }
>  
>  static inline long
> -- 
> 2.37.3
> 
