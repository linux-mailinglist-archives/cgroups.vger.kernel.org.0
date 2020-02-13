Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2B415C85A
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2020 17:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgBMQgn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Feb 2020 11:36:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43114 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgBMQgn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Feb 2020 11:36:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id r11so7455101wrq.10;
        Thu, 13 Feb 2020 08:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lmfQ+P5qqT40a5iQ7iRjjbaHXUizOe4fBlQ/eH9eBdY=;
        b=JoXI0owAkqa1H5x46j1rZrU5kxHCsFBSU9MBo11uXqO8D2bugzi2X287cc6d7LrUVc
         aZbFFlLr5mHXkAzGS/k+G0cy4vfwAucxS2WFTlcOGKLN4fsebCDsKGD3x9LDbcLsn0H5
         vxMcaLH4loj3EnA/t9eA6M9YOxQiLIctWJBgPiA7z7l2tEKLoo9NW6c3OPMQQ+ih1H4p
         ef+9OnHzAH2qY6DMp+70V13tYVaFG31bi3uq+n8hBvLuH3BLwpHpmhwXFVZ1bX6yHCeq
         weTIekdbtdbRHB/aqU9oZVhqSt8SxtxKsNP5fplose9c06z5meuHadKSDpLZlt6OgV03
         sGuw==
X-Gm-Message-State: APjAAAUmVVnWo1f7uPbkiJrL+brZY3c3uMQf2Q+Y9OBo6ZWsMHSP/HfR
        Gt0qh3IPCWarQS4dyGAdwqo=
X-Google-Smtp-Source: APXvYqx9OeOJFs7+oXJ+VHrtubnIYIroyeFz0+EmF8royFusQStAvQZ+cr2PQiveNWcbVmmpP2Nk5A==
X-Received: by 2002:adf:c453:: with SMTP id a19mr22819198wrg.341.1581611799518;
        Thu, 13 Feb 2020 08:36:39 -0800 (PST)
Received: from localhost (ip-37-188-133-87.eurotel.cz. [37.188.133.87])
        by smtp.gmail.com with ESMTPSA id b11sm3567835wrx.89.2020.02.13.08.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:36:38 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:36:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200213163636.GH31689@dhcp22.suse.cz>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200130170020.GZ24244@dhcp22.suse.cz>
 <20200203215201.GD6380@cmpxchg.org>
 <20200211164753.GQ10636@dhcp22.suse.cz>
 <20200212170826.GC180867@cmpxchg.org>
 <20200213074049.GA31689@dhcp22.suse.cz>
 <20200213135348.GF88887@mtj.thefacebook.com>
 <20200213154731.GE31689@dhcp22.suse.cz>
 <20200213155249.GI88887@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213155249.GI88887@mtj.thefacebook.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 13-02-20 10:52:49, Tejun Heo wrote:
> Hello,
> 
> On Thu, Feb 13, 2020 at 04:47:31PM +0100, Michal Hocko wrote:
> > Well, I would tend to agree but I can see an existing cgroup hierarchy
> > imposed by systemd and that is more about "logical" organization of
> > processes based on their purpose than anything resembling resources.
> > So what can we do about that to make it all work?
> 
> systemd right now isn't configuring any resource control by default,
> so I'm not sure why it is relevant in this discussion.

AFAIK systemd already offers knobs to configure resource controls [1].
Besides that we are talking about memcg features which are available only
unified hieararchy and that is what systemd is using already.

> You gotta
> change the layout to configure resource control no matter what and
> it's pretty easy to do. systemd folks are planning to integrate higher
> level resource control features, so my expectation is that the default
> layout is gonna change as it develops.

Do you have any pointers to those discussions? I am not really following
systemd development.

Anyway, I am skeptical that systemd can do anything much more clever
than placing cgroups with a resource control under the root cgroup. At
least not without some tagging which workloads are somehow related.

That being said, I do not really blame systemd here. We are not making
their life particularly easy TBH.

[1] https://www.freedesktop.org/software/systemd/man/systemd.resource-control.html
-- 
Michal Hocko
SUSE Labs
