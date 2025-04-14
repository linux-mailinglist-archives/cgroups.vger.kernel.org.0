Return-Path: <cgroups+bounces-7525-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADF1A88ABC
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 20:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079F1177D74
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 18:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F7228B4E0;
	Mon, 14 Apr 2025 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="synrLOQx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472BB2749E2
	for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654219; cv=none; b=uZ6tStzcLl0gIBF3Bjor9nncug0eaSjYhi06MRVW7pSewwiXBAhjfnFuSzgcAR30iWXJQtXCZBn+jVeCj+TtxKnvnmvFuZNpfh7MqG0oc7iyg145YDoJpwPM8VlEMQq1b3BM4Re4MBFAddwPwQdfYAW4Eh8Ag0GsFJU5WWhKfTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654219; c=relaxed/simple;
	bh=WhMMyVEvthmWhAyPBPX4bGNG1muo/czpOPnPrkkB6yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7I5gu69XeQ+Ps1arvXVx8ef8QYRl39J5YHoxcTztiqHaZpTrPud6mj6W90BC0pwA5FgjiA6RKVS8Eony0AVBHGobSIfvGqjCJZex/+nDosf/Jx4EShJWbS4qTZeXt2/d4btBbB17EpbwwbQCpSfNNf5YrRXMP61BMl8AMkJz0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=synrLOQx; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c542ffec37so482439285a.2
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 11:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744654216; x=1745259016; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wmxLTZDlUtyhjPG3LKgyqC3m7MkeZf8KO7nU/7lCHDI=;
        b=synrLOQx9REgbd5vbwGt1fSFp3Ut6a6BWu2AB2ypqnO7zWXhJP4i3pZV4PmaZW6bDo
         yh3gxJD+xEGgq37F4/iK9OcKUMCxk01WSxtGybrpIBq9j6ayttxrLqmQflPAwbBVYo0J
         i7l5dGj6tG6eTwAH/Zguwlvt3FV2w9AdcyGeeQipsk+hAinhHS1a8zRn4YdJXAtTi99S
         PgTsegJa6XETEHWPZC1rD5k3j4i3WwAajusiEyB8QhBa8YTPJIiC7y7pc4kHct00EO9C
         c+OJZUvj8vqYfCNhQGB87primZKJEDmxIPYwTHGbbnD0d2Z8kTyTwJ0tSnI+Rj1qNhPT
         hS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744654216; x=1745259016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmxLTZDlUtyhjPG3LKgyqC3m7MkeZf8KO7nU/7lCHDI=;
        b=oImRXVUFbSL/m1O/vEsSxOVAzXefzHWk5trcsXDkR7ypDaWYoCc8U+anzVPoc4HD/y
         EsIJ9P0ox/6C0macwI7aCJiCigT5VApxUqYpvHPU7AC0mpL0T9IjGk6uvrCVfoj2on/M
         QqILgUn+Z05VP5aDAaTJkmMGVVYCEOd6WMMtH80DRyYYLtaq+bORMAPa/9OHaK3Z8aCT
         gB26y0l8HpE0htyR+R5oC1144xTKRitcLjVdXe59gFynQC2iI+WYWRFtVuDb/K7oKLXY
         Aa5L13kmMXQu9Pz1O0GSdgqIbOw2RfNPIlSvkGvgMUOGEQWfqBGkLi7ZrKL6Gd3G/Ag0
         AR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxyMSfQnu9a55eLWhNyjIVMzCAFtG0p6aVbuBXfyuEYlLtyg8Iqrg1UAySsBMu04wUSyhg15uG@vger.kernel.org
X-Gm-Message-State: AOJu0YyIjEB2JaEGP/dzSakR9GqWEKbb6s9i9H6RxyQhiCosJpKqJVpz
	gUQjJD+ItKky9zUuaAeLvNFC8u2090Ubyhn5hYrRE7jyFFASTpj/e9F7ga2H4Xg=
X-Gm-Gg: ASbGncsN+QZYlL6VjIv5eZ81NW/+t9tSLsamUcZOjJQbLlJmiXELwMEccLwT74POO2o
	EFi4Nr49oT7Uggmk1H+k5frHcRyXYf3GAz3pjdM4/b9xG9fpxp771mcdn9shczBeTegyoGWfNcq
	H/uadNI3mxNvELqKaRgtni6s7CLaCvBArWam9x45hGsN/DvcqWmIQrKbcN/rO98eDTVACboh+UM
	szHQpAeFXzKMtxZAJF5mclf53NiHvh9LOnU7F8o8HuSogOcNygJJVOyof9/PGEIPmoLG0F6EhT3
	XwJPTqx5/KBH97KQ8Y90m4rBXkX9qhIdsz98KEs=
X-Google-Smtp-Source: AGHT+IE+XdJpOVhGEaj+Yv6sX3pIJj3/ALpArX3Fg1kdMboHe1klm4GlgsjQnZuIvjCGUk7JRR/efw==
X-Received: by 2002:a05:620a:40c7:b0:7c5:5f19:c64f with SMTP id af79cd13be357-7c7af1182d8mr2068553185a.4.1744654215840;
        Mon, 14 Apr 2025 11:10:15 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8a0c863sm768502585a.92.2025.04.14.11.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:10:15 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:10:14 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Waiman Long <llong@redhat.com>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
Message-ID: <20250414181014.GB741145@cmpxchg.org>
References: <20250414021249.3232315-1-longman@redhat.com>
 <20250414021249.3232315-2-longman@redhat.com>
 <kwvo4y6xjojvjf47pzv3uk545c2xewkl36ddpgwznctunoqvkx@lpqzxszmmkmj>
 <6572da04-d6d6-4f5e-9f17-b22d5a94b9fa@redhat.com>
 <uaxa3qttqmaqxsphwukrxdbfrx6px7t4iytjdksuroqiu6w7in@75o4bigysttw>
 <20250414164721.GA741145@cmpxchg.org>
 <gpzfja7rsb6cy6r5mpfbakx7xp444xskdumooocytwhi6362fk@hdjhr7zampaj>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gpzfja7rsb6cy6r5mpfbakx7xp444xskdumooocytwhi6362fk@hdjhr7zampaj>

On Mon, Apr 14, 2025 at 08:01:42PM +0200, Michal Koutný wrote:
> On Mon, Apr 14, 2025 at 12:47:21PM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > It's not a functional change to the protection semantics or the
> > reclaim behavior.
> 
> Yes, that's how I understand it, therefore I'm wondering what does it
> change.
> 
> If this is taken:
>                if (!mem_cgroup_usage(memcg, false))
>                        continue;
> 
> this would've been taken too:
>                 if (mem_cgroup_below_min(target_memcg, memcg))
>                         continue;
> (unless target_memcg == memcg but that's not interesting for the events
> here)

D'oh.

> > The problem is if we go into low_reclaim and encounter an empty group,
> > we'll issue "low-protected group is being reclaimed" events,
> 
> How can this happen when
> 	page_counter_read(&memcg->memory) <= memcg->memory.emin
> ? (I.e. in this case 0 <= emin and emin >= 0.)
> 
> > which is kind of absurd (nothing will be reclaimed) and thus confusing
> > to users (I didn't even configure any protection!)
> 
> Yes.
>  
> > I suggested, instead of redefining the protection definitions for that
> > special case, to bypass all the checks and the scan count calculations
> > when we already know the group is empty and none of this applies.
> > 
> > https://lore.kernel.org/linux-mm/20250404181308.GA300138@cmpxchg.org/
> 
> Is this non-functional change to make shrink_node_memcgs() robust
> against possible future redefinitions of mem_cgroup_below_*()?

No, this was really just aimed to stop low events on empty groups.

But as you rightfully point out, they should not get past the min
check in the first place. So something seems missing here.

