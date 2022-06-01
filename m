Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8061453AEEC
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 00:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiFAVb1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 17:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiFAVbL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 17:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 729571AA15C
        for <cgroups@vger.kernel.org>; Wed,  1 Jun 2022 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654119057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Q5Yw9t0Y+2Q0d6nFtht5jV9c3xFTEYinX8tRSP5cPo=;
        b=gwHHKitxzN7NcjDj4ocwUOqn8bWEmokQ3skl8yH56amEM6+ElOUme+fAL5pstoRmO4oUE+
        4aFPMEhtqHM42BsXU+hALjVfknupUA8/EAKRWfatHc/PZ6PXx9jzBUs351rnrHUI4cixtg
        2u1h9K7+V6+AX7OK4IFju8X1PTFKiB8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-r4dROy8VPu6p05x1WXSfgA-1; Wed, 01 Jun 2022 17:30:54 -0400
X-MC-Unique: r4dROy8VPu6p05x1WXSfgA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 030A3811E7A;
        Wed,  1 Jun 2022 21:30:54 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B890840885A1;
        Wed,  1 Jun 2022 21:30:53 +0000 (UTC)
Message-ID: <9b1c20a7-ef93-d6c9-9054-64688cf48625@redhat.com>
Date:   Wed, 1 Jun 2022 17:30:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 2/2] blk-cgroup: Optimize blkcg_rstat_flush()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20220601211824.89626-1-longman@redhat.com>
 <20220601211824.89626-3-longman@redhat.com>
 <YpfZh6JZZMzUQIAt@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YpfZh6JZZMzUQIAt@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 6/1/22 17:26, Tejun Heo wrote:
> On Wed, Jun 01, 2022 at 05:18:24PM -0400, Waiman Long wrote:
>> @@ -59,6 +59,57 @@ static struct workqueue_struct *blkcg_punt_bio_wq;
>>   
>>   #define BLKG_DESTROY_BATCH_SIZE  64
>>   
>> +/*
>> + * lnode.next of the last entry in a lockless list is NULL. To make it
>> + * always non-NULL for lnode's, a sentinel node has to be put at the
>> + * end of the lockless list. So all the percpu lhead's are initialized
>> + * to point to that sentinel node.
>> + */
> Can you please add why we want all entries to have non-NULL next?

As said elsewhere, lnode->next is used as a flag to indicate its 
presence in a lockless list. Sorry for not being explicit here.


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
>> +static inline struct llist_node *
>> +fetch_delete_lnode_next(struct llist_node *lnode)
>> +{
>> +	struct llist_node *next = READ_ONCE(lnode->next);
>> +	struct blkcg_gq *blkg = llist_entry(lnode, struct blkg_iostat_set,
>> +					    lnode)->blkg;
>> +
>> +	WRITE_ONCE(lnode->next, NULL);
>> +	percpu_ref_put(&blkg->refcnt);
>> +	return next;
>> +}
> It's not a strong opinion but I'm not too fond of using inlines to mark
> trivial functions. The compiler should be able to make these decisions,
> right?
>
> Other than the above two bikesheddings,

Sure, I can remove the inline keywords. I think I do it out of habit:-)

Regards,
Longman

>
>   Acked-by: Tejun Heo <tj@kernel.org>
>
> Thanks.
>

