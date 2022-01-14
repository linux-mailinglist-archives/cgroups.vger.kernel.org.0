Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0454748EE09
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 17:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243315AbiANQXQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 11:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243318AbiANQXP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 11:23:15 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701F6C06161C
        for <cgroups@vger.kernel.org>; Fri, 14 Jan 2022 08:23:15 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso22575289pje.0
        for <cgroups@vger.kernel.org>; Fri, 14 Jan 2022 08:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WMPE+WU1bNdjA6o7ZbSZsATOGsvK5p4vgAdRPhBadPc=;
        b=fl3KdIZfValLjKA1E6wedckpa7NV+PNpEFoj8oa3STd5ZQLHS2aaTMEzMBmBSb3wq+
         o2gSaeZoO/8yPFDBpMhj3fGtAl10cJAhdLkfZ3VlRS3Kp0JpapU/FH3thd8kytE1VF09
         XECH6TqRirWgstwCobE9daj33k00FkiAhGF+zZKjuBcUBNYFpnfs0AznIxM1jMLHcFs5
         BVUUOsfQiJ3Co1FtHATSSi9LK7LbADoVuuSYvS96Osbk0g05tLOGJML3L05USTsHWWu+
         MTNgsI4GX+KaZgsnRZCGm0ah5cOQ62Mv2h1EbKrtQzs5UKbDJq9EwF7MbJyf7VgLS8n3
         V8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WMPE+WU1bNdjA6o7ZbSZsATOGsvK5p4vgAdRPhBadPc=;
        b=R39UeBryRQLUa8dPg33EmFfoYIWkpG0sQg2qZrxwgfZAx1jBgTleNsHFQm9PajMrzG
         3Ep92VFh5eFMfZR5qsc9mo2Ljrlg+rIq00U+kWIDhBWCGi9hbLOtpGvzfLvXQSjdvs5b
         u0oVKICluT9I/5p+AqMIBo7synLYlflhrCtrtuaGOhytzKHLNRGX/v741frycKiTOQdP
         bi5HIrv0RF3p+GA+5KXL41WKShbQ28Qvb/KXlhhzXsP8eWNKU0La41Jn7pUE4ZG8PyDR
         dHDfVr+6wArwcXw6Z6Do2V+gfeuKT2THaxNgrQGn6DqweJuQrj4PeGD4LXxITG/Q0bNC
         xGzQ==
X-Gm-Message-State: AOAM530JgD4PPzVynli/Zw2I8BE6nwxvFGpAxSVpZDKWH3vs0TNn8pI1
        LRny2nKgvhd9Sm9chk1AG68=
X-Google-Smtp-Source: ABdhPJxu546PerKJs7qQiFSTh9hIC7+Vs3tRH15QSqaFf1N7Y7ak994n9gGwe4pZaG/Y4fNE35/eYw==
X-Received: by 2002:a17:902:ee55:b0:14a:357e:74d5 with SMTP id 21-20020a170902ee5500b0014a357e74d5mr10528504plo.50.1642177394692;
        Fri, 14 Jan 2022 08:23:14 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id nv10sm1505268pjb.33.2022.01.14.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 08:23:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 14 Jan 2022 06:23:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: Re: LTP test suite triggers LOCKDEP_CIRCULAR on linux-next
Message-ID: <YeGjcF6CU/R6cyec@slm.duckdns.org>
References: <87mtjzslv7.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtjzslv7.fsf@oc8242746057.ibm.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Roman, does this ring a bell?

On Thu, Jan 13, 2022 at 04:20:44PM +0100, Alexander Egorenkov wrote:
> 
> Hi,
> 
> our daily CI linux-next test reported the following finding on s390x arch:
> 
> 	 LOCKDEP_CIRCULAR (suite: ltp, case: mtest06 (mmap1))
> 		 WARNING: possible circular locking dependency detected
> 		 5.17.0-20220113.rc0.git0.f2211f194038.300.fc35.s390x+debug #1 Not tainted
> 		 ------------------------------------------------------
> 		 mmap1/202299 is trying to acquire lock:
> 		 00000001892c0188 (css_set_lock){..-.}-{2:2}, at: obj_cgroup_release+0x4a/0xe0
> 		 but task is already holding lock:
> 		 00000000ca3b3818 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x38/0x180
> 		 which lock already depends on the new lock.
> 		 the existing dependency chain (in reverse order) is:
> 		 -> #1 (&sighand->siglock){-.-.}-{2:2}:
> 			__lock_acquire+0x604/0xbd8
> 			lock_acquire.part.0+0xe2/0x238
> 			lock_acquire+0xb0/0x200
> 			_raw_spin_lock_irqsave+0x6a/0xd8
> 			__lock_task_sighand+0x90/0x190
> 			cgroup_freeze_task+0x2e/0x90
> 			cgroup_migrate_execute+0x11c/0x608
> 			cgroup_update_dfl_csses+0x246/0x270
> 			cgroup_subtree_control_write+0x238/0x518
> 			kernfs_fop_write_iter+0x13e/0x1e0
> 			new_sync_write+0x100/0x190
> 			vfs_write+0x22c/0x2d8
> 			ksys_write+0x6c/0xf8
> 			__do_syscall+0x1da/0x208
> 			system_call+0x82/0xb0
> 		 -> #0 (css_set_lock){..-.}-{2:2}:
> 			check_prev_add+0xe0/0xed8
> 			validate_chain+0x736/0xb20
> 			__lock_acquire+0x604/0xbd8
> 			lock_acquire.part.0+0xe2/0x238
> 			lock_acquire+0xb0/0x200
> 			_raw_spin_lock_irqsave+0x6a/0xd8
> 			obj_cgroup_release+0x4a/0xe0
> 			percpu_ref_put_many.constprop.0+0x150/0x168
> 			drain_obj_stock+0x94/0xe8
> 			refill_obj_stock+0x94/0x278
> 			obj_cgroup_charge+0x164/0x1d8
> 			kmem_cache_alloc+0xac/0x528
> 			__sigqueue_alloc+0x150/0x308
> 			__send_signal+0x260/0x550
> 			send_signal+0x7e/0x348
> 			force_sig_info_to_task+0x104/0x180
> 			force_sig_fault+0x48/0x58
> 			__do_pgm_check+0x120/0x1f0
> 			pgm_check_handler+0x11e/0x180
> 		 other info that might help us debug this:
> 		  Possible unsafe locking scenario:
> 			CPU0                    CPU1
> 			----                    ----
> 		   lock(&sighand->siglock);
> 						lock(css_set_lock);
> 						lock(&sighand->siglock);
> 		   lock(css_set_lock);
> 		  *** DEADLOCK ***
> 		 2 locks held by mmap1/202299:
> 		  #0: 00000000ca3b3818 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x38/0x180
> 		  #1: 00000001892ad560 (rcu_read_lock){....}-{1:2}, at: percpu_ref_put_many.constprop.0+0x0/0x168
> 		 stack backtrace:
> 		 CPU: 15 PID: 202299 Comm: mmap1 Not tainted 5.17.0-20220113.rc0.git0.f2211f194038.300.fc35.s390x+debug #1
> 		 Hardware name: IBM 3906 M04 704 (LPAR)
> 		 Call Trace:
> 		  [<00000001888aacfe>] dump_stack_lvl+0x76/0x98 
> 		  [<0000000187c6d7be>] check_noncircular+0x136/0x158 
> 		  [<0000000187c6e888>] check_prev_add+0xe0/0xed8 
> 		  [<0000000187c6fdb6>] validate_chain+0x736/0xb20 
> 		  [<0000000187c71e54>] __lock_acquire+0x604/0xbd8 
> 		  [<0000000187c7301a>] lock_acquire.part.0+0xe2/0x238 
> 		  [<0000000187c73220>] lock_acquire+0xb0/0x200 
> 		  [<00000001888bf9aa>] _raw_spin_lock_irqsave+0x6a/0xd8 
> 		  [<0000000187ef6862>] obj_cgroup_release+0x4a/0xe0 
> 		  [<0000000187ef6498>] percpu_ref_put_many.constprop.0+0x150/0x168 
> 		  [<0000000187ef9674>] drain_obj_stock+0x94/0xe8 
> 		  [<0000000187efa464>] refill_obj_stock+0x94/0x278 
> 		  [<0000000187eff55c>] obj_cgroup_charge+0x164/0x1d8 
> 		  [<0000000187ed8aa4>] kmem_cache_alloc+0xac/0x528 
> 		  [<0000000187bf2eb8>] __sigqueue_alloc+0x150/0x308 
> 		  [<0000000187bf4210>] __send_signal+0x260/0x550 
> 		  [<0000000187bf5f06>] send_signal+0x7e/0x348 
> 		  [<0000000187bf7274>] force_sig_info_to_task+0x104/0x180 
> 		  [<0000000187bf7758>] force_sig_fault+0x48/0x58 
> 		  [<00000001888ae160>] __do_pgm_check+0x120/0x1f0 
> 		  [<00000001888c0cde>] pgm_check_handler+0x11e/0x180 
> 		 INFO: lockdep is turned off.
> 
> 
> Regards
> Alex

-- 
tejun
