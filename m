Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A335694722
	for <lists+cgroups@lfdr.de>; Mon, 13 Feb 2023 14:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBMNec (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Feb 2023 08:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBMNec (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Feb 2023 08:34:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDAB269C;
        Mon, 13 Feb 2023 05:34:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A051C21867;
        Mon, 13 Feb 2023 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676295267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=saciHrBqwPQPzdodH5ZXO9iXT8uGZbs1hjAThfGOX/I=;
        b=BC6hazDDMXHKpRkZWsOSWgGkkhDysckN0BIGsh9eYVLoFwx8ieX8PHP6IdWYj4e7wjhhNy
        4gdwyIdrR3ibbBV1z8mYpZgnP+zyuHhminpQI4ngTo2vGnhBHFQ52LNFASsHh32AJgYZHh
        vYiYeH//eF3kJ8oB0Bkc47W5tRshTgo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CE0B1391B;
        Mon, 13 Feb 2023 13:34:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X1FAHGM86mMqZAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 13 Feb 2023 13:34:27 +0000
Date:   Mon, 13 Feb 2023 14:34:26 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] sched/isolation: Add cpu_is_isolated() API
Message-ID: <Y+o8Yndho4fpl3IS@dhcp22.suse.cz>
References: <20230203232409.163847-1-frederic@kernel.org>
 <20230203232409.163847-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203232409.163847-3-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 04-02-23 00:24:09, Frederic Weisbecker wrote:
> Provide this new API to check if a CPU has been isolated either through
> isolcpus= or nohz_full= kernel parameter.
> 
> It aims at avoiding kernel load deemed to be safely spared on CPUs
> running sensitive workload that can't bear any disturbance, such as
> pcp cache draining.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Is there any locking required? I do not think so as these should be
boot time configured AFAIR. From the discussion around this I have
understood that this might change in the future once cpusets gain a
better isolation support. Maybe this should be documented at this stage?

Thanks!

> ---
>  include/linux/sched/isolation.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index b645cc81fe01..088672f08469 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -53,4 +53,10 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
>  	return true;
>  }
>  
> +static inline bool cpu_is_isolated(int cpu)
> +{
> +	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> +		 !housekeeping_test_cpu(cpu, HK_TYPE_KERNEL_NOISE);
> +}
> +
>  #endif /* _LINUX_SCHED_ISOLATION_H */
> -- 
> 2.34.1

-- 
Michal Hocko
SUSE Labs
