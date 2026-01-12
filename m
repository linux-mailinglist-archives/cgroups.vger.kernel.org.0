Return-Path: <cgroups+bounces-13084-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B75D13EE5
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 17:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 772B8300297F
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F22364E97;
	Mon, 12 Jan 2026 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDubA/9F"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FE01CD1E4
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234639; cv=none; b=VSn00taIfoNM8qUBlwilCLcYXTau5WjBS9xXAhg/uH7YtjzEW/my1Jkb+8lLkNqPB6wspvcyieCn4seK88wdwKLxOENbQz7zg+phtJli3PF+T2yfdIjGYu4A99di0IdMtxIkOxee0cLaDfApCDy0cvKi4cSTOEQUsO8OHEq+Kq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234639; c=relaxed/simple;
	bh=f6kD8+ufnSvROiZtUrO1jfgPCWDyPJMAQlV8s6KiEYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swdCg0SaefkhXUtcVulog7aT+URKvdUw2m/DWaeAI6V6tlEOaq02clzAt9klW1ITR+jiMSYaU7n7mfjmJDxMYKDheQ463zm9OsdjcROVZke9wnvEl1ht3uDfBSIOfhBCquEsp3pVhaG1cVNa1IIohAgnkNv/06P3fwPH65CkNTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDubA/9F; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b870732cce2so208883366b.3
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 08:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768234636; x=1768839436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vqb4Hn5493L1mZt0rxFOjY5Siy0ns6XDE52wWf3HhJM=;
        b=EDubA/9Fgp58TkUug+G+/hN3hjkMchxk4/62kINUtlwU70VuT359ibWDUaSPOJ9UE/
         leUWYzqGoRHleQVKqR38+EN6nSHQNpx2PYo7tF4Y/uaw3nWGqHm+brQsawXZt8YJUoMW
         ByVH1/bhnY246Db0SKuqpPbqaBwBagRMM7VJ9LlOLqtWZY7DiqsVv4qg88LdKaYypGWR
         J8/c3/5t2xNWnjLEjKetLds6vcsUIeWzaZdw6kNtTEl5v2xmpvpt3rEGVjmoFRrW0oOT
         R/E4jFdEw0pDaiX8YI626LST5hvKsOrrRsuP/3CpUXNmM4Xo5k70sh4br/3VBQy4hxIR
         aYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768234636; x=1768839436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vqb4Hn5493L1mZt0rxFOjY5Siy0ns6XDE52wWf3HhJM=;
        b=DSXnLkrg1W+xoInHCmWWijPeNG99lABrK1bhzXVoPaMMyUaJweUIpYAfUn3P60VtQw
         J7amm/iqa8wlavbo0d73+iQMfJ86shIbXKOvjK1vG25L6LcKnmlqoYu0ms1+hOhV1w0z
         UbtbSJDnyjA2Xvi6ioZPyJLr5oBfqq7TryvcAjuy7180v+A68dtmqk9m3+KpbqlmwSuf
         AZ2cYpyExx0ER62m6pLJtFpDYhB4p8VkxjJEhS8p6XthTmuIXOg8Tq7H2tBfr0p9ReAj
         WH8iu9JDnzHdLXeplvlzdKT/ozWlREgih+OHYzxrs5JU6gxad/a2b34u+lUr0X2BAEV2
         G7+w==
X-Forwarded-Encrypted: i=1; AJvYcCU7H6CrQeBq7kpV0ZqEO9vPjkc1Dyz2unv/d9ti46GhoSwYy8YYIdpJCf8QS0IPcR2v/6mRYjlD@vger.kernel.org
X-Gm-Message-State: AOJu0YxHU1rggjUhblICgWk/fysh0kTAMFpcykkixPGyHv01ce05Zo7b
	4T5WzWhqBBOz807KSllLknzC1C5dpn8UdFc0pwSyvj0YoIT3PpyUTi9XBn581NjHpXPAixFj+aT
	lOWMFw5n6nVHdAIalQ0T+y9CYsDN+J1k=
X-Gm-Gg: AY/fxX4qUeL1ZjNrqkCbrac+MtdtU8EOH2Cnt85YVFSGOEWeEJiRpZtZ9Zfdf2xTl0p
	H7rnHlj1lA22+ZasFo7Zko4yxRsrZx98KqyJWOrP6z7j+jwOCejCSIQaEciNhnVgV9Qa+Inuq2Z
	zblWl3oVtjXMVFwELq4r23kLxQP2KhNR5+clOsTUAiIQAAT48f0MA8gNGKNzxCJ0Ibu/MwJYzC8
	ZcGR0wsxNME4WUjAU5fKlAfwU85kZeZOlUCfGKMOgCPacnFXYBOnSN3aTrmi2AFeWAwn1mNCMDZ
	r8rOUKiUkUpD9ZeDeIqeK8hgXMz4
X-Google-Smtp-Source: AGHT+IEHT2Wmj8ARHOeq+QXdeZhO2RV1mWXnMgHXcWT0v3RIri68i3/VYSsb62Dl7FZ899QtqfuzeanTuJydxAH+Cf8=
X-Received: by 2002:a17:907:3c94:b0:b79:f4e4:b55d with SMTP id
 a640c23a62f3a-b84453a0281mr1946626666b.51.1768234635616; Mon, 12 Jan 2026
 08:17:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110064613.606532-1-kartikey406@gmail.com> <aWUSyzHcaDwEg6_c@cmpxchg.org>
In-Reply-To: <aWUSyzHcaDwEg6_c@cmpxchg.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 13 Jan 2026 00:16:39 +0800
X-Gm-Features: AZwV_QifkK-8AO58M8_ctp22Xy7Bmh0O4VYVW6iSEyCGW44qb3SEfE5iCfTbZNg
Message-ID: <CAMgjq7CMsAMZZJL1=a=EtfWCOuDFE62RKR_0hUdPC4H+QF5GfQ@mail.gmail.com>
Subject: Re: [PATCH] mm/swap_cgroup: fix kernel BUG in swap_cgroup_record
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, 
	syzbot+d97580a8cceb9b03c13e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 11:27=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Sat, Jan 10, 2026 at 12:16:13PM +0530, Deepanshu Kartikey wrote:
> > When using MADV_PAGEOUT, pages can remain in swapcache with their swap
> > entries assigned. If MADV_PAGEOUT is called again on these pages,
>
> This doesn't add up to me - maybe I'm missing something.
>
> memcg1_swapout() is called at the very end of reclaim, from
> __remove_mapping(), which *removes the folio from swapcache*. At this
> point the folio is exclusive to *that* thread - there are no more
> present ptes that another madvise could even be acting on.
>
> How could we reach here twice for the same swap entry?
>
> It seems more likely that we're missing a swapin notification, fail to
> clear the swap entry from the cgroup records, and then trip up when
> the entry is recycled to a totally different page down the line. No?

Thank you so much for Ccing me!

Deepanshu's patch is helpful but that's not the root cause. I did see
the problem locally sometime ago, but I completely forgot about this
one :(

I think the following fix should be good?

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 453d654727c1..e8b5b8f514ab 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -758,8 +758,8 @@ static int __remove_mapping(struct address_space
*mapping, struct folio *folio,

                if (reclaimed && !mapping_exiting(mapping))
                        shadow =3D workingset_eviction(folio, target_memcg)=
;
-               __swap_cache_del_folio(ci, folio, swap, shadow);
                memcg1_swapout(folio, swap);
+               __swap_cache_del_folio(ci, folio, swap, shadow);
                swap_cluster_unlock_irq(ci);
        } else {
                void (*free_folio)(struct folio *);

---

It's caused by https://lore.kernel.org/linux-mm/20251220-swap-table-p2-v5-1=
2-8862a265a033@tencent.com/

Before that patch, if the folio's swap entries are already freed and
have swap count of zero, memcg1_swapout records a stalled value but
the put_swap_folio below will clear the cgroup info as it frees the
folio's swap slots. After that commit, put_swap_folio is merged into
__swap_cache_del_folio so the stalled value will stay.

