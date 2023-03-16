Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0986BC232
	for <lists+cgroups@lfdr.de>; Thu, 16 Mar 2023 01:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCPAKG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 20:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjCPAJ7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 20:09:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0956F525B
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 17:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678925352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xoeBmzzz0FU9zZCf+NCdIJ+5XjbGzZmlZo/bkUXi60o=;
        b=EZvnnr33BxwP+gbEE2sWARO0Erk9g5gckMO6LZujfKTxXlEGebwTxeIGRnhr1JDKl0CF/K
        3iWdQKFJrwugpbkUibk/DDn3vLWCkMWMP7Gnt4F7kjKmBroUsbkBlQhTxQAg8cCyS/9+JP
        Gh8M/SuLTlPRngIuNuEXUk6QFqwL+W0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-v8AEuQWUOgOLUsSnft__XA-1; Wed, 15 Mar 2023 20:09:06 -0400
X-MC-Unique: v8AEuQWUOgOLUsSnft__XA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1E23801206;
        Thu, 16 Mar 2023 00:09:05 +0000 (UTC)
Received: from [10.22.34.146] (unknown [10.22.34.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F4A91121314;
        Thu, 16 Mar 2023 00:09:04 +0000 (UTC)
Message-ID: <8d4e1b74-6ae8-4243-d5c2-e63e8046d355@redhat.com>
Date:   Wed, 15 Mar 2023 20:09:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from
 compound_head(page)
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
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
 <ZBFPh6j+4Khl1Je8@casper.infradead.org>
 <CAJD7tkYFjRPq6ATj-d0P25FhDaMzKdXfqTa_hh7TZp_Xyt4v+w@mail.gmail.com>
 <ZBG3xzGd6j+uByyN@casper.infradead.org>
 <CAJD7tkbcTMo1oZAa0Pa3v_6d0n4bHCo+8vTxzXGU6UBVOhrUQw@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAJD7tkbcTMo1oZAa0Pa3v_6d0n4bHCo+8vTxzXGU6UBVOhrUQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 3/15/23 17:43, Yosry Ahmed wrote:
> On Wed, Mar 15, 2023 at 5:19 AM Matthew Wilcox <willy@infradead.org> wrote:
>> On Wed, Mar 15, 2023 at 12:04:10AM -0700, Yosry Ahmed wrote:
>>> On Tue, Mar 14, 2023 at 9:54 PM Matthew Wilcox <willy@infradead.org> wrote:
>>>> On Mon, Mar 13, 2023 at 02:08:53PM -0700, Yosry Ahmed wrote:
>>>>> On Mon, Mar 13, 2023 at 12:44 PM Andrew Morton
>>>>> <akpm@linux-foundation.org> wrote:
>>>>>> On Mon, 13 Mar 2023 08:34:52 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:
>>>>>>
>>>>>>> From: Hugh Dickins <hughd@google.com>
>>>>>>>
>>>>>>> In a kernel with added WARN_ON_ONCE(PageTail) in page_memcg_check(), we
>>>>>>> observed a warning from page_cgroup_ino() when reading
>>>>>>> /proc/kpagecgroup.
>>>>>> If this is the only known situation in which page_memcg_check() is
>>>>>> passed a tail page, why does page_memcg_check() have
>>>>>>
>>>>>>          if (PageTail(page))
>>>>>>                  return NULL;
>>>>>>
>>>>>> ?  Can we remove this to simplify, streamline and clarify?
>>>>> I guess it's a safety check so that we don't end up trying to cast a
>>>>> tail page to a folio. My opinion is to go one step further and change
>>>>> page_memcg_check() to do return the memcg of the head page, i.e:
>>>>>
>>>>> static inline struct mem_cgroup *page_memcg_check(struct page *page)
>>>>> {
>>>>>      return folio_memcg_check(page_folio(page));
>>>>> }
>>>> If you look at my commit becacb04fdd4, I was preserving the existing
>>>> behaviour of page_memcg_check() when passed a tail page.  It would
>>>> previously, rightly or wrongly, read the memcg_data from the tail page
>>>> and get back NULL.
>>> Right, I looked at that. I also looked at 1b7e4464d43a which added
>>> folio_memcg() and changed page_memcg()'s behavior to use page_folio()
>>> to retrieve the memcg from the head, which made me wonder why
>>> different decisions were made for these 2 helpers.
>>>
>>> Were the users of page_memcg() already passing in head pages only?
>> There were 18 months between those commits ... I'd learned to be
>> more careful about maintaining the semantics instead of changing
>> them to "what they should have been".
>>
>>>> I suspect that was not the intended behaviour, but I do not think this
>>>> patch is the right fix; it simply papers over the problem and maybe
>>>> creates a new one.  Callers of page_memcg_check() should be eliminated,
>>>> precisely because of this ambiguity.  It's up to the people who understand
>>>> each of the callers who need to make the decision to always convert the
>>>> page that they have to a folio and ask about its memcg, or whether they
>>>> want to preserve the existing behaviour of returning NULL for tail pages.
>>>>
>>>> So, I say NACK to this patch as it does not preserve existing behaviour,
>>>> and does not advance our understanding of what we have wrought.
>>> I am not sure which patch you are NACKing, the original patch from
>>> Hugh (adding compound_head() to page_cgroup_ino()) or the suggested
>>> alternative patch which changes page_memcg_check() to use
>>> page_folio().
>> Both patches are NACKed.  page_memcg_check() needs to go away
>> because it has the tail page ambiguity.  Both callers should be using
>> folio_memcg_check() directly and resolving for themselves what the
>> correct behaviour is when seeing a tail page.
>>
> I agree. I even suggested this to Michal in one of the replies.
>
> For page_cgroup_ino() we can simply pass in
> folio_memcg(page_folio(page)), which would mimic what Hugh's patch is
> doing for page_cgroup_ino().
>
> For page owner, I am not sure if we want to do something similar
> (which would start printing the memcg for tail pages as well), or
> explicitly excluding tail pages and THEN do
> folio_memcg(page_folio(page)) to get the memcg of head pages. Waiman,
> what do you think?

I prefer the current behavior of printing information for the head page 
only. I am open to suggestion of the best APIs to use.

Cheers,
Longman

