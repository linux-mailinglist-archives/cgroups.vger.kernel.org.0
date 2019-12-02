Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D12A10EFE3
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2019 20:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfLBTOk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Dec 2019 14:14:40 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:46031 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbfLBTOk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Dec 2019 14:14:40 -0500
Received: by mail-qv1-f68.google.com with SMTP id c2so299903qvp.12
        for <cgroups@vger.kernel.org>; Mon, 02 Dec 2019 11:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QIwY2zPo3ipb4HjrxhdMR+nMxJM+BtZphU9RF6iDWeU=;
        b=TvFns/ZrhMMvvKw4xSqFeBbOm3xLJ3LdC6WG77/3x7nQJkVazjKafuDUdNO3tPdkaO
         IQvLpcGQEQTu78eLkQoY8CGRR6caHMUmy6qEsLPEft/bCWZDOq9N+YJI38GxygJ2cYvV
         RxQqhCUY1Y+DRbLvhZeC6pM2z1GPCGD2QTHqbV5o6E/59krKxPT9+j58A4d0jQXUB/f8
         WmSZ12On6OUXjzH9ukX0PHCRsSWWwO7wG54OlDFXhSr8ICv5ELG0PN+lzC//7iGoRFOU
         CVsyBKPlob68Fwwo3yeQoEawwG+GB4rSmQu9N611J3VlVvJD8BH+HR3XMgro8itIVVrR
         aKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QIwY2zPo3ipb4HjrxhdMR+nMxJM+BtZphU9RF6iDWeU=;
        b=YTSUC1a1jn0oG3M7pmcNxgWpBZVYFMOVkr3DJ+bs3QDjzIficIw3rmOFYBDvuPCXvn
         MHJc2a6H8kSgGmFLrgwzFzTtMfgtmz4fcrGpPhZBpDQont02/lJEgNVukz7qC2X3IGFN
         SGmBLeoG7mZhv1jgaBD80sv7w8bLgVuocapb+7Khk4taIaaBSlfndI6sX1S6Cz9GFxMD
         z7r0n0Z8l0saIU0g9g2Gf80KHriJpTaQ1F728ChZr1Hok5cJWWvqInYayBMrkUZfUDXy
         h2iugzjChrnWTVXF20K7Iij85e2Py+JkbTG/jec6SB0FiaO2TFsYkha6d/mkrSQbNIie
         jIpA==
X-Gm-Message-State: APjAAAX42wNTw+3uAqABoXeYSHxz0MjmLQH2ZMkdD63DFiEE/aL3hoL+
        BydghWGZnIfjnHkxfF9s9o0=
X-Google-Smtp-Source: APXvYqxlV4KPPBpwnmKUj99p+IArO+a+uhEWMvRZMhQZytthgNgfB57f9MGSo2YD2rbVnoE4GYregw==
X-Received: by 2002:a05:6214:1709:: with SMTP id db9mr711187qvb.68.1575314079340;
        Mon, 02 Dec 2019 11:14:39 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:c909])
        by smtp.gmail.com with ESMTPSA id i17sm231520qtm.53.2019.12.02.11.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 11:14:38 -0800 (PST)
Date:   Mon, 2 Dec 2019 11:14:36 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Kenny Ho <Kenny.Ho@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com, Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH RFC v4 02/16] cgroup: Introduce cgroup for drm subsystem
Message-ID: <20191202191436.GG16681@devbig004.ftw2.facebook.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190829060533.32315-3-Kenny.Ho@amd.com>
 <20191001143106.GA4749@blackbody.suse.cz>
 <CAOWid-ewvs-c-z_WW+Cx=Jaf0p8ZAwkWCkq2E8Xkj+2HvfNjaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOWid-ewvs-c-z_WW+Cx=Jaf0p8ZAwkWCkq2E8Xkj+2HvfNjaA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 29, 2019 at 01:00:36AM -0500, Kenny Ho wrote:
> On Tue, Oct 1, 2019 at 10:31 AM Michal Koutný <mkoutny@suse.com> wrote:
> > On Thu, Aug 29, 2019 at 02:05:19AM -0400, Kenny Ho <Kenny.Ho@amd.com> wrote:
> > > +struct cgroup_subsys drm_cgrp_subsys = {
> > > +     .css_alloc      = drmcg_css_alloc,
> > > +     .css_free       = drmcg_css_free,
> > > +     .early_init     = false,
> > > +     .legacy_cftypes = files,
> > Do you really want to expose the DRM controller on v1 hierarchies (where
> > threads of one process can be in different cgroups, or children cgroups
> > compete with their parents)?
> 
> (Sorry for the delay, I have been distracted by something else.)
> Yes, I am hoping to make the functionality as widely available as
> possible since the ecosystem is still transitioning to v2.  Do you see
> inherent problem with this approach?

Integrating with memcg could be more challenging on cgroup1.  That's
one of the reasons why e.g. cgroup-aware pagecache writeback is only
on cgroup2.

-- 
tejun
