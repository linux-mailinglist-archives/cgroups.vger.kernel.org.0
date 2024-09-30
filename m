Return-Path: <cgroups+bounces-4989-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2975E98AAC2
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 19:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA121F23048
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 17:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA24195980;
	Mon, 30 Sep 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOK28VA4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B5A194C85;
	Mon, 30 Sep 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716305; cv=none; b=QSiWNShYGNobI/vfxNGGbWxpat7apl3q+u4cbMTu+F9PNvffj4ULzl5QzktdZnSQNh7A6ZtpGMj756d9N9aIe08ZXZJ2lxZhGM60sxmJ7Slgn4K/F/YJMANpZNflMyex+9RD1Z1bADnehtOrx2EYxrZHX9pkYXSlAxRssWpPH9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716305; c=relaxed/simple;
	bh=o1K5k91qZFtJQYCTb40/SpUrr1tTX/a1xr5upzEJtqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTTSPjdBsuAbGWL9F7hSNhvfyg421u7J7+beh7t0BS31Cl+tviiNpEs0B6g6ALdc0vghJvg5xK0x9vsrfCVrB8I2iMD4MsiDUbGdvqvD/YU6sWBWegm/nYyz7D9vYuAJ5x2bNzNXOLDGqtZ77ohjJ55XS2v7z7s/7wS1WK1oDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOK28VA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FF4C4CEC7;
	Mon, 30 Sep 2024 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727716305;
	bh=o1K5k91qZFtJQYCTb40/SpUrr1tTX/a1xr5upzEJtqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOK28VA42BH/9l2Mzkt+edgDzkh6uVrog9wYVsopfRRVbkfwtJWfC86r6AObas7G/
	 X7uRmDPJgy6yElqw4vny6Y41Hnz9hH5maV9JkMPsYBlW0sljV7Vtif9L1XC+TFQOew
	 zpQHmZqsZUBknmVA/DNvYQSlXowhFSTJdXlQ1zZJ0R6w3P1r7+J37IMfjcbuzfHbIE
	 BacLyk6zEaM6NNjOJSJIdA3nkAeBOFmZZUY1sk+OSNSQZ0zGxEjCwmKAEhW0N/D6Em
	 TkEWrtUXngL09fL8K9soegSbM5+VmeOwg6k1XVcxx1JfCiaqegTpfni2eA55Kz9Ky1
	 1jh7t1wS8CEcw==
Date: Mon, 30 Sep 2024 07:11:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 1/5] blk-cgroup: add a new helper blkg_print_dev_name()
Message-ID: <Zvrb0DXhtVHT2lfa@slm.duckdns.org>
References: <20240930085302.1558217-1-yukuai1@huaweicloud.com>
 <20240930085302.1558217-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930085302.1558217-2-yukuai1@huaweicloud.com>

Hello,

On Mon, Sep 30, 2024 at 04:52:58PM +0800, Yu Kuai wrote:
> +static inline bool blkg_print_dev_name(struct seq_file *sf,
> +				       struct blkcg_gq *blkg)
> +{
> +	struct gendisk *disk = blkg->q->disk;
> +
> +	if (!disk)
> +		return false;
> +
> +	seq_printf(sf, "%u:%u", disk->major, disk->first_minor);
> +	return true;
> +}
> +

I wonder whether we just should add a name field to disk.

Thanks.

-- 
tejun

