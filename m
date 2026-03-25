Return-Path: <cgroups+bounces-15045-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMWlDpcfxGmZwgQAu9opvQ
	(envelope-from <cgroups+bounces-15045-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 18:47:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9FA32A153
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 18:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 314DE3010729
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 17:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAD44035D4;
	Wed, 25 Mar 2026 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="eZKHiMpN"
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55AB24BBEB;
	Wed, 25 Mar 2026 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460452; cv=none; b=pZfMgD3z9gNbAsBx5HCZFG0urOFMepJju3+b7EMUWgLBz1yZZdDAQXZFMJVkrOeh8heiqmRCNcEmvCQQBdqc9EtHUC/7q3lXRfJru8+lQ+iZp5Ywao4KMOeOBhZHPRv1fThmr9SCmZM24immXG0cXWz+ebCRMoY/9PTYLsosfNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460452; c=relaxed/simple;
	bh=hj3o3G9XhkwMqaTKh0AJYwv6VWqb3tJ8NSmdRt1luSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jb1KONt94swyjO3YcSGlDIKyZTuSCdNMIuKJxW5QkQqTR7FuScEeykkfMPovXhsEmOLUU2JSeZXvP14O1nLpYdrVRjuGaDvQdOVYXa3+Hx4rwvHRp3ygtc91YddSBiRSm6xUCu73vW6Ittgn8s7WjzBpVB7AWt48OPhbnaLT5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=eZKHiMpN; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1774460441;
	bh=hj3o3G9XhkwMqaTKh0AJYwv6VWqb3tJ8NSmdRt1luSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eZKHiMpNpcPIBahNXtzhZb5u11e7BXyJac+OoEP9JjHLFsZUJor4xTsiRBdJldpcG
	 JxkZTFskDnDfdzUMU4YThMBSUhQ3dYKVkk1+VDvALuUS3jtDdRafU4PKhDcYYRvrYX
	 qRN3wutLAHfplDWP1dZcuXKpirZ3cYgzno0AR2od31PKg9wZa8axtErRUtj7WtxZEX
	 FkO35/mJ5YaSigo8jriGUSkzxGU8pVzQ2zPTc+bNc7RLPhxBGdcWCmo7EA1FTcqN7I
	 7w2SB0wcD0MwoMMiFZIQUz3ixnz2ae1QPK1cQybgWhFVcI/bGh7fr/MMg9vg92e1Yl
	 SUucGB9dfxchw==
Message-ID: <f1edec8a-f446-4fdc-b39b-1dbb690ff57e@lankhorst.se>
Date: Wed, 25 Mar 2026 18:40:40 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] cgroup/dmem: allow atomic irrestrictive writes to
 dmem.max
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
 <b099d9248df084fed8d4252e3c6fc485@kernel.org>
 <88f89d75-1e1f-4457-8c1f-57e934c251cc@lankhorst.se>
 <acF6PMV-aezq3dWc@quatroqueijos.cascardo.eti.br>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <acF6PMV-aezq3dWc@quatroqueijos.cascardo.eti.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lankhorst.se,none];
	R_DKIM_ALLOW(-0.20)[lankhorst.se:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,cmpxchg.org,suse.com,vger.kernel.org,lists.freedesktop.org,igalia.com];
	TAGGED_FROM(0.00)[bounces-15045-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lankhorst.se:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@lankhorst.se,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lankhorst.se:dkim,lankhorst.se:mid]
X-Rspamd-Queue-Id: 2E9FA32A153
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hey,

Den 2026-03-23 kl. 18:37, skrev Thadeu Lima de Souza Cascardo:
> On Mon, Mar 23, 2026 at 05:46:28PM +0100, Maarten Lankhorst wrote:
>> Hey,
>>
>>
>> Den 2026-03-21 kl. 20:27, skrev Tejun Heo:
>>> Hello,
>>>
>>> Generally looks okay to me. One comment on 3/3 — the naked xchg() in
>>> set_resource_max() needs a comment explaining why it's used instead of
>>> page_counter_set_max() and what the semantics are (unconditionally sets max
>>> regardless of current usage to prevent further allocations, since there's no
>>> eviction mechanism yet).
>>>
>>> Applied 1/3. Maarten, Michal, what do you think?
>>
>> Yeah probably drop 2/3 too since there is no longer a case where setting a limit may fail.
>>
>> Kind regards,
>> ~Maarten Lankhorst
> 
> Actually, this can still happen if an invalid region name is given.
> 
> So, one could write:
> 
> echo -e 'region1 max\ninvalidregion2 max\n' > dmem.max
> 
> And even though setting the value for region1 would be applied, the write
> would return -EINVAL.

Makes sense. It would be good to validate in advance then. If that's not possible we
should at least not error when we try to update 2 regions simultaneously. Likely the
best to do so anyway if we want to handle eviction, which may be handled in a blocking
fashion.

Kind regards,
~Maarten Lankhorst

