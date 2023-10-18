Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950767CDFE7
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbjJROdC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 10:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345343AbjJROcu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 10:32:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E243D24F18;
        Wed, 18 Oct 2023 07:23:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5BA011F383;
        Wed, 18 Oct 2023 14:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697638995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2IvKfrgI6kIvXjlAq5Aks0oGwA1m42o1gRc23nO1fAE=;
        b=xVtsU/1Ua8x38vrciCf3fXDEoneDqknKaF6UtsI4cf1gEaJdvYDYXXgTUpsauQMzm16yDI
        1C3HD0cKmNlo7fh0Q75XeVwMiPX3svsfn0Wf2C6f0btGo9E0CwRoXMbt45P3Lz6NtIAXWV
        7QoB4XVaj8hxs2de2til1uzYHStFLhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697638995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2IvKfrgI6kIvXjlAq5Aks0oGwA1m42o1gRc23nO1fAE=;
        b=ihRWtvfV5N2TdE/ymRmqxIkhdyZY8+l0Y4jDOViTCkSq/7LFvebhKgVimkOzXuqdSHJTLu
        pIpLC59qeE8O7sAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25E3213915;
        Wed, 18 Oct 2023 14:23:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NkKKCFPqL2UfVgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 18 Oct 2023 14:23:15 +0000
Message-ID: <3b723bf1-830e-7f47-27ce-98f7808fbc4b@suse.cz>
Date:   Wed, 18 Oct 2023 16:23:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 5/5] percpu: scoped objcg protection
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, shakeelb@google.com,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20231016221900.4031141-1-roman.gushchin@linux.dev>
 <20231016221900.4031141-6-roman.gushchin@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231016221900.4031141-6-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.57
X-Spamd-Result: default: False [-2.57 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_SPAM(1.53)[86.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[11];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/17/23 00:19, Roman Gushchin wrote:
> Similar to slab and kmem, switch to a scope-based protection of the
> objcg pointer to avoid.
> 
> Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Do you plan to convert also the bpf users of get_obj_cgroup_from_current()
so it could be removed?

Thanks!

> ---
>  mm/percpu.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index a7665de8485f..f53ba692d67a 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1628,14 +1628,12 @@ static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
>  	if (!memcg_kmem_online() || !(gfp & __GFP_ACCOUNT))
>  		return true;
>  
> -	objcg = get_obj_cgroup_from_current();
> +	objcg = current_obj_cgroup();
>  	if (!objcg)
>  		return true;
>  
> -	if (obj_cgroup_charge(objcg, gfp, pcpu_obj_full_size(size))) {
> -		obj_cgroup_put(objcg);
> +	if (obj_cgroup_charge(objcg, gfp, pcpu_obj_full_size(size)))
>  		return false;
> -	}
>  
>  	*objcgp = objcg;
>  	return true;
> @@ -1649,6 +1647,7 @@ static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
>  		return;
>  
>  	if (likely(chunk && chunk->obj_cgroups)) {
> +		obj_cgroup_get(objcg);
>  		chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = objcg;
>  
>  		rcu_read_lock();
> @@ -1657,7 +1656,6 @@ static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
>  		rcu_read_unlock();
>  	} else {
>  		obj_cgroup_uncharge(objcg, pcpu_obj_full_size(size));
> -		obj_cgroup_put(objcg);
>  	}
>  }
>  

