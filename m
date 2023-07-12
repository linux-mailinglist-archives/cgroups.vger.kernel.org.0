Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E6174FDFA
	for <lists+cgroups@lfdr.de>; Wed, 12 Jul 2023 05:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGLDpp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jul 2023 23:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjGLDpl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jul 2023 23:45:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4BC1717;
        Tue, 11 Jul 2023 20:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC6B5616DB;
        Wed, 12 Jul 2023 03:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36885C433C8;
        Wed, 12 Jul 2023 03:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689133539;
        bh=kV1aAg4a4cV9uuw2PocMUWykoJKk/tyIh0MW/t13PJs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GD62fC1aPLT4Chb4Q2u79JyVL01BCjTdBo6PhaMSEQghTJVJ2XMfb8K4IA+5zMHhm
         Jw5/r04qhJG3aBR8GiU4bqed0fsjfTvIcbfb6yTVO/VaN9jYHTc9bLnaqE6xisBuL2
         DFlYzM4h3GDQcPSUU8/iQpd3F3709bWbKmrIjdADvjUlCi170bJr8v5f93PdOLp2wg
         nARXUSE+et76TRzo+W1gxu3XwSJZf7jgKK72NG0sQ02KHSbo3GZ+nPTpLCh6eWNMR1
         38TqTfOPM7T4rqJJpU4+HxdOul3kyGc7D8rFNUpml/fi7eSw5LpV8FvkUIEcjwXB8S
         4b6xx+Y7a3Kvw==
Date:   Tue, 11 Jul 2023 20:45:37 -0700
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
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Breno Leitao <leitao@debian.org>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: Re: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators
 of sockmem pressure
Message-ID: <20230711204537.04cb1124@kernel.org>
In-Reply-To: <20230711124157.97169-1-wuyun.abel@bytedance.com>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 11 Jul 2023 20:41:43 +0800 Abel Wu wrote:
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

Eric Dumazet is currently AFK, can we wait for him to return 
(in about a week) before merging?
