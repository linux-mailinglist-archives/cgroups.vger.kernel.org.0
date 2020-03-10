Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C7617F412
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2020 10:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgCJJsl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Mar 2020 05:48:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34132 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgCJJsk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Mar 2020 05:48:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id z15so14957741wrl.1;
        Tue, 10 Mar 2020 02:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e+4+q3tBPeSakzLbgRWCQK4gOR8PDIS0+RGcMO8Rfpc=;
        b=eLD/cncseoqOWgyzzM1V7gmb8t5VE825w4IX3eXg6Jm1/nzO4FJspOu0Uvud05PXzn
         nzOh6zeofmYDqiOhCFxwHuVESi73J1Ft4wj2W2TBMYzMFyOlWEUVimc1sLGtUmMlW7HZ
         NsY3rblr/1vGSl23oqu1SqXE5hS4hPkVNX3AQ1jZWoGXwh073ygWSvHpCsucH7slVRMR
         uelUvb56NfoAXl0w2kOawtT/N21Y6VI/FpDQb4jBHByj5etnHVJivziwl19SOjGZLA2j
         5xaNPngzQstSHUpEtWPjxDBPOn6y65bCK/8yajlJ5mYHBbcs1fdzTiULhfZEDILIXf+C
         92qQ==
X-Gm-Message-State: ANhLgQ0BsOKpPBSotFrll3mCXgAvgLP0mPbm2Jkgcs7cT9+pcI8cKS1H
        3/gI5d488QsMVZObm/HJjebmxNAh
X-Google-Smtp-Source: ADFU+vvQ9U5ebYXUs0B/jnFtpUo9X8N9a+PmUrzOLRUCDtZF/cqq+adIDAY3B0XcphphqsOT4NVuRw==
X-Received: by 2002:a5d:5512:: with SMTP id b18mr25951308wrv.215.1583833718510;
        Tue, 10 Mar 2020 02:48:38 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id f15sm3321283wmj.25.2020.03.10.02.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 02:48:37 -0700 (PDT)
Date:   Tue, 10 Mar 2020 10:48:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] memcg: fix NULL pointer dereference in
 __mem_cgroup_usage_unregister_event
Message-ID: <20200310094836.GD8447@dhcp22.suse.cz>
References: <077a6f67-aefa-4591-efec-f2f3af2b0b02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <077a6f67-aefa-4591-efec-f2f3af2b0b02@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[Cc Kirill, I didn't realize he has implemented this code]

On Fri 06-03-20 09:02:02, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> An eventfd monitors multiple memory thresholds of the cgroup, closes them,
> the kernel deletes all events related to this eventfd. Before all events
> are deleted, another eventfd monitors the memory threshold of this cgroup,
> leading to a crash:
> 
> [  135.675108] BUG: kernel NULL pointer dereference, address: 0000000000000004
> [  135.675350] #PF: supervisor write access in kernel mode
> [  135.675579] #PF: error_code(0x0002) - not-present page
> [  135.675816] PGD 800000033058e067 P4D 800000033058e067 PUD 3355ce067 PMD 0
> [  135.676080] Oops: 0002 [#1] SMP PTI
> [  135.676332] CPU: 2 PID: 14012 Comm: kworker/2:6 Kdump: loaded Not tainted 5.6.0-rc4 #3
> [  135.676610] Hardware name: LENOVO 20AWS01K00/20AWS01K00, BIOS GLET70WW (2.24 ) 05/21/2014
> [  135.676909] Workqueue: events memcg_event_remove
> [  135.677192] RIP: 0010:__mem_cgroup_usage_unregister_event+0xb3/0x190
> [  135.677825] RSP: 0018:ffffb47e01c4fe18 EFLAGS: 00010202
> [  135.678186] RAX: 0000000000000001 RBX: ffff8bb223a8a000 RCX: 0000000000000001
> [  135.678548] RDX: 0000000000000001 RSI: ffff8bb22fb83540 RDI: 0000000000000001
> [  135.678912] RBP: ffffb47e01c4fe48 R08: 0000000000000000 R09: 0000000000000010
> [  135.679287] R10: 000000000000000c R11: 071c71c71c71c71c R12: ffff8bb226aba880
> [  135.679670] R13: ffff8bb223a8a480 R14: 0000000000000000 R15: 0000000000000000
> [  135.680066] FS:  0000000000000000(0000) GS:ffff8bb242680000(0000) knlGS:0000000000000000
> [  135.680475] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  135.680894] CR2: 0000000000000004 CR3: 000000032c29c003 CR4: 00000000001606e0
> [  135.681325] Call Trace:
> [  135.681763]  memcg_event_remove+0x32/0x90
> [  135.682209]  process_one_work+0x172/0x380
> [  135.682657]  worker_thread+0x49/0x3f0
> [  135.683111]  kthread+0xf8/0x130
> [  135.683570]  ? max_active_store+0x80/0x80
> [  135.684034]  ? kthread_bind+0x10/0x10
> [  135.684506]  ret_from_fork+0x35/0x40
> [  135.689733] CR2: 0000000000000004
> 
> We can reproduce this problem in the following ways:
>  
> 1. We create a new cgroup subdirectory and a new eventfd, and then we
>    monitor multiple memory thresholds of the cgroup through this eventfd.
> 2. closing this eventfd, and __mem_cgroup_usage_unregister_event () will be
>    called multiple times to delete all events related to this eventfd.
> 
> The first time __mem_cgroup_usage_unregister_event() is called, the kernel
> will clear all items related to this eventfd in thresholds-> primary.Since
> there is currently only one eventfd, thresholds-> primary becomes empty,
> so the kernel will set thresholds-> primary and hresholds-> spare to NULL.
> If at this time, the user creates a new eventfd and monitor the memory
> threshold of this cgroup, kernel will re-initialize thresholds-> primary.
> Then when __mem_cgroup_usage_unregister_event () is called for the second
> time, because thresholds-> primary is not empty, the system will access
> thresholds-> spare, but thresholds-> spare is NULL, which will trigger a
> crash.
> 
> In general, the longer it takes to delete all events related to this
> eventfd, the easier it is to trigger this problem.
> 
> The solution is to check whether the thresholds associated with the eventfd
> has been cleared when deleting the event. If so, we do nothing.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

The fix looks reasonable to me
Acked-by: Michal Hocko <mhocko@suse.com>

It seems that the code has been broken since 2c488db27b61 ("memcg: clean
up memory thresholds"). We've had 371528caec55 ("mm: memcg: Correct
unregistring of events attached to the same eventfd") but it didn't
catch this case for some reason. Unless I am missing something the code
was broken back then already. Kirill please double check after me.

So if I am not wrong then we want
Fixes: 2c488db27b61 ("memcg: clean up memory thresholds")
Cc: stable

sounds appropriate because this seems to be user trigerable.

Thanks for preparing the patch!

Btw. you should double check your email sender because it seemed to
whitespace damaged the patch (\t -> spaces). Please use git send-email
instead.

> ---
>  mm/memcontrol.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d09776c..4575a58 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4027,7 +4027,7 @@ static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
>      struct mem_cgroup_thresholds *thresholds;
>      struct mem_cgroup_threshold_ary *new;
>      unsigned long usage;
> -    int i, j, size;
> +    int i, j, size, entries;
>  
>      mutex_lock(&memcg->thresholds_lock);
>  
> @@ -4047,12 +4047,18 @@ static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
>      __mem_cgroup_threshold(memcg, type == _MEMSWAP);
>  
>      /* Calculate new number of threshold */
> -    size = 0;
> +    size = entries = 0;
>      for (i = 0; i < thresholds->primary->size; i++) {
>          if (thresholds->primary->entries[i].eventfd != eventfd)
>              size++;
> +        else
> +            entries++;
>      }
>  
> +    /* If items related to eventfd have been cleared, nothing to do */
> +    if (!entries)
> +        goto unlock;
> +
>      new = thresholds->spare;
>  
>      /* Set thresholds array to NULL if we don't have thresholds */
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
