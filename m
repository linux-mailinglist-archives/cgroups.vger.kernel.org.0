Return-Path: <cgroups+bounces-3003-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8748E8CF10B
	for <lists+cgroups@lfdr.de>; Sat, 25 May 2024 20:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D75CBB20DD5
	for <lists+cgroups@lfdr.de>; Sat, 25 May 2024 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BD9127B51;
	Sat, 25 May 2024 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gPCtwBgA"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342C72D054;
	Sat, 25 May 2024 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716663385; cv=none; b=maHpGQ2+R/LPq6eAPGRZoSsIuP6lsUCnInBveIE9BiBL+N8V9aoasZ+DhE+8KYuPMugJNMrA4OvEp7EB5mqO/xyv+DHYVFiUds6PsRqrRUEyB3qSxdLs5H4/W7OxcMU17CqiRm5Vc5ZcCsHORu/WidI1SiyUMwuKkI1Q+euGrJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716663385; c=relaxed/simple;
	bh=u5kc3T0d1t7VTulBjsJ9BN9TM+HxwlgLQTDBgj+qAtg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tPGEGTKUnqDioGe2i03/1dAEfic6NLYv/qKzffgsN1FsRZlvXrWA+jd3E52cpBAoMJEODbmmi2jIqSch/vZcysjXvHAD5k/D7MZhBeMJzmwOOLkSWB5Z3Psu9Rae06nKEWbQTTfiSGXkAjubkEsZsh4FX/nFmiIHbnHjJsarYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gPCtwBgA; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716663345; x=1717268145; i=markus.elfring@web.de;
	bh=otZ1ymj2tqkpbqE9c0QPaxhZ2hMV5/4szWg3ccvyUUM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gPCtwBgAxy8hXOr9pavL+mYgllfCZNwIaYf5tAFKy13EjxiJoA8Z74v+SfeJXQ2t
	 CrYokUsEHLerBl0eHPh2US4zXsMKsRNoE4ikUOELNsQBfi3ma7uJTfUHJC4ehjW/k
	 59VfIfPSQ0KGO1NrqLXzdBENF+jM7Mrrq53F+Ygsdb3XVCon3gmovtEQQSEqb7EZI
	 bdMbnxLjMGpBsGrmLMAY7QMBcAlcIXi4fYeULn3//KJtFphH4RqXJLNpJaQMpWPtH
	 mzcliTCGP8jOzWpdlz/J3gGNDiYyEJMJjN2RxSBWyUe8upUBMIxspXeeyXGdwC6nF
	 XVGkTiEyGtuoYUY/7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3ouq-1sbVwn3PAe-00siTw; Sat, 25
 May 2024 20:55:45 +0200
Message-ID: <57cef938-fe79-4745-80a1-1285f87cdc7c@web.de>
Date: Sat, 25 May 2024 20:55:43 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xiu Jianfeng <xiujianfeng@huawei.com>, cgroups@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240525094403.1584987-1-xiujianfeng@huawei.com>
Subject: Re: [PATCH -next] cgroup/cpuset: Remove unnecessary zeroing
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240525094403.1584987-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4H/AFM09eXMdDH8ofE10+RVKwkLM6PKpcF+70soekPfLQNIRinj
 Ho02yw1vWFDtYO+nK+kQuD7u7ktt167vDyzoeXBqiz+eT5idXb8t3Ukmmn3EXFFstd5H8aG
 O2yP6PpIHCGROtFgHFx0ydALjP/R0DGTItgzegm7ZLVG9uyFSSI7v/DufqO9oD42LvlJ3M5
 DnsfAiwCR5hypMB8jYObw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5IuDjFeHSXc=;M6r+191U0bS7HoIkE9j5DzBA6r9
 AjFoWXvKvPa5EK+fR41iMeFxgcyJj8rVh21tYzGOrOJFOgjaTuyI2nh6pnfo0tVlABSfGsMG6
 Yzxy1CELxl6UhIb3QPxjYTQxQN5KTZA2NzyRqhq5HkD4QFoWEL6juHSj666O8UZcuUqmhbFcb
 X+0kPX8P5pKuXHK0s4/2kudiuUKVAAoosYRNCeep0l15Uxl0KpOSg5rZm2lt0bq366rXvP7U3
 CjwqgG/ttlNF7Xf4JHGBCwNlAOn0/3xQkQ6vNLGrGs2MUCKUxsoxiR5U8hksn8dnddKB9IRxO
 vpixQ4taSsAQYkHFMt52OAAZ/oZtL/bHW35On/0h9CpVuOUMt8AjrZahefzKsFEkvnNNgt2eW
 qVlFehMWqEnt3M9/Li0CDxHEr08/DKco5KUxUAxKGUozndrB+/EAuRJhVOczqtq36J12oou51
 tgguxfKf3JOWFTxZb01t+pEQ2x/9uBVTzDmMkte+mQVRkRY/2O1zxZLAaXGv56zBGbEv/+QqX
 CMLIBqhIJ8bdETL4As9rg1dm8JVIClU4t+sDPrhm/uoHzbkAQGnF7jjfVyFihx8W0d0GIu6sB
 kz6O5vTorD8KJUWJUxSNEfIezCTdJ0cghDJlipJzk5lCnh4YfRmNwKkS/6bTiGNLQ2rEx07zQ
 EZg5YkGjigSwdGGiEEn2kUzblG+t5HosKxRLFy3wiB+xvZPr6rz8sdybEJmKVOgfHtkcn/x4B
 UgvuDhlRsFyKtqLyRv0rmnOezMAqHWTaFBWwGrq+Bc7MSPDKEqVJyzCSJD76Z2R2rvTxctZNw
 5DsdiF5zMP5BvMp/zULpC2VfOvShG0/DEjtL+FZStQuOo=

> The struct cpuset is kzalloc'd, all the members are zeroed already,
> so don't need nodes_clear() here.

* How do you think about to convert a part of this change description
  to an imperative wording?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.9#n94

* Please avoid a typo in the domain of an email address.

* Can the proposed source code cleanup be relevant for the addition
  of the tag =E2=80=9CFixes=E2=80=9D?


Regards,
Markus

