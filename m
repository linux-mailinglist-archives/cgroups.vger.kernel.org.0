Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0697F713981
	for <lists+cgroups@lfdr.de>; Sun, 28 May 2023 15:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjE1NCT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 May 2023 09:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjE1NCT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 28 May 2023 09:02:19 -0400
Received: from out-43.mta1.migadu.com (out-43.mta1.migadu.com [95.215.58.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE6E90
        for <cgroups@vger.kernel.org>; Sun, 28 May 2023 06:02:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685278936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZXa+Q1xIzbQ2IAdpFSYo7sWvHd3UcTbXBMlCfmZbUY=;
        b=RMKThOY2ZnoegXflMWRJU6adp4QipmRp12PejT2eSBK5bGcQuCW/uwq5m7XRDS/fpn8M+H
        TlgkD1l4KBJ4QFavGpsbbNmOnikoASMtE6nscS8YaMUy2OFyi2uR4ZJNY1V4REsxC7cOO2
        Io2kSEYTrQJnHO5WUV1QMF8iulfouBQ=
MIME-Version: 1.0
Subject: Re: [PATCH] memcg: remove unused mem_cgroup_from_obj()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <CAJD7tkZ2Q1ZCqNchpiiC6FCE08dYH6tzANA=VqujeDgT8YhRUA@mail.gmail.com>
Date:   Sun, 28 May 2023 21:01:37 +0800
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vasily Averin <vasily.averin@linux.dev>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2B59104-B602-45A3-B938-AE5DC67BAC98@linux.dev>
References: <20230527103126.398267-1-linmiaohe@huawei.com>
 <ZHGAcaqOx/e8lqwV@casper.infradead.org>
 <CAJD7tkYSrVkAONXko0eE6LWS__kK_Xeto9MVGwTxuqT5j6N8RQ@mail.gmail.com>
 <ZHIcnOV/mrkcerlG@casper.infradead.org>
 <CAJD7tkZ2Q1ZCqNchpiiC6FCE08dYH6tzANA=VqujeDgT8YhRUA@mail.gmail.com>
To:     Yosry Ahmed <yosryahmed@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On May 28, 2023, at 02:54, Yosry Ahmed <yosryahmed@google.com> wrote:
>=20
> On Sat, May 27, 2023 at 8:07=E2=80=AFAM Matthew Wilcox =
<willy@infradead.org> wrote:
>>=20
>> On Fri, May 26, 2023 at 09:13:05PM -0700, Yosry Ahmed wrote:
>>> On Fri, May 26, 2023 at 9:01=E2=80=AFPM Matthew Wilcox =
<willy@infradead.org> wrote:
>>>>=20
>>>> On Sat, May 27, 2023 at 06:31:26PM +0800, Miaohe Lin wrote:
>>>>> The function mem_cgroup_from_obj() is not used anymore. Remove it =
and
>>>>> clean up relevant comments.
>>>>=20
>>>> You should have looked at the git history to see why it was created
>>>> and who used it.
>>>>=20
>>>> Shakeel, Vasily, are you going to retry adding commit 1d0403d20f6c?
>>>=20
>>> That commit did not introduce the function though, no? It was
>>> introduced before it and replaced by other variants over time (like
>>> mem_cgroup_from_slab_obj()). It looks like that commit was reverted =
~9
>>> months ago. We can always bring it back if/when needed.
>>=20
>> The commit immediately preceding it is fc4db90fe71e.
>>=20
>> Of course we can bring it back.  It's just code.  But avoiding
>> unnecessary churn is also good.  Let's wait to hear from Vasily.
>>=20
>>> It also looks to me that 1d0403d20f6c was using =
mem_cgroup_from_obj()
>>> on a struct net object, which is allocated in net_alloc() from a =
slab
>>> cache, so mem_cgroup_from_slab_obj() should be sufficient, no?
>>=20
>> Clearly not.
>=20
> I dived deeper into the history on LKML, and you are right:
> https://lore.kernel.org/all/Yp4F6n2Ie32re7Ed@qian/
>=20
> I still do not understand why mem_cgroup_from_slab_obj() would not be
> sufficient, so I am hoping Vasily or Shakeel can help me understand
> here. Seems to be something arch-specific.

I think it is because *init_net* which is not allocated from slab meant
its address does not belong to linear mapping addresses on arm64. =
However,
virt_to_page() is only applicable to linear mapping addresses. So,
mem_cgroup_from_slab_obj() is not sufficient. mem_cgroup_from_obj() is =
used
in this case, which will use vmalloc_to_page() for the page associated
with *init_net*. If Vasily does not want to bring commit 1d0403d20f6c =
back,
this patch LGTM. Otherwise, let's wait for Vasily.

Thanks.

