Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3719F15D8DC
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 14:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgBNN5c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 08:57:32 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38094 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgBNN5c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 08:57:32 -0500
Received: by mail-qv1-f65.google.com with SMTP id g6so4301403qvy.5;
        Fri, 14 Feb 2020 05:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pRCR8JFRteiLiVzqAfjfoL4EPL1tfp3Ime2M/1tWd2A=;
        b=Xt+4QjfcAQFD4vbXwLw142jzmUR/mbfyWcR2LGQxEG3Q4CI4VnpvrtZdxIzjAMG0NM
         12gk7hnv23oml5u4GPRoSAR1zri9vwXrb4GXVszIma+EJWc+TMedI/TsHu9IB/yiwvYl
         l9tmJ9l3SL8pc7gpPoKNofC0lO0V1mMt/tZfMprNr3xounTF0mzLJ/zcCN7ETn//1KVY
         o8dDRv2rXzXiog5yCkv1sCoPDAeKuTOzemq55dKXyAPWVs+wzVeCeYAfolPGJ5Vik8aP
         ddWHw6bWMPQ7qFme1giV2oPfdSwVecasRRbWE2WJQN4DJ9FWqkiRq3DGzyLJC1eYmFjF
         zDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pRCR8JFRteiLiVzqAfjfoL4EPL1tfp3Ime2M/1tWd2A=;
        b=QwETe9g+1cZCFJ9Sg7V95PXzeHj90TS7A9X9qDS/7TbEgkhIWFLGZb814BNif+hk4f
         pkUYZzf0l1ZMY1K6rFtKtxIBCaH0o0+UKiupLFr/Ew7et4jetELwPHBhTIAmYYXJTJ/M
         9PbT4PkQZDOP9Ynr535ixcBICmVHlApZ+yXCZALQfvGzwbK/RXdimI907OxVXjpCceYx
         TlnqI9zDmQkH/A/AZcDL9Zn74FqPeMEXlkh082gVbuOSfXLzLZMlMCA3UCUtQu+YHhTg
         Qhu8zuiyY7Vi5/iEX0NczoPYuRl7FvUf3KaF4j95nFGLhTDsazeycmal4e3BPZ8TjIHX
         637w==
X-Gm-Message-State: APjAAAVVfi2mfhmYv9VhzyuZeEksR6/TGN345XaB0344+qDyRJztumgl
        8hNc+N6bP+YF4GPXTSkwH/Q=
X-Google-Smtp-Source: APXvYqwMGPF1vQTzvjZZAzqYcaur4NxkkfsQZNmn2Qcu3JNVWIdK1pxN9mTSXfJCZUr4riuWjBkKbw==
X-Received: by 2002:ad4:4dc9:: with SMTP id cw9mr2299790qvb.0.1581688651050;
        Fri, 14 Feb 2020 05:57:31 -0800 (PST)
Received: from localhost ([71.172.127.161])
        by smtp.gmail.com with ESMTPSA id c26sm3149342qtn.19.2020.02.14.05.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:57:30 -0800 (PST)
Date:   Fri, 14 Feb 2020 08:57:28 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200214135728.GK88887@mtj.thefacebook.com>
References: <20200203215201.GD6380@cmpxchg.org>
 <20200211164753.GQ10636@dhcp22.suse.cz>
 <20200212170826.GC180867@cmpxchg.org>
 <20200213074049.GA31689@dhcp22.suse.cz>
 <20200213135348.GF88887@mtj.thefacebook.com>
 <20200213154731.GE31689@dhcp22.suse.cz>
 <20200213155249.GI88887@mtj.thefacebook.com>
 <20200213163636.GH31689@dhcp22.suse.cz>
 <20200213165711.GJ88887@mtj.thefacebook.com>
 <20200214071537.GL31689@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214071537.GL31689@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Feb 14, 2020 at 08:15:37AM +0100, Michal Hocko wrote:
> > Yes, it can set up the control knobs as directed but it doesn't ship
> > with any material resource configurations or has conventions set up
> > around it.
> 
> Right. But services might use those knobs, right? And that means that if
> somebody wants a memory protection then the service file is going to use 
> MemoryLow=$FOO and that is likely not going to work properly without an
> an additional hassles, e.g. propagate upwards, which systemd doesn't do
> unless I am mistaken.

While there are applications where strict protection makes sense, in a
lot of cases, resource decisions have to consider factors global to
the system - how much is there and for what purpose the system is
being set up. Static per-service configuration for sure doesn't work
and neither will dynamic configuration without considering system-wide
factors.

Another aspect is that as configuration gets more granular and
stricter with memory knobs, the configuration becomes less
work-conserving. Kernel's MM keeps track of dynamic behavior and adapt
to the dynamic usage, these configurations can't.

So, while individual applications may indicate what its resource
dispositions are, a working configuration is not gonna come from each
service declaring how many bytes they want.

This doesn't mean configurations are more tedious or difficult. In
fact, in a lot of cases, categorizing applications on the system
broadly and assigning ballpark weights and memory protections from the
higher level is sufficient.

> > > Besides that we are talking about memcg features which are available only
> > > unified hieararchy and that is what systemd is using already.
> > 
> > I'm not quite sure what the above sentence is trying to say.
> 
> I meant to say that once the unified hierarchy is used by systemd you
> cannot configure it differently to suit your needs without interfering
> with systemd.

I haven't experienced systemd getting in the way of structuring cgroup
hierarchy and configuring them. It's pretty flexible and easy to
configure. Do you have any specific constraints on mind?

> > There's a plan to integrate streamlined implementation of oomd into
> > systemd. There was a thread somewhere but the only thing I can find
> > now is a phoronix link.
> > 
> >   https://www.phoronix.com/scan.php?page=news_item&px=Systemd-Facebook-OOMD
> 
> I am not sure I see how that is going to change much wrt. resource
> distribution TBH. Is the existing cgroup hierarchy going to change for
> the OOMD to be deployed?

It's not a hard requirement but it'll be a lot more useful with actual
resource hierarchy. As more resource control features get enabled, I
think it'll converge that way because that's more useful.

> > Yeah, exactly, all it needs to do is placing scopes / services
> > according to resource hierarchy and configure overall policy at higher
> > level slices, which is exactly what the memory.low semantics change
> > will allow.
> 
> Let me ask more specifically. Is there any plan or existing API to allow
> to configure which services are related resource wise?

At kernel level, no. They seem like pretty high level policy decisions
to me.

> > > That being said, I do not really blame systemd here. We are not making
> > > their life particularly easy TBH.
> > 
> > Do you mind elaborating a bit?
> 
> I believe I have already expressed the configurability concern elsewhere
> in the email thread. It boils down to necessity to propagate
> protection all the way up the hierarchy properly if you really need to
> protect leaf cgroups that are organized without a resource control in
> mind. Which is what systemd does.

But that doesn't work for other controllers at all. I'm having a
difficult time imagining how making this one control mechanism work
that way makes sense. Memory protection has to be configured together
with IO protection to be actually effective.

As for cgroup hierarchy being unrelated to how controllers behave, it
frankly reminds me of cgroup1 memcg flat hierarchy thing I'm not sure
how that would actually work in terms of resource isolation. Also, I'm
not sure how systemd forces such configurations and I'd think systemd
folks would be happy to fix them if there are such problems. Is the
point you're trying to make "because of systemd, we have to contort
how memory controller behaves"?

Thanks.

-- 
tejun
