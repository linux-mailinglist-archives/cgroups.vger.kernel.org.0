Return-Path: <cgroups+bounces-5282-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B346D9B1912
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 17:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239A22829A1
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 15:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC156249E5;
	Sat, 26 Oct 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QcNiFeI0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEFB1DFFD
	for <cgroups@vger.kernel.org>; Sat, 26 Oct 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729956404; cv=none; b=ct7p8MLws3sf93sdL3kTdlQ/W0IvhHPUrGgk4XcRr25/ADkBmNvfLL9ivQsXtm6DsVhfR6p+IAX9FhwL5wMpuC54Zfda1jbC/C4QkdQkQn8VGlYMl7oiBRI/BuLGlTmZSZmKNTXQTXdAoN5lFWxKnk100Lj9jWtvBr9fdSyY9GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729956404; c=relaxed/simple;
	bh=j+TOt+oBoXAXIref9ySAzCU2ABgXyfapBlEIF4iWO1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ho+IOLsqdO5VJ+fq0i3iGfJSxGIMbMRqAOENdHyTHLdAdRz/BQ+WITYI2ahpiTrkdaf16417atiKGewK4dveH91rxktZltpmpT1NtwPGasrK80B6u1AabX9GVUT07MBdiomEemgSqoxOapeRNzLk85bhasF/V2coJz96uc5HSW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QcNiFeI0; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4a74a77878dso902478137.0
        for <cgroups@vger.kernel.org>; Sat, 26 Oct 2024 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729956401; x=1730561201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xurp/dzSZiTxc3Q4P+xg6SJq6yioLcLs/RNUwkLIb8=;
        b=QcNiFeI0D+4/GuAlhGXHe9GX8KU08JRwuhTU2KTl9W5MsI5PXZE0hf5chrDmwO4UMr
         5NwN9HrHhG+XIdOOiGWJ15D/+Slyu2ROHE+SryvQgnk5qFU5L7Ljx6Vwkpft1b6NYWGs
         BX/qVMoX1t6hxO5F6HS7tC4/faBNjEpp73nEzZSlL89EbID9AIJDKUF9QtyTTDrKaS7y
         +nIe0QER7LmRaqnjHOGT/dV+taSPp45QW4eOVYtGQ3avFKFWU00pzBkpKmL3cYKltsAG
         BfQkFysK/Jpdcs+l2cSS9fXP52yz4Hgm8+AfPrmB6j+8BacHbVDrJfsY/znkKZPiBYEp
         yM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729956401; x=1730561201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xurp/dzSZiTxc3Q4P+xg6SJq6yioLcLs/RNUwkLIb8=;
        b=P/0D0zQqt/Mtv8+Ewn3yANzyn1NXxDAPriLbcE/LcrAA8rMkQUwrWeKfiswAOiELx+
         iFHGZuzSmBe7o1Snq/sN4XDrQbf8NeucIn+aOZ5O9ctGx1MfOajAA4+IAuLVM5CYEyJU
         55624zk64V+icvUP3+caC71/I3UkAc9+WcO2QeVxSvBmcWRObnF8o6jFr7OfQ1RqgRnd
         GYnObSjPfnbEXyiif8rjzUAqL+ERxrkf7tlER5tK8T3iQi4Bmf1rSy95dfGU4ZJtX+r6
         HU5XPSFoNbV90eNObpVy5ny7BxqkKk1Rp7HpCj2uHJ8A6yA7EBbUjU/W5ou1RSOuZN2M
         94sg==
X-Forwarded-Encrypted: i=1; AJvYcCX53j02nYdOLDR6w6IWYvUvvaQzk8QzcJjNchICrMtoWt/MGO9pKjxRbY7eteSEoMDaSOl3jJKq@vger.kernel.org
X-Gm-Message-State: AOJu0YzPY1C5crzxHMs2yTVIy52jhe8kb34s2cvTmbKtL+qQ+gLn9GP9
	OI5caey551o7nW3oO4iGlHBQRyvRQ4OQAH33sqL5IIyLzq/tA7RXRG9GYDQc44k8PzIe8ByKLZ9
	mvnQUqq6oP+ZlCeb2vvO68nBl++eatkwZHsQf
X-Google-Smtp-Source: AGHT+IErUT0EIQ3izExbmaeiykyMEE+HsZfO112pFWJqZp8vISP3bZ5byVVQr2RWeeWRFFt6XPR1QkksNOhNbda7Msk=
X-Received: by 2002:a05:6102:5112:b0:4a5:b0d3:cbbe with SMTP id
 ada2fe7eead31-4a8cfb27a5fmr2090677137.1.1729956401467; Sat, 26 Oct 2024
 08:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-6-shakeel.butt@linux.dev> <iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
In-Reply-To: <iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 26 Oct 2024 09:26:04 -0600
Message-ID: <CAOUHufZexpg-m5rqJXUvkCh5nS6RqJYcaS9b=xra--pVnHctPA@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 12:34=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Thu, Oct 24, 2024 at 06:23:02PM GMT, Shakeel Butt wrote:
> > While updating the generation of the folios, MGLRU requires that the
> > folio's memcg association remains stable. With the charge migration
> > deprecated, there is no need for MGLRU to acquire locks to keep the
> > folio and memcg association stable.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>
> Andrew, can you please apply the following fix to this patch after your
> unused fixup?

Thanks!

> index fd7171658b63..b8b0e8fa1332 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3353,7 +3353,7 @@ static struct folio *get_pfn_folio(unsigned long pf=
n, struct mem_cgroup *memcg,
>         if (folio_nid(folio) !=3D pgdat->node_id)
>                 return NULL;
>
> -       if (folio_memcg_rcu(folio) !=3D memcg)
> +       if (folio_memcg(folio) !=3D memcg)
>                 return NULL;
>
>         /* file VMAs can contain anon pages from COW */
>
>

