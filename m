Return-Path: <cgroups+bounces-3177-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF2F9063A4
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 07:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF3D284A03
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 05:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C327B13698E;
	Thu, 13 Jun 2024 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tLNSuK4S"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C44613666E;
	Thu, 13 Jun 2024 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718258154; cv=none; b=CWi1uNygem7Bp1UBRpmNg5E2IAY0nySloVr1SyppmOaoGs+wiXVYvSMBqbtQDmS2WzT/r2gWLZ+F//HX+nlYYy3whEyAm2SylKBW8iS+jYt08O0hy9uf4tAmdZ/yBSFLyEMDrT6ZCHAEoC/Cuvl38h+kD3tYDmXOC9kkyIKEajM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718258154; c=relaxed/simple;
	bh=KN4qmdh/FyDgOSKi+sxrz5gqS8uoqP/5WyHmVrg1EdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCE0Jk6nlCW4FLS7TAX4nJ8vDnxvDJGtrbxdPAp8Vsk1jEndc8J3uRe8OP3jNoA7egGFxiyx3U3flL8RIVnG/AnoAtD8epewqmML+Cu93GZoqlwHSuaC7O9+uKkH0E+EMeY/bxHVb9ofV2eCLxphO7MG0uzMT2PkuQBosyEzfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tLNSuK4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC69C2BBFC;
	Thu, 13 Jun 2024 05:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718258154;
	bh=KN4qmdh/FyDgOSKi+sxrz5gqS8uoqP/5WyHmVrg1EdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tLNSuK4SrtIz4iPeZfziy2wNdi/nRPGrK/WdXTG5iNXf4Ag71rKLafE+lB6/6+yqo
	 3lVVZKszv3Lso7yve1Z/spq72zo1gR3Z8VAimKSc0Wj9uDaq6Nc1XPqVcZhC/afh8z
	 eX+H5DJIjwgU4PtiTO/qqanMqRQUS1VHiviZ5Zn8=
Date: Thu, 13 Jun 2024 07:55:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
	lizefan.x@bytedance.com, hannes@cmpxchg.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH RFC -next 1/7] kernfs: export pr_cont_kernfs_path()
Message-ID: <2024061314-moodiness-snowflake-14c5@gregkh>
References: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
 <20240613014937.1326020-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613014937.1326020-2-yukuai1@huaweicloud.com>

On Thu, Jun 13, 2024 at 09:49:31AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> This helper is used in iocost, prepare to build iocost as kernel module.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  fs/kernfs/dir.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 458519e416fe..84ad163a4281 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -279,6 +279,7 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
>  out:
>  	spin_unlock_irqrestore(&kernfs_pr_cont_lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(pr_cont_kernfs_path);

This isn't the helper that needs to be exported, it's a include wrapper
that is using this for cgroups.  Please document this much better and
perhaps, just fix up the cgroups code instead?

thanks,

greg k-h

