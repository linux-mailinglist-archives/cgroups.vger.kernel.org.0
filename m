Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 456E715D29C
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 08:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgBNHPm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 02:15:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40523 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbgBNHPm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 02:15:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so9657362wru.7;
        Thu, 13 Feb 2020 23:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F0xj7bH5swJh/Jvt4q2hyWK65GDCtgJ1J8rbJbB5Suo=;
        b=R4CzYAaNp66z6Z9oNzFeVsyFrT6cbz7WR/dibEF3m4KjJctHk6S99F1G1v1OHO87NR
         1tvZKbywlsG5AV0v2r54gaDj27DArQHIBHQ8Sb0WzsBgeLzW1GMkmUqpAsQca12WvasY
         x1Ck+/1xMyR8m0ieRbkk41ZThLvyygA06Dr3OE719Ao6FQl8sRydH2C0hKt/HzOU77yQ
         gCIxk3Z8QAy1XjONKFQ5+JXMTzHYRUf+ZbBFSg9HMeWxBflFcXzczpd/Mu2s6TTHpaF4
         bXJ1wAzNpC2URBOTa7IdkoqTwRqoCN5KzdIiXVhCI+UqRavbxtBwufti5mUPsNbN1aIV
         E5Kw==
X-Gm-Message-State: APjAAAXcnJP/J7DYo0U9UocOjLxusUJEKGXnWMgN1IcMX1hXvlGtquUP
        UBFPfhUdRmA9wB2u+gK9Sg0=
X-Google-Smtp-Source: APXvYqy+UgK9CbRw/e0Lm7Q6qtnGd8SOJ1ptn5OA9oHrQCZ1WJzwzZ0IsAvZzJd5JYQmYU0G8Q3Xcg==
X-Received: by 2002:adf:8296:: with SMTP id 22mr2310663wrc.352.1581664539776;
        Thu, 13 Feb 2020 23:15:39 -0800 (PST)
Received: from localhost (ip-37-188-133-87.eurotel.cz. [37.188.133.87])
        by smtp.gmail.com with ESMTPSA id q1sm5768332wrw.5.2020.02.13.23.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 23:15:38 -0800 (PST)
Date:   Fri, 14 Feb 2020 08:15:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200214071537.GL31689@dhcp22.suse.cz>
References: <20200130170020.GZ24244@dhcp22.suse.cz>
 <20200203215201.GD6380@cmpxchg.org>
 <20200211164753.GQ10636@dhcp22.suse.cz>
 <20200212170826.GC180867@cmpxchg.org>
 <20200213074049.GA31689@dhcp22.suse.cz>
 <20200213135348.GF88887@mtj.thefacebook.com>
 <20200213154731.GE31689@dhcp22.suse.cz>
 <20200213155249.GI88887@mtj.thefacebook.com>
 <20200213163636.GH31689@dhcp22.suse.cz>
 <20200213165711.GJ88887@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213165711.GJ88887@mtj.thefacebook.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 13-02-20 11:57:11, Tejun Heo wrote:
> Hello,
> 
> On Thu, Feb 13, 2020 at 05:36:36PM +0100, Michal Hocko wrote:
> > AFAIK systemd already offers knobs to configure resource controls [1].
> 
> Yes, it can set up the control knobs as directed but it doesn't ship
> with any material resource configurations or has conventions set up
> around it.

Right. But services might use those knobs, right? And that means that if
somebody wants a memory protection then the service file is going to use 
MemoryLow=$FOO and that is likely not going to work properly without an
an additional hassles, e.g. propagate upwards, which systemd doesn't do
unless I am mistaken.

> > Besides that we are talking about memcg features which are available only
> > unified hieararchy and that is what systemd is using already.
> 
> I'm not quite sure what the above sentence is trying to say.

I meant to say that once the unified hierarchy is used by systemd you
cannot configure it differently to suit your needs without interfering
with systemd.
 
> > > You gotta
> > > change the layout to configure resource control no matter what and
> > > it's pretty easy to do. systemd folks are planning to integrate higher
> > > level resource control features, so my expectation is that the default
> > > layout is gonna change as it develops.
> > 
> > Do you have any pointers to those discussions? I am not really following
> > systemd development.
> 
> There's a plan to integrate streamlined implementation of oomd into
> systemd. There was a thread somewhere but the only thing I can find
> now is a phoronix link.
> 
>   https://www.phoronix.com/scan.php?page=news_item&px=Systemd-Facebook-OOMD

I am not sure I see how that is going to change much wrt. resource
distribution TBH. Is the existing cgroup hierarchy going to change for
the OOMD to be deployed?

[...]

> > Anyway, I am skeptical that systemd can do anything much more clever
> > than placing cgroups with a resource control under the root cgroup. At
> > least not without some tagging which workloads are somehow related.
> 
> Yeah, exactly, all it needs to do is placing scopes / services
> according to resource hierarchy and configure overall policy at higher
> level slices, which is exactly what the memory.low semantics change
> will allow.

Let me ask more specifically. Is there any plan or existing API to allow
to configure which services are related resource wise?

> > That being said, I do not really blame systemd here. We are not making
> > their life particularly easy TBH.
> 
> Do you mind elaborating a bit?

I believe I have already expressed the configurability concern elsewhere
in the email thread. It boils down to necessity to propagate
protection all the way up the hierarchy properly if you really need to
protect leaf cgroups that are organized without a resource control in
mind. Which is what systemd does.
-- 
Michal Hocko
SUSE Labs
