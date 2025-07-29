Return-Path: <cgroups+bounces-8921-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B28B14F2E
	for <lists+cgroups@lfdr.de>; Tue, 29 Jul 2025 16:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA1F3BA24E
	for <lists+cgroups@lfdr.de>; Tue, 29 Jul 2025 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25451DE4C3;
	Tue, 29 Jul 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="CUC99S14"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A21A238A
	for <cgroups@vger.kernel.org>; Tue, 29 Jul 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798972; cv=none; b=VTuCt5r+0F4urNyvbVHEP+JhN6c1JlGsZ4aD9ChbkGj7uI/WYSUqtswOelymGWAFVsJiWk5DFmdLbhvSAAbiURCUZ2ELvbDW8oXMahdAofyRbxC5ZoSyaf+ZzJnjiUzncJEJ3Yv1Vg5IfGMIgj7AelhDfuyfo3mPdnLpsuAWLt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798972; c=relaxed/simple;
	bh=n/B1V47tIX2IzjUKv7W7NbvhxGtBrYglLmbZLfK4Y84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMkyUl0O4a0hK8y5Qyk2iPljfNA669CrmuYSqWjTnJGmf3IykgpvRs4sbJIRsz3yDR2puTWOM+yaVSxySCyu+MusVkc9oFZisasXClU85k/00v3cBSIlWHXc5TrYAeiz3xfhFYxRTk8FMvroIsg08ae0vJSufr8JYvhm5Z73b8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=CUC99S14; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4aba19f4398so66835581cf.1
        for <cgroups@vger.kernel.org>; Tue, 29 Jul 2025 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1753798969; x=1754403769; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=COkIEuiWzegLgJMToflCtnJ3/8gZZNZmKmrpqxdoDwA=;
        b=CUC99S144ezJuZ5KajosRCM00g9IMrmlOtz0pE2gqe2+CCb0ASaEPY2YqUUri6XD4J
         Owpon/W+pkglLyV7Ts3ozDb2X9lxkBQZxnotHFrHln8RmW4SjYXw8Fe24u0nVm68OI4L
         8sE4+dWGwOTVw8vRZkc6FAzt/gAFPRkZF43+yfcjRX8xWBrWplwrLzwXIe5hBx+V35ZB
         g1u6e2gkVsEdA0nmW/Q/O37tgVKUI846H5HfsOqdIGbywla1r59TpaZOCTi7d18NC3d1
         xREQGOiUfp+p/XClbqHdVSZFJoaluoCg3aSSoij/5Bf9p+kRphu10EeNSG2o2Ztqm1Dn
         JG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753798969; x=1754403769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COkIEuiWzegLgJMToflCtnJ3/8gZZNZmKmrpqxdoDwA=;
        b=QOXN4EYumXvp29GyVU4p1ZWi+f48mNreSWQndCjZVosB+R+T8X6sN8MuxzrAI+0fD5
         tZaxoAk/1gdVQOYcJAewlbqZ2emdDKosDijhjYGQYeEr01uWfksk30i+VsjTXJD90zc1
         vc5Fjww99iYhcKEFHTHax0CrSwCoWzjVO0tNeYrC5GKzTUI8kr1y9OJ75QohVr2dQ8oJ
         f9XK2y6rjy6vljRVMhkZOIJ/Lm+kSCZ9LzDAlCETsTTmMrvdEP7eC/RsciEBLORBHX8y
         vHt27WHZdIMcws36UFJXGwTbDoiS9MPiRVP/vPQg15S2c1mA24RtAgCeNOpiuPnfATpV
         81hg==
X-Forwarded-Encrypted: i=1; AJvYcCXo5IB0opcYAZsGv+8CVzCjywDfvmFTNcKsK484edv4AWxPodD90Eo1bUsZc+IB/+amkvGjR2QC@vger.kernel.org
X-Gm-Message-State: AOJu0YyetyXPQSVnmoEYx+jM7ek2/Cd7mFFDjXL/DFK+qoohOCuv5OOl
	sdK9J93SxZIe6KYBE/IhGwzW53bihWTt/vnWW8JMCgFUfjW1EGHQZ4B3122ORqKLKoY=
X-Gm-Gg: ASbGnctNHF2K25xU90JP0HGE1xYynKzXjfYFb0aNBMb75S9HFwcQ92i/mHWmgk6gCSj
	1eKu5bLsDWOWb1Y7i7Z3EYIHMH66zmI/iZfaNIE7xavmjJ1J6bqhkGcHJnKhr/cIUBSXLBREj3F
	09LMrKPjGBUnkXNPIudOSsfpGmbYCd40z7tmSk0G1fvg42FGHxKulKZFL8yb/eLL6D4FQ9TXl57
	JJI8I0lxd1QG6lYJywkZ092gpoTAMSerRo66KjIniJGxVHAJlE6FsDc6z8QbMbueYdWs8AmX3iY
	bQD6wR9to/8GgM26tWQXnJBzL0ffSNHziscR39SiA+6qeJrpFbecUzqme02OwkkLMkUeTQk33Dn
	NARSx9p0jKk3F6gBBotTRsE55PaEBcHXF
X-Google-Smtp-Source: AGHT+IEUceVkl40iNUbmH8CG0B9SvtBCZGSM71xkMe4dIMOtKKEAU9bj+x0vh8grcAXbbZcW59/UVg==
X-Received: by 2002:a05:622a:3:b0:4a9:7725:b1be with SMTP id d75a77b69052e-4ae8ef406d4mr180745941cf.8.1753798968930;
        Tue, 29 Jul 2025 07:22:48 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4aea7d724d0sm38853931cf.23.2025.07.29.07.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:22:48 -0700 (PDT)
Date: Tue, 29 Jul 2025 10:22:46 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
Message-ID: <20250729142246.GF54289@cmpxchg.org>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-14-kuniyu@google.com>
 <20250728160737.GE54289@cmpxchg.org>
 <CAAVpQUBYsRGkYsvf2JMTD+0t8OH41oZxmw46WTfPhEprTaS+Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUBYsRGkYsvf2JMTD+0t8OH41oZxmw46WTfPhEprTaS+Pw@mail.gmail.com>

On Mon, Jul 28, 2025 at 02:41:38PM -0700, Kuniyuki Iwashima wrote:
> On Mon, Jul 28, 2025 at 9:07 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima wrote:
> > > Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> > > buffers and charge memory to per-protocol global counters pointed to by
> > > sk->sk_proto->memory_allocated.
> > >
> > > When running under a non-root cgroup, this memory is also charged to the
> > > memcg as sock in memory.stat.
> > >
> > > Even when memory usage is controlled by memcg, sockets using such protocols
> > > are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
> > >
> > > This makes it difficult to accurately estimate and configure appropriate
> > > global limits, especially in multi-tenant environments.
> > >
> > > If all workloads were guaranteed to be controlled under memcg, the issue
> > > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> > >
> > > In reality, this assumption does not always hold, and a single workload
> > > that opts out of memcg can consume memory up to the global limit,
> > > becoming a noisy neighbour.
> >
> > Yes, an uncontrolled cgroup can consume all of a shared resource and
> > thereby become a noisy neighbor. Why is network memory special?
> >
> > I assume you have some other mechanisms for curbing things like
> > filesystem caches, anon memory, swap etc. of such otherwise
> > uncontrolled groups, and this just happens to be your missing piece.
> 
> I think that's the tcp_mem[] knob, limiting tcp mem globally for
> the "uncontrolled" cgroup.  But we can't use it because the
> "controlled" cgroup is also limited by this knob.

No, I was really asking what you do about other types of memory
consumed by such uncontrolled cgroups.

You can't have uncontrolled groups and complain about their resource
consumption.

