Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C36543A00
	for <lists+cgroups@lfdr.de>; Wed,  8 Jun 2022 19:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiFHRM6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Jun 2022 13:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiFHRMi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Jun 2022 13:12:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB061FE8DC;
        Wed,  8 Jun 2022 09:57:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 86A261F9A9;
        Wed,  8 Jun 2022 16:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654707454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5e+pVB/HXrwHYJ53O8Bi72Pko0mOIlxl6e8wCUHcuMo=;
        b=c/wlGidIaOiFmaIeIYa34mqPOP9ouH/T1bZS7CcW1LrvYbq7XkMnxGKS8ch9Hr0HkYv0AT
        I0ywnTGlJX3h0iGmKGwGQXfhiYZH/ZW8WKd95v/pEoWRHUtjQ6BXc/4t3+eLj/RkCQ9wGQ
        3hSHHVO6AkTI7bmZN0AUOKk1IGBC4DQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4889E13A15;
        Wed,  8 Jun 2022 16:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JHu8D/7UoGI3NgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 08 Jun 2022 16:57:34 +0000
Date:   Wed, 8 Jun 2022 18:57:32 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v6 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Message-ID: <20220608165732.GB19399@blackbody.suse.cz>
References: <20220602192020.166940-1-longman@redhat.com>
 <20220602192020.166940-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602192020.166940-4-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Thu, Jun 02, 2022 at 03:20:20PM -0400, Waiman Long <longman@redhat.com> wrote:
> As it is likely that not all the percpu blkg_iostat_set's has been
> updated since the last flush, those stale blkg_iostat_set's don't need
> to be flushed in this case.

Yes, there's no point to flush stats for idle devices if there can be
many of them. Good idea.

> +static struct llist_node *fetch_delete_blkcg_llist(struct llist_head *lhead)
> +{
> +	return xchg(&lhead->first, &llist_last);
> +}
> +
> +static struct llist_node *fetch_delete_lnode_next(struct llist_node *lnode)
> +{
> +	struct llist_node *next = READ_ONCE(lnode->next);
> +	struct blkcg_gq *blkg = llist_entry(lnode, struct blkg_iostat_set,
> +					    lnode)->blkg;
> +
> +	WRITE_ONCE(lnode->next, NULL);
> +	percpu_ref_put(&blkg->refcnt);
> +	return next;
> +}

Idea/just asking: would it make sense to generalize this into llist.c
(this is basically llist_del_first() + llist_del_all() with a sentinel)?
For the sake of reusability.

> +#define blkcg_llist_for_each_entry_safe(pos, node, nxt)			\
> +	for (; (node != &llist_last) &&					\
> +	       (pos = llist_entry(node, struct blkg_iostat_set, lnode),	\
> +		nxt = fetch_delete_lnode_next(node), true);		\
> +		node = nxt)
> +

It's good hygiene to parenthesize the args.

> @@ -2011,9 +2092,16 @@ void blk_cgroup_bio_start(struct bio *bio)
>  	}
>  	bis->cur.ios[rwd]++;
>  
> +	if (!READ_ONCE(bis->lnode.next)) {
> +		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
> +
> +		llist_add(&bis->lnode, lhead);
> +		percpu_ref_get(&bis->blkg->refcnt);
> +	}
> +

When a blkg's cgroup is rmdir'd, what happens with the lhead list?
We have cgroup_rstat_exit() in css_free_rwork_fn() that ultimately flushes rstats.
init_and_link_css however adds reference form blkcg->css to cgroup->css.
The blkcg->css would be (transitively) pinned by the lhead list and
hence would prevent the final flush (when refs drop to zero). Seems like
a cyclic dependency.

Luckily, there's also per-subsys flushing in css_release which could be
moved after rmdir (offlining) but before last ref is gone:

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index adb820e98f24..d830e6a8fb3b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5165,11 +5165,6 @@ static void css_release_work_fn(struct work_struct *work)

        if (ss) {
                /* css release path */
-               if (!list_empty(&css->rstat_css_node)) {
-                       cgroup_rstat_flush(cgrp);
-                       list_del_rcu(&css->rstat_css_node);
-               }
-
                cgroup_idr_replace(&ss->css_idr, NULL, css->id);
                if (ss->css_released)
                        ss->css_released(css);
@@ -5279,6 +5274,11 @@ static void offline_css(struct cgroup_subsys_state *css)
        css->flags &= ~CSS_ONLINE;
        RCU_INIT_POINTER(css->cgroup->subsys[ss->id], NULL);

+       if (!list_empty(&css->rstat_css_node)) {
+               cgroup_rstat_flush(css->cgrp);
+               list_del_rcu(&css->rstat_css_node);
+       }
+
        wake_up_all(&css->cgroup->offline_waitq);
 }

(not tested)


>  	u64_stats_update_end_irqrestore(&bis->sync, flags);
>  	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
> -		cgroup_rstat_updated(bio->bi_blkg->blkcg->css.cgroup, cpu);
> +		cgroup_rstat_updated(blkcg->css.cgroup, cpu);

Maybe bundle the lhead list maintenace with cgroup_rstat_updated() under
cgroup_subsys_on_dfl()? The stats can be read on v1 anyway.


Thanks,
Michal
