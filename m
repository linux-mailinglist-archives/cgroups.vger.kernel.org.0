Return-Path: <cgroups+bounces-9350-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B27B32717
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 08:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFDA41CC114B
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 06:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B591921D3C0;
	Sat, 23 Aug 2025 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N6DBQntd"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F59A20296C;
	Sat, 23 Aug 2025 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755931432; cv=none; b=Lhte6SHNkqrsS1ZHJfGXBpbehvFIIhJC3wtS6woJZc51m0rIWmkjTjSVtLMZpL0Z71Lb60io9wq9wlhjQmg4JKfgIzK8eC7AiLaXTWMSYVA8nRXFNcOkguIwEd0hIlo54BMkXhDwsGG8CCjldhBI7OD875GJ5undGRgA//XyOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755931432; c=relaxed/simple;
	bh=+mwJRjb6klKc8Mg0ZGKn17yA7SD4nT8yEamguhUTaqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nC+V3KU5o1nrECKJ1T+rbNGPdUz+W7RCn1hfavWKpdFdDjLlqQD/uqUrExlpo+8wXFCMnFEIH4bAhO/kbs8P8wuDnQf6YOkIvVKiCI3XCn1Fgk5IleItY9p9i45rCM/Z/aICpA/8F7YYUEO0uzRZgOFxn1OerknjFLdAM4vrXCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N6DBQntd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4E3C4CEE7;
	Sat, 23 Aug 2025 06:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755931432;
	bh=+mwJRjb6klKc8Mg0ZGKn17yA7SD4nT8yEamguhUTaqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N6DBQntdKXP21s9ka4NNO4PaJTgjQdDhLFQPoS+7EsSB2sFdmHEvT9UX8Y2XW+fti
	 yWqs6DsKzeQnjU1eFuNgjmzIw9VXJnYELuFGOG9wDxdtdjBuSViecokwwduRkMh42e
	 WXM0AulZ8NzaylL+uy/P9BEVl4K5ZTixoND9+6ws=
Date: Sat, 23 Aug 2025 08:43:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org,
	mkoutny@suse.com, peterz@infradead.org, zhouchengming@bytedance.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v2 2/2] cgroup/psi: Set of->priv to NULL upon file release
Message-ID: <2025082322-canopener-snugness-14e3@gregkh>
References: <20250822070715.1565236-1-chenridong@huaweicloud.com>
 <20250822070715.1565236-3-chenridong@huaweicloud.com>
 <aKitWH39wpfTF5st@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKitWH39wpfTF5st@slm.duckdns.org>

On Fri, Aug 22, 2025 at 07:48:08AM -1000, Tejun Heo wrote:
> On Fri, Aug 22, 2025 at 07:07:15AM +0000, Chen Ridong wrote:
> > From: Chen Ridong <chenridong@huawei.com>
> > 
> > Setting of->priv to NULL when the file is released enables earlier bug
> > detection. This allows potential bugs to manifest as NULL pointer
> > dereferences rather than use-after-free errors[1], which are generally more
> > difficult to diagnose.
> > 
> > [1] https://lore.kernel.org/cgroups/38ef3ff9-b380-44f0-9315-8b3714b0948d@huaweicloud.com/T/#m8a3b3f88f0ff3da5925d342e90043394f8b2091b
> > Signed-off-by: Chen Ridong <chenridong@huawei.com>
> 
> Applied to cgroup/for-6.17-fixes.

Both or just this second patch?  Should I take the first through the
driver-core tree, or do you want to take it through the cgroup tree?  No
objection from me for you to take both :)

thanks,

greg k-h

