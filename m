Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0A0E1FFA
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2019 17:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406963AbfJWP4q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Oct 2019 11:56:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40764 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406949AbfJWP4q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Oct 2019 11:56:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id o49so25174885qta.7
        for <cgroups@vger.kernel.org>; Wed, 23 Oct 2019 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qCDfb7NBt3k96Z3LHT9+wyaPinygdsUVG4eMjwQIig0=;
        b=gzPtJc9UG7/c3nCw1QDLmDFrPZ2p/5hVgwAWj5fxU7jOZw+4M6LELBbAGYk+6wbln3
         f8ief24ppj67ptUxcdk4CzpF1yUiOP/2cRcPsqUBcFvNqdvDdfh1GrdDRfcdT6jSga8O
         lCUDrd5RQn/iYeUN5F8eMCJalFsQlOXYkpMo6RwW+lAx6M9sN67Bw/rIRZs76wUfN5ST
         3CmZcNDi0/pmB0JWE+/PHNP2bwbar9mrnhDdr4HqOzD/LbibMVqfVF5SBw424VYUqiAQ
         ZP48m8ZlTKx6J90KvpquV6g52d05IyK6VPpkmJ5aUaOaY30+/V/qPLq6e17IUoCMFz2f
         +SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qCDfb7NBt3k96Z3LHT9+wyaPinygdsUVG4eMjwQIig0=;
        b=eKUSfc6DzA1+UhWatt6bQcyrBFuIZ0yuTObb2Sxo4hJ1k4GuqJuPLma5ZAya90A1Q6
         yDm10lPg+enes7Ax/+6g6ciL+HqVQczyPugtXXPDAVCCH0wcILnkIwuTo7Vls6Q7uyAz
         XP3ysNkwk0g925JIg0WzlmiTJHVidvF1YK1ObGWpRjPUet74bUQnA8oYPrjAzrfoAEKv
         wz49oTAR/h35duf3jYRlSx6YcgtTdPmzcDfgoLVkygD5fWtd4JEa2PuIC7nUJkJIqFsy
         4kYG3mfkHJOZXgP6Ra7VjrYjid1loIS/THmN1pR2GQHc0sVScK1ngcnWbrEugy3FDvtz
         OSdg==
X-Gm-Message-State: APjAAAWLqocxkNVxwA5ZIeeFFIXlTH/ztSwvY8BNtw1YZMFNNvEhKeVq
        B0CrB9kq9DMs0Rq5uYvV8B+6KwDJrQo=
X-Google-Smtp-Source: APXvYqx0acPfaJc7aDp/xUAu/oImOejs62QLL76QQZnIiy0PFClGHYdtIYajkheNs7/YVZ6DSkKAsQ==
X-Received: by 2002:ac8:4506:: with SMTP id q6mr10062633qtn.277.1571846205200;
        Wed, 23 Oct 2019 08:56:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:c4de])
        by smtp.gmail.com with ESMTPSA id p7sm12637822qkc.21.2019.10.23.08.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 08:56:44 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:56:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/8] mm: vmscan: naming fixes: global_reclaim() and
 sane_reclaim()
Message-ID: <20191023155643.GB366316@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-5-hannes@cmpxchg.org>
 <20191023141436.GE17610@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023141436.GE17610@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 23, 2019 at 04:14:36PM +0200, Michal Hocko wrote:
> On Tue 22-10-19 10:47:59, Johannes Weiner wrote:
> > Seven years after introducing the global_reclaim() function, I still
> > have to double take when reading a callsite. I don't know how others
> > do it, this is a terrible name.
> 
> I somehow never had problem with that but ...
> > 
> > Invert the meaning and rename it to cgroup_reclaim().
> > 
> > [ After all, "global reclaim" is just regular reclaim invoked from the
> >   page allocator. It's reclaim on behalf of a cgroup limit that is a
> >   special case of reclaim, and should be explicit - not the reverse. ]
> 
> ... this is a valid point.
> 
> > sane_reclaim() isn't very descriptive either: it tests whether we can
> > use the regular writeback throttling - available during regular page
> > reclaim or cgroup2 limit reclaim - or need to use the broken
> > wait_on_page_writeback() method. Use "writeback_throttling_sane()".
> 
> I do have a stronger opinion on this one. sane_reclaim is really a
> terrible name. As you say the only thing this should really tell is
> whether writeback throttling is available so I would rather go with
> has_writeback_throttling() or writeba_throttling_{eabled,available}
> If you insist on having sane in the name then I won't object but it just
> raises a question whether we have some levels of throttling with a
> different level of sanity.

I mean, cgroup1 *does* have a method to not OOM due to pages under
writeback: wait_on_page_writeback() on each wb page on the LRU.

It's terrible, but it's a form of writeback throttling. That's what
the sane vs insane distinction is about, I guess: we do in fact have
throttling implementations with different levels of sanity.

> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
