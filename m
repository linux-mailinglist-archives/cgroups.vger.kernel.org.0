Return-Path: <cgroups+bounces-5255-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F59AF6DB
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 03:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901511C217F3
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 01:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C6071750;
	Fri, 25 Oct 2024 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RGmI6tKR"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F34B60B8A
	for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 01:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820022; cv=none; b=AMt7udNv37Ytf+Rw1uh90s2v23r3RbiZPb7ADOfVFMFTPnZMURF2+9ZrRdSa6KKqM/rmrlDgb4H3TvSh5oxhAJDGZyqzOFXzk+LEO5kaVo0nJwXG/0cbOWCMft2kr7iZK7cAwylbqb8XsD3M4LckuNbfIIZOkAKFjNesjrhQTd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820022; c=relaxed/simple;
	bh=52QRq8hygu5PMDKS2MH6a/Y24KdWAkWnn2hippVQ7Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwAiAIINPCLord/6NLvdHVqxFtIzHfgRZIN5wbaY3i+jR5vV0riy7VqweLIYvao0FFDcA/h5tj80yJ0I862gUJJIYZlTUKbYccxxQxNalDCBzj0nOCSh44JAFxUzHAm1TeBs+SeGrivmx98xwJU71/iWKFL3oY5S9LJcdxJ2hvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RGmI6tKR; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 18:33:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729820012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3cyFDDl9Fn7myhSdVnKeGIMsM9Cumy3wrd3akiTWoU=;
	b=RGmI6tKRO283K/VPcEyaGbgj6d6o/79ispGa/A4c/lTmtS+WTBqQ+UGcPGb4fBSRUIZgOI
	IFHh4PFjVOPE9ppsaV5R4c+rqgECVqvpcRuJezz78x1C3oxSTlw5XXyOok2IhVQFgvSI/7
	3p7/Rl7oWOD3WDoUSn/9dk9FFc1R8b8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 0/6] memcg-v1: fully deprecate charge moving
Message-ID: <isidrym2cm6qshx2t6v5vvatd7vmyrd7ve543rgy4ddx4csiej@x72hqvpkkwfi>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 24, 2024 at 06:22:57PM GMT, Shakeel Butt wrote:
> The memcg v1's charge moving feature has been deprecated for almost 2
> years and the kernel warns if someone try to use it. This warning has
> been backported to all stable kernel and there have not been any report
> of the warning or the request to support this feature anymore. Let's
> proceed to fully deprecate this feature.
> 
> Changes since RFC:
> - Writing 0 to memory.move_charge_at_immigrate is allowed.
> - Remove the memcg move locking in separate patches.
> 
> Shakeel Butt (6):
>   memcg-v1: fully deprecate move_charge_at_immigrate
>   memcg-v1: remove charge move code
>   memcg-v1: no need for memcg locking for dirty tracking
>   memcg-v1: no need for memcg locking for writeback tracking
>   memcg-v1: no need for memcg locking for MGLRU
>   memcg-v1: remove memcg move locking code
> 

Please ignore the patch at [1] as it was resent by mistake.

[1] https://lore.kernel.org/linux-mm/20241024065712.1274481-4-shakeel.butt@linux.dev


