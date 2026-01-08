Return-Path: <cgroups+bounces-12985-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D62D0372C
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 15:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DEB4307B30D
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411C844DB68;
	Thu,  8 Jan 2026 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Di4j+R9k"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7809638B645;
	Thu,  8 Jan 2026 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880337; cv=none; b=DY5T6d7q4yvkVnSfkI8PLveWhleKUm8W9wT3lhRlaOMTZCDmsuRmxnotW63BC6DCVRQIW0xCfx3t8HvhHMJngLnqYdM+eCy3aEFuybR37a2uGy5n+Jb+XTgHyYgM/4Hr7kpvvciUrcOcELHcIc0wpOBMjEOaV/hg/RbeE+EtzBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880337; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzuZuftHp25DNS55sSAofvfJL+LkM9NQvCOm7dpZ/bJs2PPYy8mfq/d0d4BgJb329oHY1O3/HNjrRnXSr32N2OJ3n1eie1shGedYTTLTdXhQyIBYJrMX0+TgU6Oi5pYRGvtrSj1s/Ekm7f5BpZWaxgGGLByB0C1cjx0ckQHJok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Di4j+R9k; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Di4j+R9kLqA3lWNhGbECjRl2Ya
	bkBwXDK0fuqmHJtkr9n1SppYje7O1U/jbEoiceQ8gLEhvTdC2jz5oXEWzaIdWLYFT4zWRYJ2J8MxG
	24cAu8ywmVEUSkosNHWqEO5cC4+WmbDF31SUP9ThzWF4L7nJ3LAiiVJSZCHE4RZiOB45JiIhh5NnA
	r+88IG3izle6/WJ7fj58AdHeP3a0piaGt+lsOXX1UPad+ERnv+zz2VdTrz/zO/ZFm2CTXH6g8/qfS
	J30SsCmHGo0bLqiTO/F84fqu0+/niVQsbmIbdS6a9/bPCsUjFo8oG5BAJLJ3CXswTim08rYAv5wQP
	Lc/pcqAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdqQv-0000000HEdd-0r8g;
	Thu, 08 Jan 2026 13:52:13 +0000
Date: Thu, 8 Jan 2026 05:52:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, yukuai@fnnas.com,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, houtao1@huawei.com, zhengqixing@huawei.com
Subject: Re: [PATCH 3/3] blk-cgroup: skip dying blkg in
 blkcg_activate_policy()
Message-ID: <aV-2jeMsLFdFRsp5@infradead.org>
References: <20260108014416.3656493-1-zhengqixing@huaweicloud.com>
 <20260108014416.3656493-4-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108014416.3656493-4-zhengqixing@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


