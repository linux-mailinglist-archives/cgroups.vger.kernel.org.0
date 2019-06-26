Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0665725E
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 22:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfFZUMq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 16:12:46 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40373 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZUMq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 16:12:46 -0400
Received: by mail-oi1-f196.google.com with SMTP id w196so100220oie.7
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 13:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Tdf+fLcwGtXw/pR+VztI7GnuPqHyZkqUUhbwkDx/+Q=;
        b=gJyA30Ula6v92KNUAW91AK4cD/ciKwyoXJ7oztHBTYS+ivR6VN2hajT9THs4YOcvcO
         ytpiKnO2h6oFuVgxTViEk2DIpTZo0W5GDjG+0MSIPMihN5NVqRDsiVIxYJWzVmtcvHsd
         BumB0KOcnqua9BZxG9qOpc6T7/DMf/8YCiYB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Tdf+fLcwGtXw/pR+VztI7GnuPqHyZkqUUhbwkDx/+Q=;
        b=NQIcJsCgpVc5uk+2rAvDcxBS8gtd/wRwBdsx+/uXhuTzFAh3NsbmOhs2F2fTpRw/Sg
         V59GnlfvjhIF4TSs6WndaSY0qC/cu+5WUTxhryrAxik4lxugBzF4Xkq2KuvNuwPMo2+S
         RCuqdKdCXTyYvlz2RCDM7Bnt4fqrqUJszMw1CeYZqW3LNpRGiCbwlr3MyID5EGl/fZcV
         GrIS7yusftGYWaIygoa0uTS9BRPoxeTR3QlxS1nTccgJtpxcnjNMoxnorl/v7KC9B+g4
         /ASZ1jrkOmR4CRaHjOOkEwgx2XcN5ooYHAtfWK3de++f4w5YYkxk07vE4//zVhqrdVYg
         aAww==
X-Gm-Message-State: APjAAAVsfVbZnupU9adUPpDkCdgI1OzvpHp+yeGn0hV40N/W5tazIVgJ
        pqndaO2QCYTEmI1u0trC55GQ1SPI2NX06A8/W4d8Bg==
X-Google-Smtp-Source: APXvYqxuKEUl7mQ4aRONGVPnVlpEBgKCK1RTN9RtN03ZPBRixfIqEZ3fWzSrhKyttyGimchD/szuveKezD/aUmDDhKA=
X-Received: by 2002:a05:6808:118:: with SMTP id b24mr138245oie.128.1561579965393;
 Wed, 26 Jun 2019 13:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com> <20190626150522.11618-2-Kenny.Ho@amd.com>
 <20190626154929.GP12905@phenom.ffwll.local> <CAOWid-dyGwf=e0ikBEQ=bnVM_bC8-FeTOD8fJVMJKUgPv6vtyw@mail.gmail.com>
In-Reply-To: <CAOWid-dyGwf=e0ikBEQ=bnVM_bC8-FeTOD8fJVMJKUgPv6vtyw@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 26 Jun 2019 22:12:34 +0200
Message-ID: <CAKMK7uEpxbu-mACYxrskvCoktDeJ6+ckZvPkSAsXFtdz_h_8EA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/11] cgroup: Introduce cgroup for drm subsystem
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 9:35 PM Kenny Ho <y2kenny@gmail.com> wrote:
>
> On Wed, Jun 26, 2019 at 11:49 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > Bunch of naming bikesheds
>
> I appreciate the suggestions, naming is hard :).
>
> > > +#include <linux/cgroup.h>
> > > +
> > > +struct drmcgrp {
> >
> > drm_cgroup for more consistency how we usually call these things.
>
> I was hoping to keep the symbol short if possible.  I started with
> drmcg (following blkcg),  but I believe that causes confusion with
> other aspect of the drm subsystem.  I don't have too strong of an
> opinion on this but I'd prefer not needing to keep refactoring.  So if
> there are other opinions on this, please speak up.

I think drmcg sounds good to me. That aligns at least with memcg,
blkcg in cgroups, so as good reason as any. drmcgrp just felt kinda
awkward in-between solution, not as easy to read as drm_cgroup, but
also not as short as drmcg and cgrp is just letter jumbo I can never
remember anyway what it means :-)
-Daniel

> > > +
> > > +static inline void put_drmcgrp(struct drmcgrp *drmcgrp)
> >
> > In drm we generally put _get/_put at the end, cgroup seems to do the same.
>
> ok, I will refactor.
>
> > > +{
> > > +     if (drmcgrp)
> > > +             css_put(&drmcgrp->css);
> > > +}
> > > +
> > > +static inline struct drmcgrp *parent_drmcgrp(struct drmcgrp *cg)
> >
> > I'd also call this drm_cgroup_parent or so.
> >
> > Also all the above needs a bit of nice kerneldoc for the final version.
> > -Daniel
>
> Noted, will do, thanks.
>
> Regards,
> Kenny



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
