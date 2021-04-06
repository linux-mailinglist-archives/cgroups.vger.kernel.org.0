Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CF8354E80
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 10:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhDFIZP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Apr 2021 04:25:15 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:39670 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbhDFIZO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Apr 2021 04:25:14 -0400
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id D78F3A1B35B;
        Tue,  6 Apr 2021 10:25:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1617697500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=FFIoGOaJU2yArcx/E1SPfz59RP31n3PkOCSfX9LZ5mw=;
        b=wtv4AXwdmy9SrC39BGy86T5bCpx4qithD9DEpb5x8lXsFJsiyWpOg2AfpeBG8KSes5uzc5
        61gPq4ZYzUaOUdQKWKN+MXhmvXn2mnRmksQpxhriG5rS1OS0ufKjMpryVDIGoiCwsR9LbF
        rKxrehcvQvIXzjW+WImHjdGahU079qw=
Date:   Tue, 6 Apr 2021 10:25:00 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Page fault in cgroup_get_e_css
Message-ID: <20210406082500.ufjxjv2pbi532nwc@spock.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello.

From time to time I'm experiencing the following:

```
[64924.105071] BUG: unable to handle page fault for address: 0000040000000190
[64924.105080] #PF: supervisor read access in kernel mode
[64924.105083] #PF: error_code(0x0000) - not-present page
[64924.105085] PGD 0 P4D 0
[64924.105088] Oops: 0000 [#1] PREEMPT SMP NOPTI
[64924.105091] CPU: 3 PID: 1103 Comm: bluetoothd Tainted: G        W         5.11.0-pf7 #1
[64924.105094] Hardware name: ASUS System Product Name/Pro WS X570-ACE, BIOS 3302 03/05/2021
[64924.105097] RIP: 0010:cgroup_get_e_css+0x27/0xe0
[64924.105102] Code: b9 eb da 0f 1f 44 00 00 41 54 55 48 89 f5 53 48 89 fb e8 2c 8a fb ff 49 89 dc 48 85 ed 74 10 48 63 85 94 00 00 00 48 83 c0 2e <4c> 8b 64 c3 08 4d 85 e4 74 4d 41 f6 44 24 54 01 74 0d e8 32 db fb
[64924.105105] RSP: 0018:ffffc07f02bafad8 EFLAGS: 00010012
[64924.105108] RAX: 0000000000000031 RBX: 0000040000000000 RCX: 0000000000000000
[64924.105111] RDX: 000000000000000a RSI: ffffffffb93398a0 RDI: 0000040000000000
[64924.105113] RBP: ffffffffb93398a0 R08: 0000000000000040 R09: ffffc07f02bafcd8
[64924.105115] R10: 0000000000000476 R11: 000000000000000c R12: 0000040000000000
[64924.105117] R13: ffff9f88c538e700 R14: ffff9f88c538e400 R15: ffffedfb96b629c0
[64924.105119] FS:  00007f234fe867c0(0000) GS:ffff9f8fceac0000(0000) knlGS:0000000000000000
[64924.105122] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[64924.105124] CR2: 0000040000000190 CR3: 000000010c89c000 CR4: 0000000000350ee0
[64924.105127] Call Trace:
[64924.105130]  wb_get_create+0x8d/0x640
[64924.105136]  ? xfs_bmap_add_extent_hole_real+0x60a/0x950 [xfs]
[64924.105188]  __inode_attach_wb+0x8c/0x250
[64924.105192]  account_page_dirtied+0x16d/0x1b0
[64924.105196]  __set_page_dirty+0x50/0xc0
[64924.105199]  iomap_set_page_dirty+0x50/0x90
[64924.105203]  iomap_write_end+0x73/0x280
[64924.105206]  ? iov_iter_copy_from_user_atomic+0xc7/0x340
[64924.105210]  iomap_write_actor+0xed/0x190
[64924.105213]  iomap_apply+0x106/0x300
[64924.105216]  ? iomap_write_begin+0x5b0/0x5b0
[64924.105271]  iomap_file_buffered_write+0x5c/0x80
[64924.105274]  ? iomap_write_begin+0x5b0/0x5b0
[64924.105277]  xfs_file_buffered_aio_write+0xe7/0x350 [xfs]
[64924.105333]  new_sync_write+0x16a/0x200
[64924.105337]  vfs_write+0x21c/0x2e0
[64924.105341]  __x64_sys_write+0x6d/0xf0
[64924.105344]  do_syscall_64+0x33/0x40
[64924.105347]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[64924.105352] RIP: 0033:0x7f23504a40f7
[64924.105355] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[64924.105357] RSP: 002b:00007ffcc0fdc988 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
```

I'm not quite positive about having an exact reproducer, unfortunately.

Have you got an idea on what could go wrong here?

Thanks.

-- 
  Oleksandr Natalenko (post-factum)
