Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2638E53AD14
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 20:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiFASw7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 14:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiFASw6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 14:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0B3A1455B0
        for <cgroups@vger.kernel.org>; Wed,  1 Jun 2022 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654109574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=23W9sVLSI1R9gyjHi/xhjrSHqXfJ+ljK3ctft/U12GA=;
        b=b1SlC9hJytQitRSVp0Y0rwnEmjpL5K4aedbhK1EupISGA+9LzxhGs/XD8MRtW8zfMGRx0w
        eJ2COMJi2SCQWULd3wDjE42OK2B9LK0XikWa81EKlHu8Beg5bOvqBa63/2GNkIy/P8VDHb
        yIMbMypCIWhb7v2A7E5zSNjCDnftr28=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-SB65AArwOOGGFynUaqRX-g-1; Wed, 01 Jun 2022 14:52:51 -0400
X-MC-Unique: SB65AArwOOGGFynUaqRX-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C53E185A79C;
        Wed,  1 Jun 2022 18:52:51 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 098DE40CF8EB;
        Wed,  1 Jun 2022 18:52:51 +0000 (UTC)
Message-ID: <bca31669-7107-ebe4-7fbf-2449940a5cc8@redhat.com>
Date:   Wed, 1 Jun 2022 14:52:50 -0400
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
 <ca091a5c-4ae1-e973-403e-4086d4527102@redhat.com>
 <YpexWFptr/l2Y0rU@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YpexWFptr/l2Y0rU@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/1/22 14:35, Tejun Heo wrote:
> Hello,
>
> On Wed, Jun 01, 2022 at 02:15:46PM -0400, Waiman Long wrote:
>> It was mentioned in the commit log, but I will add a comment to repeat that.
>> It is because lnode.next is used as a flag to indicate its presence in the
>> lockless list. By default, the first one that go into the lockless list will
>> have a NULL value in its next pointer. So I have to put a sentinel node that
>> to make sure that the next pointer is always non-NULL.
> Oh yeah, I noticed that in the commit log, but I think it really warrants an
> inline comment.
>
>>>> + * The retrieved blkg_iostat_set is immediately marked as not in the
>>>> + * lockless list by clearing its node->next pointer. It could be put
>>>> + * back into the list by a parallel update before the iostat's are
>>>> + * finally flushed. So being in the list doesn't always mean it has new
>>>> + * iostat's to be flushed.
>>>> + */
>>> Isn't the above true for any sort of mechanism which tracking pending state?
>>> You gotta clear the pending state before consuming so that you don't miss
>>> the events which happen while data is being consumed.
>> That is true. I was about thinking what race conditions can happen with
>> these changes. The above comment is for the race that can happen which is
>> benign. I am remove it if you think it is necessary.
> I don't have too strong an opinion. It just felt a bit disproportionate for
> it to be sticking out like that. Maybe toning it down a little bit would
> help?

Will do.


>>>> +	/*
>>>> +	 * No RCU protection is needed as it is assumed that blkg_iostat_set's
>>>> +	 * in the percpu lockless list won't go away until the flush is done.
>>>> +	 */
>>> Can you please elaborate on why this is safe?
>> You are right that the comment is probably not quite right. I will put the
>> rcu_read_lock/unlock() back in. However, we don't have a rcu iterator for
>> the lockless list. On the other hand, blkcg_rstat_flush() is now called with
>> irq disabled. So rcu_read_lock() is not technically needed.
> Maybe we just need an rcu_read_lock_held() - does that cover irq being
> disabled? I'm not sure what the rules are since the different rcu variants
> got merged. Anyways, the right thing to do would be asserting and
> documenting that the section is RCU protected.

I will leave rcu_read_lock() in for now. We can worry about the proper 
way to remove it or document it later on.


>
> As for llist not having rcu iterators. The llists aren't RCU protected or
> assigned. What's RCU protected is the lifetime of the elements. That said,
> we'd need an rmb after fetching llist_head to guarantee that the flusher
> sees all the updates which took place before the node got added to the
> llist, right?

Fetching of llist head is done by an atomic xchg(). So it has all the 
necessary barrier.

Iterating the nodes of the llist and clearing them are not atomic. That 
is the reason I put a comment previously about a possible race. However 
that race is benign. Making it atomic does not eliminate the race as the 
iostat update data themselves are synchronized separately with sequence 
lock.

> Can you also add an explanation on how the pending llist is synchronized
> against blkg destructions?

Sure. I will need to think about that and put a proper comment there.

Cheers,
Longman

