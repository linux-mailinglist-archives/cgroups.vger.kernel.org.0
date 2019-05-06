Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D49015020
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2019 17:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfEFP0s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 May 2019 11:26:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44511 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfEFP0r (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 May 2019 11:26:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id f24so4727678qtk.11
        for <cgroups@vger.kernel.org>; Mon, 06 May 2019 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uVcv5gxrx40HJxyOUvgx5wp3GUe3viewKvbzXFxWMGA=;
        b=kNAXGCHsJPJnSk1S+4Hg/yKLjuRyBetqYMtBT4XmcSvlaOngptLrBWAWSQgoiqt+qq
         SlmbaADYeoYs2HfxS6UfWLFGyn8M5xuWu3n6EixHYBJ7Gbt5FyiiTq1EeX3gA8bm+vak
         jGFJgpYrd9GmbR569UqwHwe6z7q0mSq57UIqZIu1f8aKEdr+dnd2zPk9D2fuR4/HHY/M
         hdOcV1rZ8Mincs1oNYqCdEsT9K3Fx5V2Oapm7YyfGJbMXdGnDdHgrPBrWz8DZQVWxEom
         aWp1VeBzaYII8ABKROan48kPGryi+mfYPaTQxA8d9J0qvZZKV73Y2vluuRgVTcnEq0i4
         ldKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uVcv5gxrx40HJxyOUvgx5wp3GUe3viewKvbzXFxWMGA=;
        b=VLxA7mpbI2JcAswDZqjKnYSI8Y3+5i533Dz+zlqa2tCcWJfmTqIUmSSXiBtHDUlgfn
         Ue5oprl5inMLx3nbTd6c3EDRJmAberDF1sYCEKEdrFHsHPwZzbBlawbWO3CpRLz/jeFz
         c+HpnFHgqODXES0zaOHssY28DDcWEKjTbW6vIpY8HFKEA/nsZrlvS55L99DJDtuem2cp
         h5MHqq3eRoNcQoMs5OSDOsJn/GpQckOMFLGYYISwrK2UsiA8uzzteBIL1oVqJRtQ+P6B
         7KmeZWU8ZjKyKFhu6aJChjlxKodaVUKJ/W6Rvmbfi4PttP6dnSKwEqdnWQr2M+vFFlfB
         OWUA==
X-Gm-Message-State: APjAAAUbzFzjJA6NIFEs0IQ4ELH/W/JsjFInxZm9PLjOworN05biAtUA
        wRop5lJIH/TzAd5+8DTw918=
X-Google-Smtp-Source: APXvYqzk+AOzpTMV+J/CSy5XKE9ZdY35ptnyEbfzsCREY2hn/LTfzkX9Rc7uiofd+Noq2KoA0jpolQ==
X-Received: by 2002:a0c:c3d0:: with SMTP id p16mr21166391qvi.229.1557156406665;
        Mon, 06 May 2019 08:26:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:34f3])
        by smtp.gmail.com with ESMTPSA id u2sm6350591qkb.37.2019.05.06.08.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:26:45 -0700 (PDT)
Date:   Mon, 6 May 2019 08:26:43 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Brian Welty <brian.welty@intel.com>
Cc:     cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        ChunMing Zhou <David1.Zhou@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH 0/5] cgroup support for GPU devices
Message-ID: <20190506152643.GL374014@devbig004.ftw2.facebook.com>
References: <20190501140438.9506-1-brian.welty@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501140438.9506-1-brian.welty@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, May 01, 2019 at 10:04:33AM -0400, Brian Welty wrote:
> The patch series enables device drivers to use cgroups to control the
> following resources within a GPU (or other accelerator device):
> *  control allocation of device memory (reuse of memcg)
> and with future work, we could extend to:
> *  track and control share of GPU time (reuse of cpu/cpuacct)
> *  apply mask of allowed execution engines (reuse of cpusets)
> 
> Instead of introducing a new cgroup subsystem for GPU devices, a new
> framework is proposed to allow devices to register with existing cgroup
> controllers, which creates per-device cgroup_subsys_state within the
> cgroup.  This gives device drivers their own private cgroup controls
> (such as memory limits or other parameters) to be applied to device
> resources instead of host system resources.
> Device drivers (GPU or other) are then able to reuse the existing cgroup
> controls, instead of inventing similar ones.

I'm really skeptical about this approach.  When creating resource
controllers, I think what's the most important and challenging is
establishing resource model - what resources are and how they can be
distributed.  This patchset is going the other way around - building
out core infrastructure for bolierplates at a significant risk of
mixing up resource models across different types of resources.

IO controllers already implement per-device controls.  I'd suggest
following the same interface conventions and implementing a dedicated
controller for the subsystem.

Thanks.

-- 
tejun
