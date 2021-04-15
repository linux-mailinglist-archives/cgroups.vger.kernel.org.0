Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190703610A2
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 18:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhDORAC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 13:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233330AbhDORAC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 13:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618505979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=elHrGsyviNRX+T8DndgeK2yskuXfifgVcBuAA2Ta4Ok=;
        b=ewyXg4zk7G8LPtm97g8uMyScjtrJePy7OCx2SFjFsyU0Z85qgGi7wh+cEV9rB9wSh7TcPW
        c89zEp/NM3T70m2NioU9smDZgnTGxrZxG6DyNYlbgDMFVdJbz0+APdu34658zc6Fu2kea5
        /D3XGef37+yY+RPxaTRzDF0PuIHttas=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-XtAzQw7bMgyO5LUnPCrAqQ-1; Thu, 15 Apr 2021 12:59:37 -0400
X-MC-Unique: XtAzQw7bMgyO5LUnPCrAqQ-1
Received: by mail-qk1-f199.google.com with SMTP id 79so1915643qkm.20
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 09:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=elHrGsyviNRX+T8DndgeK2yskuXfifgVcBuAA2Ta4Ok=;
        b=BpjH41uThSJKBx+GIIqOBeBcLl7mFszJsEsoMjlHZL0GETBG/0pKOK+hn3wFQIA3KW
         BGsvI8u1TuAx/v85GuKdLvitaLvghlxj7wi4ubcyjDqfeHFssE+aYZdRXlSjwYga8K9e
         AmSF0lzsvpPDl5DJKXhSGLyz2eEFNr/OncN7yzcRR8cIuFp0RM6gSSuaFPB+pvfGoqgc
         nCbrJ7UNEIL2sN8OvLD2g2gCI2OjVfeUbh3REeHRtM2GqG5OZ0ysHOurhdmX8SuYfotV
         AI6ZwGYZTIRZ3pVSx36tGnsqVWZZS3C+yTB/9k3xv/jiSMDbyvs2iODzzlxDwg0Yw3W5
         aCYA==
X-Gm-Message-State: AOAM530g6Ir/LmrqQN8DuOH4C3iRfiH79kbubLY1XD7mWnX5UHDiupqd
        iYGW4sq+uyTntwtUM3IlfqORoNo2cizvD6fDZY9VIv3QGd7UqHHrD2lJiq06jDovS/7ZjaXezwy
        Uk80ctNbnlW9jVUdwhQ==
X-Received: by 2002:a37:d4e:: with SMTP id 75mr4203698qkn.457.1618505974857;
        Thu, 15 Apr 2021 09:59:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvAPNkVJI8wUxitPnbMVkF+NPMJpjx0i3yeexynXZiZOvFXpqTEJad03ray4v6M3SeArr5Zw==
X-Received: by 2002:a05:620a:13a6:: with SMTP id m6mr4535437qki.64.1618505963716;
        Thu, 15 Apr 2021 09:59:23 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id h65sm2349848qkc.128.2021.04.15.09.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 09:59:23 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 1/5] mm/memcg: Pass both memcg and lruvec to
 mod_memcg_lruvec_state()
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
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-2-longman@redhat.com> <YHhsapGx3vTlyZvF@cmpxchg.org>
Message-ID: <59a85df9-3e77-1d43-8673-2ff50a741130@redhat.com>
Date:   Thu, 15 Apr 2021 12:59:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHhsapGx3vTlyZvF@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/15/21 12:40 PM, Johannes Weiner wrote:
> On Tue, Apr 13, 2021 at 09:20:23PM -0400, Waiman Long wrote:
>> The caller of mod_memcg_lruvec_state() has both memcg and lruvec readily
>> available. So both of them are now passed to mod_memcg_lruvec_state()
>> and __mod_memcg_lruvec_state(). The __mod_memcg_lruvec_state() is
>> updated to allow either of the two parameters to be set to null. This
>> makes mod_memcg_lruvec_state() equivalent to mod_memcg_state() if lruvec
>> is null.
>>
>> The new __mod_memcg_lruvec_state() function will be used in the next
>> patch as a replacement of mod_memcg_state() in mm/percpu.c for the
>> consolidation of the memory uncharge and vmstat update functions in
>> the kmem_cache_free() path.
> This requires users who want both to pass a pgdat that can be derived
> from the lruvec. This is error prone, and we just acked a patch that
> removes this very thing from mem_cgroup_page_lruvec().
>
> With the suggestion for patch 2, this shouldn't be necessary anymore,
> though. And sort of underlines my point around that combined function
> creating akwward code above and below it.
>
The reason of passing in the pgdat is because of the caching of vmstat 
data. lruvec may be gone if the corresponding memory cgroup is removed, 
but pgdat should stay put. That is why I put pgdat in the obj_stock for 
caching. I could also put the node id instead of pgdat.

Cheers,
Longman

