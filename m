Return-Path: <cgroups+bounces-6160-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3153A116BB
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 02:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D94188A1A3
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 01:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6241178C6C;
	Wed, 15 Jan 2025 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tNrMaXVn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A037B762EF
	for <cgroups@vger.kernel.org>; Wed, 15 Jan 2025 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736905207; cv=none; b=pKA18lhvNWFLcOHA/haGEIIbksoUpYb2pTByVsNG8e1xeqiqtT7PDLodw+xQ9VntocDCwnaUzTOvQ4FolGsIPyKLyIK7kWdo2lXhsuPl6yZTZtQDD4NFe7v7fWxVmyC5TCrwK2Wfq51U75nL24QyQdCbzo8CiPMo1c1cSHVJE80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736905207; c=relaxed/simple;
	bh=2gt++kKQuFiBpFOQa/RerEAyCO/q6xvgmoNjUK3ctS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2FH6OTW8TQpVb518ZovCkh5ueBxktdmELXoGXlo0XYylcdAYaUjzXfXatvlLK/uXnh07HpaZtvQQtm+0yKcUrOuLqC5UemFNSNkLpFw6pUy0d01BlD0o6b5GrWFNfo3q+sPq6LeyEH7dd2LSZooerJEWK8eDqjCzC+QZu8T2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tNrMaXVn; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d8e8cb8605so33366146d6.0
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 17:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736905204; x=1737510004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiiJFWVgdb4jW+ugK+i4jrVS7AIheM6MMFwsTAa0sgg=;
        b=tNrMaXVnpJIkpOV5QzrKxXeL+MEnAv8BWZJHuTHwT3/xWIwLYm3YVpXqac84WNUybC
         NiVEasXEQTV6tGwxltdx1EUiwnUtZd42QQ32i/ZMXUeTpUGDy5lj7t6VYrKZpnsolsDi
         SHzENIg1mSM+nqnEm4nWWH8wAmBzkyDj/TH+79V5s681FQf8ghw7m/q1GTk7FV5CkyGx
         9dLMjPaKzmAIWewS2YagvOyH9IGc+3FJ9uqdqwSI0g7MFcXJFZzz4MAsmO3V18ZfkJqh
         x2AShHEcorsP2YI/1MzzAa36oQZ/ArT5j19cFy33e+XtC7R3LnPnJerEby0KCmQsTNpX
         n8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736905204; x=1737510004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiiJFWVgdb4jW+ugK+i4jrVS7AIheM6MMFwsTAa0sgg=;
        b=a9xSJHr6q1GljEYQIQP0ce/gpGnOjKcGjJJh0slLvHWhp6phaxuRQN+3mFxnBbuI/I
         ovE8NyMTkEz2K43P5DI+xmD8Hm1BLQ3CRR1QlCUUzJWlEUq6hKSaFMYUD3AdF6Idm453
         jcIczRsopBKQU/V817TYFlxlMf3H65N8r1jG+g49s4Dtai/bazOb4sjGyjxeXkeQ0Z5i
         +g4pqujIwp0ttvbq3sXxUl0DYExgeEYnig0ZaCmWXa3a/Tl5i0z4YrYGxlYyPdEWF7hL
         X08X/NaeHnmH+A9LvlSU9Y80PWwtoC8cBt6njoKyKOPyi7kMBphYO9nyLSPfBxKOX/CN
         0WQA==
X-Forwarded-Encrypted: i=1; AJvYcCWmdFE1srXLIGnfDtiZHxUTFvq+esWTFjoNL0TY6Cdo83irgHns3p9BUoGQyc/7QKG/hIlNE6rC@vger.kernel.org
X-Gm-Message-State: AOJu0YwRxXNBZHPlnlLvO04JY2WjrZ+yZ0B5Yub+VaXppNc1kMcJBCI8
	ugFvsqRPtD+7L0gADWzfTTpoFN6TUvMy7ZNZFxpI4vAUkchhJjg723+syfrX9h1RlhyXi3pYO3K
	rQo+R6AOt35oVnpb2y53TAlejqG0tIV9hEC2H
X-Gm-Gg: ASbGncupXwe3F9EBv/2MkyToEnFvjRAb/G7TGxAH7dOtTbygSbNF8NThTNpcDuQvPUb
	+zZhj/wUppFU2pKg6vIxY9m0YkPVQYF0lJVRkHSd52oCUlfc23xgK2RlVOJebsLXegTAA
X-Google-Smtp-Source: AGHT+IHfwPncaMotev11QjY/IBBc2ozTptdW01qlXHfZTluvxk1Gclq6xG2iESy181Z7aro77brAUxuUUsmdWa24hMM=
X-Received: by 2002:ad4:5964:0:b0:6d8:d5f6:8c72 with SMTP id
 6a1803df08f44-6df9b230aecmr429451286d6.19.1736905204305; Tue, 14 Jan 2025
 17:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224011402.134009-1-inwardvessel@gmail.com>
 <cenwdwpggezxk6hko6z6je7cuxg3irk4wehlzpj5otxbxrmztp@xcit4h7cjxon>
 <3wew3ngaqq7cjqphpqltbq77de5rmqviolyqphneer4pfzu5h5@4ucytmd6rpfa> <3348742b-4e49-44c1-b447-b21553ff704a@gmail.com>
In-Reply-To: <3348742b-4e49-44c1-b447-b21553ff704a@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 14 Jan 2025 17:39:27 -0800
X-Gm-Features: AbW1kvaTKtPeLPEx9TMyttpFIcFaL9JR1NZ9USgYjcO-hjQ3cn5O9M_EJfckXrM
Message-ID: <CAJD7tkbhzWaSnMJwZJU+fdMFyXjXBAPB1yfa0tKADucU7HyxUQ@mail.gmail.com>
Subject: Re: [PATCH 0/9 RFC] cgroup: separate rstat trees
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 5:33=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> Hi Michal,
>
> On 1/13/25 10:25 AM, Shakeel Butt wrote:
> > On Wed, Jan 08, 2025 at 07:16:47PM +0100, Michal Koutn=C3=BD wrote:
> >> Hello JP.
> >>
> >> On Mon, Dec 23, 2024 at 05:13:53PM -0800, JP Kobryn <inwardvessel@gmai=
l.com> wrote:
> >>> I've been experimenting with these changes to allow for separate
> >>> updating/flushing of cgroup stats per-subsystem.
> >>
> >> Nice.
> >>
> >>> I reached a point where this started to feel stable in my local testi=
ng, so I
> >>> wanted to share and get feedback on this approach.
> >>
> >> The split is not straight-forwardly an improvement --
> >
> > The major improvement in my opinion is the performance isolation for
> > stats readers i.e. cpu stats readers do not need to flush memory stats.
> >
> >> there's at least
> >> higher memory footprint
> >
> > Yes this is indeed the case and JP, can you please give a ballmark on
> > the memory overhead?
>
> Yes, the trade-off is using more memory to allow for separate trees.
> With these patches the changes in allocated memory for the
> cgroup_rstat_cpu instances and their associated locks are:
> static
>         reduced by 58%
> dynamic
>         increased by 344%
>
> The threefold increase on the dynamic side is attributed to now having 3
> rstat trees per cgroup (1 for base stats, 1 for memory, 1 for io),
> instead of originally just 1. The number will change if more subsystems
> start or stop using rstat in the future. Feel free to let me know if you
> would like to see the detailed breakdown of these values.

What is the absolute per-CPU memory usage?

