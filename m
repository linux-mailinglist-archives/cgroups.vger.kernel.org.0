Return-Path: <cgroups+bounces-7805-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC8DA9B680
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 20:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412414C34D8
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 18:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC7528F521;
	Thu, 24 Apr 2025 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8cvvGls"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8717A2EA
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519931; cv=none; b=P/5fhxiK7oVrUN8qCm3ZeQnS0RCT5Ig+6rdb7qm0z8/DI8abmz6llYv+zO93CUjC55G2FZlly4kU1kVMYu29Dhxj0iUnnJIJVZ//osWrXR34WHLAskpOoLVhzMfJgpuMQ4hSrgJpQ1QTlZwqbcC+mCVZWnXd4uvFMd2LbKDhVFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519931; c=relaxed/simple;
	bh=huEaN2IrGUl5UQvr2VrzWlljVUCeaTQ13HcZqdMV2N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxYACeZATxgygu6tor2TKnC3J76J9WKZMvWQZd+Mehm2MQMrHGvIXj0meq/k+dbK+LUtOzk+0YlthIPzGbJBH1Xd8C4jh9L/AT6ezXsQ0t3tzhWm3a0RouECaVrHyyZkKabkpPZV5u6v4y50irMEB3soPf9PTffKx9910xIp6ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8cvvGls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B08C4CEE3;
	Thu, 24 Apr 2025 18:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745519930;
	bh=huEaN2IrGUl5UQvr2VrzWlljVUCeaTQ13HcZqdMV2N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8cvvGlsJkJwXLA3OxBmnD34c/z6Gwgf3/QLE41XHjrcBcRX808uB6SGVrC5V0m+P
	 R+8ehyh2JRR3B+1yFxMbOdcUQGY26OEDzHDSI/Vk8r6dzllUWLr/Ui7slyvbDdjYo7
	 ya6ZoawJOqU882i/g//XFHQjVAS/cxK8hb61oC+Qm5MmI0TpfOOuOXnZT1c+REERi0
	 2FyfGgQyqBsVDGlUqdNVd5RBwabAgpNw+UCk33sjWbCkTu4SQOSP+KoWonGx1vzC/X
	 4rzeYlRIldsS/aVXfUN/iHaAChxJfe0f6757m43+Z+5vVrFc48hhUo76+zIWelPZTF
	 h2W3d1F1isOjw==
Date: Thu, 24 Apr 2025 08:38:49 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: yosryahmed@google.com, shakeel.butt@linux.dev, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup: fix goto ordering in cgroup_init()
Message-ID: <aAqFOWXniY2ZRM7E@slm.duckdns.org>
References: <20250424175358.68389-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424175358.68389-1-inwardvessel@gmail.com>

On Thu, Apr 24, 2025 at 10:53:58AM -0700, JP Kobryn wrote:
> Go to the appropriate section labels when css_rstat_init() or
> psi_cgroup_alloc() fails.
> 
> This is intended for branch "for-6.16" on "tj/cgroup.git".

I think the more common convention for saying the above is using "[PATCH
cgroup/for-6.16]" in the subject line.

> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> Fixes: a97915559f5c ("cgroup: change rstat function signatures from cgroup-based to css-based")

Applied to cgroup/for-6.16.

Thanks.

-- 
tejun

