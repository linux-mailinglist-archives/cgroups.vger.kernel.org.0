Return-Path: <cgroups+bounces-10513-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E7ABB285E
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 07:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6344E179B95
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 05:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E2826D4F7;
	Thu,  2 Oct 2025 05:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OvHrXvLt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B92248F72
	for <cgroups@vger.kernel.org>; Thu,  2 Oct 2025 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759382540; cv=none; b=peB/M9mZ5M4UtM5d7gZcUSkqP63ZZk5uRec9bh5Jll15UJHHKj8YKXKoB5Wn03kOgwl776v8eSK1ufdzTJ93LcsWBbCGkz4wwazrCz5MJ/ujG/RMOYIjZBOqt6dlki8Bh/OWzOTdHgD4svc/CKSkERvAd3EacAC5cMzCQXRzKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759382540; c=relaxed/simple;
	bh=K5dUnB/rPRs4/uFO5etlJrs3honC1ofWRtYjE7/z49I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NUsIwot1nwiTPMs5cBAO9F9pl4pUeDZ6chEY4wziUapWiLX+CtCzJ594wjcbPA/AyKOdi4xb1xmlQvWduNZAtiY4yDuFeQ2u+Pc13QJ8xHxzuEhLTre5VPCuX+rOhO1JYokgHvLE6xy6Rp3QL07FFl4WCpy3q9JA32LEvSmVbCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OvHrXvLt; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-26e4fcc744dso3615995ad.3
        for <cgroups@vger.kernel.org>; Wed, 01 Oct 2025 22:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759382538; x=1759987338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2MskRbXWx9xZ3cfwXyeqyicyUNKx5SWmHPDU1DgfgcY=;
        b=OvHrXvLt8du9EcF6lwVsPMEQztTI16PUympiJiiNSoJrk6WuFyKteKUo0oyFC4fmnf
         9Rvs8wV5pie/eHzXVI3WFu3A/RVCfRBRRYWLoW5Z8ty0TxGruLOWmYDLT5wA5iU1yTlO
         pGfeyHDKNp49upb/C3EecdsRuGkflsG9Ibyzqq4eWaGWowgxINEIF9xxe5DIwzc7aG5c
         TkDYbUBGFjiEZgdfQ9zyON5mD92gl8DLMmkCfJ8TsoLobOWG9beASshYWLSVD80N7IWf
         XpackRhZAAjneX4Jyl/O1NeN7NzkaiwDibMLzTUnqKSe3sJNhKZYqWNkuLmoqcAYMz1u
         HViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759382538; x=1759987338;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MskRbXWx9xZ3cfwXyeqyicyUNKx5SWmHPDU1DgfgcY=;
        b=Id8JADQkVfKwwmqA0nT67FYrvDp/733vrqIwSbrRzWo8L1eLegkY86HaUppZnpCn3t
         h6p+3MuRJEenWBpwvJvjzP2hHC4VsZwsTDdujDY1kFwPHx2FEd6lhT3yeURh3yb+BN2C
         gOatCkRPyxwR3/zQTYiuF3OveCl9gpM6CnUh9zwxdPE9yxH4EVMWz26cUAI2uOAbRTEM
         yqR1ZnGXQdx1VvvkHtaeH+PWgVzaHmNh2GeUBKzopJ5Qfwt4lw22Jf1zVQKlLNYuMkaF
         2ocv5iJTim5QTXv+x10/A2l1hqK41vGIVQl6J3MyFVmujk4zgKGpo+VA/zJKME25KaKg
         8BlA==
X-Forwarded-Encrypted: i=1; AJvYcCW6EAJhyLK/d97OQ9XDk57vwhLjZOhnlQX//C5mLydEBW7OQkRtNjSir8Y49mRFk9erst6IrkM/@vger.kernel.org
X-Gm-Message-State: AOJu0YwKg7eKcEfkpqk/tlU/OnSO3DwE14SxJejVliR6LnBWCGuOnV5H
	atj9h77uGdlnHWS3s/FNjAGG3cJt8dez08izfNusnPN1ao0NWPnN3OlAn0eXAxystZul7rvDin5
	zTuaE+g==
X-Google-Smtp-Source: AGHT+IHjyYf65SorjHPQ8Oqp9G8GmBeGyG/D8ncklMRdBiC3a9MYURwraenLFtVRqvU1dV8ysAn0qMO6hNw=
X-Received: from plei3.prod.google.com ([2002:a17:902:e483:b0:269:7570:9ef0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a2e:b0:25c:5bda:53a8
 with SMTP id d9443c01a7336-28e7f489e8fmr71572145ad.37.1759382538285; Wed, 01
 Oct 2025 22:22:18 -0700 (PDT)
Date: Thu,  2 Oct 2025 05:22:07 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002052215.1433055-1-kuniyu@google.com>
Subject: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq when CONFIG_PREEMPT_RT=y.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Tiffany Yang <ynaffit@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, cgroups@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, 
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported the splat below. [0]

Commit afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
introduced cgrp->freezer.freeze_seq.

The writer side is under spin_lock_irq(), but the section is still
preemptible with CONFIG_PREEMPT_RT=y.

Let's wrap the section with preempt_{disable,enable}_nested().

[0]:
WARNING: CPU: 0 PID: 6076 at ./include/linux/seqlock.h:221 __seqprop_assert include/linux/seqlock.h:221 [inline]
WARNING: CPU: 0 PID: 6076 at ./include/linux/seqlock.h:221 cgroup_do_freeze kernel/cgroup/freezer.c:182 [inline]
WARNING: CPU: 0 PID: 6076 at ./include/linux/seqlock.h:221 cgroup_freeze+0x80a/0xf90 kernel/cgroup/freezer.c:309
Modules linked in:
CPU: 0 UID: 0 PID: 6076 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)}
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__seqprop_assert include/linux/seqlock.h:221 [inline]
RIP: 0010:cgroup_do_freeze kernel/cgroup/freezer.c:182 [inline]
RIP: 0010:cgroup_freeze+0x80a/0xf90 kernel/cgroup/freezer.c:309
Code: 90 e9 9e fb ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c e7 f9 ff ff 4c 89 f7 e8 e1 43 67 00 e9 da f9 ff ff e8 17 68 06 00 90 <0f> 0b 90 e9 10 fc ff ff 44 89 f9 80 e1 07 38 c1 48 8b 0c 24 0f 8c
RSP: 0018:ffffc90003b178e0 EFLAGS: 00010293
RAX: ffffffff81b6c6a9 RBX: 0000000000000000 RCX: ffff88803671bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003b17a70 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1d6d2a7 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000001 R15: ffff88803623a791
FS:  00005555915ae500(0000) GS:ffff888127017000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33363fff CR3: 0000000023b98000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 cgroup_freeze_write+0x156/0x1c0 kernel/cgroup/cgroup.c:4174
 cgroup_file_write+0x39b/0x740 kernel/cgroup/cgroup.c:4312
 kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5d5/0xb40 fs/read_write.c:686
 ksys_write+0x14b/0x260 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0dc3e9eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd9b7b6198 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f0dc40f5fa0 RCX: 00007f0dc3e9eec9
RDX: 0000000000000012 RSI: 0000200000000200 RDI: 0000000000000004
RBP: 00007f0dc3f21f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0dc40f5fa0 R14: 00007f0dc40f5fa0 R15: 0000000000000003
 </TASK>

Fixes: afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
Reported-by: syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68de0b21.050a0220.25d7ab.077d.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 kernel/cgroup/freezer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 6c18854bff34..7e779c8a6f89 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -179,6 +179,7 @@ static void cgroup_do_freeze(struct cgroup *cgrp, bool freeze, u64 ts_nsec)
 	lockdep_assert_held(&cgroup_mutex);
 
 	spin_lock_irq(&css_set_lock);
+	preempt_disable_nested();
 	write_seqcount_begin(&cgrp->freezer.freeze_seq);
 	if (freeze) {
 		set_bit(CGRP_FREEZE, &cgrp->flags);
@@ -189,6 +190,7 @@ static void cgroup_do_freeze(struct cgroup *cgrp, bool freeze, u64 ts_nsec)
 			cgrp->freezer.freeze_start_nsec);
 	}
 	write_seqcount_end(&cgrp->freezer.freeze_seq);
+	preempt_enable_nested();
 	spin_unlock_irq(&css_set_lock);
 
 	if (freeze)
-- 
2.51.0.618.g983fd99d29-goog


