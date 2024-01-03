Return-Path: <cgroups+bounces-1064-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3950823443
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 19:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40581285072
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E731C696;
	Wed,  3 Jan 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWjQ3KA5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0C81C697;
	Wed,  3 Jan 2024 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-427e69f70afso5164471cf.0;
        Wed, 03 Jan 2024 10:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704306002; x=1704910802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OrPWR9HpDsfok0xoAtga3b/s4MSroYmZsQH3rRBi6PI=;
        b=iWjQ3KA52ACJkBMhRzezkNny4OlO/owPx6ItmdBY6SldGLBDdBhamPsDc5kg8QNrAB
         EU9L/ta5Lk7f0jnO0pUC4hKRjpW1vOfny5V/2Lsi2zdRqVmR+3G8IZ2trty7PW7xME+a
         rj5RD1XHe1xOY3GgItViOP0Ixce5ucDdHUKfzwlbEtEmNaI6MXuDzpgINN09uhmLr6Hw
         cy9o2Wm0eFM0LZomhNZlf7CnfHUBp7N/iog1oyBGB0qSpIVXtYIyoS+dapZdt5YhfmfD
         VQTpckecQY4LULqTopGIZJ7CavoE80qz5htoJeRvLuI9R76J9kDx5gjiO5xOnbAHrLMq
         P9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704306002; x=1704910802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrPWR9HpDsfok0xoAtga3b/s4MSroYmZsQH3rRBi6PI=;
        b=tEfwdqtENv9Wd2K5W+HThwhJ760u+cWqpobjuZ6xmqlunL/p8enqmus+dVBpwI2NkD
         Jq3Krg3+kORJbgjRkWtzErLqoYHhhecMdY/asRc8B6QWVpXxuV/49y5EuTcZmzoDkLZb
         FwZoRwshwvDq5BUN0fPRMcisZjvMz2mIRP9pyeiRtYrD0aqq6WdjApuDX/Zc0OawslCf
         VMxVsu8T/G0JVUkkTwZyVLCLY1iF8lyQq5DfPMTbdyzQ0g42ne2aaeLxo+V20jDuJcmd
         EEE9dlyW0lISa82r19NxFGH1EhflEiUtYPiaqTbziWiCJ4GKzo1Q8A0tgEnKU0nV4sqq
         qLsw==
X-Gm-Message-State: AOJu0YzY3w3ihqNObuW9ejaTWN5wtRZvtRjkHwPDG9l3mRSmgklutFrK
	mss2ADYlpAEvEh7G8/BoA8eWqTWgh2H0yg==
X-Google-Smtp-Source: AGHT+IEznFViHNZVbxOOUJA44LzQJGRsagsfg2qaFqollE3lXewLiQHeCmTuv7TaYn0hcrP/qHy6Sw==
X-Received: by 2002:a05:622a:34b:b0:428:3018:89b0 with SMTP id r11-20020a05622a034b00b00428301889b0mr1818061qtw.35.1704306001635;
        Wed, 03 Jan 2024 10:20:01 -0800 (PST)
Received: from dschatzberg-fedora-PC0Y6AEN ([2620:10d:c091:400::5:fcab])
        by smtp.gmail.com with ESMTPSA id cg13-20020a05622a408d00b0042831b379c7sm1734711qtb.89.2024.01.03.10.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:20:01 -0800 (PST)
Date: Wed, 3 Jan 2024 13:19:59 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Yosry Ahmed <yosryahmed@google.com>, Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>, Chris Li <chrisl@kernel.org>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v6 2/2] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZZWlT5wmDaMceSlQ@dschatzberg-fedora-PC0Y6AEN>
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
 <20240103164841.2800183-3-schatzberg.dan@gmail.com>
 <CAOUHufZ-hTwdiy7eYgJWo=CHyPbdxTX60hxjPmwa9Ox6FXMYQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufZ-hTwdiy7eYgJWo=CHyPbdxTX60hxjPmwa9Ox6FXMYQQ@mail.gmail.com>

On Wed, Jan 03, 2024 at 10:19:40AM -0700, Yu Zhao wrote:
[...]
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index d91963e2d47f..394e0dd46b2e 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -92,6 +92,11 @@ struct scan_control {
> >         unsigned long   anon_cost;
> >         unsigned long   file_cost;
> >
> > +#ifdef CONFIG_MEMCG
> > +       /* Swappiness value for proactive reclaim. Always use sc_swappiness()! */
> > +       int *proactive_swappiness;
> > +#endif
> 
> Why is proactive_swappiness still a pointer? The whole point of the
> previous conversation is that sc->proactive can tell whether
> sc->swappiness is valid or not, and that's less awkward than using a
> pointer.

It's the same reason as before - zero initialization ensures that the
pointer is NULL which tells us if it's valid or not. Proactive reclaim
might not set swappiness and you need to distinguish swappiness of 0
and not-set. See this discussion with Michal:

https://lore.kernel.org/linux-mm/ZZUizpTWOt3gNeqR@tiehlicka/

> Also why the #ifdef here? I don't see the point for a small stack
> variable. Otherwise wouldn't we want to do this for sc->proactive as
> well?

This was Michal's request and it feels similar to your rationale for
naming it proactive_swappiness - it's just restricting the interface
down to the only use-cases. I'd be fine with doing the same in
sc->proactive as a subsequent patch.

See https://lore.kernel.org/linux-mm/ZZUhBoTNgL3AUK3f@tiehlicka/

