Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF1C571D9
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 21:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfFZTfU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 15:35:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33721 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZTfU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 15:35:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so5373155wme.0
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5SrQ5SYua3CBmwCDqScHd2/Bwr4oTQ8I2YEBgR7+gA=;
        b=eMsKc+rnCj8StfekhCHMqWi4SmNhIffQowFbvQPE+yXuPzxz4jp694GIj1LYbyqrtp
         7UQ8vM7QNCfBJ0nAE7gVrTydFflwf2vtINWHN4yYPxc3boYl6W9MdK8TdnqTjGsfc9Kg
         FurBoVhNLd0DKjNzVViMIQlpZbtv2DrP6GgxAgnijbQYsmmKK16K4zE8aL1IKE4Lc+R+
         eyjJZtfCP4Dqiv2LXZ2n+OF7Q2j+CKW+HJarmsrWV1nBjU1Lu8mxjZs9K4TX/ZbWaHRP
         CiKjA6Du28wcuxDpKm6wb1O4aD34efUIp42Ki0iITbQh0IFlpCFJ5djzrAEsNSzcmd8f
         MFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5SrQ5SYua3CBmwCDqScHd2/Bwr4oTQ8I2YEBgR7+gA=;
        b=O1ThRwLngkTtPtacny30QLLmpPLoFxLI3gPvFw5tXVLBWv+DzVLkdJNbmMgfaQdjYk
         RD/0czzxWK3n6kZFsGApxqf3/rt4pEmz2VnRgrEc6Gs66SV992foC25wiEndtBLBs4u3
         fb56RTqNZymcvwAcGteXK9AUDSI0AkIyFGzdr+rrVgbECMM0TcjoYJUR11bZGcAO8TgM
         ZjT8D4E/PZitMRUTVUhI7QFZJMElqsHjbhM0Af4JuvXYz60p8QRv24tkxcnotp+wh4FQ
         RSvEMgkULNdB2bvr5lNygR39E4djawlGlEtnKPxOFQq2eAXblWTo/LcDyupzsbrA4P6/
         YGFA==
X-Gm-Message-State: APjAAAUfcnWZJM4Gv7uetMqsRVxIgWlHEV1SLmcVwqYhweGFs5g1XbKL
        ALSSTB6UYCdBqGAATC6+uo6CalSznZ2ctYbTbBV8jbucym4=
X-Google-Smtp-Source: APXvYqyG8Is/2v0hS1XHLGNtOeXAyVyYv2E23r0Yvate33SClP0PPy8+QLPRF9mvGuAMa/xfdd48bj61kdArq/BDS/A=
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr384737wme.29.1561577718154;
 Wed, 26 Jun 2019 12:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com> <20190626150522.11618-2-Kenny.Ho@amd.com>
 <20190626154929.GP12905@phenom.ffwll.local>
In-Reply-To: <20190626154929.GP12905@phenom.ffwll.local>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Wed, 26 Jun 2019 15:35:06 -0400
Message-ID: <CAOWid-dyGwf=e0ikBEQ=bnVM_bC8-FeTOD8fJVMJKUgPv6vtyw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/11] cgroup: Introduce cgroup for drm subsystem
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 11:49 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> Bunch of naming bikesheds

I appreciate the suggestions, naming is hard :).

> > +#include <linux/cgroup.h>
> > +
> > +struct drmcgrp {
>
> drm_cgroup for more consistency how we usually call these things.

I was hoping to keep the symbol short if possible.  I started with
drmcg (following blkcg),  but I believe that causes confusion with
other aspect of the drm subsystem.  I don't have too strong of an
opinion on this but I'd prefer not needing to keep refactoring.  So if
there are other opinions on this, please speak up.

> > +
> > +static inline void put_drmcgrp(struct drmcgrp *drmcgrp)
>
> In drm we generally put _get/_put at the end, cgroup seems to do the same.

ok, I will refactor.

> > +{
> > +     if (drmcgrp)
> > +             css_put(&drmcgrp->css);
> > +}
> > +
> > +static inline struct drmcgrp *parent_drmcgrp(struct drmcgrp *cg)
>
> I'd also call this drm_cgroup_parent or so.
>
> Also all the above needs a bit of nice kerneldoc for the final version.
> -Daniel

Noted, will do, thanks.

Regards,
Kenny
