Return-Path: <cgroups+bounces-92-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BD77D770C
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 23:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521112812F2
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 21:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBADC347AE;
	Wed, 25 Oct 2023 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EGcnm8qa"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2AD1401F
	for <cgroups@vger.kernel.org>; Wed, 25 Oct 2023 21:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C10C433C7;
	Wed, 25 Oct 2023 21:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1698270487;
	bh=FivMY2UZEjYxUUisKcHog0hj9YelNqxTfva3B6Fv7W8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EGcnm8qaNwuS8KZJm/tL05RTzbs4uEVOWgI7qv8c8ygV5VynW6dZye1e0s/0KealV
	 Xy0muOhCQ7qq2dN3Jh6wi5eazMXItrFhT+YHNc0QAfgBg3e6kjyDndOZve78/PeTzr
	 sm4kR8kKiFdOE+BdDBcJ2czXWYpZ1tC12xV1EVI8=
Date: Wed, 25 Oct 2023 14:48:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: Michal Hocko <mhocko@suse.com>, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, shakeelb@google.com, cgroups@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 1/2] memcg, oom: unmark under_oom after the oom killer
 is done
Message-Id: <20231025144806.a10f34be15e564871861f698@linux-foundation.org>
In-Reply-To: <1a8ee686-e416-466b-4f6d-1dd26212b360@shopee.com>
References: <20230922070529.362202-1-haifeng.xu@shopee.com>
	<ZRE9fAf1dId2U4cu@dhcp22.suse.cz>
	<6b7af68c-2cfb-b789-4239-204be7c8ad7e@shopee.com>
	<ZRFxLuJp1xqvp4EH@dhcp22.suse.cz>
	<94b7ed1d-9ca8-7d34-a0f4-c46bc995a3d2@shopee.com>
	<ZRF/CTk4MGPZY6Tc@dhcp22.suse.cz>
	<fe80b246-3f92-2a83-6e50-3b923edce27c@shopee.com>
	<ZRQv+E1plKLj8Xe3@dhcp22.suse.cz>
	<9b463e7e-4a89-f218-ec5c-7f6c16b685ea@shopee.com>
	<ZRvH2UzJ+VlP/12q@dhcp22.suse.cz>
	<1a8ee686-e416-466b-4f6d-1dd26212b360@shopee.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 09:59:25 +0800 Haifeng Xu <haifeng.xu@shopee.com> wrote:

> 
> 
> On 2023/10/3 15:50, Michal Hocko wrote:
> > On Thu 28-09-23 11:03:23, Haifeng Xu wrote:
> > [...]
> >>>> for example, we want to run processes in the group but those parametes related to 
> >>>> memory allocation is hard to decide, so use the notifications to inform us that we
> >>>> need to adjust the paramters automatically and we don't need to create the new processes
> >>>> manually.
> >>>
> >>> I do understand that but OOM is just way too late to tune anything
> >>> upon. Cgroup v2 has a notion of high limit which can throttle memory
> >>> allocations way before the hard limit is set and this along with PSI
> >>> metrics could give you a much better insight on the memory pressure
> >>> in a memcg.
> >>>
> >>
> >> Thank you for your suggestion. We will try to use memory.high instead.
> > 
> > OK, is the patch still required? 
> Yes
> As I've said I am not strongly opposed,

I'm confused.  You (Haifeng Xu) are looking at using memory.high for
your requirement, yet you believe that this patch is still required? 
This seems contradictory.

Oh well.  I think I'll drop this patch for now.  If you believe that
kernel changes are still required, please propose something for
6.7-rcX.


