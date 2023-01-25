Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB7267ABD9
	for <lists+cgroups@lfdr.de>; Wed, 25 Jan 2023 09:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjAYIeS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Jan 2023 03:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjAYIeK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Jan 2023 03:34:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975C6F6;
        Wed, 25 Jan 2023 00:33:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F26DF21F43;
        Wed, 25 Jan 2023 08:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674635630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E4rgGfWEon8mTJ3xQufUQx0PpIsnYpjp+SuGeR3ihNs=;
        b=nXei/ipLqEit9F4UME6bDn4D9KuCh4bbgFHAmK08auHOmzF/T17spkqIBC1wJ6MQznsFRL
        7WyZHH6mvlTVh5118YdfhDMWoJhUcbSuL3NzuyhsAcudR18NhCbfuhGq+kn4f1vPn6+fFi
        8cTLmCn9i8Gk0LpdQIuK4T1g8O8fC4U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D49711339E;
        Wed, 25 Jan 2023 08:33:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v0DWMG3p0GPYegAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 25 Jan 2023 08:33:49 +0000
Date:   Wed, 25 Jan 2023 09:33:49 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125073502.743446-1-leobras@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 25-01-23 04:34:57, Leonardo Bras wrote:
> Disclaimer:
> a - The cover letter got bigger than expected, so I had to split it in
>     sections to better organize myself. I am not very confortable with it.
> b - Performance numbers below did not include patch 5/5 (Remove flags
>     from memcg_stock_pcp), which could further improve performance for
>     drain_all_stock(), but I could only notice the optimization at the
>     last minute.
> 
> 
> 0 - Motivation:
> On current codebase, when drain_all_stock() is ran, it will schedule a
> drain_local_stock() for each cpu that has a percpu stock associated with a
> descendant of a given root_memcg.
> 
> This happens even on 'isolated cpus', a feature commonly used on workloads that
> are sensitive to interruption and context switching such as vRAN and Industrial
> Control Systems.
> 
> Since this scheduling behavior is a problem to those workloads, the proposal is
> to replace the current local_lock + schedule_work_on() solution with a per-cpu
> spinlock.

If IIRC we have also discussed that isolated CPUs can simply opt out
from the pcp caching and therefore the problem would be avoided
altogether without changes to the locking scheme. I do not see anything
regarding that in this submission. Could you elaborate why you have
abandoned this option?
-- 
Michal Hocko
SUSE Labs
