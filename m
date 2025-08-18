Return-Path: <cgroups+bounces-9267-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC04B2AF08
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 19:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8076801CA
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 17:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F31732C300;
	Mon, 18 Aug 2025 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB3fT4AE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDCD32C30F;
	Mon, 18 Aug 2025 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536921; cv=none; b=PG6uHU0fe/Lhd/lLW7UZG0fgpo14QMyGolgZGiJXqST41jfrLGe5z4XmLZk5ZCXjXHm9QJ/oc878xUql7Z+rcymcpOdo5nDbTUpXjNWX3qU0Or8Vjf37IAw65AYL09MG79gwag4mpiBseaesplQZwlDmssJOVvGse2OQm+MxWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536921; c=relaxed/simple;
	bh=64CcmkGtdUxeHQ1pBgSUaPFesNmD3+o91YK6wmGkYJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsbP+A46tjUOQ+Mwa3vrO493QgnEOOLXC7JE/2e/HXu2qhlzR8rFO+uPauDaCFENgsEDL+Cr/Te2VWgnGfYkSrVkNXpmfxI+nq8sGiWRXN284Tz/VwcE/Ff8sFbtBKeCwUEgu1qMp2/QOPhBkzOGevSouAMwsVrKYxV2apC0trQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB3fT4AE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F574C4CEEB;
	Mon, 18 Aug 2025 17:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755536920;
	bh=64CcmkGtdUxeHQ1pBgSUaPFesNmD3+o91YK6wmGkYJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cB3fT4AEF3Up/BvqosBGRperiBFtvAvgJ1bC3UdhNTb65WHq0vzhH1S6kulu+uLcl
	 w0n9UZWXiIxmL69PScnQZNRdyl5jhIum4rRpXKCqxhxYP/L1wfCyy+DUlGGYNzkOHR
	 7mSVhgW7Z2Kp3TOPYWYMN0wL/gHPbjN/bT6WANkHx06KnCP9Sg+vY3ULXVcMWaxae5
	 rUCRKCXmWKOSIRqrsIFQXAO3C6ge8712FlH2b41Utl/78x/NB4vBhuJb6DA/p/Lbob
	 Yb7M4jEqFmIbEvZXr4xKvSJr1AdFw8Ju4tZXygiEUn3Tm8EhbWT4l1sRGc/eVmt42h
	 r4YO2Hl7N9JiQ==
Date: Mon, 18 Aug 2025 07:08:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, lizefan@huawei.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com, hdanton@sina.com,
	gaoyingjie@uniontech.com
Subject: Re: [PATCH v5] cgroup: split cgroup_destroy_wq into 3 workqueues
Message-ID: <aKNeF68tmjLKB6dK@slm.duckdns.org>
References: <20250818034315.1303955-1-chenridong@huaweicloud.com>
 <20250818061435.1304516-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818061435.1304516-1-chenridong@huaweicloud.com>

Hello,

On Mon, Aug 18, 2025 at 06:14:35AM +0000, Chen Ridong wrote:
...
> + * Rationale for using separate workqueues:
> + * The cgroup root free work may depend on completion of other css offline
> + * operations. If all tasks were enqueued to a single workqueue, this could
> + * create a deadlock scenario where:
> + * - Free work waits for other css offline work to complete.
> + * - But other css offline work is queued after free work in the same queue.

Can you please refer to the concrete example too?

Thanks.

-- 
tejun

