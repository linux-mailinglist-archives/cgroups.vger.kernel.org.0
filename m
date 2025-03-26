Return-Path: <cgroups+bounces-7234-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AB8A72793
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 00:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3115B18989FF
	for <lists+cgroups@lfdr.de>; Wed, 26 Mar 2025 23:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2505F23C8CD;
	Wed, 26 Mar 2025 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noAec5Dl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431D81C8624;
	Wed, 26 Mar 2025 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743033454; cv=none; b=KPF9xrNuVls/5pEieSMhpMeeOrrPlzYrNB+9hSO26A1YUEsoZ1+2KtUbe6Nm0e6pWXXvC4DoIiHX9OAqtPmWrnDeXM/2GQH6oz0ioEcIr35tYa4XJDlVzYVciX7MCVnPhtiFZwJzaP5LxL5u6VoYmrpWSCnYLV7XNghynZNdwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743033454; c=relaxed/simple;
	bh=/STihoPYXRHMOjpcglX1vRTqVYy77WjuYmkOE5ojoNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqQ3HDWsXRDq7b73HhLblFHMUOT87XXRAF4oIKTcGUbBA6k4y50o9MQRXbfspT3XjsZzYVXzoPM8sxFFbdi7gwf1qOMozb2qYZkQ6q7zA2PpECR/6VUNHV07WiAlJ8S1d+adtM1Burq1EKxG6m8xUtIeBhYnZExsvQo+VnCGndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noAec5Dl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so661336a12.2;
        Wed, 26 Mar 2025 16:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743033451; x=1743638251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfL0zZBVe1RxEvNcNmE6dfxCA/2Hz+Ouu0xAFqUlH9A=;
        b=noAec5DlT40uQNDq+09GuZcbhIwqottn5Ws8dk4QTz1ljpTbSL5xFJfZrRuvRxxWJ6
         oBO2eOK/iWd7jADHXmT0ymi3MPdVRDjVeSdOxFfM3m4OIeOACbVqrsDSGYS4EF+8J4U1
         3lCe+QGa/O9l4TR4uGVqcvs0nAW2kHAE75ig3xWhgcW004PfOfYrjjg7TNhnhyRzHo2k
         pO1uTatQd8qVjC6zwlwRKeltRwTiieKOajY9lyUwObm0Ld1j7EbmEopNyaFxuPSU5cQZ
         Y36P0TNLCizVhPf6oI1RLEf6WlUZsiVzuQR/CAMdQFHZW2BbdDe8nJPEs8/UtABgvaR6
         go7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743033451; x=1743638251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfL0zZBVe1RxEvNcNmE6dfxCA/2Hz+Ouu0xAFqUlH9A=;
        b=gxNjW2bjyKFsIokwW1ImhQ7rWO4Auv8prAWKfUqRbAITnIqfBLW+VZuub8M5W2O325
         CQXTX1rrC1NDI+qpMofOGzVT0kvA1QOT28BYcD7MfZagQlM2PUm9b8qy0b/8VBdPREEa
         IhqqhzVnUNgBUNIMLKN7Mnc3M2k7qNCueLjxkremK6ek/E60xo3eSdY477gGS++1qvsM
         Ja2O+v766HnmwGMLsaEgwlrquHRzzsYSfkHLzy5wRqds0YsZH2YXLbBnFNVWDHaG0arf
         e70gTp5fKhtqZyNrbkQseXTcGqlPekzNMKQpn2A3BPyBxRppgCoiRJOkFy/HsCivdaZX
         mJsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5KLn/Zc1LOnrOnSGWQcwmJJlJULV43Dis9/B82yw9jgiNYJIg9sfCIAHChMyIJWHiafAOFgd7@vger.kernel.org, AJvYcCXbBR6V44XnltvcD4h5d1ZECfkpQHVgF1QABTVzVkFv5zJAPf7aQMHOsTk4hHQ2ZL1/VOvrQ0yiTNS6ykJL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvb00CdkfI9iVJHlSL9m3EynUKmaoxpTJCQYGD2KD2N2nmE/Jc
	Zs+s4DwqF0WSPU6r5mBY16VvYTPfjQz17xFnKu+IrKbPpTd2laa/scIxIsCsRLwd/Xe74HRilHf
	HQv9Ymewz08XqHXF6PDzL51rzxCU=
X-Gm-Gg: ASbGncvIknfOzdFUNhegwdtgc/zHHNrmSRQXKkj7aFHRWevV5h9g541x2qik/JINeCM
	XT41pdrrQjxglHY4Qsli7xHwBYtZQL3TPm6XBniwWG9ElhJnvSzb50+Yc4FqUyNXFBbzHW9QUfY
	MnRr2FbLqtEgwvcT/IbLWLlOxU
X-Google-Smtp-Source: AGHT+IFN//Xoa5xJhfjM1LYOOVmakekz4BFhgDXTCCePBITSricx0HscPMedKrQZtphZGJnjbaiTDTJRdWnY+Rhiu3Q=
X-Received: by 2002:a05:6402:3596:b0:5eb:ca97:7c60 with SMTP id
 4fb4d7f45d1cf-5ed8df6a56bmr1585288a12.6.1743033451157; Wed, 26 Mar 2025
 16:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319071330.898763-1-gthelen@google.com> <u5kcjffhyrjsxagpdzas7q463ldgqtptaafozea3bv64odn2xt@agx42ih5m76l>
 <Z9r-YQDAXIur81i0@slm.duckdns.org>
In-Reply-To: <Z9r-YQDAXIur81i0@slm.duckdns.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 27 Mar 2025 00:57:19 +0100
X-Gm-Features: AQ5f1JpbmDohO9ocCxEGWIoauJamJ5UA7T8ZC7rvjrjfnqAmW-PgRpsHSi5vYXc
Message-ID: <CAGudoHHBs5Bo3PKS1SzrkUjTXFdGNDZ=3NyHuTezz1AUbauQ2A@mail.gmail.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
To: Tejun Heo <tj@kernel.org>
Cc: Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <edumzaet@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 6:26=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Mar 19, 2025 at 11:47:32AM +0100, Mateusz Guzik wrote:
> ...
> > Is not this going a little too far?
> >
> > the lock + irq trip is quite expensive in its own right and now is
> > going to be paid for each cpu, as in the total time spent executing
> > cgroup_rstat_flush_locked is going to go up.
>
> Lock/unlock when the cacheline is already on the cpu is pretty cheap and =
on
> modern x86 cpus at least irq on/off are also only a few cycles, so you
> probably wouldn't be able to tell the difference.
>

This does not line up with what I had seen on x86-64 uarchs up to this
point, including Sapphire Rapids, which I think still counts as
reasonably new.

Most notably I see smp_mb() as a factor on my profiles, which compiles
to lock add $0 to a stack pointer -- a very much cache hot variable.

However, the cost of an atomic op has a lot of to do with state
accumulated around it -- the more atomics in short succession, the
lesser the impact. That is to say it may be given code is slow enough
that adding a lock-prefixed instruction does not add notable overhead.

In order to not just handwave, here is overhead of __legitimize_mnt()
while performing a path lookup for access() on my test box. smp_mb()
is the stock variant. irq() merely toggles interrupts, it does not
provide any sanity for the routine, but lets me see the cost if it got
planted there for some magic reason. Finally the last bit is what I
expect the final routine to have -- merely a branch to account for bad
mounts (taking advantage of synchronize_rcu() on unmount).
smp_mb:         3.31%
irq:            1.44%
nothing:        0.63%

These would be higher if it was not for  the fact that memory
allocation (for path buffer) is dog slow.

And indeed I get over a 3% speed up in access() rate by not suffering
that smp_mb() [I note I don't have a viable patch for it, rather I
whacked it for benchmarking purposes to see if pursuing proper removal
is worth it]

I'll note though that profiling open()+close() shows virtually no
difference (less than 0.5%) -- but that's not an argument for atomics
being cheap, instead it is an argument for open() in particular being
slow (which it is, I'm working on it though).

If you want I can ship you the test case, diffs and kernel config to
reproduce on your own.









--
Mateusz Guzik <mjguzik gmail.com>

