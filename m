Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FF4612987
	for <lists+cgroups@lfdr.de>; Sun, 30 Oct 2022 10:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJ3Jkn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Oct 2022 05:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJ3Jkj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Oct 2022 05:40:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5843BC89;
        Sun, 30 Oct 2022 02:40:36 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r14so13663160edc.7;
        Sun, 30 Oct 2022 02:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VzvbL7tnM7K6RLTUujC4jQKyKpew0+HWRUgr63xlXaE=;
        b=WP7Ihx0n0LqOlFvORgOnuSnoQTzlhH+fbuENT+/CCBuQ7TEquYPK3eXMpfP2Zv0ag6
         qs7xWay+epsN8DmWr+Q0fSZW1ntxLNAtdjy1OWO++uG5CoE4qJYfMAVLVBdA589iGNL8
         zZdskoT1wpclHUH7X7LjgOcjvNE5ifezx9ldRTKgjb4PrNu+hGGHHGtB2G2NrepVcy1p
         3+POPYV5s9jBJHfW4uPT58kMkgjizQYj6zzeKGfExftqltnZFYgs37Q6AU2gno7DSgoq
         M6P8w4Hju0krwVeH7IbmL7frdhVUbsze7y98zSbJTlfAr6yUJFJ8JOv1bOPteNbSrUEW
         2qGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VzvbL7tnM7K6RLTUujC4jQKyKpew0+HWRUgr63xlXaE=;
        b=SYeOIpiQHwbi9q0yy3zQgcFWJnxFHX47UKtNAtR2aQTpZes5JwU+CMcUnG5RKSZGIs
         dtBlOrXKI9nfB2I/yM99itcZR6q6KRtx3KiQytG9dA+3uNLCcMNPH5Xo940B5xDxqctS
         htBjrZInyPULwR8pYJTDyY/3st3ZAkFlTkG79LBEV0ruUv1V2M0LipqhjRaGqQp2tacJ
         d06rb3hXciedf4XoapJl//sfm9NjhBVR4nIc/xMZOlyyqCVLfRwtenb0VASjL1lfGgv/
         nWz827b4P8cDDAPToC/37syCmlN6nXQ1Ys9zRJjVMzNo+OMbgdY7YdHchwmilAUiYpMw
         iDzg==
X-Gm-Message-State: ACrzQf2P/5EDgdzK7wKB/T2nztBi3dyl2+RnKf8XBlsLVKt5R+XBJam3
        FmbzSvprTCf8ykcp4RGaWpvlBoPH9fWaYcNPnoc=
X-Google-Smtp-Source: AMsMyM6W4SNUMzjTz8iwr57ra18ucFeDquQ0p+7PTy65h3VINs8+qgVzBUOM3eGTXdrBSwDfKXKq6eQBrBWnZ56nyPY=
X-Received: by 2002:a05:6402:5291:b0:45c:3f6a:d4bc with SMTP id
 en17-20020a056402529100b0045c3f6ad4bcmr8008907edb.285.1667122835140; Sun, 30
 Oct 2022 02:40:35 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 17:39:59 +0800
Message-ID: <CAO4mrfdCeFWo4Nq=OYyiOa2qhuu3Jkft3KSosympvrFzxt+iQg@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in bio_associate_blkg_from_css
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
compiler: gcc 8.0.1
console output:
https://drive.google.com/file/d/1ec016fbMgmvittn6-wHxp8V_9adDCRrY/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

loop0: detected capacity change from 0 to 61456
BUG: kernel NULL pointer dereference, address: 00000000000005d0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 107f59067 P4D 107f59067 PUD 109722067 PMD 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 17581 Comm: syz-executor.0 Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:bio_associate_blkg_from_css+0x331/0xb90
Code: fe 48 c7 c6 79 f7 54 82 48 c7 c7 e0 de 41 86 e8 75 04 db fe 48
8b 45 d0 49 89 46 48 e9 ec 00 00 00 e8 b3 7b e8 fe 49 8b 46 08 <48> 8b
80 d0 05 00 00 48 8b 80 90 00 00 00 4c 8b a0 f0 04 00 00 e8
RSP: 0018:ffffc90003de7b10 EFLAGS: 00010212
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc9000b9f1000 RSI: ffff88810b5f9b80 RDI: 0000000000000002
RBP: ffffc90003de7b60 R08: ffffffff8254f7ad R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000001 R12: ffffffff892f6f60
R13: ffff88810717fc00 R14: ffff888107d38700 R15: 0000000000000046
FS:  00007fc6ebc98700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000005d0 CR3: 000000012f494000 CR4: 00000000003506e0
Call Trace:
 bio_associate_blkg+0x94/0x2c0
 lbmStartIO+0xb6/0x160
 lbmWrite+0x18b/0x210
 lmNextPage+0xb6/0x1d0
 lmWriteRecord+0x4ca/0x630
 lmLog+0x1a3/0x3e0
 jfs_mount_rw+0x1fb/0x230
 jfs_fill_super+0x379/0x480
 mount_bdev+0x23d/0x280
 legacy_get_tree+0x2e/0x90
 vfs_get_tree+0x29/0x100
 path_mount+0x58e/0x10a0
 do_mount+0x9b/0xb0
 __x64_sys_mount+0x13a/0x150
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46abda
Code: 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc6ebc97a48 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fc6ebc97af0 RCX: 000000000046abda
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fc6ebc97ab0
RBP: 0000000020000000 R08: 00007fc6ebc97af0 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000100
R13: 00007fc6ebc97ab0 R14: 0000000000000001 R15: 0000000020000140
Modules linked in:
CR2: 00000000000005d0
---[ end trace 00146354a78b09b6 ]---
RIP: 0010:bio_associate_blkg_from_css+0x331/0xb90
Code: fe 48 c7 c6 79 f7 54 82 48 c7 c7 e0 de 41 86 e8 75 04 db fe 48
8b 45 d0 49 89 46 48 e9 ec 00 00 00 e8 b3 7b e8 fe 49 8b 46 08 <48> 8b
80 d0 05 00 00 48 8b 80 90 00 00 00 4c 8b a0 f0 04 00 00 e8
RSP: 0018:ffffc90003de7b10 EFLAGS: 00010212
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc9000b9f1000 RSI: ffff88810b5f9b80 RDI: 0000000000000002
RBP: ffffc90003de7b60 R08: ffffffff8254f7ad R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000001 R12: ffffffff892f6f60
R13: ffff88810717fc00 R14: ffff888107d38700 R15: 0000000000000046
FS:  00007fc6ebc98700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000005d0 CR3: 000000012f494000 CR4: 00000000003506e0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0: 48 c7 c6 79 f7 54 82 mov    $0xffffffff8254f779,%rsi
   7: 48 c7 c7 e0 de 41 86 mov    $0xffffffff8641dee0,%rdi
   e: e8 75 04 db fe        callq  0xfedb0488
  13: 48 8b 45 d0          mov    -0x30(%rbp),%rax
  17: 49 89 46 48          mov    %rax,0x48(%r14)
  1b: e9 ec 00 00 00        jmpq   0x10c
  20: e8 b3 7b e8 fe        callq  0xfee87bd8
  25: 49 8b 46 08          mov    0x8(%r14),%rax
* 29: 48 8b 80 d0 05 00 00 mov    0x5d0(%rax),%rax <-- trapping instruction
  30: 48 8b 80 90 00 00 00 mov    0x90(%rax),%rax
  37: 4c 8b a0 f0 04 00 00 mov    0x4f0(%rax),%r12
  3e: e8                    .byte 0xe8

Best,
Wei
