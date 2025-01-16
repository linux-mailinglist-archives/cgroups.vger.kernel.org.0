Return-Path: <cgroups+bounces-6206-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C82FA14264
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 20:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1201188BE05
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 19:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5875222F825;
	Thu, 16 Jan 2025 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iONaSlxf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DA4414;
	Thu, 16 Jan 2025 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056305; cv=none; b=Vj3miAEja/xv396XOxzd1814vENEP1Vc9pNu2Uxe1HHnN7dds8PhwV/z1E+vHjkpoI6au6gS8CxEjlIGE7XMwOpJxtkQ79uAgFYJUrIU06qyQF8XmdY3s4NCOOKa/vspQ2XhZ8MvtQknrML5OYbIX7Y2wg3TrQxYffXerxlP0Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056305; c=relaxed/simple;
	bh=RxFx7NEwLlBZ3BpIT9eT1ehVipuZ4MJ3xS/m7OSzHWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR4nrmioUBzgsTFvqW/802P8HbTdxbuPRCl1aEnq42EDxpS5sdjVdjy9OXmnF5V/s3jQ7MyWljb90L3fNSJx65uaMdWaiWuY4KQvoYJSdjGIyoKEBmUk6MnuJzmJ2c5McLK7dvM3O+qX9pnXZzl6i454iVgltfK1zbNft/iLNLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iONaSlxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADB8C4CEDF;
	Thu, 16 Jan 2025 19:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737056304;
	bh=RxFx7NEwLlBZ3BpIT9eT1ehVipuZ4MJ3xS/m7OSzHWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iONaSlxfST1qdqEWGQ2P441CPj1c760XuNAxlZHm+frhzfr0zFAyQIjCIB/kMR88D
	 FCDCc4SfjNnUfmDi6otWEstvzdhMB+FJ6ROpzbylq2W9JZQQxuz6eiW00FCQ3ThH+5
	 m1SSlGFg2Oj2gSG47fztpDapx1tlA0sNuaddrExUwbk6Cqp5e2BMIWGrATiBqTnqVo
	 iTpdfqTzeoqfZPT+fhHBRVM2w8b1rlGus+df+2cjR1SWlt9g7hY5eftVRp7KUoedyp
	 g/oyqpLTw0Y/KaWIilYnYjwaxGMvvvpDdgJBkXoLTkZOrush3sOqwwdswrIYpxt5am
	 53ir8iGg3+7/w==
Date: Thu, 16 Jan 2025 09:38:23 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH] cgroup/cpuset: Move procfs cpuset attribute under
 cgroup-v1.c
Message-ID: <Z4lgLxZXjoKuMh3r@slm.duckdns.org>
References: <20250116095656.643976-1-mkoutny@suse.com>
 <b90d0be9-b970-442d-874d-1031a63d1058@redhat.com>
 <l7o4dygoe2h7koumizjqljs7meqs4dzngkw6ugypgk6smqdqbm@ocl4ldt5izmr>
 <Z4lA702nBSWNFQYm@slm.duckdns.org>
 <3ebd4519-4699-47ff-901e-a3ce30e45bcd@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ebd4519-4699-47ff-901e-a3ce30e45bcd@redhat.com>

On Thu, Jan 16, 2025 at 02:15:00PM -0500, Waiman Long wrote:
> 
> On 1/16/25 12:25 PM, Tejun Heo wrote:
> > Hello,
> > 
> > On Thu, Jan 16, 2025 at 03:05:32PM +0100, Michal Koutný wrote:
> > > On Thu, Jan 16, 2025 at 08:40:56AM -0500, Waiman Long <llong@redhat.com> wrote:
> > > > I do have some reservation in taking out /proc/<pid>/cpuset by default as
> > > > CPUSETS_V1 is off by default. This may break some existing user scripts.
> > > Cannot be /proc/$pid/cpuset declared a v1 feature?
> > > Similar to cpuset fs (that is under CPUSETS_V1). If there's a breakage,
> > > the user is not non-v1 ready and CPUSETS_V1 must be enabled.
> > I think we can try given that the config is providing an exit path. After
> > all, users who were depending on cpusets on v1 are in the same boat.
>
> I am not totally against this, but I think we need to make the relationship
> between the CPUSETS_V1 config and /proc/<pid>/cpuset file more visible if we
> want to go this route. We should update the help text of CPUSETS_V1 config
> entry to emphasize this.

+1

Thanks.

-- 
tejun

