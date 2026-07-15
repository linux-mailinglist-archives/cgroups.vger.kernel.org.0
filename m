Return-Path: <cgroups+bounces-17831-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NyPZJ4BOV2rqIwEAu9opvQ
	(envelope-from <cgroups+bounces-17831-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 11:10:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 589CA75C438
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 11:10:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="Q/XfsBTU";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17831-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17831-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3649232C6058
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 09:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C319A3E4513;
	Wed, 15 Jul 2026 09:02:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14F3E1CEF
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 09:01:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106120; cv=none; b=fiR8TuEKGCVgGN2s5efVFhHTx4a6dhGq9fBRw+ZC2i5vAYZBUb6PDwAzrqLspb+YTbLkstZ5l0+U/B6uW9ZE6mSSM+63Rz44Bipo2IoCvKIT1CE6UYTdRS2UXVpHDblno2uYEu+YNyD6ozwBLk12bbMQmpe3lZo65BZ2EtOtC/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106120; c=relaxed/simple;
	bh=Sjv5VCwSEt6zqYACQUTN7C7iuSdYRzhtwTyhw33MvX4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=O9dpUvwkE89Oh+FrqviLfnN/+0RGW83cnWUgUEIf64NYL0NJmED6IC4r3/7NhdzZ0nzjLvOe1XeCAlfvw/vD8KQhlQ87Xw5APDF5DZHP6aPesl/yeguPUyKEqUQ/Z5adwZ2GJULQQTFau9Dcbcc05h+Ayyq+ChkVAMxq73sJZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q/XfsBTU; arc=none smtp.client-ip=95.215.58.182
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784106102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sjv5VCwSEt6zqYACQUTN7C7iuSdYRzhtwTyhw33MvX4=;
	b=Q/XfsBTUW7yoyG8P4VPqcKjBeYHCAjtmZ9ZOEvrYT/irTKB3NczjFc6IiAeDLmOyz/XYqi
	mnBjj4y1E6JtsAlkE+oNxbAQlvlyFmDNTcqp9R814r7Y7hVmkuqaQP+nF1khmXf6exTov/
	Lq42jc6yvm29mpqcLnS+s7kjrC6fLv4=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 09:01:31 +0000
Message-Id: <DJZ0TRQNDNHG.3CD9OFRR949TK@linux.dev>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <cgroups@vger.kernel.org>, <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 3/4] mm/page_alloc: fixup alloc_pages_nolock_noprof()
 comment
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Zi Yan" <ziy@nvidia.com>, "Brendan Jackman" <jackmanb@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Waiman
 Long" <longman@redhat.com>, "Ridong Chen" <ridong.chen@linux.dev>, "Tejun
 Heo" <tj@kernel.org>, =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20260714-spin-trylock-followup-v2-0-3c20ed032b14@google.com>
 <20260714-spin-trylock-followup-v2-3-3c20ed032b14@google.com>
 <DJYR00V65DBO.EAAIW26NL9ID@nvidia.com>
In-Reply-To: <DJYR00V65DBO.EAAIW26NL9ID@nvidia.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:sashiko-bot@kernel.org,m:ziy@nvidia.com,m:jackmanb@google.com,m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hannes@cmpxchg.org,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brendan.jackman@linux.dev,cgroups@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-17831-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brendan.jackman@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 589CA75C438

On Wed Jul 15, 2026 at 1:19 AM UTC, Zi Yan wrote:
> On Tue Jul 14, 2026 at 5:32 AM EDT, Brendan Jackman wrote:
>> Update the comment to reflect the recent change to allow flags in
>> gfp_nolock.
>>
>> Reported-by: sashiko-bot@kernel.org
>> Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714=
e19d3@google.com
>
> The link below points to Sashiko's comment directly. You can find the
> link at the end of the title "Patch 6: ...".
>
> Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e=
19d3%40google.com?part=3D6

Nice, thanks for the pointer.

