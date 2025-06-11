Return-Path: <cgroups+bounces-8486-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB10CAD5D59
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 19:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C953A7C26
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 17:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E490F223DD7;
	Wed, 11 Jun 2025 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIZ28o44"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B67E22256B;
	Wed, 11 Jun 2025 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749663444; cv=none; b=DIJVu3TR5+OoJuN7EoPvoJ0HipzNKm0DIknuDSyiQqCFALCHmyb3jvYUGQWJJzVOyOvuoh69K98UH7WL/R7/MtQY4+oHtXnO/aNDplb4NuorU+FuC74Gditvp+OWNEeZEo3hvSMDlcfQqn7b0tbZI5atf11U2727U4kZTgtr12Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749663444; c=relaxed/simple;
	bh=RxRvCCQAc09pOoApuwSOluUbk6YsmNSe3Pm4y3AeGQ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZMHjOIE/WI1/Qxvu5wVg2DotG5Ll9DdFKNkKkIqlhZP0phPzL0liVoUrkaSBlRe1qebFnedBtiRkQPc3kmDck1EMBiwRtq0kLBGFsOKOe9isfY2PaBb3SpZOety0/5HqoTbeaumciFx/CrB3hzOrkpjVr9fe11c5KvhB9W7tyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIZ28o44; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b2f645eba5dso965142a12.1;
        Wed, 11 Jun 2025 10:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749663442; x=1750268242; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qdx+HUyFlvdHm+W6jgROnH/naTCj5dcAprpNX8qijoM=;
        b=RIZ28o44vqnk5yw/ukh76PWP1Rjn6qAetcB7TPhQi/ZfeQMzhVzZmJd3XQw7FjTm0I
         h6PT2PzgAwU0loONKUaz8bG/TPO6YcbIWB6uuipc2aNAckhGVruya3rN6vMcDn36dpwK
         k3fJ5IizCjt5Bo+Kx0DhQNe1Gl6ND1zOwHrn+gqVZ1IePKZljp72fwepDnn6Z7EdZNsq
         qHcC0OOU5ZaQ4Pfh2GZgzEmTsXMg9njrk3Xg1qI91PV+K71zDzCXqMjkE6SXVujlOJgj
         DkDB7LPhclM9SeGniREcOGrbWRYqPzuxCm23/UEggC8pPPQLqr9mALk0O2RyYJkV9IZb
         J9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749663442; x=1750268242;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qdx+HUyFlvdHm+W6jgROnH/naTCj5dcAprpNX8qijoM=;
        b=CE37W+V282XT1CVKC0hgJYCnxZckUtbGCTAJsuAyeo4i1fcI1E8+ZaTaKUNqQSA0U9
         FaepPYhHHvLb+8e3SVHPK2H0tlsPejG89L19gB3FpkwopTQabV+zxcS9MHQnORxtKDnZ
         3fKyKrTZdfyvd84C5NC3Dwveh/BL3VWXtlUNulkQpGvN8Wuz7kyJ0aafXK+h2VhajDNC
         CeeFHUMYFVtsevKj1GekDc6pXE5YlX1OUqVImqGC+M1dGox2mmzQHYyUAYXInqAAfivA
         p5PW02DdYj/SVfOkb1+rQ+gBt0L2+99WWYuG14o0rDno6RZTzkIUkJh5IvcuFkWDNXGd
         X9Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVNdvLb5ZMQFiJ6uh15f0i/dfVoHEIpCMrL7Ve6MoMoLt1NfA/GiVJCKZFSleW41sRgMHvnsYDg@vger.kernel.org, AJvYcCW6Qk27FN9RaA/sL8Tt9YY3WJRZj1PpzdJnWWJZW5aGd/QmO+TTe4Nhv5Q5VcjL/e49Krl5YbV36UURjgEP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0QTXavSbf+r60iW8PoanVrmI2CnBPLCK75qjX6vG5qxpisMLD
	Q+TDJdwpirKLwdUyuIYmIu1fpEZXdRbKquG7Qumt+UYULO04e8cR+bCL9tmsGE7+1j41eaRR0z8
	BIgK+jloWCmMSwVHtBUNZC3yrvhrBJQk=
X-Gm-Gg: ASbGncvl+6a90LYfGwB44rinUFmY+uxCIEdMZDoa3GSm1tLdnEfd9XHEF3Nmprpakdq
	Bz/HNiwKmTshDKqJXifYZ/U+M7xhI06hEDH83nOn2aVCQU/v1UkE9mz3Sfze53AT0GZ0LFb6dN/
	SDCowUumNLVLWFdXWrkkqFpMJ4T8yiKalRy2GwG0egQBdBEVa31EZwSB8=
X-Google-Smtp-Source: AGHT+IEjycZwjuaydhb9hB5P8UQ/fl56j+Lznqu09ONsNgiSt1GEAvBLvUlmxXMXjPLZVddE5naJd/n3OlOMt2na/t4=
X-Received: by 2002:a17:90b:534c:b0:30e:e9f1:8447 with SMTP id
 98e67ed59e1d1-313bfd6eb45mr464488a91.4.1749663442245; Wed, 11 Jun 2025
 10:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Charlemagne Lasse <charlemagnelasse@gmail.com>
Date: Wed, 11 Jun 2025 19:37:10 +0200
X-Gm-Features: AX0GCFt6AMPMnfwGbDRevkngQ_776BKkCPArI8xqatqb4HBSG_M9g30Xnaqvjv4
Message-ID: <CAFGhKbwVyxCwYSNrPaQ-GkuP008+uvDg-wNA5syWLLzODCfpcA@mail.gmail.com>
Subject: locking/local_lock, mm: sparse warnings about shadowed variable
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

HI,

when I run `make C=2 mm/mlock.o CHECK="sparse -Wshadow"`, I get a lot of

./include/linux/local_lock.h:88:1: warning: symbol 'l' shadows an earlier one
./include/linux/local_lock.h:88:1: originally declared here

after commit

51339d99c0131bc0d16d378e9b05bc498d2967e2 is the first bad commit
commit 51339d99c0131bc0d16d378e9b05bc498d2967e2
Author: Alexei Starovoitov <ast@kernel.org>
Date:   2025-04-02 19:55:14 -0700

   locking/local_lock, mm: replace localtry_ helpers with local_trylock_t type

   Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce
   localtry_lock_t").  Remove localtry_*() helpers, since localtry_lock()
   name might be misinterpreted as "try lock".

   Introduce local_trylock[_irqsave]() helpers that only work with newly
   introduced local_trylock_t type.  Note that attempt to use
   local_trylock[_irqsave]() with local_lock_t will cause compilation
   failure.

   Usage and behavior in !PREEMPT_RT:

   local_lock_t lock;                     // sizeof(lock) == 0
   local_lock(&lock);                     // preempt disable
   local_lock_irqsave(&lock, ...);        // irq save
   if (local_trylock_irqsave(&lock, ...)) // compilation error

   local_trylock_t lock;                  // sizeof(lock) == 4
   local_lock(&lock);                     // preempt disable, acquired = 1
   local_lock_irqsave(&lock, ...);        // irq save, acquired = 1
   if (local_trylock(&lock))              // if (!acquired) preempt
disable, acquired = 1
   if (local_trylock_irqsave(&lock, ...)) // if (!acquired) irq save,
acquired = 1

   The existing local_lock_*() macros can be used either with local_lock_t or
   local_trylock_t.  With local_trylock_t they set acquired = 1 while
   local_unlock_*() clears it.

   In !PREEMPT_RT local_lock_irqsave(local_lock_t *) disables interrupts to
   protect critical section, but it doesn't prevent NMI, so the fully
   reentrant code cannot use local_lock_irqsave(local_lock_t *) for exclusive
   access.

   The local_lock_irqsave(local_trylock_t *) helper disables interrupts and
   sets acquired=1, so local_trylock_irqsave(local_trylock_t *) from NMI
   attempting to acquire the same lock will return false.

   In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().  Map
   local_trylock_irqsave() to preemptible spin_trylock().  When in hard IRQ
   or NMI return false right away, since spin_trylock() is not safe due to
   explicit locking in the underneath rt_spin_trylock() implementation.
   Removing this explicit locking and attempting only "trylock" is undesired
   due to PI implications.

   The local_trylock() without _irqsave can be used to avoid the cost of
   disabling/enabling interrupts by only disabling preemption, so
   local_trylock() in an interrupt attempting to acquire the same lock will
   return false.

   Note there is no need to use local_inc for acquired variable, since it's a
   percpu variable with strict nesting scopes.

   Note that guard(local_lock)(&lock) works only for "local_lock_t lock".

   The patch also makes sure that local_lock_release(l) is called before
   WRITE_ONCE(l->acquired, 0).  Though IRQs are disabled at this point the
   local_trylock() from NMI will succeed and local_lock_acquire(l) will warn.

   Link: https://lkml.kernel.org/r/20250403025514.41186-1-alexei.starovoitov@gmail.com
   Fixes: 0aaddfb06882 ("locking/local_lock: Introduce localtry_lock_t")
   Signed-off-by: Alexei Starovoitov <ast@kernel.org>
   Acked-by: Vlastimil Babka <vbabka@suse.cz>
   Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
   Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
   Cc: Daniel Borkman <daniel@iogearbox.net>
   Cc: Linus Torvalds <torvalds@linuxfoundation.org>
   Cc: Martin KaFai Lau <martin.lau@kernel.org>
   Cc: Michal Hocko <mhocko@suse.com>
   Cc: Peter Zijlstra <peterz@infradead.org>
   Cc: Steven Rostedt <rostedt@goodmis.org>
   Cc: Vlastimil Babka <vbabka@suse.cz>
   Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

include/linux/local_lock.h          |  58 ++--------
include/linux/local_lock_internal.h | 211 +++++++++++++++---------------------
mm/memcontrol.c                     |  39 ++++---
3 files changed, 116 insertions(+), 192 deletions(-)
bisect found first bad commit

