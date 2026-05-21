Return-Path: <cgroups+bounces-16153-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L59L0HkDmrACwYAu9opvQ
	(envelope-from <cgroups+bounces-16153-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 12:53:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A505A3A26
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 12:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DBAD3035A98
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 10:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654C43AD509;
	Thu, 21 May 2026 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="YPtVUkqr"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3362B37F8DB;
	Thu, 21 May 2026 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360786; cv=none; b=nkGHArW3731e3x6SFrsoLTqwEjdkAT04gfw690V3ZUciYTVOsNANcjAT45rOp3oz9hOT+vq9i1C6RzCKKsv4oIi2xk5gC5sCGChCov2yLn5TSoP0IBlhby5DF9N89MROTRX26KuI8AfRGfjcVxVMm8mtZIoONB3YCcvJYacqjsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360786; c=relaxed/simple;
	bh=J0PCE3h15coQO1iEBxAQSl9gLFubhk7J/mgFRDgQMgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKN1K4QCt7YOKGnrNSYn6hLx3QxSfSSnhoOJ0iRZKgWdbZM/wlP9xybA+VD5bQxMhBY9wM/GF8b2Tt7Mq7SFBqe3a3mRh6i2VvWAySDuaB2uF32yuumEf4hMdY6v2Oqwpy4Ds+mv0NIauQNyPGl58pD1ej+70KkBTmGNFpOiQrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=YPtVUkqr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779360774; x=1779965574; i=natalie.vock@gmx.de;
	bh=BQVZdyNsRLh1UO3hzgkf7rJ2bJDZ9CoCemZi279WiTA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YPtVUkqrFPa778V+Oo7c9OOstVS3tJ9m2W3qRa1hoUrbzWedlKi95PFEyeyR5vcB
	 OT3ebQqx3BP88yKiYms2j3KAl7+4XKQUgSQxp+tFD2K/2c3ipJYEm/KmkBTmEnT4a
	 AFulsyyzTWAbxxp4Fv2K87mQ8ZGw96f64naNX9N2gAX+afXG3GjWpGEk5bAuP9mEr
	 KaCDzzKVNZoSqkuNQphW8Up4EBVSXXHlwE/xQotZIZjqInMqGbMFrBjiwIbokGNjQ
	 okDTDH/TpeG7y1YJtxHK2dyPuyWnC72UbNb+YiJrTZ2NtMWRcNWuCmqfeSZDXVQcY
	 J7p3quna228wVdNW0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYLQ-1x1Imk0Lsm-00qmYS; Thu, 21
 May 2026 12:52:54 +0200
Message-ID: <c9eeee76-25a8-482e-9ef4-74971537457f@gmx.de>
Date: Thu, 21 May 2026 12:52:53 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/dmem: implement dmem.high soft limit and
 throttling
To: Qiliang Yuan <realwujing@gmail.com>, Maarten Lankhorst
 <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com>
Content-Language: en-US
From: Natalie Vock <natalie.vock@gmx.de>
In-Reply-To: <20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PZ4dvDT0U+l0AsA9Ag5Bmm59ckZbPykegQPAfYv1gSKHuyR52iA
 tH9nQseiGplcz/+EOQ99iUwRkHaXu9pLTbcnk/yV9+eYHFJRwk1AJ0AVZm0NhLOwJgnbOQ/
 tQccazbMy2tQPsQSRupC/mFf6nllakv7odTZ1cErkg4lnCjrrsnp7kJZqlMUgW9ZxJgc9Od
 Q0pAdcmIgepFs9/XoZcPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5OGF0HZOaAc=;DIGb1CRXR6ZrF56WLnZMiK1d4L3
 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
 ptrhCA==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16153-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lankhorst.se,kernel.org,cmpxchg.org,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmx.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmx.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:mid,gmx.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 41A505A3A26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 08:07, Qiliang Yuan wrote:
> Introduce the "high" soft limit for the dmem cgroup v2 controller.
> When a cgroup's device memory usage exceeds its high limit, tasks
> belonging to that cgroup are throttled by being forced into a sleep
> before returning to user space, instead of being failed outright
> as with the "max" limit.
>=20
> Key changes:
> - Add high counter configuration to dmem_cgroup_pool.
> - Add over-high check in the try_charge path and set TIF_NOTIFY_RESUME.
> - Inject the dmem throttling handler into resume_user_mode_work.
> - Implement the handler to perform a 100ms interruptible sleep for
>    over-limit tasks.


Interesting proposal, but inserting sleeps on allocation is never a good=
=20
idea and doesn't work like you might think it does. In graphics driver=20
land, lots of random things may result in buffer allocation functions=20
being called. Whenever TTM determines some buffer needs to be physically=
=20
moved (most often during VRAM contention, but also as a result of=20
pinning buffers for scanout, etc etc), dmem cgroup pools are=20
charged/uncharged in accordance with the change in buffer residency.=20
Sleeping in a charge/uncharge path means that in the worst case, a task=20
will be put to sleep over and over again for exceeding its high limit=20
just once.

Most critically, submit ioctls typically go over the task's entire=20
working set and call ttm_bo_validate() to make sure the buffer is=20
accessible by the GPU, since paging things in on fault is not available=20
in many consumer GPUs. Your approach could lead to every single=20
submission sleeping for at least 100ms, thus permanently destroying=20
performance.

Maarten's suggestion of preferentially evicting memory that is over the=20
high limit sounds like a better approach.

(Also, did you use AI for this? Please disclose your AI usage as per=20
kernel guidelines if so.)

Best,
Natalie

