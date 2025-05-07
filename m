Return-Path: <cgroups+bounces-8077-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561DFAAECAD
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 22:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E6D9C0BD8
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 20:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AEF207A22;
	Wed,  7 May 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nR9sGH6m"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986901F9A89
	for <cgroups@vger.kernel.org>; Wed,  7 May 2025 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746648453; cv=none; b=osRlyi8m2kvXU48yPiG7VP71XdZumXUFK5cfUt3NEwJy/VGp5j+IrQ9JUG04YJ3as1ppY3pQzoPql2KIS//Rh8o+YdvvbcxIhskpgV30LtBbT6j7vJHMnNAzhIMrW9WnNcF4ctk0xoiE96Ax8TX4g4tL6fCuIPfu993EkmVp/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746648453; c=relaxed/simple;
	bh=w3+3KeoElHyRcJVg0RmvVvE2AsXALYl4aJ8aofm6AIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4SGzstNsmVvVwjJKfWJqpZ5d2Ook63+mLuZTL1+4/5uf38XWQQu5zFZoRxdzCxnR6ztjyOFpG/yvfB7fsAw+QTSJioqyacyPeMIT5SelcV6dw5wjBxya7bf6IK0icBaSCo63Su4RtzZm5qLYC87ncLyqvE/Mpuv0u/xSptM/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nR9sGH6m; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acb39c45b4eso34228966b.1
        for <cgroups@vger.kernel.org>; Wed, 07 May 2025 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746648450; x=1747253250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3+3KeoElHyRcJVg0RmvVvE2AsXALYl4aJ8aofm6AIM=;
        b=nR9sGH6mEVA0ualXnhIOf0eGmjnyrDHYuzJUMqEMAoObxGxGWidjHKwv0AV+qNho6j
         qzESypGJu7PliTxYnNFSHroPKe9sAYq2Bgrp3XMBI2+gaJe9sYRE+wmgJuGf9lYJJRwJ
         t3iszg+DfQ5KgS/Pz/+EtXWXVAtmIr37Y+cRY4Zig8fn7EpjD0M9w9UU2VesTXbIR+9R
         nDHi2YF9X9afEtubAbtTuWyRHcqQ+2xX/GutwbWAU8yct3KW+PJ902WrLf/queUAokpu
         lUz+rGzWI0NFKjiIY3mb+lPSjCe4YrIXGP+A7RxQZ9QGCvDwY0BK4C06j5RbMol2RpHI
         fxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746648450; x=1747253250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3+3KeoElHyRcJVg0RmvVvE2AsXALYl4aJ8aofm6AIM=;
        b=MdhneAMnNljO15NTA+hRNgCKosT5N8VbCVul4GjxUItZuBEM9F/kTAKmT+M6PWBeWU
         OB56itYj7DewHrsw2T60WtJ4YdddQvV6ORkoN9IRKb7Yq8vnoubOxrGuOAVv1Cku5Svv
         XrEK2Og+CaUN4hwW7k2aWxEcAJLc5PT5/OAmmwqUTaezVypt73N4HSesR1rgd7+wwQw3
         Lj5kCx6DiNamx4So32s2huNbHgF5U7aOoo5EgtvQug6He0FiXb22TkjJJX6PxBF9rarz
         8IuULuYonsvkfbZQIg2B3cbluAqn8/kf8HKILOyMMh1DN+Q1G7lbJxAZ9MNetvJWp/3K
         FPKg==
X-Forwarded-Encrypted: i=1; AJvYcCWviVJJSvNoIfISpmP6t6M5D6jKDoumFqWZ4xv6EPMQ883gwgYHongSzcbuDqGpjWVw7I85L36D@vger.kernel.org
X-Gm-Message-State: AOJu0Yy90R9QRv2YH3Y6MW8CAlWNEzXKXpu24VZi8l2T5D3ciiIrD+ku
	Hj22erS8MQ/e4eIcxjT6D+hibmM4GC0hDcUYQjJK/FEfZUqgT2sMPuVh5ZIYLeUnZ57jg6ABsy8
	Ts+EsQYAS/ej6d7sPekAltNSt+DoHFMNAe8Rz
X-Gm-Gg: ASbGncvK5kxmHNmlhTOgoXI3yW0cmqDXJ0s8wiBk14ScPQQNqr5Wu68puPEIqE0UFTW
	ZvGuYpczGvD7kprisZsLe53koYBJ4kDmlphzYqYwDhO0K5HS7qP3sCsptxyy1a4wyZZe3IWs+gg
	c3qVudZ3jTgHls69QbBOCG9byUG52/cUZZrTEthH6nJCXlG9vfbQ==
X-Google-Smtp-Source: AGHT+IHMvqtGEgVvR4tBa+A7od70iCjCW3khzHB4JCJtIHlviqns0c3QvfPzORetkebMitf8d5H+ROVKAU7eJw0lMW0=
X-Received: by 2002:a17:907:c287:b0:ace:6c29:a98c with SMTP id
 a640c23a62f3a-ad1e8cd7709mr423668766b.37.1746648449789; Wed, 07 May 2025
 13:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506183533.1917459-1-xii@google.com> <aBqmmtST-_9oM9rF@slm.duckdns.org>
 <CAOBoifh4BY1f4B3EfDvqWCxNSV8zwmJPNoR3bLOA7YO11uGBCQ@mail.gmail.com>
 <aBtp98E9q37FLeMv@localhost.localdomain> <CAOBoifgp=oEC9SSgFC+4_fYgDgSH_Z_TMgwhOxxaNZmyD-ijig@mail.gmail.com>
 <aBuaN-xtOMs17ers@slm.duckdns.org>
In-Reply-To: <aBuaN-xtOMs17ers@slm.duckdns.org>
From: Xi Wang <xii@google.com>
Date: Wed, 7 May 2025 13:07:16 -0700
X-Gm-Features: ATxdqUG12XZN0hFzKilXUEhBsiRwGA9-TUpz4QKBiobL8v5U6hVTVFV89NOFQoM
Message-ID: <CAOBoifiv2GCeeDjax8Famu7atgkGNV0ZxxG-cfgvC857-dniqA@mail.gmail.com>
Subject: Re: [RFC/PATCH] sched: Support moving kthreads into cpuset cgroups
To: Tejun Heo <tj@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	David Rientjes <rientjes@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <longman@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Dan Carpenter <dan.carpenter@linaro.org>, Chen Yu <yu.c.chen@intel.com>, 
	Kees Cook <kees@kernel.org>, Yu-Chun Lin <eleanor15x@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	jiangshanlai@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 10:36=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, May 07, 2025 at 10:23:24AM -0700, Xi Wang wrote:
> > Overall I think your arguments depend on kernel and application threads=
 are
> > significantly different for cpu affinity management, but there isn't en=
ough
> > evidence for it. If cpuset is a bad idea for kernel threads it's probab=
ly not
> > a good idea for user threads either. Maybe we should just remove cpuset=
 from
> > kernel and let applications threads go with boot time global variables =
and
> > set their own cpu affinities.
>
> I can't tell whether you're making a good faith argument. Even if you are=
,
> you're making one bold claim without much substance and then jumping to t=
he
> other extreme based on that. This isn't a productive way to discuss these
> things.
>
> Thanks.
>
> --
> tejun

Yes this is still serious technical discussion. Frederic made several "we c=
an't
have b because we already have / are working on a" statements which were no=
t
very actionable. Deducing to a particular case is a quick way to simplify. =
I'd
prefer to focus more on higher level technical tradeoffs.

Overall compartmentalization limits resource (cpu) sharing which limits
overcommit thus efficiency. cpumask restrictions are not ideal but sometime=
s
necessary. Dynamically configurable cpumasks are better than statically
reserved cpus.

I do think the cgroup tree structure sometimes helps and we don't have to u=
se
it for all cases.

-Xi

