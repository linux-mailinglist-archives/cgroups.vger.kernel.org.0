Return-Path: <cgroups+bounces-9824-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6FBB4A4D3
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 10:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D84504E2526
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15503246BA9;
	Tue,  9 Sep 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GtD9GkhH"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917C62459FB;
	Tue,  9 Sep 2025 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405699; cv=none; b=YSc1lLNat3gQwCtci0cy5XPgSQ4CF986tcNazpbLApIhCsFkRZCSmVM5NW3IzhkSk5BavI4wOwt70O2FbM8GWoclXnbXFub6H3mxevJbFcBrZ8s5cbqjtHcVUslaTgbYtCLlLM+gm8XaDfNiN9EhA1RxEOAgHr9iaK7zV3paCB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405699; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLtxRFcoF513B7kafUmDbIgX5IY4kdM+s6mJjkTWtp9N/JZXu0J8Ol05DgEnZ83JmGMvMPehMNUtyVhBJhAAICfrUQrMz2TqDMN7mBkkVanWQojYKPGuJkiN498UQ+GCdsQEQtFHJmyzKaiFipTrEMUT41ZLjkKmNh1HurlxDoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GtD9GkhH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=GtD9GkhHfiF2wIBhN31xDVKO0D
	XIo92DbQZg3chR5TN2ZEYtChgHPoTtLLPYh8zMd2jaGRDypNRM051ehZ/K6nef/lxYGh2XLWxsbSw
	4vlLXhKAjFD01Hh4F4TAH5LqSbdGP066J29Q/qqnU2Ku0doEOktREEmr5+nGb0nRp44UNNKBzOzTc
	+OXrIuJ8d8zxBX658MoxvtIhilUQSun2NkHKffFhABK3dqyKT0oEAgmJNH44CTZsdJUF0dIvPkMw9
	8NLOPK4hsLhVHXGmB/FaCfgD6ikU4xRGJHjdm1Yn1fN/YNEOBFDSxvZIN9tsOi6A4gpRKV2DTUKeY
	U3MGN/+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtV7-00000005Uvs-0z5d;
	Tue, 09 Sep 2025 08:14:53 +0000
Date: Tue, 9 Sep 2025 01:14:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, colyli@kernel.org, hare@suse.de, dlemoal@kernel.org,
	tieren@fnnas.com, bvanassche@acm.org, axboe@kernel.dk,
	tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
	yukuai3@huawei.com, satyat@google.com, ebiggers@google.com,
	kmo@daterainc.com, akpm@linux-foundation.org, neil@brown.name,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-raid@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH for-6.18/block 11/16] md/raid5: convert to use
 bio_submit_split_bioset()
Message-ID: <aL_h_byOFfIZ_kdf@infradead.org>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-12-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905070643.2533483-12-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


