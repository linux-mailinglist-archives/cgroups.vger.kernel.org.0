Return-Path: <cgroups+bounces-6629-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4698DA3E330
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 18:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3542619C02EC
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 17:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E83C213E6E;
	Thu, 20 Feb 2025 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KhPDqKQ2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42187213248
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074362; cv=none; b=UkcCg8Dfz2eT8OyD/eKvRNN29BMsFms4SzNe9pSsetHQpQGu5TshOoVxGMvI34TqgwIV9jh8BtFKbStqecwLTYchxnMkPPRbLk2s0Eh7CB3CgKXVv/uoOTpP5e/rvd3PSMm1M1zU1ozocEXt9jPpm2y1ItuzR6tsKWlWwPYkEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074362; c=relaxed/simple;
	bh=1u+VHvwti+AJiffWdr01QmBQEw3p09eUPuIRc0FiWOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcKdE87Rpg6Ps1YAAtFMia/Zn+9okNoKr1sveiJaOapO7/To6xBMLtieGP1w2tFaa7F8deF0rWZS06LF79X3JXZExZasf3HxeOZSUq6BOdHTpoinA7gy7P2tivMW44BUOI84IIg7YkL+tXvSkp+WV9hzaFfpzar2ZNQsInr+QRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KhPDqKQ2; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 17:59:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740074358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CIE8933nkdbMTfThhnyOExCftBCOOb6dTYoTdaWqWRs=;
	b=KhPDqKQ2M0vLNSPCo3oYTs0ngvjwW/9RbUTIi33SYi3Zatd8jjmmFNJLvthNY0H3jXt1vl
	x/krK1pwGKFcS+UPd6NGQAz2wEKNVRPOTuwKzjXVjKe0PDyDLLupu+KQgR44lZg1L+ozbL
	OFBBUuca6iX0KPwmxKTxa5ucDQ/jPbY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>, tj@kernel.org, mhocko@kernel.org,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 00/11] cgroup: separate rstat trees
Message-ID: <Z7dtce-0RCfeTPtG@google.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <Z7dlrEI-dNPajxik@google.com>
 <p363sgbk7xu2s3lhftoeozmegjfa42fiqirs7fk5axrylbaj22@6feugkcvrpmv>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p363sgbk7xu2s3lhftoeozmegjfa42fiqirs7fk5axrylbaj22@6feugkcvrpmv>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 20, 2025 at 09:53:33AM -0800, Shakeel Butt wrote:
> On Thu, Feb 20, 2025 at 05:26:04PM +0000, Yosry Ahmed wrote:
> > 
> > Another question is, does it make sense to keep BPF flushing in the
> > "self" css with base stats flushing for now? IIUC BPF flushing is not
> > very popular now anyway, and doing so will remove the need to support
> > flushing and updating things that are not css's. Just food for thought.
> > 
> 
> Oh if this simplifies the code, I would say go for it.

I think we wouldn't need cgroup_rstat_ops and some of the refactoring
may not be needed. It will also reduce the memory overhead, and keep it
constant regardless of using BPF which is nice.

