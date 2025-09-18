Return-Path: <cgroups+bounces-10254-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 749F3B84865
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 14:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FFC18876A5
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 12:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CF22D0C68;
	Thu, 18 Sep 2025 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g1iFMGLh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9A21C194
	for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197569; cv=none; b=ig8NyQx0kIm1ubgeULQTo5UlH16LtboAzxVyaXNf4MW9gzOE4zFuzgHWMCGhPUX6lHVeQuYTiLShhrKM9uyeuVwLng14UYGCtQu8OTpS/CGvq4NTP8kIXynabmYMJMKAowKICA3CjHWpzHh8HOuISNUlMeH5WiCI7mvUBAFWf3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197569; c=relaxed/simple;
	bh=3AuDQOb4x5iPQKA8fJMnmCnY++4xw9SzQPwxbDEjEO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i03LflfNWMK6ObRBELFGGtgTfQSomezIKwSzwLkX55jOWrLNZJkCZ5Gd2bF71Cm6lAUd4DEja0DueZNzmhdodvBNZ0/25tVtgl/JKAH+atLjIdSYr+il7lSX1e4OxLKr6OpIQNYpQLss+S6RjvxXJ6F5xt8JePNMzAIvdXltqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g1iFMGLh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso5486965e9.3
        for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 05:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758197566; x=1758802366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BWX04E2Uyfnl0/MdQ83kX9KCxuahZoS9QnFEedx1B1I=;
        b=g1iFMGLhBdzHGXMZ9VMTjgBRnD2aLwTrP7nJSP3UY1F6DU5408sbnwbNfT/xgqjzNw
         MQVDsNAwgLCtFT6scdmuM9eOhEu6Zlx+C51fbZvrMfis47p8Jux4KHldBDAVurlGB1lN
         65Q36IxCSSI2+eMzv5bxpAzO3gPoFy/WcKb1BTphkOdIFTDvQhm8yOwbyT6Y2z69RiXJ
         wB/chwaSD4krqOQcrbamo2uMJ+l6azrlt1i0XzlaejgsGWSD8I/rfcAFkuJVppxQOHRv
         5+ZQy+i6lUeP9MOm6guBzzBI4R/KCUP0HEH/lK/3nr3OpwpqiyQHe6bvER4ei8UmlkH/
         tD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758197566; x=1758802366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWX04E2Uyfnl0/MdQ83kX9KCxuahZoS9QnFEedx1B1I=;
        b=ikIWADEkM5q0Km/juqW0WxwpKvOjMlbpqOAf4nZkh0JPeZoXGSYk0sDONYFJ7EpT7z
         mJN0TVN25ULU88kHFaqWmeHvAbdnmlFuDFuEzNB7xwYSW+uSflDMf90Qk4fWNH68tKrt
         LZyW+4hJ9yS8JHiDbyXTPd10DwAjZw2K49yJe+OT52wqoNTsBOeEe3/GuDQ5Mx9+SMuN
         +G3ylxqaLhLjUtqhE0WhoHbdVzIRERWsIXxThJbCfMQVY3lboJE710+LZmYEbHuCiwjA
         QhmxEtyFoAdZKzYRQjAyFdRM/dtr3/pMqb9SiU3yUZRabO9CNLlk0MtKE1+weF1iPaMP
         gmMA==
X-Forwarded-Encrypted: i=1; AJvYcCVdWX2lOpsd4T49N5SLoPYQ+uqiZ5v0S4GEN8GPd7t7BvwNGoF3PuLuLwlc3ujO6fCif5oZLY9U@vger.kernel.org
X-Gm-Message-State: AOJu0YzF2rU5EABYqonuvydBUPQMud3Y7VDhjsT0x53Az5MzNjbQWaDI
	I9kBG5MMR9Q0kBtBRmEDyYQa76kqZW4z8/0JZ5tERxd952jVmebqQgquhlND+O4L1yY=
X-Gm-Gg: ASbGncucvdkEjsGrUHQZg3oHy+QPo86s4JCh1/NQHu1jDPgS3EwgiTNHkoPv6LMuMSV
	O9anagXxfUsc6lgljaqAniGaowc3h970RTyZDEjascUMrntAE4yDBbi/IPAZ7CAQNtCTkIYaa/G
	xNP/HtoOyeih++AOCTWAhM8FtpNxln8ckaRJLd1ZUz/VyXmuxm77yr4W4hmPKf6B8erJBWakJC2
	cQrgBlQQlncmFsMfu1XudWJIcIYC0TiNj/XeVkLSXTd0ONx/SnT7UuxfWMLCCKyWgcABQBW3dQK
	b1wd2wVB8oAfZH6Tq5uVXf/0+scBQ+aX79Na1PEfgqKQxj9ZceuSYnxTpGVR4AoSO0llids6IhE
	v+qC/YzP2bBhnAQIqwGO59vWdcJlDFnyi87ttAJOTwYW5ifeT2X8MW70JCtyYJXFReucWr2B+
X-Google-Smtp-Source: AGHT+IFC0tUTZXRyDtSx9d5omtvQ0WqRKqIy7a/GY6qAoByd5UMfWoRhcJw9UPFcqNlY7Wi3YHh+QA==
X-Received: by 2002:a05:600c:4692:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-46206f04fa0mr48803915e9.32.1758197565947;
        Thu, 18 Sep 2025 05:12:45 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f3252260csm64513315e9.2.2025.09.18.05.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:12:45 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:12:43 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jakub Kicinski <kuba@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 14/14] ns: rename to __ns_ref
Message-ID: <3hwzagok7cl3sz4x7wi7z4xwme54y3pyljfkqfjrbkjrbdlyih@rodvre2ii7f6>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
 <20250918-work-namespace-ns_ref-v1-14-1b0a98ee041e@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d2ckcju6bogfsla5"
Content-Disposition: inline
In-Reply-To: <20250918-work-namespace-ns_ref-v1-14-1b0a98ee041e@kernel.org>


--d2ckcju6bogfsla5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 14/14] ns: rename to __ns_ref
MIME-Version: 1.0

Hi.

On Thu, Sep 18, 2025 at 12:11:59PM +0200, Christian Brauner <brauner@kernel.org> wrote:
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -29,7 +29,7 @@ struct ns_common {
>  	struct dentry *stashed;
>  	const struct proc_ns_operations *ops;
>  	unsigned int inum;
> -	refcount_t count;
> +	refcount_t __ns_ref; /* do not use directly */

+	refcount_t __ns_ref; /* do not use directly unless initializing */

Or a helper macro like
#define NS_REFCOUNT_INIT(v)  .ns.__ns_ref = REFCOUNT_INIT((v))

>  /* cgroup namespace for init task */
>  struct cgroup_namespace init_cgroup_ns = {
> -	.ns.count	= REFCOUNT_INIT(2),
> +	.ns.__ns_ref	= REFCOUNT_INIT(2),
>  	.user_ns	= &init_user_ns,
>  	.ns.ops		= &cgroupns_operations,
>  	.ns.inum	= PROC_CGROUP_INIT_INO,

The double underscore stands out here.

Regards,
Michal


--d2ckcju6bogfsla5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaMv3ORsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiRfAEApv9CrJao8D2U3nthYItW
n4Mj9Y9Wuj/jH8AzHvpRZR8BAPgIUuzR7g9w7rnCTqM8ybuEtlMzNEwUPf5cGz0m
vFwK
=DJVu
-----END PGP SIGNATURE-----

--d2ckcju6bogfsla5--

