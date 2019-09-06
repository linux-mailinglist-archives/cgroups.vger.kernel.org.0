Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFCDCABCB2
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2019 17:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404974AbfIFPiy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Sep 2019 11:38:54 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39399 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404930AbfIFPiy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Sep 2019 11:38:54 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so6010760qki.6
        for <cgroups@vger.kernel.org>; Fri, 06 Sep 2019 08:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IfEA3mYf468EoRCLgCuICwMuS6+N1Np5xB000oVK2PY=;
        b=UHqDdPUbhmJl/liWV/vdWohn99T8cEN8CSdvJiDh3FkPJTs2NcuPaTj6XoKSZW60gD
         CY9TO9zm+/2VlkWn3kisviE60JrswKHcXVLhWL4UkP5+G9+wjUA0sgzW65JNwAA+6lF8
         PEJ9aPbLOWwJjYVRO5CNK+ZgASCWdlmVXUe2CRKfF4BDFAat9/+FIDUqrht1n/3Avu5p
         6UNDrjA8ITaPD28ZJEQdtJ1wcpkXEAdEXKN76MpyNfuFBiGPQ7S2yV9E1W+MyKS6Ub1c
         bRdpSUCerFi97U3jG15d4bV4AcgtaGwtvKjflXscvy0rpoGzmns/jAPB6UaIktQOkETM
         KBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IfEA3mYf468EoRCLgCuICwMuS6+N1Np5xB000oVK2PY=;
        b=azHRZB5IFn0NnFlbMJGNNodXNGk57xIgOVGhy/KTyIQE8+Y9ACG9Oaj4LypLHDKbD0
         v9jaHym2RqXq8B4jchj2nwsNL9EJ2XrDTIriYydggnbdg+TbzRhmC8wuvfdsZQpO1mEZ
         DWu8NyDKVuSCKvz3HbfSIhvxomPeMHlOwZsX8y57vgCo3GYlcJr+nfRGKMuYmiioDxJt
         5cLzmyc2f3HdEzZ9Z6vRieVVCjrZOkOe1IUxPo9x73A0a9dfaKOd/187v/d1ZtnusOyK
         +sl0rbMW8ryfeB+OKXYbv7unVHX4Gwc05LEU/bxvU0igd7oTb/YV5ftUXRa3DV+HYmVL
         QZ6Q==
X-Gm-Message-State: APjAAAWKxASbFbLOQU1c9KbLo6HQhPeA3jIGjyBqln8VL8BQPl9ciso3
        o/HrfFjfSoM8Kx5KQEK73dNIlBHZvhc=
X-Google-Smtp-Source: APXvYqxYhuc7ftHE4EyK+xubhMWGCo+lI3aMyvBILLGMbAXC9NCNN/ngV096ExeZiRtdj/MUEPI13A==
X-Received: by 2002:a05:620a:12af:: with SMTP id x15mr9275261qki.148.1567784333465;
        Fri, 06 Sep 2019 08:38:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e7cb])
        by smtp.gmail.com with ESMTPSA id x33sm670379qtd.79.2019.09.06.08.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:38:52 -0700 (PDT)
Date:   Fri, 6 Sep 2019 08:38:51 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kenny Ho <y2kenny@gmail.com>, Kenny Ho <Kenny.Ho@amd.com>,
        cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com
Subject: Re: [PATCH RFC v4 01/16] drm: Add drm_minor_for_each
Message-ID: <20190906153851.GO2263813@devbig004.ftw2.facebook.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190829060533.32315-2-Kenny.Ho@amd.com>
 <20190903075719.GK2112@phenom.ffwll.local>
 <CAOWid-dxxDhyxP2+0R0oKAk29rR-1TbMyhshR1+gbcpGJCAW6g@mail.gmail.com>
 <CAKMK7uEofjdVURu+meonh_YdV5eX8vfNALkW3A_+kLapCV8j+w@mail.gmail.com>
 <CAOWid-eUVztW4hNVpznnJRcwHcjCirGL2aS75p4OY8XoGuJqUg@mail.gmail.com>
 <20190904085434.GF2112@phenom.ffwll.local>
 <20190906152925.GN2263813@devbig004.ftw2.facebook.com>
 <CAKMK7uFQqAMB1DbiEy-o2bzr_F25My93imNcg1Qh9DHe=uWQug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFQqAMB1DbiEy-o2bzr_F25My93imNcg1Qh9DHe=uWQug@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Daniel.

On Fri, Sep 06, 2019 at 05:36:02PM +0200, Daniel Vetter wrote:
> Block devices are a great example I think. How do you handle the
> partitions on that? For drm we also have a main minor interface, and

cgroup IO controllers only distribute hardware IO capacity and are
blind to partitions.  As there's always the whole device MAJ:MIN for
block devices, we only use that.

> then the render-only interface on drivers that support it. So if blkcg
> handles that by only exposing the primary maj:min pair, I think we can
> go with that and it's all nicely consistent.

Ah yeah, that sounds equivalent.  Great.

Thanks.

-- 
tejun
