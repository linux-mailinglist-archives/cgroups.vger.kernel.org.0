Return-Path: <cgroups+bounces-16791-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 90qCIBacKGoYGwMAu9opvQ
	(envelope-from <cgroups+bounces-16791-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 01:04:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D03AB664B27
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 01:04:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16791-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16791-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 803C6303FF9A
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 23:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E585F3C197C;
	Tue,  9 Jun 2026 23:04:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F15368287
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 23:04:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046275; cv=none; b=bzmME0tEORH58ZKkymuN3iBUk7GB0EaMU3N2JCviKRic5/dnXe7cY/ZNnadFkNxSt4Mwhr44g63du9ZeMko0oR46fbMlTikpqPmAqi/zAqUsQoqieax2tPl7kXYlAtdbSTb3TPYI0ZgSrxwxB6lhfhnIXSNtvK66wEunjm1Brmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046275; c=relaxed/simple;
	bh=bh+MNbKEbVSmeqmrTm0maztBaeQGvdCEOWzR6EEoFJA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UpPjABLAxqe3Pj4qBZVErFWon0PY7cDeOO7sGJ2Fz1gkwwUjkCVt35oMjgt/LwGk52QZTvskyjIFxVf392ronkgdC2J1IV53S98+MeoHvtTtYlHgeErBTd/Rd07mX9S+Hohp6a63dHbHFzR7eZdPTZl8Tbu6Aw/eJEQogog+tSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-48687df43c4so9503253b6e.0
        for <cgroups@vger.kernel.org>; Tue, 09 Jun 2026 16:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781046273; x=1781651073;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLcbPIP3DqH41We2y8RFQOo6XVKoUumZBhjBdhDFF2M=;
        b=QEzekV5Z5+fgpKuZk8MYlzJH5fzVgzjYThCluqXMxcs9Xb12EcBa1ozHlsyjSBw8nW
         I65D8M5rjgJprU+FgBW4DzGvCisaLsz7TREPu679Dm3Jd18xyQTQ3oAh5MCZ6+BUtQPa
         lpMyu6hQyP/AbU7o5yFkVC0opiUK3+nyaiaoTPOBybtFK2pYkAEi4bcffC57gNk9iD0J
         aqF6zANAlXOKj3exzsuQEa9/lz7JuzJ+BKwfDoX189cNBTNSbb0FbG7y3sAJ8cZszh8k
         JCOoYQHIcwPvEpjjx98duzNtG5wQAhtXUqiqsnT1ldNp49SGSX6dVLEDTeoNBC/ChRgs
         peLw==
X-Forwarded-Encrypted: i=1; AFNElJ8c3IeTthKHK4YhjsIYMV2fdUNjRbQQrwJKXUUUWNoheKTfH74ZPl3DsraUwFLddCDKVqpLKpZe@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr64PVocvcjViVQ3liudiAJNaX1BaYicD1/EZdjTKEqyLWuBBj
	KL0fNxaRdtbcMCufA7z2SY3/SmeRIoZxAVAn1rbDSI6OC3dZcqHWHnR5KJJhAK4FgSderhOq69F
	JbhCx/6QQtA+F2udzVnPWCUCqybuQ72do7SdOLrqeXzDeVWdzyDQeglLelks=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b86:b0:67d:ea53:b9c8 with SMTP id
 006d021491bc7-69eac8d9b8dmr3506618eaf.18.1781046273469; Tue, 09 Jun 2026
 16:04:33 -0700 (PDT)
Date: Tue, 09 Jun 2026 16:04:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a289c01.39669fcc.33b062.00a9.GAE@google.com>
Subject: [syzbot] [cgroups?] [mm?] WARNING in hrtick_start_fair
From: syzbot <syzbot+2cbf10efc23b22ff9c31@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, cgroups@vger.kernel.org, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=da47745f686dc823];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:anna-maria@linutronix.de,m:cgroups@vger.kernel.org,m:frederic@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:syzkaller-bugs@googlegroups.com,m:tglx@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16791-lists,cgroups=lfdr.de,2cbf10efc23b22ff9c31];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,appspotmail.com:email,syzkaller.appspotmail.com:from_mime,storage.googleapis.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlegroups.com:email,syzkaller.appspot.com:url];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D03AB664B27

Hello,

syzbot found the following issue on:

HEAD commit:    a87737435cfa Add linux-next specific files for 20260608
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11715db6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da47745f686dc823
dashboard link: https://syzkaller.appspot.com/bug?extid=2cbf10efc23b22ff9c31
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12df60ae580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11edb0ae580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/85d19fe6bb4e/disk-a8773743.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30c683ce26e1/vmlinux-a8773743.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4db5027513d2/bzImage-a8773743.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2cbf10efc23b22ff9c31@syzkaller.appspotmail.com

------------[ cut here ]------------
task_rq(p) != rq
WARNING: kernel/sched/fair.c:7656 at hrtick_start_fair+0x196/0x1f0 kernel/sched/fair.c:7656, CPU#0: rcu_preempt/18
Modules linked in:
CPU: 0 UID: 0 PID: 18 Comm: rcu_preempt Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:hrtick_start_fair+0x196/0x1f0 kernel/sched/fair.c:7656
Code: 42 80 3c 20 00 74 08 4c 89 ff e8 85 e3 97 00 4d 39 37 0f 85 0c ff ff ff 48 89 df 5b 41 5c 41 5d 41 5e 41 5f e9 4b 65 fa ff 90 <0f> 0b 90 e9 d1 fe ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 82
RSP: 0018:ffffc900001777e0 EFLAGS: 00010087
RAX: ffff8880b873ba40 RBX: ffff8880b863ba40 RCX: ffffffff8197c7de
RDX: 0000000000000000 RSI: ffff88802c528000 RDI: ffff8880b863ba40
RBP: dffffc0000000000 R08: ffffffff8fcf0b0f R09: 1ffffffff1f9e161
R10: dffffc0000000000 R11: fffffbfff1f9e162 R12: dffffc0000000000
R13: 1ffff110170c78d6 R14: ffff88802c528000 R15: ffffffff8dc217d8
FS:  0000000000000000(0000) GS:ffff888125a76000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007eff95e6a540 CR3: 0000000028e30000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 set_next_task_fair+0xa68/0xce0 kernel/sched/fair.c:15058
 put_prev_set_next_task kernel/sched/sched.h:2770 [inline]
 pick_next_task kernel/sched/core.c:6443 [inline]
 __schedule+0x3e03/0x5550 kernel/sched/core.c:7144
 __schedule_loop kernel/sched/core.c:7308 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7323
 schedule_timeout+0x158/0x2c0 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x312/0x11b0 kernel/rcu/tree.c:2123
 rcu_gp_kthread+0x9e/0x2b0 kernel/rcu/tree.c:2325
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
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

