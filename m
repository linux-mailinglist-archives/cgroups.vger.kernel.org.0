Return-Path: <cgroups+bounces-15997-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIgoI/v/B2qXUQMAu9opvQ
	(envelope-from <cgroups+bounces-15997-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 07:26:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E77F055A475
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 07:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F6F13014C13
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 05:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564172D3A69;
	Sat, 16 May 2026 05:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ssRnF9MI"
X-Original-To: cgroups@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8AB28686;
	Sat, 16 May 2026 05:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778909168; cv=none; b=NRSxVcUrruQYowc5Gi+dVnhFg4QhSwKY+HoarFqYodRNKxz5+hCtiqki6c7NW9jdcHcMEn7y+pwCkpII1SBnD94bh5z2wwcnhQmBItNSPJ2q5xgVxvWkKOFUgNDvBE+H5MVbW0uAxR+T4pXbDuwQMJEFVhMNPt/F3Os/L9LH/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778909168; c=relaxed/simple;
	bh=iwUYzr2lrolxIDfAr6znil4ophVl9S+LKNuwid7LDJQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gdaEn3wgYax53OJnxwVeFV0OFZ63lsWHJQIRacWKCMaY6Vt6jaCmHV6JCi59YBqmUV9fYs3/hTVoAmkTi1KN9UdrtzyGBsHNukaTnGHRjbgBPoaZb9VGl/ZAROsKbSAQEcwmcUP5zkFSiKCFm9rA+IM5zslJSk9wo6E99Bh1IQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ssRnF9MI; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4gHXbb0c6qz9ysd;
	Sat, 16 May 2026 07:26:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778909163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4GZ6MzR9uTlRIX3lPL2dZhubaWDGRqsi2Ca8/5K4dQ=;
	b=ssRnF9MIscuQ4wWXAQ1oXk1ERW6mlP6fIr4vbxt0jJnVyhoCiJzoUWKBQlz8sGhweNOweK
	NkzwlpgBm0PGuUpDnr0vCiX4qEbNAtNT3UZc2mcJwU9EN5dk47rfbIn5gisCtbNzss3tBH
	Mt7IkXazqZzLk21svQ6bp8xrBAZDJJE+nYHN7GBkZgg8kB+N4Cz6ACQd8tZ5/B7eDNi17m
	YHMe02CNtyAV/EYr+c0/G7yuT87mbvWqUJXfEDfwjc+ujJUwWkthdtHAoaPcc+844pHIPd
	NpSy39H0whduKzQM+tBqz5XIy50et7jdJViTZEFnKssAyVpNUVFAVtFpX+NyEQ==
Date: Sat, 16 May 2026 13:25:58 +0800 (CST)
From: Ming Qing <a0yami@mailbox.org>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <86414803.635817.1778909158261@app.mailbox.org>
In-Reply-To: <agdJWXRZF_pRgggt@slm.duckdns.org>
References: <20260515122952.59209-1-a0yami@mailbox.org>
 <agdJWXRZF_pRgggt@slm.duckdns.org>
Subject: Re: [PATCH] cgroup/rstat: validate cpu before css_rstat_cpu()
 access
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-META: ciwhgpiigxy7udfhb38dkrp8dmbq1xen
X-MBO-RS-ID: c702c497082c168aea0
X-Rspamd-Queue-Id: E77F055A475
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15997-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0yami@mailbox.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:dkim]
X-Rspamd-Action: no action

On Sat, May 16, 2026 at 12:27 AM +0800, Tejun Heo wrote:
> Can you please add this validation to the BPF kfunc that's exposing it?

Sure, will do. I'll split out an internal __css_rstat_updated() helper 
and keep the cpu validation in the css_rstat_updated() kfunc wrapper.
Internal callers will be converted to the helper in v2.

