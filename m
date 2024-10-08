Return-Path: <cgroups+bounces-5055-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D72C993E23
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 07:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335D01F224B6
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 05:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597AB1369B6;
	Tue,  8 Oct 2024 05:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mo2R9E0a"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE723A6;
	Tue,  8 Oct 2024 05:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728363679; cv=none; b=UMlepk1hspyOqPlSsXb/zGN/BnTiihBI/ReltdhCf9nDjIM1zkQci3sFMK1pXy4vZhaSOZRJ3L0MjywAa/bcaeAaf54KOEiFx4t4/mIN4qVSAyGBv6j0ytq+aVxQhQMHuXHoxecqytuSH4GjY933xZIV3KnrVlI8c21qD8XMW80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728363679; c=relaxed/simple;
	bh=vUjlbtPij7dfv7xT5Zi5eQxxfKt1edeUy93PlruaS/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHfx+tRJPLeGSWwpSpFoOGhCHdRDelj9FmLE9CCxE+NDg05BbTTRFvm3oDA05azzOpogMMpNBjfRN1Jqm2gK2PRurNiR6DK570yiRfGsaG7IO9X65oDkzlnfHlr7GVHEac+8uclX4uTW0x1mYVlWcxLom4Fvu1yzGAIdWcalKoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mo2R9E0a; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=EuATOjvebLdwzG9b6bXcZ4P8D8T60CsTrjqntsqyX44=; b=Mo2R9E0awieg8tJQtgVjxPtwtZ
	qC8FSZiOrEu/dLRTjuIah5jjt/74vhpTFr2N2gAi0XB8CXQGbBlYbLGu1mW4ltEuRooE/C6uDzzq1
	fBcxO1BSzpB5umAF9A7/CWGzHJhPuFXYVjyJHZYrbugCnNP4cDyjR796a9h88tH3uCqBLiEyI+gy1
	lR/b41GsCcgJDJoDNyxDbmUQXJqsroiynIhqB7sp4XYvYQB3GGJolldmxDFUOnVuFtyYjWjytgEm/
	gwfjnU9W/kRgekHXoGgahBQykK+2TwOO7d9tBkaHisNFEZhu+pFrKDJ8KklpVU1OyhN0HGvmB0wsc
	OT3yTq5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy2LP-00000004WGl-1M3J;
	Tue, 08 Oct 2024 05:01:11 +0000
Date: Mon, 7 Oct 2024 22:01:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, axboe@kernel.dk, josef@toxicpanda.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 1/5] blk-cgroup: add a new helper blkg_print_dev_name()
Message-ID: <ZwS8lwQ_fN2HY93p@infradead.org>
References: <20240930085302.1558217-1-yukuai1@huaweicloud.com>
 <20240930085302.1558217-2-yukuai1@huaweicloud.com>
 <Zvrb0DXhtVHT2lfa@slm.duckdns.org>
 <ce2b9ed1-cf74-1d50-a72a-23733c0d1db0@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce2b9ed1-cf74-1d50-a72a-23733c0d1db0@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 08, 2024 at 09:39:05AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2024/10/01 1:11, Tejun Heo 写道:
> > Hello,
> > 
> > On Mon, Sep 30, 2024 at 04:52:58PM +0800, Yu Kuai wrote:
> > > +static inline bool blkg_print_dev_name(struct seq_file *sf,
> > > +				       struct blkcg_gq *blkg)
> > > +{
> > > +	struct gendisk *disk = blkg->q->disk;
> > > +
> > > +	if (!disk)
> > > +		return false;
> > > +
> > > +	seq_printf(sf, "%u:%u", disk->major, disk->first_minor);
> > > +	return true;
> > > +}
> > > +
> > 
> > I wonder whether we just should add a name field to disk.
> > 
> 
> Of course we can, however, I'm not sure if this is better, because
> this field is not used in the fast path.

Struct gendisk does have a (disk_)name field aleady.


