Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD07342DE0F
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhJNP0w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Oct 2021 11:26:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233194AbhJNP0v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Oct 2021 11:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634225086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HBGMhkW5l3xF58RlsWd4EAEKmLqaalQ7yZY4iWVTFTE=;
        b=ecMyc9DVFlslgYCtW0OWygnP2al5NxrKZ7JuMW88mBLIZp/eKKCEobPj9BuMHhncb+jBFj
        X9PfmBzn6bjJPVEMO3RPg+3dJclOCGJFT0Vhu0szqyfLP8McG3XNdhZEPgBthCWE9IAant
        dJALcDMR4FPhK+jKFRnXAcILTCgSoZQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-L28ATQ1DM_WjjeWrKCs_wA-1; Thu, 14 Oct 2021 11:24:45 -0400
X-MC-Unique: L28ATQ1DM_WjjeWrKCs_wA-1
Received: by mail-wr1-f69.google.com with SMTP id y12-20020a056000168c00b00160da4de2c7so4848445wrd.5
        for <cgroups@vger.kernel.org>; Thu, 14 Oct 2021 08:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=HBGMhkW5l3xF58RlsWd4EAEKmLqaalQ7yZY4iWVTFTE=;
        b=UG1DrTIlc/pzDi+mKwB4v7Eh8ojSdWJgiuMl966RnJoRR2bpn6bvP3xNGVGkViWQxu
         1tnxAXe9NNN1VCTqHZlLqDx6OW/L5G3jCYHP+xvRoyicyGB3OIFEFIqXelaf4uQJA63N
         pbLa0jDozzNMcGFHnzFRYIRgE0QdKm36GrpQt9/imbC0ohUs+XNOZHQ3P1gfuEhk6rKC
         Gtdk6q7yI5NICwB1aavwIRYFGTPdAV5+VR5athfIkOj0cHaVZawoeefsJmliJVb7EpOP
         pVupC0Okp7DUwJAU36CITUt5Yed0vXAV3zPx4tqmJ044FPwIhzfNWpHlFXVYbupTwdJj
         bu3g==
X-Gm-Message-State: AOAM530ub6HO4iXWH6RK2yUzLc0iARwt+vY4qaQKAhj3O9niqFk5rN+L
        iFyGKUbNLJ3Ny0jf/jahOmdJKzMv3UXFAHeiEOEfgHQU7rP43310qtDCkWRTzQ3wxphQc5W5lj3
        yamsGYtRJWKLKl2dlFg==
X-Received: by 2002:a05:600c:4f8b:: with SMTP id n11mr6387169wmq.54.1634225083145;
        Thu, 14 Oct 2021 08:24:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYP7fwAuhg8aaoUbBVxOQCwoZYB4gcFaYUWfrZsNY6fPstrdXmDGBHNtD9+emUpkCG1n2fEg==
X-Received: by 2002:a05:600c:4f8b:: with SMTP id n11mr6387148wmq.54.1634225082934;
        Thu, 14 Oct 2021 08:24:42 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c694e.dip0.t-ipconnect.de. [91.12.105.78])
        by smtp.gmail.com with ESMTPSA id v185sm8368508wme.35.2021.10.14.08.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:24:42 -0700 (PDT)
Message-ID: <84b44b45-217e-885a-c513-de266315888f@redhat.com>
Date:   Thu, 14 Oct 2021 17:24:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2] memcg: page_alloc: skip bulk allocator for
 __GFP_ACCOUNT
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211014151607.2171970-1-shakeelb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211014151607.2171970-1-shakeelb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 14.10.21 17:16, Shakeel Butt wrote:
> The commit 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in
> __vmalloc_area_node()") switched to bulk page allocator for order 0
> allocation backing vmalloc. However bulk page allocator does not support
> __GFP_ACCOUNT allocations and there are several users of
> kvmalloc(__GFP_ACCOUNT).
> 
> For now make __GFP_ACCOUNT allocations bypass bulk page allocator. In
> future if there is workload that can be significantly improved with the
> bulk page allocator with __GFP_ACCCOUNT support, we can revisit the
> decision.
> 
> Fixes: 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in __vmalloc_area_node()")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
> Changes since v1:
> - do fallback allocation instead of failure, suggested by Michal Hocko.
> - Added memcg_kmem_enabled() check, corrected by Vasily Averin
> 
>  mm/page_alloc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 668edb16446a..9ca871dc8602 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5230,6 +5230,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  	if (unlikely(page_array && nr_pages - nr_populated == 0))
>  		goto out;
>  
> +	/* Bulk allocator does not support memcg accounting. */
> +	if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT))
> +		goto failed;
> +
>  	/* Use the single page allocator for one page. */
>  	if (nr_pages - nr_populated == 1)
>  		goto failed;
> 

LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

