Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA3053BE75
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 21:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbiFBTNB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jun 2022 15:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238422AbiFBTNA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jun 2022 15:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18C1510D5
        for <cgroups@vger.kernel.org>; Thu,  2 Jun 2022 12:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654197179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ura6WzJRfDCe639hKtMahR5YURQ9sPrCG1JQZM8gR34=;
        b=S6rlxM7HbD3d17TGM8/czeA9cqUqnGMJOgaUcnCv4POcNr/+40EqpJz230hOZx4ngvC7Xd
        kSrYTZoTBNdQAjiyG0cuMpAxGGUlavwKFYBpTcCwE6+7L+23uaoSRxlOB9o5K25stG1odS
        ML3GeucOvtYqSRnNBrx3M4Hr/zhljHU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-l6nvbvmKOSeZhTBelqCCeQ-1; Thu, 02 Jun 2022 15:12:54 -0400
X-MC-Unique: l6nvbvmKOSeZhTBelqCCeQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 993753C10142;
        Thu,  2 Jun 2022 19:12:53 +0000 (UTC)
Received: from [10.22.32.147] (unknown [10.22.32.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CD8F403371;
        Thu,  2 Jun 2022 19:12:53 +0000 (UTC)
Message-ID: <3ba0799f-c008-bbdf-bbc1-626d8bb4b821@redhat.com>
Date:   Thu, 2 Jun 2022 15:12:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 4/4] blk-cgroup: Document the design of new lockless
 iostat_cpu list
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20220602133543.128088-2-longman@redhat.com>
 <20220602185401.162937-1-longman@redhat.com>
 <YpkJ6rDTR24ScuEq@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YpkJ6rDTR24ScuEq@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/2/22 15:05, Tejun Heo wrote:
> On Thu, Jun 02, 2022 at 02:54:01PM -0400, Waiman Long wrote:
>> A set of percpu lockless lists per block cgroup (blkcg) is added to
>> track the set of recently updated iostat_cpu structures. Add comment
>> in the code to document the design of this new set of lockless lists.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> Thanks.

I have just realized that I forgot to free the percpu blkcg->lhead in 
blkcg_css_free(). I will send out v6 with this change as well as 
integrating this documentation patch back. Sorry for the omission.

Thanks,
Longman

