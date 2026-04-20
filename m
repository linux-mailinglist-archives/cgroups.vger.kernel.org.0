Return-Path: <cgroups+bounces-15376-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAqsAfBw5mlgwgEAu9opvQ
	(envelope-from <cgroups+bounces-15376-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 20:31:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE79432DCC
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 20:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D5DA30C0A6F
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 17:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4CD37D118;
	Mon, 20 Apr 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B+aD+7Nm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F30E37E2F4
	for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704886; cv=none; b=ngtIvVYU+4OAJFSSYDTn5DDUfQF93lXu7p5AA3n+lpl5Es5anmyNA2JswfWkem8PWKAiDRq0nIzdwkqko4Nz4Dgyv++jRqukH8iXYfYg06EC+w1WBt8V4n3GsFElskRYhE+hTObXL6LhOEPic7DCyhx3bfXHYPIX+nXtnVfEb+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704886; c=relaxed/simple;
	bh=XJB8R9bjrnCu5YbiTbHI7SkNNwC463LYnHLpbNaekPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esbZMJaB7MSJ7r9rh2pyKOSkYN9oeU0xkTcNtMdDX5kaSgMC+3s2SWz7OhODnjqQWiMFjHe0DS1nVNOwje6PkzsZ/CpIUn40GAg5MkRenF5mwuBmZEFZMT3zSursYRxQVdyxXkWtXuCL3E7UBGjGcESQKe8E5eJMlQ7YyIBquR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B+aD+7Nm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43fe62837baso2006888f8f.3
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776704883; x=1777309683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XJB8R9bjrnCu5YbiTbHI7SkNNwC463LYnHLpbNaekPM=;
        b=B+aD+7Nm8iT/ujRYKEfLtYC0Ym312alUZ4v/gVbWFb4IgdHSv9vGM4NdIboVLtR2hA
         g3XB7UGDtBk6gwjNRgl1xHeyjnsAq9X0tfW2mBR1zRIFtPAsOgd99uaeI46PLf77UBN6
         p9Rhar+DSxL5h44EldUGPF7P8SGjJSzMwc2Rj0rvdDh1VDglxVlKnMqXA1xipZB6sIeF
         W9wQzVvcAzWCbIvq++dop1TT4SyF/BCUZI9edAiqXS44PaJLeyWl+3+JMZdq23MY/h6v
         TKxR09pPklB42D3dj2XaN5V3dm7YpmPDqvZSp5hQ39XRutt2RaygzB/rnJghaSYTTKds
         nzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776704883; x=1777309683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJB8R9bjrnCu5YbiTbHI7SkNNwC463LYnHLpbNaekPM=;
        b=F4hnZhRpp/H9rohtPtoIfFBQgWUqWPyFmpSDEkBgYAxFDQ9B1FmlTGDGttdW2yiVcd
         mJS5l/wK6TJcMn++ozmgHO7XG3P2pvL0fHwMcJ4RnMc6NuNPH3hQOQ6U8nnt8Kdn31Pe
         XXQHZ+GkQCdjobwaRC2uuSYA3PW3MUrnV99wiSJmMIn2IAokixCJ+AlfVQHNvpATdhk1
         uvcsvr/4UJixRFgwkuKMVMwEtbtaOrIQxWvZkDS9E30aBFiGBOH4KCg510OakftzowaY
         lehJmihr65QcAueyW583FYgsJ5p0qOQ1hIOq3x6QHXCqBLf3Dk50NuHvWl2ijj1vFnvy
         QauQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Zlogq1KOpDDutHNvALKo81ouFud86qIX4lXCTPjbbpCtHwrgT3iiQ1vaZudveLViHQHYiPtgF@vger.kernel.org
X-Gm-Message-State: AOJu0YxzG/bX1ekVqde1n5m7HnkDMUTw64qdTi/k1AmMVvHq8IkN+re6
	ne2Esj9NJOnIyKegQpOcuY4YbSmbybZ6v7L2Y2n/JlW5l0tECHJpCFqZgdQaKdCmKeY=
X-Gm-Gg: AeBDieuztQDZxohpEvZ/YSlW/eXM/dECGP3JHSnHenh8OZtcjKLVAVg2+3fv6ERgWSu
	JxRoqgLnsg+sf/qUhs5F7iStOM9mcfLCbuT2pwCmLgBYA/qxFsjOnMWX2B3wOoxYEb9Eyo8mS7y
	UFQqUxExfgywnaJi2q34MJuBAFVXeIrNdUE0kb4cHd2kvxUYI8Qt5Gw0zf1bS+YYbJRvHPCoKdB
	SnMRrYwAjsUBKw8nEqzi9WUNCYVQi2owW7y/QY6d/0cb3KXTKGrYssw7KMiYma0rEXWDjiT1ksp
	3lM2Eg4GtentDyEOuI4YDGRU5VLLm6vWX/nnBa8aTab6K+GprGoTyOFsCvxjROuK6pgQhsWKbL8
	io/WEy66AYx36RDb7QJh4Gz5P11OWq+OpY3qoIaRvgixVQXJMjX67uY3GvJGrI4Ft1i7CHvOBcr
	azAhfaLnJnrqgNpO0FnI+WilZU0TG3vm5TWvlmo2zUgus+lfCdip2Gmw==
X-Received: by 2002:a5d:64e7:0:b0:43d:5ec9:246 with SMTP id ffacd0b85a97d-43fe3db2d0fmr22138616f8f.12.1776704882787;
        Mon, 20 Apr 2026 10:08:02 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d5b1sm34049691f8f.30.2026.04.20.10.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 10:08:02 -0700 (PDT)
Date: Mon, 20 Apr 2026 19:08:00 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cgroup/cpuset: Skip security check for hotplug
 induced v1 task migration
Message-ID: <7i2hhyijet57lfwvz3ipzlwrze3i6bm343evgpjixmj6bj44kl@rhszdi6rlycg>
References: <20260331151108.2771560-1-longman@redhat.com>
 <20260331151108.2771560-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bmvl4rpxa4yembiw"
Content-Disposition: inline
In-Reply-To: <20260331151108.2771560-3-longman@redhat.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15376-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BE79432DCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--bmvl4rpxa4yembiw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 2/2] cgroup/cpuset: Skip security check for hotplug
 induced v1 task migration
MIME-Version: 1.0

On Tue, Mar 31, 2026 at 11:11:08AM -0400, Waiman Long <longman@redhat.com> wrote:
> If a strict security policy is in place, however, the task migration
> may fail when security_task_setscheduler() call in cpuset_can_attach()
> returns a -EACCESS error.

I think this should be generally safe to skip (since v2 doesn't consider
the object of cpuset migration at all).

> That will mean that those tasks will have no CPU to run on. The system
> administrators will have to explicitly intervene to either add CPUs to
> that cpuset or move the tasks elsewhere if they are aware of it.

That "no CPU to run on" means the affected tasks would remain in
schedule() indefinitely?

Thanks,
Michal

--bmvl4rpxa4yembiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaeZdbBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ah/dgEApkJzhnus53eimCCBgfUQ
6KIsCEgzeP2bszHHG2FMu6cBAKSQD9Deg3HKpVVWej0Au7dWT173mcVWPqtjph3C
CSsE
=vN3v
-----END PGP SIGNATURE-----

--bmvl4rpxa4yembiw--

