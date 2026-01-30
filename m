Return-Path: <cgroups+bounces-13533-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJRkEJcIfGnqKAIAu9opvQ
	(envelope-from <cgroups+bounces-13533-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 02:25:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 962C9B6266
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 02:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD8B0300E71D
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 01:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB948330320;
	Fri, 30 Jan 2026 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE5sX8U9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5DC30F7E2
	for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 01:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769736302; cv=none; b=c/W55eLdO8ubj8vxKEpax5mJC/Q3duge/VcBcm7mAe5keAeS3TZssBjHYqc43Crl2FtGFzYn+uJ9BsRt5WVnMfc55Y4T/IhCM8sPUWUXipgc6ZeWW9agSFEEeuF+V/hfAPlx97LhT1QSJd+SyZSTOPWgpYo+5nhMoS5XWo2KjwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769736302; c=relaxed/simple;
	bh=QPCRSENA4SFJhAH+HmqmvpZoOVaVA5wKYXLmrxDmbR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YA82ursgEnkj6J1eA24XLpc1DQE3h7tGMcOHzNwBQKK/qmpPeXbi03dP7K15i8sw+EDvswufYO+FndCedBs6Y2Ly6dMBry1TMEVZfupDygt3otUvRfLHQRvtmwq+DtFaC+4wEbzOdcCVRSvo5C8X0o2Xmkd857jLCz/KgSPZEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE5sX8U9; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-124b117776fso1290286c88.0
        for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 17:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769736300; x=1770341100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryNCiIbjOxXcd/t0kCSD2wpxWRoodaQ92ia7l5T9br8=;
        b=UE5sX8U9LI3MzdfQoGoE4Pk7IEbEt5SrNS19zUhpKD6Br/xVh9BpD/tD0vdu3fW/Ht
         t9yxpqUHJcJ1VlTleZ4IH2vH+wYLXjCHR/o84++C70wch8mkRoPlzBEezJKC+78gTV2N
         NCKCRCUaeX8JrYhH3LpBMq7agdjo9FK5MLJzY+ghSLkclQSgvXzyTwSHK4x3zZwPraOw
         g/74oCTY1xd+JDrRA9duVM3+jYF58IjmJHm/R2r8Ao2aom2tO6XQhUckVwzZ0CaFgVIn
         +djCRYGViVEcXi8Ryp0KrGbXqj8llvr1VbvEP9WsGX7p5dzNeFVYuBP55CGi3Pxs3YDa
         kn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769736300; x=1770341100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryNCiIbjOxXcd/t0kCSD2wpxWRoodaQ92ia7l5T9br8=;
        b=tPvEAu5TZyoOAk5td+PZHxY7LJplPRf1NSlCuyo6SwL3hF8lAS4zaBGHbAK5efRj0n
         KXzESHK3gQMcrItgA9+NNmkoHBKb/wg63JRVw0+Cum5zKNhdJmVK7FlxdYfNi6HLYKmd
         Lx5AMGFnrJjcfLYJSHLPRkjKrpl+7VFckSNRVR+WWPefzT+D7uHgpqim5SXur7TD57Ra
         ILxBglQoiS2zrh/tdMPv2TxvNEJ3AJgMv78QtLzIt8j846LOs9CcjtRXtkabAqvvL9YY
         hkdW1RB+/Pw6RS2plclro5m1SVNQP65Ml8YacrTC3ErJF8cg0d0DfpvI/3Oz/FpJn6Zf
         hepA==
X-Gm-Message-State: AOJu0YwriVjCwMFN1KPuOpCAIVCLaee/v0ICnf5R/1/kbg+CGJ9R6aku
	29HgF+8kM+SfeY/PBHSpxGpmQWXATV7vw13EcOqAk0z92tdQ9d+T3KyF
X-Gm-Gg: AZuq6aJm+5l5F4AaBBsghfzpvLPg2Q8VUJwh45fODGOkqhxUclV6V6y0U8OzJAjc7wV
	CriylqEaRlXDnxlyIDky9ZoEoZecLEdJjXfBoTfRe9Dlv3WCgnmEnluuooq581njD3WDuojf5Wy
	049vJ7nMKdU16Mwmn7/It+Y/0bfvamMi8THwJAgi9LEbvpRVNz9dkAkDSgWd2Ew0dZcFQnBapME
	t9cmXncyi62T2cvuhn3ImRL8L53TuXFEqthhE280mzOqDx4rbjKM/3G/w8UbCVz5kwcotNP7+9x
	uc8SLmhMu/WWaonHtiGEwMrmieE7wDQxIBFmSgTHFz4hdDluVI+XrLlJLboCqXMHn0F03ga87xA
	bFHDsAuqMPrKF81gR88ltC2ah/5OHMLYUknLoXKllWmKlurKeBCQ1zSis3a+VVVCPi4L8sWgmuw
	QnUdW+ElTtk9IqcMN89X5Z1DANmMR8WE088c6vjnBKdMHs
X-Received: by 2002:a05:7022:b91:b0:11f:3483:bbaa with SMTP id a92af1059eb24-125c0fa0ed6mr768887c88.19.1769736300463;
        Thu, 29 Jan 2026 17:25:00 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:416e:86d1:92cd:3741? ([2620:10d:c090:500::2:15ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d7f789sm8300091c88.6.2026.01.29.17.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 17:25:00 -0800 (PST)
Message-ID: <d1a0f008-1834-4e9d-8c6e-6ae7cffa4c08@gmail.com>
Date: Thu, 29 Jan 2026 17:24:58 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: increase maximum subsystem count from 16 to
 32
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shakeel.butt@linux.dev
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, lujialin4@huawei.com
References: <20260129063133.209874-1-chenridong@huaweicloud.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <20260129063133.209874-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13533-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 962C9B6266
X-Rspamd-Action: no action

Hi Chen,

On 1/28/26 10:31 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The current cgroup subsystem limit of 16 is insufficient, as the number of
> subsystems has already reached this maximum. Attempting to add new
> subsystems beyond this limit results in boot failures.
> 
> This patch increases the maximum number of supported cgroup subsystems from
> 16 to 32, providing adequate headroom for future subsystem additions.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
[...]

I gave this a run with with 32 controllers enabled (16 pre-existing, 16
custom) and can confirm it works as expected.

Tested-by: JP Kobryn <inwardvessel@gmail.com>
Acked-by: JP Kobryn <inwardvessel@gmail.com>

