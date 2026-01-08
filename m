Return-Path: <cgroups+bounces-12983-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F4AD03AAE
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 16:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EE533136345
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48D04F1556;
	Thu,  8 Jan 2026 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2ZKAaH9P"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598B44EAC81;
	Thu,  8 Jan 2026 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880276; cv=none; b=lBabBL2/AAtZMKkquGaXwOw36V3mK/UIRGCG/nmLLsBYrrSOKP9U8K1p9FGlYqwqMR2bci1eePRyvzqudQ+0N7yth+I+YQHvRf604eJkyv63DD8bVzpem3bJOiXmgD6TtQgYU/+eZ1T0wzT3JAt8EPCXlTESDyNtRmHzMLE8+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880276; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLz2poPzF6LuC5s4b9A3MuhJCK5ws1AvcpDXjbb4p+ySm1+YiAj3ZZfznJMVHG/p/MVAsCXWQjuyF9vjjv7TN0vyQi9prVHFzTAZHjpUSMIg0GnPKFsPd6H7yHXBWjox80v2pBwecajxyqAyTiIC4/wVxtN+zMagLt/u5/W5GQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2ZKAaH9P; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2ZKAaH9PBmRPaWo7Zg+Sh2J3x+
	wEO3kXxd9ZIZEv5v3Liqlz1ygQFwOsPuSnMJ1JxQiqL0+rtrI+aaHvnmRTIY+Xd51GWM8S0T6Jng9
	IWjZWNHACkBs9jQCWcIsxzi37wdQ6MHQGHrjmaw2aKRn9VPa89BonvVwPo9Q6KeTZ9M6dKcpgdFN/
	g3a6/JsADuVfjd+RQZS93h+pknUi50SvZqcfnK2HbUloTTMfuiPiR9UeNlwRoM0ci8PyDs1kKk7Rr
	Lxvz9uLVH31ULJ9GwVg9WBx95ee+tAuU/D9xl2kd2Lp814a02tk9mryURxcW2fgGgu7IMetAhlRCF
	WEnQpwrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdqPu-0000000HEUh-1h53;
	Thu, 08 Jan 2026 13:51:10 +0000
Date: Thu, 8 Jan 2026 05:51:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, yukuai@fnnas.com,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, houtao1@huawei.com, zhengqixing@huawei.com
Subject: Re: [PATCH 1/3] blk-cgroup: factor policy pd teardown loop into
 helper
Message-ID: <aV-2Tl8R3R0rm8ZF@infradead.org>
References: <20260108014416.3656493-1-zhengqixing@huaweicloud.com>
 <20260108014416.3656493-2-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108014416.3656493-2-zhengqixing@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


