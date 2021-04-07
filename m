Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72093560D8
	for <lists+cgroups@lfdr.de>; Wed,  7 Apr 2021 03:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347778AbhDGBja (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Apr 2021 21:39:30 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:62074 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347776AbhDGBj3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Apr 2021 21:39:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617759561; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=SMzPWIhKVgVyt+OXV36wrD1CBWot3oCL7BANrZGmW5s=; b=cO9zL63saxu6n6wm4Cfy6jPx2QwV5tCamd+cAm6fP6v4OBUtsrZJVP49MoTaxtPs5HES9Bp5
 Jpkhri3pF66Ac5e0Z3hOQobvYypnAn4t541c7ZUSVvUXd0Bn+6EGmr730ysAnou6BB2+kTMu
 I1xaK+tWC/shWBlm/G16JLA7YEA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3MmZiMyIsICJjZ3JvdXBzQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 606d0d369a9ff96d95415e7d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 07 Apr 2021 01:39:02
 GMT
Sender: pkondeti=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DF21BC43465; Wed,  7 Apr 2021 01:39:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F9AEC433C6;
        Wed,  7 Apr 2021 01:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F9AEC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pkondeti@codeaurora.org
Date:   Wed, 7 Apr 2021 07:08:56 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Quentin Perret <qperret@google.com>, Wei Wang <wvw@google.com>
Subject: Re: [PATCH] cgroup: Relax restrictions on kernel threads moving out
 of root cpu cgroup
Message-ID: <20210407013856.GC21941@codeaurora.org>
References: <1617714261-18111-1-git-send-email-pkondeti@codeaurora.org>
 <YGxjwKbec68sCcqo@slm.duckdns.org>
 <20210406152715.GB21941@codeaurora.org>
 <YGyJHAlLKqng2WeS@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGyJHAlLKqng2WeS@slm.duckdns.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 06, 2021 at 12:15:24PM -0400, Tejun Heo wrote:
> Hello,
> 
> On Tue, Apr 06, 2021 at 08:57:15PM +0530, Pavan Kondeti wrote:
> > Yeah. The workqueue attrs comes in handy to reduce the nice/prio of a
> > background workqueue if we identify that it is cpu intensive. However, this
> > needs case by case analysis, tweaking etc. If there is no other alternative,
> > we might end up chasing the background workers and reduce their nice value.
> 
> There shouldn't be that many workqueues that consume a lot of cpu cycles.
> The usual culprit is kswapd, IO related stuff (writeback, encryption), so it
> shouldn't be a long list and we want them identified anyway.
> 
Sure. I have not done a complete study on which workers in our system can
compete with important tasks in other cgroups. We will have to do that to
adjust the workqueue priority so that the impact can be minimized.

> > The problem at our hand (which you might be knowing already) is that, lets say
> > we have 2 cgroups in our setup and we want to prioritize UX over background.
> > IOW, reduce the cpu.shares of background cgroup. This helps in prioritizing
> > Task-A and Task-B over Task-X and Task-Y. However, each individual kworker
> > can potentially have CPU share equal to the entire UX cgroup.
> > 
> > -kworker/0:0
> > -kworker/1:0
> > - UX
> > ----Task-A
> > ----Task-B
> > - background
> > ----Task-X
> > ----Task-Y
> > Hence we want to move all kernel threads to another cgroup so that this cgroup
> > will have CPU share equal to UX.
> > 
> > The patch presented here allows us to create the above setup. Any other
> > alternative approaches to achieve the same without impacting any future
> > designs/requirements?
> 
> Not quite the same but we already have
> /sys/devices/virtual/workqueue/cpumask which affects all unbound workqueues,
> so maybe a global default priority knob would help here?
> 

yeah, not exactly what we are looking for. It gives us the abiility to restrict
the priority of all unbound workqueues at the expense of not being able to
prioritize one workqueue over another workqueue.

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

