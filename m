Return-Path: <cgroups+bounces-15999-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ym9uA6IVCGqYYgMAu9opvQ
	(envelope-from <cgroups+bounces-15999-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 08:58:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5D255A885
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 08:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6228D301691E
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 06:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4614D2DF15C;
	Sat, 16 May 2026 06:58:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC41A682E
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778914716; cv=none; b=G5SyoqzA4/WFjUvLcsMhca9/jUQWeyNIgMAHqAX8eBSkV3KX7r1QYVwY4YWutPROF5d7D8mhrmbyuy3GAcPw7mbVGzm1zE1OkZKi0wL2tXunEO+TiDCkeR7jVij6B4qERG5UNiDkDhzFsxOztlkN5ylFIWHDC/8Mm7xGvmf20I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778914716; c=relaxed/simple;
	bh=SnPn74b/33tT3dWdo4L6P/haSV8WjrzDDwDyO/dAMgs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=m7/cwWKzdGZCF8HBV4G2vpi3hGq62ZXlKEYaw00KyobOHxPbZVrkOwMFV6wSZiOC8BQxl8qBZCbN+SR5cygx5321BkbVPvRizyIFtZAxGeTbPBn+UGY+MrsTT3+hT9kdcAMLQ+ilpxyiA+JyDKLQvYeDvcUd6+ujEAXhPwKuJ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6853c2438b9so736094eaf.3
        for <cgroups@vger.kernel.org>; Fri, 15 May 2026 23:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778914714; x=1779519514;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwSP8NA9NX4+ziNnxsMZYgv7MI6qgmjM/3UjebHnW6A=;
        b=c5QNHTkla1oSZ0ENgfG0Avjc3PNVhwOUymMhAmbbL5ZKwQWk0gRu31A9xzcHkKakDv
         Pzyt6h2FJq2xpqko042tkF0HhNCRhdW8yvH1U8zmW1k3BkhuWgUK6DZuIjJK79t46mYH
         f0epmz811dNhaVwqevjmKSYWVxUP7pmFOLl2d/NQjLTR7U9ABULm8MeVvQ5NzTFlnTFr
         ig94Y45L0kOno1DiOVW6uPvSbkgrle4arG5nkmKIeyujmfJoqyqwr6AlOO7w34mBWgNA
         3iYZQ46wa4rLkQkZ56WbJQaTAjHqhzAN+lRXARbmRhc6+4NhfDiRK7+ijO5o1FtSfq22
         htug==
X-Forwarded-Encrypted: i=1; AFNElJ9j02ux3EO9ZwdeBPj1K4uPQ55qmz71rGK9o46+BSwlqlmJ7eeepKNeuOu87L7XX9OhFyFHBrZ0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+fTc5qQPIINgDcmUltQ4j7EiiX5LGlC6qyLdAFI87BbeEkMU
	3ige8g46/OK/2lvecwWScfm4NFnGNQzZ7PMpcFQ28kXAYDsm4Hox+PaFTm2XvarCT0eCrqHYJqW
	B50C9LGRVTCmawpQq+THLZkGMChaLXwD/YNoIBzOKUntVqbW9+71s+tPQrHQ=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f005:b0:696:8c3f:d7d8 with SMTP id
 006d021491bc7-69c9437be21mr4084981eaf.37.1778914713816; Fri, 15 May 2026
 23:58:33 -0700 (PDT)
Date: Fri, 15 May 2026 23:58:33 -0700
In-Reply-To: <20260515171953.2224503-1-shakeel.butt@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a081599.170a0220.4530d.0003.GAE@google.com>
Subject: [syzbot ci] Re: memcg: cache obj_stock by memcg, not by objcg pointer
From: syzbot ci <syzbot+cid9f726b45197a5e5@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@kernel.org, muchun.song@linux.dev, oliver.sang@intel.com, 
	qi.zheng@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4C5D255A885
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlesource.com:url,appspotmail.com:email,syzbot.org:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-15999-lists,cgroups=lfdr.de,cid9f726b45197a5e5];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v1] memcg: cache obj_stock by memcg, not by objcg pointer
https://lore.kernel.org/all/20260515171953.2224503-1-shakeel.butt@linux.dev
* [PATCH] memcg: cache obj_stock by memcg, not by objcg pointer

and found the following issue:
WARNING in __refill_obj_stock

Full report is available here:
https://ci.syzbot.org/series/8efc6e46-4b2e-43ab-90a0-62552bdc14a6

***

WARNING in __refill_obj_stock

tree:      mm-new
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
base:      0cec77cfd5314c0b3b03530abe1a4b32e991f639
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/fda0a69d-af56-4b9f-8b30-b63ea4756923/config

------------[ cut here ]------------
debug_locks && !(rcu_read_lock_held() || lock_is_held(&(&cgroup_mutex)->dep_map))
WARNING: ./include/linux/memcontrol.h:380 at __refill_obj_stock+0x4fd/0x610, CPU#0: syz.1.48/5712
Modules linked in:

CPU: 0 UID: 0 PID: 5712 Comm: syz.1.48 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__refill_obj_stock+0x4fd/0x610
Code: 89 e7 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 d8 ba 00 00 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 90 <0f> 0b 90 e9 a8 fb ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 60
RSP: 0018:ffffc9000483f4b0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88810beb0f80 RCX: 0000000080000001
RDX: 0000000000000110 RSI: ffffffff8e21e93e RDI: ffffffff8c28b8e0
RBP: 0000000000000001 R08: ffffffff8239a83c R09: ffff88812103c600
R10: dffffc0000000000 R11: ffffed102d89bae9 R12: 1ffff110242078c8
R13: ffff88810beb0d80 R14: dffffc0000000000 R15: ffff88812103c600
FS:  0000000000000000(0000) GS:ffff88818dc89000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f80ad948060 CR3: 000000000e74a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __memcg_slab_free_hook+0x2ed/0x4b0
 kmem_cache_free+0x381/0x650
 __put_anon_vma+0x12b/0x2d0
 unlink_anon_vmas+0x58b/0x730
 free_pgtables+0x802/0xb40
 exit_mmap+0x490/0x9e0
 __mmput+0x118/0x430
 exit_mm+0x18e/0x250
 do_exit+0x6a2/0x22c0
 do_group_exit+0x21b/0x2d0
 get_signal+0x1284/0x1330
 arch_do_signal_or_restart+0xbc/0x840
 exit_to_user_mode_loop+0x8c/0x4d0
 do_syscall_64+0x33e/0xf80
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6eea99ce59
Code: Unable to access opcode bytes at 0x7f6eea99ce2f.
RSP: 002b:00007f6eeb8240e8 EFLAGS: 00000246
 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007f6eeac15fa8 RCX: 00007f6eea99ce59
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f6eeac15fac
RBP: 00007f6eeac15fa0 R08: 3fffffffffffffff R09: 0000000000000000
R10: 0000200001000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6eeac16038 R14: 00007fffdc60cea0 R15: 00007fffdc60cf88
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.

