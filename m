Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D43426A16
	for <lists+cgroups@lfdr.de>; Fri,  8 Oct 2021 13:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243032AbhJHLtZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Oct 2021 07:49:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39580 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243771AbhJHLtP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Oct 2021 07:49:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6A0E320120;
        Fri,  8 Oct 2021 11:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633693621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YoxW4EUonCWf2lBt5f9S3iKvB1ejzJVPxoUC2rO4AkI=;
        b=1ZcyaUI9xL0W6i8yX8fh3JwbqEunlXFB9R5Hp4A3vr8ms486M4COzbyQRsWP+KlLwyB6dh
        dGaXSFSFDN4d5nEVPhN+r4zSGmKnNwJv+aM9LS/ZyZArn593oBkmU1FM8LbR8KuVBUobD1
        yNeUmEVBsrzS2avT2ueUr8fTq1gAZDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633693621;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YoxW4EUonCWf2lBt5f9S3iKvB1ejzJVPxoUC2rO4AkI=;
        b=97hilA7zf9D+z7paBomgPpHZSwUGYILNLuMasBPsLrjC2yAu9fTQr3pifWwzZtN5UvLFl5
        +se0dSDU+VEB5VBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36BDC13EC3;
        Fri,  8 Oct 2021 11:47:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PXuXCrUvYGE2QAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 08 Oct 2021 11:47:01 +0000
Message-ID: <29155011-f884-b0e5-218e-911039568acb@suse.cz>
Date:   Fri, 8 Oct 2021 13:47:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH memcg] mm/page_alloc.c: avoid statistic update with 0
Content-Language: en-US
To:     Vasily Averin <vvs@virtuozzo.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>
References: <b2371951-bb8a-e62e-8d33-10830bbf6275@virtuozzo.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <b2371951-bb8a-e62e-8d33-10830bbf6275@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/8/21 11:24, Vasily Averin wrote:
> __alloc_pages_bulk can call __count_zid_vm_events and zone_statistics
> with nr_account = 0.

But that's not a bug, right? Just an effective no-op that's not commonly
happening, so is it worth the check?

> Fixes: 3e23060b2d0b ("mm/page_alloc: batch the accounting updates in the bulk allocator")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  mm/page_alloc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 602819a232e5..e67113452ee8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5364,9 +5364,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  	}
>  
>  	local_unlock_irqrestore(&pagesets.lock, flags);
> -
> -	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
> -	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
> +	if (nr_account) {
> +		__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
> +		zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
> +	}
>  	if (objcg)
>  		memcg_bulk_post_charge_hook(objcg, nr_pre_charge - nr_account);
>  
> 

