Return-Path: <cgroups+bounces-2909-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E03BC8C5F9E
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 06:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E154A1C21D9E
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 04:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2911B383A0;
	Wed, 15 May 2024 04:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q4MzV1Uj"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522E23D7;
	Wed, 15 May 2024 04:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715746179; cv=none; b=kb8dyLcHOdhXiACBllA/HQYvP+Ar+ffDRU12GMhplZtN1Bj2zuCuiwU+di8GTKIxFGuDJo/tt2zOa2HQiUeTuzcEPqrAPfbmHE/qNxP3dWsfOgYRco7uKQSM5pKUgwTBiN5UoTdWhfOviY+XjYoe00lLl85x38uRFqCkSqmNoeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715746179; c=relaxed/simple;
	bh=wGOV1mZ+pdVrfptpS5boXGVzJ4/MpBPVNFEfmzjHpSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZWDtwaDBYK0RtqDOjNfq71sAVqB4f4J7CBuw/cFty32RNjBGfMsW9ABt9RYhrttjL7sGiHhfZkACSRuFEqHrBUfOki6biKILkqCh4WwhZKK22S//mZ1jcyx4qAxarfgAgtZ4MFUMoD+PhX4/OWdw+onQfdrtLIIBauuklm8dys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q4MzV1Uj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fLAgEShe7dMtqipBc1HSHbcuyfF24sU6RugfONHtSCs=; b=q4MzV1UjJV63c3p5yjjaLOQ3SI
	eVeE0HWSGanF4JappNKQfh2wg7MY1fgJmkusADZl3RREZBJJgYVc1Er68xB+od/I0rlDEGTyJNuPg
	uOHTyH/yGMtJLJFuJcq39IDEJTdqvq2wUKlRYixClLNy55kyf5wsjyPcoxQnJM2jnJSQLQBE4UA7m
	0zqYvZTxbbMymV4hneBRwBVJEh+GOTLP+cceocAO/XbOHtcaJGKUVa5xmPLtM56Na1s+ybX2Vue4v
	hGV4C/jUR0hRZr5e4iN0WxsHsBGuuE4z1Pe1/v7t2raHVCJjIwL0U72wsG2djNggFIeXo33z44dF9
	iFlnBwGw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s75xG-00000009uEl-10EI;
	Wed, 15 May 2024 04:09:26 +0000
Date: Wed, 15 May 2024 05:09:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>,
	steve.kang@unisoc.com
Subject: Re: [RFC PATCH 2/2] mm: introduce budgt control in readahead
Message-ID: <ZkQ1dsHKVttb7y4_@casper.infradead.org>
References: <20240515012350.1166350-1-zhaoyang.huang@unisoc.com>
 <20240515012350.1166350-3-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515012350.1166350-3-zhaoyang.huang@unisoc.com>

On Wed, May 15, 2024 at 09:23:50AM +0800, zhaoyang.huang wrote:
> +	unsigned long budgt = inode->i_sb->s_bdev ?
> +			blk_throttle_budgt(inode->i_sb->s_bdev) : 0;

NAK as previously explained.

