Return-Path: <cgroups+bounces-4739-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7899196FA00
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2024 19:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1AD1F22B91
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2024 17:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384151D61A7;
	Fri,  6 Sep 2024 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXy94WP6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DD2200DE
	for <cgroups@vger.kernel.org>; Fri,  6 Sep 2024 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725644364; cv=none; b=qVh79lDUvMEuCx5hMqF0Cdj7EfvyYZ7Eym5FDiLj9rz6dkvC0KxCZV0PFjX7Jx3TKEWMcQN6RGhlzHTJvQ9I3z7M36L8tZrWe2UWncG3CMWGzHjjr9cYKVphvILV/1AUxYJ5DVeExwIkRCF9Gp7cqk9AFdkxgQPb363eHaTd6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725644364; c=relaxed/simple;
	bh=8DjGwk5BmApUe6QU/1dMIE3rzqUtF/FDiXDM922JrtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9kvEAsB5qWHqkGdoye0YV7LeaFbJmuciTJTVVWSACuEMJihXUF9iruz7VyIWwuuFDldumpxywdaplsfpuXnbfjg28wOw/DpRM7YE5aEo9sOHunhRuwhrBAAYiuDL+9DSHmZdOIq7dCnuRCys5kfejOG1jCT8bzUoCy/gPPQyJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bXy94WP6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso3937063e87.2
        for <cgroups@vger.kernel.org>; Fri, 06 Sep 2024 10:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725644359; x=1726249159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eyE0YvwAJ4jbuy5OCYOQlHJiaipbu47/6EmzS9gI24=;
        b=bXy94WP6ztx0TN3bvpK7wPdXIqlyx2jPyJZN9mUXJJKgLv8T++nE1XsGL9XMtosZkh
         COZKFDde7bt63pzz6GoEQtqIgvLLouzOIHWkdYUZuH8Yj7KHVoCJIZ537JCRMyzZsHwL
         J5exExF8Wo/+PkyIcJnvhAuzqweAyqoYzyTE/ZZToRJFLcIQjUoonoeA7jw/jDXc/uQ8
         cFL2H2ssvs3yAG4NddSYxPtNP0HpsCwClYU87+bPQiqQ2C9ppa4RDnE/GxbK25/utMVo
         VRRcHX2Y1uFkzxp58gLQXDsSWDmVl/i6caRMbZlR2VKgxCA+l0IJZQTt/TCy92Z+nJPZ
         T+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725644359; x=1726249159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eyE0YvwAJ4jbuy5OCYOQlHJiaipbu47/6EmzS9gI24=;
        b=eK2YdacOlznYO5KigbE6YeuVAV7+eaaCek//CsWdqd3qHHBJQyfrDT9AsJ7u7U/CWs
         wZJy7nf78YAJ2yPTGdFCYGC0Sm9hfYHwdiQEYftCLCZH9FJTi3x3lmAZz+3VPDBsqAE4
         exBI6d5qCjRPpRF2K7E8TT6LH9vI4+TkcyU36/TdcGOUhnq1KyYaWY8npvVyJ4aO6NY6
         z6PVHVlnVgIV8YuHSGcEqCG/cXQQYWa8prfbdBdB/L4H6siw3MZdE8uw8j13Zcxf/MdC
         TnT86SXHJG9KDzff4hEnUncj5bYY4oupWmRENNucOOKCzNmFWMtWiF0xFcBZB2IxmbA/
         5zJw==
X-Forwarded-Encrypted: i=1; AJvYcCWWVI/d4XCdyIyusAnvOVZQK7ER24CXm9dR8E+W91ZWsoku5MrI+XiWPziiQpGFWYpuPcrok0I+@vger.kernel.org
X-Gm-Message-State: AOJu0YzydMx6Z0IDU+rPOo8Y81RnssSDdFFIfwqYJI7hgzv595OCSE56
	8GNzQSmHz7WjEIAQw6h+QecBJR5hdZyojvn3JI0KkWnkyma1mrp27/i+P3urbCewKYMJ2WuQw+o
	5zXzYCdgiImFwP1Rmxmm2Z6XXctsRclr+stoH
X-Google-Smtp-Source: AGHT+IHipKO9SkosIPD2Wct73/XYtbbx4G71uCj3TqDiza68oFp8S5K1JEdl2VaO2MjbDdeU94o3UF6HlYNf6nqPKYQ=
X-Received: by 2002:a05:6512:104a:b0:533:4591:fc03 with SMTP id
 2adb3069b0e04-536587fbcbdmr3255522e87.46.1725644358377; Fri, 06 Sep 2024
 10:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905173422.1565480-1-shakeel.butt@linux.dev>
 <CAJD7tkbWLYG7-G9G7MNkcA98gmGDHd3DgS38uF6r5o60H293rQ@mail.gmail.com>
 <qk3437v2as6pz2zxu4uaniqfhpxqd3qzop52zkbxwbnzgssi5v@br2hglnirrgx>
 <572688a7-8719-4f94-a5cd-e726486c757d@suse.cz> <CAJD7tkZ+PYqvq6oUHtrtq1JE670A+kUBcOAbtRVudp1JBPkCwA@mail.gmail.com>
 <e7ec0800-f551-4b32-ad26-f625f88962f1@suse.cz>
In-Reply-To: <e7ec0800-f551-4b32-ad26-f625f88962f1@suse.cz>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 6 Sep 2024 10:38:42 -0700
Message-ID: <CAJD7tkZNGETjvuA97=PGy-MfmF--n6GdSfOCHboScP+wN1gTag@mail.gmail.com>
Subject: Re: [PATCH v4] memcg: add charging of already allocated slab objects
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 10:29=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/6/24 19:19, Yosry Ahmed wrote:
> > [..]
> >> I felt it could be improved more, so ended up with this. Thoughts?
> >>
> >> /**
> >>  * kmem_cache_charge - memcg charge an already allocated slab memory
> >>  * @objp: address of the slab object to memcg charge
> >>  * @gfpflags: describe the allocation context
> >>  *
> >>  * kmem_cache_charge allows charging a slab object to the current memc=
g,
> >>  * primarily in cases where charging at allocation time might not be p=
ossible
> >>  * because the target memcg is not known (i.e. softirq context)
> >>  *
> >>  * The objp should be pointer returned by the slab allocator functions=
 like
> >>  * kmalloc (with __GFP_ACCOUNT in flags) or kmem_cache_alloc. The memc=
g charge
> >
> > Aren't allocations done with kmalloc(__GFP_ACCOUNT) already accounted?
> > Why would we need to call kmem_cache_charge() for those?
>
> AFAIU current_obj_cgroup() returns NULL because we're in the interrupt
> context and no remote memcg context has been set. Thus the charging is
> skipped. The patch commit log describes such scenario for network receive=
.

Oh yeah I missed that part. I thought the networking allocations in
interrupt context are made without __GFP_ACCOUNT to begin with.

> But in case of kmalloc() the allocation must have been still attempted wi=
th
> __GFP_ACCOUNT so a kmalloc-cg cache is used even if the charging fails.

It is still possible that the initial allocation did not have
__GFP_ACCOUNT, but not from a KMALLOC_NORMAL cache (e.g. KMALLOC_DMA
or KMALLOC_RECLAIM). In this case kmem_cache_charge() should still
work, right?

>
> If there's another usage for kmem_cache_charge() where the memcg is
> available but we don't want to charge immediately on purpose (such as the
> Linus' idea for struct file), we might need to find another way to tell
> kmalloc() to use the kmalloc-cg cache but not charge immediately...

Can we just use a dedicated kmem_cache for this instead?

