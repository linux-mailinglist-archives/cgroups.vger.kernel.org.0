Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E506B104F
	for <lists+cgroups@lfdr.de>; Wed,  8 Mar 2023 18:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCHRlB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Mar 2023 12:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCHRkq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Mar 2023 12:40:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E69C78EE;
        Wed,  8 Mar 2023 09:40:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6C76D1F38A;
        Wed,  8 Mar 2023 17:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678297210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D9P/n6kZ5Q42EKXa8PVA9CYX9cXV/BCKYA1HMGowUvU=;
        b=TajgrPEobbOD2m/LLJL6XBEDwW6tdq+0QP5iqSO+RuA2fAwvLYQ7gx7qQdHzR8kp+Li8gW
        9TRsofHeCFFXiAmfGUiiyg/rm2bGogkP8mMs3B16HmVTvTDdZsbBy1NHcS+9xV4bZTXuNT
        3moocNhZ6CmjPjO+4b2T7MJmH2Cla04=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A8EE1348D;
        Wed,  8 Mar 2023 17:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Cg6uD3rICGSLWgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 08 Mar 2023 17:40:10 +0000
Date:   Wed, 8 Mar 2023 18:40:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yue Zhao <findns94@gmail.com>
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org, shakeelb@google.com, muchun.song@linux.dev,
        willy@infradead.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com
Subject: Re: [PATCH v3, 0/4] mm, memcg: cgroup v1 and v2 tunable load/store
 tearing fixes
Message-ID: <ZAjIeTBKteZaYEEb@dhcp22.suse.cz>
References: <20230308162555.14195-1-findns94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308162555.14195-1-findns94@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 09-03-23 00:25:51, Yue Zhao wrote:
> This patch series helps to prevent load/store tearing in
> several cgroup knobs.
> 
> As kindly pointed out by Michal Hocko, we should add 
> [WRITE|READ]_ONCE for all occurrences of memcg->oom_kill_disable,
> memcg->swappiness and memcg->soft_limit.
> 
> v3:
> - Add [WRITE|READ]_ONCE for all occurrences of
> memcg->oom_kill_disable, memcg->swappiness and memcg->soft_limit
> v2:
> - Rephrase changelog
> - Add [WRITE|READ]_ONCE for memcg->oom_kill_disable,
>  memcg->swappiness, vm_swappiness and memcg->soft_limit
> v1:
> - Add [WRITE|READ]_ONCE for memcg->oom_group
> 
> Past patches:
> V2: https://lore.kernel.org/linux-mm/20230306154138.3775-1-findns94@gmail.com/
> V1: https://lore.kernel.org/linux-mm/20230220151638.1371-1-findns94@gmail.com/
> 
> Yue Zhao (4):
>   mm, memcg: Prevent memory.oom.group load/store tearing
>   mm, memcg: Prevent memory.swappiness load/store tearing
>   mm, memcg: Prevent memory.oom_control load/store tearing
>   mm, memcg: Prevent memory.soft_limit_in_bytes load/store tearing
> 
>  include/linux/swap.h |  8 ++++----
>  mm/memcontrol.c      | 30 +++++++++++++++---------------
>  2 files changed, 19 insertions(+), 19 deletions(-)

Acked-by: Michal Hocko <mhocko@suse.com>

Btw. you could have preserved acks for patches you haven't changed from
the previous version.

-- 
Michal Hocko
SUSE Labs
