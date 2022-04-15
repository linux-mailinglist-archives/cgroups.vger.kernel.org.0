Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE37502D60
	for <lists+cgroups@lfdr.de>; Fri, 15 Apr 2022 18:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351684AbiDOQCZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Apr 2022 12:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349398AbiDOQCZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Apr 2022 12:02:25 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11039D0E0;
        Fri, 15 Apr 2022 08:59:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650038391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQ/j24GLveqMBhfRtNWZjMAkMOjKnLZwyOdqxvR91eI=;
        b=mq1u7phOZ+sAnnnDp1ut5N/Hn+PA19vw5Hl9rcpv4HyniUFuSb1Ip8FJOHuMswzWFy+9ht
        G5wznUQt6OzRY0vmj9yjRRAktUQzidZUihGdWrXAUX1HC67JUtN80CUN3HdqKdjn3iV6M3
        kaYCMNoSWwyJP7mKhn1RmZsaj+BJg6c=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] kselftests: memcg: update the oom group leaf events test
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <20220415140817.ljznpvacne6nchg5@dev0025.ash9.facebook.com>
Date:   Fri, 15 Apr 2022 08:59:48 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>
Message-Id: <238226BB-6536-489A-BCC7-4611F86D036D@linux.dev>
References: <20220415140817.ljznpvacne6nchg5@dev0025.ash9.facebook.com>
To:     David Vernet <void@manifault.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


> On Apr 15, 2022, at 7:08 AM, David Vernet <void@manifault.com> wrote:
>=20
> =EF=BB=BFOn Thu, Apr 14, 2022 at 05:01:30PM -0700, Roman Gushchin wrote:
>> Commit 9852ae3fe529 ("mm, memcg: consider subtrees in memory.events") mad=
e
>> memory.events recursive: all events are propagated upwards by the
>> tree. It was a change in semantics.
>=20
> In one of our offline discussions you mentioned that we may want to
> consider having the test take mount options into account. If we decide to
> go that route we should probably have this testcase take memory_localevent=
s
> into account as well. If so, I'm happy to take care of that in a follow-on=

> patch after this is merged as I already have a patch locally that reads an=
d
> parses /proc/mounts to detect these mount options.

It would be great, thank you!

>> -    if (cg_read_key_long(parent, "memory.events", "oom_kill ") !=3D 0)
>> +    if (cg_read_key_long(parent, "memory.events", "oom_kill ") <=3D 0)
>>        goto cleanup;
>>=20
>>    ret =3D KSFT_PASS;
>> --=20
>> 2.35.1
>>=20
>=20
> Looks good, thanks.
>=20
> Reviewed-by: David Vernet <void@manifault.com>

Thanks!=
