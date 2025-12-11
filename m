Return-Path: <cgroups+bounces-12337-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1AFCB5941
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 11:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 207F130019DC
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14889301030;
	Thu, 11 Dec 2025 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S87Qr1jl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FAF2773FE
	for <cgroups@vger.kernel.org>; Thu, 11 Dec 2025 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765450772; cv=none; b=lO/pmynMT2yaJcvNBYG1YbGWVaWobtbe+9h79rbmSKAvww8tNclywnTkB8coDTIaKTUGin8UVhjgridNuCX74N/JT3TAVXlkjZ+UFOv7Wpa07JrK2lp5qD3yBHo6IAInqp2FojWyiTF7qnrh/RaAbKh09G0eHzNBecpV8Gk7Jic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765450772; c=relaxed/simple;
	bh=OR2SUvkE39mGahfBdaZHgumGWqttTMBM94UMba5cEGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nns29aaJ2saKzsYljV21GonYb0lqDZj2Anboci1vc6UBiNQyqgQbaCzpKOtCUk8I8ccv//jxsSIkKwzsSLxNBL05Fz+/EQSRH7aIzwi3pa9g8uO2LxxWnaKIyR7nMW+MwbRbluXR6+RCRy9wgiCkdYfidWgw2d87IVTCTLXVfFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S87Qr1jl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42e2ce8681eso517784f8f.0
        for <cgroups@vger.kernel.org>; Thu, 11 Dec 2025 02:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765450769; x=1766055569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OR2SUvkE39mGahfBdaZHgumGWqttTMBM94UMba5cEGg=;
        b=S87Qr1jlec/3pyKFQL9bwWOQkTT1wxZsAQLf4xOuIHuuglodvjpv6mltihDbsUKdl1
         d120e+SPFOv+iFXBOh2Xb8z7b+eDKWOzPPjlQelbiC7E8gODcRr4gkmpJ3C1foMk6O30
         23aaL0BcJUruvIcXVgf2iez6nmsJXEWq6OGcyIzjr5Okr3e50TWa9BGjAI/b8eXYf4hn
         6dWNazaoZ1/RdhtoM145hFsd+fi1468DsntPewMLdGzg7B8O2ubyZlmQeVMjJF+MynW7
         8brisp3FDBkSoE4i3aHDuO6ihFEXvL3LOwfMucR/FRMbVT9oHS6gAp/L7A5yh+BejGKD
         Ga+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765450769; x=1766055569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OR2SUvkE39mGahfBdaZHgumGWqttTMBM94UMba5cEGg=;
        b=MDmDQfU0++xK3OQqfLv5zzlc3LC7VHhrVsGwULvj6n/g4Am2M7CmH4aCVOmdollJrP
         oAqHnumvsbeevnICTaN2J0VbgaSHk1NF/YJCnIsAvNH/pPX8PSKsq6B/nrQCu0BXaL4W
         GMft5MSZ6mCqoLBsKAdVX3xj2FFV0JVxBtUU9J4tCrVEas0gdn/f+gmai5yJToiN4SfA
         36V5dNQU9IDCFO5ni5C1t1S/PvKcRLGCOTsBscxOhCXZPg15x4PW1RwxEN7wmNLy6Wb+
         wVsWCJfZDaoUA5GKBluIaSTdZtvZpoPcwGWAHHJsIvrgSjJcowx5Ee/jTj8QAyFhKjpz
         nwtA==
X-Gm-Message-State: AOJu0YyaenhSdU4D3VzFEYS2N6RpmAR80Dtsw2oZM+KdGo3mrYWRZuko
	Ip0v9egW/2l1KDuSS3dNjGFArsJtKwRIuMo1QLCJkmh0PpMVy4bOOGwq0jyOvbI0Gf8=
X-Gm-Gg: AY/fxX6YqUsKbvMCi7Kst8mtPtj/evdRMhW7WOeh/1SKgHK9NkqrV2Iw0cO8aooZQy4
	+x1xIhCn7Ms038nexgBmD77J0X75yPrXoygMWjH6aA/Iea+fM1MK/RK2XBgbPDgo8+kOeS3/55K
	ZwfAH8+m3pwBgSwKMzkyyz1F0SESbY3TJu7uxXaOsJ+ralTbYneW7W1udUO+sEA3liQP7nrj0xy
	d0Sf+2edEbe3pZ6og2KnAXYBfv5SoBTqDy/abC/3yRJF3dn2N2oYvMYhG0+k6S22fF1pTkaWx/W
	Q+/DqQwJoZXIlXB2UWuzzcGuHmVoNQ/wfC863fnAx1flat4MEof77wEyH60Tr3eiwlDXIMAxS8J
	GyIbHIVdi2/Bf824DHNCWPT0sWqLSrqduTY10w/xg7Jx22mUXjV6vpTnyYHEX6Rh8aOPAgEul8J
	ysSHoF754Kx0LFc33kMMR3bUVuRPwT3RI=
X-Google-Smtp-Source: AGHT+IElxuz1/bTQLy/0cWVW28q9/npQ2QBgwkAFmGpoBGs1i00zm7N9I+fkoLidNO861vpqoM/X5Q==
X-Received: by 2002:a05:6000:2509:b0:42b:41dc:1b61 with SMTP id ffacd0b85a97d-42fa3af7d51mr5942608f8f.35.1765450769201;
        Thu, 11 Dec 2025 02:59:29 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b9b750sm4792704f8f.42.2025.12.11.02.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 02:59:28 -0800 (PST)
Date: Thu, 11 Dec 2025 11:59:27 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: cgroups@vger.kernel.org, chenridong@huaweicloud.com, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	llong@redhat.com, shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
Message-ID: <in2stxqa2swky4zwzlrm4h5vuz627ruedhq6zqr22xqwv5di7c@vcwc3z2sczx4>
References: <b3umm7mcucmztqqnp6x4e6ichqcml2r2bg7d2xairxajyqrzbt@3nshatmt2evo>
 <20251210101108.969603-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="afui5iqoqigvmlf2"
Content-Disposition: inline
In-Reply-To: <20251210101108.969603-1-sunshaojie@kylinos.cn>


--afui5iqoqigvmlf2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
MIME-Version: 1.0

On Wed, Dec 10, 2025 at 06:11:08PM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
> Regardless of whether A1 through A5 belong to the same user or different
> users, arbitration conflicts between sibling nodes can still occur (e.g.,
> due to user misconfiguration). The key question is: when such a conflict
> arises, should all sibling nodes be invalidated, or only the node that
> triggered the conflict?

Any serious [1] affinity users should watch for cpuset.cpus.partition
already (since it can be invalidated by hotplug or IMO more probable
ancestor re-configuration). Do you agree?

Then I'd say it's reasonable to invalidate all (same reasoning -- it
doesn't matter on the order in which siblings are configured, I consider
local partitions). What would you see as the upsides of invalidating
only the last offender (under the assumption above about watching)?

Thanks,
Michal

[1] The others may make use of the proposed cpu.max.concurrency [2]
[2] https://lpc.events/event/18/contributions/1978/


--afui5iqoqigvmlf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaTqkDRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiprQEAr1ThSDOLEr1kSXQnDyes
WlVu/BAmdv4fFacLcZvPWVMBAKSU5cJlMmcsNEV4epuZr6dpVs5BFraFguJjSTSA
qC4J
=lO4i
-----END PGP SIGNATURE-----

--afui5iqoqigvmlf2--

