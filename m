Return-Path: <cgroups+bounces-10548-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 660D7BBD28B
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 08:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B898D4E4559
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 06:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C72C2561D9;
	Mon,  6 Oct 2025 06:49:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89553253B42;
	Mon,  6 Oct 2025 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759733342; cv=none; b=PQPNZAbnwv8oEb+6f493f6rFs2Lq5Aq8ugd2khlcRTVMVAWGQvQUBuCNhNFEsXbbyDQySdHABC/tfUrF2dynXs/YKLhaSNdsCbG3TzXD8a9dkEMjOIecZEu2cdHALZuyXbgK2RGHwqEbNpzhC8AMGO/OwdTdFYdbRA9JYm+siMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759733342; c=relaxed/simple;
	bh=Z4LdrZ/Ts5Ga6sHozSf8hV4b1Pia2AMnKln9zjgT6AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9biLpiZFokwDFxxn0wlhf2RXF2sONYw+iR5zHe7gioqnCl01HcEZYn2vDPDAImrWHDqZNxm3+rWY3zNYoUMy1ef/PTvr88JpLSQqKR1ByJijvGzH5YxKt3XdXWrkVE69yc9IdctdftLQ6C1HjzLKU6sPDuKbKSHLq6z3V0Qj5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F54E227A8E; Mon,  6 Oct 2025 08:48:49 +0200 (CEST)
Date: Mon, 6 Oct 2025 08:48:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <hailan@yukuai.org.cn>
Cc: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>,
	tj@kernel.org, ming.lei@redhat.com, nilay@linux.ibm.com,
	josef@toxicpanda.com, axboe@kernel.dk, akpm@linux-foundation.org,
	vgoyal@redhat.com, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, yukuai3@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 08/10] blk-cgroup: remove radix_tree_preload()
Message-ID: <20251006064848.GA10829@lst.de>
References: <20250925081525.700639-1-yukuai1@huaweicloud.com> <20250925081525.700639-9-yukuai1@huaweicloud.com> <20251003073724.GA12933@lst.de> <497b2eb9-a214-4887-ac89-bd2ddff3cb7d@yukuai.org.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <497b2eb9-a214-4887-ac89-bd2ddff3cb7d@yukuai.org.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 06, 2025 at 09:55:39AM +0800, Yu Kuai wrote:
> Sure, I can do that, perhaps after this set and cleanup blkg_conf_prep apis.

Yes, that sounds sensible.


