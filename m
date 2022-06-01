Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2827553AC93
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 20:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355332AbiFASP5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 14:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353276AbiFASPz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 14:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B36D92D34
        for <cgroups@vger.kernel.org>; Wed,  1 Jun 2022 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654107351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dX1KALUYI5LTDHlQ52ro6BrgVD7fAMuVEmp4ohS0p7E=;
        b=KCs0UKP1rSx2uzKZwIDiHekFrO2D7n5FtKN+HZANwZgBzjJzNTR9t8a0EORc9E4d2yjJrZ
        nPOO2S4VxIOA5eb/r2cRRdcxfjr+Ul1zQDbLOmV7Z1/1VG/E2bt+KY3yLZyXYpBBm9SxI4
        40NoGJzcoiY+ztCYGoRVvFgVzXtlxEA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-63WTlsQiPpWkYzN5N7SdEA-1; Wed, 01 Jun 2022 14:15:47 -0400
X-MC-Unique: 63WTlsQiPpWkYzN5N7SdEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F250181E070;
        Wed,  1 Jun 2022 18:15:47 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 212492026D07;
        Wed,  1 Jun 2022 18:15:47 +0000 (UTC)
Message-ID: <ca091a5c-4ae1-e973-403e-4086d4527102@redhat.com>
Date:   Wed, 1 Jun 2022 14:15:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] blk-cgroup: Optimize blkcg_rstat_flush()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20220601165324.60892-1-longman@redhat.com>
 <20220601165324.60892-2-longman@redhat.com>
 <YpemVpvaPomwH7mt@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YpemVpvaPomwH7mt@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 6/1/22 13:48, Tejun Heo wrote:
> Hello,
>
> On Wed, Jun 01, 2022 at 12:53:24PM -0400, Waiman Long wrote:
>> +static struct llist_node llist_last;	/* Last sentinel node of llist */
> Can you please add comment explaining why we need the special sentinel and
> empty helper?

It was mentioned in the commit log, but I will add a comment to repeat 
that. It is because lnode.next is used as a flag to indicate its 
presence in the lockless list. By default, the first one that go into 
the lockless list will have a NULL value in its next pointer. So I have 
to put a sentinel node that to make sure that the next pointer is always 
non-NULL.


>
>> +static inline bool blkcg_llist_empty(struct llist_head *lhead)
>> +{
>> +	return lhead->first == &llist_last;
>> +}
>> +
>> +static inline void init_blkcg_llists(struct blkcg *blkcg)
>> +{
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu)
>> +		per_cpu_ptr(blkcg->lhead, cpu)->first = &llist_last;
>> +}
>> +
>> +static inline struct llist_node *
>> +fetch_delete_blkcg_llist(struct llist_head *lhead)
>> +{
>> +	return xchg(&lhead->first, &llist_last);
>> +}
>> +
>> +/*
>> + * The retrieved blkg_iostat_set is immediately marked as not in the
>> + * lockless list by clearing its node->next pointer. It could be put
>> + * back into the list by a parallel update before the iostat's are
>> + * finally flushed. So being in the list doesn't always mean it has new
>> + * iostat's to be flushed.
>> + */
> Isn't the above true for any sort of mechanism which tracking pending state?
> You gotta clear the pending state before consuming so that you don't miss
> the events which happen while data is being consumed.

That is true. I was about thinking what race conditions can happen with 
these changes. The above comment is for the race that can happen which 
is benign. I am remove it if you think it is necessary.

>
>> +#define blkcg_llist_for_each_entry_safe(pos, node, nxt)			\
>> +	for (; (node != &llist_last) &&					\
>> +	       (pos = llist_entry(node, struct blkg_iostat_set, lnode),	\
>> +		nxt = node->next, node->next = NULL, true);		\
>> +		node = nxt)
>> +
>>   /**
>>    * blkcg_css - find the current css
>>    *
> ...
>> @@ -852,17 +888,26 @@ static void blkg_iostat_sub(struct blkg_iostat *dst, struct blkg_iostat *src)
>>   static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>>   {
>>   	struct blkcg *blkcg = css_to_blkcg(css);
>> -	struct blkcg_gq *blkg;
>> +	struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
>> +	struct llist_node *lnode, *lnext;
>> +	struct blkg_iostat_set *bisc;
>>   
>>   	/* Root-level stats are sourced from system-wide IO stats */
>>   	if (!cgroup_parent(css->cgroup))
>>   		return;
>>   
>> -	rcu_read_lock();
>> +	if (blkcg_llist_empty(lhead))
>> +		return;
>>   
>> -	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
>> +	lnode = fetch_delete_blkcg_llist(lhead);
>> +
>> +	/*
>> +	 * No RCU protection is needed as it is assumed that blkg_iostat_set's
>> +	 * in the percpu lockless list won't go away until the flush is done.
>> +	 */
> Can you please elaborate on why this is safe?

You are right that the comment is probably not quite right. I will put 
the rcu_read_lock/unlock() back in. However, we don't have a rcu 
iterator for the lockless list. On the other hand, blkcg_rstat_flush() 
is now called with irq disabled. So rcu_read_lock() is not technically 
needed.

Will send out a v3 soon.

Thanks,
Longman

>
>> +	blkcg_llist_for_each_entry_safe(bisc, lnode, lnext) {
>> +		struct blkcg_gq *blkg = bisc->blkg;
>>   		struct blkcg_gq *parent = blkg->parent;
>> -		struct blkg_iostat_set *bisc = per_cpu_ptr(blkg->iostat_cpu, cpu);
>>   		struct blkg_iostat cur, delta;
>>   		unsigned long flags;
>>   		unsigned int seq;
> Overall, looks fantastic to me. Thanks a lot for working on it.
>

