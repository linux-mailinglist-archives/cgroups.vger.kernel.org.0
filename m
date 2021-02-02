Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE09130BBDE
	for <lists+cgroups@lfdr.de>; Tue,  2 Feb 2021 11:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhBBKNu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 05:13:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229683AbhBBKNk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 05:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612260733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OsWwN1vmOUR/or+/6FTZ3nC/QP7/0ejkOvTfj5/Q2X8=;
        b=bWg6uFp2BsSH3lgy/WA7A0Ys4rIQlNf9p4yD4cCHqzMMG6Btg48J3VwhWvVfBvrc4RKrBP
        geLx3tXiUkBYbYxAzLc5c9DfvHVqMVTrC6xw3joYsfUAcTpV2z4vSr4mD906+tkcP1HC/d
        9L70KLtHz1MQHpRYjSTiCBaYxstsYE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-gAjdoTMpNUiOWLlQcPTlBw-1; Tue, 02 Feb 2021 05:12:09 -0500
X-MC-Unique: gAjdoTMpNUiOWLlQcPTlBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8B431005513;
        Tue,  2 Feb 2021 10:12:07 +0000 (UTC)
Received: from [10.36.114.148] (ovpn-114-148.ams2.redhat.com [10.36.114.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02E2B10016FB;
        Tue,  2 Feb 2021 10:12:05 +0000 (UTC)
Subject: Re: [PATCH] mm/memcontrol: remove redundant NULL check
To:     Yang Li <abaci-bugfix@linux.alibaba.com>, hannes@cmpxchg.org
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1611216029-34397-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <187faa43-dc1c-d0a9-769c-b8d99b954c32@redhat.com>
Date:   Tue, 2 Feb 2021 11:12:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1611216029-34397-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 21.01.21 09:00, Yang Li wrote:
> Fix below warnings reported by coccicheck:
> ./mm/memcontrol.c:451:3-9: WARNING: NULL check before some freeing
> functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
> ---
>   mm/memcontrol.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 605f671..f6a561b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -447,8 +447,7 @@ static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
>   	for_each_node(nid) {
>   		pn = mem_cgroup_nodeinfo(memcg, nid);
>   		map = rcu_dereference_protected(pn->shrinker_map, true);
> -		if (map)
> -			kvfree(map);
> +		kvfree(map);
>   		rcu_assign_pointer(pn->shrinker_map, NULL);
>   	}
>   }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

