Return-Path: <cgroups+bounces-6326-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84375A1C522
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 21:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A473A7636
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 20:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFF1136326;
	Sat, 25 Jan 2025 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dR53BHmJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C87082A
	for <cgroups@vger.kernel.org>; Sat, 25 Jan 2025 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737835904; cv=none; b=cQ4x6qTBs+kLmzjDed90sbvWRYKSTcUJ/xjNxa4JoPDIgcemiBrM0fkQfC3kM1gps8uSLKsULaA+Mp5GBv2so0JQ0SuyhkxHAkfeBh44MCfy3n5cpIP5grRXTlzeoJgLzNHxvR6IvIHdlHLIL5zshstFtzP6lgyfExWraiOw3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737835904; c=relaxed/simple;
	bh=aeNLY+tfAE5muBohjYYW7MKpBTlMDJAGJGzYsCLRSQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnDUG7r7ZJ/f63Ga/nCnPkwEPq/mxI4Ec7qgPsxV9wCjguuRyzpBhwB8o/UqKOEWVPwflnFvRklzsTBJOUBJ/xsEDaOuzjUCZ6spQubVJzlz1ZqLFjFd0TtMuSzJeNmCsklH7tS9qqhFpvNBc8UaSk06RS3rma457fZYUDTACSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dR53BHmJ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 25 Jan 2025 12:11:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737835894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sl2EYcha5zEogkDolDYcBRo7zHOQtC0p79Azaal/sso=;
	b=dR53BHmJnB7yBOdg197zGsb49y5xVZBnUImqis8dB5cHLlBU693V2HwyPcvafYCciPKjvY
	CsJZu2Rz3Wq17myi3TfY7+Fj9tfF6jk4y1aCO2y5Y5LrOon/cTQzN9iFOTBwnyrg4Y/gUB
	EJhJWMTRePrkWHL+tv+cnX5dfA8FKpk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: memcontrol: unshare v2-only charge API bits again
Message-ID: <5y423amoh5dokpe6n2rfrthkjftmeih72363evolhjpmyx5rdd@y4giwx5bz5qr>
References: <20250124043859.18808-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124043859.18808-1-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 23, 2025 at 11:38:58PM -0500, Johannes Weiner wrote:
> 6b611388b626 ("memcg-v1: remove charge move code") removed the
> remaining v1 callers.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

