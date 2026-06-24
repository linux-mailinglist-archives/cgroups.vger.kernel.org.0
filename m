Return-Path: <cgroups+bounces-17226-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QsshIvuXO2qAaAgAu9opvQ
	(envelope-from <cgroups+bounces-17226-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 10:40:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8786BC9E1
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 10:40:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xmu7RoUE;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17226-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17226-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1792330258B9
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 08:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABD139769B;
	Wed, 24 Jun 2026 08:40:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C038C2A0;
	Wed, 24 Jun 2026 08:40:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290421; cv=none; b=LUjp2NbWbz+TP6QjXZCPKsAmk4YOc04wTCzpOUFWPyk0fnqoWs7nSHA4jsAeOgWocXessPGrV2qxGJBXwm066z3HmWbFa1Qr92IgFQTAHf+SrfaTx0m6Y0gqq2cEBd1S876r7+0Ki1CnwVWrDS0ywEZ4i/iWF1om4Xv1x7A22fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290421; c=relaxed/simple;
	bh=P39lXRa2jz3MWWU850wkJGkTqFPcGPr0sHxBte23N+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1HJjqcOuLeiULUO3Aio8mGAkzr8n7Da5vMdNOI1MocVZWXCWup1jO9zcvtKbdwsXXq0Yb/rqvrtdkEUWa3T2rxT6G7nelwXrAgieclAENvcOHIRK3WrRgLTEKY+fx0mWfK0HilNRvmcCSDvf3ZDTdSxA8ac9w6/1DbnoIsclq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xmu7RoUE; arc=none smtp.client-ip=80.241.56.152
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4glb3h3Qpyz9vHW;
	Wed, 24 Jun 2026 10:40:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782290416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P39lXRa2jz3MWWU850wkJGkTqFPcGPr0sHxBte23N+k=;
	b=xmu7RoUEfspa3pQuaYW/w4no6pnLUSB8p9wUfW4w0C1l0umHYgWWvmiQQu+yxXYo4u9sKo
	rtg8qjgD9eh5m757sWm0MLp4XavglYqGAoUVnL5cfCaPWpah3lms09u8q16oMxXeZg5fHb
	RP7QJO4NIlcw9Hz5+GkZwrhoS7ddk9QYOXe5AcLb2GamZhS8BcCcbHy0Dq92mo+D0zADib
	jb/552KEPSPlsql8Lcdc82JdAAcMqMEV009IiK+a6+8CELqc9nW4tfoKEc5ihq/0x3XLDU
	CsXn0KyWZgwOx07MlKiMt6Cm5+zUx7FTYySzERFaRW7B9VpCn7H2EgjJg5DakA==
Message-ID: <6fff0fe73bd8a3e45a96034a2251c7e0ca7de5c4.camel@mailbox.org>
Subject: Re: [PATCH v2 1/2] cgroup/cpuset: Avoid unnecessary cpus & mems
 update in cpuset_hotplug_update_tasks()
From: Manuel Ebner <manuelebner@mailbox.org>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes
 Weiner <hannes@cmpxchg.org>, Michal =?ISO-8859-1?Q?Koutn=FD?=
 <mkoutny@suse.com>, Ridong Chen	 <ridong.chen@linux.dev>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan	 <skhan@linuxfoundation.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Wed, 24 Jun 2026 10:40:04 +0200
In-Reply-To: <20260623230413.1984188-2-longman@redhat.com>
References: <20260623230413.1984188-1-longman@redhat.com>
	 <20260623230413.1984188-2-longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: b6772ffac49364ddedf
X-MBO-RS-META: zpbdbadoti536qbhst7wsuo7h1on8h5b
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17226-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:ridong.chen@linux.dev,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:mid,mailbox.org:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA8786BC9E1

On Tue, 2026-06-23 at 19:04 -0400, Waiman Long wrote:
> As reported by sashiko [1], cpuset_hotplug_update_tasks() may perform
> unnecessary task iteration and updating of tasks' CPU and node masks
> when mems_allowed and/or cpus_allowed are not set in cpuset v2. It is
> due to the fact that the temporary new_cpus and new_mems masks do not
> inherit parent's effective_cpus/mems when they are empty which is the
> expected behavior for cpuset v2 since commit 4ec22e9c5a90 ("cpuset:
> Enable cpuset controller in default hierarchy").
>=20
> Fix that and avoid unnecessay work by enhancing
> compute_effective_cpumask() to add the empty cpumask check
> and inheriting the parent's versions if empty when in v2. A new
> compute_effective_nodemask() helper is also added to perform similar
> function for new effective_mems.

perform a similar function
or
perform similar functions

> [...]
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index aff86acea701..044ddbf66f8e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1094,12 +1094,35 @@ void cpuset_update_tasks_cpumask(struct cpuset *c=
s, struct
> cpumask *new_cpus)
> =C2=A0 * @cs: the cpuset the need to recompute the new effective_cpus mas=
k
> =C2=A0 * @parent: the parent cpuset
> =C2=A0 *
> + * For v2, the parent's effective_cpus is inherited if cpumask empty.

+ * For v2, the parent's effective_cpus is inherited if cpumask is empty.

Thanks
 Manuel

