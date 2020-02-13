Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE3DE15C06F
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2020 15:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgBMOgo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Feb 2020 09:36:44 -0500
Received: from foss.arm.com ([217.140.110.172]:47346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgBMOgn (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 13 Feb 2020 09:36:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D3771FB;
        Thu, 13 Feb 2020 06:36:43 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 724E83F68F;
        Thu, 13 Feb 2020 06:36:42 -0800 (PST)
Date:   Thu, 13 Feb 2020 14:36:40 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Fix a race condition when reading cpuset.*
Message-ID: <20200213143639.6jw2kiadjzyu6unr@e107158-lin.cambridge.arm.com>
References: <20200211141554.24181-1-qais.yousef@arm.com>
 <20200212221543.GL80993@mtj.thefacebook.com>
 <20200213115015.hkd6uqwfjosxjfpm@e107158-lin.cambridge.arm.com>
 <20200213135645.GG88887@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213135645.GG88887@mtj.thefacebook.com>
User-Agent: NeoMutt/20171215
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 02/13/20 08:56, Tejun Heo wrote:
> Hello,
> 
> On Thu, Feb 13, 2020 at 11:50:16AM +0000, Qais Yousef wrote:
> > I ran 500 iterations of cpuset_hotplug_test.sh on the branch, it passed.
> > 
> > I also cherry-picked commit 6426bfb1d5f0 ("cpuset: Make cpuset hotplug synchronous")
> > into v5.6-rc1 and ran 100 iterations and it passed too.
> 
> Awesome, thanks for verifying.
> 
> > While investigating the problem, I could reproduce it all the way back to v5.0.
> > Stopped there so earlier versions could still have the problem.
> > 
> > Do you think it's worth porting the change to stable trees? Admittedly the
> > problem should be benign, but it did trigger an LTP failure.
> 
> I'm afraid not. It's not an issue which would affect actual use cases
> and there's (as always) some risks involved with backporting it, so
> the benefit just doesn't seem justifiable here.

Yeah I can't see how a real application would depend on this functionality
other than for informational reasons. Or testing like in this case.

Thanks

--
Qais Yousef
