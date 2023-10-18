Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381077CDE46
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 16:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjJROGk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 10:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjJROGj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 10:06:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB39B83;
        Wed, 18 Oct 2023 07:06:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E1FC821B4A;
        Wed, 18 Oct 2023 14:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697637995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n7cipJ1KzMEqbXf8FrxdUTbjqT8NmWtc5T0d42gkoIA=;
        b=MKP6LPBzpl7H9LJsOUJnK/dlpeHQ3sglBkkK8B5u4vJsUf6htIxOjpWgm9GOzJkaNmt6+0
        d/Zy8NfSKw35TRKxdRMUOWMYy0cmGt+GYfVrHD9nby7PlEvWoyMjlITzqOfD6Buz6BqhSc
        F59XI1xKOE/s27nOiQVxGsssIgkB3a0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697637995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n7cipJ1KzMEqbXf8FrxdUTbjqT8NmWtc5T0d42gkoIA=;
        b=6YQaehS1CmnhTvvWdrL+nKU0I505CDnehbJPqLS4g0wCNYjoLhaZFHrYUqFwdqmPrytVS5
        Q3O6Tv2aS5Np0gDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B841213915;
        Wed, 18 Oct 2023 14:06:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7ihqLGvmL2UjTQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 18 Oct 2023 14:06:35 +0000
Message-ID: <802261a7-553d-348f-7dd4-109eac704727@suse.cz>
Date:   Wed, 18 Oct 2023 16:06:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/5] mm: kmem: make memcg keep a reference to the
 original objcg
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
 <20231016221900.4031141-4-roman.gushchin@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231016221900.4031141-4-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
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

On 10/17/23 00:18, Roman Gushchin wrote:
> Keep a reference to the original objcg object for the entire life
> of a memcg structure.
> 
> This allows to simplify the synchronization on the kernel memory
> allocation paths: pinning a (live) memcg will also pin the
> corresponding objcg.
> 
> The memory overhead of this change is minimal because object cgroups
> usually outlive their corresponding memory cgroups even without this
> change, so it's only an additional pointer per memcg.
> 
> Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Forgot to point out typo:

> ---
>  include/linux/memcontrol.h | 8 +++++++-
>  mm/memcontrol.c            | 5 +++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index ab94ad4597d0..277690af383d 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -299,7 +299,13 @@ struct mem_cgroup {
>  
>  #ifdef CONFIG_MEMCG_KMEM
>  	int kmemcg_id;
> -	struct obj_cgroup __rcu *objcg;
> +	/*
> +	 * memcg->objcg is wiped out as a part of the objcg repaprenting

						reparenting ^

> +	 * process. memcg->orig_objcg preserves a pointer (and a reference)
> +	 * to the original objcg until the end of live of memcg.
> +	 */
> +	struct obj_cgroup __rcu	*objcg;
> +	struct obj_cgroup	*orig_objcg;
>  	/* list of inherited objcgs, protected by objcg_lock */
>  	struct list_head objcg_list;
>  #endif
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0605e45bd4a2..d90cc19e4113 100644

