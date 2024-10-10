Return-Path: <cgroups+bounces-5095-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D0099827E
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2024 11:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46591C2511C
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2024 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CB81BD51B;
	Thu, 10 Oct 2024 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vwCWLzJi"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6533CE8;
	Thu, 10 Oct 2024 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553096; cv=none; b=fFxkjLaHw+szKU45p+/ITsr97qnZbDk8vN1sq9dsUntNUulCsMOWbRxqetx96BqMyijyWuKqiOvVnQc376XA5NdYFfsaWwj6rfWU6raFnuOTmzJ+yofzjlOKnZ08Engl6DNJNsGM0JX/hI7fH6JuyFUOB/vZzmZqwJ91l6XlfZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553096; c=relaxed/simple;
	bh=aMN5PPq8edkNLETTrxOcDfcm/ZlHG3Ys4u3m6eBXZIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7Q4opDObRKhG5ZeX3KSeq/A+vvSfPRb6SB3LC3iMW8g+DHR9UmAcYQO5eXcCF1a1yQArRlOAysK2FvZp0e+3HG3UhnY6g6DtdPZ2mgesL3oYs8XKM6/1pVZm4u59fu5ThSK+1J8cJUzaeNeCBO+xgm6WTSafKLK9HLd/W0WjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vwCWLzJi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0j3RYOglfCg2sEcOjPn//O8q7Addcfgji0Dp6Ll4I1c=; b=vwCWLzJi89834zxBJGLRcndOtU
	4tRIJqLS/4Ext8O7jjJJsiTAC87rheppx1xCaGlX/VbEhtBqSvpd6WMN58uR/Qrx+koDsfhG1SI0e
	8NaLKmpqcUH+6wtp4PzbUJs9x7BLuFBD/em6VomIcejxUNJu1gXAHuOcoz6ABOIhlGp2oBS14c14k
	C9wSvhbMO2YWvgFCzKBj3/DFOpr0kpmBA6pCT3tmc96zpjeEbMpjGt4ZiQb4fIlhskj7r8nWqQI16
	XmJFqlMDSIOoJWnYPYN6tWcbGwjdH4L9e3LQhbSmIufed+SMwPu8dMJt2EcwK36IYeR75IhOmp367
	plu7MruA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sypcX-0000000CGF5-16JU;
	Thu, 10 Oct 2024 09:38:09 +0000
Date: Thu, 10 Oct 2024 02:38:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: akpm@linux-foundation.org, hch@infradead.org, llong@redhat.com,
	xavier_qy@163.com, lizefan.x@bytedance.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] lib/Makefile: Make union-find compilation conditional on
 CONFIG_CPUSETS
Message-ID: <ZweggYOQtt5OUgHJ@infradead.org>
References: <20241009154022.2432662-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009154022.2432662-1-visitorckw@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 09, 2024 at 11:40:22PM +0800, Kuan-Wei Chiu wrote:
>  	 nmi_backtrace.o win_minmax.o memcat_p.o \
> -	 buildid.o objpool.o union_find.o
> +	 buildid.o objpool.o
>  
> +lib-$(CONFIG_CPUSETS) += union_find.o

The usual way would be to have a new symbol selected by
CPUSETS rather than hardcoding the user here in lib/

