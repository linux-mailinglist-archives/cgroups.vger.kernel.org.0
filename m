Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69325280FD
	for <lists+cgroups@lfdr.de>; Mon, 16 May 2022 11:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbiEPJrd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 May 2022 05:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiEPJrc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 May 2022 05:47:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7F6344DF;
        Mon, 16 May 2022 02:47:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r71so13251052pgr.0;
        Mon, 16 May 2022 02:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YHaY3VzzTKl05Ylig5G4revSeCBrE0n2SgEWey+VV4c=;
        b=kJYGrFZKUFrWk0ImWW0YnAKs8rcQzfSr2AwwcnEDXieIovOXoMXhPfHwkPrRr2ZH7o
         xG4giXUDJD8ISDP6iPnb9oDfLIB3221ksRJ3Rc9/Mv6j99u+uC7PEKZx6eC3T0wZU3sv
         2KcBpyQhdSwtSPFTH022wws+PNTjY8P5kf8QzLrDotBClqNmhO+tZpxCwC1K69P2bk1J
         DSR63mJwu57lsyUm8sjZv1CqSyMvJvMwNy6o9ELSPh2UdM2bVjfNA1+F4NUKYiXcrb3X
         8bUu7QGJbpkb8qHWeSzKsZ5qhXTxtmauGydQ60t8cWQX0N5KZyAnIisHArUfo2x8Qryy
         ORvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YHaY3VzzTKl05Ylig5G4revSeCBrE0n2SgEWey+VV4c=;
        b=d8yAMePAWuAliGEZsTGvo6raPKfwriyMjnwQA5uJgZ+7PfoUxZVJmFAsv1DnOws2K3
         9SpohhGqxAVu9hPDdUYgsocxpbwQ7YtbSX2wxH1PYZmhATE0FcqcT/uJ9y3Nz7wXKmBk
         K8UBrA7qB2CsVKjjNnk6ASSlBG4JKlAgvgjZmQRMuISa5QjOqmPA2AoB4hnANspb7aza
         YHgO7lITLS9gcXqdr3J3V31QOtB9biHBGJUZe3xGCrC6MpFRtBKBZS4X6kR6RhcFOtpX
         6gbsbeqlvBhEzNy7D+9iBNcSF3CUI6eR/1qmcSTD/NcKgo5npxmSupnBtKECcrFvjlW4
         PyaA==
X-Gm-Message-State: AOAM530WbxAPbtnL/MgTgTzU6C4MSki65sfFLVIqMrqOvokdotGE4dvt
        wcHuJyI1f1eoSsDzpOCyqA0=
X-Google-Smtp-Source: ABdhPJzsEPBimYWFMWXuaEdMh9q0tebRm3TOASpMfV8I3pGO3mHPFBU2WdI48Hy0Ww1RHk20d2n66A==
X-Received: by 2002:a05:6a00:e8e:b0:4fa:a52f:59cf with SMTP id bo14-20020a056a000e8e00b004faa52f59cfmr16610949pfb.84.1652694450244;
        Mon, 16 May 2022 02:47:30 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709026e1700b0015e8d4eb1ffsm6639952plk.73.2022.05.16.02.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 02:47:29 -0700 (PDT)
Date:   Mon, 16 May 2022 17:47:26 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+ad1b8c404f0959c4bfcc@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/mempolicy: fix uninit-value in mpol_rebind_policy()
Message-ID: <20220516094726.b5rrsjg7rvei2od5@ppc.localdomain>
References: <20220512123428.fq3wofedp6oiotd4@ppc.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512123428.fq3wofedp6oiotd4@ppc.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 22/05/12 08:34PM, Wang Cheng wrote:
> mpol_set_nodemask()(mm/mempolicy.c) does not set up nodemask when
> pol->mode is MPOL_LOCAL. Check pol->mode before access
> pol->w.cpuset_mems_allowed in mpol_rebind_policy()(mm/mempolicy.c).
> 
> BUG: KMSAN: uninit-value in mpol_rebind_policy mm/mempolicy.c:352 [inline]
> BUG: KMSAN: uninit-value in mpol_rebind_task+0x2ac/0x2c0 mm/mempolicy.c:368
>  mpol_rebind_policy mm/mempolicy.c:352 [inline]
>  mpol_rebind_task+0x2ac/0x2c0 mm/mempolicy.c:368
>  cpuset_change_task_nodemask kernel/cgroup/cpuset.c:1711 [inline]
>  cpuset_attach+0x787/0x15e0 kernel/cgroup/cpuset.c:2278
>  cgroup_migrate_execute+0x1023/0x1d20 kernel/cgroup/cgroup.c:2515
>  cgroup_migrate kernel/cgroup/cgroup.c:2771 [inline]
>  cgroup_attach_task+0x540/0x8b0 kernel/cgroup/cgroup.c:2804
>  __cgroup1_procs_write+0x5cc/0x7a0 kernel/cgroup/cgroup-v1.c:520
>  cgroup1_tasks_write+0x94/0xb0 kernel/cgroup/cgroup-v1.c:539
>  cgroup_file_write+0x4c2/0x9e0 kernel/cgroup/cgroup.c:3852
>  kernfs_fop_write_iter+0x66a/0x9f0 fs/kernfs/file.c:296
>  call_write_iter include/linux/fs.h:2162 [inline]
>  new_sync_write fs/read_write.c:503 [inline]
>  vfs_write+0x1318/0x2030 fs/read_write.c:590
>  ksys_write+0x28b/0x510 fs/read_write.c:643
>  __do_sys_write fs/read_write.c:655 [inline]
>  __se_sys_write fs/read_write.c:652 [inline]
>  __x64_sys_write+0xdb/0x120 fs/read_write.c:652
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Uninit was created at:
>  slab_post_alloc_hook mm/slab.h:524 [inline]
>  slab_alloc_node mm/slub.c:3251 [inline]
>  slab_alloc mm/slub.c:3259 [inline]
>  kmem_cache_alloc+0x902/0x11c0 mm/slub.c:3264
>  mpol_new mm/mempolicy.c:293 [inline]
>  do_set_mempolicy+0x421/0xb70 mm/mempolicy.c:853
>  kernel_set_mempolicy mm/mempolicy.c:1504 [inline]
>  __do_sys_set_mempolicy mm/mempolicy.c:1510 [inline]
>  __se_sys_set_mempolicy+0x44c/0xb60 mm/mempolicy.c:1507
>  __x64_sys_set_mempolicy+0xd8/0x110 mm/mempolicy.c:1507
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> KMSAN: uninit-value in mpol_rebind_task (2)
> https://syzkaller.appspot.com/bug?id=d6eb90f952c2a5de9ea718a1b873c55cb13b59dc
> 
> Reported-and-tested-by: syzbot+217f792c92599518a2ab@syzkaller.appspotmail.com
> Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
> ---
> The uninit-value is pol->w.cpuset_mems_allowed in
> mpol_rebind_policy().
> 
> While syzkaller reproducer runs, I notice pol->mode is 4(MPOL_LOCAL) in
>     mpol_set_nodemask()
>   do_set_mempolicy()(mm/mempolicy.c)
> that `nodemask` in `pol` is not initialized, which will be accessed in
> mpol_rebind_policy().
> 
>  mm/mempolicy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 10e9c87260ed..18b74f02da71 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -347,7 +347,7 @@ static void mpol_rebind_preferred(struct mempolicy *pol,
>   */
>  static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
>  {
> -	if (!pol)
> +	if (!pol || pol->mode == MPOL_LOCAL)
>  		return;
>  	if (!mpol_store_user_nodemask(pol) &&
>  	    nodes_equal(pol->w.cpuset_mems_allowed, *newmask))
> -- 
> 2.30.2
>

Hi Andrew,

Thank you for fixing the commit message.

This patch seems to fix below bug too.
KMSAN: uninit-value in mpol_rebind_mm (2)
https://syzkaller.appspot.com/bug?id=f2fecd0d7013f54ec4162f60743a2b28df40926b

The uninit-value is pol->w.cpuset_mems_allowed in mpol_rebind_policy().
When syzkaller reproducer runs to the beginning of mpol_new(),

	    mpol_new() mm/mempolicy.c
	  do_mbind() mm/mempolicy.c
	kernel_mbind() mm/mempolicy.c

`mode` is 1(MPOL_PREFERRED), nodes_empty(*nodes) is `true` and `flags`
is 0. Then

	mode = MPOL_LOCAL;
	...
	policy->mode = mode;
	policy->flags = flags;

will be executed. So in mpol_set_nodemask(),

	    mpol_set_nodemask() mm/mempolicy.c
	  do_mbind()
	kernel_mbind()

pol->mode is 4(MPOL_LOCAL), that `nodemask` in `pol` is not initialized,
which will be accessed in mpol_rebind_policy().

IIUC, "#syz fix: mm/mempolicy: fix uninit-value in mpol_rebind_policy()"
could be sent to syzbot+ad1b8c404f0959c4bfcc@syzkaller.appspotmail.com
to attach the fixing commit to the bug. WDYT?

thanks,
- w

