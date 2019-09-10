Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79ADAAE98F
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2019 13:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfIJLyv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Sep 2019 07:54:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:43322 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfIJLyv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 10 Sep 2019 07:54:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96058ABCE;
        Tue, 10 Sep 2019 11:54:49 +0000 (UTC)
Date:   Tue, 10 Sep 2019 13:54:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
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
Message-ID: <20190910115448.GT2063@dhcp22.suse.cz>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190831042857.GD2263813@devbig004.ftw2.facebook.com>
 <20190903075550.GJ2112@phenom.ffwll.local>
 <20190903185013.GI2263813@devbig004.ftw2.facebook.com>
 <CAKMK7uE5Bj-3cJH895iqnLpwUV+GBDM1Y=n4Z4A3xervMdJKXg@mail.gmail.com>
 <20190906152320.GM2263813@devbig004.ftw2.facebook.com>
 <CAKMK7uEXP7XLFB2aFU6+E0TH_DepFRkfCoKoHwkXtjZRDyhHig@mail.gmail.com>
 <20190906154539.GP2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906154539.GP2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 06-09-19 08:45:39, Tejun Heo wrote:
> Hello, Daniel.
> 
> On Fri, Sep 06, 2019 at 05:34:16PM +0200, Daniel Vetter wrote:
> > > Hmm... what'd be the fundamental difference from slab or socket memory
> > > which are handled through memcg?  Is system memory used by GPUs have
> > > further global restrictions in addition to the amount of physical
> > > memory used?
> > 
> > Sometimes, but that would be specific resources (kinda like vram),
> > e.g. CMA regions used by a gpu. But probably not something you'll run
> > in a datacenter and want cgroups for ...
> > 
> > I guess we could try to integrate with the memcg group controller. One
> > trouble is that aside from i915 most gpu drivers do not really have a
> > full shrinker, so not sure how that would all integrate.
> 
> So, while it'd great to have shrinkers in the longer term, it's not a
> strict requirement to be accounted in memcg.  It already accounts a
> lot of memory which isn't reclaimable (a lot of slabs and socket
> buffer).

Yeah, having a shrinker is preferred but the memory should better be
reclaimable in some form. If not by any other means then at least bound
to a user process context so that it goes away with a task being killed
by the OOM killer. If that is not the case then we cannot really charge
it because then the memcg controller is of no use. We can tolerate it to
some degree if the amount of memory charged like that is negligible to
the overall size. But from the discussion it seems that these buffers
are really large.
-- 
Michal Hocko
SUSE Labs
