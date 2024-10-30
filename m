Return-Path: <cgroups+bounces-5346-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0C59B6DF9
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 21:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C29282753
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 20:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D161EBA1B;
	Wed, 30 Oct 2024 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxAEF9wV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB3719CC24;
	Wed, 30 Oct 2024 20:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321039; cv=none; b=CjhYiBDUX/dcWUF9DUOx5kiA8PIpiLaWRMXJYfBJuamJtEv8y7DtB/hlaqLD8/7sEks54xzPf2tjlcmSTwPJ+45N3Ez1NciqFAmz2iE3NzFl+JodWxxWSSB/IxTaTlFXSiA95NB2Gf6zeskizpRIK0zLguxL3zxYKqPpyxXGrh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321039; c=relaxed/simple;
	bh=JNkFV7cr5Y+37qEIiiM4tOnuD78lQyY8VCgnDaJjAGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbiuyFTJBK98QuQCOrlcKz/nOOegIGE68tzSrGQD0DNzJu73hCWhYeT0iQbVS+gxE9hfqBVwfEw8KijaYdAVEXMeeq7zzoCyn1QP9cOWVAORKnL2JkFa2tuyAA/Hk5OEn/WRKLjbTuld1cnv2ruPe1KetO5Yw1z/OhuuQKI5wGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxAEF9wV; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e690479cso298392e87.3;
        Wed, 30 Oct 2024 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730321036; x=1730925836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNkFV7cr5Y+37qEIiiM4tOnuD78lQyY8VCgnDaJjAGY=;
        b=QxAEF9wVFhkEHLgeQtW3BCpI6GFg31z+eFP1G0TwVFTPWuGI/i+MctHPc4c1hfjs99
         rmFNOcmNsu2UIDiSEkz+wXJrB7sZ6IFo8tqWkxjh9TF37O3nTNVDLZRKA5ULojWCw2D4
         pfsYzQiRlZYMPOVYDWNcvePV7jztWyLS4VZm1CSLHQ28WYZ4hLEmi/YUnchSMAl/JPwe
         nuKI0+Y9rBkSR/x0ON6olIYntCMs1IneFgYFeR0y49w3bdF3DYGOtDrEVFhrbWYixw7o
         jr8tMRTDX1RNqXJ+G8CNdmYV7Qf6p81w13DsVAmNGFhwNNqXkopbu2NcGXYSjyeX7kXo
         4fsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730321036; x=1730925836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNkFV7cr5Y+37qEIiiM4tOnuD78lQyY8VCgnDaJjAGY=;
        b=wkNionCeLyqNID7FB8HMS4bivW0d63Ht36Pkpc1w+URYY23XFpDFj2X2CED2Lmllj3
         YoXiNQeXE68ghLfiqwwCX93ZyewvpseS7YWjH6KyDmWitgjNrzhh9i4XTbvkRLMu4+LN
         ibfd969Rmhu6e7Ccb0mqrYzs6A7cBUqcHDwfaGcUdVx1I87pIl8M/3pzHTIhY3KoIExE
         S+VMVwVSZfdZzSShicg8ohupflQTc/TCFxgOSX8IBX8U5zDb4LDFygGsoKSmIlHLZPWG
         IHCeluvO5Z7Kle6nsMNXUXWigkldK+gZ3/PBEII0jgZJj9ZEzsDTyYuIJ5iIbTuuuNZC
         e2iA==
X-Forwarded-Encrypted: i=1; AJvYcCUsQnJscU5PzNYjkf8cHRyXhNaezV7w/h8jtiqZItWzBKE/e+jbBf2LhJ1fDogZHAylRdOATUHvVB4qFIP8@vger.kernel.org, AJvYcCVC56Nlas1SJQq+Vd2hjvO9vWlqKw8Hvr3SFqqBuYpT5LXUaGbNKKCzC6EdP0ElPNHpU+1Juu3a@vger.kernel.org, AJvYcCXelvSqCwbd73E02ItKPOo2dCpfcO9nCeDzZ44u+NQ1xIzVEtR42Gk0sa7egCw9A7xIyz0OY3lUno2y@vger.kernel.org
X-Gm-Message-State: AOJu0YzIoag/kKWr4LVzxD5IfXRrcpfACnIoypCsffytnd5V0Qp0421w
	M+kKW+0rGTwM5hFO/MgzfJ67aLS4pgBYY8Zn/CvXKRYvzgMf6hJTaejoMGqhzTPzH5Xjk5D/WG4
	zNKpQ8PCqJuxMq8qK1qgr5n75ib4=
X-Google-Smtp-Source: AGHT+IHwIVVPUQ6L4Z9pcPhSrmOucAHyfhtuRc1A2IaalpGTFNzP3GwdIuDPmFnxjOl0uDTjW9q7jnoMgwVaZUIENeM=
X-Received: by 2002:a05:6512:b8e:b0:539:8b02:8f1d with SMTP id
 2adb3069b0e04-53b348df014mr7797157e87.30.1730321035576; Wed, 30 Oct 2024
 13:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
 <ZyIZ_Sq9D_v5v43l@tiehlicka> <20241030150102.GA706616@cmpxchg.org>
 <ZyJQaXAZSMKkFVQ2@tiehlicka> <20241030183044.GA706387@cmpxchg.org>
In-Reply-To: <20241030183044.GA706387@cmpxchg.org>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Wed, 30 Oct 2024 16:43:42 -0400
Message-ID: <CAN+CAwM1FJCaGrdBMarD2YthX8jcBEKx9Sd07yj-ZcpDxinURQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, tj@kernel.org, 
	lizefan.x@bytedance.com, mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 2:30=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Joshua, can you please include something like this at the end:
>
> lruvec_stat_mod_folio() keys off of folio->memcg linkage, which is
> only set up if CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING is switched
> on. This ensures that memory.stat::hugetlb is in sync with the hugetlb
> share of memory.current.

Hello Andrew,

I saw that it was merged into mm-unstable earlier yesterday. Would it
be possible
to add this block of text to the patch description right before the footnot=
es?

3. Implementation Details:
In the alloc / free hugetlb functions, we call lruvec_stat_mod_folio
regardless of whether memcg accounts hugetlb. lruvec_stat_mod_folio
keys off of folio->memcg which is only set up if the
CGRP_ROOT_MEMORY_HUGETLB_ACCOUTING cgroup mount option is used, so
it will not try to accumulate hugetlb unless the flag is set.
This also ensures that memory.stat::hugetlb is the same as
the share of memory.current that is used by hugetlb pages.

And could you also update the list of signatures to reflect the
responses on this version?
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Chris Down <chris@chrisdown.name>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Thank you so much, I hope you have a great rest of your day.
Joshua

