Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988B274A8FA
	for <lists+cgroups@lfdr.de>; Fri,  7 Jul 2023 04:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjGGC0Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jul 2023 22:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjGGC0Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jul 2023 22:26:16 -0400
Received: from out-46.mta1.migadu.com (out-46.mta1.migadu.com [95.215.58.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386F019A6
        for <cgroups@vger.kernel.org>; Thu,  6 Jul 2023 19:26:14 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688696770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xRLT9ea/2ScZsoJKQA4zG+jZgoWMbP6gLAC+IguOQ8=;
        b=Wf36/tDV+B1vbKdnbBZ3K4lf3PqmVLFmdnV05SyMbbAZQ3rrHLS+oJeEwM9jfj8Us3Bqd2
        T9CB2agUUHRxpTTZBp1RhpB7BrW2H3eVlV/A0mG6izsBCPlunuGuLqRy0aYbExsdC5ELeQ
        VxY2I2256KXI+KJem9mlrCol+BHn8hA=
MIME-Version: 1.0
Subject: Re: [PATCH] mm/memcg: remove definition of MEM_CGROUP_ID_MAX when
 !CONFIG_MEMCG
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <61ce2910-f3de-cfb7-bdd3-546ade0cb6f3@huawei.com>
Date:   Fri, 7 Jul 2023 10:25:35 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <52C942A9-29F7-473F-8674-6CB584F009BA@linux.dev>
References: <20230706112820.2393447-1-linmiaohe@huawei.com>
 <892B507C-CFE8-4792-BA5F-3C698290A8EE@linux.dev>
 <61ce2910-f3de-cfb7-bdd3-546ade0cb6f3@huawei.com>
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



> On Jul 7, 2023, at 10:06, Miaohe Lin <linmiaohe@huawei.com> wrote:
>=20
> On 2023/7/7 9:47, Muchun Song wrote:
>>=20
>>=20
>>> On Jul 6, 2023, at 19:28, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>=20
>>> MEM_CGROUP_ID_MAX is only used when CONFIG_MEMCG is configured. =
Remove
>>> unneeded !CONFIG_MEMCG variant.
>>>=20
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>=20
>> MEM_CGROUP_ID_MAX is also only used in mem_cgroup_alloc(), maybe you =
also
>> could move it from memcontrol.h to memcontrol.c. And define it as:
>>=20
>> #define MEM_CGROUP_ID_MAX ((1U << MEM_CGROUP_ID_SHIFT) - 1)
>>=20
>> I am not suggesting defining it as USHRT_MAX, because if someone =
changes
>> MEM_CGROUP_ID_SHIFT in the future, then MEM_CGROUP_ID_MAX will not =
updated
>> accordingly.
>=20
> Looks sensible to me. Do you suggest squashing above changes into the =
current patch
> or a separate patch is preferred?

I think it's better to squash.

>=20
>>=20
>> For this patch, LGTM.
>>=20
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>=20
> Thanks for review and suggestion.
>=20
>=20
>=20

