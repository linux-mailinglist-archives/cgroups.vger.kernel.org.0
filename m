Return-Path: <cgroups+bounces-5578-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79839CF3F0
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 19:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E4DB426A5
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392DB1D61A3;
	Fri, 15 Nov 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2N6ztpfK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3uwaxwfc"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A14E15573A;
	Fri, 15 Nov 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691981; cv=none; b=BJ7Se97mXDt2DP4Zx4LGKcISxQOgrUuDMdysEIau6s8qtZgSWgvPKUivzSvitlLd7PND+fknqsOJbrplI9qZ+ZkKkRym5shCscvKozC0vtB7C6YpYsCnkVdr+3DadGfcNw04X1/pYZoivNsWXv5Cpg1RoyZvpA7uS+GrADeH+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691981; c=relaxed/simple;
	bh=OX0CjJ0yRVQ5QY/1AzjxsV+ThfM1ZrQMWDEm+bfFHDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmcSxTdS4qs4H98bTYTTXnZmKWaOxvbe38KXn0Rf/WPbypKA+sRmgepB6kueNSDmnCaylXuMwfyd6m2Y9CdkEKc24BdAY9buh8jKB0Y4SUexmtE2O6Iw+mgcy87bcejZoG1DOKwRP8YzAj7k7eB0NfTkVMhxbM1AX5LseZ3RSs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2N6ztpfK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3uwaxwfc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Nov 2024 18:32:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731691977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cst6lniwObgDlwMDtSbUQUqE/oz2DK6DpaC3A0s78Ao=;
	b=2N6ztpfKKMxnn5MrxcXLtr7Ktj224kySb1o630qokx1WcJXxo+h4dZBrAwXlsKtCWVEdns
	OA+ygUKHL6slzn0tNwlT1C7gO859wTZteW2tHfOqq/JyB8cWz8wUhthtW8lwyDBZnGlRAs
	5eTmHxBJEMFx5Tn3vkC+Sx8AJJbDbuGXQ0GM8jFR8lslUg2s2vFgafgChww5mJbiraGXbS
	6LpbuiLSRQuGVfgnpfgXfozzu01ugJ3wB5vv3BCsK1mecdK4KUh8KX7on6DlJkj7kV/OpC
	RYYVCBTBSCUE0ZlMKyzX98CSUSDN09VbHil8pZonTFmoa6pBxaILMJMV8QcBlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731691977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cst6lniwObgDlwMDtSbUQUqE/oz2DK6DpaC3A0s78Ao=;
	b=3uwaxwfcofOyQ2ZocVOfPqE/NVlnUjFDAJNPt9ilGo6xl0gzQJe0gdquotyDdQTf8tdDBe
	VZPzL8fRH1pGdfAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>, tglx@linutronix.de
Subject: Re: [PATCH v2 1/2] kernfs: Make it possible to use RCU for
 kernfs_node::name lookup.
Message-ID: <20241115173256.13IVHFNn@linutronix.de>
References: <20241112155713.269214-1-bigeasy@linutronix.de>
 <20241112155713.269214-2-bigeasy@linutronix.de>
 <u7h5zfjxz7yo6e2ukrlnznj4ug66pgu2cel4jqejjji4lzphv7@2b4ntlfl7q2g>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <u7h5zfjxz7yo6e2ukrlnznj4ug66pgu2cel4jqejjji4lzphv7@2b4ntlfl7q2g>

On 2024-11-14 14:48:16 [+0100], Michal Koutn=C3=BD wrote:
> On Tue, Nov 12, 2024 at 04:52:38PM GMT, Sebastian Andrzej Siewior <bigeas=
y@linutronix.de> wrote:
> > --- a/include/linux/kernfs.h
> > +++ b/include/linux/kernfs.h
> > @@ -147,6 +147,11 @@ enum kernfs_root_flag {
> >  	 * Support user xattrs to be written to nodes rooted at this root.
> >  	 */
> >  	KERNFS_ROOT_SUPPORT_USER_XATTR		=3D 0x0008,
> > +
> > +	/*
> > +	 * Renames must not change the parent node.
> > +	 */
> > +	KERNFS_ROOT_SAME_PARENT			=3D 0x0010,
>=20
> FTR, cgroup v2 doesn't even define renames and the full rename
> (different parent) is only used by resctrl filesystem AFAICS.
> I'm only mentioning it in the case you wanted to replace the flag with
> two different rename methods in kernfs_syscall_ops.

Thanks. I think I have enough clues for a v3 now. I wanted to do
something today but didn't manage it yet.

> Thanks for fixing this locking situation in general,
> Michal

Sebastian

