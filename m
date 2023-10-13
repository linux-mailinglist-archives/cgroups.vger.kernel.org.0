Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE47C87AC
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjJMOR2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Oct 2023 10:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjJMOR2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Oct 2023 10:17:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA426D8;
        Fri, 13 Oct 2023 07:17:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3B7C221A01;
        Fri, 13 Oct 2023 14:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697206642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3I7xUNHL0g2s71bMvgTRR/Ie+t515rJ/kQMEyfshuUM=;
        b=iVLBWv20wJKQHkXhK9SNTttjnhi31pxi8zFlNZRK2AZYglALFIKehB6KDPZh2/expdfzzt
        Ek8ejiZnD0WPOL1tmNBzhczTPX8rpk3sWeDGQog/mH3cONil8PCI9ozk46KpZHESX+wr8u
        uikMF7qfzdl8DLvE7gINhulI715Pp8M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17C741358F;
        Fri, 13 Oct 2023 14:17:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8dB4A3JRKWUjLAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 13 Oct 2023 14:17:22 +0000
Date:   Fri, 13 Oct 2023 16:17:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcontrol: Don't css_get() on root_mem_cgroup in
 get_mem_cgroup_from_mm()
Message-ID: <ZSlRcQ3JoPLFRBec@dhcp22.suse.cz>
References: <20231012161504.3445042-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012161504.3445042-1-longman@redhat.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -8.10
X-Spamd-Result: default: False [-8.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[9];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 12-10-23 12:15:04, Waiman Long wrote:
> As reference counting in the root memcg is disabled, there is no need
> to get a reference if root memcg is to be returned.

Does this give any measurable wins?
 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5b009b233ab8..2b3864194042 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1060,8 +1060,10 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>  	rcu_read_lock();
>  	do {
>  		memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
> -		if (unlikely(!memcg))
> +		if (unlikely(!memcg)) {
>  			memcg = root_mem_cgroup;
> +			break;
> +		}
>  	} while (!css_tryget(&memcg->css));
>  	rcu_read_unlock();
>  	return memcg;
> -- 
> 2.39.3

-- 
Michal Hocko
SUSE Labs
