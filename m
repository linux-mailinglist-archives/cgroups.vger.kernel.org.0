Return-Path: <cgroups+bounces-17561-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bc0XNIHuTGrvsAEAu9opvQ
	(envelope-from <cgroups+bounces-17561-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 14:18:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1218571B47F
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 14:18:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=dnZX8NVS;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17561-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17561-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A55A300D69B
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 12:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135073FA5F1;
	Tue,  7 Jul 2026 12:14:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B556F3F7A8C
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 12:14:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426493; cv=none; b=ONsGhxgFCehsPAemTIcoJtB2CL/3mSR/+XijNTxoDmjWTl7J2c93wTDJgG7OOcVng7J8GZpp8PvMwFa5QN+5RJFJpiwGXPmW6i6c5cp+YLZCjagyP3L5xRAmhlc6+gLoQXJpEU/wsaklOR0XWYuBj+YPwZK4npJ4g22Lo/F1cSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426493; c=relaxed/simple;
	bh=3cjWbNIgBqzzm+7BOCwVMDV607Ssj02e8SUOegbBowI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGyQ9h2eyOJ9yvUd1QUPfg2MjUxdoKuPId5xKaKE6azF0y4orxl7R1AVeIugsIF0nCIHvOoC6QtkGI9oBpGFB7AiQGrO4A0IHWxumg+W7JaGhpVRCK5Ooc7zNpHWKqyUloeTC/CE1C5PQzSF/h6fxlMyjZQW/Y5O42GoHAU/IcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dnZX8NVS; arc=none smtp.client-ip=95.215.58.179
Message-ID: <7d955bb1-9abd-4ba7-b1a6-a19f999cfa27@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783426489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAAXy536t9SekqRYGrtDkUhq1/DKNIxZvKhhwo2mLyw=;
	b=dnZX8NVSJ1gWNjwt2iG1RLuceDp2+oztQwYUY4lB/jOrhLw3Yjhyh2vVwsGgLT3sFTLOhY
	z1RAbF46D9HGS9l4eayKo4Gzp9PWmOkCYppkyvGH3Wbbp2oJ0LpI4m90A1osALOFeDV2w+
	SPZJl0PCl0Udo5g3ebVcfieXSV560vM=
Date: Tue, 7 Jul 2026 20:14:30 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: cgroup/test_zswap failed with "zswpout does not increase after
 test program"
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 hannes@cmpxchg.org, yosry@kernel.org, nphamcs@gmail.com,
 chengming.zhou@linux.dev, tj@kernel.org, Shuah Khan <shuah@kernel.org>,
 mhocko@kernel.org, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Li Wang <li.wang@linux.dev>
References: <c0970cee-42c2-4844-b88e-229853f08e90@linux.dev>
 <akzpi93tZry0cCCe@localhost.localdomain>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <akzpi93tZry0cCCe@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17561-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkoutny@suse.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hannes@cmpxchg.org,m:yosry@kernel.org,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:tj@kernel.org,m:shuah@kernel.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:li.wang@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zenghui.yu@linux.dev,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,cmpxchg.org,kernel.org,gmail.com,linux.dev,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghui.yu@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1218571B47F

Hi Michal,

On 7/7/26 8:01 PM, Michal Koutný wrote:
> Hello Zenghui.
> 
> On Tue, Jul 07, 2026 at 05:38:13PM +0800, Zenghui Yu <zenghui.yu@linux.dev> wrote:
> > Hi,
> >
> > Running cgroup/test_zswap on my arm64 box failed immediately with:
> >
> >   [root@localhost cgroup]# ./test_zswap 
> >   TAP version 13
> >   1..8
> >   # zswpout does not increase after test program
> >   not ok 1 test_zswap_usage
> >   [...]
> 
> What version of the tests do you run?
> Namely, does it have the recent patches from Li [1]?

I use today's mm-new [*]

> 
> [1] 83476cc97bc63 ("Merge tag 'cgroup-for-7.2' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup") v7.2-rc1~136

... so it should already be included.

[*] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-new

Thanks,
Zenghui

