Return-Path: <cgroups+bounces-8425-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14C9ACCB11
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 18:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C8C3A2B8C
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E3623BCF0;
	Tue,  3 Jun 2025 16:15:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78F4C92
	for <cgroups@vger.kernel.org>; Tue,  3 Jun 2025 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967337; cv=none; b=k6KSQZRe30KvGPjUs5R9+5eODB80ZLvxL1bF6+Kl42Nb3vH+YNeOcQGeo5ea4ABukhK06TO1FKmJLDzNQBqaoScTNLYCP6BN1SlNlMpLTeaThRe6wpQn5Ix3uXkm8UZIcogor14n7F6OZRVOOdfYee3x53psdkZ3bXbZTCuW5hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967337; c=relaxed/simple;
	bh=w+cYj+bZFDm9P7nXNSWeYs9M2oMy2QoF+kzDd6xE5Ak=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M2wiTo3MQoW8Twj9waRP/g6X5xiSXjUUUXcGYAHPTfxTOnzK4y5O/7HjiyvkMh3LbqPbKSpN2AVim9fwh2rNQpx2XZHhWxuqdwE9WBl+vwjTBGUN4KWx2stTxQNRhsz3tnn8T2YeRcj9FrdufbUpKbn+14oHXFHHhBE5tbIQt70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddb4ed2dcbso28989655ab.3
        for <cgroups@vger.kernel.org>; Tue, 03 Jun 2025 09:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748967335; x=1749572135;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76X/DdAmGEp03OYcwF3qW6PE+GuefCWrC1PptIUvkEw=;
        b=rf5whSX6I4Su6Ig9e+Y9AfaPqIUKhzpS2KSmghuZ2vCqXMS9PlXhCpV94y5skRnrLW
         Roq+Ma/bGBTye8B3P0bNDpY4TMvWQro4f3eEUfHaI+c9OrJPyYROTHGASwTr59uZOGKj
         XxaWoguyrF8ZOgY8Pa/vK3sNz0DrNqHGXGTvKgMLNUkwX6/183PjaVMesnq5juxlL3id
         WjN5ZcDFZUJhSdqbFtk3d+P3PO0/Wc7nwd2Bf1vry86g/eaYq88aBwqzQ4KwuuXCpraO
         0WY/kFwVa9w4/8NXzbXJs7AK1EkmhEz8B1ko8/RBIFjfo5gbzOg8635mODOQGabt9RDg
         Jt+g==
X-Gm-Message-State: AOJu0YwMmbTT6vuB/FYtuYHkN/UUYF0CxmUH7yt7BXPCIEr48NfikR8w
	HH7cf5jWliISOg5lguksQSpjhQnEXttqC0QFhSJP+x+77HkTJmkMtpG5n5cg2iZXVbcRI60MB5R
	osrRaOQjhMtV8IAtcsotyw7lvT3hv1l5E8LhSc1ly2/OaHfRIqGQRcqkLKiIQfA==
X-Google-Smtp-Source: AGHT+IEeYHEFfYjc0zLBj+UxmFFz22As+TynOI7W6GEuDGXDb6Sc/mswRPV1NBw/uU0lh9iw0rkUIRYH0QQamN+sfReImq6YsOW3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c8a:b0:3dd:b762:ed1d with SMTP id
 e9e14a558f8ab-3ddb762f05bmr34986295ab.14.1748967335335; Tue, 03 Jun 2025
 09:15:35 -0700 (PDT)
Date: Tue, 03 Jun 2025 09:15:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683f1fa7.a00a0220.d8eae.0071.GAE@google.com>
Subject: [syzbot] [cgroups?] WARNING in css_rstat_flush
From: syzbot <syzbot+7a605e85e5b5a7e4a5e3@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    90b83efa6701 Merge tag 'bpf-next-6.16' of git://git.kernel..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1034f482580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=262b2977ef00756b
dashboard link: https://syzkaller.appspot.com/bug?extid=7a605e85e5b5a7e4a5e3
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d5357fcb09e6/disk-90b83efa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dcb0f12e4d5a/vmlinux-90b83efa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/278fcadd7519/bzImage-90b83efa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7a605e85e5b5a7e4a5e3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 10 at kernel/cgroup/rstat.c:302 css_rstat_updated_list kernel/cgroup/rstat.c:302 [inline]
WARNING: CPU: 0 PID: 10 at kernel/cgroup/rstat.c:302 css_rstat_flush+0x76f/0x1fa0 kernel/cgroup/rstat.c:413
Modules linked in:
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.15.0-syzkaller-g90b83efa6701 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: cgroup_destroy css_free_rwork_fn
RIP: 0010:css_rstat_updated_list kernel/cgroup/rstat.c:302 [inline]
RIP: 0010:css_rstat_flush+0x76f/0x1fa0 kernel/cgroup/rstat.c:413
Code: df 80 3c 08 00 74 08 4c 89 e7 e8 4c 3a 6a 00 49 8b 1c 24 48 3b 5c 24 38 74 22 e8 9c 1c 07 00 e9 72 ff ff ff e8 92 1c 07 00 90 <0f> 0b 90 eb bd e8 87 1c 07 00 45 31 e4 e9 bb 03 00 00 e8 7a 1c 07
RSP: 0018:ffffc900000f7780 EFLAGS: 00010093
RAX: ffffffff81b8de5e RBX: ffffffff99c36880 RCX: ffff88801d2b1e00
RDX: 0000000000000000 RSI: ffffffff8be263a0 RDI: ffffffff8be26360
RBP: ffffc900000f79b8 R08: ffffffff8fa0b1b7 R09: 1ffffffff1f41636
R10: dffffc0000000000 R11: fffffbfff1f41637 R12: ffff8880b8642758
R13: ffffffff99c36880 R14: ffffffff8db91c60 R15: ffff888125c66008
FS:  0000000000000000(0000) GS:ffff888125c66000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f350fc65760 CR3: 0000000032e5c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 css_rstat_exit+0xa9/0x320 kernel/cgroup/rstat.c:479
 css_free_rwork_fn+0x8b/0xc50 kernel/cgroup/cgroup.c:5449
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

