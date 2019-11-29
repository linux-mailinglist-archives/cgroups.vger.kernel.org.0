Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0D110D1C3
	for <lists+cgroups@lfdr.de>; Fri, 29 Nov 2019 08:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfK2HSc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Nov 2019 02:18:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54543 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfK2HSb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Nov 2019 02:18:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so12995254wmj.4
        for <cgroups@vger.kernel.org>; Thu, 28 Nov 2019 23:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tkeRI2yNVRyfmG+HaLVXwFnLxkVjrmIZNI8y9X6UAY0=;
        b=a3EfmTdZwnX8sB+JVaRBSQ/mLoNcsXV7erm4NRvfI36MMemPkiPg8g+UQJKe8tfrkR
         lk8HbZY655P4W+5GQgWS5EcElRLTOqRB3h6okLDUw5j3iLYQgVenVOFuuE8dzBjkPlaG
         Nasc8+UnfNjgPmTt04pDG37HpwgQGyARGlUKpg/G4njgOxyxFIOgbegUbAJKkwpg6iIS
         lQQyTyZcymoFGLYX9HNQeiQhQO2yatTTK1hV/T8ouwwaGGfjBCniqjW8OMDn+g3knRkp
         yhhZo7AYsShmOnABthUFBvWrIdJYxcRofbztlDO7MXL8JhJxxuy1uVSxf3Rbv28KJKFK
         oAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tkeRI2yNVRyfmG+HaLVXwFnLxkVjrmIZNI8y9X6UAY0=;
        b=o8BF7l2wdWwhWHNBt3Vm0Tk0C1Mnb5XehUqOmIC1BEQuzIYD0X8/yPWalieV+YEQTy
         XHmUx0J/K1v+/jteuDexm4GVOHMnhE7Q/nnVtJ7Zfc2CypKcjLOsN/HqVTfOZtMbj9FU
         W2rvynMgcC3aSNQCgOCZ4+Np/4BZOvkRe+C3UoW4b8Oj6e4eSR9TNNon4zeEwSkCJdWD
         GIOHHRGdeyXRpYuHKhnsKpfrChrmyKqsT7pimQYqABY11cbQ716MD4az93H20IssKJz5
         0fATvYs0Sg7puf9UyhXMQZDq1IJuvEDM4+EN8OYZ9JrpXAQC1QoAE26lDCpDBKp+L9Pj
         VPZg==
X-Gm-Message-State: APjAAAUQcdjXGM60FUNBMQdvp+3ulq6OYSDylHRzM9W1RDiHqC6LSHpz
        K7cG/WB6t6Tk1eKe2E7D+c8tkSPC5/pIE4RD1W8=
X-Google-Smtp-Source: APXvYqzT32qHBZuzjCjX33Dg4+GU6F5DyFwzn3B8bpFRr4BM0kkJOpw1uOFVI1WyG4NlW0pdHQwEJTYh54sxKRLk2as=
X-Received: by 2002:a1c:5603:: with SMTP id k3mr13924771wmb.150.1575011907203;
 Thu, 28 Nov 2019 23:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20190829060533.32315-1-Kenny.Ho@amd.com> <20190829060533.32315-8-Kenny.Ho@amd.com>
 <20191001142957.GK6694@blackbody.suse.cz>
In-Reply-To: <20191001142957.GK6694@blackbody.suse.cz>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 29 Nov 2019 02:18:15 -0500
Message-ID: <CAOWid-diGR6bkygGO7gMQauNSCApxFwgYPunHGWGTXFKV8KkJg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 07/16] drm, cgroup: Add total GEM buffer allocation limit
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Kenny Ho <Kenny.Ho@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com, Daniel Vetter <daniel@ffwll.ch>,
        Tejun Heo <tj@kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 1, 2019 at 10:30 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
> On Thu, Aug 29, 2019 at 02:05:24AM -0400, Kenny Ho <Kenny.Ho@amd.com> wro=
te:
> > drm.buffer.default
> >         A read-only flat-keyed file which exists on the root cgroup.
> >         Each entry is keyed by the drm device's major:minor.
> >
> >         Default limits on the total GEM buffer allocation in bytes.
> What is the purpose of this attribute (and alikes for other resources)?
> I can't see it being set differently but S64_MAX in
> drmcg_device_early_init.

cgroup has a number of conventions and one of which is the idea of a
default.  The idea here is to allow for device specific defaults.  For
this specific resource, I can probably not expose it since it's not
particularly useful, but for other resources (such as the lgpu
resource) the concept of a default is useful (for example, different
devices can have different number of lgpu.)


> > +static ssize_t drmcg_limit_write(struct kernfs_open_file *of, char *bu=
f,
> > [...]
> > +             switch (type) {
> > +             case DRMCG_TYPE_BO_TOTAL:
> > +                     p_max =3D parent =3D=3D NULL ? S64_MAX :
> > +                             parent->dev_resources[minor]->
> > +                             bo_limits_total_allocated;
> > +
> > +                     rc =3D drmcg_process_limit_s64_val(sattr, true,
> > +                             props->bo_limits_total_allocated_default,
> > +                             p_max,
> > +                             &val);
> IIUC, this allows initiating the particular limit value based either on
> parent or the default per-device value. This is alas rather an
> antipattern. The most stringent limit on the path from a cgroup to the
> root should be applied at the charging time. However, the child should
> not inherit the verbatim value from the parent (may race with parent and
> it won't be updated upon parent change).
I think this was a mistake during one of my refactor and I shrunk the
critical section protected by a mutex a bit too much.  But you are
right in the sense that I don't propagate the limits downward to the
children when the parent's limit is updated.  But from the user
interface perspective, wouldn't this be confusing?  When a sysadmin
sets a limit using the 'max' keyword, the value would be a global one
even though the actual allowable maximum for the particular cgroup is
less in reality because of the ancestor cgroups?  (If this is the
established norm, I am ok to go along but seems confusing to me.)  I
am probably missing something because as I implemented this, the 'max'
and 'default' semantic has been confusing to me especially for the
children cgroups due to the context of the ancestors.

> You already do the appropriate hierarchical check in
> drmcg_try_chb_bo_alloc, so the parent propagation could be simply
> dropped if I'm not mistaken.
I will need to double check.  But I think interaction between parent
and children (or perhaps between siblings) will be needed eventually
because there seems to be a desire to implement "weight" type of
resource.  Also, from performance perspective, wouldn't it make more
sense to make sure the limits are set correctly during configuration
than to have to check all the cgroups up through the parents?  I don't
have comprehensive knowledge of the implementation of other cgroup
controllers so if more experience folks can comment that would be
great.  (Although, I probably should just do one approach instead of
doing both... or 1.5.)

>
> Also, I can't find how the read of
> parent->dev_resources[minor]->bo_limits_total_allocated and its
> concurrent update are synchronized (i.e. someone writing
> buffer.total.max for parent and child in parallel). (It may just my
> oversight.)
This is probably the refactor mistake I mentioned earlier.

Regards,
Kenny
