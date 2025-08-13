Return-Path: <cgroups+bounces-9141-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CCFB25330
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 20:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E421D7B53F7
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 18:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1542E9EDC;
	Wed, 13 Aug 2025 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X0O8sbup"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CA82E11CB
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110609; cv=none; b=vB/hA5CEdC2oR0pTEUSL8mifnam7qHGnhoSROXu5k+OK9Ws5hwXBJN9sWvJd0EGvdRZYRpa1x7nwvawyf7Dy6JiaacRIsR4NFYl4IypiEj2exb0XT/9MRZb7cv+4inaRnWZjxYZABUBPicw2wm7L+DK+x7TRKuAH83ZvZgZV7RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110609; c=relaxed/simple;
	bh=peKhyYh5erOKsru1vnv61mgnhKM9DzH+xoHN6mevgvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSWRWxIiJlfO0Ax6LsUFDLYsLBd0P8ELu8KWdb0UEn+UZ1fiOHbmTcBF2GhqXyPiNUosOIaSyAZUHX2/LMphTSdTBp7VAz8Mlga0wBeCUe1KT2C7eHY5pSakjuPkiCK6dquTKRcWaL7uOB8YmhO/Rg3kyOCHM8KUXDRWCAWaSb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X0O8sbup; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24458298aedso645265ad.3
        for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755110607; x=1755715407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9BzIik8ItZsQbt/3YanXJu26q0lEOJnE+a73ddJFdE=;
        b=X0O8sbupOxY7pG6JHsl2uQa9oQUxyZnIwb8Xrofhd4g3Id/XEE4sjE3ucT0xDr3je7
         d8Hh/CTfUELFF9jO2Qyfak/i4AuBuXMK9Sqq4LJVitYnoW0EbpGbnL9+fFPBcjUk4kCa
         TgHegg5pjYQDjKcZwv6UE/CDyssHj9wfHAXezpT+ek2zY2Fnvca4I3XlN4AsBMlg4OQz
         OtXwT2GmxRWw99Lho1qbMdbWejgPvsvu6SSDMNAjncSTYo1TPQ1rbwxVprNeMFD0y8E7
         8fhwFgNROxFDHHbvYB+e5TDwODUzHv2IYRG2nACd13vi0PSOsBBqXJHCucTBBtcoIqdJ
         TqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755110607; x=1755715407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9BzIik8ItZsQbt/3YanXJu26q0lEOJnE+a73ddJFdE=;
        b=XlheHYaYmygAhQLKzG7gyqeqn4uungG1L30CQp9iINhMTlgyVmsUBdwugODCpdek77
         VQIEaGtVW9uW7da3kba7Y+icltqfbOfTjuAcO3tYKRfOmltFqpYbhfphzU4fzODbYY9M
         Gr2xNbZ9o/dVPmDLZx8GpZveHn8GmWWxTug7CQyHrHNuzvSsb6vZlteP91cSYrl923UB
         2zqECZWZIxtHkcvWDFMjQBF3yI7CYP3+me74nKTdEh++JUYHYLb/K/EijvsN6q65lJd+
         e39bUmuQbhRJtFycz0aRf0mmiQdIGVazwH3QGGqZZPH9sf9aEGxYVUP1rn195hRoWZCR
         0+mw==
X-Forwarded-Encrypted: i=1; AJvYcCVoCGiZ6buQsV00rgAmCKAoTEeGZAorcIRdTJoBJRGnEoMEtxNwppE9ohUM8su8GMGwflg/Pi4f@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8v5KK3tRir2Y1Z4vH7/lrKn64BmTChDVDqhP+qfvSCqiWO+E1
	8H6l7U72FKo8A0XZ2QQ/gWmx+2VMLFCbdSuiNBBQTZ8qBVD1UpaVue/KUTCEjuapu8HOPRSOiDS
	0lg73JpZuB0HhJFR3dzs11HTkyjLWAq1s8Og0iuC/
X-Gm-Gg: ASbGncsx7COKqkqOUK5XVtXtoMoV58oHlM8eBrECA31NIEd+usT/1Lq9ECOjy529tJN
	D7GSRyDPSNmmYBXwjNOcvff9kxtzIaEXeo7M3u0QwQBCJlWzmAS7bad5H69zk+DHF9zIIC+T2fi
	H/pa6ni0rd/8/RqL79uqje8U7Ao8si5h0q/gAKcAv1/ODZs/0B4p76sGQusQ2fEEfD1p3hMqZJ0
	LEM0N7UdOx3Yw3imRLWPEkveLmT0ojmxF86UWpu
X-Google-Smtp-Source: AGHT+IE+OAJLh0cA0JpKkD0/B+CsZDY5rBp0+LgetnTu3qP/aHmx8+dnnAhaX3xyY/0hlQtXLDaeU8b5ZnPRaXFlw7U=
X-Received: by 2002:a17:903:22d2:b0:240:3915:99ba with SMTP id
 d9443c01a7336-244584af6a2mr1990405ad.5.1755110607235; Wed, 13 Aug 2025
 11:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com> <20250812175848.512446-13-kuniyu@google.com>
 <20250813130009.GA114408@cmpxchg.org>
In-Reply-To: <20250813130009.GA114408@cmpxchg.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 13 Aug 2025 11:43:15 -0700
X-Gm-Features: Ac12FXzkQNJfJzM_zFO5RI8--6tu5_zAqIX6wf49jOuR7WukQGz1HzzF1Da6JMs
Message-ID: <CAAVpQUB-xnx_29Hw-_Z4EbtJKkJT1_BCfXcQM7OpCO09goF+ew@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:00=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Aug 12, 2025 at 05:58:30PM +0000, Kuniyuki Iwashima wrote:
> > If all workloads were guaranteed to be controlled under memcg, the issu=
e
> > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> >
> > In reality, this assumption does not always hold, and processes that
> > belong to the root cgroup or opt out of memcg can consume memory up to
> > the global limit, becoming a noisy neighbour.
>
> As per the last thread, this is not a supported usecase. Opting out of
> memcg coverage for individual cgroups is a self-inflicted problem and
> misconfiguration. There is *no* memory isolation *at all* on such
> containers.

I think the commit message needs to be improved, but could
you read throughout the patch again ?  I think you have the
same misunderstanding that Shakeel had and corrected here.
https://lore.kernel.org/netdev/jmbszz4m7xkw7fzolpusjesbreaczmr4i64kynbs3zco=
ehrkpj@lwso5soc4dh3/

---8<---
Initially, I thought the series introduced multiple modes, including an
option to exclude network memory from memcg accounting. However, if I
understand correctly, that is not the case=E2=80=94the opt-out applies only=
 to
the global TCP/UDP accounting. That=E2=80=99s a relief, and I apologize for=
 the
misunderstanding.
---8<---

This patch does NOT change how memcg is applied to sockets
but changes how _another_ memory accounting in the networking
layer is applied to sockets.

Currently, memcg AND the other mem accounting are applied
to socket buffers.

With/without this patch, memcg is _always_ applied to socket
buffers.

Also, there is _no_ behavioural change for _uncontrolled
containers_ that have been subject to the two memory
accounting.  This behaviour hasn't been changed since
you added memcg support for the networking stack in
e805605c72102, and we want to _preserve_ this behaviour.

This change stop double-charging by opting out of _the
networking layer one_ because it interferes with memcg
and complicates configuration of memory.max and the
global networking limit.


> Maybe their socket buffers is the only thing that happens
> to matter to *you*, but this is in no way a generic, universal,
> upstreamable solution. Knob or auto-detection is not the issue.
>
> Nacked-by: Johannes Weiner <hannes@cmpxchg.org>

Please let me know if this nack still applies with the
explanation above.

