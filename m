Return-Path: <cgroups+bounces-1340-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA9E848F2F
	for <lists+cgroups@lfdr.de>; Sun,  4 Feb 2024 17:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A695AB2218A
	for <lists+cgroups@lfdr.de>; Sun,  4 Feb 2024 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206E322EED;
	Sun,  4 Feb 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yHtcUesN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876DA22EEA
	for <cgroups@vger.kernel.org>; Sun,  4 Feb 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063460; cv=none; b=XNwITFgIuMzuAyWvL/GB72f9V0KCSoYp9NwExrFkAUAimiuvjtqtWnH/120Vt/98xfovVFvNwpDj6Q2HR6WpFd4xfP3kGpnhVCaox870VVeC4EIc3RXYNyeDNO7bWPbP3ICmz3kRzRU/32sI48SqqYT0n8A3lwZUWdFqE0SYbJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063460; c=relaxed/simple;
	bh=to2OBQooB2bY+rgljHt4uaz9h8TvFbBAnxNcwMwHRF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLnXFv2cp7sfRU3cjfpSgXgnxJz2wgFrzy0GJCiIR2snF7JB4Yki7PpqQ74968muVrGuP3m85V2agpRu5hoEB6WPaARN6fh/5imfrYhvFGD9WIQ3Yc5GqjVJyGOO+NdZOTj5v3DIglqpHaOPzRkF3XnnQHt8KkLBmfhKnsX84g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yHtcUesN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d94691de1eso89215ad.1
        for <cgroups@vger.kernel.org>; Sun, 04 Feb 2024 08:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707063459; x=1707668259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gR8mCFXieSn2fI05m7xsuH5LKF6XnUBI7N+gwzR4+1A=;
        b=yHtcUesNUnmmEM/eBaEkohwTdyvRxWgJo0c8iHmnUNAzzFNNLXDWq5ReK5l31rlizz
         z9SH/dlgu374yu7xF8gt4oqd69H4azsEzEmks3McNqTBzZT1j9FczfVxgIOrEX0t1NEp
         P4Potdu976axnbw+xnid0YejeZ57ekoK2edirPkPSTD4ttJJMZh4/hfzhPlUZyFl7V+z
         3DqwAh8NKspiRrd8w0Z+hqyuRknXvDkst1/Yo9j4E7HLGneCksPvyUdC1GIZEFEzZIvM
         OeMk0YnYDTBXOJvodhyvVTZFIkaSLe4+PMhMAtzNhs+GQ5HrgMTQmPLTk53/PGYCnKmY
         2/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707063459; x=1707668259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gR8mCFXieSn2fI05m7xsuH5LKF6XnUBI7N+gwzR4+1A=;
        b=LbDcOU+tZGA8TeovNuXluImMCSCKdwv0woorc8Qn26XM6riuUTTU4Y0OsQQwbXBWB9
         9YgoT07lPS1C1VQuzXVY6tW0GDqvBOvzqlODq0dH6hjQK0RmoLZ4veK1k7j5hnKGdSq0
         mixm8NkQHJb9jTfSrCLEMxDKzvtLfCxgRjE0LmtaOh6pE8zPYe9QCfp8WejumwjcnJA2
         l6X7QrnrrlE+TSMcAKGxSc2Idlxh5KldoIzhioBJVR7QISeoqqZaF/AewzX05Qqh8U+6
         RUci3kKsiVm531crbkb9/C0ngHcC68Ow1RLBGWgk6Ote0uMT+KPYbLCty9Aw1qzTrfz5
         nIeQ==
X-Gm-Message-State: AOJu0Yyz7l5/x/MnbCvtOn2dLXo3bVPDhHNejQiEzqV27BEqJcx4VqGc
	WQWbtIWOzFWA8yA+fRsr+M04q+W8Rk0p8LTL4srdkt/u6E9y/YABAv/PW04jh8KQEAqh/F6AvWS
	0N8F7/nSbpX9N63585RypS1X/UTi6JWw5R6Xi
X-Google-Smtp-Source: AGHT+IGSTu3Lad/7ru7MAsWyHtWYX5fvh3BjujCmDIEe9RbfXJhczY7Xe7tRqf2uSWCiqrfvPWwtb734Hj21uj9MizQ=
X-Received: by 2002:a17:902:e547:b0:1d9:6c20:b900 with SMTP id
 n7-20020a170902e54700b001d96c20b900mr167822plf.7.1707063458573; Sun, 04 Feb
 2024 08:17:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202233855.1236422-1-tjmercier@google.com>
In-Reply-To: <20240202233855.1236422-1-tjmercier@google.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Sun, 4 Feb 2024 08:17:25 -0800
Message-ID: <CALvZod4KroCg=zp0bugdDZmG9v-mwUnxKJacrd5nADH491hAqg@mail.gmail.com>
Subject: Re: [PATCH v3] mm: memcg: Use larger batches for proactive reclaim
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Efly Young <yangyifei03@kuaishou.com>, 
	android-mm@google.com, yuzhao@google.com, mkoutny@suse.com, 
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:39=E2=80=AFPM T.J. Mercier <tjmercier@google.com> =
wrote:
>
> Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive
> reclaim") we passed the number of pages for the reclaim request directly
> to try_to_free_mem_cgroup_pages, which could lead to significant
> overreclaim. After 0388536ac291 the number of pages was limited to a
> maximum 32 (SWAP_CLUSTER_MAX) to reduce the amount of overreclaim.
> However such a small batch size caused a regression in reclaim
> performance due to many more reclaim start/stop cycles inside
> memory_reclaim.
>
> Reclaim tries to balance nr_to_reclaim fidelity with fairness across
> nodes and cgroups over which the pages are spread. As such, the bigger
> the request, the bigger the absolute overreclaim error. Historic
> in-kernel users of reclaim have used fixed, small sized requests to
> approach an appropriate reclaim rate over time. When we reclaim a user
> request of arbitrary size, use decaying batch sizes to manage error while
> maintaining reasonable throughput.
>
> root - full reclaim       pages/sec   time (sec)
> pre-0388536ac291      :    68047        10.46
> post-0388536ac291     :    13742        inf
> (reclaim-reclaimed)/4 :    67352        10.51
>
> /uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
> pre-0388536ac291      :    258822       1.12            107.8
> post-0388536ac291     :    105174       2.49            3.5
> (reclaim-reclaimed)/4 :    233396       1.12            -7.4
>
> /uid_0 - full reclaim     pages/sec   time (sec)
> pre-0388536ac291      :    72334        7.09
> post-0388536ac291     :    38105        14.45
> (reclaim-reclaimed)/4 :    72914        6.96
>
> Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive =
reclaim")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>

Acked-by: Shakeel Butt <shakeelb@google.com>

