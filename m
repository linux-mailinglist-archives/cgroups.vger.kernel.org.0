Return-Path: <cgroups+bounces-3461-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A14591D314
	for <lists+cgroups@lfdr.de>; Sun, 30 Jun 2024 20:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814E8B20B08
	for <lists+cgroups@lfdr.de>; Sun, 30 Jun 2024 18:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B00C155A23;
	Sun, 30 Jun 2024 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FqNB4rRP"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD7259C;
	Sun, 30 Jun 2024 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719770511; cv=none; b=esflLcepQCk7bT9ok+d3tFptrdRtqQut/Oz3XoYDIfy1ZenoCJnT37A1PRGAgxwn6xpTmIw4+nEbQvnlKfffG3xV6m942PDnkVp+Ltc5d6acMKguSnLusNs0wv4Rr7SDl2FEaZeQg8gOJKajg/5nl0mXAXn6QDr8G6jLCWzCrq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719770511; c=relaxed/simple;
	bh=JM4ts4Lg+u1XZgCQxkJ32EGuA7iSoUrxdkoZR/5bRXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciePGusA7N22/HER9in2pAoqmA1x2kDAHrGlwPCvj8CraSu4bnrT1a6b0wc6jMF4O+5Ehyab3+whrJLs9KkNsUauKFiSBGs6Y2A/CrYxgV4tcllQtyM5MogoChHowdP3WCdZIdXYDM2vhocy/nNAFzFvOlblqfmqztqAgP+h72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FqNB4rRP; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719770454; x=1720375254; i=markus.elfring@web.de;
	bh=2l5pzDpEunthmwraZ8MRcFVL/DiaIDsYVGK5RSImcgc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FqNB4rRPmpoZmTeZUtGks31irwq/sxmRR4g2EQlJvDaOKEaSm/ZJ3k426Pp3ZLE/
	 jn3dnCJe+qWetJeRivDkm/nBwUsNxbU1BZXuWk5qR9vK+cIFU4pKPfRbxjOyqOsC1
	 l1VKm0hDK1+yZyLf0YaNwNTWAvKdQvWMHXJI9xcnhwGoGTV0TKE2qUapKVnq5pUKJ
	 26NokycH2PpNif0U8ovQYUnE1F2jzcxsJNVKPSw0AMlgCziJn98cqCuvNtOScAu+z
	 P/eHE5x9Iz1EhtS2Pk972TCkBVczbWMGp/0lzD4tcMRtkui9UYlV7aWVdXGOk5YgY
	 FWyuEfjgSoDpxXBDpQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYtwy-1ssreI2Cga-00P5bO; Sun, 30
 Jun 2024 20:00:54 +0200
Message-ID: <55f0bd69-03a6-4a2f-94e0-6c62e2e3a6f8@web.de>
Date: Sun, 30 Jun 2024 20:00:52 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V4] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
To: Tejun Heo <tj@kernel.org>, Chen Ridong <chenridong@huawei.com>,
 cgroups@vger.kernel.org
Cc: Aditya Kali <adityakali@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Peter Zijlstra <peterz@infradead.org>, Serge Hallyn <sergeh@kernel.org>,
 Waiman Long <longman@redhat.com>, Zefan Li <lizefan.x@bytedance.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <20240628013604.573498-1-chenridong@huawei.com>
 <e5a78840-b623-485c-b467-828a5a0b7d37@web.de>
 <ZoGP6uV2oD4AdYWP@slm.duckdns.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZoGP6uV2oD4AdYWP@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cTPgX2zg7g/i2MT8VqlgAlTZHTJNvHuMDr/05KvwiUnXVuksN0z
 NlWTIryGqdGe6Z8m93kRylnebBLPEJfFuc2bqDXj0G1nPkJRLDH1RsUxatXBvC9oyeNOnhg
 IaCqmM9nIvotL19mRygn9zJ2HH6Rqj01JQg8aVI4NS3m8L4GQ7+EVy0p1M606SR2f7me41d
 wrIexzT7rhuIc7i8do0AA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sZuomuhfio4=;E3dx0FBev/VnnfLA+TD+f0rV1+f
 4eEGWRRAk6EDUalWCzS3YO8f+G1OlEqMHZPvopLjRSGS2CAAp4NlfVYs02bWWkxsRywynVrhC
 yKf/bOHcv98yFK953doqAQy4gbU0BIK+G5v0ztBwNIt2G32jmF64CbfptSxz0JbdibSfb9sjx
 dsKXVxuMYDrgTb4CA9YwoLCcOoyFiaEEiJYg+LMzlXCCQq7um4UJ8HpdyeT/6S12CYStnenxs
 O8dxs+HWcQYLpnMxqOntUlIx4qtwff+plrH0c5W5XJa0VPk+1WmI+ZFQKGNSqBNJVfz4ccEZQ
 o+k9wshAn8wCiHwKokx4XLQ2P6HDWkKYaMDYKkPBEqxTcu7gElbmWWctb3+3cT9Ppd9pSUh00
 znf3Cca3ykk3zMTtWxjk2Wv1nvznspKs9rE3G4ESUuXAZTj1EanFTfI4wnOM1WVNtRH2GAaul
 EXZAF5Aoz1XyPH3zLt8gYB0WEADqeojsbWzdpWGMCuDzxIk4qR89xLHHvcxBs146Q/hSU2TCT
 LHKEPcBCc3ya8dyaSjFqlp8ILVC6tgme0yCKfHGG9nYLt2Ai441Fsic3U+KKjLN2aB0OjtrM2
 ZlLwVGlGaCLhsRvqJtFSnYrOjRV5xyGMhpSHjCrkZa74s+nvXta2Yivc5YddoKhx7CiThKSL0
 zJ6skO7LFDbbWU3AqOthM8OvZfw0GzYnDXZ31q71If8bPV33eo1bmuGY5TlfwHt53hr0BgMvt
 aYBzW5md/MuM4NT5HuthY+1yeoeL1b2BbkTNXLtsJmvNll+/OAlRyRlAJ1z3HPHgjs4K2wXMI
 8vMg5m2zCVp1O5D64s4T8MHT6IYHu2XFZLUMNtp+X83r4=

>> Under which circumstances would you become interested to apply statemen=
ts
>> like the following?
>>
>> * guard(rcu)();
>>   https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/rcupd=
ate.h#L1093
>>
>> * guard(spinlock_irq)(&css_set_lock);
>>   https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/spinl=
ock.h#L567
>
> I don't really care either way.

I find such feedback interesting somehow.


> Neither makes meaningful difference here.

Would you like to support making the affected source code safer and a bit =
more succinct?
https://elixir.bootlin.com/linux/v6.10-rc5/source/kernel/cgroup/cpuset.c#L=
5034

Regards,
Markus

