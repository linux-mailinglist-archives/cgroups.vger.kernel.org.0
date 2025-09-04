Return-Path: <cgroups+bounces-9690-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50960B42FB9
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 04:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E1D3B0E4B
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 02:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10E61FF1C4;
	Thu,  4 Sep 2025 02:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaqggoCI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF781F8691
	for <cgroups@vger.kernel.org>; Thu,  4 Sep 2025 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952528; cv=none; b=H0vNW0GGxIb9TkQD+bFgJVenE3ekDG1lkqj7wVH7Cw1N3Ux4PfmX7wrdZ2AmXISICB8XUUkk9PlgLQqIgS3VUsTPm3QwtdBhm0Ev83UXlatwvKpaL01vDF3GQD+3zrHBvn7wRyC4g1UxXe6QPevPI9hdQZAEl/7DO51z1TPPrmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952528; c=relaxed/simple;
	bh=A2GlZNRYtfxOum4TwwmFXfFcVX0AQ1b9mpTZT4MuB2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJKK38VSw6BOXnHxoLjFR24dVx121aM3zM4/osm+pFe0FFKEOFNOzjJTKmqfXWi7PM9ld/EWOfhBFuZgFrAz47ydp0kQ/8WIqtFDNb5W4gOT9FAL2VomL/A3siIOmY5XtAydg/5B6Z72XXmVN1RcT8RXCRfK3Bo81Mvh7CzLa7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaqggoCI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afec5651966so104128666b.2
        for <cgroups@vger.kernel.org>; Wed, 03 Sep 2025 19:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952525; x=1757557325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXVSLMWASFD03eCh7RAZNIgqIvAhKcab9R9R5MJY7EU=;
        b=RaqggoCItdiyDYTOCx1F//rbYgc2qSDcKhm/vJN5Ti8beywMluGygE84JAzL4rD/0S
         0+TBoAdesS78ozLu3n5GiyUVc6JwtnK+yyWb0vGE2P6g+7ejecKQXxrvHjBF3U8Id4OP
         A/EOIkmeQOl5VuLjdAdsTCz9VJZiMAihSA+N1MaHt6sjqsEtwypgDEbWNZsG/FsV4ceo
         +HfjUk7Ht5iuUqGcBVimEVdpzSll74TulvDsdarFlP+5RaaVScPjI38GkpWK2eCT+9gJ
         i+av+D/JYxWlR8tIyI+cGuirRHbYgbbTqKAJUlVjZ4bulvUMkbhf8Yv55XUQvM2bb5yX
         Ocmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952525; x=1757557325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXVSLMWASFD03eCh7RAZNIgqIvAhKcab9R9R5MJY7EU=;
        b=JFvoQs+Lrkfnt/AqbSevNVI/iSGs8JLK6bE0xryesxBhFmoBjp0flIL2WDuzSpqZy1
         nNRmZ+HgtnbX1I5vAVR27Nre5QIm4X2BevmyC5N6ZwFgOuoZ5DCPom8MVJeKpU+/LwPM
         VE93eGF71tC5W0nUqOL+0uVIUFs2xnEDhKYF8bR1J2MXcWT3D6w1ONFWfmymrd0pd+vQ
         jvQdnJZMNLVIB0sdRCDlpWVX8dowodWUtmucrEwAgh+zWGhQ5yUlAhpEyAzA0Rh6tgQs
         wwuOO2sa47KsedlFHCYW3d5MiNEFRv4QD1YD5cD5Y23JfAP8MGS7H4Pow+LMoIb/azko
         sP6A==
X-Forwarded-Encrypted: i=1; AJvYcCXi4+calsWJ1yBozmjLr4gwJTANx0RJEq5Jv8P1UggDxyzN7xt5fz31OmmTpklCghdojYfq1Hup@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ9+zYq2Pxd3VJBOqMBTWGIsmso5D8yRtv8USGL1h+S6CQ/mOa
	e1n8hMBolSlmnisXjFLgcRtAvYH1bTraqCSoR7a0hafIjm/OQzieiedl5Hk4cazHd3wTgyC/j1T
	aulgomzNWnvNDmUQ281PbAXWxmqNj0jQ=
X-Gm-Gg: ASbGnctlciI6pR6tqigfg3WMYAaY+VgE5Suk+SN9Eqe/etURTNrPhA5rXOmeIyAa0sH
	wc7Kmw77Yz+AIKKmzHzvZub6yc7k6gG/M8vPecdrwgb6HCcKwP1KtZoS6usMB+EyXwCS9CILAX8
	5X7/omgbg+zuK06pno/B20x6Qv9BpnOjpIvDUhdrxUJoBoqgN9jlA0r0jWaMZkfGvTsZKOjqiLh
	kXVfg==
X-Google-Smtp-Source: AGHT+IEcqmtj81HfK+9kHhNiA6AXxxKlsMDqPVXZRpbMNel0k6GBh80LEZ+J24B+dPaLV1bTxSagay7ZwP49Lkj+V20=
X-Received: by 2002:a17:906:f596:b0:b04:65b4:707 with SMTP id
 a640c23a62f3a-b0465b40b24mr528466666b.13.1756952525112; Wed, 03 Sep 2025
 19:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902041024.2040450-1-airlied@gmail.com> <20250902041024.2040450-10-airlied@gmail.com>
 <e1507242-952c-4131-93e1-6af52760b283@amd.com>
In-Reply-To: <e1507242-952c-4131-93e1-6af52760b283@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 4 Sep 2025 12:21:53 +1000
X-Gm-Features: Ac12FXwW1MaD_A4-ok2fSvRkEovDekWEGy5dDSEU50r6EOTRHxe79q64hkc2Qto
Message-ID: <CAPM=9txo88E9y96w1Ti5hXC322HVRDhD18CrmBj8zse8Xx=V4Q@mail.gmail.com>
Subject: Re: [PATCH 09/15] ttm/pool: initialise the shrinker earlier
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>, Waiman Long <longman@redhat.com>, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Sept 2025 at 00:07, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
>
>
> On 02.09.25 06:06, Dave Airlie wrote:
> > From: Dave Airlie <airlied@redhat.com>
> >
> > Later memcg enablement needs the shrinker initialised before the list l=
ru,
> > Just move it for now.
>
> Hui? That should just be the other way around.
>
> The shrinker depends on the list lru and so needs to come after ttm_pool_=
type_init() and not before.

list_lru_init_memcg needs to take a registered shrinker as an
argument, also the shrinker list is locked so this is fine, if we get
called to shrinker before ttm_pool_type_init happens, shrinker_scan
will have 0 pools.

Dave.

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Dave Airlie <airlied@redhat.com>
> > ---
> >  drivers/gpu/drm/ttm/ttm_pool.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_p=
ool.c
> > index 9a8b4f824bc1..2c9969de7517 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -1381,6 +1381,17 @@ int ttm_pool_mgr_init(unsigned long num_pages)
> >       spin_lock_init(&shrinker_lock);
> >       INIT_LIST_HEAD(&shrinker_list);
> >
> > +     mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool=
");
> > +     if (!mm_shrinker)
> > +             return -ENOMEM;
> > +
> > +     mm_shrinker->count_objects =3D ttm_pool_shrinker_count;
> > +     mm_shrinker->scan_objects =3D ttm_pool_shrinker_scan;
> > +     mm_shrinker->batch =3D TTM_SHRINKER_BATCH;
> > +     mm_shrinker->seeks =3D 1;
> > +
> > +     shrinker_register(mm_shrinker);
> > +
> >       for (i =3D 0; i < NR_PAGE_ORDERS; ++i) {
> >               ttm_pool_type_init(&global_write_combined[i], NULL,
> >                                  ttm_write_combined, i);
> > @@ -1403,17 +1414,6 @@ int ttm_pool_mgr_init(unsigned long num_pages)
> >  #endif
> >  #endif
> >
> > -     mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool=
");
> > -     if (!mm_shrinker)
> > -             return -ENOMEM;
> > -
> > -     mm_shrinker->count_objects =3D ttm_pool_shrinker_count;
> > -     mm_shrinker->scan_objects =3D ttm_pool_shrinker_scan;
> > -     mm_shrinker->batch =3D TTM_SHRINKER_BATCH;
> > -     mm_shrinker->seeks =3D 1;
> > -
> > -     shrinker_register(mm_shrinker);
> > -
> >       return 0;
> >  }
> >
>

