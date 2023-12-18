Return-Path: <cgroups+bounces-974-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52888176FF
	for <lists+cgroups@lfdr.de>; Mon, 18 Dec 2023 17:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29BDFB2474B
	for <lists+cgroups@lfdr.de>; Mon, 18 Dec 2023 16:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1533D576;
	Mon, 18 Dec 2023 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgMvrh7w"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEC73D56F;
	Mon, 18 Dec 2023 16:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C376C433C7;
	Mon, 18 Dec 2023 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702915741;
	bh=cOm2dIgu3pqKuuN+O7eq+QXxoJeltRgUhvRQY2vvd60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cgMvrh7wxDkB+PTk/oxopzMiU0neWJLcw6xW0BEPyw2Ux5Yv+ET+Dhu2eTaI13THS
	 q4+aMFO2T4HGD2aW445NfDowVb75FMwEf0s71hC6cMPpZ2cH2+KTbwDIqv9icCbvuc
	 9cO7CS3U7fG0TzpeirO/dJ6WDj8DXmfV7R2rAssYvYjqkwNjvG9w4ZcdwHaXOTCKU8
	 PTq1l5+HYyGHA7JdaIAqQ6b87JyNwfpMkITrgJwaUyA2zTU7bI9R4joVZ0fbi7TooD
	 870OMXighFFLmkwQY1/ecTzNot9Mpv/Xy8HKT1YTYgqQ4r/HZ8N0GXGKGFC179jP6L
	 2EFC/qsH8aZsA==
Date: Mon, 18 Dec 2023 09:08:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, tj@kernel.org, hch@lst.de, linux-block@vger.kernel.org,
	cgroups@vger.kernel.org, Kundan Kumar <kundan.kumar@samsung.com>
Subject: Re: [PATCH] block: skip cgroups for passthrough io
Message-ID: <ZYBumts89QyXjzCu@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20231218153411epcas5p15bfb9e24856b5d719501c375e2bf3897@epcas5p1.samsung.com>
 <20231218152722.1768-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218152722.1768-1-joshi.k@samsung.com>

On Mon, Dec 18, 2023 at 08:57:22PM +0530, Kanchan Joshi wrote:
> From: Kundan Kumar <kundan.kumar@samsung.com>
> 
> Even if BLK_CGROUP is enabled, it does not work for passthrough io.
> So skip setting up blkg for passthrough bio.
> 
> Reduced processing gives ~5% hike in peak-performance workload.

Looks good. Our passthrough commands still need to call bio_set_dev()
for integrity data, so this is type of check is the easiest way to avoid
the overhead.

Reviewed-by: Keith Busch <kbusch@kernel.org>

