Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3790C20E4B
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 19:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfEPR46 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 13:56:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43708 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfEPR46 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 13:56:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id z6so2806413qkl.10
        for <cgroups@vger.kernel.org>; Thu, 16 May 2019 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bcnfQY6UYyRStLiSmuTZOVFUbTzk6P+Gmm7BbKAmwyU=;
        b=cgQvEXGqW3uJsJG9b+dK2N/cDz3BRPEjJu+tvCpLVBFxuPhuD61ZEeLlmXg2LXDD81
         9j/El74ihm7rBYSC44gkXw1rRFuAhlTbE8+uL+kZ32ezLBwnnlUM/uLdI1yD+ySC9+eM
         0+HMufBCBDMT65ba17Iq8Ly+p5aNGv35sxAWPBb8ShXqWNY5KFyOFwocVhGKykt3G/ie
         wX+JUwysDAwORWcI6YDMhbAmlouhcV9fb65nlqNLu3kvEuoYGgztUxjb1cb4hcbhY/MU
         nXlojvj+DTffd2557vhyClUuWe3uSiS55KoOzvn4RA1J43jihR0qRcWymWWsiZLl1iBv
         7iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bcnfQY6UYyRStLiSmuTZOVFUbTzk6P+Gmm7BbKAmwyU=;
        b=Z8tGCl3eBkW7v3aPkO/FUL6i0lFT+ucljX75gDr0oJZ0IlnvADskZdA3dkLsUlonom
         qWaZQ6FhsWHE7QojenUu0w54cRvgYPyC1nyR0ptRvF1lnRKHXaLI/uqy/K9SBaOaEN8/
         sapHpxBLyX256Ya0HltrCdkDJcMQwRGPC1KgYgRUV92TrDlO3XysNumlIQFvC/uVyPAl
         JNBLKDkhvoknBFj7JclVTQS1Z3NggjaTtBMcwFMDRnuL4Z0DHEbzH531WVo2Nh27rYBK
         kC/qBJh3XcN9rqA20JwA1VpdPU5DLJuSnfVxMD8bfH1l4MXfcw6+hGkVIoU34zIxglma
         8OBw==
X-Gm-Message-State: APjAAAVUxJ7diQwhtqhfmOoG8uXNKPOXk6ocFTUyhabQuPn2CSKYtu8p
        3mX+vJ/cs3FJ5LnuG5a4OeMTXg==
X-Google-Smtp-Source: APXvYqznhLu3pkDLRhIZaeCnSQT/mT9vHrnEax9MJ7d8wP8ZSTawPdwoSoNBFcCMfZSxbMFkUvb6+Q==
X-Received: by 2002:a37:dcc4:: with SMTP id v187mr7145177qki.290.1558029416922;
        Thu, 16 May 2019 10:56:56 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id o6sm972349qtc.47.2019.05.16.10.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 10:56:56 -0700 (PDT)
Date:   Thu, 16 May 2019 13:56:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, mm-commits@vger.kernel.org,
        tj@kernel.org, guro@fb.com, dennis@kernel.org,
        chris@chrisdown.name,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: + mm-consider-subtrees-in-memoryevents.patch added to -mm tree
Message-ID: <20190516175655.GA25818@cmpxchg.org>
References: <20190212224542.ZW63a%akpm@linux-foundation.org>
 <20190213124729.GI4525@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213124729.GI4525@dhcp22.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 13, 2019 at 01:47:29PM +0100, Michal Hocko wrote:
> On Tue 12-02-19 14:45:42, Andrew Morton wrote:
> [...]
> > From: Chris Down <chris@chrisdown.name>
> > Subject: mm, memcg: consider subtrees in memory.events
> > 
> > memory.stat and other files already consider subtrees in their output, and
> > we should too in order to not present an inconsistent interface.
> > 
> > The current situation is fairly confusing, because people interacting with
> > cgroups expect hierarchical behaviour in the vein of memory.stat,
> > cgroup.events, and other files.  For example, this causes confusion when
> > debugging reclaim events under low, as currently these always read "0" at
> > non-leaf memcg nodes, which frequently causes people to misdiagnose breach
> > behaviour.  The same confusion applies to other counters in this file when
> > debugging issues.
> > 
> > Aggregation is done at write time instead of at read-time since these
> > counters aren't hot (unlike memory.stat which is per-page, so it does it
> > at read time), and it makes sense to bundle this with the file
> > notifications.
> > 
> > After this patch, events are propagated up the hierarchy:
> > 
> >     [root@ktst ~]# cat /sys/fs/cgroup/system.slice/memory.events
> >     low 0
> >     high 0
> >     max 0
> >     oom 0
> >     oom_kill 0
> >     [root@ktst ~]# systemd-run -p MemoryMax=1 true
> >     Running as unit: run-r251162a189fb4562b9dabfdc9b0422f5.service
> >     [root@ktst ~]# cat /sys/fs/cgroup/system.slice/memory.events
> >     low 0
> >     high 0
> >     max 7
> >     oom 1
> >     oom_kill 1
> > 
> > As this is a change in behaviour, this can be reverted to the old
> > behaviour by mounting with the `memory_localevents' flag set.  However, we
> > use the new behaviour by default as there's a lack of evidence that there
> > are any current users of memory.events that would find this change
> > undesirable.
> > 
> > Link: http://lkml.kernel.org/r/20190208224419.GA24772@chrisdown.name
> > Signed-off-by: Chris Down <chris@chrisdown.name>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Roman Gushchin <guro@fb.com>
> > Cc: Dennis Zhou <dennis@kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> FTR: As I've already said here [1] I can live with this change as long
> as there is a larger consensus among cgroup v2 users. So let's give this
> some more time before merging to see whether there is such a consensus.
> 
> [1] http://lkml.kernel.org/r/20190201102515.GK11599@dhcp22.suse.cz

It's been three months without any objections. Can we merge this for
v5.2 please? We still have users complaining about this inconsistent
behavior (the last one was yesterday) and we'd rather not carry any
out of tree patches.
