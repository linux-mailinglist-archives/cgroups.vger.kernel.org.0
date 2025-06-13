Return-Path: <cgroups+bounces-8517-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AB4AD9116
	for <lists+cgroups@lfdr.de>; Fri, 13 Jun 2025 17:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF60F1BC3A22
	for <lists+cgroups@lfdr.de>; Fri, 13 Jun 2025 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692F1E1E1F;
	Fri, 13 Jun 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FDbTjOBm"
X-Original-To: cgroups@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF401C5F35;
	Fri, 13 Jun 2025 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828085; cv=none; b=ipsFcOPRrgZZChrrvrWophZ+1dck9WaWV6iEz3JQm2ZxzoHFndfV3oAVpWyaxMr84bvlRsXICFU+vJCRGcxWozNbIYEo9vMA4ARVDsgAiQRP/uCqGHQ6KthsnoBzTI+ERcIAHD85OwhQnlghRqIeXNlp5ZzQiMVJ2JXphZFQV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828085; c=relaxed/simple;
	bh=8sJjFWPMSLC+qodY0LblnKFoZqyEo+d0EIpXPR1ArDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8lvfqPFM1qFrp6YXZ2TTixL66vLB3lt3/y19cjLpA4cxZ7OCDv5C858hNSYFcG0KLSKt/g8CChkcsW1/EE+6i1NFBqfb5FfklAzIF6XIE8C7lzZiVXvbHsUCgtRxKaEtBdq6Y/kP21Du6jwNnuAjpcf4pgWc4Lid1cRviXlCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FDbTjOBm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HBFJcgqfJ2Wrz52AH0HmBBmtGo2Dy9oUkdqK/ph6rYI=; b=FDbTjOBmd33GRB1rYSuPHTeJ1S
	GUyHm3F+sXqiRHsOczF9ACUREmmX3hkSodEq8w2k1WnYwQUtKA2u4nqpG0L/XeakiXy+50wd8yfK7
	Af50gAPDQEHkufBKtkAku5bJsLCs97LADSVIbJALD/gwdjbnpK7C7uB45OQU0kQE2zSE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ6DT-00FjbM-7Y; Fri, 13 Jun 2025 17:21:15 +0200
Date: Fri, 13 Jun 2025 17:21:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] rds: Expose feature parameters via sysfs
Message-ID: <05ac7bdf-999c-487c-beb2-74153d03f6b1@lunn.ch>
References: <20250611224020.318684-1-konrad.wilk@oracle.com>
 <20250611224020.318684-2-konrad.wilk@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611224020.318684-2-konrad.wilk@oracle.com>

On Wed, Jun 11, 2025 at 06:39:19PM -0400, Konrad Rzeszutek Wilk wrote:
> We would like to have a programatic way for applications
> to query which of the features defined in include/uapi/linux/rds.h
> are actually implemented by the kernel.
> 
> The problem is that applications can be built against newer
> kernel (or older) and they may have the feature implemented or not.
> 
> The lack of a certain feature would signify that the kernel
> does not support it. The presence of it signifies the existence
> of it.
> 
> This would provide the application to query the sysfs and figure
> out what is supported.
> 
> This patch would expose this extra sysfs file:
> 
> /sys/kernel/rds/features

This should probably be documented somewhere under
Documentation/ABI/stable.

> which would contain string values of what the RDS driver supports.
> 
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  net/rds/af_rds.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
> index 8435a20968ef..46cb8655df20 100644
> --- a/net/rds/af_rds.c
> +++ b/net/rds/af_rds.c
> @@ -33,6 +33,7 @@
>  #include <linux/module.h>
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
> +#include <linux/kobject.h>
>  #include <linux/gfp.h>
>  #include <linux/in.h>
>  #include <linux/ipv6.h>
> @@ -871,6 +872,33 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
>  }
>  #endif
>  
> +#ifdef CONFIG_SYSFS

include/linux/sysfs.h has a stub for when SYSFS is not enabled. So you
should not need any #ifdefs

    Andrew

---
pw-bot: cr

