Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BC169DA52
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 06:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjBUFRn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 00:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjBUFRm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 00:17:42 -0500
Received: from out-60.mta1.migadu.com (out-60.mta1.migadu.com [IPv6:2001:41d0:203:375::3c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D42025BA0
        for <cgroups@vger.kernel.org>; Mon, 20 Feb 2023 21:17:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676956658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHA4ShwNMc6Yko4CbZnfjUYJ3+IEBFc/U9IHl1ydyHU=;
        b=SXSZebXV3YlaL4vWyE/804yKeFVfemiAG1+03DjJ6qxJkRSrXnmU0+PShEqj3GjAY5zPiX
        wMvdyP9wVBiSDcdKGvCTvpXtS5z5qfbZaGs+tWTsPwwuZJoE7vUsH7Pufzko8fAojReXSK
        MUzlB4qxYLsDXsDQEHUlhfdQs6bkSsQ=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
Date:   Mon, 20 Feb 2023 21:17:25 -0800
Message-Id: <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
References: <20230220230624.lkobqeagycx7bi7p@google.com>
Cc:     Yue Zhao <findns94@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230220230624.lkobqeagycx7bi7p@google.com>
To:     Shakeel Butt <shakeelb@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> On Feb 20, 2023, at 3:06 PM, Shakeel Butt <shakeelb@google.com> wrote:
>=20
> =EF=BB=BFOn Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin wrote:
>>> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
>>> The knob for cgroup v2 memory controller: memory.oom.group
>>> will be read and written simultaneously by user space
>>> programs, thus we'd better change memcg->oom_group access
>>> with atomic operations to avoid concurrency problems.
>>>=20
>>> Signed-off-by: Yue Zhao <findns94@gmail.com>
>>=20
>> Hi Yue!
>>=20
>> I'm curious, have any seen any real issues which your patch is solving?
>> Can you, please, provide a bit more details.
>>=20
>=20
> IMHO such details are not needed. oom_group is being accessed
> concurrently and one of them can be a write access. At least
> READ_ONCE/WRITE_ONCE is needed here.

Needed for what?

I mean it=E2=80=99s obviously not a big deal to put READ_ONCE()/WRITE_ONCE()=
 here, but I struggle to imagine a scenario when it will make any difference=
. IMHO it=E2=80=99s easier to justify a proper atomic operation here, even i=
f it=E2=80=99s most likely an overkill.

My question is very simple: the commit log mentions =E2=80=9C=E2=80=A6 to av=
oid concurrency problems=E2=80=9D, so I wonder what problems are these.

Also there are other similar cgroup interfaces without READ_ONCE()/WRITE_ONC=
E().

Thanks!=
