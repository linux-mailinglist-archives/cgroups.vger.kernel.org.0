Return-Path: <cgroups+bounces-6432-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DC7A297F4
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 18:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3CA7A0262
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A7A1FC0EE;
	Wed,  5 Feb 2025 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HrtU79ev"
X-Original-To: cgroups@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530381FC0ED;
	Wed,  5 Feb 2025 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777822; cv=none; b=TiEkrFtif7QP57Ol5QAizNpX/OX5eaA60IWjs+j2rYEipL6A0Tt/mjcQ1cN99hO2PSawzUdvWQge0UIIBOBtGLwyVPrXwylwdBlNb8wP4OxZvo3MY1/hajxng2Pi+i64PsjOKRuxgNxF44Pheqv/VJCt+ntGOYcYEBgtJ9CrQ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777822; c=relaxed/simple;
	bh=abN9KipNnaEw5cUvmYhbDmtzvc9hKPinaUEoZCnA0UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7aNq/lN10mKkb9XflPUVXaJp/EW2hZQlfL3B+fVKke27vBTyo0F8KLRFpeVQ8jNhAHrhXCi0dXMdwjbYu680VoVLA1fTQEraG4afLP+UibAZvvddYrlA+YBSqjJiH33YA6de/KYZz+phtH4NIERqqKFnf03ih6m0VTnkZEHe8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HrtU79ev; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.2.246] (bras-base-toroon4332w-grc-32-142-114-216-132.dsl.bell.ca [142.114.216.132])
	by linux.microsoft.com (Postfix) with ESMTPSA id 08B45203719A;
	Wed,  5 Feb 2025 09:50:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08B45203719A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738777820;
	bh=/QdguPZCzgq21lnkBKomUMawlFCJW7ToZuaOaJesVug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HrtU79ev3S6VNI+UDLf9dMlKMVFtAFwBX6Kz/ljPAMBJWWoN4oGWPym4ZZCDlXub/
	 stHL5KYAFfNfcHWK45Ue1u5Pr1ThnA4bXOVv2qyIB+IffDaF3mBVLtCw5SG+2flK2Q
	 wKXThpc02bjtdZURzbMA/sRqrciCjoVpKz2I0480=
Message-ID: <ccd67fd2-268a-4e83-9491-e401fa57229c@linux.microsoft.com>
Date: Wed, 5 Feb 2025 12:50:19 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: A path forward to cleaning up dying cgroups?
To: linux-mm@kvack.org
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Allen Pais <apais@linux.microsoft.com>, Yosry Ahmed <yosryahmed@google.com>
References: <Z6OkXXYDorPrBvEQ@hm-sls2>
Content-Language: en-US
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
In-Reply-To: <Z6OkXXYDorPrBvEQ@hm-sls2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Cc: Shakeel Butt <shakeel.butt@linux.dev>

On 2/5/25 12:48, Hamza Mahfooz wrote:
> I was just curious as to what the status of the issue described in [1]
> is. It appears that the last time someone took a stab at it was in [2].
> 
> Though it seems like there has been relative silence regarding it since
> then. So, has there been any discussion regarding the issue since then
> and does anyone know if there is consensus on how we should go about
> resolving this issue within the kernel?
> 
> BR,
> Hamza
> 
> [1] https://lwn.net/Articles/895431/
> [2] https://lore.kernel.org/r/20220621125658.64935-1-songmuchun@bytedance.com/


