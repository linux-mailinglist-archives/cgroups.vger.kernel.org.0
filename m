Return-Path: <cgroups+bounces-13910-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPoGHy4XjmlF/QAAu9opvQ
	(envelope-from <cgroups+bounces-13910-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 19:08:46 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C828130283
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 19:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA0FF308D6EF
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 18:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22FE26A08F;
	Thu, 12 Feb 2026 18:08:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAF225BEE8
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770919714; cv=none; b=pWy6kyuOKoRaXYzNmaaCo3OkgAWmot3lEf4vpfBbIa+r2Kb1fhuAfIIe1mVKX0gbaoMzNryIhLn6DMnHUmUCXM/CQhK0a7nkR7mka8OjwCD7ntn1XDnlcVwDtS+XLGVsUDDWncEmyJVueirLRe0ULnaduISgE4YFmgxYfTj5uvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770919714; c=relaxed/simple;
	bh=HImPkHp9naq2C+tRBNg/2m46FyeyuAohNvDbp2boAm8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ZXMo5JUvpn/b5uns4zumhdScgGbwPeNe1J9nDiTWpvsVDbOY+tOt8kIUSI7d7wGefZIZa1ANQdwvt8eQ0oFiFYpFaapv1FTf47MABWa/j4QPi/eItO8MB+Wk++2hhAaSDkkmWd/d7+oZF7XthIF2HzCh1sY6Kwqp4MdxPJA2SIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-40a4d2264abso595057fac.2
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 10:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770919712; x=1771524512;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yvycq04pVPWUL32pOjxUaG+/MLmhhHqjiM5kRuuTJYM=;
        b=YOMWYfr3m72c9O21+bYCA0jXFkEchRAGjjBub2U5ipqu1F5FXlF3py8ibl3S3ikWwL
         4kR3KRo5OVn+A7iXmMmPLJiddpbTm14BjquT712b+IH48c38+9F4XaQ2dQqiQ0Fa4Ain
         9iGBgEEhA1w+/LthBM1JNAN+TfJCWrL7hb2cmoryjFh5um1u73HQYrS/n7Dkmu2zigLI
         qRiG++vnJcLEA+7nI0/Ep06+7p+T26CftEkr4C/80wr66jBXrFb1Tzcy5Hz9PNY+JX+6
         rBenCici5WuinhWnV3t0JJcMS84Vx3asPze+x7P1uvqU7BDYTwztW2q3bpl7AsDELACw
         Fdbw==
X-Forwarded-Encrypted: i=1; AJvYcCVncJUBVRnVtKdmqx4izvcbCTbrIu9w7PeWGdUvqz6INzWoZJGIh4ARBOJuDQdXwUPJ4x4lpTMJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHnvwWKO1Rx+PKuEt0ih6+wPtykvaQoyF94xmF2UjphuKBJjF
	GoYBF3Lurkm3zT8sy1jmrz7frtNogWqjNocEJK3jT4PDr4CIcCjgbznywKXoy0m9LXv95Sd2Hrx
	EI1jj1XfB+eR+qslVrDTIJ4BgBmdtOBmUvIOl/idsO9eY0jpB3ax3dg2Mvew=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:198d:b0:65d:3c7:b57 with SMTP id
 006d021491bc7-676ee27c2f4mr142899eaf.34.1770919712604; Thu, 12 Feb 2026
 10:08:32 -0800 (PST)
Date: Thu, 12 Feb 2026 10:08:32 -0800
In-Reply-To: <20260212045109.255391-1-inwardvessel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698e1720.a70a0220.2c38d7.009c.GAE@google.com>
Subject: [syzbot ci] Re: improve per-node allocation and reclaim visibility
From: syzbot ci <syzbot+ciaf452181ab05b97e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, axelrasmussen@google.com, 
	byungchul@sk.com, cgroups@vger.kernel.org, david@kernel.org, 
	eperezma@redhat.com, gourry@gourry.net, hannes@cmpxchg.org, 
	inwardvessel@gmail.com, jasowang@redhat.com, joshua.hahnjy@gmail.com, 
	kernel-team@meta.com, liam.howlett@oracle.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, mst@redhat.com, muchun.song@linux.dev, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, shakeel.butt@linux.dev, 
	surenb@google.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	weixugc@google.com, xuanzhuo@linux.alibaba.com, ying.huang@linux.alibaba.com, 
	yuanchu@google.com, zhengqi.arch@bytedance.com, ziy@nvidia.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13910-lists,cgroups=lfdr.de,ciaf452181ab05b97e];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,nvidia.com,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,meta.com,oracle.com,kvack.org,intel.com,suse.com,linux.dev,suse.cz,lists.linux.dev,linux.alibaba.com,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,googlesource.com:url]
X-Rspamd-Queue-Id: 9C828130283
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v1] improve per-node allocation and reclaim visibility
https://lore.kernel.org/all/20260212045109.255391-1-inwardvessel@gmail.com
* [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
* [PATCH 2/2] mm: move pgscan and pgsteal to node stats

and found the following issue:
WARNING in __mod_node_page_state

Full report is available here:
https://ci.syzbot.org/series/4ec12ede-3298-43a3-ab6b-79d47759672e

***

WARNING in __mod_node_page_state

tree:      mm-new
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
base:      72a46cdd4ef13690beb8c5a2f6a2023fd7ef2eb4
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/0f678e4c-a4ba-4f17-8ed7-8ae99e56a463/config

------------[ cut here ]------------
IS_ENABLED(CONFIG_PREEMPT_COUNT) && __lockdep_enabled && (preempt_count() == 0 && this_cpu_read(hardirqs_enabled))
WARNING: mm/vmstat.c:396 at __mod_node_page_state+0x126/0x170, CPU#0: kthreadd/2
Modules linked in:
CPU: 0 UID: 0 PID: 2 Comm: kthreadd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__mod_node_page_state+0x126/0x170
Code: 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 48 89 df 4c 89 e6 44 89 fa e8 68 00 00 00 31 db eb cc 90 0f 0b 90 e9 3e ff ff ff 90 <0f> 0b 90 eb 80 48 c7 c7 e0 c6 64 8e 4c 89 f6 e8 66 3c d3 02 e9 28
RSP: 0000:ffffc900000773d0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 000000000000003d RDI: ffff88815fffb380
RBP: dffffc0000000000 R08: ffffffff8fef2977 R09: 1ffffffff1fde52e
R10: dffffc0000000000 R11: fffffbfff1fde52f R12: ffff88815fffb380
R13: ffffffff92f50f00 R14: 000000000000003d R15: 000000000000003d
FS:  0000000000000000(0000) GS:ffff88818e0f0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000e346000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 alloc_pages_mpol+0x407/0x740
 alloc_pages_noprof+0xa8/0x190
 get_free_pages_noprof+0xf/0x80
 __kasan_populate_vmalloc+0x38/0x1d0
 alloc_vmap_area+0xd21/0x1460
 __get_vm_area_node+0x1f8/0x300
 __vmalloc_node_range_noprof+0x372/0x1730
 __vmalloc_node_noprof+0xc2/0x100
 dup_task_struct+0x228/0x9a0
 copy_process+0x508/0x3980
 kernel_clone+0x248/0x870
 kernel_thread+0x13f/0x1b0
 kthreadd+0x4f9/0x6f0
 ret_from_fork+0x51b/0xa40
 ret_from_fork_asm+0x1a/0x30
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

