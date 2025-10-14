Return-Path: <cgroups+bounces-10729-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEFDBD9A2B
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 15:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10519501E73
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 13:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA34F31619E;
	Tue, 14 Oct 2025 13:10:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8732A315D52
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447459; cv=none; b=kDErHr/nePiuQnUg42jbt2H0DyUsVj6OgbMJ6ND0N7RUd23/Ey2qX5II0PXqhAigzo6RGrdNDebrgntsyct8c82rugoqGMaGaSZFWHkfUauAGUvjlYhBGKR2lOQQgRErqp9J5RdyKuJChm8DKotuXfAKr5ER5iRI/uAiFycH6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447459; c=relaxed/simple;
	bh=Dh2gIj78AlhZH9jhvU+ALwIFDJlhmM9v2sNPvwECyPg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=pmy2C+T9aJ/PMz0BpIEgrPz1tRumw+8qpAh0eUbi6VnXeQ8FVEapWnsaWZAJntJ0CKzVAZ3L4Y92EvCWtZm/t2JqCgsLzVMsD23fknDHlU3HJETNmJW2UXulIdFo3TQkt0U/kKURoP2U9IaxAqul3Z0ZErio6GtxaafPUOOx7XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e4fb08300so130738239f.3
        for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 06:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760447456; x=1761052256;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTvCLh80L5RCIEYpK48k3nL1zjTVSsw4OaSTIePcCmg=;
        b=cM0mANLpyct7aDh0vy7ZYTJ79ttPZBEaRJlZAkFvnicnzZMVMzSWEWhSRqRCCIg2LX
         J83hSOnMdIMTnYU7OPQhM6a1O2KKLqDHjgIwFO91GaS8Kkg8WQUFa35XBF+wF4y7B0IR
         Nprkk46yZuqHGIEXAQT2adbstpcOK8KIPcXSklixeD9b5TGW3VAUO5Vo8o7VgLeSAGRj
         5mMKjgrAThMb5JZImCknT0k2fh2Fywsf7MuiCOrbGb0utK50zN9WOdZ/fNQajMAwGSZt
         AsjoDz/p1AB6l9LP5Nzfp2HQ7tfpXd8iWJK4SEGi1KUcodADk7HTbCuglphOibD4gYqk
         6vjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPl4JJ9P1F+XK65sDFLwF72bC+h2ro8ni7rs3wJL7OkpUxLBnlhYuTmklk1ce3t+hzRF1SA4mv@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkym7SW8RO1brbRNZ7fQVxfb2SlxPrDUl9jofY+o8lZ/aTopCr
	cIKnQNnQotM9SWHetQmhWtVxVWCNKdGxFOzVg/ntQI2+FTRIWDu/cerJllqCgLdv2d8LDNme6nf
	7dShBJ89lkzKRm8ieOtaKiaNt3rXH5p0apvQwY3zctk2uUAKh4TjqsunRZSU=
X-Google-Smtp-Source: AGHT+IEPH9IF89ITwygTX0sulnxlR817dJPiW7sqU1Z8BIDZ/6e+3f2GvHQhEGN5ckeXiKxOq+fc0U8MPZ/A5YbCtFxHLytXbbXL
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:426:39a:90f1 with SMTP id
 e9e14a558f8ab-42f873d62c7mr267953315ab.18.1760447456621; Tue, 14 Oct 2025
 06:10:56 -0700 (PDT)
Date: Tue, 14 Oct 2025 06:10:56 -0700
In-Reply-To: <20251014093124.300012-1-hao.ge@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee4be0.050a0220.ac43.0104.GAE@google.com>
Subject: [syzbot ci] Re: slab: Introduce __SECOND_OBJEXT_FLAG for objext_flags
From: syzbot ci <syzbot+cid6b2cf8227adc21a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, ast@kernel.org, cgroups@vger.kernel.org, 
	gehao@kylinos.cn, hannes@cmpxchg.org, hao.ge@linux.dev, harry.yoo@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	surenb@google.com, vbabka@suse.cz
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] slab: Introduce __SECOND_OBJEXT_FLAG for objext_flags
https://lore.kernel.org/all/20251014093124.300012-1-hao.ge@linux.dev
* [PATCH] slab: Introduce __SECOND_OBJEXT_FLAG for objext_flags

and found the following issue:
general protection fault in percpu_ref_get_many

Full report is available here:
https://ci.syzbot.org/series/6fd66120-211f-479f-b6a1-35f990da2dc2

***

general protection fault in percpu_ref_get_many

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      0d97f2067c166eb495771fede9f7b73999c67f66
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/74de5bb7-695b-4115-9a4b-ee7d7fd0cca2/config

Oops: general protection fault, probably for non-canonical address 0xdffffc00177780ff: 0000 [#1] SMP KASAN PTI
KASAN: probably user-memory-access in range [0x00000000bbbc07f8-0x00000000bbbc07ff]
CPU: 1 UID: 0 PID: 6155 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:percpu_ref_get_many+0x8d/0x140
Code: 01 48 c7 c7 80 70 78 8b be 65 03 00 00 48 c7 c2 c0 70 78 8b e8 64 2b 6f ff 49 bc 00 00 00 00 00 fc ff df 4c 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 ff e8 c4 50 f7 ff 49 8b 07 a8 03 75 62
RSP: 0018:ffffc90004df7500 EFLAGS: 00010206
RAX: 00000000177780ff RBX: ffffffff822de139 RCX: 14bab840e71f4400
RDX: 0000000000000000 RSI: ffffffff8bc074c0 RDI: ffffffff8bc07480
RBP: 0000000000000088 R08: 0000000000000000 R09: ffffffff822de139
R10: dffffc0000000000 R11: fffffbfff1f3c1ef R12: dffffc0000000000
R13: ffff88823c63b5c0 R14: 0000000000000001 R15: 00000000bbbc07f8
FS:  0000555570ae6500(0000) GS:ffff8882a9d12000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555562d8c5c8 CR3: 0000000113444000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 refill_obj_stock+0x254/0x850
 __memcg_slab_free_hook+0x123/0x3b0
 kfree+0x3f7/0x6d0
 kobject_uevent_env+0x361/0x8c0
 netdev_queue_update_kobjects+0x346/0x6c0
 netdev_register_kobject+0x258/0x310
 register_netdevice+0x126c/0x1ae0
 __ip_tunnel_create+0x3e7/0x560
 ip_tunnel_init_net+0x2ba/0x800
 ops_init+0x35c/0x5c0
 setup_net+0xfe/0x320
 copy_net_ns+0x34e/0x4e0
 create_new_namespaces+0x3f3/0x720
 unshare_nsproxy_namespaces+0x11c/0x170
 ksys_unshare+0x4c8/0x8c0
 __x64_sys_unshare+0x38/0x50
 do_syscall_64+0xfa/0xfa0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f85c81906c7
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe57c0ca58 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f85c81906c7
RDX: 00007f85c818eec9 RSI: 00007ffe57c0ca20 RDI: 0000000040000000
RBP: 00007ffe57c0cac0 R08: 00007f85c83a69d0 R09: 00007f85c83a69d0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe57c0cac0
R13: 00007ffe57c0cac8 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:percpu_ref_get_many+0x8d/0x140
Code: 01 48 c7 c7 80 70 78 8b be 65 03 00 00 48 c7 c2 c0 70 78 8b e8 64 2b 6f ff 49 bc 00 00 00 00 00 fc ff df 4c 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 ff e8 c4 50 f7 ff 49 8b 07 a8 03 75 62
RSP: 0018:ffffc90004df7500 EFLAGS: 00010206
RAX: 00000000177780ff RBX: ffffffff822de139 RCX: 14bab840e71f4400
RDX: 0000000000000000 RSI: ffffffff8bc074c0 RDI: ffffffff8bc07480
RBP: 0000000000000088 R08: 0000000000000000 R09: ffffffff822de139
R10: dffffc0000000000 R11: fffffbfff1f3c1ef R12: dffffc0000000000
R13: ffff88823c63b5c0 R14: 0000000000000001 R15: 00000000bbbc07f8
FS:  0000555570ae6500(0000) GS:ffff8882a9d12000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555562d8c5c8 CR3: 0000000113444000 CR4: 00000000000006f0


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

