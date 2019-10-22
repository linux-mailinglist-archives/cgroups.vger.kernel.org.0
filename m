Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C99E0DCC
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 23:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbfJVVbc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 17:31:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44282 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732491AbfJVVbc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 17:31:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id z22so8598938qtq.11
        for <cgroups@vger.kernel.org>; Tue, 22 Oct 2019 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=98G4icOId5gRa0BO3+NnJk8SaIphOMOAkR+jC8y01cM=;
        b=Kpeg9R3GFL4QkfZagosY6d53cYjLfU/55y5oiGy1mjM68ATS5EsPMC/b39+CZvdWeM
         8ibBRJ3iDRpWYJTRT5OE2MAc0HRbHMm595crY+xLwbBHRUMsTGMIbg0AntoeOMyUCt+/
         L8qKG9XzwfuKXthd76s7hR9+ewQIJGi5UyQFtq3Us7KZpuY4HdPH6MW0y0ZEnYa/9c63
         ZO4/9+L5Y1ZazxPGB0LMu0hJk9Ap/Z0UgVACp0+rsSjXaz0Ac+1uW4mdQ3ZHCdSPFPXm
         t7w3cYhZSB217CYGAzMq3ziGNwSN3kVFOgs5o5kvEn100lxhMNAhcgNpDaiAD2pOTogb
         u82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=98G4icOId5gRa0BO3+NnJk8SaIphOMOAkR+jC8y01cM=;
        b=sJ9vSBHTbCzJQ2etEi0U5k0wnbahXclcdIeGJER+mMzqmXQ/O+FMJJjr+NE0PoITE6
         ssjapZfW7loKYFZt2QjqLbueGDg8OzEKFDywpPOaZVY2VV4Lbf1XxtfhIKJrh1udQqLs
         0QJzZIiXp/WgHPk8iR6Few25pkrUwtyiYihweLSfmoi0Reatjs8mFCk9h9F1VdWGXqFZ
         GtP9gzAIOcZ7dZhWrdxVNAQGSblbXQ7/3YkjeomiJ4YRYOhuxFHR8bVxe5lVvurBjhpM
         OVgI6p+c3Yp2WrPAqIX6GSnLGsnvuaZ+8pNmSEiRby1QL2k5SGDibKcp2bSuCwZRLoW9
         Jp5g==
X-Gm-Message-State: APjAAAW6gC8QHd3+LXWraiDIKaNN7M5/rGJ2WPLLqlqQMvHS9jUjC3am
        glHF4gv5e63zhmwH+n8JlJ7Upw==
X-Google-Smtp-Source: APXvYqxtoQLEP4BL19wiGwuyRPuynHQIQ7Fa6uLZDQMbflk5fVafKu3TQVjiuhiZwrorgsPiF32wZw==
X-Received: by 2002:ac8:f8d:: with SMTP id b13mr5674183qtk.129.1571779891433;
        Tue, 22 Oct 2019 14:31:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:869e])
        by smtp.gmail.com with ESMTPSA id d39sm7220087qtc.23.2019.10.22.14.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 14:31:30 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:31:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 2/8] mm: clean up and clarify lruvec lookup procedure
Message-ID: <20191022213130.GA361040@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-3-hannes@cmpxchg.org>
 <20191022192456.GB11461@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022192456.GB11461@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 22, 2019 at 07:25:01PM +0000, Roman Gushchin wrote:
> On Tue, Oct 22, 2019 at 10:47:57AM -0400, Johannes Weiner wrote:
> > There is a per-memcg lruvec and a NUMA node lruvec. Which one is being
> > used is somewhat confusing right now, and it's easy to make mistakes -
> > especially when it comes to global reclaim.
> > 
> > How it works: when memory cgroups are enabled, we always use the
> > root_mem_cgroup's per-node lruvecs. When memory cgroups are not
> > compiled in or disabled at runtime, we use pgdat->lruvec.
> > 
> > Document that in a comment.
> > 
> > Due to the way the reclaim code is generalized, all lookups use the
> > mem_cgroup_lruvec() helper function, and nobody should have to find
> > the right lruvec manually right now. But to avoid future mistakes,
> > rename the pgdat->lruvec member to pgdat->__lruvec and delete the
> > convenience wrapper that suggests it's a commonly accessed member.
> 
> This part looks great!

Thanks!

> > While in this area, swap the mem_cgroup_lruvec() argument order. The
> > name suggests a memcg operation, yet it takes a pgdat first and a
> > memcg second. I have to double take every time I call this. Fix that.
> 
> Idk, I agree that the new order makes more sense (slightly), but
> such changes make any backports / git blame searches more complex.
> So, I'm not entirely convinced that it worth it. The compiler will
> prevent passing bad arguments by mistake.

Lol, this has cost me a lot of time since we've had it. It takes you
out of the flow while writing code and make you think about something
stupid and trivial.

The backport period is limited, but the mental overhead of a stupid
interface is forever!
