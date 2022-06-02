Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D994853BD15
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 19:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbiFBRRY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jun 2022 13:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiFBRRY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jun 2022 13:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94E2E1F5756
        for <cgroups@vger.kernel.org>; Thu,  2 Jun 2022 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654190242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6YpvaMVW61kZDAQpHfhp/j+cfCfwUKP7vhTQl8WVi3M=;
        b=EtUibsxCQRglE7LWFxqX5oNapuVRPB2qi3FJLa5add+D30LtJC255PYHRKhzFRee7kYcwu
        CiHxLwt+VOaxvQE4xsvQfO1KHQC2ExPDkjEM/PUeWbilPnBQYdgYJUnBqyjbLWjd/zE85S
        LMZqSpFRFbiWWMdPCr+itXgcAPpA3FU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-7NMUobmOOjCrnkppVGVx9A-1; Thu, 02 Jun 2022 13:17:19 -0400
X-MC-Unique: 7NMUobmOOjCrnkppVGVx9A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D98C80B70A;
        Thu,  2 Jun 2022 17:17:19 +0000 (UTC)
Received: from [10.22.32.147] (unknown [10.22.32.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CEA5492C3B;
        Thu,  2 Jun 2022 17:17:19 +0000 (UTC)
Message-ID: <6674e652-b083-2859-3cba-9eca6c721fba@redhat.com>
Date:   Thu, 2 Jun 2022 13:17:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 2/3] blk-cgroup: Return -ENOMEM directly in
 blkcg_css_alloc() error path
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20220601211824.89626-1-longman@redhat.com>
 <20220602133543.128088-3-longman@redhat.com>
 <YpjiYPscJst5iuyv@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YpjiYPscJst5iuyv@slm.duckdns.org>
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

On 6/2/22 12:16, Tejun Heo wrote:
> On Thu, Jun 02, 2022 at 09:35:42AM -0400, Waiman Long wrote:
>> For blkcg_css_alloc(), the only error that will be returned is -ENOMEM.
>> Simplify error handling code by returning this error directly instead
>> of setting an intermediate "ret" variable.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> But I don't understand why this would trigger warning. Can you please
> elaborate why this is needed.
>
> Thanks.

I forgot to set "ret" in my original patch 2 in case of allocation 
error. I didn't got a warning in my own build, maybe I didn't explicitly 
enable more warning. I could have modified the patch to set "ret" on 
error, but the "ret" setting looks duplicative to me and so I added this 
patch to get rid of it.

Thanks,
Longman

