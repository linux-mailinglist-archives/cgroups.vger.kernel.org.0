Return-Path: <cgroups+bounces-12614-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A5DCDA1B0
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 18:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20FD83002EAA
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 17:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB02F328B75;
	Tue, 23 Dec 2025 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fp7wZ3pT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997E42F999F
	for <cgroups@vger.kernel.org>; Tue, 23 Dec 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766510970; cv=none; b=FZexKE276Y6oh9vlD5Iqs7lQo2RA5vxTSpu8zRssUbHFsr2L7EJMQBuIDpa+GgtV2g+J0DOYgHN0W8qqn3QNnF3KQlg3DtjEjdpqjgL8mi4ohw5JrIiyBqYmqFDKp1SAaoE+xruDfXJkAe/1jDnKi4yhiQa/46Am41xFjAAyDnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766510970; c=relaxed/simple;
	bh=rggxtg0IlLrSbT39HtAN9OV5lK8TW333cTSRUbsopsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITsQxveMBHaKORSjjfQuInnomVfFcLT1SmnZL4BoR1S03kRBpNNLTtnEDv8gBMbP99Retf7B8QeFTmZ2HvK70JDYrRiAoyD6Ug8DptZh5fWDNS62q4vJmzGqajvRCzGIFDDb6Ngbrc/oS+ZPG7rvfqyIItJcV6Vb/C2LqugYtcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fp7wZ3pT; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so1177552966b.2
        for <cgroups@vger.kernel.org>; Tue, 23 Dec 2025 09:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766510967; x=1767115767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rggxtg0IlLrSbT39HtAN9OV5lK8TW333cTSRUbsopsA=;
        b=Fp7wZ3pT+v5e6Sap3H6ocMkJ7x5Yequv2ckWvtmskAo3+acbWeWG1hsLL+RCbGHvlW
         yoJhRg8sNs31jkloUMjgo3I764GZIX/G3NesNUunNi4PZ8sMDjYy7xSqNEHV0NR6dK9/
         qH8PqovnajA8is6M7MIN0LTI1j9VoamoUgxAMSScNijQefnsGpMm7v/YEqhKvOJzr1mR
         HdoMuY9D5d15WaQgmlurHncsXoba6iH5HddRCqX+YBL2Gi5YYpbxnCtXv0+2jyQ7s7SJ
         vc8xatJVcQ9WZmgtgzFIrEHzb4jotK4WoGjHWTPWxtwhqNIhHWjDMMgle7tmbLvXPsCv
         Vwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766510967; x=1767115767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rggxtg0IlLrSbT39HtAN9OV5lK8TW333cTSRUbsopsA=;
        b=PG2w6BonMGhE8uDTyYFFxE0buVtbtWz078olV2zFLuqNIKovfCjmqiIGsFRKdggObA
         H7OUlmjAZR3mXV8Hq0gGnaNVSAzGKXeZuCcFLCBl9fNvQv60qFU73OrESgGKhnZ/v3dD
         Q4no359PEasmForRyue02hagI7+M5N9AUIlUlHrEhChT19/4+ui2rxk6R1O2OLQdVtK5
         FVaMUurCwWqsjZgiTkCVf0zuf5/c8psErQ13pNXc6fc0BF963mWxlcNxyz6KxI5lglT+
         ZNkB4/jCqfIjQ/s2ruKp3fZQNJrgPpx8FQw0xmlqR2q7UGXnQWtEDWROQof6gvU2pFlr
         IqJg==
X-Forwarded-Encrypted: i=1; AJvYcCVS4B4hsVoR7OlgM0HJwvIN1v5PmdTc6EDx+4Th6jC/gX9LJfiYk2+wrDjJGKjqk540kJlSLKLm@vger.kernel.org
X-Gm-Message-State: AOJu0YxLrQRvdwj3O5uqGoWWxddyWFuBDRSvL7V2OSf4S1NQvDmfUZgj
	hVl64vE2NVUR8j5RpPok3MNf6e1zjjAUPjT2FVYoVIE+QjxW8GwY+dC00AjsouL9l3aKdQ/t9Ry
	Dnr0N
X-Gm-Gg: AY/fxX7MyC8pJtrxuutiP76bljBPfUce9ocdH6en29X/puo7AVnfv1zKHAWlli+w7FG
	G1qfpxE1FMqCwdnzOp9CCBh6HDtsp9mHZIEjGkeRRoXvBx9F8shzaWBmmnp4NMjlbHDxURm+f8R
	XgYbfTsisT74x+w3Z/IpByJ6wR0cu9ia8ls5e39zZsIx64DuMHz1Nojb/RFSHpvzxTYVP02Kz4x
	FFp77xCmynT4MZuMpA9yjLDhXibpnzPO3Vps/GaNBzyl68pGA3YDeCvM/D3EKZxjviLnuOUspOq
	wa2s8A28nMAhSD228mvjtcfJ2jwSikY0Eg/MNgKJW9I8fzHVliSF0ILqhwmsVd3Ky5oohmkam5o
	SHNpQSMu00qxMjItUi85BngHSsA0Mn1IR7iO9O7ZWbzNbaU6AKt8x+J25uRBlMH72BS/2/yEyZZ
	UTJcmW
X-Google-Smtp-Source: AGHT+IHrzD5xF9C8mM+mrol7ZlfgNgZPzixpqoCWEiRQ3zsznET1pBa+kJ1BKO2+znhmdH+ONgDsrw==
X-Received: by 2002:a17:907:e109:b0:b80:4030:1eca with SMTP id a640c23a62f3a-b804030298fmr1100189666b.2.1766510966837;
        Tue, 23 Dec 2025 09:29:26 -0800 (PST)
Received: from blackbook2 ([46.252.227.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ad1e6dsm1497428666b.21.2025.12.23.09.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:29:26 -0800 (PST)
Date: Tue, 23 Dec 2025 18:29:23 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] cgroup-v2/freezer: small improvements
Message-ID: <eamvrn5wbcdydffxfxitphfdfv3wec7wdsni3ykzvrammayndw@ecrksjfijhkh>
References: <20251223102124.738818-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223102124.738818-1-ptikhomirov@virtuozzo.com>

On Tue, Dec 23, 2025 at 06:20:06PM +0800, Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:
> First allows freezing cgroups with kthreads inside, we still won't
> freeze kthreads, we still ignore them, but at the same time we allow
> cgroup to report frozen when all other non-kthread tasks are frozen.

kthreads in non-root cgroups are kind of an antipattern.
For which kthreads you would like this change? (See for instance the
commit d96c77bd4eeba ("KVM: x86: switch hugepage recovery thread to
vhost_task") as a possible refactoring of such threads.)

> Second patch adds information into dmesg to identify processes which
> prevent cgroup from being frozen or just don't allow it to freeze fast
> enough.

I can see how this can be useful for debugging, however, it resembles
the existing CONFIG_DETECT_HUNG_TASK and its
kernel.hung_task_timeout_secs. Could that be used instead?

Thanks,
Michal

