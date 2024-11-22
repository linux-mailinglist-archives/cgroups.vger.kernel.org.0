Return-Path: <cgroups+bounces-5662-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ED59D587C
	for <lists+cgroups@lfdr.de>; Fri, 22 Nov 2024 04:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A73F1B22104
	for <lists+cgroups@lfdr.de>; Fri, 22 Nov 2024 03:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056BB61FD8;
	Fri, 22 Nov 2024 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKscsitV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504015689A;
	Fri, 22 Nov 2024 03:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732245514; cv=none; b=azUb5PirvXHkSl5vNgbWO+GLOlXebLCL7Afv3AwWBidWhhkC17lFaoziyDoQYou3b9Sfd0mN2rKC/7SaA+we7ncNisbTCFS1jdUl9M6aCaxa+SN/bgUWnDvF02g7ITdBqfy8/vxWLdbjHZoBjr5r4zAiqahhQ+QSabNv+oON8rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732245514; c=relaxed/simple;
	bh=ePNkJffxCRQbcE+tv2gt6MlRWJqoybJK1B5XZSyXrR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZlNkajjVcJvOeM+D+IoSdM963nyOZ5uxZnlEYTysOmF7Aa7llst30GGZu4BoXBmfWDS00AuviqPdOGQIPsHWUypBOYPcfswiX1dGC8HJ8sCAL81GEnT0gdE3s9P4ep4fyrbKrYPSLLR8mnlXYzN6ymHHx4g7+o8X7GkhXhl5WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKscsitV; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d4241457b7so9817426d6.2;
        Thu, 21 Nov 2024 19:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732245512; x=1732850312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePNkJffxCRQbcE+tv2gt6MlRWJqoybJK1B5XZSyXrR8=;
        b=nKscsitVo7HSAzO7e7XAwo7RxUAkdRZq6XJ5/997tCskoRj4zA3QFR+9Ak6iGDmcKT
         zk2bA44HJmE1OkS3UClMAbkFRmHKNHneUmMVYLs/FwLd1mL9yglw/izWmOALsaQWz2Fv
         O8kWus/ctPl40j81PRkXGDhUHkRvetc61VPrem6zTIrusWpgg03lZ1IiQfdvWL0wkgWC
         ZAsNYNx9oUOXVpcwuH/UTo/XWs9FSofN6scUKFKtDapiTMrMqRcTG9uSQ+qdpUM/wzp1
         7aEy6ljNY2f82nW/T8gnqa820vIVDG2CMGCcW+lcyGAfxYASAr+k/YkAA1DGdO4NIcvi
         986A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732245512; x=1732850312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePNkJffxCRQbcE+tv2gt6MlRWJqoybJK1B5XZSyXrR8=;
        b=HHLlnzR22Vqp6KsPVwYiobu3VveiJ2PPNRtJptB2CLdZRA/i6qbtMnYWGxdemYKksf
         6niFPlFhRKYHUuXXClYvHYXvUT24bDXV8bnaYvTXnQEuhNaN129FqWfQN6R8OHc5a/cL
         GYFx5Wsz8o85JabQ6lQQ7PE87oqLbYjzD6e7tTWpzF39Fi1kz8LfjAixPGrxk1EW5h7b
         5Bny1PwUszLuL/13QA2SgGhZAzK6K2FKfmH8YSsSEHhgnDhYcvL36ysTmtNsT2paiZn8
         g0ACGqXdHPFEEEAdZb66DGRj2MUBD7ujJiq4BRr5dP4UQwkQHCM9lrgyQGOqaSfiypdE
         oi+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUR42nuRWGGYl/u/i+nWPJ0d3ryYd78TImanI/jXuOi/CYRNOT91A/aYyeMDZNPfamDtOYCurMl@vger.kernel.org, AJvYcCWd04DiQH52DiNeabWblNVJDgJmjzfp15Bp+FMc3h6E4MHEwZ6757CZBnFBrAjRCrzkTIma2uuInhqm7IH+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3vGVBTq3+27mgi7Xzf++zZIogHqXsm6lQ6NHtPKR89zpY7tos
	Rg/682rkelQKqpAE/G+YBXqNSmxjotcVnRpY8zUETBTzRJ9LKUpV1alFXiHPzJGbDdSfQzWqNAE
	AuN21ZTC/tr/W7arMmHow4iZB5zA=
X-Gm-Gg: ASbGncuVggcI237f4rNaqAA4TXqLuq6fgP9HoP3AyBALqH0Ru8lEJ9OxKMSIcCcy+0l
	TvUHGIu528UAdqQvrDqAYlVTf5dkXczrp
X-Google-Smtp-Source: AGHT+IEl4F59tpmWnjBxPKUsl2b74MlRqcH0513G8QWTMu3SsQ5tLbBkPeiI/QxLSzju7hQfnj0dA6CsOvM/X6tedhs=
X-Received: by 2002:a05:6214:519a:b0:6d3:d2c3:b134 with SMTP id
 6a1803df08f44-6d450ee4687mr18335656d6.29.1732245512203; Thu, 21 Nov 2024
 19:18:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108132904.6932-1-laoar.shao@gmail.com> <dmibxkog4sdbuddotjslmyv6zgyptgbq5voujhfnitdag2645m@bl4jphfz3xzg>
 <CALOAHbC54QZ6ZrRBHHKKz8F79C1J8fYcA1q59iwotuBBKtFGmA@mail.gmail.com> <20241118101023.GI39245@noisy.programming.kicks-ass.net>
In-Reply-To: <20241118101023.GI39245@noisy.programming.kicks-ass.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 22 Nov 2024 11:17:56 +0800
Message-ID: <CALOAHbAXyet_ip62suwgz3GdkfFQo29n6UoDav+XON4zkTUfMw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] sched: Fix missing irq time when
 CONFIG_IRQ_TIME_ACCOUNTING is enabled
To: Peter Zijlstra <peterz@infradead.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	hannes@cmpxchg.org, surenb@google.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 6:10=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sun, Nov 17, 2024 at 10:56:21AM +0800, Yafang Shao wrote:
> > On Fri, Nov 15, 2024 at 9:41=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@sus=
e.com> wrote:
>
> > > > The load balancer is malfunctioning due to the exclusion of IRQ tim=
e from
> > > > CPU utilization calculations.
> > >
> > > Could this be fixed by subtracting (global) IRQ time from (presumed
> > > total) system capacity that the balancer uses for its decisions? (i.e=
.
> > > without exact per-cgroup breakdown of IRQ time)
> >
> > The issue here is that the global IRQ time may include the interrupted
> > time of tasks outside the target cgroup. As a result, I don't believe
> > it's possible to find a reliable solution without modifying the
> > kernel.
>
> Since there is no relation between the interrupt and the interrupted
> task (and through that its cgroup) -- all time might or might not be
> part of your cgroup of interest. Consider it a random distribution if
> you will.

Some points require further clarification.

On our servers, the majority of IRQ/softIRQ activity originates from
network traffic, and we consistently enable Receive Flow Steering
(RFS) [0]. This configuration ensures that softIRQs are more likely to
interrupt the tasks responsible for processing the corresponding
packets. As a result, the distribution of softIRQs is not random but
instead closely aligned with the packet-handling tasks.

[0]. https://lwn.net/Articles/381955/

