Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCDF36103B
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 18:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhDOQgN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 12:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31986 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231137AbhDOQgN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 12:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618504549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s47wUvhDxo7f8LaX+UuV/f8OqzaAqCVXK0vtBt6gLnc=;
        b=c/OSYHYhaOiH4fd4gO9bUOMnYHa0BctwWZ9rTgb6cT0+9A/err5J76HUQrZ39/XvxRG/5m
        2aUUgFRnkBbUYr3+nxzxD9N+ycRbh1EUf7MeFl9EjcD7Zt1yA7fhRt2voHcQky6i9WIGPd
        qSSFdCYNDXkXSMTm9W2MYWxMarDXQuE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-Cfmj83W9NXaVLUhx4KzZzw-1; Thu, 15 Apr 2021 12:35:48 -0400
X-MC-Unique: Cfmj83W9NXaVLUhx4KzZzw-1
Received: by mail-qk1-f198.google.com with SMTP id 15so1871508qkv.16
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 09:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=s47wUvhDxo7f8LaX+UuV/f8OqzaAqCVXK0vtBt6gLnc=;
        b=PzvN8jRrobDXo0jJCdl15fSG/iYyyx5GnluWUQk7S1bfztJRvEsfBjTuxJCD9fxLaU
         4FkNu3zJvZOFK4vmnXMSYfwO0keHKmQ7Mxh4GMcFlRgwO6Du+2KsniPt7DcSC8aXcv6R
         CBoEFoNRZB0B/6NlinxJVz4Eb0a0K8JnDjAgqkmUVbWSIg9Z6muJkSn9NoGfJ9keyCiV
         EBPuTC+jwUOiUUAm7qkgALjN4h3tjBLekY0hdJjs460VkF2ORrlI0RBhO2touQMgdC70
         mUkNgdksy9S/kpFyNAxUWMGbH1YvUqQZQT0MwBucrrHJaqrWRuxXEmP9Kg69gJ5WpDtJ
         5zOA==
X-Gm-Message-State: AOAM532AG783fDQZxBBbEY+c+PmFIGwAcJf32lOdk1m3x3XfZwCmaV7D
        wfDEdVq40ETYVjFyJE4+fxxIaEumqXRDLKL/sY14Pacctn19UGr8DuK9rXdrU0SvWq8MQfnkxVG
        PaDuBbMOSORto2I9mww==
X-Received: by 2002:a05:622a:14c6:: with SMTP id u6mr3732871qtx.125.1618504547881;
        Thu, 15 Apr 2021 09:35:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdrAITzN7+b2b1F20V9MktKhAkmPaXFgdVujfeKgC7dKMBGFp5V/bRqqBWQ3QhezwWOXSwBg==
X-Received: by 2002:a05:622a:14c6:: with SMTP id u6mr3732852qtx.125.1618504547668;
        Thu, 15 Apr 2021 09:35:47 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id 26sm2171153qtd.73.2021.04.15.09.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 09:35:47 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 2/5] mm/memcg: Introduce
 obj_cgroup_uncharge_mod_state()
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
 <20210414012027.5352-3-longman@redhat.com> <YHhqPYcajI9JgXk/@cmpxchg.org>
Message-ID: <1c85e8f6-e8b9-33e1-e29b-81fbadff959f@redhat.com>
Date:   Thu, 15 Apr 2021 12:35:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHhqPYcajI9JgXk/@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/15/21 12:30 PM, Johannes Weiner wrote:
> On Tue, Apr 13, 2021 at 09:20:24PM -0400, Waiman Long wrote:
>> In memcg_slab_free_hook()/pcpu_memcg_free_hook(), obj_cgroup_uncharge()
>> is followed by mod_objcg_state()/mod_memcg_state(). Each of these
>> function call goes through a separate irq_save/irq_restore cycle. That
>> is inefficient.  Introduce a new function obj_cgroup_uncharge_mod_state()
>> that combines them with a single irq_save/irq_restore cycle.
>>
>> @@ -3292,6 +3296,25 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
>>   	refill_obj_stock(objcg, size);
>>   }
>>   
>> +void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
>> +				   struct pglist_data *pgdat, int idx)
> The optimization makes sense.
>
> But please don't combine independent operations like this into a
> single function. It makes for an unclear parameter list, it's a pain
> in the behind to change the constituent operations later on, and it
> has a habit of attracting more random bools over time. E.g. what if
> the caller already has irqs disabled? What if it KNOWS that irqs are
> enabled and it could use local_irq_disable() instead of save?
>
> Just provide an __obj_cgroup_uncharge() that assumes irqs are
> disabled, combine with the existing __mod_memcg_lruvec_state(), and
> bubble the irq handling up to those callsites which know better.
>
That will also work. However, the reason I did that was because of patch 
5 in the series. I could put the get_obj_stock() and put_obj_stock() 
code in slab.h and allowed them to be used directly in various places, 
but hiding in one function is easier.

Anyway, I can change the patch if you think that is the right way.

Cheers,
Longman

