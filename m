Return-Path: <cgroups+bounces-8697-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E63BAFB2B8
	for <lists+cgroups@lfdr.de>; Mon,  7 Jul 2025 13:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69794A1562
	for <lists+cgroups@lfdr.de>; Mon,  7 Jul 2025 11:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4BF29A9C3;
	Mon,  7 Jul 2025 11:57:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F76294A17
	for <cgroups@vger.kernel.org>; Mon,  7 Jul 2025 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751889453; cv=none; b=d77khhkFctVyCqsGoa5DbLLiOVmBMvC4+hn/DDRxTeZVKBYP8TaTxRdzVTcKgCBYtPpzhPy0q6GwQmihwWDaUCPeucFhA68JgrYC48cOf4krOriZUz+CZbI37Ygi3mGz95CzhWrrgc8PN5Z1XApCuw/R4Q+tu+utWy5nC1CIP6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751889453; c=relaxed/simple;
	bh=lBatdydMr1UbrD6ITIl1XJhYoHkZ1L7B7CzZEV88NwU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S4YOnkj3tQ2Azna612C+gr8yw/htDlwuQMh2objh4L6oG6AFt4M60aHf71htolHpc9s9PnUwQyK2cGMvrSFJen1kZLwPBnozdBt8jF2/AVcnFo9DcehtLxbbi2wx+utP9qKA6JJoCNhmOOZutItt6GN3pgXS1y5m00oWzckvFqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86d126265baso284579039f.0
        for <cgroups@vger.kernel.org>; Mon, 07 Jul 2025 04:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751889451; x=1752494251;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5TRauz+CW9RrwFgg/EnD6rf4LP2K7mvnWRyp76QyUoY=;
        b=C2neOiNbtr3uWbq8IBvogJA5/LL/asSs1I19353c57bqWflq3P3kPlRUn1nGMlXgOK
         DxJF1GTDZek9IXsP3We/NS/FTz+PpVRNh+AiqoATgog22rXclwHtxD+0b3VpnXql/QqD
         NvArHLlYK06uwVka24J7yuU5D9nQl7rhFpkpAmQ+IJd2R9mUTjUXsTR9e5vjGSfgnep4
         bp8MbNsdsjLT93be5SLj+n+WdkxZbKhbo2duM3MniiDN7JBVUdfzfMJbMKYUyITl5zxF
         WXEB1G1HsddZopQBMR+IK57GlXtPj7+XUf5MDAQ8HuY7reDfUGxzWb6JzU80IYIXgPC1
         wuWA==
X-Gm-Message-State: AOJu0YwzRyi5+yWiDWAae00R5KDRLeNkATksmdfhCeTXvOmHjDNgzb8g
	xoNHz241AxabxEbgrwZZUdP+YTkbEcDyms5FtUO6OSbjwv9VOZCIwl2qSsgOlcGGqY05w1ZFyrR
	AKaStD2wvlPUpKx/ZFVTQSYABrQ5gVsWQ7wfQO55jlMTBlthYEFMa2WRYFv+gfg==
X-Google-Smtp-Source: AGHT+IH0zbsaedvYiTcoa5SpT+03pinfOsDYpE1rs6o13TrhrLa7Dsrb8o1tjvsxD8Z90QIYgE2PQ3emY+x8B8PDJLaC3ZiGAtJj
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8b:0:b0:3d9:6cb6:fa52 with SMTP id
 e9e14a558f8ab-3e13eefa3c0mr77137375ab.12.1751889451289; Mon, 07 Jul 2025
 04:57:31 -0700 (PDT)
Date: Mon, 07 Jul 2025 04:57:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686bb62b.a00a0220.c7b3.0083.GAE@google.com>
Subject: [syzbot] [cgroups?] KCSAN: data-race in cgroup_migrate_execute / memcpy_and_pad
From: syzbot <syzbot+f3188428a0ed36870056@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176e828c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce48b74bcedce10f
dashboard link: https://syzkaller.appspot.com/bug?extid=f3188428a0ed36870056
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a4c012a3b93/disk-d7b8f8e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e3a6050563a6/vmlinux-d7b8f8e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2bdc7eedebcd/bzImage-d7b8f8e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3188428a0ed36870056@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in cgroup_migrate_execute / memcpy_and_pad

write to 0xffff888133646ad0 of 8 bytes by task 4554 on cpu 1:
 __list_splice include/linux/list.h:533 [inline]
 list_splice_tail_init include/linux/list.h:589 [inline]
 cgroup_migrate_execute+0x6b5/0x7f0 kernel/cgroup/cgroup.c:2689
 cgroup_update_dfl_csses kernel/cgroup/cgroup.c:3135 [inline]
 cgroup_apply_control+0x3ab/0x410 kernel/cgroup/cgroup.c:3375
 cgroup_subtree_control_write+0x7d5/0xb80 kernel/cgroup/cgroup.c:3520
 cgroup_file_write+0x194/0x350 kernel/cgroup/cgroup.c:4183
 kernfs_fop_write_iter+0x1be/0x2d0 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x49d/0x8e0 fs/read_write.c:686
 ksys_write+0xda/0x1a0 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __x64_sys_write+0x40/0x50 fs/read_write.c:746
 x64_sys_call+0x2cdd/0x2fb0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888133646180 of 3200 bytes by task 4561 on cpu 0:
 memcpy_and_pad+0x48/0x80 lib/string_helpers.c:1007
 arch_dup_task_struct+0x2c/0x40 arch/x86/kernel/process.c:98
 dup_task_struct+0x83/0x6a0 kernel/fork.c:873
 copy_process+0x399/0x1f90 kernel/fork.c:1999
 kernel_clone+0x16c/0x5b0 kernel/fork.c:2599
 __do_sys_clone3 kernel/fork.c:2903 [inline]
 __se_sys_clone3+0x1c2/0x200 kernel/fork.c:2882
 __x64_sys_clone3+0x31/0x40 kernel/fork.c:2882
 x64_sys_call+0x10c9/0x2fb0 arch/x86/include/generated/asm/syscalls_64.h:436
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 4561 Comm: syz.2.316 Not tainted 6.16.0-rc5-syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
==================================================================


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

