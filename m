Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2F57AD27B
	for <lists+cgroups@lfdr.de>; Mon, 25 Sep 2023 09:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjIYH55 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Sep 2023 03:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjIYH55 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Sep 2023 03:57:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ACDD3
        for <cgroups@vger.kernel.org>; Mon, 25 Sep 2023 00:57:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02DEE21858;
        Mon, 25 Sep 2023 07:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695628669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=878uZwZWbWAa9WLyZURZrcUcT1iIEeDeTu8lVz1v0Rk=;
        b=GGSnKBycveNXuhvySz5Lw/xh2lozc1ZmzaQDsxf5W5dyn6hUclOjeLkrKuIqtqO6I2wXG4
        706kpSTT1iyYaW+01rawFVNd0/Q7oqVIwcBPhvtVNGw9q7AjKxEhgEajXimZrZR6zQBZnR
        ze4hHML9wJSp8x6JjkgH6cIFhwQLfe4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAF2F13A67;
        Mon, 25 Sep 2023 07:57:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ihwJM3w9EWUeTAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 25 Sep 2023 07:57:48 +0000
Date:   Mon, 25 Sep 2023 09:57:48 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] memcg, oom: unmark under_oom after the oom killer is
 done
Message-ID: <ZRE9fAf1dId2U4cu@dhcp22.suse.cz>
References: <20230922070529.362202-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922070529.362202-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 22-09-23 07:05:28, Haifeng Xu wrote:
> When application in userland receives oom notification from kernel
> and reads the oom_control file, it's confusing that under_oom is 0
> though the omm killer hasn't finished. The reason is that under_oom
> is cleared before invoking mem_cgroup_out_of_memory(), so move the
> action that unmark under_oom after completing oom handling. Therefore,
> the value of under_oom won't mislead users.

I do not really remember why are we doing it this way but trying to track
this down shows that we have been doing that since fb2a6fc56be6 ("mm:
memcg: rework and document OOM waiting and wakeup"). So this is an
established behavior for 10 years now. Do we really need to change it
now? The interface is legacy and hopefully no new workloads are
emerging.

I agree that the placement is surprising but I would rather not change
that unless there is a very good reason for that. Do you have any actual
workload which depends on the ordering? And if yes, how do you deal with
timing when the consumer of the notification just gets woken up after
mem_cgroup_out_of_memory completes?

> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e8ca4bdcb03c..0b6ed63504ca 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1970,8 +1970,8 @@ static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
>  	if (locked)
>  		mem_cgroup_oom_notify(memcg);
>  
> -	mem_cgroup_unmark_under_oom(memcg);
>  	ret = mem_cgroup_out_of_memory(memcg, mask, order);
> +	mem_cgroup_unmark_under_oom(memcg);
>  
>  	if (locked)
>  		mem_cgroup_oom_unlock(memcg);
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
