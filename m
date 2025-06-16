Return-Path: <cgroups+bounces-8543-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CACADB940
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 21:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7855A3AFDEE
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 19:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CE31E2312;
	Mon, 16 Jun 2025 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yxhmWNlz"
X-Original-To: cgroups@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E992BEFF8;
	Mon, 16 Jun 2025 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750100480; cv=none; b=ss21ntOsBbdCZxlO1qdRq/B5YHZepNd53PzwTzoP8//AXSC4lDFQ/EwDJ+kzG45h1lbdV1uBa3QL0MGcBCMhpZ0sICs3tvu5frzDx8HNuRx6u2ONWDOczZzMDrhw5xucNkLV+/Oh4WZ/veLkrLeU12zdiGRyWqrSOYO1BI7Cybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750100480; c=relaxed/simple;
	bh=USxgzpl7+hY7G+QKeg4JLcc5y4PD6NU5jyW03ggM+7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvLuwhU7H680bM5In8RRBYsKpxLwY3BnfjjuUJv6eDG1LO4JEknZOc/zDUiwMrDuGr4LbBz7m/iAXbwnVQOEUTRwV4qnVBOQElxYYoSkeB2Yooit9a5C+p0HLn/asEHkFzAxkUaHF3wRpX6QQH4w5ULiQ4dErVZjAaq9KUgCVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yxhmWNlz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NAvcocV1hx7+8hA+DnXfce45O70Tw2fyTGzwBQS2idY=; b=yxhmWNlz1LbYftvFFhwws/TBf2
	Rdei/1IW/XI/M1GrLUkW5WdXD0e4+fD0VA4iD3AVWN84ydajb/qY9SRwMgwsUPGJuL+X2kphrLaoD
	036DlptDRiyTQbvrLdd5NdT3cztXWgAOtRIaXoxVsSjEnqSsb03AVJgbm2mQaO3ZZEmU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRF4w-00G4wb-Q5; Mon, 16 Jun 2025 21:01:10 +0200
Date: Mon, 16 Jun 2025 21:01:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] rds: Expose feature parameters via sysfs
Message-ID: <b71efc64-89b7-4f4b-af0e-9bf081cc9518@lunn.ch>
References: <20250611224020.318684-1-konrad.wilk@oracle.com>
 <20250611224020.318684-2-konrad.wilk@oracle.com>
 <05ac7bdf-999c-487c-beb2-74153d03f6b1@lunn.ch>
 <aFBlHiguQpdB1e86@char.us.oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFBlHiguQpdB1e86@char.us.oracle.com>

> I could not for the life of me get the kernel to compile without
> CONFIG_SYSFS, but here is the patch with the modifications you
> enumerated:

Please take a read of:

https://docs.kernel.org/process/submitting-patches.html

and

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You need a new thread for every version of the patch. You should also
put the tree into the Subject: line, etc.

> diff --git a/Documentation/ABI/stable/sysfs-driver-rds b/Documentation/ABI/stable/sysfs-driver-rds

I could be bike shedding too much, but RDS is not a driver. It is a
socket protocol, which you can layer on top of a few different
transport protocols. So i don't think it should have -driver- in the
filename.

> new file mode 100644
> index 000000000000..d0b4fe0d3ce4
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-driver-rds
> @@ -0,0 +1,10 @@
> +What:          /sys/kernel/rds/features
> +Date:          June 2025
> +KernelVersion: 6.17
> +Contact:       rds-devel@oss.oracle.com 
> +Description:   This file will contain the features that correspond
> +               to the include/uapi/linux/rds.h in a string format.
> +
> +	       The intent is for applications compiled against rds.h
> +	       to be able to query and find out what features the
> +	       driver supports.

Is that enough Documentation for somebody to make use of this file
without having to do a deep dive into the kernel sources? If i need to
do a deep dive, i might just as well handle the EOPNOTSUPP return
values.

> +static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			     char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "get_tos\n"
> +			"set_tos\n"
> +			"socket_cancel_sent_to\n"
> +			"socket_get_mr\n"
> +			"socket_free_mr\n"
> +			"socket_recverr\n"
> +			"socket_cong_monitor\n"
> +			"socket_get_mr_for_dest\n"
> +			"socket_so_transport\n"
> +			"socket_so_rxpath_latency\n");

This is ABI. User space is going to start parsing this. Maybe we
should add both here, and in the documentation, something like:

  New lines will be added at random places within the file as new
  features are added.

This makes it clear that any code which tests line 4 for
"socket_free_mr" could break in the future. The whole file needs to be
searched for a feature.

	Andrew

