Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E022915DB37
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 16:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgBNPlB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 10:41:01 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43446 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729439AbgBNPlB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 10:41:01 -0500
Received: by mail-qv1-f67.google.com with SMTP id p2so4450713qvo.10;
        Fri, 14 Feb 2020 07:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PUP4np+G4VE7PuRhOk6undkvvxru+QNxEyvlFdHRy8M=;
        b=ZbT6gpBkKjiYBwLqeSqmGvHliwzu3GiTDD1TN6F1csmbHvQf5zew22ys7x8sByZCFB
         q48R1dqd6gb7760yQUKvX4ZNOKbkvtwgVXPFolXQrQXFKuoaSdlGKyGE+fp8z//c61Hd
         9aFr16nzHuax9MVICJO+adiLztmf99s8R7h4dW7aDkTdvIDlLGhEAskwkWWFDaMuKHh+
         EBqbHa95IoXx+rusv2pI09ldunnEOGJq3Ra9uXfWr3ii4cIPUeeLkQmcWl2DMBT4FrBk
         hTj1LXm+1GQmksx8ne1jW4r0o3tNzCKAJvVd/3eOw9vI5C/TQEWBf3N/WArbWsU/bI6K
         f3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PUP4np+G4VE7PuRhOk6undkvvxru+QNxEyvlFdHRy8M=;
        b=P05Di6E8QV69jFzp/Z7wTXS5j8uMQGfMbSjkfPT+n/pQTnZUe8us3U1W/HfaJjcRQU
         cVlxEcOoeLtBU55vo/qA2GPiEluUJLnilgMje3oaDpq7xejUBc6MeHQcunA3zvipQ6M5
         ILE5Cxhjwg8G3MAqLpJRMcp+v5BA/sLgCmG1SZt6PkLp9u/FoO4zxKB8GiyOqkICCxqN
         Qks81Es2gD7dOmcglDN1grirVnWwhXXP9MOBmhP9bVOSRvovh0UzrlRmFeUDtzBpp+gZ
         6LJ8q1NEd4BOm7fjrtlPX+P3Pw1PYA/7uKj1mqzTvwuf3jUcvAIXggYL+yV51uESRz8I
         4Qvw==
X-Gm-Message-State: APjAAAXeGbv5fc/lhDmGjBCPJ1nsm/X8YzA4U7vKtpO1dh36ASTUAjLj
        UVR9e2JRGRgUaI1x3LXEofZqxFDFGzQ=
X-Google-Smtp-Source: APXvYqxdW4fylNswjll7xxYrCS6rXZrMDa0xELAOaKYQie0LHhRSG3Il+FkHWaO6Oesbu4IpntutBQ==
X-Received: by 2002:a0c:e408:: with SMTP id o8mr2707981qvl.236.1581694860207;
        Fri, 14 Feb 2020 07:41:00 -0800 (PST)
Received: from localhost ([71.172.127.161])
        by smtp.gmail.com with ESMTPSA id s22sm3440963qke.19.2020.02.14.07.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 07:40:59 -0800 (PST)
Date:   Fri, 14 Feb 2020 10:40:57 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200214154057.GM88887@mtj.thefacebook.com>
References: <20200212170826.GC180867@cmpxchg.org>
 <20200213074049.GA31689@dhcp22.suse.cz>
 <20200213135348.GF88887@mtj.thefacebook.com>
 <20200213154731.GE31689@dhcp22.suse.cz>
 <20200213155249.GI88887@mtj.thefacebook.com>
 <20200213163636.GH31689@dhcp22.suse.cz>
 <20200213165711.GJ88887@mtj.thefacebook.com>
 <20200214071537.GL31689@dhcp22.suse.cz>
 <20200214135728.GK88887@mtj.thefacebook.com>
 <20200214151318.GC31689@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214151318.GC31689@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Feb 14, 2020 at 04:13:18PM +0100, Michal Hocko wrote:
> On Fri 14-02-20 08:57:28, Tejun Heo wrote:
> > But that doesn't work for other controllers at all. I'm having a
> > difficult time imagining how making this one control mechanism work
> > that way makes sense. Memory protection has to be configured together
> > with IO protection to be actually effective.
> 
> Please be more specific. If the protected workload is mostly in-memory,
> I do not really see how IO controller is relevant. See the example of
> the DB setup I've mentioned elsewhere.

Most applications, even the ones which don't use explicit IOs much,
don't have set memory footprint which is uniformly accessed and there
needs to be some level of reclaim activity for the working set to be
established and maintained. Without IO control, memory protection
isn't enough in protecting the workload.

Even if we narrow down the discussion to something like memcache which
has fixed memory footprint with almost uniform access pattern, real
world applications don't exist in vacuum - they compete on CPU, have
to do logging, pulls in metric ton of libraries which implicitly
accesses stuff and so on. If somebody else is pummeling the filesystem
and there's no IO isolation set up, it'll stall noticeably every once
in a while.

> > As for cgroup hierarchy being unrelated to how controllers behave, it
> > frankly reminds me of cgroup1 memcg flat hierarchy thing I'm not sure
> > how that would actually work in terms of resource isolation. Also, I'm
> > not sure how systemd forces such configurations and I'd think systemd
> > folks would be happy to fix them if there are such problems. Is the
> > point you're trying to make "because of systemd, we have to contort
> > how memory controller behaves"?
> 
> No, I am just saying and as explained in reply to Johannes, there are
> practical cases where the cgroup hierarchy reflects organizational
> structure as well.

Oh I see. If cgroup hierarchy isn't set up for resource control,
resource control not working well seems par for the course. I mean, no
other controllers would work anyway, so I'm having a hard time to see
what the point is. What we ultimately want is cgroup actually being
useful for its primary purpose of resource control while supporting
other organizational use cases and while the established usages aren't
there yet I haven't seen anything fundamentally blocking that.

Thanks.

-- 
tejun
