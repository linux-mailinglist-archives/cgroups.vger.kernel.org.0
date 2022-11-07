Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA5A61EB2D
	for <lists+cgroups@lfdr.de>; Mon,  7 Nov 2022 07:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiKGGuV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Nov 2022 01:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKGGuU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Nov 2022 01:50:20 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC9512775
        for <cgroups@vger.kernel.org>; Sun,  6 Nov 2022 22:50:18 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id q127so9674768vsa.7
        for <cgroups@vger.kernel.org>; Sun, 06 Nov 2022 22:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lAiL66oLuU1UM2VLyBCvNm96RdT9OSVILQCYD0+AsTk=;
        b=eT6OCFbXPLWP8V/twst0UhbXMVRlR0JA6uz4may4K7ycuYEbecCcerMbi3/6PlCXtt
         1soUcO22yyvyVNQ3v71I5SlCutKN7nX9pQ2HRq7b5V6aQNgOyAsZKojbSdBREI+sWkkR
         CXDHSYFzhazAx6U9o4x178vos7BapBxVUdDJe3/ytdP1hOWlxfsqGSBdsf23Up+XtjDH
         peh3xzHb+Ol7h7LO8QlNM+e7P2guJIGFWLdacc8yU5YxEbky7H0d3bA/l/O4p3hJJQ27
         Za1nfkyUkvtHSxbC+Fc9TtbrLtD4I2n7JmfsrxYbl3TyikSFB4WNPLNVrSYugefol9bZ
         4HNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAiL66oLuU1UM2VLyBCvNm96RdT9OSVILQCYD0+AsTk=;
        b=weT2gechFn21g6Rdzmn5IMo/daCUZZN2P/kzA7Qm5Z0vFY0QqRaAQk19MYmIG8YTwM
         tXpJIP2Ka5qz+4ExgcZ6D23Eq1vmvs1pvgTNXiN1JPeZ8UK6rBu5cXWx+IK0+UAzgVcN
         QRkl/9h/Q+6O0IZbBglrG2DlIWVGFCFUga6zwaSMr9feF49nsBo/+3vXqcnzv2a2J0np
         octEET42KUN1Dp2JJHsqc6w6nOp2VUbuopFq8STtNJMbqpB9KF6Fsxq5InfIS54lJB3s
         Xk+oE2o7xsKqZvalRCxrkPpnofNDM9QQLNDp2YA/bQm+OrPTIlMsDNbC1DtUjer77CwY
         BUfw==
X-Gm-Message-State: ACrzQf3wC6sYovOQf/2fWmu3ouyG8hsXB7E6OqRfdrb8ld3i70MAM3Ct
        2tDoMUJiqaTk5gFLMyIjD55SCrv7aVQhl1g+HW6LnlBCWZoO7Dmo
X-Google-Smtp-Source: AMsMyM4roXxBapb1ULE+yJWrGre4/luT0CY/ECPGDPQ90cM0A6P453CC8j96kHCVYGTVo5B0NiJYCdOrtbASL00d3WU=
X-Received: by 2002:a67:c297:0:b0:3aa:3cac:97b6 with SMTP id
 k23-20020a67c297000000b003aa3cac97b6mr26468712vsj.76.1667803816887; Sun, 06
 Nov 2022 22:50:16 -0800 (PST)
MIME-Version: 1.0
From:   Sergey Dolgov <palza00@gmail.com>
Date:   Mon, 7 Nov 2022 12:50:04 +0600
Message-ID: <CADn0Px_+-z5-cjJ6t6fO86=oq9Se-uLDA1nJ0OUSxwf+zHJgWQ@mail.gmail.com>
Subject: problem with remove cgroup in function cgroup_addrm_files
To:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello
we faced problem in removing cgroup in cgroup_addrm_files in kernel 5.4

kernel log:
[45393502.717886] BUG: kernel NULL pointer dereference, address:
00000000000006a3
[45393502.738685] #PF: supervisor read access in kernel mode
[45393502.745395] #PF: error_code(0x0000) - not-present page
[45393502.752128] PGD 0 P4D 0
[45393502.756222] Oops: 0000 [#1] SMP NOPTI
[45393502.761439] CPU: 31 PID: 3025852 Comm: prio-rpc-libvir Kdump:
loaded Tainted: G           OE     5.4.0-73-generic #82~18.04.1-Ubuntu
[45393502.776093] Hardware name: Intel Corporation S2600WFT/S2600WFT,
BIOS SE5C620.86B.02.01.0013.121520200651 12/15/2020
[45393502.788023] RIP: 0010:cgroup_addrm_files+0x51/0x370
[45393502.794381] Code: 50 ff ff ff 48 89 95 58 ff ff ff 65 48 8b 04
25 28 00 00 00 48 89 45 d0 31 c0 48 8b 85 58 ff ff ff 48 39 c3 0f 84
a8 01 00 00 <80> 38 00 0f 84 9f 01 00 00 49 89 c6 eb 2b 49 81 bf 08 02
00 00 a0
[45393502.815850] RSP: 0018:ffff9892625a7d08 EFLAGS: 00010293
[45393502.822545] RAX: 00000000000006a3 RBX: 0000000000000000 RCX:
0000000000000000
[45393502.831144] RDX: 00000000000006a3 RSI: ffff88e7c9a0b000 RDI:
ffff88e7c9a0b000
[45393502.839723] RBP: ffff9892625a7dc0 R08: 0000000000000000 R09:
ffff9892625a7d78
[45393502.848298] R10: 0000000000000020 R11: 0000000000000000 R12:
0000000000000000
[45393502.856859] R13: 0000000000000000 R14: ffff88e2db361000 R15:
ffff88e7c9a0b000
[45393502.865394] FS:  00007f64d0fcc700(0000)
GS:ffff8915ff7c0000(0000) knlGS:0000000000000000
[45393502.874881] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[45393502.882011] CR2: 00000000000006a3 CR3: 0000002cffa46005 CR4:
00000000007626e0
[45393502.890514] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[45393502.899002] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[45393502.907455] PKRU: 55555554
[45393502.911469] Call Trace:
[45393502.915194]  ? cset_cgroup_from_root+0x70/0x70
[45393502.920889]  ? call_rcu+0x10/0x20
[45393502.925429]  ? __percpu_ref_switch_mode+0xda/0x190
[45393502.931436]  css_clear_dir+0x50/0xa0
[45393502.936215]  cgroup_destroy_locked+0xc5/0x180
[45393502.941768]  cgroup_rmdir+0x2e/0xe0
[45393502.946429]  kernfs_iop_rmdir+0x63/0xa0
[45393502.951416]  vfs_rmdir+0x81/0x19
[45393502.955868]  do_rmdir+0x1e4/0x210
[45393502.960301]  __x64_sys_rmdir+0x17/0x20
[45393502.965151]  do_syscall_64+0x57/0x190
[45393502.969888]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

backtrace process:

crash> bt -s

PID: 3025852  TASK: ffff88e37b63dac0  CPU: 31  COMMAND: "prio-rpc-libvir"
 #0 [ffff9892625a7978] machine_kexec+451 at ffffffffa9a6ee03
 #1 [ffff9892625a79d8] __crash_kexec+114 at ffffffffa9b567d2
 #2 [ffff9892625a7aa8] crash_kexec+65 at ffffffffa9b57671
 #3 [ffff9892625a7ac8] oops_end+189 at ffffffffa9a351ad
 #4 [ffff9892625a7af0] no_context+473 at ffffffffa9a7f339
 #5 [ffff9892625a7b60] __bad_area_nosemaphore+80 at ffffffffa9a7f730
 #6 [ffff9892625a7ba8] bad_area_nosemaphore+22 at ffffffffa9a7f8e6
 #7 [ffff9892625a7bb8] __do_page_fault+525 at ffffffffa9a802ad
 #8 [ffff9892625a7c20] do_page_fault+44 at ffffffffa9a8059c
 #9 [ffff9892625a7c50] page_fault+52 at ffffffffaa601284
    [exception RIP: cgroup_addrm_files+81]
    RIP: ffffffffa9b5d781  RSP: ffff9892625a7d08  RFLAGS: 00010293
    RAX: 00000000000006a3  RBX: 0000000000000000  RCX: 0000000000000000
    RDX: 00000000000006a3  RSI: ffff88e7c9a0b000  RDI: ffff88e7c9a0b000
    RBP: ffff9892625a7dc0   R8: 0000000000000000   R9: ffff9892625a7d78
    R10: 0000000000000020  R11: 0000000000000000  R12: 0000000000000000
    R13: 0000000000000000  R14: ffff88e2db361000  R15: ffff88e7c9a0b000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
#10 [ffff9892625a7dc8] css_clear_dir+80 at ffffffffa9b5daf0
#11 [ffff9892625a7df0] cgroup_destroy_locked+197 at ffffffffa9b62c75
#12 [ffff9892625a7e28] cgroup_rmdir+46 at ffffffffa9b6325e
#13 [ffff9892625a7e60] kernfs_iop_rmdir+99 at ffffffffa9d82873
#14 [ffff9892625a7e80] vfs_rmdir+129 at ffffffffa9ce9fb1
#15 [ffff9892625a7eb0] do_rmdir+484 at ffffffffa9cf00f4
#16 [ffff9892625a7f20] __x64_sys_rmdir+23 at ffffffffa9cf0137
#17 [ffff9892625a7f30] do_syscall_64+87 at ffffffffa9a04207
#18 [ffff9892625a7f50] entry_SYSCALL_64_after_hwframe+68 at ffffffffaa60008=
c
    RIP: 00007f64df799d77  RSP: 00007f64d0fcb8b8  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 0000000000000000  RCX: 00007f64df799d77
    RDX: 00007f64b02ba080  RSI: 00007f64e0ca7cf0  RDI: 00007f64b02ba080
    RBP: 00007f64d0fcb920   R8: 00007f64e0edeba0   R9: 0000000000000000
    R10: 00007f64b00008d0  R11: 0000000000000246  R12: 00007f64b02ba080
    R13: 00007f64e0f43901  R14: 0000000000000000  R15: 00007f64b0003550
    ORIG_RAX: 0000000000000054  CS: 0033  SS: 002b


It looks that
css_clear_dir(&cgrp->self);
(https://github.com/torvalds/linux/blob/v5.4/kernel/cgroup/cgroup.c#L5565)
expects cgroup without any ss(all cgroup=E2=80=99s css removed in
https://github.com/torvalds/linux/blob/v5.4/kernel/cgroup/cgroup.c#L5561-L5=
562)

but we have from kdump:
Pointer to cgroup based in R15 : ffff88e7c9a0b000
crash> struct cgroup.self.ss 0xffff88e7c9a0b000
  self.ss =3D 0xffff88fc910d9f80,


crash> struct cgroup_subsys.cfts 0xffff88fc910d9f80
  cfts =3D {
    next =3D 0x703,
    prev =3D 0x0
  },

So in css_clear_dir
(https://github.com/torvalds/linux/blob/v5.4/kernel/cgroup/cgroup.c#L1650):

css->ss is true
https://github.com/torvalds/linux/blob/v5.4/kernel/cgroup/cgroup.c#L1660

and we fall in https://github.com/torvalds/linux/blob/v5.4/kernel/cgroup/cg=
roup.c#L1668-L1669

and when we try to access in
https://github.com/torvalds/linux/blob/v5.4/kernel/cgroup/cgroup.c#L3926

cft->name[0]  we get BUG


If we change comparison in
https://github.com/torvalds/linux/blob/v5.4/kernel/cgroup/cgroup.c#L1660

 from (!css->ss) to (!(css->ss or css =3D=3D css->cgroup->self)) it will
be resolve problem


Full structure cgroup from kdump:
https://drive.google.com/file/d/1fokPEwSSpBr7XyySIhjIyhr5yf_5JTI3/view?usp=
=3Dsharing

Full structure cgroup->self->ss from kdump:
https://drive.google.com/file/d/14z7w_t-6DiQhJzVrCGKFNCAIEkbt7Ce_/view?usp=
=3Dsharing


--=20
Best regards, Sergey Dolgov
