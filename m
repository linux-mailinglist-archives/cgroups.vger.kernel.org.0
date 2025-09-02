Return-Path: <cgroups+bounces-9605-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8275DB3F57F
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 08:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5B51A83F86
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B91D2E1754;
	Tue,  2 Sep 2025 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TusC0xOq"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F087202F93;
	Tue,  2 Sep 2025 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794673; cv=none; b=ojlEkF9VtewcyqJrzHAsO7l7Wf1ms9nwku0icwFy9mN38y8+I6rmgzqavmOKf6j1mh4mLgym5r/EBhpZFt869FBsdKuzGyCoMxoVdRJfjqZM0kQZrriygTKwMJsHtQuSCMwNrKp7RDGVMyjwhtD7SS2+THRJX7jgC94pbBZxeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794673; c=relaxed/simple;
	bh=zPstAKzxnsGHP2HNmcw0eolv6JLOUUjmKmNljHh8hyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FH0+RQl84PjtkcLLudurWPuAMGHI3QXFBnCEKkUnrl6XbvZ2tDODwYYS9fiGNAS0JisoEAUd4cbcEzvPtSI45JdNWldTlfOQ5F2nQXznt+Eq9tKDiBQQb3ggPsrmPdv8KS18d/bqV9GnLfCEDeSn/erLrNVm4PJ/L1V7HQpy840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TusC0xOq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=FX2BUjrX01jYzdztuj22H7lse3A+TvUCbGtp4V4ey3Q=; b=TusC0xOqB6fAX89HRBn/iJXrmi
	DoLA0qBK3+LIYtVvPmpWQ1nzgeaG5do/60aWhSQqH+OC5nilKU/+zbfiRQXg2z4bNp/1EytwmTxcx
	J3s2g+MKPpOrMYy9gEB/HfP6xpDcAqdIhB8kURYeykBdzuLFa8BCsrDCBV2sTIFmme9iNjtts8ulB
	eaiXC0eDqIm5nRt2BhxQp4mH2vJ25tzK/4mb68h1SWon6mE9UhmQq9C+2hSKOEMSuTk+CNPCzAJRV
	xNxoUwHJyttclDrzFT58cl4QM7hoh7AnIHDGG3zeWxRXZmVn1j/F9c5SgVoZtt6N+roLMcXQeYJuY
	H+NU8G9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utKXd-0000000FXGX-0Y7N;
	Tue, 02 Sep 2025 06:30:53 +0000
Date: Mon, 1 Sep 2025 23:30:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	anthony <antmbox@youngman.org.uk>,
	Yu Kuai <yukuai1@huaweicloud.com>, colyli@kernel.org, hare@suse.de,
	tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com, song@kernel.org, akpm@linux-foundation.org,
	neil@brown.name, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC 4/7] md/raid10: convert read/write to use
 bio_submit_split()
Message-ID: <aLaPHctB8IgtD_Sg@infradead.org>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-5-yukuai1@huaweicloud.com>
 <aKxCJT6ul_WC94-x@infradead.org>
 <6c6b183a-bce7-b01c-8749-6e0b5a078384@huaweicloud.com>
 <aK1ocfvjLrIR_Xf2@infradead.org>
 <fe595b6a-8653-d1aa-0ae3-af559107ac5d@huaweicloud.com>
 <835fe512-4cff-4130-8b67-d30b91d95099@youngman.org.uk>
 <aK60bmotWLT50qt5@infradead.org>
 <def0970e-0bf7-4a6d-9b68-692b40aeecae@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <def0970e-0bf7-4a6d-9b68-692b40aeecae@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Sep 02, 2025 at 07:18:01AM +0100, John Garry wrote:
> BTW, do we realistically expect atomic writes HW support and bad blocks ever
> to meet?

That's the point I'm trying to make.  bad block tracking is stupid
with modern hardware.  Both SSDs and HDDs are overprovisioned on
physical "blocks", and once they run out fine grained bad block tracking
is not going to help.  І really do not understand why md even tries
to do this bad block tracking, but claiming to support atomic writes
while it does is actively harmful.


