Return-Path: <cgroups+bounces-16656-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x9fOLhqyImoOcQEAu9opvQ
	(envelope-from <cgroups+bounces-16656-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 13:25:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFA5647B1E
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 13:25:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lankhorst.se header.s=default header.b=CEexm4Sd;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16656-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16656-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lankhorst.se;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2156D3060CA7
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 11:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBA140242E;
	Fri,  5 Jun 2026 11:14:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B49260566;
	Fri,  5 Jun 2026 11:13:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658041; cv=none; b=mMdsEv4vp1WSNv30gAPLbQ38USA/bea8/ree7BCluEMQRkO+oHbS1f59RgW2R8e/iN1hx+5ppj9x4tLYBNzveT9b2teHTHa2amER1YOhPKeuAWbyPr5P+QXd8W5uQ3MgQ1mhPNbyVCx3UdnjQ09x/Jm0bPnGJCTd2zQ2uPMXhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658041; c=relaxed/simple;
	bh=ZMIjWts6XvJ/jhRFZHvdvlkNH+2yiGMbLQW8gHV1kwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPr6euiewYACmKFFSontGWl4+gpvzW8F79Ku2QarxmsAkdNFnu6b0H/0c8ahFcSwRZsBzE1L8kAH3sx+MZ/VmQY2PYIIH5Ko46Z1wai/vZe2Gmx1B+6fCzYM2n2Iixcvlj9WBNEjzkXBEskBlZAcRrC6mR//VI0i+6ICP4mFyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=CEexm4Sd; arc=none smtp.client-ip=141.105.120.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1780658031;
	bh=ZMIjWts6XvJ/jhRFZHvdvlkNH+2yiGMbLQW8gHV1kwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CEexm4Sd9mFFbUW90LsMcO3+Mj3TbO0dZyBWnLyaExoVg9Nx4w1NiQFwerSK7AEVa
	 pUXW/dRqapt1pg4raMvsX2k9eCYQSgtFEOKWEb9pGTWBgSM5Hs/yVt30aCOCUE8Icq
	 0kC64phG1c1l0dR5LD9hwJlb8JB/eo4Cg0MqJoG8CowI7XJO5RoJWSJ3BuFmgnN4ty
	 CM5A9c8bml2t/C9wrJ40Ovyp6RZjK/KLrbv58d/4Gk9eVJdthXa/losttEAXScNfCt
	 i2W5MmIQCrs9H5ctSLwh3MsX4BwuSISL2e96oeF0Jr8qxvZ0bVq4sAzbtpCPeTxOdJ
	 BK59XHVm4B/vA==
Message-ID: <fdce637f-703f-46d9-91ab-05fe3728393e@lankhorst.se>
Date: Fri, 5 Jun 2026 13:13:52 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cgroup/dmem: introduce a peak file
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260514-dmem_peak-v3-1-b64ce5d3ac38@igalia.com>
 <ahCISfTlN10gD8e6@localhost.localdomain>
 <89901220-0a43-4668-9d20-aaecc72c58dd@lankhorst.se>
 <ahmOBo02TA8u8RW2@localhost.localdomain>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <ahmOBo02TA8u8RW2@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lankhorst.se,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lankhorst.se:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16656-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkoutny@suse.com,m:cascardo@igalia.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:mripard@kernel.org,m:natalie.vock@gmx.de,m:tvrtko.ursulin@igalia.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kernel-dev@igalia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dev@lankhorst.se,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[igalia.com,kernel.org,cmpxchg.org,linux.dev,linux-foundation.org,lwn.net,linuxfoundation.org,gmx.de,vger.kernel.org,kvack.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@lankhorst.se,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[lankhorst.se:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lankhorst.se:mid,lankhorst.se:dkim,lankhorst.se:from_mime,lankhorst.se:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BFA5647B1E

Hey,

On 5/29/26 15:01, Michal Koutný wrote:
> On Fri, May 29, 2026 at 09:34:28AM +0200, Maarten Lankhorst <dev@lankhorst.se> wrote:
>>> Reviewed-by: Michal Koutný <mkoutny@suse.com>
>> Reviewed-by: Maarten Lankhorst <dev@lankhorst.se>
>>
>> With your r-b it's ok to push it to the dmemcg tree?
> 
> Please go for it.
> 
> Michal

Thanks, pushed and queued for v7.3!


