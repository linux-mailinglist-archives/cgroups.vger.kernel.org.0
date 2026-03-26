Return-Path: <cgroups+bounces-15059-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGhXGrbkxGnz4gQAu9opvQ
	(envelope-from <cgroups+bounces-15059-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 08:48:06 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C645A3309B8
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 08:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E67AF30E131E
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 07:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E8930EF7F;
	Thu, 26 Mar 2026 07:41:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96C22F39C7
	for <cgroups@vger.kernel.org>; Thu, 26 Mar 2026 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774510898; cv=none; b=hphZ5v8ARSOM3BCim2DJWjI149t3HDL9qVgxefJRpW6jjDAA6k0+oMC+/JrkV8WiTaE7nq4X3LYZxeRIKbCOM0rB18NEYQ0GEXTXZtJVb5VOmuJA7ymfVbupDZGV2OZHIUmoK12MuZfCs1EDuX/X9z4h+TJZEpBYbE8TpOK3L9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774510898; c=relaxed/simple;
	bh=k+Wa5mkK/qo4q7naR3icxnM5bJjr1K2O8cdt/ldHW0E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=jhVg4h0FZXLKuhhvQJJQtVs7J5icQ0cAy6aLQOpK6Op1MzQQVJ3vWiks+NmcaGwkdOYSt/Vngkuv70D5zn5gzhq0uAqd+9vQUbzKE5cr+9WPFPSE+C2QS/OOQbIIsb49vFhAETN2/Fd09RZGNFVnOXHPqa/o2068fi3XTwXP/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67dece24dbcso2097040eaf.1
        for <cgroups@vger.kernel.org>; Thu, 26 Mar 2026 00:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774510896; x=1775115696;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZZ5EaHOzm+qNrXdSfZ5XAFEz3HOXnh1h44VtF1Qhog=;
        b=oHIXkmqSI81/Yoc5hnlkiMtbZ2Z85yrHkAbu+M4f6HfhB8eyLr2gtULhCBZUzWyuAN
         Qd5OFK+cs0LN4CgtlwkA7iZmY7FW3G7TY7fwxx+TEaABIyp0ZhBV/brlUdUxQqKXEY/I
         6Co4+oaqeV/dWRDP3HZj1u7p6GKsmJqMRl6SiISqojCsByhP6m3tzHxun7Ky3ybYvAeQ
         qDoLpEmx/usQUCOVpWtYe2M1tOp8Sc07e4vWT+loRnXsYjsiyWb8QLh3RlzAQgH1OB5Y
         Kej3AdWOOHS5Ufr2SP6i4DfF0HBnePOeZlRxeyYhdLThyZuUvjpn3uyiaLzlxoA54nk5
         qdyA==
X-Forwarded-Encrypted: i=1; AJvYcCVDwd2xZnXy3gnHFVLCzrnI07RXTxYiIP7qf+Ir8a0T1TtntapyiMDhODXFGHzAmMFc/xRDnmsx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+fmxRH6x9DWxH+PRUWCEeOil8OAIM6hYGJN82r8LjSssuex3O
	b3A5WLn6e6dT+xIOn1KqZcTeK/kadU4yooS30ypYwmbsIG9ITlguapClo7Kw9RyH9Vxqtgh1Ary
	ltUO4yiri8lugR5iqQq+zhcpDkJpnTzhm8t51YJjP2p+gS8ZXenKb3lnILI4=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2912:b0:67e:aa1:882e with SMTP id
 006d021491bc7-67e0aa18df9mr1504176eaf.62.1774510895883; Thu, 26 Mar 2026
 00:41:35 -0700 (PDT)
Date: Thu, 26 Mar 2026 00:41:35 -0700
In-Reply-To: <20260325175453.2523280-1-youngjun.park@lge.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c4e32f.a70a0220.23629d.000c.GAE@google.com>
Subject: [syzbot ci] Re: mm/swap, memcg: Introduce swap tiers for cgroup based
 swap control
From: syzbot ci <syzbot+ci687e6f97bd3a602d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, baohua@kernel.org, bhe@redhat.com, 
	cgroups@vger.kernel.org, chrisl@kernel.org, gunho.lee@lge.com, 
	hannes@cmpxchg.org, hyungjun.cho@lge.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	mkoutny@suse.com, muchun.song@linux.dev, nphamcs@gmail.com, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, shikemeng@huaweicloud.com, 
	taejoon.song@lge.com, youngjun.park@lge.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15059-lists,cgroups=lfdr.de,ci687e6f97bd3a602d];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,redhat.com,vger.kernel.org,lge.com,cmpxchg.org,tencent.com,kvack.org,suse.com,linux.dev,gmail.com,huaweicloud.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlesource.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: C645A3309B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot ci has tested the following series

[v5] mm/swap, memcg: Introduce swap tiers for cgroup based swap control
https://lore.kernel.org/all/20260325175453.2523280-1-youngjun.park@lge.com
* [PATCH v5 1/4] mm: swap: introduce swap tier infrastructure
* [PATCH v5 2/4] mm: swap: associate swap devices with tiers
* [PATCH v5 3/4] mm: memcontrol: add interfaces for swap tier selection
* [PATCH v5 4/4] mm: swap: filter swap allocation by memcg tier mask

and found the following issue:
WARNING in folio_tier_effective_mask

Full report is available here:
https://ci.syzbot.org/series/6ed50ca2-a106-41e9-aa4d-7c46869e0011

***

WARNING in folio_tier_effective_mask

tree:      mm-new
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
base:      6381a729fa7dda43574d93ab9c61cec516dd885b
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/e5c66fa8-a7fd-4809-9564-448847b5f230/config
C repro:   https://ci.syzbot.org/findings/d64cc6fa-636a-40a0-b131-d02ce1129494/c_repro
syz repro: https://ci.syzbot.org/findings/d64cc6fa-636a-40a0-b131-d02ce1129494/syz_repro

------------[ cut here ]------------
debug_locks && !(rcu_read_lock_held() || lock_is_held(&(&cgroup_mutex)->dep_map))
WARNING: ./include/linux/memcontrol.h:377 at obj_cgroup_memcg include/linux/memcontrol.h:377 [inline], CPU#1: syz.0.17/5955
WARNING: ./include/linux/memcontrol.h:377 at folio_memcg include/linux/memcontrol.h:431 [inline], CPU#1: syz.0.17/5955
WARNING: ./include/linux/memcontrol.h:377 at folio_tier_effective_mask+0x175/0x210 mm/swap_tier.h:63, CPU#1: syz.0.17/5955
Modules linked in:
CPU: 1 UID: 0 PID: 5955 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:obj_cgroup_memcg include/linux/memcontrol.h:377 [inline]
RIP: 0010:folio_memcg include/linux/memcontrol.h:431 [inline]
RIP: 0010:folio_tier_effective_mask+0x175/0x210 mm/swap_tier.h:63
Code: 0f b6 04 20 84 c0 75 6b 8b 03 eb 0a e8 04 b8 9e ff b8 ff ff ff ff 5b 41 5c 41 5e 41 5f 5d c3 cc cc cc cc cc e8 ec b7 9e ff 90 <0f> 0b 90 eb 9b 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c c2 fe ff ff
RSP: 0018:ffffc90004bee6d0 EFLAGS: 00010293
RAX: ffffffff8226dd04 RBX: ffff888113589280 RCX: ffff8881727b8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffea0006c62207 R09: 1ffffd4000d8c440
R10: dffffc0000000000 R11: fffff94000d8c441 R12: dffffc0000000000
R13: ffffea0006c62208 R14: ffffea0006c62200 R15: ffffea0006c62230
FS:  00005555771cb500(0000) GS:ffff8882a9462000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ed63fff CR3: 0000000112d86000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 swap_alloc_fast mm/swapfile.c:1355 [inline]
 folio_alloc_swap+0x392/0x13a0 mm/swapfile.c:1735
 shrink_folio_list+0x26a7/0x5250 mm/vmscan.c:1281
 reclaim_folio_list+0x100/0x460 mm/vmscan.c:2171
 reclaim_pages+0x45b/0x530 mm/vmscan.c:2208
 madvise_cold_or_pageout_pte_range+0x1ef5/0x2220 mm/madvise.c:563
 walk_pmd_range mm/pagewalk.c:142 [inline]
 walk_pud_range mm/pagewalk.c:233 [inline]
 walk_p4d_range mm/pagewalk.c:275 [inline]
 walk_pgd_range+0xfdc/0x1d90 mm/pagewalk.c:316
 __walk_page_range+0x14c/0x710 mm/pagewalk.c:424
 walk_page_range_vma_unsafe+0x309/0x410 mm/pagewalk.c:728
 madvise_pageout_page_range mm/madvise.c:622 [inline]
 madvise_pageout mm/madvise.c:647 [inline]
 madvise_vma_behavior+0x28b9/0x42c0 mm/madvise.c:1358
 madvise_walk_vmas+0x573/0xae0 mm/madvise.c:1713
 madvise_do_behavior+0x386/0x540 mm/madvise.c:1929
 do_madvise+0x1fa/0x2e0 mm/madvise.c:2022
 __do_sys_madvise mm/madvise.c:2031 [inline]
 __se_sys_madvise mm/madvise.c:2029 [inline]
 __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:2029
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5e5af9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0c8e2708 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007f5e5b215fa0 RCX: 00007f5e5af9c799
RDX: 0000000000000015 RSI: 0000000000600000 RDI: 0000200000000000
RBP: 00007f5e5b032c99 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5e5b215fac R14: 00007f5e5b215fa0 R15: 00007f5e5b215fa0
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

