Return-Path: <cgroups+bounces-14828-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA5CCWLDt2m1VAEAu9opvQ
	(envelope-from <cgroups+bounces-14828-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 09:46:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EA02966CA
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 09:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89E19300764B
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 08:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B093822AE;
	Mon, 16 Mar 2026 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="YaOcUGg8"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A483822AF
	for <cgroups@vger.kernel.org>; Mon, 16 Mar 2026 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650781; cv=none; b=sjBNuy080uZIZ2Vjpad/eaD4xB/Aii97c+Q32oeONT9gAPtkuKaxMWQwdHu7FvzfYTMTrDB8+zC/nqXeQPM02dOU8eeVKh5SozN25EqgQh8EspowVPUj8UdvJ7HeSpgAg9Z9HxfeE5vcFozVZOi+cUnBvOn0akS8v5g1lOgiIL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650781; c=relaxed/simple;
	bh=au4oUjf1R3jQS8P9UTO9wB9zvyDEBuHCYgRAXcJzV+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ll1S9haomg+mLJQQH9ULZms6VLmItk3rtGAeYSCB6cfph8NtA7SHubhOFh5nUyGIj3DLwSvH85Nx0Ob48ykU72qJqLw4kOhYw6MHuInjrUpnOv7G+/DckAkYkH9y0rkq1GIJhjsOBIfxQFg8bJc4ZR4+t7v4bwIeBlYIiiWK9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=YaOcUGg8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773650777; x=1774255577; i=natalie.vock@gmx.de;
	bh=96UFq0Jee3mbXOL1pVtFSnSBHwRvEcVpbZpy1zz8p4E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YaOcUGg8VHKdDPy0bcFRgcgQCEz4EjivZ00TMNeTd04aP1BYoBcpEJZjwX2hKp0p
	 ZCm4DHb+I4aVWngVqapn4t/uprNVWMX7GhNpFAUgbgPgXeTXMTpGOngErZo8jbtkX
	 YSNA8DX0QsYz9cweXzYyN0IOsmfJUi1y793O9YuLv+88s3aR9TNuAlSxXQ+LinAKW
	 2hfH6jcT9oi6SiIE+McrKGpgebU7bISgoJsmMdEdoLECyMXmEFWGoe+QZ6zs4J6js
	 P0Px2TiP3g1AD3xosCDHFjBpj50yKzl3tzgfmspLb4ULmhEByNb03LUhLbj34ntsn
	 Ew1a2lG1kUb1oS75GA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOA3F-1wH8We2HLF-00N8CL; Mon, 16
 Mar 2026 09:46:17 +0100
Message-ID: <911b9bfb-c352-4f6d-93a1-540246ccd5b2@gmx.de>
Date: Mon, 16 Mar 2026 09:46:15 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] cgroup,cgroup/dmem: Add
 (dmem_)cgroup_common_ancestor helper
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>,
 cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-2-7c71cc1492db@gmx.de>
 <cykgy6mf4nu5kkwl3uc6modkj3ppela2xgjy2ijidpyzdsnyn4@cbwivcrqa5kh>
Content-Language: en-US
From: Natalie Vock <natalie.vock@gmx.de>
In-Reply-To: <cykgy6mf4nu5kkwl3uc6modkj3ppela2xgjy2ijidpyzdsnyn4@cbwivcrqa5kh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I7f7ml8E9z07wjFby9cVae4dD0jqNDkdP7LcekYQT4nATfv0iTl
 FlvKU9BeogR36eU7TZjW5sefFPp9e/9us3qEO6d7BZkVBo/oTFR5qrKQAYflY87LDgQyJAk
 TaVGvFbXv/BAWttB+Q5iHfT1YkFg1wu9o23ruqdzZ7BZyaadG4YUND54rzX/wmjKpsIA7er
 bppV4mABIPNdJUKUUtsUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8Ua4JPpl2Jo=;Wyk8I/cscy6VpHaYQkUf0+ErqS1
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14828-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lankhorst.se,kernel.org,cmpxchg.org,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,vger.kernel.org,lists.freedesktop.org];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:dkim,gmx.de:email,gmx.de:mid]
X-Rspamd-Queue-Id: 91EA02966CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 15:16, Michal Koutn=C3=BD wrote:
> On Fri, Mar 13, 2026 at 12:40:01PM +0100, Natalie Vock <natalie.vock@gmx=
.de> wrote:
>> This helps to find a common subtree of two resources, which is importan=
t
>> when determining whether it's helpful to evict one resource in favor of
>> another.
>>
>> To facilitate this, add a common helper to find the ancestor of two
>> cgroups using each cgroup's ancestor array.
>>
>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>> ---
>>   include/linux/cgroup.h      | 21 +++++++++++++++++++++
>>   include/linux/cgroup_dmem.h |  9 +++++++++
>>   kernel/cgroup/dmem.c        | 28 ++++++++++++++++++++++++++++
>>   3 files changed, 58 insertions(+)
>=20
> When the helper is added, the idiom in
> kernel/cgroup/cgroup.c:cgroup_procs_write_permission() could perhaps be
> switched to it too (structured in commits) to "optimize" migrations from
> large depths.

Right. Perhaps better suited as follow-up work though, isn't it?

Thanks,
Natalie

>=20
> Thanks,
> Michal


