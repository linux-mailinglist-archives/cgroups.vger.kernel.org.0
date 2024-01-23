Return-Path: <cgroups+bounces-1217-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00B9838968
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 09:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E1E1F2B2D3
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231735786E;
	Tue, 23 Jan 2024 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D6iyN1EW"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0DD57316;
	Tue, 23 Jan 2024 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999592; cv=none; b=tBaOg/gjdD4spUkomwDo0crrZSV5nvIJOaAj8zka+Zr3eD8QiAzBOVU2Qa87EmT6Xqy1wjCLtM7GqNBElVZMbkvTWK/f3+S1poD4LJ9PCXrIt2kPwr4/Hmr8gbYmcTqwvDti6yw1LCEjhMlMgKzIXbBmouTHAspk6khvlREsTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999592; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWBy8pbdEEmDg8RNgLS+4SVuvLd8AJzCueNDX+wZVcvBFKUzy5QRNHNrbYv4zulYimSngSu80kzHn3S6hizWCjbkRa5EMv+S/pVzMBqBSZIrFE+Q69mMVAIhOh8LY4R4QrTT/qi5Qck9t8vq00Pk/diQTMgDjE0fMYsA2HoQIsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D6iyN1EW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=D6iyN1EWmmMw2R0pqSUNme4xDL
	UvmpKetVaKS+eeWapPSFD8YqOeYMaPf0jCnW8rL3M9hnqG/ekImj2UsO5xS4EURLl7X4aWzAoMq3G
	EfWx2xDrVAT4Vv3kmgLmiNNvNEcchk5bKbhonvH/qij/dQOZVybk0ILxMM/EXeFoYMrK+7Gf5NKYI
	x1lbZx/tHMW716TCozDMR3ZN3xlwhXdPg3OTBfCk/SMiT3vu+YEnCQ2Q/FM+k1wZs9M5hsd14uakV
	NUI+Ruxe0VFn8AsBpHFONAGvBln/97K+cRbLm0lMttUVm+ZsbksRn7QX2is1jzB48BXqTUSNXCeLx
	YZX8xsiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCQO-00FcWD-0C;
	Tue, 23 Jan 2024 08:46:28 +0000
Date: Tue, 23 Jan 2024 00:46:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: tj@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	chunguang.xu@shopee.com
Subject: Re: [PATCH] blk-throttle: Eliminate redundant checks for data
 direction
Message-ID: <Za985ElMjsCWPwY3@infradead.org>
References: <20240123081248.3752878-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123081248.3752878-1-yizhou.tang@shopee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

