Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB9373EB57
	for <lists+cgroups@lfdr.de>; Mon, 26 Jun 2023 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjFZT6X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Jun 2023 15:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFZT6W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Jun 2023 15:58:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17DFE7B;
        Mon, 26 Jun 2023 12:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6036C60F52;
        Mon, 26 Jun 2023 19:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CE4C433C8;
        Mon, 26 Jun 2023 19:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687809500;
        bh=ldB+MatWlVsNCLZ0mR+Yj//TS0gmW2dKp23REUfd6MU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u697IQCtWc7mPfP5qNsMU2uWqPdgmV1hJ9wSJ61mq7qWHcO0fSuOP1QJw+GQeHeJH
         yz3fVEY9D+3Y2y0raE7vu687ZMFBltGJd3Hbyz5/t59QlAG5BYc6OUe21J6p2bNMVf
         OFGKjOGg70AKDzOnVr+EfgC/iuPcBNc0vy+l4Bv2s2efBnkJHfTS8DYof2UJupzYOc
         FS4iuCYuKTQ+vdUlmXxHzPYvwMhsLdhSlxZx2f6bZWgp4nNp2LWcKxhCIuuJAQb1oC
         e1bDUJvq8rLTipdMQC6SN1Xtd48ku1uo9jnnBTMDyzo9BLxP76wRPO06DnbgNaGR/F
         w1PG4+jOG5OGw==
Date:   Mon, 26 Jun 2023 12:58:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Breno Leitao <leitao@debian.org>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org (open list),
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: Re: [PATCH net-next 1/2] net-memcg: Scopify the indicators of
 sockmem pressure
Message-ID: <20230626125818.74193aea@kernel.org>
In-Reply-To: <20230625142820.47185-1-wuyun.abel@bytedance.com>
References: <20230625142820.47185-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, 25 Jun 2023 22:28:10 +0800 Abel Wu wrote:
> Now there are two indicators of socket memory pressure sit inside
> struct mem_cgroup, socket_pressure and tcpmem_pressure.
> 
> When in legacy mode aka. cgroupv1, the socket memory is charged
> into a separate counter memcg->tcpmem rather than ->memory, so
> the reclaim pressure of the memcg has nothing to do with socket's
> pressure at all. While for default mode, the ->tcpmem is simply
> not used.
> 
> So {socket,tcpmem}_pressure are only used in default/legacy mode
> respectively. This patch fixes the pieces of code that make mixed
> use of both.

The merge window for 6.5 has now started, let's defer this until 6.6.

Please repost in ~2 weeks.
-- 
pw-bot: defer
