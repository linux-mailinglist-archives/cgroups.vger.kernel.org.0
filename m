Return-Path: <cgroups+bounces-3790-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D93A937344
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 07:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3535A1C21BDD
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 05:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600C947A4C;
	Fri, 19 Jul 2024 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L6+wMYSE"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99D6433A4;
	Fri, 19 Jul 2024 05:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721367015; cv=none; b=fQ/E+gvct0RiJyE5SeEf4tJfLNte1tKJh7pV5zcA3MdHBwvceq7og20BqdvAR/be/5HKsSUnhCU2alKM8v/YUOP3Ho4SuTRsyl4KRUTJfNWCeOONBoJSrP5ly9imEaXhBvffjx7u1pUFhW0qgvhFVa9zmcP+Z/sHtBdLh71MXHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721367015; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJm/ZLGGjufjtUF5MFpJVzdDpsdYsveIYCDxi239+TMb3pN5wj7I2hPFXABnjNlX1GLLkN02IQAz//tdKRzU4KyS9FlPE2M5N/XZGWWFDziODnSm7QvTOfT8FHHHjM7nN2iT9HT2z3YxIl3DCBIFtUuavz7ObqPWWsMXRYUHl4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L6+wMYSE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=L6+wMYSEWDnRdFapTgQN0uXDuh
	EEVuJgZ2LWxD3vGL5/ymRgfSD9mdQh72GIYFpoNow/O95C6iFl7yzEM5tCpezmEdDabikA4npbjtG
	BTtOlXk93t/cEQyKqQD5z56cCr0YUQAx+FflFLa/cx9+0PzWBsvdY/mWQxjNr94MDOwS2YPn45rnO
	pfqL6lrWRfZLYwpD5j9upl2z9okyVDO2Vvk0eSAJ8/zMpc5FDQLoasDdLhJwKDRpfiJNDVisqb7QG
	duKDcTT7gSV+nZvJTmR6cKu7hjwJgfHtW4qBQOSrCwTTLpdApr0Dv081tj34phnFbsBPibnVyMObT
	H7lSxwSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgC3-00000001dtB-46hO;
	Fri, 19 Jul 2024 05:30:11 +0000
Date: Thu, 18 Jul 2024 22:30:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: bvanassche@acm.org, jack@suse.cz, hch@infradead.org, tj@kernel.org,
	josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 2/3] blk-ioprio: remove ioprio_blkcg_from_bio()
Message-ID: <Zpn54yfWoYaob6sb@infradead.org>
References: <20240719023431.3800647-1-yukuai1@huaweicloud.com>
 <20240719023431.3800647-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719023431.3800647-3-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


