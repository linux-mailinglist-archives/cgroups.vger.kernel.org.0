Return-Path: <cgroups+bounces-12246-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AC5C9A182
	for <lists+cgroups@lfdr.de>; Tue, 02 Dec 2025 06:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FBF3A303D
	for <lists+cgroups@lfdr.de>; Tue,  2 Dec 2025 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D42F2F6587;
	Tue,  2 Dec 2025 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC98s0oL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED10936D51B;
	Tue,  2 Dec 2025 05:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764653384; cv=none; b=PtvcNeZCthZGBcxx6ut99W2XVA7+YP6SNjUchBe44NGwSFs3Qixah8xbXwXiEkPm8X/7ZFDfdrJPMU66D62TbHbQ53efTIzcXl9Avu/Ofp+4Ut0JqOnedlrZUQ0dVSgQaay8LdVaHRqyzlOiHpQwYxl08KpNLCvGhaclOaC/QpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764653384; c=relaxed/simple;
	bh=LVYgY6HHzC2KtafiLZ0UUisYpXQkl5MPaZkaJ1/yoCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiIoTWqyMLeOh3WFpjUSTy5uxhpdr9z2FWB6cXveLftbueWd3UsxiSWmo8hXOl7i+PcbEnKi1Mbk7/MS8jGlt1QcTXkWjSbsTnvl8ypqybcHRrg9Ube/fDRYprKeGh4tSE8zNLQcKYFG+bcDzYl7v50SvuXVFpWHxFmnIVaq+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC98s0oL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58283C4CEF1;
	Tue,  2 Dec 2025 05:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764653383;
	bh=LVYgY6HHzC2KtafiLZ0UUisYpXQkl5MPaZkaJ1/yoCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LC98s0oLBoygZIm689BEeQQyZVMaE8l7oGpWK+Vb+nccj647KfZ+6/wmedmoC/ebV
	 pU93vTT8lPOQmuajkgMFwl33bu7Z+dS49Qx9qw/1iv5dhxou9ZMn7YS5fEGPG8Y6MW
	 IzIX/6zoOjiO3FghUZHBG8UYCD3sxE7iqPO9Y470oxm9eTb2A0rmgKfW/e0/9xGz7v
	 i4xuvh6zK06vWL8ywCfUEzZjnZkRsF5UM1EwyU6fNhoaayGzNH3rJVTGqWlGDKSrt9
	 jqs/YhXoZv60Ar7lqg49biwZ038wrsDbb+IxZ7KlKLMRvT8gwXwgLqTZLFzi/wzGdT
	 oIYASe2zxOm9Q==
Date: Mon, 1 Dec 2025 19:29:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Waiman Long <llong@redhat.com>, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH -next v2] cpuset: Remove unnecessary checks in
 rebuild_sched_domains_locked
Message-ID: <aS55RdSgpdXNOfJ-@slm.duckdns.org>
References: <20251126091158.1610673-1-chenridong@huaweicloud.com>
 <518ffa19-fcb2-4131-942d-02aa8328a815@redhat.com>
 <1165075e-baa2-4120-8e58-50532b2b459d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165075e-baa2-4120-8e58-50532b2b459d@huaweicloud.com>

On Tue, Dec 02, 2025 at 08:57:45AM +0800, Chen Ridong wrote:
> Just checking, can this patch be applied? Wanted to make sure you saw it.

Yeah, I missed it. Will apply after merge window.

Thanks.

-- 
tejun

