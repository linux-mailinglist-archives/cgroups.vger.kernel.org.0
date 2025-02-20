Return-Path: <cgroups+bounces-6631-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46201A3E4A2
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 20:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85AA37A5EC1
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 19:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83861E9B1C;
	Thu, 20 Feb 2025 19:00:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02BA2144D6
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078053; cv=none; b=nVZF/GwmvIni9NRklklb+njkm1w9n6joGvlqfJxVLUzYovFlL0m1Z+y9W7pWeCnyjRJ1Df1VYQ7rnaGDbxxCLPJmLS/WIFMQuCMIQ7ytK9o1XLWFKeQImOA7+nQctgQfoxd0yYT6Dk4zXt3kLKGptthRac3+CfsXjFPAFco7qnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078053; c=relaxed/simple;
	bh=KLk5i4gbcwYIxC+GPgJYEqivWFCu7nrTSR/E8qgxBu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9vkyj2fmUcjBXXjXNd9x65O0Axnse0wcrEIfGpiaaI1Jf158DZaYzeBPETGxngi/sOl79q8Amkl43LurVVOAFUIRFg22hTuKcodu3z17XiD6qEO4lIEhPLXs3250ERTtzuqzF1aRduGaGIT03gBUQWXhq8igE1L5cB/VGY4aBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Message-ID: <e8883543-e80e-4c9e-80af-475bc79c4712@lankhorst.se>
Date: Thu, 20 Feb 2025 20:00:47 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add entry for DMEM cgroup controller
To: Tejun Heo <tj@kernel.org>
Cc: dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>
References: <20250220140757.16823-1-dev@lankhorst.se>
 <Z7dNdKLxEDqxkNmJ@slm.duckdns.org>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <Z7dNdKLxEDqxkNmJ@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you all, pushed to drm-misc-fixes. :)

On 2025-02-20 16:42, Tejun Heo wrote:
> On Thu, Feb 20, 2025 at 03:07:57PM +0100, Maarten Lankhorst wrote:
>> The cgroups controller is currently maintained through the
>> drm-misc tree, so lets add add Maxime Ripard, Natalie Vock
>> and me as specific maintainers for dmem.
>>
>> We keep the cgroup mailing list CC'd on all cgroup specific patches.
>>
>> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
>> Acked-by: Maxime Ripard <mripard@kernel.org>
>> Acked-by: Natalie Vock <natalie.vock@gmx.de>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.
> 


