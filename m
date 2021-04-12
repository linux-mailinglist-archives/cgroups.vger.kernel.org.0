Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BAB35D18D
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 21:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245437AbhDLT7L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 15:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245412AbhDLT7L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 15:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618257532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ehM6Hadf4JLUdNm4RfG2SBXxOzb5EYXQTf0escn85tQ=;
        b=FQLmHp9NRV08fCW5MDOhsZ/mClHXI7qOe2HQupmfkfstS8vXCsie9Q8rBuklClUoD4Vjvn
        PB9fOoJCE8ZuPJk0kPVBV/wU8NmAyhBrH1RSLuOl6GWH+RIYfzuwLXTglHSl7ACTRfwEtz
        nZC3GjGbCCyv0MwABJIBkH+8Oe8sadk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-mHRiwGJuNrClB4MC8LpsxQ-1; Mon, 12 Apr 2021 15:58:50 -0400
X-MC-Unique: mHRiwGJuNrClB4MC8LpsxQ-1
Received: by mail-qk1-f198.google.com with SMTP id h21so9732144qkl.12
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 12:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ehM6Hadf4JLUdNm4RfG2SBXxOzb5EYXQTf0escn85tQ=;
        b=HYDR1RRBxgZR190HQvB4qr5yFm/Ed8xczVFXXEaHC75WPEaV678V0zwQV/TS3R+mqw
         JF/hOUMWF1VAp9vEmenzf47XC6H8uEftII/1/Q8MwxJ70x4bzJZ9fQvWZ+mnbO2hUWvS
         G3LjTnbdHb7s6wnzNFjGZ5qjgyUJVAWUxrJ1MMdxdkomIGHTQVpaX8wpf0VsoK/R2iAT
         L6SDjlpJfna/TI1zdB6AUhUXfThoRk1sTQkOeyoTmI9UchWPa5ZYBR1HArxHrCOiK/hY
         3EvuJGxbuuYDHnF/Y+W7M7CMJ+/OeWOfTyQlGbrIbgQ007EEBq3aODZhdPLBA+utZQl0
         IY0w==
X-Gm-Message-State: AOAM530kY1vt8yqrEztfmYrh6fPMfxya117Zsz3oepID6nE/0Vf9E7Zo
        sb1M7AgTmIwBR2lk6CUyOjbXMS4NK+HL1tCCLZNO/cgvVFzPwvzK3s9cyHxEr3+d3oCYBLi1cHK
        gxRhK7ojx5dS1qb2oPQ==
X-Received: by 2002:ae9:e113:: with SMTP id g19mr27687894qkm.480.1618257530278;
        Mon, 12 Apr 2021 12:58:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyy3YDvoLfNsTaNiMkidhnzNRynhxxwDgzSLooH0YRQviUJityR8hXjC/cQUBoC0G0T80xDvg==
X-Received: by 2002:ae9:e113:: with SMTP id g19mr27687881qkm.480.1618257530098;
        Mon, 12 Apr 2021 12:58:50 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id f9sm8594541qkk.115.2021.04.12.12.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 12:58:49 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 5/5] mm/memcg: Optimize user context object stock access
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
References: <20210409231842.8840-1-longman@redhat.com>
 <20210409231842.8840-6-longman@redhat.com>
 <YHSXvQVvzHu26u7H@carbon.dhcp.thefacebook.com>
Message-ID: <49c03fb0-be46-5288-2c4c-6ad5ad194b4c@redhat.com>
Date:   Mon, 12 Apr 2021 15:58:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHSXvQVvzHu26u7H@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/12/21 2:55 PM, Roman Gushchin wrote:
> On Fri, Apr 09, 2021 at 07:18:42PM -0400, Waiman Long wrote:
>> Most kmem_cache_alloc() calls are from user context. With instrumentation
>> enabled, the measured amount of kmem_cache_alloc() calls from non-task
>> context was about 0.01% of the total.
>>
>> The irq disable/enable sequence used in this case to access content
>> from object stock is slow.  To optimize for user context access, there
>> are now two object stocks for task context and interrupt context access
>> respectively.
>>
>> The task context object stock can be accessed after disabling preemption
>> which is cheap in non-preempt kernel. The interrupt context object stock
>> can only be accessed after disabling interrupt. User context code can
>> access interrupt object stock, but not vice versa.
>>
>> The mod_objcg_state() function is also modified to make sure that memcg
>> and lruvec stat updates are done with interrupted disabled.
>>
>> The downside of this change is that there are more data stored in local
>> object stocks and not reflected in the charge counter and the vmstat
>> arrays.  However, this is a small price to pay for better performance.
> I agree, the extra memory space is not a significant concern.
> I'd be more worried about the code complexity, but the result looks
> nice to me!
>
> Acked-by: Roman Gushchin <guro@fb.com>
>
> Btw, it seems that the mm tree ran a bit off, so I had to apply this series
> on top of Linus's tree to review. Please, rebase.

This patchset is based on the code in Linus' tree. I had applied the 
patchset to linux-next to see if there was any conflicts. Two of the 
patches had minor fuzzes around the edge but no actual merge conflict 
for now.

Cheers,
Longman


