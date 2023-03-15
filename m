Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44A06BA581
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 04:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCODHy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Mar 2023 23:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjCODHx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Mar 2023 23:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863865D888
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 20:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678849621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/9uUNak1Tu2TI0+onJdIdCGcTQ1Jze/K6cutYT1dX2Y=;
        b=NUuLDFKSTXovbx8tqwf/S0x8P/vK0pVNOho/s8j20bBitVMS3sov0n4e3VuIXDUfJVNpuD
        dzohhgejRhBXKjNkESy6lHgNmm0QGYmyyoe32pZ5z9R1pZnbPNcG/3ugjMXKcsihRHbuSW
        +HNT42bVzs9dPp432oT3Do01bJHdWVw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-eI4iOifCO8ytIOuGJ3mjeg-1; Tue, 14 Mar 2023 23:06:55 -0400
X-MC-Unique: eI4iOifCO8ytIOuGJ3mjeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48AAE3C02B67;
        Wed, 15 Mar 2023 03:06:55 +0000 (UTC)
Received: from [10.22.9.226] (unknown [10.22.9.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E7ABC017D7;
        Wed, 15 Mar 2023 03:06:54 +0000 (UTC)
Message-ID: <61e8e6d3-697e-f9a5-a1fb-45a3448ee5db@redhat.com>
Date:   Tue, 14 Mar 2023 23:06:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from
 compound_head(page)
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org
References: <20230313083452.1319968-1-yosryahmed@google.com>
 <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
 <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/13/23 17:08, Yosry Ahmed wrote:
> On Mon, Mar 13, 2023 at 12:44 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
>> On Mon, 13 Mar 2023 08:34:52 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:
>>
>>> From: Hugh Dickins <hughd@google.com>
>>>
>>> In a kernel with added WARN_ON_ONCE(PageTail) in page_memcg_check(), we
>>> observed a warning from page_cgroup_ino() when reading
>>> /proc/kpagecgroup.
>> If this is the only known situation in which page_memcg_check() is
>> passed a tail page, why does page_memcg_check() have
>>
>>          if (PageTail(page))
>>                  return NULL;
>>
>> ?  Can we remove this to simplify, streamline and clarify?
> I guess it's a safety check so that we don't end up trying to cast a
> tail page to a folio. My opinion is to go one step further and change
> page_memcg_check() to do return the memcg of the head page, i.e:
>
> static inline struct mem_cgroup *page_memcg_check(struct page *page)
> {
>      return folio_memcg_check(page_folio(page));
> }
>
> This makes it consistent with page_memcg(), and makes sure future
> users are getting the "correct" memcg for whatever page they pass in.
> I am interested to hear other folks' opinions here.
>
> The only other user today is print_page_owner_memcg(). I am not sure
> if it's doing the right thing by explicitly reading page->memcg_data,
> but it is already excluding pages that have page->memcg_data == 0,
> which should be the case for tail pages.

It is reading memcg_data directly to see if it is slab cache page. It is 
currently skipping page that does not have memcg_data set.

Cheers,
Longman

