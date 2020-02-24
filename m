Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52DFF16AB6A
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2020 17:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgBXQ3J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Feb 2020 11:29:09 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39942 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgBXQ3J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Feb 2020 11:29:09 -0500
Received: by mail-qv1-f65.google.com with SMTP id q9so4378401qvu.7
        for <cgroups@vger.kernel.org>; Mon, 24 Feb 2020 08:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ayL/a+KEUEgG8kUr32wkz/zkDzUV2JeP3xXHo8B3UmY=;
        b=H70cCu9pyk/xG3LyHYdYjgRM9JXlOdn+iavwajhfdD56D1QKqyTUIY2WkWWtme6T0R
         X0EtycCQX0mfKuXRA6ip6+B1shl+Y6MAmt8aVaNkw+P3d2QwiRZOY4VAilSFo2tH6GIQ
         8uEVQQOlAQDRDWY2xyGEK8Q0x9rigYd6AkhIDBvgupLxMxT8V29iDdKekTkoNVIIZNPd
         7015RAXtidGAd5WyQQRSIZmwrkqDA9hCTOs1MQAWoZxLPA70GcMdUahyXRINEk0eQgq/
         9IVdQi0vJuUcoWegqbsfRr+0WWwFJ+hfJsYJI+qic+gun0s6YEN3aVVEXUYixc8DAe2r
         K4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ayL/a+KEUEgG8kUr32wkz/zkDzUV2JeP3xXHo8B3UmY=;
        b=rSosvQbTzxNaxg9rLGWufhCNUPb+4RIpq6AZ6JN8mwyBx6rsCLHOyy4eDPNx21D5SX
         n02iYZEqW1YY3ZupCT6T3xgTJ9e8P8RBNEmIwiXUuJ91kCz6oOv/rMNQiV0nwwhZtEn9
         CNiZ7Y0b4Ro5w92HuGU/MQA7MJDX/MVMH1WR4NEsvdrFZi/Ly64qQKgDpiLkEmUTvoUt
         YMzXC/SjusA6qpQAse8IbGcKL0CgugCAn5VFNpsLCwoEM7WBro8k+l8KFcwyL+IuVspN
         KlNpne68Rp22Y0XM1FPSiZHK3IeWujwpPh26k4Q1vDYaKBX9YsQ7svzLmFyWyZkMzDBY
         jbbw==
X-Gm-Message-State: APjAAAWuK+dljIvUUcLMV44gQXrfxBmEsjloeb10wksrj8oxmw2kbsoP
        GY+q/ZrQZwwZq2sh1lL6sF8BZW1WL4M=
X-Google-Smtp-Source: APXvYqx0pL8vfqPmQyNgg4FDblN91V9G8PXmIWaM6qg3/8YLstc1EGv3MDjK1Z35pn05cPP4mT77ew==
X-Received: by 2002:a0c:ed32:: with SMTP id u18mr45645692qvq.2.1582561748197;
        Mon, 24 Feb 2020 08:29:08 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:e64b])
        by smtp.gmail.com with ESMTPSA id y91sm6291011qtd.13.2020.02.24.08.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 08:29:07 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:29:06 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Qian Cai <cai@lca.pw>
Cc:     tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: fix psi_show() crash on 32bit ino archs
Message-ID: <20200224162906.GB1674@cmpxchg.org>
References: <20200224030007.3990-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224030007.3990-1-cai@lca.pw>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Feb 23, 2020 at 10:00:07PM -0500, Qian Cai wrote:
> Similar to the commit d7495343228f ("cgroup: fix incorrect
> WARN_ON_ONCE() in cgroup_setup_root()"), cgroup_id(root_cgrp) does not
> equal to 1 on 32bit ino archs which triggers all sorts of issues with
> psi_show() on s390x. For example,
> 
>  BUG: KASAN: slab-out-of-bounds in collect_percpu_times+0x2d0/
>  Read of size 4 at addr 000000001e0ce000 by task read_all/3667
>  collect_percpu_times+0x2d0/0x798
>  psi_show+0x7c/0x2a8
>  seq_read+0x2ac/0x830
>  vfs_read+0x92/0x150
>  ksys_read+0xe2/0x188
>  system_call+0xd8/0x2b4
> 
> Fix it by using cgroup_ino().
> 
> Fixes: 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID")
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
