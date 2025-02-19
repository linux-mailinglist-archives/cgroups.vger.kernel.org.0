Return-Path: <cgroups+bounces-6597-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE56EA3AF91
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 03:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC443A572A
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 02:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1257815B543;
	Wed, 19 Feb 2025 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lft+X4la"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79F13665A
	for <cgroups@vger.kernel.org>; Wed, 19 Feb 2025 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931976; cv=none; b=qEtOoDxKsp3NE/HFtYhs6lTsARJguLm5vBNuRUymQ8WJNw3DHcahgaMhyIadTLbRJfcxrD29+2WuP+O2unUyQ9634Y7bd+xFwhTZrOvZBfjLD1vcvBrUyTq5ZVRK/3EyzlLtp9vgiZeIWsK6MMl2K5Da6Y/gw3JItJb1rb2h6HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931976; c=relaxed/simple;
	bh=zI2ptk6c44vWgPFe42wwdE2JaYgw5en0tDheTR3bvIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=it1z0FbSF5/yX29XdDW+y1wX1Iz0Q9tWe+vC2QBkgwF2dtaBK/kiOtvMBkV996r87vUORFe+GDPWMRi6/Wfr+jXtD2KD3zpag0j7x+r54vDRoDtSt7SIVLcJVtWG8iN8PqPUI142N+dhrmRZlYipC1J0pwXsAemNP83HgYXzRj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lft+X4la; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Feb 2025 18:26:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739931971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKAu9cP1VyXXRGu/Q46hWn+GVwoDBvQa3gtfujndEZY=;
	b=lft+X4larQiMUh/x7eGgPYKGgRK5qk7Ily0Tw2UXmNOoq4q9SNIo/V+zAaaU7am2N8xPas
	JUpvkTiJhYObGKOuUtsnu0Pab6e27Zgjsn7HH/ZG9U5fZ26ZbCWE7wKamt30Ceeyh6B0OT
	erUFtnTvpmLnr6zbkSfteWeFiRKuFec=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 02/11] cgroup: add level of indirection for cgroup_rstat
 struct
Message-ID: <xl2xxrfpixx66hbywv3njmdj6cckawtjiwri5nxcbc2gtz2ahu@5axlmmuzplzz>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-3-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-3-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 17, 2025 at 07:14:39PM -0800, JP Kobryn wrote:
> Change the type of rstat node from cgroup to the new cgroup_rstat
> struct. Then for the rstat updated/flush api calls, add double under
> versions that accept references to the cgroup_rstat struct. This new
> level of indirection will allow for extending the public api further.
> i.e. the cgroup_rstat struct can be embedded in a new type of object and
> a public api can be added for that new type.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

I think the code looks good here but the commit message needs some
massaging. From what I understand, you are trying to decouple struct
cgroup_rstat from struct cgroup, so later you can move struct
cgroup_rstat in different structure (and maybe later some new structure
can all include cgroup_rstat to take advantage of rstat infra). I am not
sure I would call this "add level of indirection". 

