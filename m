Return-Path: <cgroups+bounces-8144-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C1CAB4424
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 20:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E9919E53D9
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83030297120;
	Mon, 12 May 2025 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REzRzN6E"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F5144C63
	for <cgroups@vger.kernel.org>; Mon, 12 May 2025 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076173; cv=none; b=q70/MjPFby0B65nw0GNrx2GQKoAQe9MctfNLAvbp/74TWDHujfiJNYDTs4DSiGHO8kIEyCJFc0/x15XFBCmBpGxiaZR1KFLDqi5SALQPasK4wJ7XcmM3uVz8m2h2aU/3gQx+UA6ZDV0H3Sj/3OVZn6FBpYUYnCPy8ZqG01FvYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076173; c=relaxed/simple;
	bh=R9Oi8PhHsn0Iqgoq3Kuo2vY/g67j2m74WQmsNoKbiDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNxyWQHEpbZszTRxyZwWfW6WIAEssD6YBsYpdd+v5bf3jaBr/Z1q13kYofvT7NjWiTYZTE54x0ZjaDi5hgBWeBdnLekrWQPWwsyvNDaebdqNUdLdlrmBIm6gRQUSos0Nxir7j6vW75gQXdqRNGeh9mC270e6+a953ZfbrZHdd40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=REzRzN6E; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so8213888a12.3
        for <cgroups@vger.kernel.org>; Mon, 12 May 2025 11:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747076170; x=1747680970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9Oi8PhHsn0Iqgoq3Kuo2vY/g67j2m74WQmsNoKbiDg=;
        b=REzRzN6EJwLd6jkvOc2HILBwBgbhLcxCfe6nq3wLePWM6WdZvrhkJ/i5JQPPE62kqK
         LeQz6AYyceWAyEwBUI69F6U5tIkPIZ4JkUPTxj6qKDz1PD+YXW2skpqobii8yh4SwPno
         fhQGQxfCf/pTuWMd1vFPqKUjcsLSnL2+OSUqW0VZF6qeIr9H07SLjcRPnkbBGo+CClvO
         S7l62Yri+QQiPC9jz5NOt4Po0v0RjWuKEmPDVcW2gOCrlJI1pMLGOqdbjueeupXbqUyt
         MnJvgq0kiOTBjq5lqHq7M/vhbjtz5lJZBVyMmx5oTRRWdHuntSpcOEjKDIHC2ItK1syP
         943A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747076170; x=1747680970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9Oi8PhHsn0Iqgoq3Kuo2vY/g67j2m74WQmsNoKbiDg=;
        b=bEmNRn1/eax4H0qst9Kodq1uJsb1H1infLJsEAcqTlusG35Cw8hXy+ga1hRP63zrpI
         Wnbb3xqohotN9L5ZV6F/p9xrFKKUgX2T/77xxph40/Uf3ckLY/eEGrVfwFhV47oDZsxx
         WSPm44uLJDcWDPC2UpK8auCh6H8+1jLzxYSf8ReHWnyQ68uEzRfM5+xkK17vFkGMz+fZ
         TlhQmWiKGDJ+QVDqS1X1ICgqbp8I/y05kDuMY2HVXRdo0disire4Qv/NiSLG6h3ixS9o
         JUKKaQmTLJU9q/p15ZiYoO2tiyfl6P9Ix4kowiAsb7SZNr9ynJinLxCtyLJ/i+NO6o4Q
         N52Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGxprk9ao8lYkm8xTI+fzShBTAvwXB8IM5TZoyff2I+weWdoO5vVY9SQm2XxSRzmIgmhcNLw/u@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8CsYh4RQ7055X1P/cWAfS+Rql2tBvzSu2YqH8MPaOgzyRPF4U
	K9QFMuot4hM97NF45FiMqWbzYWTBLRXRzuLvK1iW/f4qkTgY0SH/FFuvK0GxK55+tInDM7bwi6T
	zSYaeS9FHrn7TtPf+SQRsBClHd7VdDwFDhjYb
X-Gm-Gg: ASbGncv9olLApM0lVp36DlfPPzNEpk2hA+qOOInzwWaOzEWHe+gHjnCE5BlIedaAAat
	IoJAcuObY2TH6sxwee+HQGrHPil9CbXAjBQ37MT9YAWMKwn+9BCimhkkw5QryxGt2f57hWu4VaN
	Oa9k1naA9PkmoplZ1p+ufWKdCnhm8r4eA/yWqY34VeDm/LV/fbMFbPm3zGNl0wovqj9VQ=
X-Google-Smtp-Source: AGHT+IGSxf21cydcKSaeqGdWQfCMq/i1Jw1c1h3iOLfTnyifJEAxgbYTWe1QXdk0KWz98TodjdO76SfECkN7Q4EznqM=
X-Received: by 2002:a17:907:1b1c:b0:ac2:7a6d:c927 with SMTP id
 a640c23a62f3a-ad2192d4b63mr1294443666b.50.1747076169603; Mon, 12 May 2025
 11:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506183533.1917459-1-xii@google.com> <avxk2p2dr3bywzhujwnvbakjyv4gsnshssvgwj5276aojh7qbl@llhdz2e55iai>
In-Reply-To: <avxk2p2dr3bywzhujwnvbakjyv4gsnshssvgwj5276aojh7qbl@llhdz2e55iai>
From: Xi Wang <xii@google.com>
Date: Mon, 12 May 2025 11:55:57 -0700
X-Gm-Features: AX0GCFtN5E-ewrK2qktSybXmdK4lo0FOtGq_i9xSb1_nkn6X8o0AyCvqgWj55u8
Message-ID: <CAOBoifiYV3YX6nAf9v5PwkkKPt4qhV8af47mWoJQ1B_tFJ7D-g@mail.gmail.com>
Subject: Re: [RFC/PATCH] sched: Support moving kthreads into cpuset cgroups
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, David Rientjes <rientjes@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Lai Jiangshan <jiangshanlai@gmail.com1>, 
	Frederic Weisbecker <frederic@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Chen Yu <yu.c.chen@intel.com>, 
	Kees Cook <kees@kernel.org>, Yu-Chun Lin <eleanor15x@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 3:36=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hello.
>
> On Tue, May 06, 2025 at 11:35:32AM -0700, Xi Wang <xii@google.com> wrote:
> > In theory we should be able to manage kernel tasks with cpuset
> > cgroups just like user tasks, would be a flexible way to limit
> > interferences to real-time and other sensitive workloads.
>
> I can see that this might be good for PF_USER_WORKER type of kernel
> tasks. However, generic kernel tasks are spawned by kernel who
> knows/demands which should run where and therefore they should not be
> subject to cpuset restrictions. When limiting interference is
> considered, there's CPU isolation for that.
>
> The migratable kthreadd seems too coarse grained approach to me (also
> when compared with CPU isolation).
> I'd mostly echo Tejun's comment [1].
>
> Regards,
> Michal
>
> [1] https://lore.kernel.org/r/aBqmmtST-_9oM9rF@slm.duckdns.org/

Kernel doesn't actually have the best information because it doesn't know w=
hich
user threads are more important. Giving the root user more power for fine t=
uning
is a common practice.

The most important reason for moving kthreadd is to prevent a kthread from
interfering with important user threads right after forking. It can still b=
e
moved to other cgroups later. Moving kthreadd allows better control rather =
than
worse control.

CPU isolation is more narrowly focused compared to generic cpuset based con=
trol.

-Xi

