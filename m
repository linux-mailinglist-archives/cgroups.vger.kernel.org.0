Return-Path: <cgroups+bounces-15781-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOhZKdQ0AmocpAEAu9opvQ
	(envelope-from <cgroups+bounces-15781-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 21:58:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39282515596
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 21:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D6A3301641B
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 19:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C7C37F002;
	Mon, 11 May 2026 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2u7SNV5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A562E8DEC
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529489; cv=none; b=G75W97T6EZy1SBUolW0tBCpgKolDo4MXFpQhYAHJDt9nvEWPBF23W59zGxKZVFYGhF3qZRva2bIUF65V0r0xflGHKyKChD1KZpX5Bwn9tLa81JfiMAkXzSVKzFVUUiITC8vnzXSLYmB+E9EqvBe4iPBV8Png+SuHnsp2FYCWrFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529489; c=relaxed/simple;
	bh=Ro69MQ9EqEnNINtduiTATSKngAU7AoF+/0O7Kz5FFSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVjT/3+ChDUSfY1zxeFPY2MObh/RPIxxVYmGEvYnXZ6SUs+rVY/Hz0+ayF0AYiXTKFMIReOSJHQ9ar70uzYFRCgLxnugLjEmEbEgviTSYJlGw/RMjXC2Dhj72JLAbIBw3Wndk52ycKx5B2qo9yaQwOnh2ryKXQDw+eAgBQW6plQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2u7SNV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465AEC2BCC9
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778529489;
	bh=Ro69MQ9EqEnNINtduiTATSKngAU7AoF+/0O7Kz5FFSM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I2u7SNV5bs8OJ2W+gFAiVWIJPqIsMJnrUmeXEiOXiN+Awh/+AoZHWsawFt82eGQP1
	 iYvFkHu/cjhJwN6v1C9Zln9xKKrSAykZybOV6uAn1zckKzd3+wi6S+G0bpo0yge9T8
	 sHydtMPo/jgHIG33SEzoc4lv848LeRzUnkRJTHd/YTMjPeRsQS1HtNLbx31345j2VR
	 CMp1/J7A91nx2fZ376nBGthXZo1JpZ7xTpNwtu1nBA7nCpqm+UILkIIrvyXcnqpZXb
	 sDgndDgUZwi6rfZe4myIVrtoLQUsRh/KJeKbEUjaYGZKTr7T2Sg/nKDXrDYQ1AcsFX
	 H7LxvjP4NJ2nQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bcff2d08ca8so196628566b.3
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 12:58:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9oI52f0/fvJ/8zZuTTbASchRv1gAKQoaU3My7BBpSUfbmK0soybeYjwmlAOaiKSrJptsVfpaxo@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZSzRY/GPaHjI9IcI57Fb7aw7e+1HCScMQIbTMmyBB7N6p4/l
	XrUX/ASqC3ypHdwwClgEPu6pOKVcSIPLWSsJv0K5xkyI7FpVB3vHtz30BXonlf5OudtFYfP24Hz
	gdKLMQwTkKPkqfNLDxwqAZlKEw/dO4fs=
X-Received: by 2002:a17:907:9412:b0:b97:1d24:c004 with SMTP id
 a640c23a62f3a-bc56de100damr1640546966b.21.1778529488205; Mon, 11 May 2026
 12:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511105149.75584-1-jiahao.kernel@gmail.com>
 <20260511105149.75584-3-jiahao.kernel@gmail.com> <CAKEwX=PLFRkfUvZyaYfwBv0QJ-8KAktvZvGA02Hod04H-RsS-Q@mail.gmail.com>
In-Reply-To: <CAKEwX=PLFRkfUvZyaYfwBv0QJ-8KAktvZvGA02Hod04H-RsS-Q@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 11 May 2026 12:57:56 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNOPdpJuTmccvQ6ZAVS+tXxp-_ofA765DbnfaUZOPPO-g@mail.gmail.com>
X-Gm-Features: AVHnY4JggveioK6wHYDCMPwvJ0NzLIt9APWEOL57HCcrUJO5sRIVBp_Ljdyoras
Message-ID: <CAO9r8zNOPdpJuTmccvQ6ZAVS+tXxp-_ofA765DbnfaUZOPPO-g@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/zswap: Implement proactive writeback
To: Nhat Pham <nphamcs@gmail.com>
Cc: Hao Jia <jiahao.kernel@gmail.com>, akpm@linux-foundation.org, tj@kernel.org, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 39282515596
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15781-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,vger.kernel.org,kvack.org,lixiang.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lixiang.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 12:49=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Mon, May 11, 2026 at 3:52=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com>=
 wrote:
> >
> > From: Hao Jia <jiahao1@lixiang.com>
> >
> > Zswap currently writes back pages to backing swap devices reactively,
> > triggered either by memory pressure via the shrinker or by the pool
> > reaching its size limit. This reactive approach offers no precise
> > control over when writeback happens, which can disturb latency-sensitiv=
e
> > workloads, and it cannot direct writeback at a specific memory cgroup.
> > However, there are scenarios where users might want to proactively
> > write back cold pages from zswap to the backing swap device, for
> > example, to free up memory for other applications or to prepare for
> > upcoming memory-intensive workloads.
> >
> > Therefore, implement a proactive writeback mechanism for zswap by
> > adding a new cgroup interface file memory.zswap.proactive_writeback
> > within the memory controller.
>
>
> We already have memory.reclaim, no? Would that not work to create
> headroom generally for your use case? Is there a reason why we are
> treating zswap memory as special here?

+1, why do we need to specifically proactively reclaim the compressed memor=
y?

Also, if we do need to minimize the compressed memory and force higher
writeback rates, we can do so with memory.zswap.max, right?

