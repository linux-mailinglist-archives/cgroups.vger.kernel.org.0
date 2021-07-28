Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7C33D89A7
	for <lists+cgroups@lfdr.de>; Wed, 28 Jul 2021 10:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhG1IVY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Jul 2021 04:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234510AbhG1IVX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Jul 2021 04:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627460482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gWJqZpysylhm0r71/CN5q60nzTxNxEk/7whHXN4TyA=;
        b=fiF/vVqd9oN9e8dKNjUyYg0xm31UqV7R5Oqq9jjFaG7gd1TWS3PesPtjH8OueLizybbAk1
        VklP1xeyESVL10k13r9S5dx/Xo6Bk/DIa+Eh2T4JpCn36EWukF4X4xJdq/0ppKCcGi5Dns
        hpCvByTiWRFA1ki7zCT2xYF9p1MBy00=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-6QfjtdHEOu6iKaxRqxv5AQ-1; Wed, 28 Jul 2021 04:21:21 -0400
X-MC-Unique: 6QfjtdHEOu6iKaxRqxv5AQ-1
Received: by mail-wr1-f70.google.com with SMTP id v18-20020adfe2920000b029013bbfb19640so618273wri.17
        for <cgroups@vger.kernel.org>; Wed, 28 Jul 2021 01:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6gWJqZpysylhm0r71/CN5q60nzTxNxEk/7whHXN4TyA=;
        b=RA2tB8ZpOWFyYPbRF9RjQs1tELUvOApNHpCu4g0xt2XY5gMPNV2BEBlpSq3AEFdSUP
         agI33w0uCyR0PG7yF78eRy/rpRN6jabCXH8BgrTC6H57AG/LsHfgpcBL0iNBB75XUt9d
         U+5AkeRxbpeW1AnpAwgh7vDEtaquKmGfBb3Ch+fSEVz99AuhoY5ImhiA8IN+Hh8lO+Qs
         8Iz846L57iKh34LJ6uHcCWpbHS+/p1nWCjRer0RQzG/5zXB0gPnThjB3z6fV7kLRF9vF
         8Q5XTv3iRATREMWFudVgdg3VgK0AmYKwsxHsZ/hIMBXrASwgsO8VfCcC2SyOWKX/uv3L
         y7Iw==
X-Gm-Message-State: AOAM533b/YsjxJE6vfWQdOXvJihULaIki/xmuvHiacXlZC89uYRReTpc
        sx4skzz0S8/IGzsOdzZoV/ZW9ao4cCX/1XP5iuHEP1SGE4ld8WYcSiDGQ5stuJ5GpUITmnrcNO8
        VJo6QX+5k1Ykrr6wfeg==
X-Received: by 2002:a05:600c:2210:: with SMTP id z16mr1463173wml.92.1627460479813;
        Wed, 28 Jul 2021 01:21:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywozPvYuAuinyeJcKYXHRgjRzubPJmW42EHxOhWmI72/fa0axCzQ3ARxBmOyn7dHEFAcgp9g==
X-Received: by 2002:a05:600c:2210:: with SMTP id z16mr1463157wml.92.1627460479606;
        Wed, 28 Jul 2021 01:21:19 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id z2sm5312534wma.45.2021.07.28.01.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 01:21:19 -0700 (PDT)
Subject: Re: [PATCH] memcg: cleanup racy sum avoidance code
To:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210728012243.3369123-1-shakeelb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8c35e469-b355-63b0-6cd4-ca39c39ddb79@redhat.com>
Date:   Wed, 28 Jul 2021 10:21:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728012243.3369123-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 28.07.21 03:22, Shakeel Butt wrote:
> We used to have per-cpu memcg and lruvec stats and the readers have to
> traverse and sum the stats from each cpu. This summing was racy and may
> expose transient negative values. So, an explicit check was added to
> avoid such scenarios. Now these stats are moved to rstat infrastructure
> and are no more per-cpu, so we can remove the fixup for transient
> negative values.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>   include/linux/memcontrol.h | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7028d8e4a3d7..5f2a39a43d47 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -991,30 +991,19 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
>   
>   static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
>   {
> -	long x = READ_ONCE(memcg->vmstats.state[idx]);
> -#ifdef CONFIG_SMP
> -	if (x < 0)
> -		x = 0;
> -#endif
> -	return x;
> +	return READ_ONCE(memcg->vmstats.state[idx]);
>   }
>   
>   static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
>   					      enum node_stat_item idx)
>   {
>   	struct mem_cgroup_per_node *pn;
> -	long x;
>   
>   	if (mem_cgroup_disabled())
>   		return node_page_state(lruvec_pgdat(lruvec), idx);
>   
>   	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -	x = READ_ONCE(pn->lruvec_stats.state[idx]);
> -#ifdef CONFIG_SMP
> -	if (x < 0)
> -		x = 0;
> -#endif
> -	return x;
> +	return READ_ONCE(pn->lruvec_stats.state[idx]);
>   }
>   
>   static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

