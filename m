Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1D0D464D
	for <lists+cgroups@lfdr.de>; Fri, 11 Oct 2019 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfJKRMv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Oct 2019 13:12:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36211 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfJKRMv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Oct 2019 13:12:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id y189so9570326qkc.3
        for <cgroups@vger.kernel.org>; Fri, 11 Oct 2019 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NuMSmBYvIUrurNU4suw+Rbb1VhTuXsZkS4OjxBP9q68=;
        b=ifvZPXB31gLgdDyQ1v2wmXMiJAA0+/dNBlNr8lvPChRMn2r8frAWWSSuzlADbd0x9F
         PwtSNFLEyXqP7Hv7tQBqj8xjr2eW0UW9qRExAnBsyeNf/O40DVsSyXkqTgBp8unKGsmD
         WiEAb03SDqljViosFXOo3I4a917SFHJDrYwIHbZ1GVmBXnSTbpfvh+CiK2MpeYLPRm3T
         qdLfMVcqgTUZqvZM9e+Buwk1CmSFbGOrXFR8qnjA+8HkwiBSFMxguekxpbmipVYYASg0
         vY9kbiVsOkdR6UoXKvFew+HyfxKFw7BUr7GgV2JF5wxAyjGJ2KQK+gwDZUVDzR7TgAQw
         O+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NuMSmBYvIUrurNU4suw+Rbb1VhTuXsZkS4OjxBP9q68=;
        b=N7QB0IsdBOn+UDkJHl8VoRt/MChN+SPRmh/06b/mP5Fm9UdDS0+aq2MIg1P1wE3100
         R817LYeh7/ETQ3B2BI5lPrz1S9Bv7cMhkJJHS/rftg93VxYqSH1XB8yIe+uVIjvYfz71
         jNKPhTgeZXZFYaZxdqoxoquVH154tfEEyB/06bi7awULEpgU7tWSLaJY1VXizGhBAHg8
         owFKz8YXBWX7Xx2AJ2dVddktxVVzispxAGxPOguPY4cDbUbqFoVs/FNpftMZ76V3JAKO
         MlbQqMO/2an8FhQTwtSh2apMae/HI/eWxEAChP20CKJnoiGryQQWkpalxZ4xhcMMYeR2
         l1/w==
X-Gm-Message-State: APjAAAVqZJLt7CaNCv3IACo/H4pUvG+zegMjBF/KwoIKCQka9Tt287I7
        N0mPf3M5YVxOHvRWB9aS+JU=
X-Google-Smtp-Source: APXvYqw3aInVVpQ+UOpQlX/invdq43B1H1nhl6BPEPRXEZ/Jpdfbxpy3mSHsbispioWm387SJTIb2A==
X-Received: by 2002:a37:7603:: with SMTP id r3mr16289209qkc.116.1570813970112;
        Fri, 11 Oct 2019 10:12:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::3741])
        by smtp.gmail.com with ESMTPSA id z72sm5103213qka.115.2019.10.11.10.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 10:12:49 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:12:47 -0700
From:   "tj@kernel.org" <tj@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Ho, Kenny" <Kenny.Ho@amd.com>,
        "y2kenny@gmail.com" <y2kenny@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
        "jsparks@cray.com" <jsparks@cray.com>,
        "lkaplan@cray.com" <lkaplan@cray.com>
Subject: Re: [PATCH RFC v4 14/16] drm, cgroup: Introduce lgpu as DRM cgroup
 resource
Message-ID: <20191011171247.GC18794@devbig004.ftw2.facebook.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190829060533.32315-15-Kenny.Ho@amd.com>
 <b3d2b3c1-8854-10ca-3e39-b3bef35bdfa9@amd.com>
 <20191009103153.GU16989@phenom.ffwll.local>
 <ee873e89-48fd-c4c9-1ce0-73965f4ad2ba@amd.com>
 <20191009153429.GI16989@phenom.ffwll.local>
 <c7812af4-7ec4-02bb-ff4c-21dd114cf38e@amd.com>
 <20191009160652.GO16989@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009160652.GO16989@phenom.ffwll.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Daniel.

On Wed, Oct 09, 2019 at 06:06:52PM +0200, Daniel Vetter wrote:
> That's not the point I was making. For cpu cgroups there's a very well
> defined connection between the cpu bitmasks/numbers in cgroups and the cpu
> bitmasks you use in various system calls (they match). And that stuff
> works across vendors.

Please note that there are a lot of limitations even to cpuset.
Affinity is easy to implement and seems attractive in terms of
absolute isolation but it's inherently cumbersome and limited in
granularity and can lead to surprising failure modes where contention
on one cpu can't be resolved by the load balancer and leads to system
wide slowdowns / stalls caused by the dependency chain anchored at the
affinity limited tasks.

Maybe this is a less of a problem for gpu workloads but in general the
more constraints are put on scheduling, the more likely is the system
to develop twisted dependency chains while other parts of the system
are sitting idle.

How does scheduling currently work when there are competing gpu
workloads?  There gotta be some fairness provision whether that's unit
allocation based or time slicing, right?  If that's the case, it might
be best to implement proportional control on top of that.
Work-conserving mechanisms are the most versatile, easiest to use and
least likely to cause regressions.

Thanks.

-- 
tejun
