Return-Path: <cgroups+bounces-5168-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332269A517C
	for <lists+cgroups@lfdr.de>; Sun, 20 Oct 2024 00:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AFF1F21F37
	for <lists+cgroups@lfdr.de>; Sat, 19 Oct 2024 22:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EE41922E9;
	Sat, 19 Oct 2024 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mesSAKLY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9030520E30B;
	Sat, 19 Oct 2024 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729377967; cv=none; b=mf2Zql84flPuKG1/g8kKM6loCYuNurZSbMvplVyAqpkGsy35/NKHP2lLH+1CYyjRGyp7Dksvv275ZtXmgwsBOLCXDXNw8kFy934BfuwarNgT0rIYyFQyefd6MKxw4UfVXWoauh9GfEsmn3ClqBTadV7P254cbKfAzx0hYOqnnsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729377967; c=relaxed/simple;
	bh=HygObp9ZtTiCt4ruecN7jyPhUDu4WsEXYehExPiGj6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWtdQh7IPCtXh9Ml6usxNkJuTaF44fvJ4KeO2tCdNdDFzoqCuB6lvlhb2W4rOjs9ItYu7wjYu8bRVNfwLN31HgKhac3hmsxwD3gqUyrQn8RjEQadCBjyPz4Qha4IUfU1JiYWif38MChfQdelmPGqh5Xn6DXC2nu30vSIbKjWgDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mesSAKLY; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so3842679a12.0;
        Sat, 19 Oct 2024 15:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729377964; x=1729982764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HygObp9ZtTiCt4ruecN7jyPhUDu4WsEXYehExPiGj6g=;
        b=mesSAKLYXXz7eGOyNudKVfprmwD+CiW02OoFacbqNxjDlk5br6bk++pCbXHex3HtCJ
         ENWfv8NT87JkqGE+8rUS5UeMfVN/zh3qwEZ4QtaJRI5TCdOv8K4Bjk56Y6CKdP1QyYKj
         umXF4gc+Ye53W/25ZdKklQsKVNrgSZDUYashjxwqGMz1CyouMal0mZ2gK+XTlvRAM9Au
         v2OtcWRJrOSiPjVzyq9KBQ7tmZumRy07Uh6EnEouixsoQxHRo4prMYfln3+62QY6636o
         uYbRy/aUKNW9qg7WwZsVotfHDYlUK3jv1Txeyjt9U+3F8I38YFwJlQg3f0P5Gt42R39J
         g43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729377964; x=1729982764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HygObp9ZtTiCt4ruecN7jyPhUDu4WsEXYehExPiGj6g=;
        b=Sm/xoz+xd0XJunvPmVNLtPNuJ1blNyUYV23NQGZ/cGQSnk+I/36jkjj71835Vgj2Xj
         p2OOIy7pw88E/Hf37hXv+rzWO9Iom6EudaRKU5FSKxmLGgG3IAwQfkv18DOsHdb5Tons
         bPdw3OxuZDV/fdwbBcUtAVi27GnxlerJlkRNJS//Wpx83FbxOZbSdshybfuOPZ2SWUlF
         S0vwXGaSfknJnhSm3xBbAtcHZ6fr+UsArI9MYxl6zOwVPhO6dbLvgK5tKJyRaJlR9gHO
         f0jvEcr1pBIYao1TkjrwDwm4KEVJlhZ1i5vxvNSK5mUahNJoOc/f+Pqy2tZeZ0hrD3uP
         OJng==
X-Forwarded-Encrypted: i=1; AJvYcCWLfmyrEoxmRvEcgMe02PrServlb0L1TDutRdA89hD3djGnxStUB7/5G4YiIvCDnauAZRyr/PpzoeIlTWay@vger.kernel.org, AJvYcCWWs1Eb9q61S+NrcZh+YkUPtFLm7vcFPcfTe1dtkBPfRNws+zYfDNuwz8+xEEET+FZcdPIonXry@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvn2hZqo+ghYxUdHfTOXY19DF4I8FPYFE0F4ihme+lzmSALL2X
	2YPLWxR0FjdWBvaxwj6Cl9zgISXo0T9e9LYVB/q0LA/dGog9SvHJW8SHLZS7UMmlzdvid9d0qaG
	C+QD81wlWJQ5cliemBL1nee6Nf0Q0tw==
X-Google-Smtp-Source: AGHT+IFAOoB+M7JjlLl7z0ntzCkGcHgGblt5gwhJG44WUxgPDR/KmYf5vV2JDcbJ5hpyN7kRwnm/R9a7HRoJZpMaskw=
X-Received: by 2002:a05:6402:27d2:b0:5ca:14f3:2883 with SMTP id
 4fb4d7f45d1cf-5ca14f328ddmr2611149a12.4.1729377963447; Sat, 19 Oct 2024
 15:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
 <20241017160438.3893293-2-joshua.hahnjy@gmail.com> <bhcxyl2xir27ds7jlcsncajathj6fbpzo5hoymdvb7h6a44gfu@lxdsu5up344n>
In-Reply-To: <bhcxyl2xir27ds7jlcsncajathj6fbpzo5hoymdvb7h6a44gfu@lxdsu5up344n>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Sat, 19 Oct 2024 18:45:52 -0400
Message-ID: <CAN+CAwNrijiP91_Hg6rTcGt3pQi0C2a4CSUtMjYfb_CP80KdcA@mail.gmail.com>
Subject: Re: [PATCH 1/1] memcg/hugetlb: Adding hugeTLB counters to memory controller
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	lnyng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 5:34=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Oct 17, 2024 at 09:04:38AM GMT, Joshua Hahn wrote:
> > HugeTLB is added as a metric in memcg_stat_item, and is updated in the
> > alloc and free methods for hugeTLB, after (un)charging has already been
> > committed. Changes are batched and updated / flushed like the rest of
> > the memcg stats, which makes additional overhead by the infrequent
> > hugetlb allocs / frees minimal.
> >
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>
> I have an orthogonal cleanup request (i.e. after you are done with this
> work). Hugetlb is the last user of try-charge + commit protocol for
> memcg charging. I think we should just remove that and use a simple
> charge interface. You will need to reorder couple of things like
> allocating the folio first and then charge and you will need to do right
> cleanup on charge failing but I think it will cleanup the error path of
> alloc_hugetlb_folio() a lot.

That sounds good to me. I was originally planning to include the
hugeTLB accounting in the try charging mechanism (as to only include
it in memory.stat if it is also accounted for in memory.current. I will
think of another way to do this accounting so that cleanup becomes
easier once this patch is finished. One way I can think of is just to
check for the hugeTLB accounting config before adding the stats
and accounting for them.

Thank you for your feedback!

Joshua

