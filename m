Return-Path: <cgroups+bounces-6570-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CBCA38AFC
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 18:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9871B18929B4
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 17:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54A4231CB0;
	Mon, 17 Feb 2025 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UNilreET"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F54233132
	for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739815072; cv=none; b=rYja60zqWLYtzNrTfokpXHpyPd9ytmK0iKZUfce4DQ+8/MsMwuFChR8q2W4aZLdpqfG6MyC8XPtZhR3iw/2EXG5ZO93qZTMHDyha1Q1x++Kl4ESvjnoqTa2pw/mH3zfWZiD9m3lZl8SQlZ+tJ1aGrzLWgTjN95uAd64CRRx3t3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739815072; c=relaxed/simple;
	bh=BBNDe4VDZ7B1rKJS4SghuqNUBX7l/JBij6Kgv1XI5D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxojRS34BIht7lA58kHEx1Pzy3Ui1PQUtQMLJzrEIwDDk9ZcWhuHINQH2TdWSrXDM/SfjPdefcbJzsR/DPmmtnAXEWr5KCKA/QIAGmt8P2e/CTymdk+dJZKnLACjUNSKICdCe5E9WoLN3mDSiAb/Azxos+N51yXIAfi8NusVq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UNilreET; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5ded46f323fso5888626a12.1
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 09:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739815069; x=1740419869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BBNDe4VDZ7B1rKJS4SghuqNUBX7l/JBij6Kgv1XI5D0=;
        b=UNilreETx55NatOlDR2oBk5nWfNwLiQc/ge7tPzJ9qpcWWKgv5PV0YXiUgvlTAngCU
         1ZCxzb4A6tbr7fBYsc76SI4bUCHSqEXVzzTANHjDGqptiuIE8cSLg1am019xZ6+sTqFY
         GM5dFTRF/7+aiMDULP+bqiXJFwWIoodUxfMNJPHWDkRqW/6dhswTGlq8abap75K6K8Wx
         cgYE/Zrf8dlxjYlpoF+iXMBlPpMZuxM7F/1Q3sn1C1iDQUsVfSTf12VnqMwcGKiy5uZg
         KridYPbaPCF9pmMNFHaCtlA2QJfi9epdCtO3K4C0nIQ2J0SGYr22XSY8GzbUGsU1XR81
         2tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739815069; x=1740419869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBNDe4VDZ7B1rKJS4SghuqNUBX7l/JBij6Kgv1XI5D0=;
        b=ttu7hwWX96PTn9aoXoKxMVHLKVeSjmTpKRLVLyP6M7MmMMbmAog0G7E1nL/EiXYFQt
         34tzXi0+u2oMJqfTM17Dxzth7Y300kaZgd28SyqP/Q5PUMKlMEW/RKi0FNffKrPctMUN
         RyhxWyklZPkSXLLUAUZd8PSna+MEaAKO2JnQPn10Po5cy9uyFQ2fUtUZmZRdaeasHlft
         FMPpuml30e013IMorfCb7O6+VDzOnaEZcDrp88hAUBzC95jtzsPQFx/fr6zAqouQz+mQ
         ymGGtZaNztN0p56uk60nXYCDroFz1lVnuORXVrC0EKRw5D3AAWUaB/Ba6NFQtWzX6Mpl
         ki0w==
X-Forwarded-Encrypted: i=1; AJvYcCW/DM76alxBaoPNvtds4txTHCeCQyvPFBikQtAU+mYTP+ItJa5Xxthki2F7oKTRSY8Pvkk+dEi4@vger.kernel.org
X-Gm-Message-State: AOJu0Yze5HkbrWBv2hr4R5FRIcy70NxreOavtRfZ/4vTt/fCFgXIp65V
	0HCjAgHHeO/a75YK7+MfW60yv8P4nnLtH9nd9Z2nbngE26nk0wwgASNHQdJgFYs=
X-Gm-Gg: ASbGncuz/KNldt6giE4YO0kv9LJhx633oa1hZwo1Ond+8uHdlm7EIZ+hruNQTd9YrGR
	15PL8VYKAYQG02rbrgS1RmquGGT1lFeVxGCmuPG1HjnDWNiZ666lGIGITc4i9btxl/sK2n+qIoa
	CVqUbyGXYMmu98tLgb/3UZiqKCA105TcWOAx1b1K/WuYKlinRVcdAD4yHAQSDWeocO9HJR14Afh
	vy2JV/coX0fJEq61hj+JQvou68HbjbrONDSgEZzbRJGaFeYNsNFuxffmFE8ldPMD9W2qJh1Ej2f
	86On+TsrRXUlSgaAkQ==
X-Google-Smtp-Source: AGHT+IHhLdwZj2jv74Mbs98LUBVEWhEdTq/6oUDnDWYmDroBwSv6ozcHSeV/0qNpWeUox6P6nvdeuQ==
X-Received: by 2002:a05:6402:3495:b0:5dc:c9ce:b01b with SMTP id 4fb4d7f45d1cf-5e0360f9622mr9042695a12.8.1739815068694;
        Mon, 17 Feb 2025 09:57:48 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece28808fsm7407349a12.75.2025.02.17.09.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 09:57:48 -0800 (PST)
Date: Mon, 17 Feb 2025 18:57:46 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
Message-ID: <t574eyvdp5ypg5enpnvfusnjjbu3ug7mevo5wmqtnx7vgt66qu@sblnf7trrpxs>
References: <20250205222029.2979048-1-shakeel.butt@linux.dev>
 <mshcu3puv5zjsnendao73nxnvb2yiprml7aqgndc37d7k4f2em@vqq2l6dj7pxh>
 <ctuqkowzqhxvpgij762dcuf24i57exuhjjhuh243qhngxi5ymg@lazsczjvy4yd>
 <5jwdklebrnbym6c7ynd5y53t3wq453lg2iup6rj4yux5i72own@ay52cqthg3hy>
 <20250210225234.GB2484@cmpxchg.org>
 <Z6rYReNBVNyYq-Sg@google.com>
 <bg5bq2jakwamok6phasdzyn7uckq6cno2asm3mgwxwbes6odae@vu3ngtcibqpo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nesrzqfldixxuyvr"
Content-Disposition: inline
In-Reply-To: <bg5bq2jakwamok6phasdzyn7uckq6cno2asm3mgwxwbes6odae@vu3ngtcibqpo>


--nesrzqfldixxuyvr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
MIME-Version: 1.0

Hello.

On Tue, Feb 11, 2025 at 05:08:03PM -0800, Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> > So maybe someone can come up with a better explanation of a specific pr=
oblem
> > we're trying to solve here?
=20
In my experience, another factor is the switch from v1 to v2 (which
propagates slower to downstreams) and applications that rely on
memory.stat:hierarchical_memory_limit. (Funnily, enough the commit
fee7b548e6f2b ("memcg: show real limit under hierarchy mode") introduces
it primarily for debugging purposes (not sizing). An application being
killed with no apparent (immediate) limit breach.)

Roman, you may also remember that it had already popped ~year ago [1].


> The most simple explanation is visibility. Workloads that used to run
> solo are being moved to a multi-tenant but non-overcommited environment
> and they need to know their capacity which they used to get from system
> metrics.

> Now they have to get from cgroup limit files but usage of
> cgroup namespace limits those workloads to extract the needed
> information.

I remember Shakeel said the limit may be set higher in the hierarchy for
container + siblings but then it's potentially overcommitted, no?

I.e. namespace visibility alone is not the problem. The cgns root's
memory.max is the shared medium between host and guest through which the
memory allowance can be passed -- that actually sounds to me like
Johannes' option b).

(Which leads me to an idea of memory.max.effective that'd only present
the value iff there's no sibling between tightest ancestor..self. If one
looks at nr_tasks, it's partial but correct memory available. Not that
useful due to the partiality.)

Since I was originally fan of the idea, I'm not a strong opponent of
plain memory.max.effective, especially when Johannes considers the
option of kernel stepping back here and it may help some users. But I'd
like to see the original incarnations [2] somehow linked (and maybe
start only with memory.max as
that has some usecases).

Thanks,
Michal

[1] https://lore.kernel.org/all/ZcY7NmjkJMhGz8fP@host1.jankratochvil.net/
[2] https://lore.kernel.org/all/20240606152232.20253-1-mkoutny@suse.com/

--nesrzqfldixxuyvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ7N4lwAKCRAt3Wney77B
SatUAQDZaNdWHwjzXd9poJ9nHN5lCECypBk//h7v52pBxjbhGgEAzcXby8B//Pga
UrXQF9ErO8OmlXS3SMQq9MXR1nAU8Ak=
=C5m/
-----END PGP SIGNATURE-----

--nesrzqfldixxuyvr--

