Return-Path: <cgroups+bounces-9835-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6DEB5024A
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 18:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE7E5E3F86
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EB2350D52;
	Tue,  9 Sep 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy7RwoZU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150D732A815
	for <cgroups@vger.kernel.org>; Tue,  9 Sep 2025 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434570; cv=none; b=TVHwNvPM3AzzZWdWsDXoZpZ5VsWxDta3CZ4vhPj+aTg0gcXA9VjShcvrqI/k2dHyFx2fUnaDpV2pCKhOpY5guSSX8VWLJ/4G5pFt2cDjNzAh/iz84ipGFDf1ePIEJYqyXwGvQ//1NgrBeu2l29BvUoh3knq/prk51Gva+tOOdYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434570; c=relaxed/simple;
	bh=8geU/4eOv326mQPYUdjPgngUOLm52LnzgVlD/ZKGCJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U53TTja4/btd7bf76aqn8xBBKf2lGd8X9PERGZdnAYjZjVh3Se5Ok5aBjKaK6mhrM81HAW7Q6/K4hYNKcFAaHSzfu9DRs0m88DA9rwaUOKWFlMkb5yrC7mFYT2q4WzviUPd2JUlyId/sg7KzUkQBIW4/zXTjjruqmv5wvhOJMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy7RwoZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0F0C4CEF4
	for <cgroups@vger.kernel.org>; Tue,  9 Sep 2025 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757434569;
	bh=8geU/4eOv326mQPYUdjPgngUOLm52LnzgVlD/ZKGCJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iy7RwoZUOuHaHDwhCnkwu25fWid4iYX9PGWsJrqfwgxcJzQI9Rd47ZorKtQKlS8Nu
	 /IkKUxmHH1Bnp+d5NvxoHp20wb7r+JdzZkDR9URf57060p/3nCqfcPh5rjR7FGE7+A
	 mQhVqaGXmbYq4853FAs6l9sFNjqk6hiKmhVplojvOgzidesfqDDakcwxxowEqmxkaR
	 4vP0q8QZL0FmUFno698wjpDnb5xA7TXwFfjzC865KikVkkNKtWwsUaK4ghu4rtOpl6
	 6P30ml3NFeEsbjrfRH+mJEQl1JfstN+W233sPZULF8IM9NwxZz92mht11OREoqYNqu
	 w0qxf4DIJCdMA==
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dd9d72f61so256395e9.0
        for <cgroups@vger.kernel.org>; Tue, 09 Sep 2025 09:16:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAgQsKFBcKGe+g19ec4qoidHn43PTa474pjRSWOWVw0gJp6XTWULrzxmQgioiFZklAcIESBiLp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wjiDnde6xGlmI0ygVsFEy5VXMsN12ogH3R/sYz3eNWPb9PYJ
	vKPLDuV3pSSNS8/6epHgzGvVhVSNYDvTI5hzqZlI5yrcmZS5tQCmcN2CAvPuATKMo2dgTK29UNM
	wh2Ntfjzd7ZJ2HpJvyZECaLCs3ItqVrKBccKkyls+
X-Google-Smtp-Source: AGHT+IEQ+bGwDzJ/J01xdKe3jrA92uUbIJQmvkt4fuP43jYqEZst7Tgop0RCxlHErtb1OaBKkRPPTuXg/R540vh9nm4=
X-Received: by 2002:a05:600c:c082:b0:45d:f6a6:a13e with SMTP id
 5b1f17b1804b1-45df6a6a1famr173355e9.1.1757434567985; Tue, 09 Sep 2025
 09:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <CAMgjq7Ca6zOozixPot3j5FP_6A8h=DFc7yjHKp2Lg+qu7gNwMA@mail.gmail.com>
 <CAGsJ_4xiTteQECtUNBo+eC9uu8R3CgVT2rpvGCGdFqc3psSnWQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xiTteQECtUNBo+eC9uu8R3CgVT2rpvGCGdFqc3psSnWQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 9 Sep 2025 09:15:56 -0700
X-Gmail-Original-Message-ID: <CAF8kJuM4BEeHnkhw5bSM6ap23paChMBZtqCY6ksie+8EghYb8g@mail.gmail.com>
X-Gm-Features: AS18NWD8Bdipbsrc2Xnoz893tOcQg79yI5VZd6lbFZnJZu1va_aTGBEbLnomork
Message-ID: <CAF8kJuM4BEeHnkhw5bSM6ap23paChMBZtqCY6ksie+8EghYb8g@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Barry Song <21cnbao@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>, Lei Liu <liulei.rjpt@vivo.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, 
	Hao Jia <jiahao1@lixiang.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Fushuai Wang <wangfushuai@baidu.com>, 
	"open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:24=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
> I feel the cover letter does not clearly describe where the bottleneck
> occurs or where the performance gains originate. To be honest, even
> the versions submitted last year did not present the bottleneck clearly.
>
> For example, is this due to lock contention (in which case we would
> need performance data to see how much CPU time is spent waiting for
> locks), or simply because we can simultaneously zap present and
> non-present PTEs?

I have done some long tail analysis of the zswap page fault a while
back, before zswap converting to xarray. For the zswap page fault, in
the long tail a good chunk is a bath free swap slot. The breakdown
inside  shows a huge chunk is the clear_shadow() followed by
memsw_uncharge(). I will post the link to the breakdown image once it
is available.

Chris

