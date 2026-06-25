Return-Path: <cgroups+bounces-17282-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fmUOHnjtPGobuggAu9opvQ
	(envelope-from <cgroups+bounces-17282-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 10:57:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA426C401C
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 10:57:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=ZNF8oOTz;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17282-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17282-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF9D93025703
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 08:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACFC3845D9;
	Thu, 25 Jun 2026 08:57:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B031578E;
	Thu, 25 Jun 2026 08:57:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377842; cv=none; b=U1DRJqonPuCRyFLaXsOE18TFZrPxblRRBaWlYj/dcu4Tf5VdCNCFcXnH8DXl7XGru/djYRIVeETtzuT/QCc1w3SODoNy1p4PgCR7cs6uY2rNy/A1CC6Sxh1wjx312gB5OWZhF9eehAcmlS3AkAf1rlsj6GtkSiJo2/2Lp7Y5eJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377842; c=relaxed/simple;
	bh=4ovQ9FDAeLTwePTMHYW6w2T3BZnIXzKw7+7SCYheTq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAjx/6IgS0w8/+Jx0k14e+HAjDWpKv1pL/NsfYCO9vC4dy1Bpy5FM3VZW0BVs6yjAKy75vexgeRjH+lWWb1FqXgdKdhUoMVCgGCpXpf8L/3IP99Ky5fbVlVxBrzb0DmddYoaWnnT+UUdVIyLbCYQZZL5iEcB5hS2ANgLtJ196NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=ZNF8oOTz; arc=none smtp.client-ip=212.227.15.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782377824; x=1782982624; i=natalie.vock@gmx.de;
	bh=5sovfMXXV3q1CNiomfvSl1RvdSeGXKXP+CcGXXDeILU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZNF8oOTzDrE/SHe4huAkDnL0BBVPIFvqMC9Zn9YlxSNQ9g4LdPs8ByCaYCmpt8su
	 k2JpoDwDxLDqBE0kfyYU+GPCLEyVHnPVPLkALB26kupSy+G09Dm3q9eE/yWYoHj3S
	 gbbZuRUkFqFqLokXMCLniN+yU9IhHBgaq0r+rTW5n2FdM3E5JLkk5fGnSwj+TRQUS
	 RW+BxMn+8vIvLqQqiC+/Q9swPwkWJByFgvOB9b+rIC0nXK/nWZj8RQS4N7hbAC5rc
	 +7ILDdlimT0JFToZImDodUvf3A6Z6YC+kmP/9Fy0JIa3DzA5rKnhbm1zpgCKT4JVk
	 Jem5dqP0jhLh7M9/eQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6lpM-1wVX0r3xcM-00DmoU; Thu, 25
 Jun 2026 10:57:04 +0200
Message-ID: <b549422c-7c35-434d-ad4a-49a4676970ac@gmx.de>
Date: Thu, 25 Jun 2026 10:57:00 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup/dmem: add per-region event counters
To: Hongfu Li <lihongfu@kylinos.cn>, tj@kernel.org
Cc: cgroups@vger.kernel.org, corbet@lwn.net, dev@lankhorst.se,
 dri-devel@lists.freedesktop.org, hannes@cmpxchg.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mkoutny@suse.com,
 mripard@kernel.org, skhan@linuxfoundation.org, hongfu.li@linux.dev
References: <ajwnf0uzT4PMHYZx@slm.duckdns.org>
 <20260625021053.488107-1-lihongfu@kylinos.cn>
Content-Language: en-US
From: Natalie Vock <natalie.vock@gmx.de>
In-Reply-To: <20260625021053.488107-1-lihongfu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CEljW2+RKbyTzEtBdOh9bp2lP4jVSsdvL0KX5wMFpLnqeyxBWDu
 cbJOWfS3T57jYAPNP+ErV1r+JtpYg4GpSyb2TXnCSWmEOcWcJJMSrQE38/VvCkI/OxzHvDC
 s0hhvPKuFboTRXeD9uj74HZ1hdluscgIuWVfR+I2apckNNZ1dwojjpoai5/1vu+C30jAmxB
 1Z20gKPR4ljZ5+YqwfspQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:r9esJXEQ0Xg=;llHEx3cnA2NoukvUtR/omkYNrFr
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lihongfu@kylinos.cn,m:tj@kernel.org,m:cgroups@vger.kernel.org,m:corbet@lwn.net,m:dev@lankhorst.se,m:dri-devel@lists.freedesktop.org,m:hannes@cmpxchg.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mkoutny@suse.com,m:mripard@kernel.org,m:skhan@linuxfoundation.org,m:hongfu.li@linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17282-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.de:dkim,gmx.de:mid,gmx.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDA426C401C

Hi,

On 6/25/26 04:10, Hongfu Li wrote:
> Hi, Tejun
> Thanks for the review comments.
>=20
>>> Add dmem.events to report hierarchical low/max event counts per DMEM
>>> region.  Increment counters on dmem.max allocation failures and
>>> dmem.low protection events.  The file is available for non-root cgroup=
s
>>> only.
>>
>> Please don't double space in descs or comments. Also, maybe it's obviou=
s but
>> it'd help if you list why and how this is useful. Why do we want to add
>> this?
>=20
> I'll fix the double spacing in the commit message and comments.
>=20
> As for the motivation: dmem already exposes per-region limits and curren=
t
> usage, but not how often those limits actually matter at runtime. Withou=
t
> event counters, it's hard to tell whether allocation failures come from
> this cgroup, a parent limit, or pressure elsewhere in the hierarchy.
> dmem.events provides that visibility for tuning dmem.low/dmem.max and
> diagnosing recurring device memory pressure.

Shouldn't you be able to deduce this rather trivially from just looking=20
at the current usage together with the low/max limits you already set?=20
I'm not sure I really see anything this events file provides that=20
analysis of current usage and set limits doesn't? If your usage is=20
highly variable, the separately-developed dmem.peak file might also suit=
=20
your needs, but still, not sure what you can do with dmem.events that=20
you can't already do with these tools.

Best,
Natalie

>=20
> I'll expand the commit message to cover this.
>  =20
>>> +  dmem.events
>>> +	A read-only file that reports the number of times each cgroup
>>> +	has hit its configured memory limits.  The format lists each
>>> +	region on a single line, followed by the event counters::
>>> +
>>> +	  drm/0000:03:00.0/vram0 low 0 max 3
>>> +	  drm/0000:03:00.0/stolen low 0 max 0
>>
>> This isn't a supported file format. Please read the documentation on al=
lowed
>> formats.
>=20
> Thanks for catching this. I'll switch dmem.events to nested-keyed format=
 (region low=3DN max=3DM).
>=20
> Thanks again for the valuable feedback.
>=20
> Best regards,
> Hongfu


