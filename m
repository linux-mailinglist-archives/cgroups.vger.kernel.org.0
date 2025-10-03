Return-Path: <cgroups+bounces-10528-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF48BB62FC
	for <lists+cgroups@lfdr.de>; Fri, 03 Oct 2025 09:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFFE14E9E3C
	for <lists+cgroups@lfdr.de>; Fri,  3 Oct 2025 07:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35D52475CB;
	Fri,  3 Oct 2025 07:37:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A81487F6;
	Fri,  3 Oct 2025 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759477050; cv=none; b=CdMILLXnvVVdIfhqFROTfb7S/N8k2VWjPpNbHvzSNETvWcSK/ahi21NckHsQHimOF6R5ithG1OelU4k46NPzpPIFlGMokFeZK00OBIqk7je4DIL5BZR+VoSWErvqT5TLoLntzn8iUltWsFrj7Ap6XMlj8vWbK3N36ihdFFW+4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759477050; c=relaxed/simple;
	bh=8oMk1tTNDdnAc4sOlWr73sowsuiT1oXGCOPgrarjzjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBoH2NS3RJCeJm1pVtTHnEMHnpyyU/AWKiqqdsJlm64GGdGnH72zo75Wc2xmVMmZoB7tG4K1InP4PCyRSHXdmBJuyHMyJ6sWiPMVTE7VuPs3eteQp4O1Kf3+4sTtmfk84XEGKKpKKdMAJ2eLw3A7bMHjdK9duG0ROZ4Gjj3tImc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EAF2C227AAC; Fri,  3 Oct 2025 09:37:24 +0200 (CEST)
Date: Fri, 3 Oct 2025 09:37:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, ming.lei@redhat.com, nilay@linux.ibm.com, hch@lst.de,
	josef@toxicpanda.com, axboe@kernel.dk, akpm@linux-foundation.org,
	vgoyal@redhat.com, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, yukuai3@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 08/10] blk-cgroup: remove radix_tree_preload()
Message-ID: <20251003073724.GA12933@lst.de>
References: <20250925081525.700639-1-yukuai1@huaweicloud.com> <20250925081525.700639-9-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925081525.700639-9-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Sep 25, 2025 at 04:15:23PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that blkcg_mutex is used to protect blkgs, memory allocation no
> longer need to be non-blocking, this is not needed.

Btw, this might also be a good time to convert from the old radix tree
to an xarray.


