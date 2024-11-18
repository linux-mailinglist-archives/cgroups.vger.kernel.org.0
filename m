Return-Path: <cgroups+bounces-5617-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1469D1620
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 17:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60469282ACE
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 16:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C5B1B6CFC;
	Mon, 18 Nov 2024 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nwE6SKbQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A71A00F8;
	Mon, 18 Nov 2024 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948880; cv=none; b=R1b/l+DRVThSxJ40Qne/97v0sE/0qthdzTWFg35g+6InMGErmMjknw6CPWDwwIF0xepQhXu4M3D8noAd8vnXODJq1RYPchgRlP17U4sb7Gx84hnM212P0HXXJtH3Tp1kJ9Vr5WMZoYQVPjqSFo9CbnY0ow0G5qlYm8eOHQnB8KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948880; c=relaxed/simple;
	bh=zPj/dC98kkRn+UKiK2vA5JU2TJ53OmJyxLTKysXIbmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqAHBo83QH30pxauibTHQp98n5bxXxMnlho0YkBHZpih8CJIw1QvY+nf5S/CdqtxCVbGhkmHS0whkZBuEwcLZzr96MFQhH99VAo5+j/+NN7Agxu9RBhiocrldaHxVgudt+S0DbESDnsD3HV+nJ+0c5e1ETpvG0EUmtqXNV67+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nwE6SKbQ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Nov 2024 16:54:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731948875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7reLWwmTn1z5R7AVGPER+NDMgklm9tqFwDlMhXCXMPo=;
	b=nwE6SKbQGlEXsiLlOIPmBPT9alBQzKvp9gQnn3qacGfc3ApieCYGqsqJpzDNzW2KeJPmU6
	CM2n7M43mumhCI/t3mnn8obZfpm32o0t0x4BQqfp2u0mkH8bUTLu/97sVEmX4AuMSqdcPs
	YrQ2r0V0aq1wPr6M0NzyTo3ObbEzCQM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Keren Sun <kerensun@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: prefer 'unsigned int' to bare use of 'unsigned'
Message-ID: <ZztxRbTVAbvh-9kb@google.com>
References: <20241115235744.1419580-1-kerensun@google.com>
 <20241115235744.1419580-2-kerensun@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115235744.1419580-2-kerensun@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 15, 2024 at 03:57:42PM -0800, Keren Sun wrote:
> Change the param 'mode' from type 'unsigned' to 'unsigned int' in
> memcg_event_wake() and memcg_oom_wake_function(), and for the param
> 'nid' in VM_BUG_ON().
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Keren Sun <kerensun@google.com>

A small nit: Acked-by tags should follow your signature.

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

