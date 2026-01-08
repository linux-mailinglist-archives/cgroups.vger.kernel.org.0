Return-Path: <cgroups+bounces-12984-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6579ED04312
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 17:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E4A330F817F
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C775C38A70B;
	Thu,  8 Jan 2026 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KRs8LhlW"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AB238B639;
	Thu,  8 Jan 2026 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880302; cv=none; b=ZjOXVSHk/dQq6V+nYu5cowCcx0Ea9ASSNLqi5SWXOgDi6IEey8yys4MmbnRq4CB5bg4d9zIIKPZXnuvgYmuZnth5tkc+zCEMn9NlPCrnZ9AbeDkl6MvEM38EfvVDlGGLkDgJ/88sg7045Z2oUo6l/5/YDXwmMX3qgTh5bfcIczo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880302; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYxRGpTrzcXd8wX8J4GTmIanepko5WLdfBorN58nRe0ld2qGL0y8/Kxyi6xynsavqwu4WVdIesQu8N9xkbg+rKyH39nmG5hsClvzRmQ9SLPOcNykonbTJDQcCGJZFRQIZ/PxVH3Wu2fUx/DbWO6LeOeGtgF5oIPP7LWFQX9Advc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KRs8LhlW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=KRs8LhlWu7gethNiEGksxLzaoc
	ovNSQGqnYCmjMX948EkOGVhvFrfEb6YNnGJTy6op0FVS6o5FY+d0c4iGbzX5/6zANyV+y7iUDSIUp
	IEQ8ToKd5C/V08Cv0Wh4gj8L3x3lWBX9cCeo9OJyiv5O4Q4yPt1sOVER5hfgxiEVDyBM0bSZVrhSl
	cPDx0ZW29zqOTtFXFQcloG8TY4XPhFdHGyiKtxtVrRyCWl+5ljxnZc8FZbB4Y7cPs3h1LdXweQXsO
	K0iOKGc1hT+eYzoJQBHJXV0l6b2qQuzk9LQK3cG5lV0N8nlK1SxpH3AtewqA8i5FVKHbytFBLfG2G
	3ziJmqUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdqQL-0000000HEYb-1c9C;
	Thu, 08 Jan 2026 13:51:37 +0000
Date: Thu, 8 Jan 2026 05:51:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, yukuai@fnnas.com,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, houtao1@huawei.com, zhengqixing@huawei.com
Subject: Re: [PATCH 2/3] blk-cgroup: fix uaf in blkcg_activate_policy()
 racing with blkg_free_workfn()
Message-ID: <aV-2aXiHfjAJbh0O@infradead.org>
References: <20260108014416.3656493-1-zhengqixing@huaweicloud.com>
 <20260108014416.3656493-3-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108014416.3656493-3-zhengqixing@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


