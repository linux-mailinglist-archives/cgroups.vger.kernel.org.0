Return-Path: <cgroups+bounces-12935-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEBACFA8C3
	for <lists+cgroups@lfdr.de>; Tue, 06 Jan 2026 20:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B27F30124C0
	for <lists+cgroups@lfdr.de>; Tue,  6 Jan 2026 19:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1111334B1AD;
	Tue,  6 Jan 2026 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHFxpVwb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00542868A7;
	Tue,  6 Jan 2026 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767722631; cv=none; b=gjgP8VJVNnZ2D4jK2nACfmsQNJA9IGpL5AkplsWf6RZbkJC13Z9TFqT/LqYvqikC6MUk7gUHvkq6ji+TpKuGp37hDvyt/59e/Jpc78ckD9ijO0wPHmqtdXgkZZSd3baIth4g1351naSXBOlxU3q7g9RoVcS4kpHnnC5De6k/taw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767722631; c=relaxed/simple;
	bh=p3Jt3MN1IXIrOPC99GF2WJoelTHqrcIxGdkKgV0seao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GM0tRTgSicpIwMipjaj8x2wXxAMrtJbGMN2hsbZT9KayDVAuK9fJo4CBOsxu86dLwl1siOKI7KEZpvc2gc24A0qcsdMRF9XGT92Ndw6mVyZ20S9tRi3s4+pMYathlNCgivh+ohl4hiFF1blC0kHcLTZWoAHkxdCPLvlOdqgki68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHFxpVwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654FAC116C6;
	Tue,  6 Jan 2026 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767722631;
	bh=p3Jt3MN1IXIrOPC99GF2WJoelTHqrcIxGdkKgV0seao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHFxpVwbCvVpQLiYAuAFVliW0Z+5kXkyhKtcDwwiHaHj3l6snsgACo7/nF9rvwOYr
	 9++gj33po4TVILxHZk7WfSid4qzeJ0DE8hx9mYQs1YlXPVM4kUlZn+V/akZuEZlbr5
	 huJIon9cKc2t80CiVBfqmsuD5w4uxJs3twG+jbTjkaNBVlZQ21h80wgnmWLHx1a0BZ
	 gDF/VWqJ71enfPo0Xo6n1lIt9cxpatOS07MLopajIcBkq9yOnrPmFRGMJHJ7hYqL44
	 Lleht1/bskufG+9MZ9qIz55USca05uNNy2u/KY4PQEgVes9xRNAIlekC9aX8Pr76bs
	 FKjDPZ8NqPehQ==
Date: Tue, 6 Jan 2026 08:03:50 -1000
From: Tejun Heo <tj@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Laight <david.laight.linux@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 1/4] cgroup: Eliminate cgrp_ancestor_storage in
 cgroup_root
Message-ID: <aV1OhkWD9fZgrVtz@slm.duckdns.org>
References: <20251217162744.352391-1-mkoutny@suse.com>
 <20251217162744.352391-2-mkoutny@suse.com>
 <4e2d8a58-a78f-46e3-81a1-342e571b4273@embeddedor.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e2d8a58-a78f-46e3-81a1-342e571b4273@embeddedor.com>

On Tue, Jan 06, 2026 at 04:06:47PM +0900, Gustavo A. R. Silva wrote:
> Instead of the above anonymous struct, we can use the DECLARE_FLEX_ARRAY()
> helper here:
> 
> 		DECLARE_FLEX_ARRAY(struct cgroup, *ancestors);

Michal, can you update the patch with the above and resend?

Thanks.

-- 
tejun

