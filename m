Return-Path: <cgroups+bounces-6553-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41173A35B61
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2025 11:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66B83AD93D
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2025 10:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6CB245AFB;
	Fri, 14 Feb 2025 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A+Nbgz9k"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B787642AAF;
	Fri, 14 Feb 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528406; cv=none; b=WDVipCYyUqj63RJGrAzNhMZ6RPAb6Yf7gUwMx+4HJKikZVt7GYTQXRFRRcXl/8D9ct7U7nrP+O5citpEEx51YswOmxH3JT0R7GDpkwIb13Svl13tWGeN7ROlhpcN9COwbc4Z1isAc+IT4qX9+6H1pvEeLA554k14yOm+LM0Qc5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528406; c=relaxed/simple;
	bh=kfMj4c6O3tWgc6ztXJvVUog3WM88q7v0yQVPPXUMeFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXwaga/woPM31t5tnGnh9P397f7oJBwfGYE3pxDoUK06pmIFG671qgb06Ea0WQqblOowr88Ly6Q4watyWogpAaYA5OWiWMcGZSpOHSqjoRlDMjyj7h4h83rrRwQU4VVpxo6Mi+lw9wHQ1ze1pjsFrpnBGaWyvFKzsOi4KIXcQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A+Nbgz9k; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cpfkoDvOz4Ksm3PzH+IRQujrKVmY4HveZdCkzBUmOg0=; b=A+Nbgz9kuBQAaQFsIKUsf02sjO
	HjM/VOEHxZID581T0CJI6hOBcOB5coIf0rzD9GzM4wWeTUooBC1RoOjxBQ/s4D+csj1rQUVxXFZff
	Hiy/xcI7lbIaJNBBYgk51xmRRFn5l/OOOXG9SzWiXSToedEuLapQ6KzSqaoUUTIsdR9/wB0LKkWji
	zpeLYVeho/7R6Lq3AAibZ5ArRly0msBjVzjy8Csdf0OeS1hjwecfy6dRlc13Nl78sG+ua1ikT+QZ9
	E19gigOuUAP9ztHs3RM7FfU33KqN6G0qEK4NXrColSifQrcwKxy3fEN9kaPJ/gz63N5IWyfbpfKM/
	bN+DH67Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tisng-00000001EI7-3jOw;
	Fri, 14 Feb 2025 10:20:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C2E3930050D; Fri, 14 Feb 2025 11:19:59 +0100 (CET)
Date: Fri, 14 Feb 2025 11:19:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <llong@redhat.com>
Cc: syzbot <syzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com>,
	cgroups@vger.kernel.org, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, mkoutny@suse.com,
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Subject: Re: [syzbot] [cgroups?] possible deadlock in __run_timer_base (2)
Message-ID: <20250214101959.GH21726@noisy.programming.kicks-ass.net>
References: <67a9136a.050a0220.110943.001e.GAE@google.com>
 <2aaa1663-fa9c-43ce-9421-60019899bac1@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aaa1663-fa9c-43ce-9421-60019899bac1@redhat.com>

On Tue, Feb 11, 2025 at 09:14:12PM -0500, Waiman Long wrote:
> On 2/9/25 3:43 PM, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    92514ef226f5 Merge tag 'for-6.14-rc1-tag' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=179453df980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1909f2f0d8e641ce
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ed801a886dfdbfe7136d
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-92514ef2.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/c4d8b91f8769/vmlinux-92514ef2.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/c24ec4365966/bzImage-92514ef2.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com
> 
> This problem should be fixed by the following upstream patch once it is
> merged into mainline.
> 
> https://lore.kernel.org/lkml/20250127013127.3913153-1-longman@redhat.com/
> 

AFAICT all these lockdep reports are because of an earlier warning. Fix
warning, report goes away. Notably:

> >         _printk+0xd5/0x120 kernel/printk/printk.c:2457
> >         __report_bug lib/bug.c:195 [inline]
> >         report_bug+0x346/0x500 lib/bug.c:219
> >         handle_bug+0x60/0x90 arch/x86/kernel/traps.c:285
> >         exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:309
> >         asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
> >         expire_timers kernel/time/timer.c:1827 [inline]

IOW I think we're focusing on the wrong thing here.

> Peter, are you planning to merge this patch? This is another instance where
> the old way of calling wake_up_process() inside the lock critical region can
> lead to deadlock.

I still don't love the Changelog, but yeah, I suppose I can pick it up.
But I see Boqun took it and I'll get it eventually.

No real hurry there I suppose.

