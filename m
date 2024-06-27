Return-Path: <cgroups+bounces-3419-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F2C91AF70
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 21:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225F9282819
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA2919AD55;
	Thu, 27 Jun 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN86Cslf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AC19A294;
	Thu, 27 Jun 2024 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719515360; cv=none; b=ACQch0m4RmUM2oppdlGjLCj5q0NubSHshOGxFon96nkm0fsYNnW6Y04M8CSOJm/PMmu0VcTl+cE9y7FQhy+RJZ9qf1+PeMy/8+JFhxUgEIg38/77+zbBJ9iUQK7P63EWw53GtI2EVioqrNgE5Dcz8YV4bhdT162Mn0PO5g+rj4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719515360; c=relaxed/simple;
	bh=BJFGnMnNLxYSOMjRrF2O+HAjnBxN8qoTJhmm/fQHryE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyKTAQECKpsbqsW2PZVekjzYzGv2WYk3R4QMXPlKne4CdTEJsLPJPDwujKqSURvwTk8cBNUy0NmVWJtFMzVKwSItCGLhlb0NivnfcWkWmDCfHF8oo41MeEhTHX7OxYCWErtGFpxIsv24vTZ3kYWLQl1roFDUMKr2Pq+kGImketo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RN86Cslf; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-445033fbc24so19050451cf.3;
        Thu, 27 Jun 2024 12:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719515357; x=1720120157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0+hj8sR+QbQ9EpFDrzEmuUbfGkJIqPXAt68R7keXiY=;
        b=RN86CslfAZU5XOk5xT68eqz4E4SAzE9cbdmLQAonYngXi5GPDUfhTI2Py7A+1DrU30
         YGLloxEdLLGLObsD7vaIr+2Jret7Bki/BWrjCivbXdNTh4IpV6iVyDrhYcZtMH5fFcAI
         nHXBM8zHDtAi+4R7IQkSW6Z2/gX+4/SupSZGqTpJSsIiu0Zl6yaVbg1wczf8s0lbC8DP
         QGp8QAa/IA2iA9yDqy3FtZcGUIBk3rITWGtnksBAGe/+Zp2TL5NPqAOpWpTsgzNxbzP8
         qWQu8i0G0xODcjsZEUpbRNEjrMYv2nrAvU6H5aF2MDanlpG35f2Dt18/7SrWYD1eEbFt
         8vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719515357; x=1720120157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0+hj8sR+QbQ9EpFDrzEmuUbfGkJIqPXAt68R7keXiY=;
        b=DuaMOLsYcD35/SofGLcJp+lrO27RekAOjBahbIi9bLtdXX3MfJPpn8Mj0FPodoIhN1
         R/J9QvUIWNB1j8A/xvAKmqH3NyEUS6eYIVz/gVCVV4O3UdoaFEp5Is9AGL9YGX+awn1Z
         lUC1iKxL85+ouWkvEJYuYqbAR+wOb7jIMLez7xYjYYPRGHy5WrXyQym2qdnsZMdECRCL
         JLa9ZmZAgWl9Tlqbeh3LQJgYs8aPR6t7hxgpnPlFc67/COvXgWpaVIiE5EtJDVIzaM31
         dyldNRcgisucyBDlOJMJcggg0h+ZH6OdiX9f5ggwp2N6ebJDN7ULXqpLv9TH3PMlRQuG
         pOPw==
X-Forwarded-Encrypted: i=1; AJvYcCXcLLd9zURKmM8VCMFJeN8FGkh1LvRpO69W2D49hoqzV5ycPRsqUPIaA/85GX4Ne1ptm3JN6aw/fG8pTUirtPYbsDX2mU/cOe8EidYeZGUVqJvXWnsbvSSjt5g68VqzHgTbIaWMNw==
X-Gm-Message-State: AOJu0Yxi28j4Bp+HQ/P+GmoQNa0bUiy8cTgjWHz8j/J3IFXsNHwDh0pB
	FMFhvuE3ORtwyiK9oM+Vta46j1iDtXCjjBY5ERbfcgFr1JA8Bxyq5xBv7ekmRrkxsFe7oYyaVPt
	S9wyCkn6KzRQswnY3RKtLWwdRDSg=
X-Google-Smtp-Source: AGHT+IHJ471pqo5Z4OLH9K7oi1G5rgMuHfsuIEvK17T/5yx8+pSdZKqFyicuUkS1BBegzznaxD+nRAh7gGFXXsVcn80=
X-Received: by 2002:a05:6214:923:b0:6b5:4865:948c with SMTP id
 6a1803df08f44-6b548659960mr121632576d6.27.1719515357302; Thu, 27 Jun 2024
 12:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f71227061bdf97e0@google.com> <20240627163100.GC469122@cmpxchg.org>
In-Reply-To: <20240627163100.GC469122@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 27 Jun 2024 12:09:05 -0700
Message-ID: <CAKEwX=OgbhJhRi3uXe9e7NqApH=+mkoR5-whUwK=aY6gVVZcmQ@mail.gmail.com>
Subject: Re: [syzbot] [cgroups?] BUG: sleeping function called from invalid
 context in cgroup_rstat_flush
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: syzbot <syzbot+b7f13b2d0cc156edf61a@syzkaller.appspotmail.com>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizefan.x@bytedance.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 9:31=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Jun 27, 2024 at 07:03:21AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    7c16f0a4ed1c Merge tag 'i2c-for-6.10-rc5' of git://git.=
ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1511528e980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D12f98862a3c=
0c799
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db7f13b2d0cc15=
6edf61a
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/50560e9024e5/d=
isk-7c16f0a4.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/080c27daee72/vmli=
nux-7c16f0a4.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/c528e0da4544=
/bzImage-7c16f0a4.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+b7f13b2d0cc156edf61a@syzkaller.appspotmail.com
> >
> > BUG: sleeping function called from invalid context at kernel/cgroup/rst=
at.c:351
> > in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 17332, name: syz=
-executor.4
> > preempt_count: 0, expected: 0
> > RCU nest depth: 1, expected: 0
> > 1 lock held by syz-executor.4/17332:
> >  #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire=
 include/linux/rcupdate.h:329 [inline]
> >  #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock in=
clude/linux/rcupdate.h:781 [inline]
> >  #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: filemap_cachesta=
t mm/filemap.c:4251 [inline]
> >  #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: __do_sys_cachest=
at mm/filemap.c:4407 [inline]
> >  #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: __se_sys_cachest=
at+0x3ee/0xbb0 mm/filemap.c:4372
> > CPU: 1 PID: 17332 Comm: syz-executor.4 Not tainted 6.10.0-rc4-syzkaller=
-00330-g7c16f0a4ed1c #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 06/07/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> >  __might_resched+0x5d4/0x780 kernel/sched/core.c:10196
> >  cgroup_rstat_flush+0x1e/0x50 kernel/cgroup/rstat.c:351
> >  workingset_test_recent+0x48a/0xa90 mm/workingset.c:473
> >  filemap_cachestat mm/filemap.c:4314 [inline]
> >  __do_sys_cachestat mm/filemap.c:4407 [inline]
> >  __se_sys_cachestat+0x795/0xbb0 mm/filemap.c:4372
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Ok yeah, cachestat() holds the rcu read lock, so
> workingset_test_recent() can't do a sleepable rstat flush.
>
> I think the easiest fix would be to flush rstat from the root down
> (NULL) in filemap_cachestat(), before the rcu section, and add a flag
> to workingset_test_recent() to forego it. Nhat?

You're right. I think it's been broken since this commit:

b00684722262 mm: workingset: move the stats flush into workingset_test_rece=
nt()

which moves the stats flushing from the refault step (before rcu read
lock section) to inside workingset_test_recent(). I believe that's
6.8, 6.9, and 6.10 we need to fix?

The fix sounds reasonable to me :) Let me whip up something real quick.

