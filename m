Return-Path: <cgroups+bounces-15659-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFMwFwyH/GkaRAAAu9opvQ
	(envelope-from <cgroups+bounces-15659-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 14:35:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF24E843A
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 14:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B31A93027963
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2026 12:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321773ED5D5;
	Thu,  7 May 2026 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TvSLHeQh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C637189A
	for <cgroups@vger.kernel.org>; Thu,  7 May 2026 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157225; cv=none; b=bDaQvDD6T0apaW2gickOs7AQodrYw4L1/pKY6/wdHbbXs2SnXsYGUmY+mIbRzYVeSTPO9CIwFi8e52RCBsR5TZvVmaxUHRG2z8YaO2GgxmW0mJ4sIcuZ1lQgZdIPC5DV8860ZVIiRjPL3Ss0QK28stGJneqYWGv/Q9IV9KykaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157225; c=relaxed/simple;
	bh=/j34EO3N1sgNWbbycnNE9oIkrmRtDeYAbWJpqtqpUyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH4X92IdYg5x5jrjCSXfPPjFO5OYvCXU71r/huFDc7Mvl35313bUvXxsZx8sFEkx4a6hY+b769mDlUWBbIVh+GuphPVR8tEpLxHGMRJUUSqp22HGlsuwwfxt5+kJ34NajkcyTa7/TeZFO4A9Jks/i+YKjNw3HXcNqkSTJLnMQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TvSLHeQh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48909558b3aso9477795e9.0
        for <cgroups@vger.kernel.org>; Thu, 07 May 2026 05:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778157221; x=1778762021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CTmqfglj2+4OL7BNewSjF7y+lLfP01LseLD6DRMfrg8=;
        b=TvSLHeQh1k8RDtc4m0RGSncIIA4+AB7xI/VNLFX32VRLO9irVp3fZUAw7NxYaSckYs
         5QFjvS2RM93n9KICHemXIbAg4nDnMB7LNKCVxrtXXPseCaRiPZlpZDX/yADKEimpULhm
         ZqhfEfnvfieojZpKoyad5Pt6bcywpDEYRjPGJziwGCO/A1IbEDPJE77W1xBESXrCCiLh
         8pOL/O9it9uuL9SzWvJDiN+Xyps9/ghEvrcFY4L8WnHcw5FDr8IIBT4wnCtvnWVXeHJ0
         iJcGsd7EhfDHdCayfA44eEy3zKxPRtxUrFC3BRfnrqI61kmLJpZxwMRuclHrt60GU8Df
         RNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778157221; x=1778762021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTmqfglj2+4OL7BNewSjF7y+lLfP01LseLD6DRMfrg8=;
        b=TJbEBENs1yq43XwBf38gFZjvnW+qzmtJ2ucDUY5pJYZNozEAVb/TWyWLUm1GNp9Lvy
         AEnb+9hTiDhdMFPnHMv5SxwtJJM1KfeL5QNfgJB9kjxB2T7qD1PLXf7f/UkE+nHALJ+r
         x+ED+GVIvfCTMlgu+w5Uh1PO7GXPIYB1HADXT+Eazf8vMFpJuIlGm6y164CHcBZRamwm
         vm7RR02iQaLYvcDITAei6KXfATGh1zA299HMvpjbnkNQ+7aT0m9P7sHKbYOw9vIRGoA4
         GhOrkbYvg4Eee+WNJo1lBHgDqYnmdTufy1U71Cv2+kBRfcaRpDmyIfAf2AgG10RtsVGt
         dgsA==
X-Forwarded-Encrypted: i=1; AFNElJ+s7q7QQrHVb6qQi9zKQVNsx7BuXjJmbsagE18NaPJ2PbNi9i2PEDf/hvGQaVOPMViXx0chIY85@vger.kernel.org
X-Gm-Message-State: AOJu0YwbjhMPhI5rYCDDm1kiprmZ/BuW4CTgT7clC3aGPHPPGOa5T9yn
	nyOxXMTEISwGFfmTGCKOEVnjc0OpFC+4+ZdFcV8qjze1x3/pD90M5WNs7a3aY+TLK9I=
X-Gm-Gg: AeBDies9yFAyHZcNxXWCBhExvrP7rpDPiM1emyaPzdSRNWeKNSFMIeppfxdEdh7aunV
	ABV9flzTMMPNB82VXy3EEyOs3zdfYXQz9FqWhPvfzCuRJmMVHYF1d5JF+eMvmZzvIOiBYNcG01r
	PNht4/donxaXsjZwp0mSEb/+17+vgj5pg+wKxcbbHVEb/tB7qQJ3CpDLYcKaaM9lJNziv5M4Qxk
	EeN4px1PA1e8U4uB+knvimmFjmTk9IPkASdaYlKiRb10TdPWvuK+WLnZCv6Pzao3GmJPg0GZ0rz
	/qVhqzhhox7fFXaCtbAirgkA6lt2YGN6VrYxopipvtem+Pt575SrYYaYW7GtcjvjdBLUmXkoD9I
	bEGMRnEP0bIPwMk9CveymtFv7QJXiVmeBLz2dyGtsURHhIzODETnYIT/FaYM/d64Svv+A0iHMMq
	06h/rGSIRLiZ96DgHmzs1hM1z+VPoT9yj6pboHdYMsJNnkD9Qg7+EGeoZyZzs=
X-Received: by 2002:a05:600c:4c25:b0:48a:65a5:750f with SMTP id 5b1f17b1804b1-48e51f46ddamr76036625e9.21.1778157220675;
        Thu, 07 May 2026 05:33:40 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5390f854sm117995255e9.14.2026.05.07.05.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:33:39 -0700 (PDT)
Date: Thu, 7 May 2026 14:33:37 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Wandun <chenwandun1@gmail.com>
Cc: longman@redhat.com, chenridong@huaweicloud.com, tj@kernel.org, 
	hannes@cmpxchg.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: move PF_EXITING check before
 __GFP_HARDWALL in cpuset_current_node_allowed()
Message-ID: <afx1u4kV-2kvgEEf@localhost.localdomain>
References: <20260507105434.3266234-1-chenwandun@lixiang.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3chgs2uacfweczqc"
Content-Disposition: inline
In-Reply-To: <20260507105434.3266234-1-chenwandun@lixiang.com>
X-Rspamd-Queue-Id: EEAF24E843A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-15659-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


--3chgs2uacfweczqc
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/cpuset: move PF_EXITING check before
 __GFP_HARDWALL in cpuset_current_node_allowed()
MIME-Version: 1.0

On Thu, May 07, 2026 at 06:54:34PM +0800, Chen Wandun <chenwandun1@gmail.co=
m> wrote:
> This makes it unreachable in the common case, so dying tasks can get
> stuck in direct reclaim or even trigger OOM while trying to exit,
> despite being allowed to allocate from any node.

(OTOH, the caused OOM could select this task and bypass the hardwall. So
this should only expedite but no unblock the exit path.)

> Move the PF_EXITING check before __GFP_HARDWALL so that dying tasks
> can allocate memory from any node to exit quickly, even when cpusets
> are enabled.

This makes sense to me on its own (given other hardwall exemptions,
namely the commit c596d9f320aaf ("cpusets: allow TIF_MEMDIE threads to
allocate anywhere")).

Acked-by: Michal Koutn=FD <mkoutny@suse.com>


At first, I wondered whether this could happen on cpuset v2 -- it can --
because only per-cpuset hardwalling is absent but the generic logic for
GFP_USER allocations is still meant to be in place. Nevertheless, it
occured to me we can spare callback_lock in this function (a separate
chaneg for cpuset_current_node_allowed()):

--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4213,6 +4213,9 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_=
mask)
        if (current->flags & PF_EXITING) /* Let dying task have memory */
                return true;

+       if (is_in_v2_mode())
+               return true;
+
        /* Not hardwall and node outside mems_allowed: scan up cpusets */
        spin_lock_irqsave(&callback_lock, flags);

Regards,
Michal

--3chgs2uacfweczqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCafyGnBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AisYgEA2XwE8BxodpT847kFKFjP
5wujFu0d2aAwT/mq1EROxS4BAPD2z9mAVnY5ofEnOUjFsXuHoFYi/Uc5AW/BoRKX
GLUH
=9ABV
-----END PGP SIGNATURE-----

--3chgs2uacfweczqc--

