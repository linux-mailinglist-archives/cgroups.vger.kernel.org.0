Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13C270C57A
	for <lists+cgroups@lfdr.de>; Mon, 22 May 2023 20:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjEVSpO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 May 2023 14:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjEVSpN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 May 2023 14:45:13 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E73E6;
        Mon, 22 May 2023 11:45:12 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d3e5e5980so3845911b3a.2;
        Mon, 22 May 2023 11:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684781112; x=1687373112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPEdOjaln13eDkr1qkN349p3zj4aR3vg58cbN+JoRYk=;
        b=pw1TCbAM/9X7C4aNn9jkVVcJZLM2CSvFZAOHfIxRjiHX55nbX+GF9K/lD/zzJcsFkK
         gWvVWipuH89kaaOo7I9QmOgkSI2TVKk4R6++qB/8Wd73IMxUIwLlPAyuOUp6cDTivj1G
         CKYXjQXD7DlvopChbyi40wquu/zmDeHrqD57gpKspr9vXxr02t3YKcaXwK/znJ/DJDpb
         iYVNEt/OenjvbEuvz5bD3eRVlT9VoO9zOxwhMTL0IikBrPHgRWOM2iMc21pfI7u/VEiN
         Dq5F4E/kskoV++jz3iKpF97Ape1+7BeHQaSzBTmxEB7iSU/i2BBqgu/fUQ5LQa0fPpdT
         vNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684781112; x=1687373112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPEdOjaln13eDkr1qkN349p3zj4aR3vg58cbN+JoRYk=;
        b=kHuBnyCDh6DiXJRDlSlKsBdz1VMAyupdMFpwPyEp/FmU4AIgKECu7F4dJQz3xxYKv2
         J2Krwy2qUfDooKDqSTUBqnqfERTGCVxBcyvWltEN+7QHHltDxe32VpX30r1sgv/4WHUV
         gtpKcFUmAFJIlJBoJwW02W1/VbI15IjxdvbNrWybQD0rlBFNjggviAfazq4caPjYF4ND
         nI80sElyjuyNaKdeF7rH0+nXQSfWvvj8e8Qllag/Ha8AkfRT96pL7b8A01JM0OkJKc/F
         TcIJ+3+Me/STKAshnyW3IRATEwWKZgsdo80R0SnmTaJJj+rc1J3NnGDbWNL727e5/80x
         0auA==
X-Gm-Message-State: AC+VfDyxDEGz2krMNWJMfJkxVGIUSDf9os6SfkXOcZMbKU7brkJXnwnq
        bVy7KOtpK2N+eS4j8HpRViY=
X-Google-Smtp-Source: ACHHUZ5hFyUq9RkANKr5i6RTrWMoJ05IENw4wt/aRfLALVJFNwQevDRiaUrWfjR9/pV5vbgmLWUriw==
X-Received: by 2002:a05:6a00:228e:b0:64d:6a78:157e with SMTP id f14-20020a056a00228e00b0064d6a78157emr5614329pfe.28.1684781111444;
        Mon, 22 May 2023 11:45:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:39c])
        by smtp.gmail.com with ESMTPSA id g2-20020a62e302000000b0064d31ddb5e4sm4454262pfh.43.2023.05.22.11.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 11:45:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 22 May 2023 08:45:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Qi Zheng <qi.zheng@linux.dev>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        muchun.song@linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>,
        Zhao Gongyi <zhaogongyi@bytedance.com>
Subject: Re: [PATCH] cgroup: fix missing cpus_read_{lock,unlock}() in
 cgroup_transfer_tasks()
Message-ID: <ZGu4NW-lPhqa3Rwe@slm.duckdns.org>
References: <20230517074545.2045035-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517074545.2045035-1-qi.zheng@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 17, 2023 at 07:45:45AM +0000, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> The commit 4f7e7236435c ("cgroup: Fix threadgroup_rwsem <-> cpus_read_lock()
> deadlock") fixed the deadlock between cgroup_threadgroup_rwsem and
> cpus_read_lock() by introducing cgroup_attach_{lock,unlock}() and removing
> cpus_read_{lock,unlock}() from cpuset_attach(). But cgroup_transfer_tasks()
> was missed and not handled, which will cause th following warning:
> 
>  WARNING: CPU: 0 PID: 589 at kernel/cpu.c:526 lockdep_assert_cpus_held+0x32/0x40
>  CPU: 0 PID: 589 Comm: kworker/1:4 Not tainted 6.4.0-rc2-next-20230517 #50
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>  Workqueue: events cpuset_hotplug_workfn
>  RIP: 0010:lockdep_assert_cpus_held+0x32/0x40
>  <...>
>  Call Trace:
>   <TASK>
>   cpuset_attach+0x40/0x240
>   cgroup_migrate_execute+0x452/0x5e0
>   ? _raw_spin_unlock_irq+0x28/0x40
>   cgroup_transfer_tasks+0x1f3/0x360
>   ? find_held_lock+0x32/0x90
>   ? cpuset_hotplug_workfn+0xc81/0xed0
>   cpuset_hotplug_workfn+0xcb1/0xed0
>   ? process_one_work+0x248/0x5b0
>   process_one_work+0x2b9/0x5b0
>   worker_thread+0x56/0x3b0
>   ? process_one_work+0x5b0/0x5b0
>   kthread+0xf1/0x120
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x1f/0x30
>   </TASK>
> 
> So just use the cgroup_attach_{lock,unlock}() helper to fix it.
> 
> Fixes: 4f7e7236435c ("cgroup: Fix threadgroup_rwsem <-> cpus_read_lock() deadlock")
> Reported-by: Zhao Gongyi <zhaogongyi@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Applied to cgroupp/for-6.4-fixes w/ Fixes tag updated to 05c7b7a92cc8 (the
commit that 4f7e7236435c fixes) and stable tag added.

Thanks.

-- 
tejun
