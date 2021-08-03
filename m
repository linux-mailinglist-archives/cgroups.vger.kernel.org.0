Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A6A3DF145
	for <lists+cgroups@lfdr.de>; Tue,  3 Aug 2021 17:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbhHCPUy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Aug 2021 11:20:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33076 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbhHCPUx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Aug 2021 11:20:53 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3AADC200E1;
        Tue,  3 Aug 2021 15:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628004041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ersUyOxiWFVo1kZan9calBKiFWyiEpXiBiaAlyP0RUk=;
        b=QQKupwhLEkgmEnJJYUoCR2y56AeRN1vJHq7a+JYfpBxspF6+tdBBHJ1PU/5vxtoYDVQb/h
        G22A9nYpesaAojCZwymzFeK+7epUmG6+jdfB5Bg6oOq3Pv5RTh0LlgHdlKBk5rc1sxYMEP
        s9KBxaft90NRdh31hjGXtYPcf02PCBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628004041;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ersUyOxiWFVo1kZan9calBKiFWyiEpXiBiaAlyP0RUk=;
        b=Q2d1r4HmCHf/1RhdxXRthGFYySUD/PbxzwbcLE2qK1ZXy8aeFFycQFy3r0HhgmpChEgwkP
        mjzibAym07HUe7Ag==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1516113B68;
        Tue,  3 Aug 2021 15:20:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id C7/hA8leCWEEdgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 03 Aug 2021 15:20:41 +0000
Subject: Re: [PATCH] mm: memcontrol: Set the correct memcg swappiness
 restriction
To:     Michal Hocko <mhocko@suse.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <d77469b90c45c49953ccbc51e54a1d465bc18f70.1627626255.git.baolin.wang@linux.alibaba.com>
 <YQOekWWgtZUfim4M@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <6e6570d2-44a2-1da1-6c2a-38766786c40c@suse.cz>
Date:   Tue, 3 Aug 2021 17:20:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQOekWWgtZUfim4M@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/30/21 8:39 AM, Michal Hocko wrote:
> On Fri 30-07-21 14:26:35, Baolin Wang wrote:
>> Since commit c843966c556d ("mm: allow swappiness that prefers reclaiming
>> anon over the file workingset") has expended the swappiness value to
>> make swap to be preferred in some systems. We should also change the
>> memcg swappiness restriction to allow memcg swap-preferred.
>> 
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Yes, this looks like an omission. It doesn't really make sense to have
> two different constrains on the value.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

So, also Fixes: c843966c556d ("mm: allow swappiness that prefers reclaiming anon
over the file workingset")
?

> Thanks!
> 
>> ---
>>  mm/memcontrol.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 6580c23..988fc94 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -4046,7 +4046,7 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
>>  {
>>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>>  
>> -	if (val > 100)
>> +	if (val > 200)
>>  		return -EINVAL;
>>  
>>  	if (!mem_cgroup_is_root(memcg))
>> -- 
>> 1.8.3.1
> 

