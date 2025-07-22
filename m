Return-Path: <cgroups+bounces-8862-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF32B0E37D
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 20:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5DD56699E
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD30280331;
	Tue, 22 Jul 2025 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAqKvuWH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1951019D082
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208873; cv=none; b=Qm/F6ftckpEYuIhqVn+wLKZB/41WVDGORb0W2FhtSDRIGEp8JmpGvatlHJHOIXF7k1kUjm76CgMhXVnpXWVmie8er/CTx7YTYAU0xybltmxVdPBeFY8r9azAiv59ToXY1EACqgcNVP7JpT4ghIbtpVDTQYBXpM2oMS5nKDWFcEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208873; c=relaxed/simple;
	bh=kdF5tg8ENJcaojyO3wuhelQPZ6QwZOTEotDF62Wu3Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rykbAMyAD/Xb2EwJWIteKhmni989D8W/M51v9kF6iMx+cA+36BM7i8F5AGmq9ZHA8L96s+SKB442x/eBLNxs8yTrEMxar/K3u4/6dEVb0FOkqJXtElqcnWHlcJ2zeAd2YnD+/PPYlTZLwYpyDQ7CGgKYVaEzRFQp7DvHcFf9fIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gAqKvuWH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234c5b57557so52184195ad.3
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753208871; x=1753813671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJ06jcp3N8mk84kkZkPxLydB4nlpZWRtwPoY10l8wjU=;
        b=gAqKvuWHZ1xibrF1h5kTHZA67Gep9xDkxFZid1e07MUlPv0Yk2F5FPqXCQEZAVoxbg
         +ty8tRQGMNmQnfG0MTPVmJCafTqHNfEfsKDjW13aE/4TJm5IFrcA1qRbCtf1Hd0uiEIn
         h35oN7oSA74y4BTiGfO57AK9ew51Zp5xufbJ7lSO6T0neP1zZfLkLq8dkajOtq3DzkVh
         Yg1ruPccsggBXBIOayiwXe203Xm3GF0arXbunDnkI5o2G/ejTzSHCPDrnO4FdGX2B0RS
         +1cryPgbQp86tIpNKB/q0XZQzGLnkq7bAzVS5RS3VP12LaJ4tpZ8hb6WzfYklhYJegtR
         cGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208871; x=1753813671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJ06jcp3N8mk84kkZkPxLydB4nlpZWRtwPoY10l8wjU=;
        b=R2w84SVLXE86SgxZmdHG7gzpJBb8gCKxK2jpl3db3JglW0RQjSoY+GIKPVCbfx8azF
         i4TrX/W9KJDRi13JzExUo3vLIlMyoNwY8SYof/ey7Dlr09vZ6fsD67rZXyzPCvNkFeiU
         lpivAax5MLbk9sS+bmZghgiZ7L7TTxxS7B0tHr7CvKp3RB+LwVl/iJbrq8vbBchXmCSN
         glISiHsDVadVX+dZiVs8+JRuFT5NLoMlUOPLrldNHLCrpNUahwGxAFEF7dzmaTTNweTP
         v01NLfgEn1F6YhEJqRg9ZRNcl667gjMDZJaOD1oA7lxmDM4cyPIBHUhhI4ILrQb+ovED
         M/CA==
X-Forwarded-Encrypted: i=1; AJvYcCUMabbfbQLXZH3yXgYuYQ1rmDXsK1lWAWoWqo8UClzFHuCP81rbSDJ5eWhstUX68UWTt+zwu7PM@vger.kernel.org
X-Gm-Message-State: AOJu0YwBaFWDl6aO8DtjCfV+oqsyPX9iYuKvGyOZhTfQeHNSo40E8R6h
	/OKoTY2V1sl0elqHKtuEnaKCbHGew0qA7qEvWwvyZaLp1sRF0FdI4yhwCV9aVLyfCthKtNFF21r
	Q3+0HXP0RjyrCF6lWby/yRZJo0Bo+e3xHJmBwp3Lv
X-Gm-Gg: ASbGnct0QfErO1bNZAEc5SRMCQsxiffG/QC91ZmaKb0USzawoPmpzfTtOPs0GIkw+BR
	8BcbU3SpF6CXri+Ph1y+OLB1P4GxGDl77vw9kxL3RFrTVfZmFRK3t3XmghIob/RKq3wO+8UMgry
	piaICtJaf7jj4epkkok+LMkRaZJGKBtYpvvkW6uKokemAAuKA4BS4LOHPGorazSK6lIEw7/E/LD
	rk2Xh6Ep2XYsgmok+3xLfiuFaFc1kkdGIeYPQ==
X-Google-Smtp-Source: AGHT+IEsDSi8OkW3pGhx0kurDkEYKeTjeHF2pizFwIotQyNcJvMlToKfbMqC1EaLyBr5Mr/rFszOK4D2GukeMpu05bg=
X-Received: by 2002:a17:902:ebcb:b0:235:7c6:ebd2 with SMTP id
 d9443c01a7336-23e25730056mr376366275ad.31.1753208871268; Tue, 22 Jul 2025
 11:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
 <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz> <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
In-Reply-To: <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 11:27:39 -0700
X-Gm-Features: Ac12FXxLpxDEFMJ1OteDYmd2L-tyFGpDS0pkCtWi7bSCC4GD2tBgGIdi0vnLq7g
Message-ID: <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com>
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Daniel Sedlak <daniel.sedlak@cdn77.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 10:50=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Jul 22, 2025 at 10:57:31AM +0200, Michal Koutn=C3=BD wrote:
> > Hello Daniel.
> >
> > On Tue, Jul 22, 2025 at 09:11:46AM +0200, Daniel Sedlak <daniel.sedlak@=
cdn77.com> wrote:
> > >   /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
> > >
> > > The output value is an integer matching the internal semantics of the
> > > struct mem_cgroup for socket_pressure. It is a periodic re-arm clock,
> > > representing the end of the said socket memory pressure, and once the
> > > clock is re-armed it is set to jiffies + HZ.
> >
> > I don't find it ideal to expose this value in its raw form that is
> > rather an implementation detail.
> >
> > IIUC, the information is possibly valid only during one jiffy interval.
> > How would be the userspace consuming this?
> >
> > I'd consider exposing this as a cummulative counter in memory.stat for
> > simplicity (or possibly cummulative time spent in the pressure
> > condition).
> >
> > Shakeel, how useful is this vmpressure per-cgroup tracking nowadays? I
> > thought it's kind of legacy.
>
>
> Yes vmpressure is legacy and we should not expose raw underlying number
> to the userspace. How about just 0 or 1 and use
> mem_cgroup_under_socket_pressure() underlying? In future if we change
> the underlying implementation, the output of this interface should be
> consistent.

But this is available only for 1 second, and it will not be useful
except for live debugging ?

