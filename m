Return-Path: <cgroups+bounces-3412-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE4791ACDB
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 18:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B221C26348
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF96198838;
	Thu, 27 Jun 2024 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Kx2k2th8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7415D18B1A
	for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505870; cv=none; b=fqZL5++tX9tNE4X+4vusWY9bD5xAwTfab1gCUQVtrXh10B/F+L49lRH63enpi9bW1FBWTF/B4/sGGEWakP71hFRZVJYsP1A67VSCGsDX2vJTZ642VQ9iHORZcUDvikWScOw1JJnKka41PactJuSezgAgFcrlPrp28Ayn0bgneo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505870; c=relaxed/simple;
	bh=rbPUP6fg+E+zMZem2W8dw06xr/P36TLLJcmmekBMiIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQ60PhlB2hfRBlvK2fhhjvDLNJuY5Zt+mPfJJnx7QSWs35xVgn+Uz1iFRftW5Do3lKQYRIUaOVhEZJeM6kBwL/EuKpYq6nXitAF+KsGXjUCroU3Am3D1WK6uL2xArtwg8uYFsWrUixe0z2qQhodJN/bJtV0M2qwZm0qDbFMaOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Kx2k2th8; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b4fe2c79fdso34659166d6.0
        for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1719505866; x=1720110666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=onH/xeAbXWJK2z25s3p7/oY6URlbYd6cQ3Fa4SiGD/Y=;
        b=Kx2k2th8KZSzWS+6RSz1xvXCEYbUyl5meM+zUOT8zbx7tkOS4l7BxtDtoh9aI0GVkZ
         7V3vxHE/ALElxHGr61+Dkfo1rYkZg4sd9A8S2OzG3HREhLEP9QU3uU1iUoQnu/lloULW
         ny5NrMnJR5QgvKjK3UX+rTCiXWO5iHzLUU6S+dKXlr+lAo3WD12GOfewyxUFPeAXeqgI
         ZwSTP3ns1qGtFU2QtH6saQ6RuBMfPxSz4W7K5sRoyZlF64UfXoNvXQHQXfB9cAZzdwyp
         bhHtyBfOhMlsNP/VO18UG2LGyabgN49vLdfPZUND/oRLPcSgAF/eZbKRTm/SFnMqEmzL
         YkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719505866; x=1720110666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onH/xeAbXWJK2z25s3p7/oY6URlbYd6cQ3Fa4SiGD/Y=;
        b=LwudsWuosUZr4EYShlAjVm//3rQazXZ3Mc37/pvkODVmpKxTHueQdxVqZUtIeWJR/3
         hb/AWMnvErrGr9bohNJm+QUTyXqSwwprM0wH4eTLh4aHeniskqlLLnIHqCCjBsh58G/j
         MfUqp20zzNso1q/GcxRRe9Y3WWlR5YDD/aGvFNWwZUBTg8ToyihLTl5FLkd6kr7SPX+4
         I7ccvAqsw0lC/ZuDCm24kWkLG4etGQBRF8quvstXfObzw/ec94GXGMngEYel3TvMi0IV
         /3MjcnDGs8a8qxTT/hMmbpE/YHSfPOVXCqUof/nfPlgUsMINfviZ+k7tf55K2QHJGSQj
         HkwQ==
X-Gm-Message-State: AOJu0Yw9mJhFjskI62XUyp08AW7mPgtRF57+j/SLKNIXMyVyoA62Jv9t
	Djwy8GqGv4iqzxGgkc1ddRl5/PrTGJkCEBBrI1HKne8OOmlD9wtsqlX7v8EWqWi+AMwmfwC7gut
	r
X-Google-Smtp-Source: AGHT+IGUQGL0TI0zwDVxFsmJ+/DowNwtnZ+/+BkwzrbtB6PRJZSCdHijW9zCjMKIc/PiCtphBkeRug==
X-Received: by 2002:ad4:5aad:0:b0:6b5:8f2e:376b with SMTP id 6a1803df08f44-6b58f2e3aa2mr33489886d6.48.1719505866099;
        Thu, 27 Jun 2024 09:31:06 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b592709b30sm6294836d6.130.2024.06.27.09.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:31:05 -0700 (PDT)
Date: Thu, 27 Jun 2024 12:31:00 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: syzbot <syzbot+b7f13b2d0cc156edf61a@syzkaller.appspotmail.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	lizefan.x@bytedance.com, syzkaller-bugs@googlegroups.com,
	tj@kernel.org, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [syzbot] [cgroups?] BUG: sleeping function called from invalid
 context in cgroup_rstat_flush
Message-ID: <20240627163100.GC469122@cmpxchg.org>
References: <000000000000f71227061bdf97e0@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f71227061bdf97e0@google.com>

On Thu, Jun 27, 2024 at 07:03:21AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7c16f0a4ed1c Merge tag 'i2c-for-6.10-rc5' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1511528e980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=12f98862a3c0c799
> dashboard link: https://syzkaller.appspot.com/bug?extid=b7f13b2d0cc156edf61a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/50560e9024e5/disk-7c16f0a4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/080c27daee72/vmlinux-7c16f0a4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c528e0da4544/bzImage-7c16f0a4.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b7f13b2d0cc156edf61a@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at kernel/cgroup/rstat.c:351
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 17332, name: syz-executor.4
> preempt_count: 0, expected: 0
> RCU nest depth: 1, expected: 0
> 1 lock held by syz-executor.4/17332:
>  #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
>  #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
>  #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: filemap_cachestat mm/filemap.c:4251 [inline]
>  #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: __do_sys_cachestat mm/filemap.c:4407 [inline]
>  #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: __se_sys_cachestat+0x3ee/0xbb0 mm/filemap.c:4372
> CPU: 1 PID: 17332 Comm: syz-executor.4 Not tainted 6.10.0-rc4-syzkaller-00330-g7c16f0a4ed1c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  __might_resched+0x5d4/0x780 kernel/sched/core.c:10196
>  cgroup_rstat_flush+0x1e/0x50 kernel/cgroup/rstat.c:351
>  workingset_test_recent+0x48a/0xa90 mm/workingset.c:473
>  filemap_cachestat mm/filemap.c:4314 [inline]
>  __do_sys_cachestat mm/filemap.c:4407 [inline]
>  __se_sys_cachestat+0x795/0xbb0 mm/filemap.c:4372
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Ok yeah, cachestat() holds the rcu read lock, so
workingset_test_recent() can't do a sleepable rstat flush.

I think the easiest fix would be to flush rstat from the root down
(NULL) in filemap_cachestat(), before the rcu section, and add a flag
to workingset_test_recent() to forego it. Nhat?

