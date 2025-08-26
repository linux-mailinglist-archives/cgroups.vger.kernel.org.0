Return-Path: <cgroups+bounces-9409-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B1FB35630
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 09:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EC8687212
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 07:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57CA2F547A;
	Tue, 26 Aug 2025 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Opng1bfQ"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B74D169AD2;
	Tue, 26 Aug 2025 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756194966; cv=none; b=qLYuzJZc87ePPuBn58DTYEDO03rJSDfcEE7nXgwddFK6bqotgW8Z+UucBx2Tfll9nvD8JuBUvq6WG6yJSf2wE81UG3pJQEnPFqWAIFRaod9XTln/jy/0grQxV8NcCdHlRKx6VpzH9lV3iy/GhAn94WK4Cg3esu2wi4HUc8MShmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756194966; c=relaxed/simple;
	bh=7n6gkPFo79ZLWy87VAgqm4OGAAeFNJeJAMIuM4S36dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a63zQ+VWtP3aLSDlGX/yl4EhkabuolwSCApr0cd4glVEBt6JlbcKIXpkGc2AXW3r9E3meLRSEJ+acfwWBwYN/G1uqigVOF+GrNZIZBzAMp9tt3M5s07UYGj24pTTDigf/EOthDLfdWVZ5t26/pf/vSXGmZ0Pc39VzqIhd19zg/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Opng1bfQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G3kiyl4IFgJMpMujWsi5OFKYRPVKXX4aUKET+1q/COE=; b=Opng1bfQJn0L5u2632sBryYZWN
	HCycrsbj8YYFaYfX9xe0l4hx9RUyxqVgT7olWqU+Z2tJyFiEq2CvX0qa+oauCe0SsiwIsW6MCjm8g
	Lt1vIsG/QMxwrrKG6iXoJGJRixCYQbeeSWFWrCrPoso2ccyRl/G7JJ3XU7PD1lkeEIVbTYjRh1piL
	PCroBnT11VnraV6BpkNyVDGJZ597CDdGcujCt8BYaDt3jjz6gWZ12n2S4e+vm6FsO/WgjFuJRFcNg
	ij2I1OwDt49aptKpxIuZhMKd8F8FsM4GYAcXU0qV13bWLt55iSAiTCYcDWwFETiCkmt4RCzpbMzoi
	jDgFLejQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqoXC-0000000Av4o-46XQ;
	Tue, 26 Aug 2025 07:56:02 +0000
Date: Tue, 26 Aug 2025 00:56:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, colyli@kernel.org, hare@suse.de,
	tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com, song@kernel.org, akpm@linux-foundation.org,
	neil@brown.name, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC 5/7] md/raid5: convert to use bio_submit_split()
Message-ID: <aK1oksF1icAVAQjp@infradead.org>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-6-yukuai1@huaweicloud.com>
 <aKxCStAJPOI3LdtG@infradead.org>
 <5af54574-2c28-dc6f-7205-cb3c3575c93b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5af54574-2c28-dc6f-7205-cb3c3575c93b@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 26, 2025 at 09:15:34AM +0800, Yu Kuai wrote:
> > > +		raid_bio->bi_opf &= ~REQ_NOMERGE;
> > 
> > It almost feels as if md wants a little helper that wraps
> > bio_submit_split and also clears REQ_NOMERGE?
> > 
> 
> Yes.
> 
> And with the respect bio_submit_split() set this flag and then we clear
> it, will it make more sense to set this flag after bio_submit_split()
> from block layer?

Yes.


