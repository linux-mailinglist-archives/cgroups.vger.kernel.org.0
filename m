Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8935A5B2B13
	for <lists+cgroups@lfdr.de>; Fri,  9 Sep 2022 02:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIIAXL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Sep 2022 20:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIIAXJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Sep 2022 20:23:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AD689822;
        Thu,  8 Sep 2022 17:23:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8F3071F88C;
        Fri,  9 Sep 2022 00:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662682984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RUcUYAJZGU901kXStidccK27lsK7j2zOm94hwmU7LWc=;
        b=p3QIvpvvl1+OlHebZtJU5545iMnFcY++IJbcSYaNlcbllQWhTrKccHI+ZKQu1Ppix3rQsk
        78KYNcOprAr6pSy/mMr57cubhvkeX0n6mcs8iwaIN/7DOBLF73HQEwlRHVr5dm3vMsV/zo
        FlmTC47AB1hzLgp6jz/TBPL5aSIfWqc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56B4013A93;
        Fri,  9 Sep 2022 00:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LgceFGiHGmOvLwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 09 Sep 2022 00:23:04 +0000
Date:   Fri, 9 Sep 2022 02:23:02 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] memcg: reduce size of memcg vmstats structures
Message-ID: <YxqHZtOx2+LUYZth@blackbook>
References: <20220907043537.3457014-1-shakeelb@google.com>
 <20220907043537.3457014-4-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907043537.3457014-4-shakeelb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello.

On Wed, Sep 07, 2022 at 04:35:37AM +0000, Shakeel Butt <shakeelb@google.com> wrote:
>  /* Subset of vm_event_item to report for memcg event stats */
>  static const unsigned int memcg_vm_event_stat[] = {
> +	PGPGIN,
> +	PGPGOUT,
>  	PGSCAN_KSWAPD,
>  	PGSCAN_DIRECT,
>  	PGSTEAL_KSWAPD,

What about adding a dummy entry at the beginning like:

 static const unsigned int memcg_vm_event_stat[] = {
+	NR_VM_EVENT_ITEMS,
+	PGPGIN,
+	PGPGOUT,
 	PGSCAN_KSWAPD,
 	PGSCAN_DIRECT,


> @@ -692,14 +694,30 @@ static const unsigned int memcg_vm_event_stat[] = {
>  #endif
>  };
>  
> +#define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
> +static int mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
> +
> +static void init_memcg_events(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < NR_MEMCG_EVENTS; ++i)
> +		mem_cgroup_events_index[memcg_vm_event_stat[i]] = i + 1;

Start such loops from i = 1, save i to the table.

> +}
> +
> +static inline int memcg_events_index(enum vm_event_item idx)
> +{
> +	return mem_cgroup_events_index[idx] - 1;
> +}

And the there'd be no need for the reverse transforms -1.

I.e. it might be just a negligible micro-optimization but since the
event updates are on some fast (albeit longer) paths, it may be worth
sacrificing one of the saved 8Bs in favor of no arithmetics.

What do you think about this?

>  static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
>  {
> -	return READ_ONCE(memcg->vmstats->events[event]);
> +	int index = memcg_events_index(event);
> +
> +	if (index < 0)
> +		return 0;

As a bonus these undefined maps could use the zero at the dummy location
without branch (slow paths though).


> @@ -5477,7 +5511,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>  			parent->vmstats->state_pending[i] += delta;
>  	}
>  
> -	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
> +	for (i = 0; i < NR_MEMCG_EVENTS; i++) {

I applaud this part :-)


Michal
