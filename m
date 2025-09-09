Return-Path: <cgroups+bounces-9820-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DB5B4A4C3
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 10:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2A21B261AC
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEEE246BB2;
	Tue,  9 Sep 2025 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HoYyN9b7"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124AC24467E;
	Tue,  9 Sep 2025 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405611; cv=none; b=Rzen3dTQfI0c6rXcdPb62qqpQfCtGI4rxcu3DluyFiteMqm68HrwsxUQYGyIDi6omZ+OYYG9KxNaCmA8U8FTRaeePiv7hrK7qUcwq+tgnJQ3guWbxVjqW5BUYeBXQm+VRfcitU2L53Lw4TtohKe/khD4D/Zi6e/yupJr8Ltkbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405611; c=relaxed/simple;
	bh=dFj4PXIWzhbmUJOFmzQNt1qgtQ8syeC3KliuYY5z/vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiFDuEY7HcRQU3XnxmJ0TdUZArPGEQg/KKfOLBop3scBCiglvhTrEhIyZ95ZvSkqeJt60KB0vv/yPF1pIT6rxQJbNJfsv8ds5lT+K4+WzkcLhF9AWAN60OA1hCIFS1MlFJjKsA/gSAkMOniG9n5EK+RmWeRjItGV//1eL2igCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HoYyN9b7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dFj4PXIWzhbmUJOFmzQNt1qgtQ8syeC3KliuYY5z/vY=; b=HoYyN9b7m9obrOnSBBf0vtMf9V
	S+lDgtIeVP+kDh3sVx3fNVcbTiy4e+dv/xEWxUqBoIjB2atLXlJ2bXNuBbIDLHVoMJ4aHqS2MFkQl
	PnT1W4XlWuqAh9V6NUSKsHahMWOAYasplHX+Ah8leWkXU86128YBleJ5gJZOvJrsiu0syWv/RL/hS
	+pxW4pzh7KknT3EQu2vQQIStX6sbHkCENz9gd4WxzC+ghAWq+29/Hs5VxlIJzVShxPAILtZtsnLNM
	PL19MNjhifyoH+WKCxgHVAu6OrgOudxM2nhh5LKuOu1UhxPCpGYGa/NwgWw98r+Mp7viJAhp9LKFh
	llWEJDbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtTh-00000005UBI-0nT4;
	Tue, 09 Sep 2025 08:13:25 +0000
Date: Tue, 9 Sep 2025 01:13:25 -0700
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
Subject: Re: [PATCH for-6.18/block 06/16] block: factor out a helper
 bio_submit_split_bioset()
Message-ID: <aL_hpUBRQ5vnBJ0Y@infradead.org>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-7-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905070643.2533483-7-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html


Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


