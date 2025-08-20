Return-Path: <cgroups+bounces-9287-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9FEB2D18D
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 03:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3C917FDF0
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 01:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF1927602F;
	Wed, 20 Aug 2025 01:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovubPvSz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE15C4317D;
	Wed, 20 Aug 2025 01:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755654382; cv=none; b=l7Wc1sakMMdvVffg4O279R2UztB7XU0fqFbxiuMHF2iMGbNtYaagXaPpo8LPxXSEPINEr1AEk/D84Q1VSWuLaJi6l2iL7Dd203ndPe7mBT9+kXqWXZ3d0sS45GnAbNGHQ4IxbJgkiub9OLmH33Z7hYISyqqrngjpRbW6++qekqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755654382; c=relaxed/simple;
	bh=2qQwZzUYtcKpxLRaqqdwF30G9WB9vf9KTnEJ2erud/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq93aU6NTg2B9tDBDtW6hNMn+YfgiMiU8mt0C8Q+wdEurwHplFBglkuA1OVThVMsiQlrdTG3CGtwa2EcHyW1FxzSMHPa+/IMqOHI8jjtuaLdorUxLhiTT6i0IUfxUKEBOmD8ta+5BvK7ds0dMS8vi3IFcVfAiAquxLA7gTLmhQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovubPvSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFADC4CEF1;
	Wed, 20 Aug 2025 01:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755654381;
	bh=2qQwZzUYtcKpxLRaqqdwF30G9WB9vf9KTnEJ2erud/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovubPvSz3FIuyJrPoUJZ4gU+GDPvEqp9ISkdsaoNpmXNMmay0d46CWlMC1lKU+yZH
	 SjW+Eyu6kpQUmCcsQG1ArbJLydzMIgsNv4K6e3DVY6RkHY7kOJPo71cpzD7byIwUEi
	 /cMKM5lNTKKBLKHJNQgyXKNBqJ+qigmZkxPCHQMvOeXoSBCaRBsY2+XAn59EjuB3c0
	 4j5Hvamdt8PlpZqW/sUlFd+l9GYBGU7FH664gobYo98mgc1T/+E49vBQ26fX8cnjBT
	 cMrlIJrUb5ULr5+fPQ5Z3IzOc5O2fZHlo4ZxLigOsUGGKImb0ubMjAVqxcAAdfONAi
	 sPiQlFOBqgCFw==
Date: Tue, 19 Aug 2025 15:46:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Baokun Li <libaokun1@huawei.com>, cgroups@vger.kernel.org,
	chenridong@huawei.com, gregkh@linuxfoundation.org,
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, mkoutny@suse.com, peterz@infradead.org,
	zhouchengming@bytedance.com, Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH] kernfs: Fix UAF in PSI polling when open file is released
Message-ID: <aKUo7BuX-teh4IzF@slm.duckdns.org>
References: <20250815013429.1255241-1-chenridong@huaweicloud.com>
 <0319ee9b-ce2c-4c02-a731-c538afcf008f@huawei.com>
 <e485b38a-183b-42c8-9aed-9c2d939add0b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e485b38a-183b-42c8-9aed-9c2d939add0b@huaweicloud.com>

Hello,

On Mon, Aug 18, 2025 at 04:00:08PM +0800, Chen Ridong wrote:
> > A potential solution is to make the lifecycles of cgroup_file_ctx and
> > psi_trigger match the struct kernfs_open_file they're associated with.
> > Maybe we could just get rid of the kernfs_release_file call in
> > kernfs_drain_open_files?
> >
> 
> Hi, Tj, what do you think about this solution?

So, I think it's really fragile for a killed (drained) kernfs_open_file to
be reused after the corresponding @kn is resurrected. Once killed, that file
should stay dead. I think it'd be best if we can do this in a generic manner
rather than trying to fix it only for poll.

kernfs_get_active() is the thing which gates active operations on the file.
Maybe we can add a wrapper, say, kernfs_get_active_of(struct
kernfs_open_file *of) which returns NULL if @of has already been killed or
the underlying @kn can't be activated?

Thanks.

-- 
tejun

