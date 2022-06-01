Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD9253AEE0
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 00:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiFAVc0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 17:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiFAVcV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 17:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACC4F1C4F07
        for <cgroups@vger.kernel.org>; Wed,  1 Jun 2022 14:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654119138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kydqna2S/fNnNfFhR9vYtc6J6licD3U6v9tlZqx3JCg=;
        b=a/F51BYxgYuYWwu2iksFXMlFfQ3io6dkyHJLLipggzyIi285ZYSURmf/Oy2Iiispz+WhSw
        rG5ucEXZSQECemNhsbW+YKUKq8z/xevWWzOhk9GZysJEnpfsaoLNA+JOEXMMQGp8FqR0jr
        Wd+WLtopqlRkp/T5QKTQbwMQ20sm/VQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-nxe11axJOkGj6dRd8brr-A-1; Wed, 01 Jun 2022 17:32:12 -0400
X-MC-Unique: nxe11axJOkGj6dRd8brr-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8BA2383328C;
        Wed,  1 Jun 2022 21:32:11 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A81FCC23DBF;
        Wed,  1 Jun 2022 21:32:11 +0000 (UTC)
Message-ID: <6734ae25-27eb-0024-8524-ab8885a5fae0@redhat.com>
Date:   Wed, 1 Jun 2022 17:32:11 -0400
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
 <bca31669-7107-ebe4-7fbf-2449940a5cc8@redhat.com>
 <c26f153c-304c-e109-6626-bb8b79a2e2ad@redhat.com>
 <YpfaC+wB5Th4tLDY@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YpfaC+wB5Th4tLDY@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 6/1/22 17:28, Tejun Heo wrote:
> On Wed, Jun 01, 2022 at 05:25:53PM -0400, Waiman Long wrote:
>> I think the best way to protect against blkg destruction is to get a percpu
>> reference when put into lockless list and put it back when removed.
>>
>> BTW, when I ran a test that continuously create and destroy containers, the
>> total number of blkcg's kept on increasing. There are some freeing of
>> blkcg's but no freeing of blkg's at all. Maybe we have a similar dying
>> blkcg's problem here. I will take a further look at that when I have time.
> They get pinned by per-cgroup writebacks which gets pinned by lingering page
> cache and other remaining accounted memory areas, so I think they can hang
> around if there's no memory pressure. But, yeah, it'd be great to verify
> that they actually go away under memory pressure.
>
> Thanks.
>
Thanks for the explanation. It makes sense to me.

Cheers,
Longman

