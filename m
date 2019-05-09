Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9780518C91
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2019 16:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfEIO7z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 May 2019 10:59:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41514 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfEIO7y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 May 2019 10:59:54 -0400
Received: by mail-qk1-f193.google.com with SMTP id g190so1624097qkf.8;
        Thu, 09 May 2019 07:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4gjHH6OYdovENGKv9IjwwO4ODZYrK1/UA7BvRASYLNI=;
        b=ayPSsWC0hR8g3mnVVrm+gQZmYbe42qhRJXMZYN7ygfB92Wm/rOAOjjrvjb/6q4fUsl
         Lyv9bzDlEqFyLPcOJ7xiIaOBB22MPJpS+EfmN6P8J8pq8v/m5YgUqwtpARAdWnqd+dvP
         mSsm0qZoa7YrHEQoYbTlpwrPKuBV9EzdYYfe+0BACLO3heXSQo6AXtFd+yqVafsqZ90F
         KnT3W5xoQMuRKttdtZlLiBTJ67VBhggvbdAAwXrUGCUZvSyC909x5JX9KzENIYK/A0T/
         DMGi8VhyeDsNLpSJ01yy0Tvh58H4nfxyN1ITN+jtfYWb5NA+2KqyRaW1af+fgazMkW2G
         WfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4gjHH6OYdovENGKv9IjwwO4ODZYrK1/UA7BvRASYLNI=;
        b=QbbvEJsW6YPeuRXl7GbBj2Pmm+gYBqrwMnxZYJY87pNW6fbPW/cYxQl/mSMzK0OzZL
         MObM79yJXOlFcbx3v/Yd7VQ8TbU1fFpZk9cvIMJn0DjhkIfvaKNmhlfIGlC9BBsqgf0H
         9anzqr/Wcj49q9n9DrmHJ8zAKl2XV7a8lvs8NxUMKVr1gAZqCHC4sX3/IH2SzPnv5zsr
         aUBYRuvvtl4E8QZzpiglvQOUg1j+utnYwGr9HT+WGoSZSPDxALMTFM2JjEIlLIVTonKQ
         HCpAgE4r0/1rygm0TOT4+T0oW51y1DuP1I76PH+Ti2Zd8vdIXc2uDL25eXvZ+OoHlixa
         w7Cw==
X-Gm-Message-State: APjAAAU1zGWAXA+CGWkUlIJOYS0Z0+TXMq9Tj8d5aqOL0KoJXRRQslnR
        7Ka/bM9qBq42ksObtJUx2eE=
X-Google-Smtp-Source: APXvYqw+TWBoOVTjrbLlCjTBgfg0fnuiq+rbpYtl/1hunt8oRsdn+hey5vud63/GdfuOr6EVh8aRlw==
X-Received: by 2002:a37:b802:: with SMTP id i2mr3484347qkf.343.1557413993211;
        Thu, 09 May 2019 07:59:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c346])
        by smtp.gmail.com with ESMTPSA id k53sm1301341qtb.65.2019.05.09.07.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 07:59:52 -0700 (PDT)
Date:   Thu, 9 May 2019 07:59:49 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] cgroup: never call do_group_exit() with task->frozen bit
 set
Message-ID: <20190509145949.GU374014@devbig004.ftw2.facebook.com>
References: <20190508203420.580163-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508203420.580163-1-guro@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 08, 2019 at 01:34:20PM -0700, Roman Gushchin wrote:
> I've got two independent reports that cgroup_task_frozen() check
> in cgroup_exit() has been triggered by lkp libhugetlbfs-test and
> LTP ptrace01 tests.
> 
> For example:
> [   44.576072] WARNING: CPU: 1 PID: 3028 at kernel/cgroup/cgroup.c:5932 cgroup_exit+0x148/0x160
> [   44.577724] Modules linked in: crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sr_mod cdrom
> bochs_drm sg ttm ata_generic pata_acpi ppdev drm_kms_helper snd_pcm syscopyarea aesni_intel snd_timer
> sysfillrect sysimgblt snd crypto_simd cryptd glue_helper soundcore fb_sys_fops joydev drm serio_raw pcspkr
> ata_piix libata i2c_piix4 floppy parport_pc parport ip_tables
> [   44.583106] CPU: 1 PID: 3028 Comm: ptrace-write-hu Not tainted 5.1.0-rc3-00053-g9262503 #5
> [   44.584600] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   44.586116] RIP: 0010:cgroup_exit+0x148/0x160
> [   44.587135] Code: 0f 84 50 ff ff ff 48 8b 85 c8 0c 00 00 48 8b 78 70 e8 ec 2e 00 00 e9 3b ff ff ff f0 ff 43 60
> 0f 88 72 21 89 00 e9 48 ff ff ff <0f> 0b e9 1b ff ff ff e8 3c 73 f4 ff 66 90 66 2e 0f 1f 84 00 00 00
> [   44.590113] RSP: 0018:ffffb25702dcfd30 EFLAGS: 00010002
> [   44.591167] RAX: ffff96a7fee32410 RBX: ffff96a7ff1d6000 RCX: dead000000000200
> [   44.592446] RDX: ffff96a7ff1d6080 RSI: ffff96a7fec75290 RDI: ffff96a7fec75290
> [   44.593715] RBP: ffff96a7fec745c0 R08: ffff96a7fec74658 R09: 0000000000000000
> [   44.594985] R10: 0000000000000000 R11: 0000000000000001 R12: ffff96a7fec75101
> [   44.596266] R13: ffff96a7fec745c0 R14: ffff96a7ff3bde30 R15: ffff96a7fec75130
> [   44.597550] FS:  0000000000000000(0000) GS:ffff96a7dd700000(0000) knlGS:0000000000000000
> [   44.598950] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [   44.600098] CR2: 00000000f7a00000 CR3: 000000000d20e000 CR4: 00000000000406e0
> [   44.601417] Call Trace:
> [   44.602777]  do_exit+0x337/0xc40
> [   44.603677]  do_group_exit+0x3a/0xa0
> [   44.604610]  get_signal+0x12e/0x8d0
> [   44.605533]  ? __switch_to_asm+0x40/0x70
> [   44.606503]  do_signal+0x36/0x650
> [   44.607409]  ? __switch_to_asm+0x40/0x70
> [   44.608383]  ? __schedule+0x267/0x860
> [   44.609329]  exit_to_usermode_loop+0x89/0xf0
> [   44.610349]  do_fast_syscall_32+0x251/0x2e3
> [   44.611357]  entry_SYSENTER_compat+0x7f/0x91
> [   44.612376] ---[ end trace e4ca5cfc4b7f7964 ]---
> 
> The problem is caused by the ptrace_signal() call in the for loop
> in get_signal(). There is a cgroup_enter_frozen() call inside
> ptrace_signal(), so after exit from ptrace_signal() the task->frozen
> bit might be set. In this case do_group_exit() can be called with the
> task->frozen bit set and trigger the warning. This is only place where
> we can leave the loop with the task->frozen bit set and without
> setting JOBCTL_TRAP_FREEZE and TIF_SIGPENDING.
> 
> To resolve this problem, let's move cgroup_leave_frozen(true) call to
> just after the fatal label. If the task is going to die, the frozen
> bit must be cleared no matter how we get into this point.
> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Applied to cgroup/for-5.2 for now.

Thanks.

-- 
tejun
