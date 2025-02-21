Return-Path: <cgroups+bounces-6639-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8C8A40270
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2025 23:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CD786403A
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2025 22:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9997200BA2;
	Fri, 21 Feb 2025 22:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vmI1CpxK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5404B1FBCAF
	for <cgroups@vger.kernel.org>; Fri, 21 Feb 2025 22:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740175770; cv=none; b=ZbooxZfVmoDppdFLGAHXOSyggr60yFRr106Ev/zIAEpisoRRiqu8Nsiv3JM4G4i5lcbCvfq6Ra+zSP0u0KY0iGM/sfHamsN6/t4XmTLFXOme2gwx4QYMR0Qe+2dcXFu9DLXyvSKR4SYGApGh3ilyCv9SZv7D8WQhGYkXTN4p/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740175770; c=relaxed/simple;
	bh=h6UXDUXY4m2r1TPVbSfFNAC+B8w04ebIypXkCGSxJUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHk5bRdyg6O1gzC3hezSOF94uiRBMwHQngB0T9BTrkYsdQaqQrg2UjWrmlQH0zmxwn+iyqvi6Kqe5oozu8xLa/B/u7DcgeE3EAYDpfjNOF6wAZdQLPHSIoPAunjyTEEDNqGpi1ouI9YvGItKtBqEfKGXmIN66A+1rIWUQgeJlSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vmI1CpxK; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Feb 2025 14:09:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740175764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ff7GplsJETsFRnID6bxEAoUm0JuKYcn12o3QxaY57WA=;
	b=vmI1CpxKKIjW0NmqLL4Q8ctTxh52z+BUxmjW6O3AyYgd2MNSBZW3rOZ765lrXQLJCF8QJp
	vRmmOx6jBnk8FEWqRj3zl2cKx7LylktpP/YLpd3pXY4BPGNVa944gi/ed1EhGRhpwxERLO
	sN8e9H1rLCM1L3gzO/cH1MfuxKZ3ycM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 06/11] cgroup: rstat lock indirection
Message-ID: <4ifdcruyhsszzpurygsijrlsaea4zmc4g5crgsk4ekevsh7ygs@yqwc6iw2aoyi>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-7-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-7-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 17, 2025 at 07:14:43PM -0800, JP Kobryn wrote:
> Instead of accessing the target lock directly via global var, access it
> indirectly in the form of a new parameter. Also change the ordering of
> the parameters to be consistent with the related per-cpu locking
> function _cgroup_rstat_cpu_lock().
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

