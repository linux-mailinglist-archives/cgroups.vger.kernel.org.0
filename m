Return-Path: <cgroups+bounces-5354-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7683E9B80A9
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 17:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A141F21722
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9741BCA1B;
	Thu, 31 Oct 2024 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nxj1vdZn"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49BA1A0B00;
	Thu, 31 Oct 2024 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393732; cv=none; b=cxhVV5QSlUnR5F1J8BjMUW+twevCMahLd1y44U5BUvvyx5TC6X3zarKhul1Kw4VutLP9N+Uw5ajrK3MMmxSZhBqjEd3jjxOdhnBT5iLNsoukb2EHUjMKYlT4qF3JXVuuy0PY2qtnzeHGeHNqPXUJk8LdfKCN3OuxY5D5F+XN72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393732; c=relaxed/simple;
	bh=RCkl69TU1SUisOFnPs8Z0e879sBAtwgHjNlQIi3Ed4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am9VzKgmts8zOEZSHmOzM1O2aqBBl6lNQoMR+jfeVmz+ZGTEhHa3D7NBNxjMFRTYvkpiCFkoSr+cULKruN0t6Krm+q18beWlIbDbQdVgQFY5L4Zo5TpA0R9tDr+2z4mNinUi5gd7Thw1ko+Jsw8LKeNxaGT2+mrqjEQgIPIfNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nxj1vdZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BFFC4DE16;
	Thu, 31 Oct 2024 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730393732;
	bh=RCkl69TU1SUisOFnPs8Z0e879sBAtwgHjNlQIi3Ed4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nxj1vdZnWwFV2A2fv/DxL7cqhvvTn26UjRArr02r3a1Zk5zQkixt6TJliSoqsiP3I
	 gtMcNqARsFfZXAfagek297OgfFqo9qqqONm8DUEKeSrfBpQVqlGg7CAPJqG/wGg22H
	 8KO+LpFnDf7srfH/uG1rKto90W0yGwONfyMpd72VXMZ/1+nEdllhKnV/8MFPzysBer
	 gDO9NfC7T+2VksSRYlmrhYMIBfalVvgZCCykwVV7PYUwpU0zXRghbUOo7R4Gk/UJjW
	 taFR48navctuucxQ+7e2lqFNLQhLC4jk5H+Prt0it5kXDqya16pPCcnWdIu8XM/JTr
	 Ylkieb+RsS35Q==
Date: Thu, 31 Oct 2024 06:55:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 1/5] blk-cgroup: add a new helper blkg_print_dev_name()
Message-ID: <ZyO2g3Lh6rvDd8DP@slm.duckdns.org>
References: <20240930085302.1558217-1-yukuai1@huaweicloud.com>
 <20240930085302.1558217-2-yukuai1@huaweicloud.com>
 <Zvrb0DXhtVHT2lfa@slm.duckdns.org>
 <33183043-335f-fd07-1068-c873656f51d6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183043-335f-fd07-1068-c873656f51d6@huaweicloud.com>

Hello,

On Thu, Oct 31, 2024 at 04:04:00PM +0800, Yu Kuai wrote:
> > On Mon, Sep 30, 2024 at 04:52:58PM +0800, Yu Kuai wrote:
> > > +static inline bool blkg_print_dev_name(struct seq_file *sf,
> > > +				       struct blkcg_gq *blkg)
> > > +{
> > > +	struct gendisk *disk = blkg->q->disk;
> > > +
> > > +	if (!disk)
> > > +		return false;
> > > +
> > > +	seq_printf(sf, "%u:%u", disk->major, disk->first_minor);
> > > +	return true;
> > > +}
> > > +
> > 
> > I wonder whether we just should add a name field to disk.
> 
> And suggestions on this set now? I guess add a name filed is not
> appropriate. :(

Yeah, I don't know. I've always struggled a bit with block device names. We
use MAJ:MIN in all the input interfaces and mix the disk names and MAJ:MIN
when outputting and there are (or is it used to be now?) request_queues
without disk attached, so sometimes names are just not available.

Jens, do you any preference here? The proposed patch can be fine but e.g. it
can race against disk_release() if the caller isn't careful and it also
sucks not knowing the name in destruction path.

Thanks.

-- 
tejun

