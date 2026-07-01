Return-Path: <cgroups+bounces-17416-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I7ilE4/KRGr20woAu9opvQ
	(envelope-from <cgroups+bounces-17416-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 10:06:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEC56EAF0F
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 10:06:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17416-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17416-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8776B3023A72
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 08:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEA53C553A;
	Wed,  1 Jul 2026 08:06:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C823CAE76;
	Wed,  1 Jul 2026 08:06:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893168; cv=none; b=h6GUTaUjb/qY5Knbe8ZWdfI3+xGHEh6MIR8ntjy0YfIqRlo6uqrKAKmVReRJpRl2PgszeK4i6ryoZVwTUBWk3t4FtqwO89qU2kHZIH86ePiXtQReJ+zc/1Ua5LssYQTkARtIp5G1co8hANEneOAPwcpy1uoMvtsQ+ZHh+Ynsaw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893168; c=relaxed/simple;
	bh=vHVjUrsJFkugfvScX3CHmnwPsWHMu9yN4TkDEQ5YQa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKq26pNzjoqxH0ZzJiBa61rf6WFqtdkP71eFunFiQR22CptiDHyQQY8pNuQc/QLq/nAzQ66GNLu/ldlNCg3pqAZZ6fcsULfgZCGKVDCP3bJGKv3ytdxpgqslAyFooR5orS05Dzh8EctCStgi9O+Ydz7hJxLD8yVBrhcjooWeo/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: b15d4340752311f1aa26b74ffac11d73-20260701
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9c10d8d2-2dd5-4dfc-8998-558e32c145ef,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:9c10d8d2-2dd5-4dfc-8998-558e32c145ef,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:1b6a4bfce7ffa0962576b94cc7550798,BulkI
	D:260624112706YSGBNPCQ,BulkQuantity:11,Recheck:0,SF:10|64|66|78|80|81|82|8
	3|102|127|841|850|865|898,TC:nil,Content:-10|0|15|50,EDM:-3,IP:-2,URL:0,Fi
	le:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,D
	KR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_OBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b15d4340752311f1aa26b74ffac11d73-20260701
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 940195476; Wed, 01 Jul 2026 16:05:58 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: dev@lankhorst.se
Cc: cgroups@vger.kernel.org,
	corbet@lwn.net,
	dri-devel@lists.freedesktop.org,
	hannes@cmpxchg.org,
	hongfu.li@linux.dev,
	lihongfu@kylinos.cn,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mkoutny@suse.com,
	mripard@kernel.org,
	natalie.vock@gmx.de,
	skhan@linuxfoundation.org,
	tj@kernel.org
Subject: Re: [PATCH 1/2] cgroup/dmem: add per-region event counters
Date: Wed,  1 Jul 2026 16:05:11 +0800
Message-Id: <20260701080511.277167-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2021ac83-3f17-4a77-94ec-5156618c00fe@lankhorst.se>
References: <2021ac83-3f17-4a77-94ec-5156618c00fe@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17416-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FREEMAIL_CC(0.00)[vger.kernel.org,lwn.net,lists.freedesktop.org,cmpxchg.org,linux.dev,kylinos.cn,suse.com,kernel.org,gmx.de,linuxfoundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lihongfu@kylinos.cn,cgroups@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:dev@lankhorst.se,m:cgroups@vger.kernel.org,m:corbet@lwn.net,m:dri-devel@lists.freedesktop.org,m:hannes@cmpxchg.org,m:hongfu.li@linux.dev,m:lihongfu@kylinos.cn,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mkoutny@suse.com,m:mripard@kernel.org,m:natalie.vock@gmx.de,m:skhan@linuxfoundation.org,m:tj@kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongfu@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:from_mime,dmem.events:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBEC56EAF0F

Hi,

> > >
> > > Shouldn't you be able to deduce this rather trivially from just looking at the current usage together with the low/max limits you already set? I'm not sure I really see anything this events file provides that analysis of current usage and set limits doesn't? If your usage is highly variable, the separately-developed dmem.peak file might also suit your needs, but still, not sure what you can do with dmem.events that you can't already do with these tools. 
> > Thanks for the question.
> > 
> > Besides exposing counters, dmem.events notifies userspace on changes via
> > cgroup_file_notify(). This allows tools to monitor limit-related events
> > (for example, allocation failures or low-protection fallbacks) asynchronously,
> > without the need to periodically poll dmem.current against the limits. While
> > you could infer some conditions from current usage and limits, polling is
> > inefficient and cannot capture transient events in real time. dmem.peak only
> > records the highest usage, not these specific events.
> > 
> > So dmem.events provides both lower overhead and richer, actionable information.
> 
> Agreed, they're separate but both useful.
> 
> The peak tells you what the maximum memory consumption is.
> The events are sent when a limit is reached, but more will also count how often limit is reached and reclaim needs to happen.
> 
> So if you have 4 cgroups, and 1 of them sends a lot of events, that tells you that you may want
> to increase that cgroup's limits dynamically to have a more performant system.

Thanks for the reply. That clarifies the distinction between peak and
events nicely.

While implementing the low event counter, I hit a design mismatch with
how TTM eviction works. TTM keeps BO LRUs per ttm_resource_manager (per
memory type), not per cgroup. During eviction,
dmem_cgroup_state_evict_valuable() is called for each BO on that global
LRU. If we increment the low counter inside this per-BO check for pools
protected by dmem.low, we count once per rejected BO during the scan, not
once per low-protection fallback.

Memory cgroup avoids this: reclaim is per memory cgroup, and MEMCG_LOW is
incremented once per memcg when reclaim enters the low-protection
fallback, before page scanning, not once per page examined.

For dmem, the low counter should be bumped when eviction decides to fall
back, when hit_low triggers a retry with try_low = true, not inside the
per-BO iteration. I'll revise the series accordingly for v2.

Thanks again for your feedback.

Best regards,
Hongfu

