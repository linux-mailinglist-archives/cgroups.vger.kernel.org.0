Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFAD4AF7FD
	for <lists+cgroups@lfdr.de>; Wed,  9 Feb 2022 18:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbiBIRXd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Feb 2022 12:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238104AbiBIRXc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Feb 2022 12:23:32 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBFFC0613C9
        for <cgroups@vger.kernel.org>; Wed,  9 Feb 2022 09:23:35 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id c6so8060460ybk.3
        for <cgroups@vger.kernel.org>; Wed, 09 Feb 2022 09:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=P6aW3G2e5umZOIzGRRqXxSKwZ2UFDNvGaTiFCzb0BQI=;
        b=yYtM/Z2iNFgasr3DE+nu3MWsAoISfh5QM0Kxn5+K/G5xuKSSFoNSEepufHM1n2C/aY
         /iL90+vn2yn0jS8Ysh90aAT2hyZ8OomFeeBOWgkk2f1r29og+vg/QCc46+EYqkX8LU6N
         irDrHoBmdfzZwkOB1QWpvLEnICyk3H0jsSS5lKkURcRIXq8FKNeKgClkp9U0j72O0SUf
         EsSP2SEDG2XssORmIkA328ANHnjNdiS7zJwKwXHE/CK7XYplsYt0nbVq2ymhsuIwmyPN
         tdwKC7xy0CimprRQTGB1xRjjwvsWo9O6YL1HSfs16aKK3DVJpy2lEYGfVWJK4ltcaRs3
         RwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=P6aW3G2e5umZOIzGRRqXxSKwZ2UFDNvGaTiFCzb0BQI=;
        b=bWgwSN3E8bZoo4+FQHY/9CSwrsVNyyZ/OcaiVoTomwTbXYPcg2p232xgFMgs5t6x66
         XSdD3M/X15/QqTt7QjN7ioUK0uaWPhrMrF5iSOkPwdiZGTpgFVKQvG5xOEJNjvz56Rjc
         +smMJIRsiSyVt/KoJ59+/WE5EXzg7FeoIYPwxDHK6VZxsxbb7raf03aG8FEo/mAw16oG
         i3OjyATkApvmYCTAu8vtunihTWwzepbaBrbZz5gKjtaT8yeDCqqE5XihhzacRMSEAvfB
         MCUKkrzOfKYUhXG9TWrf5ICxmqqtqQF4omhwsbsD2safn/ZQ9JPkEENNtYn2+f1SjdVq
         uzsg==
X-Gm-Message-State: AOAM53144Nmd8N18UI3xs4lBiQ7+EZcmNiLksDtP7ezRDpR/GlurV6ZK
        vC+HI3IaxK2u4xczf1SM2jpaZmA7CVPVJJqmEpQfj0K6Vv5Ck04p
X-Google-Smtp-Source: ABdhPJyEztGuFofZ/vg6VtJgy4jFsupjQvzPfLj/F8uxexWDgMDjQG5w536Y4DGORAX7ywk7okUu4zzM3o1l1DLmfvQ=
X-Received: by 2002:a25:ba0a:: with SMTP id t10mr2928362ybg.509.1644427414388;
 Wed, 09 Feb 2022 09:23:34 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 9 Feb 2022 10:23:18 -0700
Message-ID: <CAJCQCtRjgrjWYwA1M99NMLdy-Y=nvQvrrps8A0hG5wX+qf94vg@mail.gmail.com>
Subject: kernel BUG at lib/list_debug.c:54! RIP: 0010:__list_del_entry_valid.cold+0x1d/0x47
To:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

I hit this bug out of the blue (haven't seen it before) with 5.16.5,
the activity at the time was logging out of GNOME shell, and dropping
to a tty, and then got a hard lockup. And cgwb_release_workfn brought
me here, let me know if it should go elsewhere.


[35824.733029] kernel: list_del corruption. next->prev should be
ffff93e01fa2f550, but was 0000000000000000
[35824.733085] kernel: ------------[ cut here ]------------
[35824.733104] kernel: kernel BUG at lib/list_debug.c:54!
[35824.733127] kernel: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[35824.733149] kernel: CPU: 1 PID: 27905 Comm: kworker/1:2 Not tainted
5.16.5-200.fc35.x86_64 #1
[35824.733179] kernel: Hardware name: LENOVO 20QDS3E200/20QDS3E200,
BIOS N2HET66W (1.49 ) 11/10/2021
[35824.733208] kernel: Workqueue: cgwb_release cgwb_release_workfn
[35824.733234] kernel: RIP: 0010:__list_del_entry_valid.cold+0x1d/0x47
[35824.733260] kernel: Code: c7 c7 38 a8 64 91 e8 47 d8 fd ff 0f 0b 48
89 fe 48 c7 c7 c8 a8 64 91 e8 36 d8 fd ff 0f 0b 48 c7 c7 78 a9 64 91
e8 28 d8 fd ff <0f> 0b 48 89 f2 48 89 fe 48 c7 c7 38 a9 64 91 e8 14 d8
fd ff 0f 0b
[35824.733322] kernel: RSP: 0018:ffffa710470ffe40 EFLAGS: 00010082
[35824.733343] kernel: RAX: 0000000000000054 RBX: ffff93e01fa2f540
RCX: 0000000000000000
[35824.733370] kernel: RDX: 0000000000000002 RSI: ffffffff91634c5d
RDI: 00000000ffffffff
[35824.733396] kernel: RBP: 0000000000000202 R08: 0000000000000000
R09: ffffa710470ffc88
[35824.733423] kernel: R10: ffffa710470ffc80 R11: ffffffff91f462a8
R12: 00000000ffffffff
[35824.733449] kernel: R13: ffff93e0092f1000 R14: ffff93e01fa2f400
R15: ffff93e36e879b05
[35824.733475] kernel: FS:  0000000000000000(0000)
GS:ffff93e36e840000(0000) knlGS:0000000000000000
[35824.733505] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[35824.733527] kernel: CR2: 00007fcbd0ef9e40 CR3: 0000000057e10001
CR4: 00000000003726e0
[35824.733553] kernel: Call Trace:
[35824.733566] kernel:  <TASK>
[35824.733577] kernel:  percpu_counter_destroy+0x24/0x80
[35824.733599] kernel:  cgwb_release_workfn+0xf9/0x210
[35824.733619] kernel:  process_one_work+0x1e5/0x3c0
[35824.733639] kernel:  worker_thread+0x50/0x3b0
[35824.733656] kernel:  ? rescuer_thread+0x350/0x350
[35824.733674] kernel:  kthread+0x169/0x190
[35824.733704] kernel:  ? set_kthread_struct+0x40/0x40
[35824.733725] kernel:  ret_from_fork+0x1f/0x30
[35824.733747] kernel:  </TASK>
...
[35824.734658] kernel: ---[ end trace 252276f5cea252b7 ]---
[35824.734679] kernel: RIP: 0010:__list_del_entry_valid.cold+0x1d/0x47
[35824.734706] kernel: Code: c7 c7 38 a8 64 91 e8 47 d8 fd ff 0f 0b 48
89 fe 48 c7 c7 c8 a8 64 91 e8 36 d8 fd ff 0f 0b 48 c7 c7 78 a9 64 91
e8 28 d8 fd ff <0f> 0b 48 89 f2 48 89 fe 48 c7 c7 38 a9 64 91 e8 14 d8
fd ff 0f 0b
[35824.734778] kernel: RSP: 0018:ffffa710470ffe40 EFLAGS: 00010082
[35824.734802] kernel: RAX: 0000000000000054 RBX: ffff93e01fa2f540
RCX: 0000000000000000
[35824.734832] kernel: RDX: 0000000000000002 RSI: ffffffff91634c5d
RDI: 00000000ffffffff
[35824.734862] kernel: RBP: 0000000000000202 R08: 0000000000000000
R09: ffffa710470ffc88
[35824.734892] kernel: R10: ffffa710470ffc80 R11: ffffffff91f462a8
R12: 00000000ffffffff
[35824.734922] kernel: R13: ffff93e0092f1000 R14: ffff93e01fa2f400
R15: ffff93e36e879b05
[35824.734952] kernel: FS:  0000000000000000(0000)
GS:ffff93e36e840000(0000) knlGS:0000000000000000
[35824.734986] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[35824.735011] kernel: CR2: 00007fcbd0ef9e40 CR3: 0000000057e10001
CR4: 00000000003726e0
[35824.735041] kernel: note: kworker/1:2[27905] exited with preempt_count 1
[35833.869319] kernel: rfkill: input handler disabled
[35840.610774] kernel: NMI watchdog: Watchdog detected hard LOCKUP on cpu 0

(more follows)


Downstream bug report (full dmesg attached to the bug)
https://bugzilla.redhat.com/show_bug.cgi?id=2052329

Thanks!

-- 
Chris Murphy
