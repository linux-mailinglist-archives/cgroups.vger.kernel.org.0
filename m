Return-Path: <cgroups+bounces-6433-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F863A29827
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 18:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D56D161853
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 17:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F89D1FC7C1;
	Wed,  5 Feb 2025 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Zeq2P3QQ"
X-Original-To: cgroups@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978B01FC111;
	Wed,  5 Feb 2025 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778186; cv=none; b=aWMVncaZDykcw94abvM24fwLzrmqQHsiLGn45OJiPEAoLKKsXgDAg0m16tfVEq0JSqa1pv5hLVZbf6+1jv9TBr8Gf10HT68uxhp3LYoPOr2DwuelcSHy2P6g7jqzbsjT+iB/F5L6sj2UtjLQeF1Z8bq+GxiySRX0bwDNPPrpjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778186; c=relaxed/simple;
	bh=VJMpmOXHqXJkGyy8pbyVg5hd2QEIfnpnPgIkpF+ZB3I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pzzY9EqkXWqwOEtGPMtrzUjsdyQEBdTcYIAUfOtA6KJKZH+FEFapbqPaTz1uDOoDJbT5JzbLZjTWNVTJwVUqHk7eXC74K9I3Us/CjHMgIlYn22YJj+Lg7njHBkAjHxu91DHzqJkmI6tuz+dDYS4tOsrMY2u2GWa4QleMOxTuJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Zeq2P3QQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2 (bras-base-toroon4332w-grc-32-142-114-216-132.dsl.bell.ca [142.114.216.132])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7C4E520ACD7D;
	Wed,  5 Feb 2025 09:48:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C4E520ACD7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738777700;
	bh=VJMpmOXHqXJkGyy8pbyVg5hd2QEIfnpnPgIkpF+ZB3I=;
	h=Date:From:To:Cc:Subject:From;
	b=Zeq2P3QQfB6fqXABp/Y7dlqfdhdbKAvD3pOrv4OpcsCkmLcDDWqDn1Jl4vzOAB78L
	 4VIzIHtd0bFEOE6cwHiLtPyo1OFKbSDgt/hMB+QVPwcLbTERNLry+S5HoZAp8oTUQR
	 wErejlPZDwYFHiuTgsc099ArxGqM0Ze3JgwwLi5I=
Date: Wed, 5 Feb 2025 12:48:13 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-mm@kvack.org
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeelb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Allen Pais <apais@linux.microsoft.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: A path forward to cleaning up dying cgroups?
Message-ID: <Z6OkXXYDorPrBvEQ@hm-sls2>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I was just curious as to what the status of the issue described in [1]
is. It appears that the last time someone took a stab at it was in [2].

Though it seems like there has been relative silence regarding it since
then. So, has there been any discussion regarding the issue since then
and does anyone know if there is consensus on how we should go about
resolving this issue within the kernel?

BR,
Hamza

[1] https://lwn.net/Articles/895431/
[2] https://lore.kernel.org/r/20220621125658.64935-1-songmuchun@bytedance.com/

