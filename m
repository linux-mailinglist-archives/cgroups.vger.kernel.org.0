Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4031722896
	for <lists+cgroups@lfdr.de>; Mon,  5 Jun 2023 16:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjFEORJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jun 2023 10:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjFEOQy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jun 2023 10:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD11E79
        for <cgroups@vger.kernel.org>; Mon,  5 Jun 2023 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685974552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DACW0kCzVuT5IFaBn71kjqbpg34q1clPenVlI/hF2Iw=;
        b=arwOE3VzPy/DCFrU3713YNNwmY7pWySInwqgX6vVm6PNgDFGHSJqFDlKgkzU3JLq6+x3jr
        kfb+t7KLs4SSkkgHKGy4fojTvmxZqGVKsVJM7h4V41ZJdYBbR7VYNAbGYDB2eoIe/dwwOn
        o8reWw+jJLkQy2TvddeMNhTZeX4nI1Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-ogMX25KYN5epLTHPlLAQ2Q-1; Mon, 05 Jun 2023 10:15:18 -0400
X-MC-Unique: ogMX25KYN5epLTHPlLAQ2Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFE3F2A2AD53;
        Mon,  5 Jun 2023 14:12:26 +0000 (UTC)
Received: from [10.22.10.186] (unknown [10.22.10.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B36E49BB98;
        Mon,  5 Jun 2023 14:12:26 +0000 (UTC)
Message-ID: <e0d1998f-c081-30e6-7646-cf6460c2d67c@redhat.com>
Date:   Mon, 5 Jun 2023 10:12:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] cgroup: fixed the cset refcnt leak when fork() failed
Content-Language: en-US
To:     Zou Cao <zoucaox@gmail.com>, linux-kernel@vger.kernel.org,
        tj@kernel.org
Cc:     cgroups@vger.kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, brauner@kernel.org,
        Zou Cao <zoucao@kuaishou.com>
References: <20230605130444.1421-1-zoucao@kuaishou.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230605130444.1421-1-zoucao@kuaishou.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/5/23 09:04, Zou Cao wrote:
> TeamID: B1486294
What is this?
>
> when fork, cset will be increased by commit "ef2c41cf38a7", the refcnt will
> be decrease by child exit, but when failed in fork(), this refcnt will
> be lost decrease in cgroup_cancel_fork as follow:
>
> copy_process
>       |
> cgroup_can_fork    //  increase the css refcount
>    ......
>    spin_lock_irq(&css_set_lock);
>    cset = task_css_setcurrent);
>    get_css_set(cset);
>    spin_unlock_irq&css_set_lock);
>    ......

The code quoted above is actually in cgroup_css_set_fork(). You may want 
to list it as well.

I believe the problem is in

         if (!(kargs->flags & CLONE_INTO_CGROUP)) {
                 kargs->cset = cset;
                 return 0;
         }

When CLONE_INTO_CGROUP isn't set, a reference to the current cset is taken.

>       |
> goto cgroup_cancel_fork    // if failed in  copy_process
>       |
> cgroup_cancel_fork  // lost the decrease refcount if flag not CLONE_INTO_CGROUP
>
> Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
> Signed-off-by: Zou Cao <zoucao@kuaishou.com>
> ---
>   kernel/cgroup/cgroup.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index d18c2ef..5ecd706 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6284,6 +6284,11 @@ void cgroup_cancel_fork(struct task_struct *child,
>   		if (ss->cancel_fork)
>   			ss->cancel_fork(child, kargs->cset);
>   
> +	if (!(kargs->flags & CLONE_INTO_CGROUP) &&
> +			kargs->cset) {
> +		put_css_set(kargs->cset);
> +	}
> +
I believe the out_revert error path of cgroup_can_fork() has a similar 
issue. Perhaps you may want to put the put_css_set() call in 
cgroup_css_set_put_fork().
>   	cgroup_css_set_put_fork(kargs);
>   }
>   
Cheers,
Longman

