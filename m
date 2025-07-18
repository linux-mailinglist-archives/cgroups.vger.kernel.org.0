Return-Path: <cgroups+bounces-8769-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F79FB0A46E
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 14:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378BE170F5F
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 12:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB80523507F;
	Fri, 18 Jul 2025 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="srG2GKYu"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24572CA4B;
	Fri, 18 Jul 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752842895; cv=none; b=Ma0GSTESuTElrISnnWdoIefua2OQi/eqO4MPhKAc6j7E6P7G0FXLQu8aqtQ+5bwcS1uc8mTxXrbukRvaIVeOr6OS/NNeWe0D3dJ9qlQ1gjnfKMGvP8G+8AYT7pYN3l2uPZY4dwpOmHNde5D5JPo9yz6NHvCbSZ0LNUHOALiqPWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752842895; c=relaxed/simple;
	bh=Gsab9fD3xI9Mag53PYLUfwNjLtNKUXEAuHUT4Se3sQo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LdptiWC44DW70tXA8oL6CmHKOfzwbIdZ/wkV5gHvaYvxcxQrQJPpzpXC9euGwYlH3IsgrdG/UHhfPkKgii/pNYz5Su4qIwbftv11ifD5T2mF9jUCNzpA/z9VyEFXrdMlXeTArd2rmdbRiF95d4AyZLs9ZBMLsjkaiCeGqlaJqyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=srG2GKYu; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752842891; x=1753447691; i=markus.elfring@web.de;
	bh=Gsab9fD3xI9Mag53PYLUfwNjLtNKUXEAuHUT4Se3sQo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=srG2GKYuSafG8D07vbFkYADQTELN823ECIaR7h0SJe5vs4oCy1wUsPYW7g3OzKWB
	 9qWJ8G0/93Np3rrtV45a4UDhdXcsS5krP+d4holoYbUC33VGpFzb2EIFFQhV8gymM
	 7x8+Lq2U4onYvl6Xel96m1VPuwU+1nGKq8x+Reku5on3poBvNHljZL5N/E905f67I
	 cGMs3xz9OMou16xNt4vQmTFie21y2hTys03+y2mEE5wKL35EAhIpxytZJxwv0HcIm
	 JvIqx2KOkQ8FiUFeSxTIr+5rjtT2dXbqsKduyYsJbm5ERk8LNYf6Nyshlwx46ChWD
	 ITvgObO1OwA55LjfEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.219]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MElZB-1uN8OP3Of5-007Z9K; Fri, 18
 Jul 2025 14:48:10 +0200
Message-ID: <1e0bf6e2-37a9-4299-8426-e495f3c43f1d@web.de>
Date: Fri, 18 Jul 2025 14:48:08 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zijiang Huang <kerayhuang@tencent.com>, cgroups@vger.kernel.org
Cc: Zijiang Huang <huangzjsmile@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Hao Peng <flyingpeng@tencent.com>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>
References: <20250718115409.878122-2-kerayhuang@tencent.com>
Subject: Re: [PATCH 2/2] cgroup: Fix reference count leak when cft->open is
 NULL
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250718115409.878122-2-kerayhuang@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:n9h/VgI2ZBDDRRNUAooTuanHJ2EJV2D8fVSw8GkyeXFmwOAyzqb
 SU+GF8Vjh/0bbBIrlzODc1l/Q3Po7UBVfKjlaoNp8Tt/ZoGo3LmPXH/Wyl/A6hy0LUadPVc
 RCT3DMUXTN+jDNQ7S0/NQBYiZknQjhk2o1FsSOv6UXCZ+liBmHV51V7iB5Fz0XCKt0NjkyC
 MUPo7IIay+qIj8jvIlEsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4Q40KKrmvX4=;QB51eumT2q4b6tixLvvOQoHOwTl
 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
 Qrv/gQEw/S/gU+2Nq

> When cft->open is NULL, it will cause ctx namespace reference count leak.

Would you like to point out that a reference count should be incremented
in another case?

Regards,
Markus

