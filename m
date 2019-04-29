Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E82FDDD7E
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2019 10:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfD2IQg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Apr 2019 04:16:36 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:36616 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfD2IQg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Apr 2019 04:16:36 -0400
Received: by mail-wr1-f54.google.com with SMTP id o4so2684587wra.3;
        Mon, 29 Apr 2019 01:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:openpgp:autocrypt:to:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=P+LnBh7bBA7RULfpGkdEbgyn85Nf7wY/ion/MIZqKKo=;
        b=rjWcy2yEnqJ1NV8Ep69oJ+PrLJlSN+RgQldllKNMbqSNZZdYOpIkTrnhz8TyQzOQfm
         2Yg/nVlkd+zd8IkqEDUzGutrSw0xCcZskSdgWYyeH5lEBHTN+eIXDRl6zvduBkUTzD7G
         VQzSe1oHyEGeYH+sShOtc373Z/0C2Q9uwIYfCmx/6LO2f7y3mJgOzajYhZv5SungKrNr
         VH0NDM2oPFEm3R1NQWeAzlWXcjVSI4q4SEoKekOh42Lr9h51vMPT4u0ZnghPUO/8RoKQ
         kQ9lM/4UWqRPHdoyqAm1yZ0v29uAMb4ANnT/BiSbebywlMVZdMmENypbMGM8DHONlUQn
         ISkQ==
X-Gm-Message-State: APjAAAUNSWEhgIm1VQbORzqEDBcr4oAbYp3+7T3zr2R91HKkjcP1ZMCQ
        pWoXuOPGL5qoEqao9sAu7H95b0pV
X-Google-Smtp-Source: APXvYqzuQcP54zEYmlCxvrYoOjsKwPHwVmf12onxxdaBI0M/izF6Fdqp5GCyhlA5ikb1o9b2ehKqWw==
X-Received: by 2002:a5d:4308:: with SMTP id h8mr28851906wrq.22.1556525793653;
        Mon, 29 Apr 2019 01:16:33 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id z4sm12594576wmk.5.2019.04.29.01.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 01:16:32 -0700 (PDT)
From:   Jiri Slaby <jslaby@suse.cz>
Subject: memcg causes crashes in list_lru_add
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, mm <linux-mm@kvack.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Message-ID: <f0cfcfa7-74d0-8738-1061-05d778155462@suse.cz>
Date:   Mon, 29 Apr 2019 10:16:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

with new enough systemd, one of our systems 100% crashes during boot.
Kernels I tried are all affected: 5.1-rc7, 5.0.10 stable, 4.12.14.

The 5.1-rc7 crash:
> [   12.022637] systemd[1]: Starting Create list of required static device nodes for the current kernel...
> [   12.023353] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> [   12.041502] #PF error: [normal kernel read fault]
> [   12.041502] PGD 0 P4D 0 
> [   12.041502] Oops: 0000 [#1] SMP NOPTI
> [   12.041502] CPU: 0 PID: 208 Comm: (kmod) Not tainted 5.1.0-rc7-1.g04c1966-default #1 openSUSE Tumbleweed (unreleased)
> [   12.041502] Hardware name: Supermicro H8DSP-8/H8DSP-8, BIOS 080011  06/30/2006
> [   12.041502] RIP: 0010:list_lru_add+0x94/0x170
> [   12.041502] Code: c6 07 00 66 66 66 90 31 c0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 49 8b 7c 24 20 49 8d 54 24 08 48 85 ff 74 07 e9 46 00 00 00 31 ff <48> 8b 42 08 4c 89 6a 08 49 89 55 00 49 89 45 08 4c 89 28 48 8b 42
> [   12.041502] RSP: 0018:ffffb11b8091be50 EFLAGS: 00010202
> [   12.041502] RAX: 0000000000000001 RBX: ffff930b35705a40 RCX: ffff9309cf21ade0
> [   12.041502] RDX: 0000000000000000 RSI: ffff930ab61bc587 RDI: ffff930a17711000
> [   12.041502] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [   12.041502] R10: 0000000000000000 R11: 0000000000000008 R12: ffff9309f5f86640
> [   12.041502] R13: ffff930ab5705a40 R14: 0000000000000001 R15: ffff930a171dc4e0
> [   12.041502] FS:  00007f42d6ea5940(0000) GS:ffff930ab7800000(0000) knlGS:0000000000000000
> [   12.041502] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   12.041502] CR2: 0000000000000008 CR3: 0000000057dec000 CR4: 00000000000006f0
> [   12.041502] Call Trace:
> [   12.041502]  d_lru_add+0x44/0x50
> [   12.041502]  dput.part.34+0xfc/0x110
> [   12.041502]  __fput+0x108/0x230
> [   12.041502]  task_work_run+0x9f/0xc0
> [   12.041502]  exit_to_usermode_loop+0xf5/0x100
> [   12.041502]  do_syscall_64+0xe2/0x110
> [   12.041502]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   12.041502] RIP: 0033:0x7f42d77567b7
> [   12.041502] Code: ff ff ff ff c3 48 8b 15 df 96 0c 00 f7 d8 64 89 02 b8 ff ff ff ff eb c0 66 2e 0f 1f 84 00 00 00 00 00 90 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 b1 96 0c 00 f7 d8 64 89 02 b8
> [   12.041502] RSP: 002b:00007fffeb85c2c8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> [   12.041502] RAX: 0000000000000000 RBX: 000055dfb6222fd0 RCX: 00007f42d77567b7
> [   12.041502] RDX: 00007f42d78217c0 RSI: 000055dfb6223053 RDI: 0000000000000003
> [   12.041502] RBP: 00007f42d78223c0 R08: 000055dfb62230b0 R09: 00007fffeb85c0f5
> [   12.041502] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> [   12.041502] R13: 000055dfb6225080 R14: 00007fffeb85c3aa R15: 0000000000000003
> [   12.041502] Modules linked in:
> [   12.041502] CR2: 0000000000000008
> [   12.491424] ---[ end trace 574d0c998e97d864 ]---

Enabling KASAN reveals a bit more:
> Allocated by task 1:
>  __kasan_kmalloc.constprop.13+0xc1/0xd0
>  __list_lru_init+0x3cd/0x5e0

This is kvmalloc in memcg_init_list_lru_node:
        memcg_lrus = kvmalloc(sizeof(*memcg_lrus) +
                              size * sizeof(void *), GFP_KERNEL);

>  sget_userns+0x65c/0xba0
>  kernfs_mount_ns+0x120/0x7f0
>  cgroup_do_mount+0x93/0x2e0
>  cgroup1_mount+0x335/0x925
>  cgroup_mount+0x14a/0x7b0
>  mount_fs+0xce/0x304
>  vfs_kern_mount.part.33+0x58/0x370
>  do_mount+0x390/0x2540
>  ksys_mount+0xb6/0xd0
...
>
> Freed by task 1:
>  __kasan_slab_free+0x125/0x170
>  kfree+0x90/0x1a0
>  acpi_ds_terminate_control_method+0x5a2/0x5c9

This is a different object (the address overflowed to an acpi-allocated
memory). Irrelevant info.

> The buggy address belongs to the object at ffff8880d69a2e68
>  which belongs to the cache kmalloc-16 of size 16
> The buggy address is located 8 bytes to the right of
>  16-byte region [ffff8880d69a2e68, ffff8880d69a2e78)

Hmm, 16byte slab. 'memcg_lrus' allocated above is 'struct
list_lru_memcg' defined as:
        struct rcu_head         rcu;
        /* array of per cgroup lists, indexed by memcg_cache_id */
        struct list_lru_one     *lru[0];

sizeof(struct rcu_head) is 16. So it must mean that 'size' used in the
'kvmalloc' above in 'memcg_init_list_lru_node' is 0. That cannot be correct.

This confirms the theory:
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -366,8 +366,14 @@ static int memcg_init_list_lru_node(stru
        struct list_lru_memcg *memcg_lrus;
        int size = memcg_nr_cache_ids;

+       if (!size) {
+               pr_err("%s: XXXXXXXXX size is zero yet!\n", __func__);
+               size = 256;
+       }
+
        memcg_lrus = kvmalloc(sizeof(*memcg_lrus) +
                              size * sizeof(void *), GFP_KERNEL);
+       printk(KERN_DEBUG "%s:    a=%px\n", __func__, memcg_lrus);
        if (!memcg_lrus)
                return -ENOMEM;


and even makes the beast booting. memcg has very wrong assumptions on
'memcg_nr_cache_ids'. It does not assume it can change later, despite it
does.

These are dump_stacks from 'memcg_alloc_cache_id' which changes
'memcg_nr_cache_ids' later during boot:
CPU: 1 PID: 1 Comm: systemd Tainted: G            E
5.0.10-0.ge8fc1e9-default #1 openSUSE Tumbleweed (unreleased)
Hardware name: Supermicro H8DSP-8/H8DSP-8, BIOS 080011  06/30/2006
Call Trace:
 dump_stack+0x9a/0xf0
 mem_cgroup_css_alloc+0xb16/0x16a0
 cgroup_apply_control_enable+0x2d7/0xb40
 cgroup_mkdir+0x594/0xc50
 kernfs_iop_mkdir+0x21a/0x2e0
 vfs_mkdir+0x37a/0x5d0
 do_mkdirat+0x1b1/0x200
 do_syscall_64+0xa5/0x290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe




I am not sure why this is machine-dependent. I cannot reproduce on any
other box.

Any idea how to fix this mess?

The report is in our bugzilla:
https://bugzilla.suse.com/show_bug.cgi?id=1133616

thanks,
-- 
js
suse labs
