Return-Path: <cgroups+bounces-9646-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D94DB4215D
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEFC483502
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E920302CA5;
	Wed,  3 Sep 2025 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lFXwXEMh"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D31246BA4;
	Wed,  3 Sep 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905947; cv=none; b=d6yJc0yRaF8unyqAq8TNiupI0KFrVnpxM+t06IEyUJ//WkVfaQwK4e4NQt9GfJQIlNEyF9dOkWJSungjTzJIGvZnOV7ZFIB8WWwAbtbJs/6iqyCZGZqxm3S9Lx2VhqLNeyEqNCFyhOxC3W7bqWHcKVWXLDWONLBEvlp/mpW/2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905947; c=relaxed/simple;
	bh=zEZv0L4tvOUQTNilBxL9wMvJKkZfTtx9pFza6S61vdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESmqyF3nQuBg8AO4/+t0nB5ZVrOOPWKvPGVjiidzauqmDGCkxoQR1GqgWzdJKnSOO+W3zbbUQsMvQkkV2ZY3VccQF6L0FhZewLlZ/8zoYMIALBIF+UIhkRS1GQo8gWwoYyFv94QabbmQlAd+O2r8rnPqNqmgHQdbc09VMqI3Apc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lFXwXEMh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zEZv0L4tvOUQTNilBxL9wMvJKkZfTtx9pFza6S61vdk=; b=lFXwXEMhUyfvUfBRqst630ZmNE
	N3NmLdoUWvxT1s/9G2ZKM2opKPzzhRclbDH2oeQWlVmJFHR30VQ9wTQkp4sqouOP7GjwiUrWIXkJ5
	Hgy+HRikY7rY3SfCMSs/ZxJXVccbHC0ilkhO0lFfjCLFo92wXGV9M7gZ0FbXaKjUEW0ChJkUtLKcg
	EbUFUu5MLrhByO6YJ4fD4Coz2nsTCwSBHaKq+Sq5eE8GzmrKxYvbs+6/G7Oss12vD83qF7o12qgo5
	/XwAkDTNZ90e/yo/bfG3unBH72/0X+uxsXuHTABndITf9AI4FeBZcQFDJowmOTZ8CgIYKCjzfa8oX
	Adubfi3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utnUc-00000006aSj-30Um;
	Wed, 03 Sep 2025 13:25:42 +0000
Date: Wed, 3 Sep 2025 06:25:42 -0700
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
Subject: Re: [PATCH RFC v3 03/15] md: fix mssing blktrace bio split events
Message-ID: <aLhB1sDlKRmpM2NW@infradead.org>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-4-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901033220.42982-4-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

s/mssing/missing/ in the subject.

Having all these open coded trace_block_split is a bit annoying, but
we don't have to fix it in this series.


