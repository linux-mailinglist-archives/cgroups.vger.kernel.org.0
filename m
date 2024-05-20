Return-Path: <cgroups+bounces-2963-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1A48C9EF8
	for <lists+cgroups@lfdr.de>; Mon, 20 May 2024 16:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4F71F21F66
	for <lists+cgroups@lfdr.de>; Mon, 20 May 2024 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED7E136673;
	Mon, 20 May 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln+ZHaNM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830CF1E878;
	Mon, 20 May 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216385; cv=none; b=QKquuj1LqP0kJN3WpCCvJcox3cyKjkPwX54FGpfEzSUC0hueUa8uuyWGsw2a4yE1L7ztb7KxAOUhJI2P/T0XMsbmZIGtC+dcz5trIvj2d9rjvCNI/xWAFh6AdGkSuLpoXB9OtQcnhv6P1kRpq9J4IIzEEVHbs4eD7SUporZ1Pd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216385; c=relaxed/simple;
	bh=nkYor5RmQ81d94obxlBN808m0wZIacK6XzjCZHCe7dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lW7suEhZpxF9LDpo8YwweInr3z/fiYT58CXO9xp46Z8RwBIykqezxxo+byi+ft6si+3X/xzIiLTIDPFWyEB7Wnnfj8+g3HP2wroEyTit4mSvk/gS+xZapAxnC+6Lb3d7rRqtOb6RSrezclmYlKMVoq1tuUXAQJd9dcCInV1dnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln+ZHaNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB296C2BD10;
	Mon, 20 May 2024 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716216385;
	bh=nkYor5RmQ81d94obxlBN808m0wZIacK6XzjCZHCe7dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ln+ZHaNMsU/xVjFM9yVnYQqEJs4vY0NyRs9vgq/yJ38mTZ1h5xU/kaXHx53DhUvQj
	 Xl5S7TNuMUnnUUXWSxasIAQZ1kNfpwO96PM2KQMRQZcXePR5mcX0kKYX96g9A5/W9N
	 VOaDejndqUsXMh7jJGZ7h37xN/qVr27q+51Ve3atVeP9yXcfcAbD4kaTxUF5D9lGKP
	 2KCdbCPzdMs5F4CLftTg4dF3Q79FWXC1H9sVe/+zSvWWSRZMtI08EejIpozzX1L/Eh
	 Z2f6FIZC8Jedd494JII5VVOqE/qVPmoczTM+UHwgqD9z6jnsPPohWieqtq4wLSc04q
	 N/QXL1Von0s+w==
Date: Mon, 20 May 2024 08:46:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, emilne@redhat.com, hare@kernel.org,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com
Subject: Re: [PATCH v4 1/6] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <ZktiPV8h5y04YwXv@kbusch-mbp>
References: <20240514175322.19073-1-jmeneghi@redhat.com>
 <20240514175322.19073-2-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514175322.19073-2-jmeneghi@redhat.com>

On Tue, May 14, 2024 at 01:53:17PM -0400, John Meneghini wrote:
> @@ -130,6 +133,7 @@ void nvme_mpath_start_request(struct request *rq)
>  	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
>  		return;
>  
> +	atomic_inc(&ns->ctrl->nr_active);

Why skip passthrough and stats?

And I think you should squash the follow up patch that constrains the
atomics to the queue-depth path selector.

> +static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
> +{
> +	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
> +	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
> +	unsigned int depth;
> +
> +	list_for_each_entry_rcu(ns, &head->list, siblings) {
> +		if (nvme_path_is_disabled(ns))
> +			continue;
> +
> +		depth = atomic_read(&ns->ctrl->nr_active);
> +
> +		switch (ns->ana_state) {
> +		case NVME_ANA_OPTIMIZED:
> +			if (depth < min_depth_opt) {
> +				min_depth_opt = depth;
> +				best_opt = ns;
> +			}
> +			break;
> +
> +		case NVME_ANA_NONOPTIMIZED:
> +			if (depth < min_depth_nonopt) {
> +				min_depth_nonopt = depth;
> +				best_nonopt = ns;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +

I think you can do the atomic_inc here so you don't have to check the io
policy a 2nd time.

> +	return best_opt ? best_opt : best_nonopt;
> +}

