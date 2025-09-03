Return-Path: <cgroups+bounces-9653-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA656B421C0
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73C0189065E
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 13:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC6430AACE;
	Wed,  3 Sep 2025 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hFE6LM7v"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BB91F4701;
	Wed,  3 Sep 2025 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906413; cv=none; b=SAS2RetwQK/SpYOMf3wLjL6NBpLYtCQQi0n27G7gDhYn87FMjo+iJpoKOQ2t7jKkEar0Lo0Z26fV6glbs3R8XAmqQbEs/sp7lUn8pYeDYG39bnVcmSp893B2n42vwFNNJYp9J0otIVC9RB8RHOayy0moO99kxPT/BJLXyOY7j0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906413; c=relaxed/simple;
	bh=cOFfILqDvcYrYQ78ncWYX0jArKBcNUi/bsrubrjjEfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VayoxPPKjDzjb+8v8JtXyfZU6jMbi3513+G4RKPUdIh5e5f2i9j4Hep80gVRelWL/9DRSYjRpPLkOSFWwQgM4UHpj8aSYGTkkt2jdu/u22k2kMGIz4NfSZDph5998lO/5h50tzaQLHg0a0UefWE8D2ExcpwFYVDCgtXaI/7110o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hFE6LM7v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QScuRPRWpoBdgKQ1Cr6eS3RFvhPh7pl84QBA46w5pWU=; b=hFE6LM7vHfmmEwVcw+z9/+gPKj
	cXRdYlPMe1uIT2v62GuEh8MAKhldZxjDiD4kK/jbMAnf/VfYGqIG28ZLPR7g4sNDLfOi8TLbHywRK
	IN+FoSIuydzsRzaPG5WxL6+AM/Z3+WM6FSZATsuhKnD3E/VuFu72/6dA1r8qZOiVa69/8dhLH3Vhs
	AmeNujY6wf1sxtBF9quO5uf5HTTTwYOfw1l67KFPbGWiSm9Fja+0+KXtAjHW4gdlvXbp1vqoUag6i
	CrHVM4d6BOIos98f86Ao3UQ7JFtQ7gBRbS2Q7PGeP8dNEZEpRHEVmgpaBlDu9We+ti2yCnsicVGjY
	mBEp6sDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utnc7-00000006bu5-0vWa;
	Wed, 03 Sep 2025 13:33:27 +0000
Date: Wed, 3 Sep 2025 06:33:27 -0700
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
Subject: Re: [PATCH RFC v3 13/15] block: skip unnecessary checks for split bio
Message-ID: <aLhDp10e2MpKVVyY@infradead.org>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-14-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901033220.42982-14-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 01, 2025 at 11:32:18AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Lots of checks are already done while submitting this bio the first
> time, and there is no need to check them again when this bio is
> resubmitted after split.
> 
> Hence factor out a helper submit_split_bio_noacct() for resubmitting
> bio after splitting, only should_fail_bio() and blk_throtl_bio() are
> kept.

As Damien said last run this helper is a bit odd.

I'd just make should_fail_bio non-sttic and merge
submit_split_bio_noacct into bio_submit_split_bioset if that works out.


