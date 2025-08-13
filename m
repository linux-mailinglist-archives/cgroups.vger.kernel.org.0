Return-Path: <cgroups+bounces-9145-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CF3B25478
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 22:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE9D9A3225
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 20:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667D5271A71;
	Wed, 13 Aug 2025 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="cGcHfJ/P"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CECB23BCE2
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755116511; cv=none; b=XvnRJQLkENSp9klL+U7AT+B9Is4L1VALry/3M/6VXhasEWPpYCNy3mPomAoqVy4bRptGqaEkA4cyqwQyi1/8Wv7Od89elgaLzLGTheiGHXcJp2YaitaBR7AuwmEGi942uSuHD7BDtPJjLqzZkItGvuz+jDx46weQ6GWqKoW1GiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755116511; c=relaxed/simple;
	bh=spEw6iTr/TlKdoJ9qRoclMR04HEh7O0DeIyHVYrMPS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hgy9Wd8kHymPxGdfFnMbtoB+pCa7cjw4PdpjJoCERZSZwd0s2AX+CBfk+iN8lVpR4xgOVqRl8FAhxhfX6FIqEuR20mtLaoEdFHykRIdGhlHzWb/sFm9wc0WutDryUor8YChvSq4wtAjVuopLtyJwUpKe/pMXYmiEE6DiKdskVrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=cGcHfJ/P; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e870316b79so24887785a.0
        for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755116508; x=1755721308; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H30kUHUoAp0mgFKEUbjujIS0Xnkk94c0v9Jq8jaPeYc=;
        b=cGcHfJ/PUOTvizvE2euT/CsdSMMwDgvI7BPZL6k0tNNR4edHZ/JxwXEXE9IyR/AGTo
         4k4gR1M8LFn1RvVZQDbuwcpqwsubgC7d8hpF+qU9b6EKUhBq3Au7/9hBy+8P5jdX+yxF
         G01EguLPdrNeSKIfy5CUhAIPKRo71gPD665H/ORJ/wV4tZPf171z5d7TGPljXHcutguE
         3NDtpn3cimXkgIeQ/vxS6uqx6XoP7x4gNoeA8jwkmHrphJ+i/bwiKCyJQZe4zUNJHXoi
         +SlN+Ha7YDd/d0E5cAuvMr9wcixsySfdV0Tj8RJO5VEQ/CaliJwkhGDSY/nxKq3zQgyH
         c0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755116508; x=1755721308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H30kUHUoAp0mgFKEUbjujIS0Xnkk94c0v9Jq8jaPeYc=;
        b=EMDzYqVaJHIojMSnSLL7PwbyCtk5JLLEMxG9fFtLJJaBRmr9XImp2uKeJVnEswFema
         tBtNQbpFGtUEU78SvUhK+TpbKrSRFFwWnmgmcJRWDae8FoJTpaNA6YzNe1t7xcwtmwAS
         2mj9brthfa1GsQGOIvDptCYpuT+NWbqQaUfjUSFEQ+HPFIuQzbjDCygVFfqzrGLRQTzy
         eiFjP0q9EZWTFXdcNh2q+fDITvus4N6kuFJsDTI5CIxnY8ht7/QT2RNHRk+suKxpZncj
         ESocpFCXfYiCYKVqKS3qedfT2n/oquc+rp5pEa+0EfRNSHClSF7am/KwDjEFH5Mq7YLe
         B+qA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ1AXBytrHqIKNwB9IgixInqMOh3RG/bR2AgvpeRO63XpYfwXivhNsxCirGAA+ZeseoNhf3l89@vger.kernel.org
X-Gm-Message-State: AOJu0YyR+x+rxfFlrguodLmwvthem2/09jcWTnid6uAJFrTMKpYxVFWI
	D+Yh1BCS59i4LZoX/zQr2sxyaDYv3WJmoP8H8WLgozc2pTJk02vhcw8FbivMrIrcAW4=
X-Gm-Gg: ASbGncvzaZdfrsUgJuGCOI+20VzZLorWzFjf1P0PMhfCQcNJNtFk6sUuLKKkCzIiZkJ
	EbmT/AHbmrJgRmfXtqbcdbWw+2ascK8aiJfhvktC3aISw5XkJReb4iYCBKgIAHWZIevT1Ae5vNu
	iX5Qo22O9DSX9C/8v9GbjhGToNYxqe8w1awJ11L3AZQoehCBMT7tvcfs37Ts6O50ptqGZCNvxrv
	KZD1yY7UWdJsOyut556NLdwGVINAGueUOkrclVmo7A87reBTPUEmG9RUw4VqjcNxBfjF4LcnKXb
	gkOZ+9qO0dGG7ZR6IckIdczroWB0J/NMcKWUuZIbVYjrSNO7zZKB9XTuCm7JlYQj7zJ0WIZOr5z
	QH/vIw8A2SAp67hwyuhGlzA==
X-Google-Smtp-Source: AGHT+IHL4RX8mGUQFHn3xTKxG6noHoTer9v5afSRdyTGpU+E2ho9o1DxodPcyvf3+YYPPRrSEMF5JQ==
X-Received: by 2002:a05:620a:3bd2:b0:7e3:28f3:8a5 with SMTP id af79cd13be357-7e87045d632mr87942885a.28.1755116507799;
        Wed, 13 Aug 2025 13:21:47 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e8079cfcc9sm1486333285a.29.2025.08.13.13.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 13:21:46 -0700 (PDT)
Date: Wed, 13 Aug 2025 16:21:42 -0400
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
Message-ID: <20250813202142.GB115258@cmpxchg.org>
References: <20250812175848.512446-1-kuniyu@google.com>
 <20250812175848.512446-13-kuniyu@google.com>
 <20250813130009.GA114408@cmpxchg.org>
 <CAAVpQUB-xnx_29Hw-_Z4EbtJKkJT1_BCfXcQM7OpCO09goF+ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUB-xnx_29Hw-_Z4EbtJKkJT1_BCfXcQM7OpCO09goF+ew@mail.gmail.com>

On Wed, Aug 13, 2025 at 11:43:15AM -0700, Kuniyuki Iwashima wrote:
> On Wed, Aug 13, 2025 at 6:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> This change stop double-charging by opting out of _the
> networking layer one_ because it interferes with memcg
> and complicates configuration of memory.max and the
> global networking limit.

No, we do want the global limits as a backstop - even if every single
cgroup in the system has its own memory limit.

Sure, from a fairness POV, we want socket buffers accounted towards
the containers' memory footprint and subject to their limits.

But that doesn't imply that we can let the cgroup limit be the only
thing curbing an explosion in socket buffers.

This isn't about fairness, but about host stability.

The MM can easily get rid of file cache and heap pages, but it has
limited to no control over the socket buffer lifetime. If you split a
1TB host into 8 containers limited to ~128G, that doesn't mean you
want to allow up to 1TB of memory in socket buffers. That could make
low memory situations unrecoverable.

> > Maybe their socket buffers is the only thing that happens
> > to matter to *you*, but this is in no way a generic, universal,
> > upstreamable solution. Knob or auto-detection is not the issue.
> >
> > Nacked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Please let me know if this nack still applies with the
> explanation above.

Yes, for one I think it's an unacceptable behavioral change of the
sysctl semantics.

But my wider point is that I think you're trying to fix something that
is a direct result of a flawed approach to containerization, and it
would make much more sense to address that instead.

