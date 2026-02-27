Return-Path: <cgroups+bounces-14481-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C3RNHP8oWl4yAQAu9opvQ
	(envelope-from <cgroups+bounces-14481-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 21:20:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C871BD85C
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 21:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC6243070CE1
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 20:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4033D46AF27;
	Fri, 27 Feb 2026 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTAk1+ab"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F10332628;
	Fri, 27 Feb 2026 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223267; cv=none; b=ru2beMHm2Mj74WdxE3Eyajpstr/JzCYjZJOg0kJAvRUlV6IYvXrtDgwyTY2JruCisnBGJuXfKh/B4b9mAF9Gw1wUNtORiOEgc17+JtZfNYyMT7l/Cag64IOfmofRO/PbBnPlJLSZn/5Y/RRqujm0z83wEFLfaM/tha87XP+SNFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223267; c=relaxed/simple;
	bh=+KOSKxsoGYY/7fsMQ88t/V8gy5v0QwKSCr+e29jLYas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hals38iG+CdIcBRDxDMj5WGIJRwXua5+bfH6UMTgkbmEj2+V7Oo0BVd6sevFwnIediHpsAdSqoHZK1KJ3dl+gQY8a1nsJju71UdXyxp9QN7BnFsIM/TqATR3u5KUhkqtHYWqdFeQSzBtKFZYb478IjQF2OPoh4U7wMPOa0bj5us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTAk1+ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC27C116C6;
	Fri, 27 Feb 2026 20:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772223266;
	bh=+KOSKxsoGYY/7fsMQ88t/V8gy5v0QwKSCr+e29jLYas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uTAk1+abXF7bulJl0Gq9qUj3wxpGCKecjwd4JWztwPUccptJKU++M4vQGoOzkyeCG
	 34FAs6yFS54QKh/J3H9JBK9iX144MGBGKqDUcqJyvKAqWEMD4WZZMrfib0kaFGkMkg
	 Bt+/XTb6+bTwoeWV15wXCQJciBR74MyYanQq7Py6O8gWuU+3hBcXvJtuyhs6PVyjtT
	 3xmlGfhGAHfdXfo9nSkShvwNjxU2m/eZM5rfzvCEZwiVC3yWT09mWF5lAaIVBQXxdU
	 Cm+n8wQ6dtJa8NpHxcdfsyrf7Evn09hj1pVMdMlkpeJHifPmxutjo3ZxeChmJmwNIK
	 ZUy0wm7IVoC+Q==
Date: Fri, 27 Feb 2026 10:14:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 07/34] sched_ext: Introduce cgroup sub-sched support
Message-ID: <aaH7Ifs8JVU8iGPl@slm.duckdns.org>
References: <20260225050109.1070059-1-tj@kernel.org>
 <20260225050109.1070059-8-tj@kernel.org>
 <aaBo0zDdwPNpGQaI@gpd4>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaBo0zDdwPNpGQaI@gpd4>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14481-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: 91C871BD85C
X-Rspamd-Action: no action

Hello,

On Thu, Feb 26, 2026 at 04:37:55PM +0100, Andrea Righi wrote:
> On Tue, Feb 24, 2026 at 07:00:42PM -1000, Tejun Heo wrote:
> ...
> > diff --git a/init/Kconfig b/init/Kconfig
> > index c25869cf59c1..96ba2fa08883 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1176,6 +1176,10 @@ config EXT_GROUP_SCHED
> >  
> >  endif #CGROUP_SCHED
> >  
> > +config EXT_SUB_SCHED
> > +        def_bool y
> > +        depends on SCHED_CLASS_EXT
> > +
> 
> It would be nice if we could opt to not build this. Also, if I disable
> CONFIG_CGROUP:
> 
> kernel/sched/ext.c: In function ‘scx_dispatch_sched’:
> kernel/sched/ext.c:2454:52: error: ‘struct sched_ext_entity’ has no member named ‘sched’
>  2454 |                 sch == rcu_access_pointer(prev->scx.sched);
>       |                                                    ^

Build bug is fixed. We can make CONFIG_EXT_SUB_SCHED a selectable config
option, but I'm not sure what that buys us. In terms of kernel image
overhead, it's not going to be anything substantial and it shouldn't add
noticeable hot path overhead either. In general, I'm not a big fan of
introducing selectable config options unless there are justifiable benefits.

Thanks.

-- 
tejun

