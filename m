Return-Path: <cgroups+bounces-13962-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIoROiQ1kmn4rwEAu9opvQ
	(envelope-from <cgroups+bounces-13962-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 15 Feb 2026 22:05:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 458DA13FB9B
	for <lists+cgroups@lfdr.de>; Sun, 15 Feb 2026 22:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3623300D466
	for <lists+cgroups@lfdr.de>; Sun, 15 Feb 2026 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1B026FA5B;
	Sun, 15 Feb 2026 21:05:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91AA23D7CF
	for <cgroups@vger.kernel.org>; Sun, 15 Feb 2026 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771189538; cv=none; b=LovZwU3cfoZfxjnLj2bt7YRTHgRG+Cj6Wrm7DQOCxwhvpTzZ4Bamwc//whbHvO0kb6Z3mpYj3Y2PmJNXTSuCAFwloiO9Xo6XdOuEAzNWiPocDPYJOQIKEv+k2BwuzmR083x1UX3xD6Fc28htpTOtl4OYpipWy36o4jSLW/zYUwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771189538; c=relaxed/simple;
	bh=TiVusZ6SMNchHHBBbaBlfHOGoTgM602XCsu8+Wgdmug=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ftysc7mm9Pt3ZtZ2ImUFlOYBcqQVClVEZ+YSi02TNEraLiJ+Ajjk2YsayrT7taVbGQ/TwkkZaN9TnkLxRfJFmDvfExMgWZHQ259Nr/jUM0vC727cIlegrgtp+5cS64h1kF3BD7UD68eEtjY9yx+VKkc+36iaSWzyAD5sEp+QFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6798921eff4so7695081eaf.1
        for <cgroups@vger.kernel.org>; Sun, 15 Feb 2026 13:05:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771189536; x=1771794336;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9dS19TYpz7C+NiSoKUspfjUeLrgceBp5Ph1RxYuUZrA=;
        b=NFTM7u92LVctE42HoPPFxW5+aH3LBoQ1c2AQ9wkvcVPc4LUnPRAdM9FkSRxWR7qbId
         DcewT8ORL/QJznqi4ZVmDxNf4sm8p9ZXHfZ8UpA6MTrw9sMVnAoaHuvhfUdO5/nO4u9f
         xqkWCHlrwAQg0pW+FMqyiCq3Idtfi7WUPd/0vIPqk0yKgZ6ZcUWgNaDRvJID5xtzzfSx
         nPhJyKmqEheBYQJZfMVCyAeFeOM9cDcftDcbgIUUAB8ODLaIeVeBlyCaQVpBd9RPw4Jg
         BWaXi4dasbbgUtOfirIkYFR+zyRECsNXSIqyW617r0oEvsSRCJ02Y7B5LgnACuaJ8UFP
         3hiA==
X-Gm-Message-State: AOJu0Yym7MCHRbJvw6uydWeTrhWzCIUMQVAb76RE2ceAxrFhbjnO4pxZ
	ymwU8eUJ1qA2tKkcJ2epd717kSB0iq533qV3TGZgKijv1jnDis4g89b9VTljPzTPSf/RNgCymSc
	MEwkAFkXJvZxGzAaJi+dl2PPhQckcI7+oZj5sYfLgUqIGrv8HFteEtx3XFlI=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81cd:b0:663:3c7:421d with SMTP id
 006d021491bc7-6785c22b1ecmr3622561eaf.75.1771189535818; Sun, 15 Feb 2026
 13:05:35 -0800 (PST)
Date: Sun, 15 Feb 2026 13:05:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6992351f.050a0220.2757fb.0035.GAE@google.com>
Subject: [syzbot] [cgroups?] general protection fault in rebuild_sched_domains_locked
From: syzbot <syzbot+460792609a79c085f79f@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, chenridong@huaweicloud.com, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, longman@redhat.com, mkoutny@suse.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a512b4a06724b76a];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13962-lists,cgroups=lfdr.de,460792609a79c085f79f];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,goo.gl:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 458DA13FB9B
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    37a93dd5c49b Merge tag 'net-next-7.0' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1649d073980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a512b4a06724b76a
dashboard link: https://syzkaller.appspot.com/bug?extid=460792609a79c085f79f
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152086e6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139c2eef980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0dedaafff2ad/disk-37a93dd5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aa7fae081497/vmlinux-37a93dd5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9096b39b53e1/bzImage-37a93dd5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+460792609a79c085f79f@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fe00de15fac R14: 00007fe00de15fa0 R15: 00007fe00de15fa0
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 5994 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:bitmap_subset include/linux/bitmap.h:433 [inline]
RIP: 0010:cpumask_subset include/linux/cpumask.h:836 [inline]
RIP: 0010:rebuild_sched_domains_locked+0x2aa/0x980 kernel/cgroup/cpuset.c:967
Code: 7d 05 00 41 83 c4 01 89 de 48 83 c5 08 44 89 e7 e8 fb 76 05 00 41 39 dc 0f 8d 4c 04 00 00 e8 fd 7c 05 00 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 1d 06 00 00 48 8b 04 24 48 23 45 00 31 ff 44
RSP: 0018:ffffc90003ecfbc0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000020
RDX: ffff888028de0000 RSI: ffffffff8200f003 RDI: ffffffff8df14f28
RBP: 0000000000000000 R08: 0000000000000cc0 R09: 00000000ffffffff
R10: ffffffff8e7d95b3 R11: 0000000000000001 R12: 0000000000000000
R13: 00000000000f4240 R14: dffffc0000000000 R15: 0000000000000000
FS:  000055555c694500(0000) GS:ffff8881246a5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f463fff CR3: 000000003704c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rebuild_sched_domains_cpuslocked kernel/cgroup/cpuset.c:983 [inline]
 rebuild_sched_domains+0x21/0x40 kernel/cgroup/cpuset.c:990
 sched_rt_handler+0xb5/0xe0 kernel/sched/rt.c:2911
 proc_sys_call_handler+0x47f/0x5a0 fs/proc/proc_sysctl.c:600
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1070 fs/read_write.c:688
 ksys_write+0x12a/0x250 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe00db9bf79
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff27bcda88 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fe00de15fa0 RCX: 00007fe00db9bf79
RDX: 00000000000000f6 RSI: 0000200000000000 RDI: 0000000000000003
RBP: 00007fff27bcdaf0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fe00de15fac R14: 00007fe00de15fa0 R15: 00007fe00de15fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bitmap_subset include/linux/bitmap.h:433 [inline]
RIP: 0010:cpumask_subset include/linux/cpumask.h:836 [inline]
RIP: 0010:rebuild_sched_domains_locked+0x2aa/0x980 kernel/cgroup/cpuset.c:967
Code: 7d 05 00 41 83 c4 01 89 de 48 83 c5 08 44 89 e7 e8 fb 76 05 00 41 39 dc 0f 8d 4c 04 00 00 e8 fd 7c 05 00 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 1d 06 00 00 48 8b 04 24 48 23 45 00 31 ff 44
RSP: 0018:ffffc90003ecfbc0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000020
RDX: ffff888028de0000 RSI: ffffffff8200f003 RDI: ffffffff8df14f28
RBP: 0000000000000000 R08: 0000000000000cc0 R09: 00000000ffffffff
R10: ffffffff8e7d95b3 R11: 0000000000000001 R12: 0000000000000000
R13: 00000000000f4240 R14: dffffc0000000000 R15: 0000000000000000
FS:  000055555c694500(0000) GS:ffff8881246a5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f463fff CR3: 000000003704c000 CR4: 00000000003526f0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	05 00 41 83 c4       	add    $0xc4834100,%eax
   5:	01 89 de 48 83 c5    	add    %ecx,-0x3a7cb722(%rcx)
   b:	08 44 89 e7          	or     %al,-0x19(%rcx,%rcx,4)
   f:	e8 fb 76 05 00       	call   0x5770f
  14:	41 39 dc             	cmp    %ebx,%r12d
  17:	0f 8d 4c 04 00 00    	jge    0x469
  1d:	e8 fd 7c 05 00       	call   0x57d1f
  22:	48 89 e8             	mov    %rbp,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2e:	0f 85 1d 06 00 00    	jne    0x651
  34:	48 8b 04 24          	mov    (%rsp),%rax
  38:	48 23 45 00          	and    0x0(%rbp),%rax
  3c:	31 ff                	xor    %edi,%edi
  3e:	44                   	rex.R


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

