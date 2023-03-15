Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53036BA5A4
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 04:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCODeQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Mar 2023 23:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCODeP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Mar 2023 23:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE41337B5B
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 20:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678851211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TbwJgOTQEBOTQga1KdTR+fInJ3Zcev0Mf+xVWLD7VKE=;
        b=f0Y1t+3jDcA8DyeYVPhn8326NLBqqEKnq6R1QJI2d1usr765vbF8Cv9VY9tmQmcj8JPMBE
        FJ7nBEfFQk58x4Ptww7tXE0mGVc6KMM6J3WTTSCdh58R63o/fdl2UDVFaF/yNLAZAm/A62
        cP3jN0QIYhZDOsDmFLOPEBwkOnuQ0Og=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-l7C_wICLOjC5hbBTZp-EPA-1; Tue, 14 Mar 2023 23:33:25 -0400
X-MC-Unique: l7C_wICLOjC5hbBTZp-EPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77CDC101AA78;
        Wed, 15 Mar 2023 03:33:24 +0000 (UTC)
Received: from [10.22.9.226] (unknown [10.22.9.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A38E40C6E6A;
        Wed, 15 Mar 2023 03:33:16 +0000 (UTC)
Message-ID: <84d8fd38-f05c-73f5-ef50-fcac524097f3@redhat.com>
Date:   Tue, 14 Mar 2023 23:33:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from
 compound_head(page)
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
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
        cgroups@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20230313083452.1319968-1-yosryahmed@google.com>
 <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
 <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
 <61e8e6d3-697e-f9a5-a1fb-45a3448ee5db@redhat.com>
 <CAJD7tkYm25ohS_P1Q6mzZMHJp4Hjwr3LqLaiPA3NFpa1gfOdJw@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAJD7tkYm25ohS_P1Q6mzZMHJp4Hjwr3LqLaiPA3NFpa1gfOdJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/14/23 23:10, Yosry Ahmed wrote:
>>> The only other user today is print_page_owner_memcg(). I am not sure
>>> if it's doing the right thing by explicitly reading page->memcg_data,
>>> but it is already excluding pages that have page->memcg_data == 0,
>>> which should be the case for tail pages.
>> It is reading memcg_data directly to see if it is slab cache page. It is
>> currently skipping page that does not have memcg_data set.
> IIUC this skips tail pages, because they should always have
> page->memcg_data == 0, even if they are charged to a memcg. To
> correctly get their memcg we should read it from the
> compound_head()/page_folio().
The purpose of that function is mainly to report pages that have a 
reference to a memcg, especially the dead one. So by counting the 
occurrence of a particular cgroup name, we can have a rough idea of 
that. So only head page has relevance here and we can skip the tail pages.
>
> My 2c, we can check PageSlab() to print the extra message for slab
> pages, instead of reading memcg_data directly, which kinda breaks the
> abstraction created by the various helpers for reading a page memcg.
> Someone can easily change something in how memcg_data is interpreted
> in those helpers without realizing that page_owner is also reading it.

You are right. We should be using a helper if available. I will send a 
patch to fix that.

Thanks,
Longman

