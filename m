Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E47368139
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 15:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbhDVNJL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 09:09:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:51002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236479AbhDVNJH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 09:09:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619096911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ziDd39JRIdWlI/ZncRHR4tPeHFque6IN9ySODF6A6RA=;
        b=ASiXiYpuhQJ/g3mUwmNQ88KUW3PYI8bbiUz8frlVc4HfAQOrx6zcEuPvAWLydBPThzX1G2
        mZw1c82Q3w+yMMZ8mF25AIjIRzZApPejrKxB7Dsc17Ce3QtjfOdmwhrc1q8d63JSizP5iT
        EVok/PSjPGn9pOzVtaBHjrwaBxnCJgs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE617B00E;
        Thu, 22 Apr 2021 13:08:31 +0000 (UTC)
Date:   Thu, 22 Apr 2021 15:08:31 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
Message-ID: <YIF1T21wiPq9eeOW@dhcp22.suse.cz>
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <699e51ba-825d-b243-8205-4d8cff478a66@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <699e51ba-825d-b243-8205-4d8cff478a66@sony.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 21-04-21 19:05:49, peter enderborg wrote:
[...]
> I think this is the wrong way to go.
> 
> I sent a patch for android lowmemorykiller some years ago.
> 
> http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2017-February/100319.html
> 
> It has been improved since than, so it can act handle oom callbacks, it can act on vmpressure and psi
> and as a shrinker. The patches has not been ported to resent kernels though.
> 
> I don't think vmpressure and psi is that relevant now. (They are what userspace act on)  But the basic idea is to have a priority queue
> within the kernel. It need pick up new processes and dying process.  And then it has a order, and that
> is set with oom adj values by activity manager in android.  I see this model can be reused for
> something that is between a standard oom and userspace.  Instead of vmpressure and psi
> a watchdog might be a better way.  If userspace (in android the activity manager or lmkd) does not kick the watchdog,
> the watchdog bite the task according to the priority and kills it.  This priority list does not have to be a list generated 
> within kernel. But it has the advantage that you inherent parents properties.  We use a rb-tree for that.
> 
> All that is missing is the watchdog.

And this is off topic to the discussion as well. We are not discussing
how to handle OOM situation best. Shakeel has brought up challenges that
some userspace based OOM killer implementations are facing. Like it or
not but different workloads have different requirements and what you are
using in Android might not be the best fit for everybody. I will not
comment on the android approach but it doesn't address any of the
concerns that have been brought up.
-- 
Michal Hocko
SUSE Labs
