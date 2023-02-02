Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7143568775E
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 09:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjBBI1o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 03:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjBBI1n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 03:27:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55DB86636;
        Thu,  2 Feb 2023 00:27:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 542EB33E4A;
        Thu,  2 Feb 2023 08:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675326460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=exe0DtfeQcAlhuYAQJBwVd6y+SRpyDu0VP1XU1cSGK0=;
        b=DGcyKCskLROJaYfTPTapPmF5EHxGu6uUXfqgXYFhdqrgb/9iD14ccSbNigzTJnMCOTleaR
        6hBq//gwdIwePPtKTgeVwYAOQzqGE4LbpKPAX+qDcIKzRFsYZhuWiy2i3bRip5V6H0/4L3
        8d6HZNPrIguXQnVO5tvB5bm8XVjtpFc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3664E139D0;
        Thu,  2 Feb 2023 08:27:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hLvwCvxz22P7HwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 02 Feb 2023 08:27:40 +0000
Date:   Thu, 2 Feb 2023 09:27:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: introduce entrance for root_mem_cgroup's current
Message-ID: <Y9tz+0J9fw+Z+O+O@dhcp22.suse.cz>
References: <1675312377-4782-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675312377-4782-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 02-02-23 12:32:57, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Introducing memory.root_current for the memory charges on root_mem_cgroup.

Charges are not currently accounted for the root memcg universally. See
try_charge which is used for all user space and skmem charges. I am not
100% sure about objcg based accounting because there is no explicit
check for the root memcg but this might be hidden somewhere as well.

That means that the patch as is doesn't really provide and usable value.
The root exemption has been removed in the past but that has been
reverted due to a regression. See ce00a967377b ("mm: memcontrol: revert
use of root_mem_cgroup res_counter") for more.

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/memcontrol.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ab457f0..158d4232 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6681,6 +6681,11 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  
>  static struct cftype memory_files[] = {
>  	{
> +		.name = "root_current",
> +		.flags = CFTYPE_ONLY_ON_ROOT,
> +		.read_u64 = memory_current_read,
> +	},
> +	{
>  		.name = "current",
>  		.flags = CFTYPE_NOT_ON_ROOT,
>  		.read_u64 = memory_current_read,
> -- 
> 1.9.1

-- 
Michal Hocko
SUSE Labs
