Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97092396A5A
	for <lists+cgroups@lfdr.de>; Tue,  1 Jun 2021 02:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhFAAi7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 May 2021 20:38:59 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:46746 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbhFAAi7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 May 2021 20:38:59 -0400
Received: by mail-io1-f69.google.com with SMTP id a24-20020a5d95580000b029044cbcdddd23so7978747ios.13
        for <cgroups@vger.kernel.org>; Mon, 31 May 2021 17:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tLrApr8w4+dztkSbD/w9zsnd5ZWNoZ15dc1n0EYhArQ=;
        b=ACxvb8bmJha3Kr04lKVkuVrNSgfxMUK2beXXcm18DXcDedma2Znq0kgHuN8iNUZIIF
         6RCf40cIFjMt6jRfKlAiZzxDiP+qc7f3b+MrOYnpSkiEHyORtAIcsVNX/XrRBuKUdJdU
         UROxjMim1/4ihRUuN0vwcgNGh4jJyWjEbtooaiImlFC7+/i3udGQbmpnAerEmD9vw7eh
         fkr4Uhzli7cyjZgcSyvSjfXcfJ6agKg1qsdPXy14CZJ3NE68jfb2lxqmfsMmZ533WgLZ
         9+c9rNDnWkoJtNHPzzITQj+TrAynK9bGO0lHscJgfS0XSfWjO6AJvatKbA8EFNSncics
         o91g==
X-Gm-Message-State: AOAM530ZJdYKeGy7OHlv8xaHgIP+8lmtJSIumeV0MrWMwnz+UkoZFFcP
        jYhPiTxFUTmwfCOfDfEORH20ih05WHRy9kev1sWH7RY87FR0
X-Google-Smtp-Source: ABdhPJzSw2Chb5clU1DbTD2aFN6LSIK1Y+cmqxjo22aneyGOo5IEACVnmyCVaQ8DTmL51ApTlz33JYXtsb4ZY/AT5HM7HFZQTKgY
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13d3:: with SMTP id v19mr19771386ilj.168.1622507838482;
 Mon, 31 May 2021 17:37:18 -0700 (PDT)
Date:   Mon, 31 May 2021 17:37:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005bad6f05c3a98b9c@google.com>
Subject: [syzbot] general protection fault in cgroup_rstat_flush_locked
From:   syzbot <syzbot+363f98e1c445bd838351@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d0c0fe10 bpf: Avoid using ARRAY_SIZE on an uninitialized p..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=13817145d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b86a12e0d1933b5
dashboard link: https://syzkaller.appspot.com/bug?extid=363f98e1c445bd838351

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+363f98e1c445bd838351@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000077: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000003b8-0x00000000000003bf]
CPU: 1 PID: 26368 Comm: kworker/1:4 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: cgroup_destroy css_release_work_fn
RIP: 0010:cgroup_rstat_cpu kernel/cgroup/rstat.c:13 [inline]
RIP: 0010:cgroup_rstat_cpu_pop_updated kernel/cgroup/rstat.c:106 [inline]
RIP: 0010:cgroup_rstat_flush_locked+0x182/0xcc0 kernel/cgroup/rstat.c:161
Code: 85 f6 49 89 f4 48 89 44 24 10 75 0a e9 94 06 00 00 4c 8b 64 24 08 e8 cd f5 05 00 4d 8d bc 24 78 03 00 00 4c 89 f8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 6b 08 00 00 49 8b 9c 24 78 03 00 00 48 83 3c
RSP: 0018:ffffc900027a7c20 EFLAGS: 00010007
RAX: 0000000000000077 RBX: ffffe8ffffc82510 RCX: 0000000000000000
RDX: ffff88802723d4c0 RSI: ffffffff816ed0a3 RDI: ffffe8ffffc82540
RBP: ffff888037f5c000 R08: 0000000000000001 R09: 0000000000000003
R10: fffff520004f4f76 R11: 0000000000000000 R12: 0000000000000046
R13: dffffc0000000000 R14: ffff8880b9c00000 R15: 00000000000003be
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33a2a000 CR3: 000000005e401000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 cgroup_rstat_flush+0x3a/0x50 kernel/cgroup/rstat.c:203
 css_release_work_fn+0x440/0x920 kernel/cgroup/cgroup.c:4991
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace c2ed221e705dd64b ]---
RIP: 0010:cgroup_rstat_cpu kernel/cgroup/rstat.c:13 [inline]
RIP: 0010:cgroup_rstat_cpu_pop_updated kernel/cgroup/rstat.c:106 [inline]
RIP: 0010:cgroup_rstat_flush_locked+0x182/0xcc0 kernel/cgroup/rstat.c:161
Code: 85 f6 49 89 f4 48 89 44 24 10 75 0a e9 94 06 00 00 4c 8b 64 24 08 e8 cd f5 05 00 4d 8d bc 24 78 03 00 00 4c 89 f8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 6b 08 00 00 49 8b 9c 24 78 03 00 00 48 83 3c
RSP: 0018:ffffc900027a7c20 EFLAGS: 00010007
RAX: 0000000000000077 RBX: ffffe8ffffc82510 RCX: 0000000000000000
RDX: ffff88802723d4c0 RSI: ffffffff816ed0a3 RDI: ffffe8ffffc82540
RBP: ffff888037f5c000 R08: 0000000000000001 R09: 0000000000000003
R10: fffff520004f4f76 R11: 0000000000000000 R12: 0000000000000046
R13: dffffc0000000000 R14: ffff8880b9c00000 R15: 00000000000003be
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33a2a000 CR3: 000000005e401000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
