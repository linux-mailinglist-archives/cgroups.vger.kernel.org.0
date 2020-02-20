Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26708166188
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 16:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgBTP4x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 10:56:53 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45118 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgBTP4x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 10:56:53 -0500
Received: by mail-qk1-f194.google.com with SMTP id a2so3965723qko.12;
        Thu, 20 Feb 2020 07:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WrIAIkuYfbohT4URY+WT9f9IMynxvVzhUx7hJqz7oAk=;
        b=ESOkYp4wOyqNJWtsVeoAd/ssWk0nvkvCqnwMaCaF3sumNcZ7bZUGH+0ucazaesndy0
         yirD6ztauUJJvTh2k0qQOCMIuSy8y0I5Op0djhJN8tXc86SkhYb3GRAvPH0Xdg20PLhR
         tkP4CLoOD5zcFyv/N+6KLjwu32UptfltbOtBQhs2lFBq9bhdey1qQykNbSqzme1HWTvF
         YJKe9824y9fv3QDFnPj2iRvGn8faVc36cGixbcfn6JihAAnsRa6TRztLTkXfYeKmfck4
         JQ0bQjj5RuwY3aPQVQLPJ5lDRI+ouoTLCgEgk4zeilfjXu6dAxWPxxTsm/zvTFmQrkVB
         y1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WrIAIkuYfbohT4URY+WT9f9IMynxvVzhUx7hJqz7oAk=;
        b=JZjH+GfTO+qhT4RqZgv/Nro+yYKDSYRQMNWbe8StRtYrtDXcoEDREy3YS2NYcT8q1G
         4tUrFPnDViVwxAqzk6vA7+AIHPE1u1FzW59Mrd/vAI2OqTunE7DnwciZ3IboEu0jTaN2
         uC0bnRtTsdIh01226K74aYyaehAbojJLCDN36pmDPNzqRldxD0pR1MneZvIy1V7Nlh46
         wKegmJratMlleWlAHtwJTr0665t8hgCgbKaHTxpbW15+Nctszza880Spad7J1Wp5ronM
         EtxVoKnoiDctjDUbITWZjqIL//k9nO2QsBkgrRcp0rCtH6yEvIPKVT9y864kQcyYUpTb
         V53w==
X-Gm-Message-State: APjAAAUz/7k9alrbtjVRIOGEETlMmBN93uiXFNZmwjLSAKDn+Z3ACfTJ
        MyfzMx/eQDjdLXNu/1SfVyQ=
X-Google-Smtp-Source: APXvYqxl2VFYhPNB5rqU5j+Wp99qIWsjSoVAVV6XHVaiOidOGQt4AO4LYzBpRqNGmdzKRoW3+dg+/w==
X-Received: by 2002:a05:620a:31b:: with SMTP id s27mr28175423qkm.105.1582214212209;
        Thu, 20 Feb 2020 07:56:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::5e31])
        by smtp.gmail.com with ESMTPSA id x66sm57180qkb.101.2020.02.20.07.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:56:51 -0800 (PST)
Date:   Thu, 20 Feb 2020 10:56:51 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200220155651.GG698990@mtj.thefacebook.com>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <20200219183731.GC11847@dhcp22.suse.cz>
 <20200219191618.GB54486@cmpxchg.org>
 <20200219195332.GE11847@dhcp22.suse.cz>
 <20200219214112.4kt573kyzbvmbvn3@ca-dmjordan1.us.oracle.com>
 <20200219220859.GF54486@cmpxchg.org>
 <20200220154524.dql3i5brnjjwecft@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220154524.dql3i5brnjjwecft@ca-dmjordan1.us.oracle.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 20, 2020 at 10:45:24AM -0500, Daniel Jordan wrote:
> Ok, consistency with io and memory is one advantage to doing it that way.
> Creating kthreads in cgroups also seems viable so far, and it's unclear whether
> either approach is significantly simpler or more maintainable than the other,
> at least to me.

The problem with separate kthread approach is that many of these work
units are tiny, and cgroup membership might not be known or doesn't
agree with the processing context from the beginning

For example, the ownership of network packets can't be determined till
processing has progressed quite a bit in shared contexts and each item
too small to bounce around. The only viable way I can think of
splitting aggregate overhead according to the number of packets (or
some other trivially measureable quntity) processed.

Anything sitting in reclaim layer is the same. Reclaim should be
charged to the cgroup whose memory is reclaimed *but* shouldn't block
other cgroups which are waiting for that memory. It has to happen in
the context of the highest priority entity waiting for memory but the
costs incurred must be charged to the memory owners.

So, one way or the other, I think we'll need back charging and once
back charging is needed for big ticket items like network and reclaim,
it's kinda silly to use separate mechanisms for other stuff.

> Is someone on your side working on remote charging right now?  I was planning
> to post an RFD comparing these soon and it would make sense to include them.

It's been on the to do list but nobody is working on it yet.

Thanks.

-- 
tejun
