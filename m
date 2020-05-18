Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B1B1D8A66
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2020 00:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgERWFP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 May 2020 18:05:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40621 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728129AbgERWFN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 May 2020 18:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589839511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iZK8o0/YgEUO016TV6TQ7POrns9r3ptB7P38AZfbfLY=;
        b=NZSy1xktGmA8/pvmLb1i6powT+xv0TGvezpc0H74gC44w6M8NODwNdePpXz2dkxQ3CaMZf
        Gq21MUedJoQ+8jF2gGhCn43bTYX8V7g4FHvtaG7alTkY/GiIW9RosDXlRrR+D3/yAR7sbc
        ZsbodOYiyP+FVm24gXngS/PGuNYKML0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-jiqD3ErjMku290OgbMSPcA-1; Mon, 18 May 2020 18:05:09 -0400
X-MC-Unique: jiqD3ErjMku290OgbMSPcA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCE021800704;
        Mon, 18 May 2020 22:05:06 +0000 (UTC)
Received: from llong.remote.csb (ovpn-114-131.rdu2.redhat.com [10.10.114.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EB1C5C1B2;
        Mon, 18 May 2020 22:05:00 +0000 (UTC)
Subject: Re: [PATCH v2 3/4] mm/slub: Fix another circular locking dependency
 in slab_attr_store()
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
References: <20200427235621.7823-4-longman@redhat.com>
 <F1FA6654-C07C-42FD-B497-61EB635B264C@lca.pw>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <638f59c0-60f1-2279-fea6-28b2980720f4@redhat.com>
Date:   Mon, 18 May 2020 18:05:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <F1FA6654-C07C-42FD-B497-61EB635B264C@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/16/20 10:19 PM, Qian Cai wrote:
>
>> On Apr 27, 2020, at 7:56 PM, Waiman Long <longman@redhat.com> wrote:
>>
>> It turns out that switching from slab_mutex to memcg_cache_ids_sem in
>> slab_attr_store() does not completely eliminate circular locking dependency
>> as shown by the following lockdep splat when the system is shut down:
>>
>> [ 2095.079697] Chain exists of:
>> [ 2095.079697]   kn->count#278 --> memcg_cache_ids_sem --> slab_mutex
>> [ 2095.079697]
>> [ 2095.090278]  Possible unsafe locking scenario:
>> [ 2095.090278]
>> [ 2095.096227]        CPU0                    CPU1
>> [ 2095.100779]        ----                    ----
>> [ 2095.105331]   lock(slab_mutex);
>> [ 2095.108486]                                lock(memcg_cache_ids_sem);
>> [ 2095.114961]                                lock(slab_mutex);
>> [ 2095.120649]   lock(kn->count#278);
>> [ 2095.124068]
>> [ 2095.124068]  *** DEADLOCK ***
> Can you show the full splat?
>
>> To eliminate this possibility, we have to use trylock to acquire
>> memcg_cache_ids_sem. Unlikely slab_mutex which can be acquired in
>> many places, the memcg_cache_ids_sem write lock is only acquired
>> in memcg_alloc_cache_id() to double the size of memcg_nr_cache_ids.
>> So the chance of successive calls to memcg_alloc_cache_id() within
>> a short time is pretty low. As a result, we can retry the read lock
>> acquisition a few times if the first attempt fails.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> The code looks a bit hacky and probably not that robust. Since it is the shutdown path which is not all that important without lockdep, maybe you could drop this single patch for now until there is a better solution?

That is true. Unlike using the slab_mutex, the chance of failing to 
acquire a read lock on memcg_cache_ids_sem is pretty low. Maybe just 
print_once a warning if that happen.

Thanks,
Longman

