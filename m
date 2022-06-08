Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE91543B48
	for <lists+cgroups@lfdr.de>; Wed,  8 Jun 2022 20:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiFHSTC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Jun 2022 14:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbiFHSQt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Jun 2022 14:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3D4134641
        for <cgroups@vger.kernel.org>; Wed,  8 Jun 2022 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654712207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=puhUcvLRx9zat7PF7KwdoaGeUx8bqAUgfHHvV+ON4tg=;
        b=AAtIHOhxXVEnaLwlXFoMnMWXWeVv6LCq2A7UlZHad5jxSuPBHl3s2o8wZhZYkP47Jnh2GZ
        Sn24+E7AyM9bY+XGrPDs4xjbsPKn+g/eTTzBnKxMz0KZgFsMAnClJvnQGwdAPCsrm3brzc
        0ewxTIGE1o2estBnf8B1ggHsqENMnrs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-fMFaPEQmNa6fs8BCIm9aTg-1; Wed, 08 Jun 2022 14:16:46 -0400
X-MC-Unique: fMFaPEQmNa6fs8BCIm9aTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A325A185A7A4;
        Wed,  8 Jun 2022 18:16:45 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F9DF2026D64;
        Wed,  8 Jun 2022 18:16:45 +0000 (UTC)
Message-ID: <506eaa3d-be84-c51e-3252-2979847054fe@redhat.com>
Date:   Wed, 8 Jun 2022 14:16:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <20220602192020.166940-1-longman@redhat.com>
 <20220602192020.166940-4-longman@redhat.com>
 <20220608165732.GB19399@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220608165732.GB19399@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/8/22 12:57, Michal Koutný wrote:
> Hello.
>
> On Thu, Jun 02, 2022 at 03:20:20PM -0400, Waiman Long <longman@redhat.com> wrote:
>> As it is likely that not all the percpu blkg_iostat_set's has been
>> updated since the last flush, those stale blkg_iostat_set's don't need
>> to be flushed in this case.
> Yes, there's no point to flush stats for idle devices if there can be
> many of them. Good idea.
>
>> +static struct llist_node *fetch_delete_blkcg_llist(struct llist_head *lhead)
>> +{
>> +	return xchg(&lhead->first, &llist_last);
>> +}
>> +
>> +static struct llist_node *fetch_delete_lnode_next(struct llist_node *lnode)
>> +{
>> +	struct llist_node *next = READ_ONCE(lnode->next);
>> +	struct blkcg_gq *blkg = llist_entry(lnode, struct blkg_iostat_set,
>> +					    lnode)->blkg;
>> +
>> +	WRITE_ONCE(lnode->next, NULL);
>> +	percpu_ref_put(&blkg->refcnt);
>> +	return next;
>> +}
> Idea/just asking: would it make sense to generalize this into llist.c
> (this is basically llist_del_first() + llist_del_all() with a sentinel)?
> For the sake of reusability.

I have thought about that. It can be done as a follow-up patch to add a 
sentinel version into llist and use that instead. Of course, I can also 
update this patchset to include that.


>
>> +#define blkcg_llist_for_each_entry_safe(pos, node, nxt)			\
>> +	for (; (node != &llist_last) &&					\
>> +	       (pos = llist_entry(node, struct blkg_iostat_set, lnode),	\
>> +		nxt = fetch_delete_lnode_next(node), true);		\
>> +		node = nxt)
>> +
> It's good hygiene to parenthesize the args.
I am aware of that. I will certainly add that if it is a generic macro 
that can have many users.

>
>> @@ -2011,9 +2092,16 @@ void blk_cgroup_bio_start(struct bio *bio)
>>   	}
>>   	bis->cur.ios[rwd]++;
>>   
>> +	if (!READ_ONCE(bis->lnode.next)) {
>> +		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
>> +
>> +		llist_add(&bis->lnode, lhead);
>> +		percpu_ref_get(&bis->blkg->refcnt);
>> +	}
>> +
> When a blkg's cgroup is rmdir'd, what happens with the lhead list?
> We have cgroup_rstat_exit() in css_free_rwork_fn() that ultimately flushes rstats.
> init_and_link_css however adds reference form blkcg->css to cgroup->css.
> The blkcg->css would be (transitively) pinned by the lhead list and
> hence would prevent the final flush (when refs drop to zero). Seems like
> a cyclic dependency.
>
> Luckily, there's also per-subsys flushing in css_release which could be
> moved after rmdir (offlining) but before last ref is gone:
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index adb820e98f24..d830e6a8fb3b 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5165,11 +5165,6 @@ static void css_release_work_fn(struct work_struct *work)
>
>          if (ss) {
>                  /* css release path */
> -               if (!list_empty(&css->rstat_css_node)) {
> -                       cgroup_rstat_flush(cgrp);
> -                       list_del_rcu(&css->rstat_css_node);
> -               }
> -
>                  cgroup_idr_replace(&ss->css_idr, NULL, css->id);
>                  if (ss->css_released)
>                          ss->css_released(css);
> @@ -5279,6 +5274,11 @@ static void offline_css(struct cgroup_subsys_state *css)
>          css->flags &= ~CSS_ONLINE;
>          RCU_INIT_POINTER(css->cgroup->subsys[ss->id], NULL);
>
> +       if (!list_empty(&css->rstat_css_node)) {
> +               cgroup_rstat_flush(css->cgrp);
> +               list_del_rcu(&css->rstat_css_node);
> +       }
> +
>          wake_up_all(&css->cgroup->offline_waitq);
>   }
>
> (not tested)

Good point.

Your change may not be enough since there could be update after the 
flush which will pin the blkg and hence blkcg.  I guess one possible 
solution may be to abandon the llist and revert back to list iteration 
when offline. I need to think a bit more about that.

>
>
>>   	u64_stats_update_end_irqrestore(&bis->sync, flags);
>>   	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
>> -		cgroup_rstat_updated(bio->bi_blkg->blkcg->css.cgroup, cpu);
>> +		cgroup_rstat_updated(blkcg->css.cgroup, cpu);
> Maybe bundle the lhead list maintenace with cgroup_rstat_updated() under
> cgroup_subsys_on_dfl()? The stats can be read on v1 anyway.

I don't quite understand here. The change is not specific to v1 or v2. 
What do you mean by the stat is readable on v1?

Cheers,
Longman

