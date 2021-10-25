Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E2C43981C
	for <lists+cgroups@lfdr.de>; Mon, 25 Oct 2021 16:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhJYOJh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Oct 2021 10:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhJYOJg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Oct 2021 10:09:36 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265F4C061745
        for <cgroups@vger.kernel.org>; Mon, 25 Oct 2021 07:07:14 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id t7-20020a4aadc7000000b002b8733ab498so1900661oon.3
        for <cgroups@vger.kernel.org>; Mon, 25 Oct 2021 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=kDzqDk02jjGLZUoZ4bS2zC6bmwxuZbbhnUm06hNeRU0=;
        b=mg57l1eRjjhfCyqn/1M2bGZqoa9qHVsaCvynpdtyiCN4id1rFKBpkAAJ0l8dNle87j
         a6xwTKyfjTKpkRRF8VCgaM7joIdasOYSkp/zlm6JmguJcRGZ/mLmtCmfTmwu0xZzAehF
         K673Yghp3Uv6Ra+Kfh92YMXrpOtuNQIpdY3UnbiyMtn0peZFYvq1qy0FEJnxkA/uHsp8
         VWcJE6+6A1nBPd+Ced/zQMn0DYD+sMKcxJk1G2wqGiCOPJARkE0lcFSJJyk06xNK2CiP
         /yrqVf3xP9oIpgkkWpBWoxDCfeJvWrnOYZAqzODrLq71L4xI637N3F8Q6nhkDjpXYdin
         lH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=kDzqDk02jjGLZUoZ4bS2zC6bmwxuZbbhnUm06hNeRU0=;
        b=m3NsE9da/EsZOteuYTDYYZI+sHodMM2yxy5UmrriOcbTWlDRrpiQkU3f4O4ROxKYb2
         BHmJz2FUf1I5QpIEiaXgnXedZNJtXHkRqEki1xptrj7siIgPFgveXrYiXaVfc5VMA75A
         3lWHL1KDUzkhbmsvp3Y2V5gjOGyPVTZVQDCjuc4PERM0GYrnJvQM+I1Fx9lBq1dHxf6r
         y9e75Ck9aUbXZxl/T7X5/uRYZA/K0KZ2fJZrmEIC+yEYKf5i4YaxDdUxu/ZRPmxUUF4J
         xiofceyoYSbOiKmQ/0sXZYjJYOQYz34VvOgNUTNO+mrImyZfG0QAbJfoC4IxNlLUAWCJ
         pb3Q==
X-Gm-Message-State: AOAM531MPCzbOxk6Ptm0YIJC9UB8g+AkSguEtuvirUPE+6QG8yYfuW6d
        7wob1QcnzftJFELSzR2EL4a8Nw==
X-Google-Smtp-Source: ABdhPJxFIAzJkscm2yB6G9tMnVOVHME7z5Vb1ICc/+Vnz5Uaj4YXWPJgGfJ3gGT6AX0tJLhrm24SSA==
X-Received: by 2002:a4a:52ce:: with SMTP id d197mr12178711oob.83.1635170833420;
        Mon, 25 Oct 2021 07:07:13 -0700 (PDT)
Received: from [127.0.1.1] ([2600:380:6060:12a6:721f:26e:6f8:a9aa])
        by smtp.gmail.com with ESMTPSA id a1sm3538821oti.30.2021.10.25.07.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:07:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Yu Kuai <yukuai3@huawei.com>,
        avanzini.arianna@gmail.com, fchecconi@gmail.com,
        paolo.valente@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        yi.zhang@huawei.com, cgroups@vger.kernel.org
In-Reply-To: <20211020014036.2141723-1-yukuai3@huawei.com>
References: <20211020014036.2141723-1-yukuai3@huawei.com>
Subject: Re: [PATCH v4] blk-cgroup: synchoronize blkg creation against policy deactivation
Message-Id: <163517083229.164887.15484331314458434649.b4-ty@kernel.dk>
Date:   Mon, 25 Oct 2021 08:07:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 20 Oct 2021 09:40:36 +0800, Yu Kuai wrote:
> Out test report a null pointer dereference:
> 
> [  168.534653] ==================================================================
> [  168.535614] Disabling lock debugging due to kernel taint
> [  168.536346] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [  168.537274] #PF: supervisor read access in kernel mode
> [  168.537964] #PF: error_code(0x0000) - not-present page
> [  168.538667] PGD 0 P4D 0
> [  168.539025] Oops: 0000 [#1] PREEMPT SMP KASAN
> [  168.539656] CPU: 13 PID: 759 Comm: bash Tainted: G    B             5.15.0-rc2-next-202100
> [  168.540954] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_0738364
> [  168.542736] RIP: 0010:bfq_pd_init+0x88/0x1e0
> [  168.543318] Code: 98 00 00 00 e8 c9 e4 5b ff 4c 8b 65 00 49 8d 7c 24 08 e8 bb e4 5b ff 4d0
> [  168.545803] RSP: 0018:ffff88817095f9c0 EFLAGS: 00010002
> [  168.546497] RAX: 0000000000000001 RBX: ffff888101a1c000 RCX: 0000000000000000
> [  168.547438] RDX: 0000000000000003 RSI: 0000000000000002 RDI: ffff888106553428
> [  168.548402] RBP: ffff888106553400 R08: ffffffff961bcaf4 R09: 0000000000000001
> [  168.549365] R10: ffffffffa2e16c27 R11: fffffbfff45c2d84 R12: 0000000000000000
> [  168.550291] R13: ffff888101a1c098 R14: ffff88810c7a08c8 R15: ffffffffa55541a0
> [  168.551221] FS:  00007fac75227700(0000) GS:ffff88839ba80000(0000) knlGS:0000000000000000
> [  168.552278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  168.553040] CR2: 0000000000000008 CR3: 0000000165ce7000 CR4: 00000000000006e0
> [  168.554000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  168.554929] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  168.555888] Call Trace:
> [  168.556221]  <TASK>
> [  168.556510]  blkg_create+0x1c0/0x8c0
> [  168.556989]  blkg_conf_prep+0x574/0x650
> [  168.557502]  ? stack_trace_save+0x99/0xd0
> [  168.558033]  ? blkcg_conf_open_bdev+0x1b0/0x1b0
> [  168.558629]  tg_set_conf.constprop.0+0xb9/0x280
> [  168.559231]  ? kasan_set_track+0x29/0x40
> [  168.559758]  ? kasan_set_free_info+0x30/0x60
> [  168.560344]  ? tg_set_limit+0xae0/0xae0
> [  168.560853]  ? do_sys_openat2+0x33b/0x640
> [  168.561383]  ? do_sys_open+0xa2/0x100
> [  168.561877]  ? __x64_sys_open+0x4e/0x60
> [  168.562383]  ? __kasan_check_write+0x20/0x30
> [  168.562951]  ? copyin+0x48/0x70
> [  168.563390]  ? _copy_from_iter+0x234/0x9e0
> [  168.563948]  tg_set_conf_u64+0x17/0x20
> [  168.564467]  cgroup_file_write+0x1ad/0x380
> [  168.565014]  ? cgroup_file_poll+0x80/0x80
> [  168.565568]  ? __mutex_lock_slowpath+0x30/0x30
> [  168.566165]  ? pgd_free+0x100/0x160
> [  168.566649]  kernfs_fop_write_iter+0x21d/0x340
> [  168.567246]  ? cgroup_file_poll+0x80/0x80
> [  168.567796]  new_sync_write+0x29f/0x3c0
> [  168.568314]  ? new_sync_read+0x410/0x410
> [  168.568840]  ? __handle_mm_fault+0x1c97/0x2d80
> [  168.569425]  ? copy_page_range+0x2b10/0x2b10
> [  168.570007]  ? _raw_read_lock_bh+0xa0/0xa0
> [  168.570622]  vfs_write+0x46e/0x630
> [  168.571091]  ksys_write+0xcd/0x1e0
> [  168.571563]  ? __x64_sys_read+0x60/0x60
> [  168.572081]  ? __kasan_check_write+0x20/0x30
> [  168.572659]  ? do_user_addr_fault+0x446/0xff0
> [  168.573264]  __x64_sys_write+0x46/0x60
> [  168.573774]  do_syscall_64+0x35/0x80
> [  168.574264]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  168.574960] RIP: 0033:0x7fac74915130
> [  168.575456] Code: 73 01 c3 48 8b 0d 58 ed 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 444
> [  168.577969] RSP: 002b:00007ffc3080e288 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  168.578986] RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007fac74915130
> [  168.579937] RDX: 0000000000000009 RSI: 000056007669f080 RDI: 0000000000000001
> [  168.580884] RBP: 000056007669f080 R08: 000000000000000a R09: 00007fac75227700
> [  168.581841] R10: 000056007655c8f0 R11: 0000000000000246 R12: 0000000000000009
> [  168.582796] R13: 0000000000000001 R14: 00007fac74be55e0 R15: 00007fac74be08c0
> [  168.583757]  </TASK>
> [  168.584063] Modules linked in:
> [  168.584494] CR2: 0000000000000008
> [  168.584964] ---[ end trace 2475611ad0f77a1a ]---
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: synchoronize blkg creation against policy deactivation
      commit: 0c9d338c8443b06da8e8d3bfce824c5ea6d3488f

Best regards,
-- 
Jens Axboe


