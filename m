Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5F32EA97B
	for <lists+cgroups@lfdr.de>; Tue,  5 Jan 2021 12:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbhAELEx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jan 2021 06:04:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729368AbhAELEw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jan 2021 06:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609844606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2AWR0WkhRJ4TUcyCLZNXdv1ehusPcAteLrZxeB8wrTE=;
        b=EBAkIHu842/nTr2LUrnMZNzip7KWhG2f+BaA4p3ag4AN92iRz9BHml2IG9qHSQcjx7LyG9
        dmSPSXY5MaYmtKPVslIn/99lKc/8NeYXgtwX1cRG8ZJ3IRXqJSaVq40gxmiaa2mMDXHPWk
        2NwVtsK17JlapChpuQUcV1fRAjyMu9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-QO0eIFieP7eVR2Wi7vfZCA-1; Tue, 05 Jan 2021 06:03:22 -0500
X-MC-Unique: QO0eIFieP7eVR2Wi7vfZCA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7D5A190A7A0;
        Tue,  5 Jan 2021 11:03:20 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0CE27048C;
        Tue,  5 Jan 2021 11:03:18 +0000 (UTC)
Subject: Re: [PATCH] mm: fix: Uninitialized variable ret.
To:     YANG LI <abaci-bugfix@linux.alibaba.com>, hannes@cmpxchg.org
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1609311551-97108-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1d9b6d7c-097d-d6c3-82e5-a46077f3ce44@redhat.com>
Date:   Tue, 5 Jan 2021 12:03:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1609311551-97108-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 30.12.20 07:59, YANG LI wrote:
> The ret is being used but it isn't being initialized,
> need to assign a value to it, like 0.
> 
> Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
> Reported-by: Abaci <abaci@linux.alibaba.com>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 605f671..15ba17d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3366,7 +3366,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
>  {
>  	bool enlarge = false;
>  	bool drained = false;
> -	int ret;
> +	int ret = 0;
>  	bool limits_invariant;
>  	struct page_counter *counter = memsw ? &memcg->memsw : &memcg->memory;
>  
> 

Before every "break" in the loop, we have a "ret = ". The loop runs at
least once.

Either I am missing something important, or that patch claims something
that does not hold - at least upstream.

-- 
Thanks,

David / dhildenb

