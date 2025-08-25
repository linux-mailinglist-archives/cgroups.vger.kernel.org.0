Return-Path: <cgroups+bounces-9385-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D25F4B348B0
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 19:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 872E04E15D1
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 17:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D0B3019BA;
	Mon, 25 Aug 2025 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3dx7lD8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C735963;
	Mon, 25 Aug 2025 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143122; cv=none; b=bBljjDLopmM//vJl4/D5eU9nTt0lqQqckjcnjwD+kSmWi4YDw/nKgrx0wHyyo6t2hcmrDxDlly3c8rPmwUSXKsdsTjtz6OIgQg4hlY/5x7Kg0Pr+zjiY8FPPV1MZh8OdwkSk70+UefoSadZMRRUiz3Bu0EUsTkVvpzlfSqFXza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143122; c=relaxed/simple;
	bh=4qcAs+1ROLAV5dnsReWbrjH1v8dr+3hzCk8V8zeLZz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFfGia9M0XQ4N784/G0Lnctu9cmzajDtLhx/5otL2GmQMUCxf1f6m1OPUpDpFPpVPRBxN0DyHu5KuMKiQ7oVRcStXvKcTX8Cczyx7YrHV8PSvJ856lVmX0OAG5jO0SNzWGXdGj5+ic32KP1nsanIYjGOpJd0H5AQIeymjQ2ZSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3dx7lD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5848C4CEED;
	Mon, 25 Aug 2025 17:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756143121;
	bh=4qcAs+1ROLAV5dnsReWbrjH1v8dr+3hzCk8V8zeLZz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l3dx7lD8GOj8/7hu1fCT7oYw7GXxwv1aNDuZo161KKWYQ99KJ8BWu22I841UVVrgz
	 TOYnEZdizXG3YFOIlxPVie+hg6ANVFW1e2zsh1SgiLlHGTcq2AGGWMc+uEkZUiBhiG
	 Vg66w8rmA5uf8M42uXffmztP2WH3HVZEr2IOrT/cyY4umDKqkaS+rwI5KN62aeU+Fv
	 qGmhG2/+neV5Qn9GEHCSrwurGhWet8Gezx60t9TgwCfonRrGlCS4WQsofDeRZLimE6
	 PDgUi4q7iLxGuUNABrZVNYJkiigx/o7TeqLYET5lHCcEsYEdUaJJHqPPVo2N8xx1Ji
	 xognF2fSZBugA==
Date: Mon, 25 Aug 2025 07:32:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org,
	mkoutny@suse.com, peterz@infradead.org, zhouchengming@bytedance.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v2 2/2] cgroup/psi: Set of->priv to NULL upon file release
Message-ID: <aKyeEIArL3gs0jNF@slm.duckdns.org>
References: <20250822070715.1565236-1-chenridong@huaweicloud.com>
 <20250822070715.1565236-3-chenridong@huaweicloud.com>
 <aKitWH39wpfTF5st@slm.duckdns.org>
 <2025082322-canopener-snugness-14e3@gregkh>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025082322-canopener-snugness-14e3@gregkh>

Hello, Greg.

On Sat, Aug 23, 2025 at 08:43:48AM +0200, Greg KH wrote:
> > Applied to cgroup/for-6.17-fixes.
> 
> Both or just this second patch?  Should I take the first through the
> driver-core tree, or do you want to take it through the cgroup tree?  No
> objection from me for you to take both :)

Sorry about the lack of clarity. Just the second one. The first one looks
fine to me but it would probably be more appropriate if you take it.

Thanks!

-- 
tejun

