Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC59AEF14
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2019 18:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388927AbfIJQDe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Sep 2019 12:03:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34088 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732013AbfIJQDe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Sep 2019 12:03:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id j1so8630606qth.1
        for <cgroups@vger.kernel.org>; Tue, 10 Sep 2019 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7aIOX124CvBDQ+soNFV0AIGLUFHPyLLvAhmjlVF2WPk=;
        b=VqkWghjlkTpH+A8hE16ODggPKsNxNZPC2yhI1hjp84XcqzJbGwKU6z8oknVnI7TadB
         PHemMFbHH5gvsYBqcWlvRyRxP4VRQ3tpv8Q8FV/8k0cwe9Gs9BHCFpHFy1pVKBlSKOQr
         5Sky68xI/IuGVVBezT7cYQo4JOmj/9g/gWri1H3bfoKG+F/gRyw5my6rpbxMkPN7+DlO
         uKDrPZ9958F75rMuAIQ2BXJLAznPnFZUPvnKoQrBSmmopoOxVILteEphyDO7v4gWhGwR
         E47gNFbPptPrTFOAtK4SexBzeZN9jrwYCatSt1d+mXYimj1UDBzcH1LZ2YuZrwi4OHd9
         1zfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7aIOX124CvBDQ+soNFV0AIGLUFHPyLLvAhmjlVF2WPk=;
        b=WKnDLLcuiFiTF27w39l1YlUSKKCxB3O0LMz7R5uKPh2fQnyhRrVeH0i67Q3LSuppRF
         5U8jUDiCyTQQvWyrEP8YwMGYN3KVRF/mMbYvIRwSbhm26Onrv7tMLUKvU3Uch3c4wwX9
         PmnoRmmfd7pTXR6D/AsHkDJTgzF/oKE819BBZOgGlwo/NwP20DKeYXt4E5cc1zOS2day
         UZc+imqcu6K6m2HfUKtYja6I5wWOiCl7aUx59M/NvpmwSHxLPh1mrLmTau+K4xyUJUdD
         YZLWciHxihFKcrxCCnzH2ZZe61XmEsvjDViMIzX4+mrRBVEfq54tAHd40Fx5kr2QOlu0
         ZgRA==
X-Gm-Message-State: APjAAAUsvTSuJCYucOd+krjYW8P4cG81znCmPJ0vD/7n9qp3kdDcJ7/M
        zm6vFi6ihZuj/cUC4lYCipwpDLr3NOU=
X-Google-Smtp-Source: APXvYqx5gqcyO2isFyQIcHOc2o+DcKf/TqnH/zbLgQZA4VElls50DS+7LNJQCVGNDmDZFbFJ4RCP6Q==
X-Received: by 2002:aed:2d67:: with SMTP id h94mr29270980qtd.63.1568131413281;
        Tue, 10 Sep 2019 09:03:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:f049])
        by smtp.gmail.com with ESMTPSA id e17sm9285328qkn.61.2019.09.10.09.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 09:03:32 -0700 (PDT)
Date:   Tue, 10 Sep 2019 09:03:29 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Kenny Ho <Kenny.Ho@amd.com>,
        Kenny Ho <y2kenny@gmail.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com
Subject: Re: [PATCH RFC v4 00/16] new cgroup controller for gpu/drm subsystem
Message-ID: <20190910160329.GR2263813@devbig004.ftw2.facebook.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190831042857.GD2263813@devbig004.ftw2.facebook.com>
 <20190903075550.GJ2112@phenom.ffwll.local>
 <20190903185013.GI2263813@devbig004.ftw2.facebook.com>
 <CAKMK7uE5Bj-3cJH895iqnLpwUV+GBDM1Y=n4Z4A3xervMdJKXg@mail.gmail.com>
 <20190906152320.GM2263813@devbig004.ftw2.facebook.com>
 <CAKMK7uEXP7XLFB2aFU6+E0TH_DepFRkfCoKoHwkXtjZRDyhHig@mail.gmail.com>
 <20190906154539.GP2263813@devbig004.ftw2.facebook.com>
 <20190910115448.GT2063@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910115448.GT2063@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Michal.

On Tue, Sep 10, 2019 at 01:54:48PM +0200, Michal Hocko wrote:
> > So, while it'd great to have shrinkers in the longer term, it's not a
> > strict requirement to be accounted in memcg.  It already accounts a
> > lot of memory which isn't reclaimable (a lot of slabs and socket
> > buffer).
> 
> Yeah, having a shrinker is preferred but the memory should better be
> reclaimable in some form. If not by any other means then at least bound
> to a user process context so that it goes away with a task being killed
> by the OOM killer. If that is not the case then we cannot really charge
> it because then the memcg controller is of no use. We can tolerate it to
> some degree if the amount of memory charged like that is negligible to
> the overall size. But from the discussion it seems that these buffers
> are really large.

Yeah, oom kills should be able to reduce the usage; however, please
note that tmpfs, among other things, can already escape this
restriction and we can have cgroups which are over max and empty.
It's obviously not ideal but the system doesn't melt down from it
either.

Thanks.

-- 
tejun
