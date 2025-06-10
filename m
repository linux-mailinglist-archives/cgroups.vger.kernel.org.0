Return-Path: <cgroups+bounces-8477-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DF2AD44D3
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 23:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278343A49E9
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 21:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A383284696;
	Tue, 10 Jun 2025 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0fkz9sh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C6F2367CC;
	Tue, 10 Jun 2025 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749591163; cv=none; b=YPQ9C8qdgnSl+GunPDlX02w9r8bOONpS7rE1o97830oOOO8/aDfe/5pZazO9LJ0kgJr+kR5J+gZM1d0cWd56Su1PNpaXzzrR9tWHNb1BUNxEaHF+2aLcoNEgn+LAJJdl83MOMRyPaAg3FLQES9cou0JtCcHSHjZarAUQeDhGkdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749591163; c=relaxed/simple;
	bh=rjr9cM49i4vCMHdMM7EGrQ95pSKm7uGYIzxiHNuz4yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRUfudXg+q/TQR3w9hwUP/5x5S4JrmJ55pQ0y6xy+p7DTOXi+0BK1BgQU0T6TGl/mw29qx0Rw1MYAROfVtuW8peqEyu4UCshmQoP7eGlTNa2L5pSBvUtRkRZM2qyOGbZfInECyZYHuPTWcu+fT1BGXXQCrjAnnCL7EaRyf+/WUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0fkz9sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCD8C4CEED;
	Tue, 10 Jun 2025 21:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749591161;
	bh=rjr9cM49i4vCMHdMM7EGrQ95pSKm7uGYIzxiHNuz4yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T0fkz9shwcoeuBHGhswMirDO8AzsTFHmpENs0C8g7alFf/hG700aJABUkfK0FPZnf
	 y2tM3MdnGAAW6+YoTbdGvpRf+lLZGTk19r2qZ9rpR45xmX8BUrPWqH5AWGH3Zvyhqm
	 7pYlnSuiosJ0ISCw+g0pOjibLcfq8XV/yJ5qoN0jC3KgDf/nzx6Nc84yp51ohitCTE
	 YzL+SxdI3RxNwE7rlOuXoAV42mIF1YVMpTVvJM17AZgTf9BTlHdXp9lYnZ8wKF7ffw
	 EceS0L8jsfVDf3XEFEolUlcwuho23S6dE+Ri6v4A4NVGKHvfSN+FX/icJuGbcpvfs4
	 kvBVx/2irIXFA==
Date: Tue, 10 Jun 2025 11:32:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, guro@fb.com,
	kernel-team@fb.com, surenb@google.com, peterz@infradead.org,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	andrew@lunn.ch
Subject: Re: [rds-devel] [PATCH RFC v1] Feature reporting of RDS driver.
Message-ID: <aEikeOlAjvbqm_7v@slm.duckdns.org>
References: <20250610191144.422161-1-konrad.wilk@oracle.com>
 <aEiZ212HZo3-zpMc@char.us.oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEiZ212HZo3-zpMc@char.us.oracle.com>

Hello,

On Tue, Jun 10, 2025 at 04:47:23PM -0400, Konrad Rzeszutek Wilk wrote:
> On Tue, Jun 10, 2025 at 12:27:24PM -0400, Konrad Rzeszutek Wilk via rds-devel wrote:
> > Hi folks,
> 
> Hi cgroup folks,
> 
> Andrew suggested that I reach out to you all since you had implemented
> something very similar via:
> 
> 3958e2d0c34e1
> 01ee6cfb1483f
> 
> And I was wondering if you have have feedback on what worked for you,
> best practices, etc.

I don't know RDS at all, so please take what I say with a big grain of salt.
That said, the sysfs approach is pretty straightforward and has worked well
for us. One thing which we didn't do (yet) but maybe useful is defining some
conventions to tell whether a given feature or option should be enabled by
default so that most users don't have to know which features to use and
follow whatever the kernel release thinks is the best default combination.

Thanks.

-- 
tejun

