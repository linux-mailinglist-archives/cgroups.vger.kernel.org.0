Return-Path: <cgroups+bounces-8288-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B2CABFB43
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 18:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485B616E97F
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F9C221DA1;
	Wed, 21 May 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRICNdHn"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364A1C5F09;
	Wed, 21 May 2025 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845021; cv=none; b=sVkeKsinY1y3OQV10NUjq+QReArBqUwbxaw8caCDgEhrBW0DQxk1iC1nvYqAuooRFlHUTw9pN44mpD4uauW6G05GFRTmt4c25AtZ+E09EXF3rs7twc4V9YVtb4aB0h01AMYpuGFVJ75MKyWlRFi4RLuv//6jnrPbl1/Hc3rggYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845021; c=relaxed/simple;
	bh=TBKT53j1ZzWAdU9ZNkIj6bRV4r88F4Q4v6goyOVmE40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgnlV8jjhzd8449RR8dtHW/Ig1O2cNOx8mqMLopFrQLzcYTwN/LJloNUptT9UjA6ABk3tbS5RqKGhMG/r0QuhKgtkT7dgcuVyRWk9T5Mn5PdqwQIxsLWPaOdg1Vwi64iJfQo5d9XUuL4nOrJX/QR6gNwEX/eJwmcECUq4ipmVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRICNdHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A0BC4CEE4;
	Wed, 21 May 2025 16:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747845019;
	bh=TBKT53j1ZzWAdU9ZNkIj6bRV4r88F4Q4v6goyOVmE40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SRICNdHnk5ZfQ4BZ12LbWKVqwbmkQvECkH6aACSqU73mdY74isIny/u2rhKTpcu1N
	 AdquhS23K+yjXMvElYq4Ej+EUzi2WKVVzuvZLWpZMhvmOjtrclHYrftgNEq2Cy1bne
	 0SNBF2VxZtbWaxmvzbQuDL4BVCVvLsma1RAGRnSsEb56tpIhsPZB29F8+9v+9M5d1+
	 vQ2bxlZciEahwGjz43tpRhH9h4Yn0c5m0SqQl8/D+fkRkOhZpBOPGreJaHJCS/QH26
	 QtyiCXvmrpunlXy5r75hhpplw7OrQ8Whum5rrHpmjliyEJSPHAtOhAWqPpfrvdU3Ou
	 xVF3FSG6Zv4YA==
Date: Wed, 21 May 2025 06:30:18 -1000
From: Tejun Heo <tj@kernel.org>
To: "Shashank.Mahadasyam@sony.com" <Shashank.Mahadasyam@sony.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Shinya.Takumi@sony.com" <Shinya.Takumi@sony.com>
Subject: Re: [PATCH v2 1/3] cgroup, docs: be specific about bandwidth control
 of rt processes
Message-ID: <aC3_moeLiTc4x85y@slm.duckdns.org>
References: <20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com>
 <20250520-rt-and-cpu-controller-doc-v2-1-70a2b6a1b703@sony.com>
 <aCziA1tUAnnGId6_@slm.duckdns.org>
 <OSZPR01MB67115CCC104221C27EE63709939EA@OSZPR01MB6711.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSZPR01MB67115CCC104221C27EE63709939EA@OSZPR01MB6711.jpnprd01.prod.outlook.com>

Hello,

On Wed, May 21, 2025 at 01:14:53AM +0000, Shashank.Mahadasyam@sony.com wrote:
> Hi Tejun,
> 
> On 21 May 2025 5:11, Tejun Heo wrote:
> > > -WARNING: cgroup2 cpu controller doesn't yet fully support the control of
> > > +WARNING: cgroup2 cpu controller doesn't yet support the (bandwidth) control of
> >
> > This reads weird to me. Without the () part, it becomes "doesn't yet support
> > the control of". Maybe rephrase it a bit more?
> 
> I'm not sure how to rephrase it. It sounds fine to me 😅 Moreover, "doesn't
> yet support the control of" was the wording when the warning paragraph on
> RT_GROUP_SCHED was added in commit c2f31b79 (cgroup: add warning about RT
> not being supported on cgroup2). Would removing the parentheses, making it
> "doesn't yet support the bandwidth control of", sound better?

You're right. I was thinking about sched_ext not RT. Lemme apply the patch
as-is.

Thanks.

-- 
tejun

