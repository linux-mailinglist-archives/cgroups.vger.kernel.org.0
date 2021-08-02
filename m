Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F393DD71E
	for <lists+cgroups@lfdr.de>; Mon,  2 Aug 2021 15:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhHBNc3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Aug 2021 09:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233769AbhHBNc3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Aug 2021 09:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627911139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YxGDLCphK9pn216lXXkSKE8Ac13snf8eRBNigOGCfQY=;
        b=LwUA1poXBpKV5QefIG2TN9hKlLe03q+vRp+SMoqwJRK87wR4unpUGWvtxpD8PmzlnkYA/G
        i5n7li/pxZqCxay3kjzyfS3d75wSVqCYPYqgeZszgTfjXftJBqJCQvuS24Vw9qu9ZOUNX0
        aWr3Q+YaRfiBmAWFix+73S/4P7oOvhQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-s9Vsn2hmNbeseF2-FRnGfg-1; Mon, 02 Aug 2021 09:32:18 -0400
X-MC-Unique: s9Vsn2hmNbeseF2-FRnGfg-1
Received: by mail-qk1-f197.google.com with SMTP id p123-20020a378d810000b02903ad5730c883so12682906qkd.22
        for <cgroups@vger.kernel.org>; Mon, 02 Aug 2021 06:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YxGDLCphK9pn216lXXkSKE8Ac13snf8eRBNigOGCfQY=;
        b=Bfi14I1Hd5aTmIIFkC7Ih2ARh0G3FNicGZZUOJDAvswEK6ZD/W5ghkcpxMUB4yGBiF
         B2j4nJiT2+LpfOpeRk/N+kBnKYpPYYlqvZ+UlWrrlXzr8BdZlbOYL6LfnWc+LrPhWZPQ
         PfJzf/i5aLClhW2gUcT+2GRiZSPoiFFzQ2OltbOC5aFgoxJRpoZqm9Ml0z6gVeP/Td42
         AZ74P4vWnT/fg+DnZuW5Zyt75xj5pxXjYPI/Ll3IcXwT44BMx6xA+4xcApPKHDfCxDD9
         Tg41RIV4zyuaO0sJNIC6PeY3na4iUwidRVebVouSRSN3Nwnj+wmCAKztfmedGx53R3Vd
         UdFw==
X-Gm-Message-State: AOAM533Hjq/ByFV3k0bV8Xbb4orTAvaP12uscfeUBO9YhLteydeG7hQH
        mm3SOjtbtBV3umu8Nn53iHu8Hhg3iR8rLfzWiVLmn+zHjyHxzMSo1jA76LbGVI8jjegWiT65ns+
        pOKMl7qLZyEigCotV4Q==
X-Received: by 2002:ac8:4f11:: with SMTP id b17mr14083630qte.33.1627911137622;
        Mon, 02 Aug 2021 06:32:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGIz1xoKvPOqISRjUd4eV/HXaGubjZfpkkJ13bdLQELNFSuifXslmT7Q3i7tSI+D+KXlK5Dg==
X-Received: by 2002:ac8:4f11:: with SMTP id b17mr14083609qte.33.1627911137439;
        Mon, 02 Aug 2021 06:32:17 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id 2sm2507742qtz.1.2021.08.02.06.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 06:32:16 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] mm/memcg: Fix incorrect flushing of lruvec data in
 obj_stock
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210802022827.10192-1-longman@redhat.com>
 <YQeQfX3t8k+U3MIL@dhcp22.suse.cz>
Message-ID: <771539d4-765c-05c7-ab19-d4cae3d29efd@redhat.com>
Date:   Mon, 2 Aug 2021 09:32:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQeQfX3t8k+U3MIL@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/2/21 2:28 AM, Michal Hocko wrote:
> On Sun 01-08-21 22:28:27, Waiman Long wrote:
>> When mod_objcg_state() is called with a pgdat that is different from
>> that in the obj_stock, the old lruvec data cached in obj_stock are
>> flushed out. Unfortunately, they were flushed to the new pgdat and
>> hence the wrong node, not the one cached in obj_stock.
> It would be great to explicitly mention user observable problems here. I
> do assume this will make slab stats skewed but the effect wouldn't be
> very big, right?
It is the /sys/devices/system/node/node*/meminfo that will get skewed. 
Not /proc/meminfo. So it is a relatively minor issue. Will update the 
patch to mention that.
>> Fix that by flushing the data to the cached pgdat instead.
>>
>> Fixes: 68ac5b3c8db2 ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
>> ---
>>   mm/memcontrol.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index ae1f5d0cb581..881ec4ddddcd 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3106,17 +3106,19 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>>   		stock->cached_pgdat = pgdat;
>>   	} else if (stock->cached_pgdat != pgdat) {
>>   		/* Flush the existing cached vmstat data */
>> +		struct pglist_data *oldpg = stock->cached_pgdat;
>> +
>> +		stock->cached_pgdat = pgdat;
>>   		if (stock->nr_slab_reclaimable_b) {
>> -			mod_objcg_mlstate(objcg, pgdat, NR_SLAB_RECLAIMABLE_B,
>> +			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
>>   					  stock->nr_slab_reclaimable_b);
>>   			stock->nr_slab_reclaimable_b = 0;
>>   		}
>>   		if (stock->nr_slab_unreclaimable_b) {
>> -			mod_objcg_mlstate(objcg, pgdat, NR_SLAB_UNRECLAIMABLE_B,
>> +			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_UNRECLAIMABLE_B,
>>   					  stock->nr_slab_unreclaimable_b);
>>   			stock->nr_slab_unreclaimable_b = 0;
>>   		}
>> -		stock->cached_pgdat = pgdat;
> Minor nit. Is there any reason to move the cached_pgdat? TBH I found the
> original way better from the readability POV.

Right. Will move it back to its original place.

Cheers,
Longman


