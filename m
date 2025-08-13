Return-Path: <cgroups+bounces-9130-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B33CCB24A07
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 15:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC035849B7
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9312D0C93;
	Wed, 13 Aug 2025 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="XrwdfLoo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC72E62C4
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090020; cv=none; b=BWSJXnI4hotqaxKeSYfgjMcbMtLr0TDXQnOGFDWg99feKPl34z5NeswX3IOoTuFOMalO7csVihpLDeaYuuSmR3UzbrQbhKYsROl8NCxVZ+ApUObrE2tuYhoE8R2+JSbxSTxfpoRQyN4oZllI7pSFJ0fCml/1d1giyqdONpomwgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090020; c=relaxed/simple;
	bh=kbkSRKewyFcnbz3jsVNMUibXidkHNks9qnhNs9m/Qbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjolkFkIgGdHh5Z+ysAmVkZ+ngEbYP9ttIs8xzRSxaeuyrLQTAH80rXh094SLNKTHIUr95sYMcmkaDNQaQXSXy4zaMIirpzVOa/4ps7v4IFHFg7l7ZovjEOgTKOwCjeTFbF67HI/VRWa31jGVDCBPzRHebdC4egBcH0lfD5X+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=XrwdfLoo; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7073075c767so77772576d6.3
        for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755090016; x=1755694816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/BrlZbr/T7l2ZRE6UEhDbhwVQUKfgdvzKuP95OrSQY=;
        b=XrwdfLooH8vr3mObn6Ld61VxpbpQPvg7XhYLUMZw0HPBu4FZvZ/P1MAtgIEKTKoYCr
         BLyTnocIB1WZ28pyLtelyzrptdsKOeJto758b4kpUfbgEahjwJXI6KIfIBljuJJr65/z
         Dj85l/pBuKzDea2UZPp9f1nfWZTEDyj/eQLtcTnl0CMgzg5jI99MgViYm7CxKhQztWg3
         I7PCORcsdQBwoZIoUuKQyitedhoINzH7hlO088o+Xdu3gevT8Ml1W2FjmJckodtBHx5z
         D/zETMcKXCaD1PpZVbaFASa16q/nHwhOtixrJ6s26RY0/YPh94r/DM0oeGnvG9cf1B0H
         4yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090016; x=1755694816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/BrlZbr/T7l2ZRE6UEhDbhwVQUKfgdvzKuP95OrSQY=;
        b=g9MceasNvRwoDBatqQj4UTy2woRj7coi9oBx6wSOqbc2CZmVN4C/kUcVW16rr5HqlK
         41RMeeTuDha/F9Co3r2qQp/E2tSbdIuqAm7B7PWwl6NQ+R5ADvOZTb/X3V5tmwCudfPH
         MZCgBXG/HZNG1jJQAnVWTisFtbTlCV1wyFF7QcgwFJeFTaHuyz+sCA+gXUHzcZjZjL1o
         v/LttM2WQTwE4P7JFOyqad9KfUJer0XWzdnskdK5wGBmToyYHGKyothjHZ06hhkBioWo
         YEI2p9dm8wHS3g26zVwGS//H8fTZnIDj0ny8aF9vKoqAK7P2FxtaKuwb+TO5X97rd8Pg
         tw0A==
X-Forwarded-Encrypted: i=1; AJvYcCV9iub7GOMUJHannRIp713h/ikFdcEuyw3T1816y20NojXQGra/1q7Hxdw5N/puK1z/1kokg+Zb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4uBYarRV50JbswSqOKZ3ArhpPY0m+5YFTt74p00HGOLuetN6R
	A22ob5NoqXVRo5es8QgCWwUW017iX/a0B4QF8iZGuLXx9wdhpulmI8U2VZ8ofEAc1dU=
X-Gm-Gg: ASbGncvZU9hEdjUpUrVLr289bcyRGFadaXoTl78eeUWSoMtiKlNUNlezCbWXKqPs7h1
	k2/juScOiAbxl2LtvvqljT2TXh1s4gAhLclh/q3v96x3GNrgRHufBLM+z0fTFQqbU2DrB8EVdRD
	X9F9WNWhAgOj9V0Mh3huBUyDWuA8Xn1u2Fapi4IS/lMFHA0ylnCN/1eFgnDiBQF21QZ9UvS8TJj
	XKeyfDKFjUmyhwy+SKw4oI5lKwB2vos7c67oZi2ERv4zds/hX8bdoWYa1GV/qzA9ILQaONVRTHa
	g8kBv4naANKuRN4gFk+nvxea1o0UVmpAUBrZP3iuLybvBZiu9GvEzJxgcyPtoECoiwbLPzMGCUx
	HNrfxuOr5+A8wgVbNKoQRNVNiAiTIZCd9
X-Google-Smtp-Source: AGHT+IFgGWoMlnm/Y1OcmFOyyn2dsuqu/R1TVP5M10fhTPzIDW0MUbQN+HwN5hLswo+SbRfYuOk9QQ==
X-Received: by 2002:a05:6214:27e5:b0:700:fe38:6bd8 with SMTP id 6a1803df08f44-709e8843a0cmr37405206d6.19.1755090015449;
        Wed, 13 Aug 2025 06:00:15 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70920e28dbbsm188318676d6.62.2025.08.13.06.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:00:14 -0700 (PDT)
Date: Wed, 13 Aug 2025 09:00:09 -0400
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
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Mina Almasry <almasrymina@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
Message-ID: <20250813130009.GA114408@cmpxchg.org>
References: <20250812175848.512446-1-kuniyu@google.com>
 <20250812175848.512446-13-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812175848.512446-13-kuniyu@google.com>

On Tue, Aug 12, 2025 at 05:58:30PM +0000, Kuniyuki Iwashima wrote:
> If all workloads were guaranteed to be controlled under memcg, the issue
> could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> 
> In reality, this assumption does not always hold, and processes that
> belong to the root cgroup or opt out of memcg can consume memory up to
> the global limit, becoming a noisy neighbour.

As per the last thread, this is not a supported usecase. Opting out of
memcg coverage for individual cgroups is a self-inflicted problem and
misconfiguration. There is *no* memory isolation *at all* on such
containers. Maybe their socket buffers is the only thing that happens
to matter to *you*, but this is in no way a generic, universal,
upstreamable solution. Knob or auto-detection is not the issue.

Nacked-by: Johannes Weiner <hannes@cmpxchg.org>

