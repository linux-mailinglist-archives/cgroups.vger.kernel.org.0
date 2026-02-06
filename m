Return-Path: <cgroups+bounces-13745-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCBxGIAmhmlSKAQAu9opvQ
	(envelope-from <cgroups+bounces-13745-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 18:36:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B08101250
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 18:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D407301E237
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 17:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DADE3A0E8F;
	Fri,  6 Feb 2026 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YsgO2JBK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCF629BDB5
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399041; cv=none; b=YbyElt8gRjxzzlCZShtXrcCRoNkZ1Kb/4VwvJ1lti3jF10dx8SGpJSHFqXahHL3x4jmufe9Uq1jNotJ9cdBRpHz8o4NcefQEBmohVHY5BZhA93IB+pxc9NBbhvDw6XasD2atdcoVphJOOhS62X8PKXoMf1iyxrlhJ4HBL0mQBCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399041; c=relaxed/simple;
	bh=X3wM3Yv9p6OLlLt/vrVIIoaX1QJ08pqi56ujLswUyhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfJCZTIRrPz6j4dG9WJoC8B7wo8QbHH0lrCHDTjxPlojFBJZPTVG6jm1AI3t4tXwFYNYA1oAHoKReHXO537sNzMDqbC+/zlcy+rnxckExBTKv1evAfBxvmKz9JIr98ivO/AZ1mG8QRPL0F0pWiqZg7yGxyWw4Xsi0jFj8QGpT2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YsgO2JBK; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Feb 2026 09:30:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770399038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2ci6nhI3j7ZOgP8M5vOd80tULh6Zm9vUAl8sjnJkCs=;
	b=YsgO2JBKLwqx2QHEJ/wWcFksHlSgVaIOLCvMJIa4ge63THx3Mibi8nz9mHSHmHF+XyGYrG
	wNnQV43jMurMligroEsF4RtCH/3y6c4iWZGEWDjgauk8q+34ffWme57AQ6QX2VJnGpfpfJ
	nvPhAR+0HRhm/SRnaNaJNrGkjhpwuxA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+e12bd9ca48157add237a@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, syzkaller-bugs@googlegroups.com, kasong@tencent.com
Subject: Re: [syzbot] [cgroups?] [mm?] KASAN: wild-memory-access Read in
 lookup_swap_cgroup_id (2)
Message-ID: <aYYkvaqYGLXD3_P-@linux.dev>
References: <69859728.050a0220.3b3015.0033.GAE@google.com>
 <CACT4Y+bd+PcL=XzkehM-bmsfAB95UA2y9jr5JY2ov8zVOp1DWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bd+PcL=XzkehM-bmsfAB95UA2y9jr5JY2ov8zVOp1DWA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f1fac0919970b671];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13745-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,storage.googleapis.com:url];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups,e12bd9ca48157add237a];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: A8B08101250
X-Rspamd-Action: no action

+Kairui

On Fri, Feb 06, 2026 at 08:31:19AM +0100, Dmitry Vyukov wrote:
> On Fri, 6 Feb 2026 at 08:24, syzbot
> <syzbot+e12bd9ca48157add237a@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    18f7fcd5e69a Linux 6.19-rc8
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1428fc5a580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f1fac0919970b671
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e12bd9ca48157add237a
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/2c19d9acc149/disk-18f7fcd5.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/02cf07c94e58/vmlinux-18f7fcd5.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/84011cec9819/bzImage-18f7fcd5.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+e12bd9ca48157add237a@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: wild-memory-access in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> > BUG: KASAN: wild-memory-access in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> > BUG: KASAN: wild-memory-access in __swap_cgroup_id_lookup mm/swap_cgroup.c:28 [inline]
> > BUG: KASAN: wild-memory-access in lookup_swap_cgroup_id+0xf9/0x1a0 mm/swap_cgroup.c:127
> > Read of size 4 at addr 0007fffffffffffc by task syz.5.3598/20029
> >
> > CPU: 1 UID: 0 PID: 20029 Comm: syz.5.3598 Tainted: G             L      syzkaller #0 PREEMPT(full)
> > Tainted: [L]=SOFTLOCKUP
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
> >  kasan_report+0xdf/0x1a0 mm/kasan/report.c:595
> >  check_region_inline mm/kasan/generic.c:186 [inline]
> >  kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
> >  instrument_atomic_read include/linux/instrumented.h:68 [inline]
> >  atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> >  __swap_cgroup_id_lookup mm/swap_cgroup.c:28 [inline]
> >  lookup_swap_cgroup_id+0xf9/0x1a0 mm/swap_cgroup.c:127
> >  swap_pte_batch+0x3c3/0x720 mm/internal.h:390
> >  zap_nonpresent_ptes mm/memory.c:1749 [inline]
> >  do_zap_pte_range mm/memory.c:1818 [inline]
> >  zap_pte_range mm/memory.c:1858 [inline]
> >  zap_pmd_range mm/memory.c:1950 [inline]
> >  zap_pud_range mm/memory.c:1978 [inline]
> >  zap_p4d_range mm/memory.c:1999 [inline]
> >  unmap_page_range+0x1f6f/0x43e0 mm/memory.c:2020
> >  unmap_single_vma+0x153/0x240 mm/memory.c:2062
> >  unmap_vmas+0x218/0x470 mm/memory.c:2104
> >  exit_mmap+0x181/0xae0 mm/mmap.c:1277
> >  __mmput+0x12a/0x410 kernel/fork.c:1173
> >  mmput+0x67/0x80 kernel/fork.c:1196
> >  exit_mm kernel/exit.c:581 [inline]
> >  do_exit+0x78a/0x2a30 kernel/exit.c:959
> >  do_group_exit+0xd5/0x2a0 kernel/exit.c:1112
> >  get_signal+0x1ec7/0x21e0 kernel/signal.c:3034
> >  arch_do_signal_or_restart+0x91/0x7a0 arch/x86/kernel/signal.c:337
> >  __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
> >  exit_to_user_mode_loop+0x86/0x4b0 kernel/entry/common.c:75
> >  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
> >  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
> >  syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
> >  syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
> >  do_syscall_64+0x4fe/0xf80 arch/x86/entry/syscall_64.c:100
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f2f8f19aeb9
> > Code: Unable to access opcode bytes at 0x7f2f8f19ae8f.
> > RSP: 002b:00007f2f900350e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> > RAX: fffffffffffffe00 RBX: 00007f2f8f416098 RCX: 00007f2f8f19aeb9
> > RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f2f8f416098
> > RBP: 00007f2f8f416090 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007f2f8f416128 R14: 00007ffc0c8cc050 R15: 00007ffc0c8cc138
> >  </TASK>
> > ==================================================================
> 
> This happened before:
> https://lore.kernel.org/all/67d04360.050a0220.1939a6.000e.GAE@google.com/T/
> and now 2 more times.
> All reports look similar: exit_mm -> zap_p4d_range
> And all access addresses look the same: top 13 bits are zeros, then
> some garbage (0007fffffffffffc).
> I am pretty sure it's telling us something, some kind of tricky race,
> rather than a previous corruption. Swp entry is somehow invalid?

Thanks for the report. It would be good to have a reproducer. I will dig
deeper later but good to have eyes from Kairui who has recent changes
in the area.

