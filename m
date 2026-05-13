Return-Path: <cgroups+bounces-15914-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMOIM8/iBGrPQAIAu9opvQ
	(envelope-from <cgroups+bounces-15914-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 22:45:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E22853AA2C
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 22:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07E05301C975
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 20:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB7E3955FF;
	Wed, 13 May 2026 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwsS+Xa0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE037F8D9;
	Wed, 13 May 2026 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778705098; cv=none; b=mtMQVEwj6N5Mr6Vr2e9t9Z7OvqqpkIJFJYjHHmw/+dMTHg+IenXFlA1feSESizVPg+NfrS5cSyvWT0ACO3NVv50ekYbNqk648PIdKbjfm+hWtt0+mLtEEgD3QRk1YNaBH/tRRcGvb/kPphYjayLXfR5wJSNusD9E2lw5TXv/OXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778705098; c=relaxed/simple;
	bh=hK59TklJ3r7JacXrdSpS9889H0qpgYzPE9M9TYuJ0n4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=IGpn/KBAMFr/f1N9Iw3dR6Xfc6oQqG2uZcwPBkGHD7OVZ3JcbHinyKBApGmMiBSZaADY8FDJoiMiKLLuPaipsN+NvG7ZvTLnWWj7KTGP+2Z7LOKjpcs5JxSPP5BlB5lkd1qDa/73btxM/kuS9X23H+CZWT7b987VeWzsMaXF7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwsS+Xa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C499C19425;
	Wed, 13 May 2026 20:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778705098;
	bh=hK59TklJ3r7JacXrdSpS9889H0qpgYzPE9M9TYuJ0n4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MwsS+Xa0ve7JCeRzGoYjxyFKLIECSSEzJfYMPQBm5oVeYiLGSXLTpVQnMIEhTfA7+
	 1QS5UVfvr88oG9z8SeUtfZjA5O8CsyJIj8vK01ihh3oNcl0T1XZJDMCkIdtf9eqOIo
	 4Oh4ftvn7W66wA2AEqIEZ2yP+oCcJuc/4gsSX64Js6zdr6JFdFIzWJi0iaK5dfALv5
	 K2WV48WoE1xfrfv5BXkHgiqdFosoNQ51EtyRmDPfVNm3XSszy58YA4UYC2fH1cNZaC
	 L3r7aAuRNntBvwJwjG4h2xgxaVJBL/IC6s2/mmRkSI0+Zs+cuJMu274jB1ZTsccuQ9
	 3pJXIVyzoQXSg==
Date: Wed, 13 May 2026 10:44:57 -1000
Message-ID: <a4f68c0ea0accdcacc6cafe444ee786f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Maarten Lankhorst <dev@lankhorst.se>,
 Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2] cgroup/dmem: introduce a peak file
In-Reply-To: <20260513-dmem_peak-v2-1-dac06999db9e@igalia.com>
References: <20260513-dmem_peak-v2-1-dac06999db9e@igalia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 5E22853AA2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15914-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[cmpxchg.org,suse.com,kernel.org,linux.dev,linux-foundation.org,lwn.net,linuxfoundation.org,lankhorst.se,gmx.de,igalia.com,vger.kernel.org,kvack.org,lists.freedesktop.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

The patch looks fine to me, but please flesh out the motivation in the
commit description - what's the use case, why do we want this?

Thanks.

--
tejun

