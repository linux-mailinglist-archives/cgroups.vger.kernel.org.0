Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5858368055
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 14:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhDVM0t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 08:26:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38248 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235875AbhDVM0s (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 08:26:48 -0400
Received: from zn.tnic (p200300ec2f0e290092fd64de2d075acb.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:2900:92fd:64de:2d07:5acb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4356F1EC047F;
        Thu, 22 Apr 2021 14:26:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619094373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JglfRayovDMQVqeriuhpOiFo+lgNzm5LhdlgTwXaVhI=;
        b=iIzRUDXhTEsdbaT+50GL0ZwpdhkmyvwZTeDFdVYRTpQRo4I5Bg33C8DLrM4Btfc0GUZ4RY
        ZdZK3mbji5oBIvjKWBEaWzu8XRZw1HAAQ/rDVsI8yn4DLbeEX3FBp7yyjiW1J8p0K1E/w5
        zA/JuqORz8avyv50hKaReb6Tdydg6ls=
Date:   Thu, 22 Apr 2021 14:26:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 16/16] memcg: enable accounting for ldt_struct objects
Message-ID: <20210422122615.GA7021@zn.tnic>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
 <94dd36cb-3abb-53fc-0f23-26c02094ddf4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94dd36cb-3abb-53fc-0f23-26c02094ddf4@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 22, 2021 at 01:38:01PM +0300, Vasily Averin wrote:

You have forgotten to Cc LKML on your submission.

> Each task can request own LDT and force the kernel to allocate up to
> 64Kb memory per-mm.
> 
> There are legitimate workloads with hundreds of processes and there
> can be hundreds of workloads running on large machines.
> The unaccounted memory can cause isolation issues between the workloads
> particularly on highly utilized machines.
> 
> It makes sense to account for this objects to restrict the host's memory
> consumption from inside the memcg-limited container.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  arch/x86/kernel/ldt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
> index aa15132..a1889a0 100644
> --- a/arch/x86/kernel/ldt.c
> +++ b/arch/x86/kernel/ldt.c
> @@ -154,7 +154,7 @@ static struct ldt_struct *alloc_ldt_struct(unsigned int num_entries)
>  	if (num_entries > LDT_ENTRIES)
>  		return NULL;
>  
> -	new_ldt = kmalloc(sizeof(struct ldt_struct), GFP_KERNEL);
> +	new_ldt = kmalloc(sizeof(struct ldt_struct), GFP_KERNEL_ACCOUNT);
>  	if (!new_ldt)
>  		return NULL;
>  
> @@ -168,9 +168,10 @@ static struct ldt_struct *alloc_ldt_struct(unsigned int num_entries)
>  	 * than PAGE_SIZE.
>  	 */
>  	if (alloc_size > PAGE_SIZE)
> -		new_ldt->entries = vzalloc(alloc_size);
> +		new_ldt->entries = __vmalloc(alloc_size,
> +					     GFP_KERNEL_ACCOUNT | __GFP_ZERO);

You don't have to break that line - just let it stick out.

>  	else
> -		new_ldt->entries = (void *)get_zeroed_page(GFP_KERNEL);
> +		new_ldt->entries = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
>  
>  	if (!new_ldt->entries) {
>  		kfree(new_ldt);
> -- 

In any case:

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
