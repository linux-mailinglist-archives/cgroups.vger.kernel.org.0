Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C9AB4DB5
	for <lists+cgroups@lfdr.de>; Tue, 17 Sep 2019 14:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfIQMVs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Sep 2019 08:21:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40733 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfIQMVr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Sep 2019 08:21:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id v38so3116507edm.7
        for <cgroups@vger.kernel.org>; Tue, 17 Sep 2019 05:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sBDZTvszyXwnAA8Fe4ydJoq8vUAh0ZWCho/0yWp4zVc=;
        b=LEmrrA6GkFueNQZUCd9cEaBPy+6Bh5n8Q2Baiv/E6gR23Dmg3+nvff6jzqH3UbGytS
         itTZJ9HNvQ7qlF6o6iTtoQNlRUjuD7bKn82rUFgw2lXQvVK3bQ2KjVe3A7vorURWJRwK
         VXI70tbnaghNzNFji7ZSIqaGgK3RURO9HZ+yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sBDZTvszyXwnAA8Fe4ydJoq8vUAh0ZWCho/0yWp4zVc=;
        b=kWDD3C2VMuWUoUtFry04vnxrxGYNO5lu0rRcwdmeLZ19cFzJlPaP3PDAITHKkO7WIe
         0MAray19efXXMyqTlKVzvIp2Em6zZOZPRpYn4il0yKicpwwhAN6ntt0P8kv147hIuOA8
         03wyh4uATfq/6eVq8Qg4XPCPaOC6RG+at9tgM8Ic1RNhh2aNpmCfL5S9FpzZFZDslWPb
         mYIfJjX5jTS3MVCKFO6fA/ha+ASWiwKocvmx38hA4fFnn9PtbFjdaSpY27gxTTlJepG7
         05jiDndDQq9vcU6nAcgj3/jEwvbsOxHPxcVK8j9tM38KW8l/kdFhpPC5rf0CffYj6hUp
         7L6g==
X-Gm-Message-State: APjAAAVhRuQkz/5TFzCgCMH/nvNva21W6aqfChS6lGO2k/QJwkq1Pq5n
        cRos6C2WXouJVqv86HvPal+1SA==
X-Google-Smtp-Source: APXvYqyALq9alFYk3aUmDri7Xuh4HiWRG2D36qfRPvo9smm60aI17Il61AZaKCaKzUvG1ikyyl0qmg==
X-Received: by 2002:a50:a532:: with SMTP id y47mr4184686edb.273.1568722904179;
        Tue, 17 Sep 2019 05:21:44 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id s21sm404166edi.85.2019.09.17.05.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 05:21:43 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:21:40 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        Kenny Ho <Kenny.Ho@amd.com>, Kenny Ho <y2kenny@gmail.com>,
        cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com
Subject: Re: [PATCH RFC v4 00/16] new cgroup controller for gpu/drm subsystem
Message-ID: <20190917122140.GL3958@phenom.ffwll.local>
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
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 10, 2019 at 01:54:48PM +0200, Michal Hocko wrote:
> On Fri 06-09-19 08:45:39, Tejun Heo wrote:
> > Hello, Daniel.
> > 
> > On Fri, Sep 06, 2019 at 05:34:16PM +0200, Daniel Vetter wrote:
> > > > Hmm... what'd be the fundamental difference from slab or socket memory
> > > > which are handled through memcg?  Is system memory used by GPUs have
> > > > further global restrictions in addition to the amount of physical
> > > > memory used?
> > > 
> > > Sometimes, but that would be specific resources (kinda like vram),
> > > e.g. CMA regions used by a gpu. But probably not something you'll run
> > > in a datacenter and want cgroups for ...
> > > 
> > > I guess we could try to integrate with the memcg group controller. One
> > > trouble is that aside from i915 most gpu drivers do not really have a
> > > full shrinker, so not sure how that would all integrate.
> > 
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

I think we can just make "must have a shrinker" as a requirement for
system memory cgroup thing for gpu buffers. There's mild locking inversion
fun to be had when typing one, but I think the problem is well-understood
enough that this isn't a huge hurdle to climb over. And should give admins
an easier to mange system, since it works more like what they know
already.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
