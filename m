Return-Path: <cgroups+bounces-8498-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EA8AD6875
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 09:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010EE170BD3
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 07:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82115142E73;
	Thu, 12 Jun 2025 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8EnxJfY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E57195808;
	Thu, 12 Jun 2025 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749711821; cv=none; b=ikgt1RxSckFYevUCmY+CQ/HmpyODgQT0BwSMeOBjKyRD50+S4eXoS+lF4FTR/hz+yanSBj/G2e/veBWKkZYk9cwIBViC+A08aICQfGZ3pLeyhWGjsdMUqEevUn1Wjhb69q3SoI+qBnKP1jRs/khOPBiZY/LO5zEc6tlHR7prA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749711821; c=relaxed/simple;
	bh=jcZDLKqbqjAfKbQedgUODPcuNZG2Ql2waANaGALBD0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rC1dEudVR1WfzuF+LWFpn0jdKIBSmMOUOeexbJQos3yXewzw2IWGKEJT4/K+l23fqQYxiKQjO2zsmjTFNkZpxPja3+9N+nirAy7pLBB3P6MZpnNqoXSeMjzucCh8J1O3+KoxozBCPoMIgAHCy4+TfSWGJIJ4X7yrVWfqfZHCKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8EnxJfY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso932865a91.3;
        Thu, 12 Jun 2025 00:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749711819; x=1750316619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2viZ0fvQanFU5qt8YT35F/R2lomO19AjWDbbjNosEQ=;
        b=f8EnxJfY9fJ8FBdBej1HnTpTYTzTkJFST6Yfelveguu2KMguJpYBt6dWONPx44hDBk
         kUoQIueLISJv+VEMj6vtCr0VmRdDSwjRqu6WQS8N6OCPzWqr2eq1oGydCF0vb1PNh2tl
         YbhijoKeG0PdIm72Ghw7nY15cuVrKLg08zKDK4+rSknNFBhLS7Rtx7l1wp52CSb5YbVA
         IQmVvyaJ3hT0NDzilPSCiebuDPZL7Urzf7UYDp0XBnNRxEHJC3raxWfSAdKNQs95kBYs
         1Q1GzaphpXPgrJ1a9Wv/O7phet5QaRb6p39N8q+cBYat2e2vO/IBg/BhldssNOFj9iZN
         s7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749711819; x=1750316619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2viZ0fvQanFU5qt8YT35F/R2lomO19AjWDbbjNosEQ=;
        b=GPv/99SzzqirDz/HDbsbDHU5SQWuvJ6zt9u63jHmK4Ti+mhnl3ZhUchBmARDV4JpAo
         YWD1fMUazE6cjgqcXzwroL9I2QR05zC1aDBmQTt/H34nhuoqAv7RLRyavZknN98xL2TU
         26h9e2a4LFKUm9VyFy30JLNlj24QdmkXHOdkcRod5DE4xol0OSjDyKOJG8qlCe4JQRRy
         1cuuErhrfcyOGN0nh71JksL/EXXDOAIVZjAPI7pj6WZZScjp+9rDr3OY2ZLld/7d89ZJ
         38p5XfAW4L+Ll6yc7SLiaPLTSFB1n5Tp+eQ5YfgB5UmXb0EuiOtZl6HwI+xTbz6RClgl
         N1iw==
X-Forwarded-Encrypted: i=1; AJvYcCUCjB+BLCEOpnR4yhDYdF3LhB629MiqQqztEADll8uu0fvW0F5iu9xSrKwF0LJnwpwcvyb9RLqD@vger.kernel.org, AJvYcCV5G/60ORlejLam7cciyO9qiWW9lggIR2E4zPUA7nZsUycRl0M3h3kCLuJQlqiO+UkRTi8MxfAwWjUkvGiQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwLlLYPppswl6weeDSjtVoH2OSH/u+wZkgYyfaylrCzKENNR7eD
	dWlu8mhLW0jpKZRuUEbWJhw1TR8s6SA0fOJBJ2vF25DMAxRkDmSS8esCAU89JL+7wXcUxM9Pjti
	bxCppVCrVEVNTsq0IkmTDK0pGD/7kWXc=
X-Gm-Gg: ASbGncuYeQXShSYmAjUtadcjhsxo4ofS35MGN7D5PsUkmRlA8lI2zAZ/OwSBb2k7Dlk
	sOyGcKHHPifAuhQqUpDs7xI4cps8fTyHRPZxE0hm+0L66HXRwrbeffop1bbIrVIbGel6BNHuZbS
	LpmCOveLhzy+eAhdSwq8lINgNk2j89nRHMe0FJXp32cAFfkaYsP1N7h6o=
X-Google-Smtp-Source: AGHT+IENKZbG1UVgSxMkbsR683h8ZS+NANUj8qRCEWN4KJPO/n5K8VlClSz08iFrHEgPCWpYK+IcgPjCIyzqEMtreeY=
X-Received: by 2002:a17:90a:d60c:b0:313:279d:665c with SMTP id
 98e67ed59e1d1-313af0fd099mr9895979a91.7.1749711819053; Thu, 12 Jun 2025
 00:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFGhKbwVyxCwYSNrPaQ-GkuP008+uvDg-wNA5syWLLzODCfpcA@mail.gmail.com>
 <68c0649d-d9b3-44f4-9a92-7f72c51a5013@suse.cz> <CAADnVQK+wjvxmBM7WJOGNK=AqeJ7UHBO4tUZR3Gjc4kfgux1sw@mail.gmail.com>
In-Reply-To: <CAADnVQK+wjvxmBM7WJOGNK=AqeJ7UHBO4tUZR3Gjc4kfgux1sw@mail.gmail.com>
From: Charlemagne Lasse <charlemagnelasse@gmail.com>
Date: Thu, 12 Jun 2025 09:03:27 +0200
X-Gm-Features: AX0GCFvBcJwp9XkOkM0Sw3LXe5H0SSamdpy1Wp3lz3PcgPgcT0LbkH9Bh5kjWlk
Message-ID: <CAFGhKbwP9e6yWM615FGuq0=eX-57E-f813MMdXZ98D4_+0TveQ@mail.gmail.com>
Subject: Re: locking/local_lock, mm: sparse warnings about shadowed variable
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jakub Kicinski <kuba@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mi., 11. Juni 2025 um 20:20 Uhr schrieb Alexei Starovoitov
<alexei.starovoitov@gmail.com>:
> I wouldn't bother messing with the code because of sparse.
> Compilers don't warn here.

Actually, they do:

$ make W=3D2 mm/mlock.o
[...]
In file included from ./include/linux/preempt.h:11,
                from ./include/linux/spinlock.h:56,
                from ./include/linux/wait.h:9,
                from ./include/linux/wait_bit.h:8,
                from ./include/linux/fs.h:7,
                from ./include/linux/mman.h:5,
                from mm/mlock.c:10:
./include/linux/local_lock.h: In function
=E2=80=98class_local_lock_irqsave_constructor=E2=80=99:
./include/linux/local_lock_internal.h:100:31: warning: declaration of
=E2=80=98l=E2=80=99 shadows a parameter [-Wshadow]
 100 |                 local_lock_t *l;                                    =
    \
     |                               ^
./include/linux/cleanup.h:394:9: note: in definition of macro
=E2=80=98__DEFINE_LOCK_GUARD_1=E2=80=99
 394 |         _lock;                                                      =
    \
     |         ^~~~~
./include/linux/local_lock.h:88:1: note: in expansion of macro
=E2=80=98DEFINE_LOCK_GUARD_1=E2=80=99
  88 | DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __percpu,
     | ^~~~~~~~~~~~~~~~~~~
./include/linux/local_lock_internal.h:128:17: note: in expansion of
macro =E2=80=98__local_lock_acquire=E2=80=99
 128 |                 __local_lock_acquire(lock);                     \
     |                 ^~~~~~~~~~~~~~~~~~~~
./include/linux/local_lock.h:31:9: note: in expansion of macro
=E2=80=98__local_lock_irqsave=E2=80=99
  31 |         __local_lock_irqsave(lock, flags)
     |         ^~~~~~~~~~~~~~~~~~~~
./include/linux/local_lock.h:89:21: note: in expansion of macro
=E2=80=98local_lock_irqsave=E2=80=99
  89 |                     local_lock_irqsave(_T->lock, _T->flags),
     |                     ^~~~~~~~~~~~~~~~~~
./include/linux/cleanup.h:391:68: note: shadowed declaration is here
 391 | static inline class_##_name##_t class_##_name##_constructor(_type *l=
)   \
./include/linux/cleanup.h:410:1: note: in expansion of macro
=E2=80=98__DEFINE_LOCK_GUARD_1=E2=80=99
 410 | __DEFINE_LOCK_GUARD_1(_name, _type, _lock)
     | ^~~~~~~~~~~~~~~~~~~~~
./include/linux/local_lock.h:88:1: note: in expansion of macro
=E2=80=98DEFINE_LOCK_GUARD_1=E2=80=99
  88 | DEFINE_LOCK_GUARD_1


$ gcc --version
gcc (Debian 14.2.0-19) 14.2.0
Copyright (C) 2024 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

