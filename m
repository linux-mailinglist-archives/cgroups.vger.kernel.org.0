Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5E3364700
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 17:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240229AbhDSPWZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 11:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238909AbhDSPWZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Apr 2021 11:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618845715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T04/99zjOhCEQHzWZ92KH2vVjDJkKk+5bJDNm7yYZ9I=;
        b=XWNG6kKy5BpR5ojCyN09H/Al44givRE6TRsbvvd2lgoe+J74x0KHUnttSK2RdDHhXYJAes
        c4RqolYj5IRjUMJwzzBRgvn0qvrJdugl+0zGHjD2bW6F5+WWSYjwqsvbsmMiUXiepMWnyH
        1OEPlgsJF44pCsFS3u2Hu8XQf5ZhUbA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-I6rRIDqLN5e463e-gf4X6w-1; Mon, 19 Apr 2021 11:21:53 -0400
X-MC-Unique: I6rRIDqLN5e463e-gf4X6w-1
Received: by mail-qt1-f200.google.com with SMTP id y10-20020a05622a004ab029019d4ad3437cso9179795qtw.12
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 08:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T04/99zjOhCEQHzWZ92KH2vVjDJkKk+5bJDNm7yYZ9I=;
        b=dDhMxeJnPTQAGZrfUghXsZcmeBd6+CnQHfvDrJF/VgJfGA+1U5xjYLJHDTcUy0EXlh
         QCHw2Er7FRzZ2IDU/WAmQhXVTnb5ziWvgusY9J4Cxntr16u6D/jwFFCOF8RvgW4+dnJT
         1+zeV2HJRRxC8nGLk/u3k+GiZBbHSAKFPGh08iJB7dfZfwOsIojO03EH90PWQg9m2OfH
         M5M1Og2RbaA88JjMqipW+OpBUsKCUWKiMv4sn7mSQh8uDoM4mzEo5vhZ50kAu7XcINjM
         EuTfjWrF9WIPc9ZS4ngpa8UuplZzMRJ6kGWazR13+T4MrE+uvzfRlkn+lVe4sjHtIICu
         GWFQ==
X-Gm-Message-State: AOAM533Rd9ont15r8ZmkQasly33UVEXuw4nJFWnF8qhMVRtmD5tphuK2
        TaQzIo4lBEQO9tHZwR37UwOPTwnCVnEfobUo3+TfHFWG3eIV2PsYfuFNat3w1jyK/LapA/jNMmC
        qdunroPsM6CAS//RlXw==
X-Received: by 2002:a0c:f514:: with SMTP id j20mr22772776qvm.14.1618845712866;
        Mon, 19 Apr 2021 08:21:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfcP+m2/yYx0KigHlb0LSENNqOid6KRPq88K9IL3KERZIIwfhDU0/SUnWl4lHGZwVLDt3UYQ==
X-Received: by 2002:a0c:f514:: with SMTP id j20mr22772760qvm.14.1618845712728;
        Mon, 19 Apr 2021 08:21:52 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id n136sm9882372qka.133.2021.04.19.08.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 08:21:52 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 1/5] mm/memcg: Move mod_objcg_state() to memcontrol.c
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
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
References: <20210419000032.5432-1-longman@redhat.com>
 <20210419000032.5432-2-longman@redhat.com> <YH2eT+JCII48hX80@cmpxchg.org>
Message-ID: <ffb5705e-8629-808d-9d09-0c9c7f509326@redhat.com>
Date:   Mon, 19 Apr 2021 11:21:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YH2eT+JCII48hX80@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/19/21 11:14 AM, Johannes Weiner wrote:
> On Sun, Apr 18, 2021 at 08:00:28PM -0400, Waiman Long wrote:
>> The mod_objcg_state() function is moved from mm/slab.h to mm/memcontrol.c
>> so that further optimization can be done to it in later patches without
>> exposing unnecessary details to other mm components.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/memcontrol.c | 13 +++++++++++++
>>   mm/slab.h       | 16 ++--------------
>>   2 files changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index e064ac0d850a..dc9032f28f2e 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3150,6 +3150,19 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>>   	css_put(&memcg->css);
>>   }
>>   
>> +void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>> +		     enum node_stat_item idx, int nr)
>> +{
>> +	struct mem_cgroup *memcg;
>> +	struct lruvec *lruvec = NULL;
>> +
>> +	rcu_read_lock();
>> +	memcg = obj_cgroup_memcg(objcg);
>> +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
>> +	mod_memcg_lruvec_state(lruvec, idx, nr);
>> +	rcu_read_unlock();
>> +}
> It would be more naturally placed next to the others, e.g. below
> __mod_lruvec_kmem_state().
>
> But no deal breaker if there isn't another revision.
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
Yes, there will be another revision by rebasing patch series on the 
linux-next. I will move the function then.

Cheers,
Longman

