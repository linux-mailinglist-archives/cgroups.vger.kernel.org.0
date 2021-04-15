Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FAC361140
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 19:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhDORlf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 13:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233134AbhDORlf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 13:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618508471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTimRIr0YgBuVLpWvKPM6c0MAPH0f+KQspjahIIUAlU=;
        b=cPDV7WzTQ9rHwfUAQ/ac8bvWdvjyTkXGWriMaF++nEkSbJ+qL0n8Miec9j2pcwCP3jD+sH
        R6TckrEa6JX8ZyygS7AnxLHcSdnNw7s2A6J/GQ6S4KME/FKCJ9tWSLOBsC0ts8eb/9IbGh
        oJuCPBuWTEs8RtOWTWoY/1i4yja7kqQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-uNheTPq4MAC1PwXFQ_7jcg-1; Thu, 15 Apr 2021 13:41:10 -0400
X-MC-Unique: uNheTPq4MAC1PwXFQ_7jcg-1
Received: by mail-qt1-f198.google.com with SMTP id j10-20020a05622a038ab029019f472c0820so4500376qtx.10
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 10:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wTimRIr0YgBuVLpWvKPM6c0MAPH0f+KQspjahIIUAlU=;
        b=XYmnz9Q65O4xiOy1O9V2DqXfe1LQpx6a+5aDtNf94a6OzsuW/+kPJVsKpats9up5xZ
         zUinLE39jbaTCTaQ3JTgdjsZtOiIsrCfQ84w2GjMl6DZSwUXhlIoOD0fO6au+USV4aGP
         jnQpoZkZlmOSiLASLh7+0rUZV/QUkd5nzddvchdZnIeC3+ti387f/rhSaPRQiapK06Gg
         ltjZQW3FbRAd0EdzC39Ov5XwuUnfbHOD3gHGgQtjq/N9TRtrY+zBGWImMTFnFgH13KUw
         /XPsdQVLVAeKyy7I6izqqAMeemNiaiMhNUL7bW63Zr+CRISh4nzG28yECDX1VecYw41M
         MfpA==
X-Gm-Message-State: AOAM532V7dLuvvsd3KG4p9D65VZD7+w2ZEnBa8iE/GwSZlIl3Un5fHo7
        QkNlTY4VCJsBLP8DAiQKMo3cvdoMI7Jz9NrXd4C3A6BnegMSz8PVloFeGPo9k/oGkN8T66+yGbg
        T5VbR4Wk/VFqXLtQESQ==
X-Received: by 2002:a37:7c5:: with SMTP id 188mr4791839qkh.348.1618508469967;
        Thu, 15 Apr 2021 10:41:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmgbFnszT76GybNyzgAt7zTaWK3t49+b+KRVvGIM0rKdDofO0Sm6ySwTeX6EQ7djs0OMFxww==
X-Received: by 2002:a37:7c5:: with SMTP id 188mr4791794qkh.348.1618508469626;
        Thu, 15 Apr 2021 10:41:09 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id x18sm2247420qtj.58.2021.04.15.10.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 10:41:09 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 0/5] mm/memcg: Reduce kmemcache memory accounting
 overhead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
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
 <20210415171035.GB2531743@casper.infradead.org>
Message-ID: <15cf3cfa-c221-9e84-9f5b-80082207efd3@redhat.com>
Date:   Thu, 15 Apr 2021 13:41:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210415171035.GB2531743@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/15/21 1:10 PM, Matthew Wilcox wrote:
> On Tue, Apr 13, 2021 at 09:20:22PM -0400, Waiman Long wrote:
>> With memory accounting disable, the run time was 2.848s. With memory
>> accounting enabled, the run times with the application of various
>> patches in the patchset were:
>>
>>    Applied patches   Run time   Accounting overhead   Overhead %age
>>    ---------------   --------   -------------------   -------------
>>         None          10.800s         7.952s              100.0%
>>          1-2           9.140s         6.292s               79.1%
>>          1-3           7.641s         4.793s               60.3%
>>          1-5           6.801s         3.953s               49.7%
> I think this is a misleading way to report the overhead.  I would have said:
>
> 			10.800s		7.952s		279.2%
> 			 9.140s		6.292s		220.9%
> 			 7.641s		4.793s		168.3%
> 			 6.801s		3.953s		138.8%
>
What I want to emphasize is the reduction in the accounting overhead 
part of execution time. Your percentage used the accounting disable time 
as the denominator. I think both are valid, I will be more clear about 
that in my version of the patch.

Thanks,
Longman

