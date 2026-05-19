Return-Path: <cgroups+bounces-16099-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KcSC93MDGrAlwUAu9opvQ
	(envelope-from <cgroups+bounces-16099-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 22:49:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE18B584D97
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 22:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C19F7302810A
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 20:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65E12DB780;
	Tue, 19 May 2026 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="n6IZ0yBD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202A366DA3;
	Tue, 19 May 2026 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223769; cv=none; b=hMVOyzDNr28GB5GjKC//4heR1kEB/Mmjp8aVJ3j0+H4kuaTas9+/fEplXgwn3j1XqeFe4VhVXjRiMnTGqOM2BsbzMqWheNr3IG4egxq+jn+0xLcwyiufYzo8Dg49USTB13+rY/eNBr1MBHxZ52t9hi41i4NQDojgqoqJ+utcVTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223769; c=relaxed/simple;
	bh=7A9MniegkQbxqmlA+0leczj1ZhP9CB3CjDe62JAKy/A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G8qQHw2BVgUfl9LzQCRLWTWeVtt3RCvuVKsM3YCUR4NfmFAF3tywaGTZex+EeGVrXm9yQ7Jm0Apsn4sSXTglMNAMPEC7ti8zWfAC2oPCeg7NjP3Val4HbgkKIS4NUonoihWajQPPgQou9T1ZNVR+vWaQ4+ZTwf9MHEmA3twOJM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=n6IZ0yBD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93311F00893;
	Tue, 19 May 2026 20:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779223768;
	bh=7A9MniegkQbxqmlA+0leczj1ZhP9CB3CjDe62JAKy/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n6IZ0yBDF2P1AATvTvw0B5+2TpR4sLiQVxkGZgKoCJAnGnokB2z4kxyLEjb4fQ0Jz
	 2IrjZ1hzzGX3N2W9RomnUnrMPlYVTs4Vax/Cy2Vf8xZPpdKsxZDCC+bRn8dh/wvMOE
	 qtBq+yvSnr+eC4zWfcIqPYXlbBThb9B2AGZmxq3s=
Date: Tue, 19 May 2026 13:49:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Harry Yoo <harry@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, Qi Zheng
 <qi.zheng@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, Joshua Hahn
 <joshua.hahnjy@gmail.com>, Meta kernel team <kernel-team@meta.com>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3] memcg: cache obj_stock by memcg, not by objcg
 pointer
Message-Id: <20260519134927.ee04379d07b0674872422c06@linux-foundation.org>
In-Reply-To: <agynzVVBb4CYJTYG@linux.dev>
References: <20260518222827.110696-1-shakeel.butt@linux.dev>
	<aguiSnY3ie1y4nEl@linux.dev>
	<4e296262-fbbf-4ac7-aecc-3ef831583704@kernel.org>
	<agxszIIN6FtK0fEb@linux.dev>
	<ca8e655d-5fe7-4957-8a36-6667616be8b6@kernel.org>
	<agynzVVBb4CYJTYG@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16099-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: AE18B584D97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 13:11:13 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> Andrew, please don't send this patch to Linus until we decide on the option.

No probs, I added a note-to-self.

