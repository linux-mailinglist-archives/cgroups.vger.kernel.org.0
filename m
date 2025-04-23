Return-Path: <cgroups+bounces-7748-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64911A98FDF
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377AA168088
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AB12918DA;
	Wed, 23 Apr 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqFCgjGr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E971D28E61A;
	Wed, 23 Apr 2025 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420799; cv=none; b=dwyUAu+mTen9F7PgyVEzpg1Cbn8xJGeG4U16gMbUWJHqec7nvMAWGNg8xVqWSBeSMsihEWv3jo/xYDYJAqA4cE0toXFYWwTJ8LlgfStuql/oGLRu/Zh0hoTs0uIukKN7cruI0173pQoprONoEnAzrmLKWZKivtJg1HWdNtf5VhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420799; c=relaxed/simple;
	bh=CWuXBa/3BXzP9DGq30t6Um3x4Mn6OezMOQl57MsTF/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHz0hDghVloIvciDhQe8R82+wlSdnnj9KSw/d3RpIPhq+mXQLecA/sjplm66In5pFbALaOSOKiymMXKyvGeuVmacAHLLJ5zuC7iyBfWh2ktS0K6yoNhUvFVTZ/lKrCh0A7niEZNtw/h8AP3hSW8FWBeokiJT2dS0cSyPOBsBAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqFCgjGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898E3C4CEEB;
	Wed, 23 Apr 2025 15:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745420798;
	bh=CWuXBa/3BXzP9DGq30t6Um3x4Mn6OezMOQl57MsTF/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqFCgjGry8oZEnY339wyWGJrZ4nHsE1BzO0r39Pnj8fu1KO9R6fAxYp+/M2hUWaaZ
	 41uwFMOQVrCGSJ4WAfPI2uEzwOm0I9qmMqPP0Z0cuKwQVYiQkmPtk84uf/OTaej+Qz
	 jmCBePX8wgOJ0asxifVm4TZgn5iLFED4MbXU8gsr3bsTGsR71PjwGqe8WhH/GwVaXW
	 CAQHGE0UDmSMBMaAJ6CYH65yxM4zoiUtF5Y8Sb4MwVsVFDCQ3201MuA6wQ3EETJQ6a
	 JkeYBoFSRAeuUee5LH8sIAVdkz1+mp6RSeSfJCL0GXU4n/+jtZx0FGhaJ/1tZWAjUD
	 ubGpK04lOeYjA==
Date: Wed, 23 Apr 2025 05:06:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <christian@brauner.io>,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: don't autoload block drivers on stat (and cgroup configuration)
Message-ID: <aAkB_Vj-ukOPeoTn@slm.duckdns.org>
References: <20250423053810.1683309-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423053810.1683309-1-hch@lst.de>

On Wed, Apr 23, 2025 at 07:37:38AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> Christian pointed out that the addition of the block device lookup
> from stat can cause the legacy driver autoload to trigger from a plain
> stat, which is a bad idea.
> 
> This series fixes that and also stops autoloading from blk-cgroup
> configuration, which isn't quite as bad but still silly.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

