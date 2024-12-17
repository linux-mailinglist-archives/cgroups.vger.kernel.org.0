Return-Path: <cgroups+bounces-5944-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788049F54D6
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 18:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4372173A0C
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384441F8902;
	Tue, 17 Dec 2024 17:37:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1CB145B16;
	Tue, 17 Dec 2024 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457049; cv=none; b=qMFc94SvXX2NUNOTUnjZarCgjzOOOe6JWxxpHc5QTk97en8G5SuhnOmZBinrWaEzh/udG84KflKJ/FGj5ViKAjzv1D8dFCXGWA1XcjMvlElwLUUBQtKR060gy+X1wS8YEO6+Kw46Quy5EADgVGbLyCGcj9fG8EXFvHTkXuM0eXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457049; c=relaxed/simple;
	bh=BuimlMyL1nw6uUan5hk/CM44c/QqaJtkdxw+QNMrsH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mt7pI9Rb4sISXRIfGIQDTNBwEj8VuSumB8Llwi+1tOdNbjsD0HifEaFE7bdTFYa0TbnZZ5r41TLuuV4PjLpNyRnTpRcS2FzCvy/p1EeQkuYSoF7SUR4bnsB7Do7COlmKuPDtrayL2Be/WZNhcQJjTx6hUNiIgtcl8kOGhmPcRiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=none smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lankhorst.se
Message-ID: <c0a539e7-0f1b-496a-9848-73a7ada66bfb@lankhorst.se>
Date: Tue, 17 Dec 2024 18:37:22 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
To: Tejun Heo <tj@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20241204134410.1161769-1-dev@lankhorst.se>
 <20241213-proud-kind-uakari-df3a70@houat>
 <80c49a80-d49c-4ca5-9568-9f7950618275@lankhorst.se>
 <20241213-gentle-glittering-salamander-22addf@houat>
 <5a50a992-9286-4179-8031-ffb514bca34f@lankhorst.se>
 <20241217-meek-bullfinch-of-luck-2c3468@houat>
 <a69a3500-be17-4899-bdb9-c6a63bf8dc81@lankhorst.se>
 <Z2GwpOQDVshpv-ml@slm.duckdns.org>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <Z2GwpOQDVshpv-ml@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Den 2024-12-17 kl. 18:11, skrev Tejun Heo:
> On Tue, Dec 17, 2024 at 03:28:50PM +0100, Maarten Lankhorst wrote:
>> Now that all patches look good, what is needed to merge the series? Without
>> patch 6/7 as it is a hack for testing.
> 
> There were some questions raised about device naming. One thing we want to
> get right from the beginning is the basic interface.
> 
> Thanks.
> 
I believe it was solved. The conclusion appears to be that we go with 
how we defined it in this series. drm/$pciid/$regionname. With the only 
regions defined now being VRAM. Main memory will be a followup, but 
requires some discussions on hwo to be prevent double accounting, and 
what to do with the limited amount of mappable memory.

Cheers,
~Maarten

