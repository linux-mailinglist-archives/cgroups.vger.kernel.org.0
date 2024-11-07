Return-Path: <cgroups+bounces-5467-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 922759C099E
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 16:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56055284FAC
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 15:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D43212EF7;
	Thu,  7 Nov 2024 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMpwZz17"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0718212177;
	Thu,  7 Nov 2024 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992036; cv=none; b=rUzbJmzVd7rceNyH4Jo8dmY7e454i25qAlHfoNoyVQIC72E0oj/EznKpXjCQPXBAToWGjEfJZRstroC1tTzy5LS8C8G2jU+QTln+T/ZbzxVdU5aWhHqmLfqh4pLrbwU0ja7rMm4szhoa/bfdIylXH9y+2UrAJ/W43Uv03/neOrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992036; c=relaxed/simple;
	bh=a3a+iXQlezEkgSTSp7apFzCXpCiS3xTjdFoPT/clhEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RegKza3unyRsExSsaqrbB9/x9LvdNV3nDoI0Ihqju86XjFFu9v+9sHjE9BF/MIRSKtrWdUq7mw7IN5vPYsohF5dh6DsoSx4BGryKK8u5B6w7iPren/z7tKrRORtd4u5kPHDk0ZWMyOJQvR0hT2vTh95CMSXFh1FppJqrbOWJH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMpwZz17; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ceca7df7f0so1230903a12.1;
        Thu, 07 Nov 2024 07:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730992033; x=1731596833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTbFFs4GMjF0GppxcpAZvv8cQk5IYlHwwCm9K1YyjBM=;
        b=XMpwZz17026CGI1iTlVfvejzYfLExOLBQjn52eKu1AExUH1DQC5u3yQJjO45Zdf8BW
         ryipNnb6yjwyV13HSpYOw+8ExAu32ZqyaIKtyrGfYacK4UG/GWkYewoC4QVP9jn4Yeju
         myn9dOShT31OicdgRoGFfuoHBKcfM9PdcVnM6nKyjjl6xUHgtiYrCRwifs85XVYRs7Q1
         xAfWljUsZ9BvvoFk5fFSyYd+U1Y4P2KCO7NzH8qvaYXkYJfmNSQCKF0dMJIZkRFi0jHr
         apSFQMoz+cjSH80gjSaTU/lg4/VI7gIFAgF1Se7Z6NtQ9yOvXdDsdoOKbTz7zwfcNzcB
         jj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730992033; x=1731596833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTbFFs4GMjF0GppxcpAZvv8cQk5IYlHwwCm9K1YyjBM=;
        b=pHJMS0rakVOMSSOwXc6RJNGfsJSncdlUSjCCcAVPSdNZu75xAVw/p3NpnhFJ9b8hJ5
         Fhn+NIStag/U0iaAjfpAFjnJpRgrj5ZZFpi/Ln52fxWDLAJAHZKjaotRvxqG46qG6VKb
         bghOsiRY6jiHrME4PNNjR1FSlkEvPguSKzADNeuUL78nkaJh1fTdesRP0T3L0H+ALiqE
         OmIkTF72u9qa+vn2GbnGqX0/J2rJeWKSlKHQmHGPMXG2neoU5r60Kj9cPWxFgYt65RTU
         ZaGrcQ1ZA6i1nXcOR/5WaUEZEnLDY/MzZ2gX2rqBFa/IqyhacnvZdBnuF9ENo4fLzB/P
         bw7A==
X-Forwarded-Encrypted: i=1; AJvYcCU4Mx3YZecjgKD0NYAyxpLKm6SU/ZfQLc2EHc8xlzivOkSqlCnr4AnlfUkm1zjnTKpFmX4UcyNo@vger.kernel.org, AJvYcCVuNKM5p27MI/UaudY34gmVo7D0yKn6jlOW+9WRlxBlv0Sv2yjQfsKsAd46nBo1yKGQXTbidTqvt5ZsRjRn@vger.kernel.org
X-Gm-Message-State: AOJu0YzL3RFNVIeeCJ0jHEsiNpaz/u5jE60k+mv60ht4HU2UuSlvQzeX
	63m5uzGlVeOMeJianwf9Cwm42nnxN/dTjcUrghbADGsCAlBg+wT01aGABBIR5rzZz1UkK9kmSw0
	XVS5fK97md/o5bBFQHKbI8q2Euj0=
X-Google-Smtp-Source: AGHT+IF5RIcl9161jr1QBTDKzzyt9nukgZq5RXyRyoAPSJy78RdLWhVzSFLWkidSrwMPtleb3JKBnV2qgyROzy04aOE=
X-Received: by 2002:a05:6402:4416:b0:5ce:faa5:c038 with SMTP id
 4fb4d7f45d1cf-5cefaa5c1afmr3351138a12.28.1730992032437; Thu, 07 Nov 2024
 07:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106221434.2029328-1-joshua.hahnjy@gmail.com>
 <20241106221434.2029328-3-joshua.hahnjy@gmail.com> <o7dpwewfztqpkidrhvpdm57ikid4yswygag5gkjplfwdfkl54l@bs6oh2t4jp7z>
In-Reply-To: <o7dpwewfztqpkidrhvpdm57ikid4yswygag5gkjplfwdfkl54l@bs6oh2t4jp7z>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Thu, 7 Nov 2024 10:07:01 -0500
Message-ID: <CAN+CAwPkcLgnrd4qVj-BAv_KYTakTsp3UwmBqs==vGdfaZan=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] memcg/hugetlb: Deprecate hugetlb memcg
 try-commit-cancel charging
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 6:50=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> >
> > -int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
> > -             long nr_pages);
> > +int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp);
>
> Please cleanup mem_cgroup_cancel_charge() and mem_cgroup_commit_charge()
> as well as there will be no users after this patch.
>
> >       /*
> >        * Processes that did not create the mapping will have no
> > @@ -3056,6 +3044,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area=
_struct *vma,
> >               /* Fall through */
> >       }
> >
> > +     ret =3D mem_cgroup_charge_hugetlb(folio, gfp);
>
> You can not call this with hugetlb_lock held.
>
> >  {
> > -     /*
> > -      * If hugetlb memcg charging is not enabled, do not fail hugetlb =
allocation,
> > -      * but do not attempt to commit charge later (or cancel on error)=
 either.
> > -      */
> > -     if (mem_cgroup_disabled() || !memcg ||
> > -             !cgroup_subsys_on_dfl(memory_cgrp_subsys) || !memcg_accou=
nts_hugetlb())
> > +     struct mem_cgroup *memcg =3D get_mem_cgroup_from_current();
>
> Leaking the above reference in error paths.
>

Hello Shakeel,

Thank you for your feedback on this patch. I will implement the changes you
mentioned in both patches. As for the comment on the other patch about
replacing the accounting check in mem_cgroup_hugetlb_try_charge,
I think this makes more sense. I will move the code from this patch to
the first.

Thank you again, have a great day!
Joshua

