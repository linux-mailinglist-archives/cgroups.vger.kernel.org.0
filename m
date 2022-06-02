Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6739753BD4F
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 19:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbiFBR0R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jun 2022 13:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbiFBR0Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jun 2022 13:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4B692914D4
        for <cgroups@vger.kernel.org>; Thu,  2 Jun 2022 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654190775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ymlh+gFPOVRynjflxpfzP7WrlZXM93cHsXOM1rPvKYM=;
        b=EtpVKsKM/EBpMt/2ZQEggugL0Vs9Mn/000Wv8vqlbUNAJk7u2D4xw3PladqX8aA4sekRnU
        29zxu+yGYLSHE1xAyP4MCmFMzelS/7kIJU9Wj5AYtAlULyWrA0zMyVpHYBrZ1bM7snaUrv
        d53SyI2iAf3RYkw7iUDuSaaezivN2no=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-sqfP4o74O5WBPwEcvo8nBQ-1; Thu, 02 Jun 2022 13:26:11 -0400
X-MC-Unique: sqfP4o74O5WBPwEcvo8nBQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4022C858EFF;
        Thu,  2 Jun 2022 17:26:11 +0000 (UTC)
Received: from [10.22.32.147] (unknown [10.22.32.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F36B0492CA4;
        Thu,  2 Jun 2022 17:26:10 +0000 (UTC)
Message-ID: <42da456d-8f6a-3af0-4cd3-d33a07e3b81e@redhat.com>
Date:   Thu, 2 Jun 2022 13:26:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20220601211824.89626-1-longman@redhat.com>
 <20220602133543.128088-4-longman@redhat.com>
 <YpjsTNZx4DG+kot4@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YpjsTNZx4DG+kot4@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 6/2/22 12:58, Tejun Heo wrote:
> Hello,
>
> On Thu, Jun 02, 2022 at 09:35:43AM -0400, Waiman Long wrote:
>> @@ -2011,9 +2076,16 @@ void blk_cgroup_bio_start(struct bio *bio)
>>   	}
>>   	bis->cur.ios[rwd]++;
>>   
>> +	if (!READ_ONCE(bis->lnode.next)) {
>> +		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
>> +
>> +		llist_add(&bis->lnode, lhead);
>> +		percpu_ref_get(&bis->blkg->refcnt);
> Hmm... what guarantees that more than one threads race here? llist assumes
> that there's a single writer for a given llist_node and the ref count would
> be off too, right?

The llist_add() function is atomic. It calls into llist_add_batch() in 
lib/llist.c which uses cmpxchg() to make the change. There is a 
non-atomic version __llist_add() which may be problematic in this case. 
Note that irq is disabled in the u64_stats_update* critical section, 
there shouldn't be a racing thread running in the same cpu. Other cpus 
will modify their own version of lhead. Perhaps the non-atomic version 
can be used here as well.

Cheers,
Longman

