Return-Path: <cgroups+bounces-9644-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57763B42147
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F997C0FD8
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669BD304BC4;
	Wed,  3 Sep 2025 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TLdK/WGI"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549CF1BD01D;
	Wed,  3 Sep 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905792; cv=none; b=u6Ii5i8/X9ZOgDZKm0pAluzCdHfWoqyz+9p7i4tjPAKpk8WMvAP+gikikgmljfMcRtbSp1Ku8wOXrkgCFJM+HPWgg+6z+fH7nEsatOtEI9aKObkdikLgWW2g7kfcRa5EjfijOAityJ7xDmVLmoRrkl2vc7U0/ozkvLKpEaHPnWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905792; c=relaxed/simple;
	bh=tUbvyc5KAD5wmw7ap2ylCviQaoF8thLHIYsY0sxr9uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahI0378fHOeKDvDU8owDckcQIw46/puyTLecZaSFCXOpxgj+GbqpN7Ac6GJTA23wVp7eIYMiSbG7i9LiajF5VhP59vEgfVaJpk6y5MtQCpJIps5exjOJ7/DH2H4N20bX10UPF3DWRZdc+f1j5yFnI1HQV97aCD8t903wx1Q/QQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TLdK/WGI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O7Um2miBU1i6ixWvXoQnJcB8IAc9Oh39tNXyVLO4/gY=; b=TLdK/WGI01V2qN69B4ZFBR1O8n
	q2uBnqELLvTmLnIPJDximQpqm7Jmk6UTeqVjDO0NIEbhk4cmzVAXFZmJhaQdNQuQFCAhJqiD3AbCI
	Zrday6m51axI4ZID6DuUfoBbheqOuiJBFcC13zFwEmyGzmb/l/BoI2JvL76nF9KqyFIU0YDdP23If
	n7ZAOEw+Gkr+/hqDEP+4vmGyyjhIwR6EgqllcFTmWcHDaZt7uuaGyKRwGINy/ZX7MQM9FYFr5ntEJ
	RL0ERPDBk8lKc2irxcAAxm7tsbNEOMsqWNP/mk+ehFWpZoIog6j9CXy9ypfB8ttqKGTZG8p1QJwOh
	Vhjho4OQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utnS2-00000006Zu3-3pb7;
	Wed, 03 Sep 2025 13:23:02 +0000
Date: Wed, 3 Sep 2025 06:23:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, colyli@kernel.org, hare@suse.de, dlemoal@kernel.org,
	tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com, song@kernel.org, kmo@daterainc.com,
	satyat@google.com, ebiggers@google.com, neil@brown.name,
	akpm@linux-foundation.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH RFC v3 01/15] block: cleanup bio_issue
Message-ID: <aLhBNoC_M2NGotxJ@infradead.org>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901033220.42982-2-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 01, 2025 at 11:32:06AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that bio->bi_issue is only used by io-latency to get bio issue time,
> replace bio_issue with u64 time directly and remove bio_issue to make
> code cleaner.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


