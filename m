Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93E1723552
	for <lists+cgroups@lfdr.de>; Tue,  6 Jun 2023 04:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjFFCdi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jun 2023 22:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjFFCdi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jun 2023 22:33:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720CB10F
        for <cgroups@vger.kernel.org>; Mon,  5 Jun 2023 19:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686018770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aonkk/+CcrMShgRhSujmxagn3pRNh1VqOrcLFDrdbTU=;
        b=crBgY47RrRMP5/DmMlFlTjqvFGRGy0ktnOC0FsvsvYZTtm7Nj2jl3+1NSMqITgPfql/BGy
        nO3jocbbfS8Tt46uY/3rNlNmSmpcaCojAzduhluJQ17J9na2A5VOKlcL3ffrXiIWfV0KhY
        BYtzoXeUQP3ImtNpAZiGSSUYLrK5a6A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-XInl0MPCOMK-uXXE-9XsWQ-1; Mon, 05 Jun 2023 22:32:47 -0400
X-MC-Unique: XInl0MPCOMK-uXXE-9XsWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA2A0185A795;
        Tue,  6 Jun 2023 02:32:46 +0000 (UTC)
Received: from [10.22.8.27] (unknown [10.22.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9458240D1B61;
        Tue,  6 Jun 2023 02:32:45 +0000 (UTC)
Message-ID: <7cc82da3-04f6-55d4-6a0a-a88079de0e14@redhat.com>
Date:   Mon, 5 Jun 2023 22:32:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] cgroup: fixed the cset refcnt leak when fork() failed
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Zou Cao <zoucaox@gmail.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, brauner@kernel.org,
        Zou Cao <zoucao@kuaishou.com>
References: <20230605130444.1421-1-zoucao@kuaishou.com>
 <ZH5V5S5InM6b1iK7@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZH5V5S5InM6b1iK7@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 6/5/23 17:38, Tejun Heo wrote:
> On Mon, Jun 05, 2023 at 09:04:44PM +0800, Zou Cao wrote:
>> TeamID: B1486294
>>
>> when fork, cset will be increased by commit "ef2c41cf38a7", the refcnt will
>> be decrease by child exit, but when failed in fork(), this refcnt will
>> be lost decrease in cgroup_cancel_fork as follow:
>>
>> copy_process
>>       |
>> cgroup_can_fork    //  increase the css refcount
>>    ......
>>    spin_lock_irq(&css_set_lock);
>>    cset = task_css_setcurrent);
>>    get_css_set(cset);
>>    spin_unlock_irq&css_set_lock);
>>    ......
>>       |
>> goto cgroup_cancel_fork    // if failed in  copy_process
>>       |
>> cgroup_cancel_fork  // lost the decrease refcount if flag not CLONE_INTO_CGROUP
>>
>> Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
>> Signed-off-by: Zou Cao <zoucao@kuaishou.com>
> Is this the same bug fixed by the following commit?
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/commit/?h=for-6.4-fixes&id=2bd110339288c18823dcace602b63b0d8627e520

I believe it is the same bug that this patch is trying to fix. I missed 
the part kargs->cset is cleared in cgroup_post_fork() so that the put 
can be done solely in cgroup_css_set_put_fork(). That is definitely the 
cleaner approach.

Cheers,
Longman

