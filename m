Return-Path: <cgroups+bounces-3381-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C86D918DE8
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 20:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1008281175
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 18:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D454190076;
	Wed, 26 Jun 2024 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cHaNHdkZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4CF18F2E3
	for <cgroups@vger.kernel.org>; Wed, 26 Jun 2024 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425252; cv=none; b=gGIwjGfNkYcItSjvUjwlgAizgZy7M1ry7eC1JN9FzqZF4ORKkFNoENHmFwong7C5Tx6UB/9yOwqQ/W2/caRWBKpMKwo1UlLyRtZ3aHsLcxQojd5yRfzmxzJWJ+RQw6R42lDOstG/nTsoEmMhZRAP0on5y1R+ShBeA7zVl6kGC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425252; c=relaxed/simple;
	bh=ChwYTbtsnCLanGl+61dAeM3cusuLWtix85Mu0FY6kF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdTxS+gUZzRW4CjpoW5NaoXfJ2jdp23qTMQVYWfGIkRqpRBQKYtJPkjvYxCDaHvglHlhfSUz06/FdjTlGlvvLNBzD/inMaPnMOqpCVbc2eTNRn39hRTkY5azsE12GucRytePzZZ3iZDnyv0CJUY01ftwDVCxAgQ5eP6bh7OqH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cHaNHdkZ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: shakeel.butt@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719425248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1XztXgyyt6OtvILQrb9rH4AWH9T5KNs/lYkpK11kd2o=;
	b=cHaNHdkZBRs81HNTRh86DPfpkSuvoClF6xKLTOV1jUqpiHW2kj5ex0mN825VRJii6AZ8fs
	FxvcSLdExgi3VucaeSsjWaAteIaVvvgYgMOFo+cPHyNr8QEEIlVtlL0mK/nb3eI4yDxq5L
	5r1xN6OENtnT3MRxJ533FelLsNwd8Q8=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: willy@infradead.org
Date: Wed, 26 Jun 2024 18:07:23 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 00/14] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <ZnxY23b_0g5_gtpJ@google.com>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
 <rkztmxmrsjw7cdwh3jcbhte3izirveb544vc7qbmpxpc6gmgia@htjd3ozkxpcd>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rkztmxmrsjw7cdwh3jcbhte3izirveb544vc7qbmpxpc6gmgia@htjd3ozkxpcd>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 25, 2024 at 10:03:53AM -0700, Shakeel Butt wrote:
> On Mon, Jun 24, 2024 at 05:58:52PM GMT, Roman Gushchin wrote:
> > Cgroups v2 have been around for a while and many users have fully adopted them,
> > so they never use cgroups v1 features and functionality. Yet they have to "pay"
> > for the cgroup v1 support anyway:
> > ...
> > Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> For the series:
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Thank you!

