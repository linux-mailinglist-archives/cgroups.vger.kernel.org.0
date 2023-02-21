Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E439969DB3B
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 08:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjBUHbg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 02:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBUHbf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 02:31:35 -0500
X-Greylist: delayed 501 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Feb 2023 23:31:34 PST
Received: from out-6.mta1.migadu.com (out-6.mta1.migadu.com [IPv6:2001:41d0:203:375::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5548223852
        for <cgroups@vger.kernel.org>; Mon, 20 Feb 2023 23:31:34 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676964187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cf+LpAhEO5DOwBgtr3qmUSxNMxu2ZN676lArhjLROM4=;
        b=aE81HyfVARJQiFBwWqtpuXcHzHwO+fJlvZRELGjtccNk4x3KKsPKW6F+yelYbWJeMWtd2p
        9iOz5RShcuT6nitSNpVzRU57VrAzHB+c2ty/PlwUJ8ukZKQgkCQ8L0lFWlUgCTMXP0I5Df
        jV0wjaQPQfHo2Qanog3rA0gyyhjSl3k=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
Date:   Tue, 21 Feb 2023 15:22:32 +0800
Cc:     Shakeel Butt <shakeelb@google.com>, Yue Zhao <findns94@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <61CA5FFC-547B-4F56-9238-C9096223BF80@linux.dev>
References: <20230220230624.lkobqeagycx7bi7p@google.com>
 <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
To:     Roman Gushchin <roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Feb 21, 2023, at 13:17, Roman Gushchin <roman.gushchin@linux.dev> =
wrote:
>=20
>> On Feb 20, 2023, at 3:06 PM, Shakeel Butt <shakeelb@google.com> =
wrote:
>>=20
>> =EF=BB=BFOn Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin =
wrote:
>>>> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
>>>> The knob for cgroup v2 memory controller: memory.oom.group
>>>> will be read and written simultaneously by user space
>>>> programs, thus we'd better change memcg->oom_group access
>>>> with atomic operations to avoid concurrency problems.
>>>>=20
>>>> Signed-off-by: Yue Zhao <findns94@gmail.com>
>>>=20
>>> Hi Yue!
>>>=20
>>> I'm curious, have any seen any real issues which your patch is =
solving?
>>> Can you, please, provide a bit more details.
>>>=20
>>=20
>> IMHO such details are not needed. oom_group is being accessed
>> concurrently and one of them can be a write access. At least
>> READ_ONCE/WRITE_ONCE is needed here.
>=20
> Needed for what?
>=20
> I mean it=E2=80=99s obviously not a big deal to put =
READ_ONCE()/WRITE_ONCE() here, but I struggle to imagine a scenario when =
it will make any difference. IMHO it=E2=80=99s easier to justify a =
proper atomic operation here, even if it=E2=80=99s most likely an =
overkill.
>=20
> My question is very simple: the commit log mentions =E2=80=9C=E2=80=A6 =
to avoid concurrency problems=E2=80=9D, so I wonder what problems are =
these.

I think there is no difference in the assembly code between them in most
cases. The only intention that I can think of is to avoid the potential
complaint (data race) emitted by KCSAN.

>=20
> Also there are other similar cgroup interfaces without =
READ_ONCE()/WRITE_ONCE().

If we decide to fix, then we should fix all.

Thanks.

>=20
> Thanks!


