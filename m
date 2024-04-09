Return-Path: <cgroups+bounces-2413-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFDB89E5AC
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 00:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5791C21DBF
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 22:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F2112F59D;
	Tue,  9 Apr 2024 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y2vU3YEW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B511EA8F
	for <cgroups@vger.kernel.org>; Tue,  9 Apr 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712702180; cv=none; b=I1asXDPDTYi6TmKRuSM23xtzUu5226K+lZO8OnwguBblrnQE4m4ZOxQAM/tMgAMSSi1FmLQTteErakI3vX0tztE45IrkxEnz817KRptO1ZiaOYgklsvT19o4Y7LYvR6Obo2Vwo/KBN3GZbqskXQhGYSR3pOPFfuexEU3hvkfXiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712702180; c=relaxed/simple;
	bh=01XOupmLACYxSiT5YVfOYtUF98Rdioy4SXxTYQ4XjpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIqnvuLhZYIqF4yNjvwP6aUvsCjvRKlEEY0G/y89IqLA1sOLktTyriOjIfaZtKB9oKihSBiOJI90PHbMRxk43b6zHERadhpoeueQrvpb1EpuArOIwB1cKrNSYHKqmGg+pq9+6AnwfE4uyQrDqa4BLJIscQcN7m5G9kKUKdGfJ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y2vU3YEW; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-617ddc988f5so50493127b3.2
        for <cgroups@vger.kernel.org>; Tue, 09 Apr 2024 15:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712702177; x=1713306977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ox3JYk/1gJ5SrPOhe25hcg8/9Pb6Gx6InXbQ2HJ+0as=;
        b=y2vU3YEWtLr9DcAMgHMdVsJGi4ujGy/APrDDuJDMxGVa3l0xxJud9S8z20sjKTsDtm
         K2SPC4iKN26j4r8Hgooo+W87rjiLXYrzrIRfVpCQqpXuDh3IOUYiXHeiA7KsTwDr/FGL
         dC2JgALI9eS2bF9rgXiCEelwRHyCKYFDpt/JgqQ+LSwiu8yl93J7p+oqjq8xCpaYEQWV
         zesGmHrTW4hnHMdjnNggMA3xwfWr+kYMc2oEXVgLniHlgdFJt1aA8CezhAsRrb7VT1dK
         Xrc4NXTReJcFqWYkNkU7BwSkgJINp0C2Z5k4vm1MkgHPyQu6MveUIENsgHag76uMmL9i
         /+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712702177; x=1713306977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ox3JYk/1gJ5SrPOhe25hcg8/9Pb6Gx6InXbQ2HJ+0as=;
        b=gifbTYuqg371ews+EVsJj069RxQ/4gkwBBL1EOAIifijjqg2FMqrVVKIKGZTvxoTPw
         l3wQlB24PaP40frFnYWcfMgdj6EKaLCGpSn3kFaj3aWX7/f80aS1MgaIX2cqkVBCdHyC
         W/Av/jY0mHbYxXInhPWbHDEII4j0Sp42zhNecNCNQKQwSn/a55YaupJk8+SIlYbbKa7i
         msxXnMY94mdFWEixKH/aAMehbfS+SUus1tnq5cpqMBygo3waKUjltoTCgt8m6Wyqj/UJ
         v5HBA+GuL5F+ViN9pfeV4QSw6YbXYFSNr84FsKEkqNlKyTtbxXIr49PXUHh7sUSi11q8
         YAyw==
X-Forwarded-Encrypted: i=1; AJvYcCWQaq/xg3Ri0QTLmBvsePR4QdKGpWiXxcPaMAbtcCk+QWwib6aa78KsyTVZEFOcDJrjJH/Sdat+832rAw58bl86qF0pxiL88w==
X-Gm-Message-State: AOJu0Ywm97GCR7CF2kQIHDt2qv2nWBcRG0bYdZufHcrVxcekhEdgO3ZE
	Gh8G7anK/jsyDOc5I/33REdlEvHispq72AUYokI0VJeA5X65U80dAyujrVRSUMSJ/sfWN1Z3EGJ
	3Ck+yp+m3SShO2zoE6rOj0uaA6rU6FNq/GqOi
X-Google-Smtp-Source: AGHT+IGAf/8Me/Bf0eW65XyXimjVSB4uyAWoDyRV+7q0bEjq9AiweOA/NnaUgQNh+9qyepeYRyZVpwkboG+TireVnq0=
X-Received: by 2002:a25:aa8a:0:b0:dc6:2152:3889 with SMTP id
 t10-20020a25aa8a000000b00dc621523889mr1241238ybi.7.1712702177244; Tue, 09 Apr
 2024 15:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327213108.2384666-1-yuanchu@google.com> <20240327213108.2384666-2-yuanchu@google.com>
 <875xwr81x9.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <875xwr81x9.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Tue, 9 Apr 2024 15:36:04 -0700
Message-ID: <CAJj2-QEczZzon8AhO32_B=D2MAZG+1YWp0yrgSKQOChjQnN1OA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/8] mm: multi-gen LRU: ignore non-leaf pmd_young
 for force_scan=true
To: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
	Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 11:52=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Yuanchu Xie <yuanchu@google.com> writes:
>
> > When non-leaf pmd accessed bits are available, MGLRU page table walks
> > can clear the accessed bit and promptly ignore the accessed bit on the
> > pte because it's on a different node, so the walk does not update the
> > generation of said page. When the next scan comes around on the right
> > node, the non-leaf pmd accessed bit might remain cleared and the pte
> > accessed bits won't be checked. While this is sufficient for
> > reclaim-driven aging, where the goal is to select a reasonably cold
> > page, the access can be missed when aging proactively for measuring the
> > working set size of a node/memcg.
> >
> > Since force_scan disables various other optimizations, we check
> > force_scan to ignore the non-leaf pmd accessed bit.
> >
> > Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> > ---
> >  mm/vmscan.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 4f9c854ce6cc..1a7c7d537db6 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3522,7 +3522,7 @@ static void walk_pmd_range(pud_t *pud, unsigned l=
ong start, unsigned long end,
> >
> >               walk->mm_stats[MM_NONLEAF_TOTAL]++;
> >
> > -             if (should_clear_pmd_young()) {
> > +             if (!walk->force_scan && should_clear_pmd_young()) {
> >                       if (!pmd_young(val))
> >                               continue;
>
> Sorry, I don't understand why we need this.  If !pmd_young(val), we
> don't need to update the generation.  If pmd_young(val), the bloom
> filter will be ignored if force_scan =3D=3D true.  Or do I miss something=
?
If !pmd_young(val), we still might need to update the generation.

The get_pfn_folio function returns NULL if the folio's nid !=3D node
under scanning,
so the pte accessed bit does not get cleared and the generation is not upda=
ted.
Now the pmd_young flag of this pmd is cleared, and if none of the
pte's are accessed
before another round of scanning occurs on the folio's node, the pmd_young =
check
fails and the pte accessed bit is skipped.

This is fine for kswapd but can introduce inaccuracies when scanning
proactively for
workingset estimation.

Thanks,
Yuanchu

