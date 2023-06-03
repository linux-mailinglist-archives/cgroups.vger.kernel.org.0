Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B39720FE3
	for <lists+cgroups@lfdr.de>; Sat,  3 Jun 2023 13:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjFCLOG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 3 Jun 2023 07:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbjFCLOF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 3 Jun 2023 07:14:05 -0400
Received: from out-27.mta1.migadu.com (out-27.mta1.migadu.com [95.215.58.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9052C180
        for <cgroups@vger.kernel.org>; Sat,  3 Jun 2023 04:14:04 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685790840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i0q/clNCiyPn574KHeniYdEndEa5TXryq3X5pe8ow6w=;
        b=HYP7ozwc29UHBTiFBxCxuhOm9xSrugaz6Honm6gB1dNkSHn6Ze3Tmz1D15istw+Iy2Rg3h
        slS/a6Ni7WVuTlJI+8H1Y+c83krBl360mi4qF4E9p6YtGRScKv05LrLem8nvMcGgsABoC1
        p8nzVqFgLh8+NgqNn2GjR4+0DBwMUGk=
MIME-Version: 1.0
Subject: Re: [PATCH] memcg: use helper macro FLUSH_TIME
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230603072116.1101690-1-linmiaohe@huawei.com>
Date:   Sat, 3 Jun 2023 19:13:24 +0800
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9542DF5E-6B48-48EA-BBD2-3FF801E29C65@linux.dev>
References: <20230603072116.1101690-1-linmiaohe@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Jun 3, 2023, at 15:21, Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
> Use helper macro FLUSH_TIME to indicate the flush time to improve the
> readability a bit. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks

