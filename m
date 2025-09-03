Return-Path: <cgroups+bounces-9684-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D41CB42A70
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 22:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303E77C1D7B
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 20:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52C6238D22;
	Wed,  3 Sep 2025 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fqwGohOU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9052C21ED
	for <cgroups@vger.kernel.org>; Wed,  3 Sep 2025 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929825; cv=none; b=rb4527krEj/HfxK5CIp4jd7FKDcttXJBB1nQnJyn2OvOcW2BXdJf6JcXygKINJ8kdDlIRDRWSd5yOdyPVgoTY3UZvzdvp95dArDI/Qyh22ZCYDKs+dTnqr4m4DledpcV16z2nXJWdac26zbAw7tKHiG4/ZtUTp44op3S1RgRmE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929825; c=relaxed/simple;
	bh=LEw0rUqvztDs6fWEAKN1HbztMCvJ4JbkrVUUKE8Df6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbN2ewPMmdTpZ0/RAEwGCEHKOle1dlAKyd4oOHXC8UXzT0wmueE6+9mJRldDggEFzb/tSk3rNLq4EH/9W/xbyGV1rSlhVRWayHvlRePp4DmIWmh+G4yG2EniEnTC6kO/REVJ5dIGD7cfnsva/h4+PT7m2AjYd5foKMW/OGl2SUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fqwGohOU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so228560f8f.3
        for <cgroups@vger.kernel.org>; Wed, 03 Sep 2025 13:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756929821; x=1757534621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LEw0rUqvztDs6fWEAKN1HbztMCvJ4JbkrVUUKE8Df6U=;
        b=fqwGohOU84TjA6olsUXAftCxqWOTBOh0Yqt9GPOuaNzdJYdBN0gWl484RocwLMO0j/
         8p3Y+okGamzxjZw+1EU7kXlC/up61QFJV/fhoGIS/qHl1kurky6BwnQEjbsf1DzFtOTV
         zz90y4gkxVCcSfOPLFmqYM2iBgZ+beZPHvqz0r7YFFldtrmq40+qhcCGt2i9NEsLxYM0
         uE75WOzTCWRynUJ3yjXrRa1rWtzSNkWpPTlW0s5qHHCvmQDM1Fa0JcDoqo0JPPAe4qub
         /a6VwYT+oWA1Bb5sc60J4L4f1gnVkHGyFqitzsyqfwSQi0LpLqQH1DMfTNKkGVA6vHVB
         e30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756929821; x=1757534621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEw0rUqvztDs6fWEAKN1HbztMCvJ4JbkrVUUKE8Df6U=;
        b=FuUOdP+Vly724n9yVdQDyLfsZYn/z7GZqiM9Zm0xb+nh8TQHVaX7jmakbsocjSlQLQ
         y0WnJ8AN0tCfEHwmZBfpUa74dLyogRBPLhGp/CNm5aNSUlRl2GlMYY6VnqgjznuA6Izy
         N/BYLVZTOLHaSAULhyirNRdDDllWqf+wAwg3Olu8vwta8DyF5pT94bZ835jgPyqzce+X
         6azcDxCut/F6ILAG+LxyiFYyoK2Z+TdkFH8NvbPpgCZpTqeRJfXDq5r5meRJhEtZGWFd
         xwI2s/AxTJCVM0YrvJZv9Yhci/ttkJshFZeqW4yPG7b1Zp0isIQqMdroxV5+O4UZqlwh
         DdSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUanVVWmcIseEMU+XxSF0mPAqqgq/wKxzNLXpBJ9sweTgDN3oW0M/Janae458+nl2iWCBWhJ2J@vger.kernel.org
X-Gm-Message-State: AOJu0YwdGDpE0A/WOQoR9Q6g/3CyNafhF5IiGMSk36sO3ToyypAEvf2k
	IAis8IHMATcRME9SBkO59X5pUdN/cqrJtEvWcidnTRhZA5HTlyumcX582iJAo2xZEg7JkTFwXPI
	g37Th
X-Gm-Gg: ASbGncttTZLGdGu4kyoWshZ7Kk2DH5gRhNiyREPXHwikiusU7fsKUSAvPmYMA3kNIWe
	0cxmOcwI9rtowOnapcaZZyzajL2pvodcGObbuOvl9kGsUx0m/QOmND2BjU3b/KGNl9eL79rQ7TP
	SqV3Q8XmlzNYuESd2iRnk4+4pUCplnqYgmW3pYIo8hE3Id05D52kRdW5BuCiT2Spmx5IqHLAlnm
	cnRu2nE77JvOantJAzE1s257o+wsbApLpkyBN/JBMhe33GpbnOjc/K/YbSTZlEiYjmYstFoTp03
	53bBzZW7ggq8JMeLhhu/6ntQpMLk0a4ZDtTXy3t0GwslAuP7pMAA1KbJpJseUd9BCJKOG8uQPzH
	m5jxYfn1DyD2oPZD31P2rivAB+Cd3N/bNT4koFoy/nJ8=
X-Google-Smtp-Source: AGHT+IGg+JstV09+BBhCR+jpyW8+OPMUmGLvbFtUU8chxe8j6dOKXLS9Tpc0uZSo5i8tFiJJFc2zhA==
X-Received: by 2002:a5d:588a:0:b0:3df:f7d1:f8ae with SMTP id ffacd0b85a97d-3dff7d1faf1mr1259216f8f.4.1756929821348;
        Wed, 03 Sep 2025 13:03:41 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fbd01sm25235180f8f.13.2025.09.03.13.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 13:03:41 -0700 (PDT)
Date: Wed, 3 Sep 2025 22:03:39 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Yi Tao <escape@linux.alibaba.com>, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
Message-ID: <rgjlqyeqcgi43crx4mqpwi7tqxqgy7bkmjbpv7t6eiqodreydm@6pag34zcnekp>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <aLhykIPSGV1k_OG0@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ezugp5sztup6n22u"
Content-Disposition: inline
In-Reply-To: <aLhykIPSGV1k_OG0@slm.duckdns.org>


--ezugp5sztup6n22u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
MIME-Version: 1.0

On Wed, Sep 03, 2025 at 06:53:36AM -1000, Tejun Heo <tj@kernel.org> wrote:
> If you use CLONE_INTO_CGROUP, cgroup migration doesn't just become cold. It
> disappears completely and CLONE_INTO_CGROUP doesn't need any global locks
> from cgroup side.

CLONE_INTO_CGROUP uses cgroup_mutex and threadgroup rwsem like regular
migration, no? Its effect is atomicity wrt clone.
Or, Tejum, what do you mean that it disappears? (I think we cannot give
up cgroup_mutex as it ensures synchronization of possible parent's
migration.)

Michal

--ezugp5sztup6n22u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLifERsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgXGgEA/QhZPlQI4Z+oxARZ/+pk
w+grIHs60GbHyuYkeC5OC20A/1j+eeXMuRgwkj/f1FEMguK4al7BSvI9U7WrpBWg
zIoA
=77fs
-----END PGP SIGNATURE-----

--ezugp5sztup6n22u--

