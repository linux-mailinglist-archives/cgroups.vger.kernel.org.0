Return-Path: <cgroups+bounces-6641-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBB9A403FD
	for <lists+cgroups@lfdr.de>; Sat, 22 Feb 2025 01:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A208116D603
	for <lists+cgroups@lfdr.de>; Sat, 22 Feb 2025 00:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAEF29405;
	Sat, 22 Feb 2025 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qsXNdX9h"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2148935947
	for <cgroups@vger.kernel.org>; Sat, 22 Feb 2025 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183535; cv=none; b=qwRas70u1vhp3GhLjjEcryMT4Gg8fRbKv3WUU8FRNiM2Mf5j/zSptzXRcUl5LH7bRetLoskkLQPg5MIM0SubeGljImEWsHPtfYWb/wtGBRLmEm6TSHw+Z296PB9vMZNRGk07iqKO3yU7LTp0+HiaTTmHNDWULIgiH/RW4hcRfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183535; c=relaxed/simple;
	bh=tNgjdtela948x3WFDD1+icKgaUpH9hk1ye2oudztz/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXG9RQg9RnBaVwYmpmGw5jMYg76hgTRBorsWlmxM6dKm3bi9f701JYciJ+3dQrenlAcBDw1t/zviGKkRMzlUXj+o4KPIi/OcW0FRos43ifdeUQR5ii53VUzXzpFpIINgMLxOEcwbpQI2MtNbQmM1w+CD7VO6DeTcEpVSGnO1RaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qsXNdX9h; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Feb 2025 16:18:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740183530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2DkFMFVwJio9H889cSd6PIdCJnBPZmSuOMV6zvFHRI=;
	b=qsXNdX9hxJpzedZf/7Gwc9bYV5MZjOPWTaO2Cmp1X58GzDU3rPCY829lFt5tRRrlEll9kh
	Ec80/VTW0cor/nWyjQaYq7mSSFpn80A6I907FGEF4c23vEeek1g+uXm1d11OKxvHkUqu/k
	mchWk/e1MolVzQAo0IQIwVZjjL+Tqp0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 08/11] cgroup: rstat cpu lock indirection
Message-ID: <c5nd2ty3e4znz3abrls46wlqs64vzwzq2j45k4cq7rsucbe2r2@wpbr26gmxtzn>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-9-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-9-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 17, 2025 at 07:14:45PM -0800, JP Kobryn wrote:
> Where functions access the global per-cpu lock, change their signature
> to accept the lock instead as a paremeter. Change the code within these
> functions to only access the parameter. This indirection allows for
> future code to accept different locks, increasing extensibity. For
> example, a new lock could be added specifically for the bpf cgroups and
> it would not contend with the existing lock.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

