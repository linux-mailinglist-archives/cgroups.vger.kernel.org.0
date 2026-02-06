Return-Path: <cgroups+bounces-13736-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFqmDRqYhWmUDwQAu9opvQ
	(envelope-from <cgroups+bounces-13736-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 08:28:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAF7FAF6D
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 08:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A975305EC34
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 07:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D85D30BB98;
	Fri,  6 Feb 2026 07:24:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09545302773
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770362665; cv=none; b=C15wRk0d3nvfv8uU81cu4Vd9xrkw9gSShW8ZgUSXMSpW7wTi0uGhC/aVF+o7ecjFHEAB+5yNCjcdlBf4nwEQXVh78VSoHlSuImA45h1vf3qcrfqDmENF0m6Jynw3g6llh5Qn8sSxrUBHe/k89N5g1GuLlHdSVNI27aA87aCuyZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770362665; c=relaxed/simple;
	bh=iBARMvGi2nN6CAOktKdGzKVjcEbruvi7SYevqC6gKRg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CTEQH4pnYib4DNwFD47nPe7Hn180zIMAJ0bN0PWYT7McJcH4LPBxE7h157gAcYA1DRTu5kFRDt8+m0FT2jjtUBcS6qWhoQgBczMSpye3eLgygYkbZ8p6EZ5yRQD/QqtRGnuTHq4erO9n53dkvE3Kak+aHjA/SZ4442QGZWYyw6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-66ad91bd85bso7356224eaf.3
        for <cgroups@vger.kernel.org>; Thu, 05 Feb 2026 23:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770362664; x=1770967464;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ot6ual0l9jo2XolXnfpiqkyLpmBuznoc4sQK0e9mC6I=;
        b=DP4lj28uD3vd7w41Q97tsD89vHJELdt8a5fUqU9FhMUsYnHx99QHyT7/SaFMpEK8yS
         dd5BBhwb+EuY3SCHAKiqtzy7CBySVSFkdJCJpLZRww5RxsfCe15xQMlUBzZe89ypv0um
         B8cCarnVskXrHKSCd9DlUyzqRQihqcrVV9wLn1di6FJqxVcbEeiQOw+ezuARrXSBdtQa
         MckSPCkEr+UarWOXkNlWO2GpIg00sUzfWGEMR7PtZkYN2WFPeF/cse7PgdTIW0Vq2LME
         wvCz1/XZj6h+7zhdDM+B0gihjTtA3J9OjXmsnmU0DSDL444Xd2sx5rrOQxRmoGBxfG1H
         cLKg==
X-Forwarded-Encrypted: i=1; AJvYcCVopS3iUNEK6f0DVo8aLil/9htELNws7CUwJPjI07amAhQJR0fi5umXh8vuLVW6NkOw1LuVUF++@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9EnOdHBLOnZShT1RuWJlwderQeHWIeNkrHo9ZiYqKqRhd2lYN
	4fGAGKcafEk4nMi5DqwDwcK2cqwZMqIkyLMc73KD/CkjQR14PLamTz/KVBm9l/BQ3qeuXkSX6tH
	itHr4ChFv6jwUnZwythu1SwPoUMCHJoNIRZWyhIGOxsYdNf810BixkVW2xWk=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2202:b0:663:d06:81e2 with SMTP id
 006d021491bc7-66d09cabe40mr920061eaf.1.1770362664044; Thu, 05 Feb 2026
 23:24:24 -0800 (PST)
Date: Thu, 05 Feb 2026 23:24:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69859728.050a0220.3b3015.0033.GAE@google.com>
Subject: [syzbot] [cgroups?] [mm?] KASAN: wild-memory-access Read in
 lookup_swap_cgroup_id (2)
From: syzbot <syzbot+e12bd9ca48157add237a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f1fac0919970b671];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13736-lists,cgroups=lfdr.de,e12bd9ca48157add237a];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,syzkaller.appspot.com:url,googlegroups.com:email]
X-Rspamd-Queue-Id: 7DAF7FAF6D
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    18f7fcd5e69a Linux 6.19-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1428fc5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1fac0919970b671
dashboard link: https://syzkaller.appspot.com/bug?extid=e12bd9ca48157add237a
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2c19d9acc149/disk-18f7fcd5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/02cf07c94e58/vmlinux-18f7fcd5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/84011cec9819/bzImage-18f7fcd5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e12bd9ca48157add237a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: wild-memory-access in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: wild-memory-access in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: wild-memory-access in __swap_cgroup_id_lookup mm/swap_cgroup.c:28 [inline]
BUG: KASAN: wild-memory-access in lookup_swap_cgroup_id+0xf9/0x1a0 mm/swap_cgroup.c:127
Read of size 4 at addr 0007fffffffffffc by task syz.5.3598/20029

CPU: 1 UID: 0 PID: 20029 Comm: syz.5.3598 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 kasan_report+0xdf/0x1a0 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:186 [inline]
 kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 __swap_cgroup_id_lookup mm/swap_cgroup.c:28 [inline]
 lookup_swap_cgroup_id+0xf9/0x1a0 mm/swap_cgroup.c:127
 swap_pte_batch+0x3c3/0x720 mm/internal.h:390
 zap_nonpresent_ptes mm/memory.c:1749 [inline]
 do_zap_pte_range mm/memory.c:1818 [inline]
 zap_pte_range mm/memory.c:1858 [inline]
 zap_pmd_range mm/memory.c:1950 [inline]
 zap_pud_range mm/memory.c:1978 [inline]
 zap_p4d_range mm/memory.c:1999 [inline]
 unmap_page_range+0x1f6f/0x43e0 mm/memory.c:2020
 unmap_single_vma+0x153/0x240 mm/memory.c:2062
 unmap_vmas+0x218/0x470 mm/memory.c:2104
 exit_mmap+0x181/0xae0 mm/mmap.c:1277
 __mmput+0x12a/0x410 kernel/fork.c:1173
 mmput+0x67/0x80 kernel/fork.c:1196
 exit_mm kernel/exit.c:581 [inline]
 do_exit+0x78a/0x2a30 kernel/exit.c:959
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1112
 get_signal+0x1ec7/0x21e0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x91/0x7a0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
 exit_to_user_mode_loop+0x86/0x4b0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x4fe/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2f8f19aeb9
Code: Unable to access opcode bytes at 0x7f2f8f19ae8f.
RSP: 002b:00007f2f900350e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f2f8f416098 RCX: 00007f2f8f19aeb9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f2f8f416098
RBP: 00007f2f8f416090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2f8f416128 R14: 00007ffc0c8cc050 R15: 00007ffc0c8cc138
 </TASK>
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

