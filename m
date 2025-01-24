Return-Path: <cgroups+bounces-6270-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD885A1B3A1
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 11:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904EA3AD0AE
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 10:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38E421ADD2;
	Fri, 24 Jan 2025 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U4+nbbQ6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E2521ADCB
	for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737715169; cv=none; b=aW86T8UReyzjy5kJTR1hV0UJkgcxWDPjC7rKaJHoEFOuiFAWtnSjMOeirAB4bVQ+LgExZwEC1eA4BxAKP5VjfUIumfZtsgJbHL5vvMPyAbSUK/HecpXUgIBN7F4j0jirs7VQSlGYbbx8H9E2rku/pBqThk6lQxSxaVOwNhAnJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737715169; c=relaxed/simple;
	bh=UT2slwg+3H7K/6HSej7fBwUmYKvcgi3W47s58DdvaTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLuXWCR8EI2xAxFWw/RZjuAbfU4nAnEd/ehVDPAO27Gy4L6hBpAT36Hd7l/07Es8i1Qvfju0tdB6RCE/BHsZ285VLKFi0SMgFEDsErRoec129zNYONM3tV0mb5mC664HADk1iFdnm/vdqTjdyOYO2psti7Jy7u6r8gF+5EgmNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U4+nbbQ6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso13551965e9.2
        for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 02:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737715166; x=1738319966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UT2slwg+3H7K/6HSej7fBwUmYKvcgi3W47s58DdvaTg=;
        b=U4+nbbQ6WP+Strtxug0Ysg6U2LI2ecM1Sk2YIXKpHjXEwXP7az+0YGNkSv0sLNo2ue
         ADQJWCumzJSS5QwA2+95CiJHbo8gUi1oqDBjfB0BBAP1ReDsSIj78pjztp209VAsyhV1
         tY7frsl58WmizOCsZN6GJmDxRc2IAgGFOagfzdbGUmXXV48ph2XfBQkCbhuxfJd18nvI
         RwCeZmzbjsDl75O5laFWcNWijMkoKxSv/yC/n/uFniST9zgFDXJ5khJhfKsozRVorG6W
         hl7QsnYMkr3hGcQ1W0JIciRAfeBTeaD+Y5YQmAq0dsy5sAbC6+MIlkbUtNI3cipHu+Sw
         dTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737715166; x=1738319966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UT2slwg+3H7K/6HSej7fBwUmYKvcgi3W47s58DdvaTg=;
        b=tX25yfJ9asJTX+uaAy1LWxrp+wmAREqH+ePq8eat9IC4ipAvWPG1+ffGDRI85lACZE
         Jvvfg4tc+efty5JEEm0W6J6u8DgnMF7vLdpxsot+c0rqcyN3q8OI3F1amEABKUXE71rX
         nBE0IT3dUbU+6dAzb96whCNLNr8T3RzS5qZ+dNsMSVheygpg6n9hSoQM20En96o72g9U
         SsNZsRlWQTz8fEl8XLGoOHAN24+oS+vnRE1rShz6NsfQPD4JFNIcna6ZVd117AuOsPY0
         ntrqfNjO5PTlpSyVYDgNMlo+GNYflwNo7QkIybN6MqAMrrYiWWrs9UJBZG4gY0JbEfct
         PU7g==
X-Forwarded-Encrypted: i=1; AJvYcCXMppq5pJkzXCbTQ7LLZA2mZ4tHoYjfE8ESH4EptxzWY0nXvKNtnjILnstZkYlcq3bUXWJoBl46@vger.kernel.org
X-Gm-Message-State: AOJu0Yw28qH204rfsUMAzFd2ZZYAY8ZScf5bk2WiXQWJ/PYN+BOTLlXO
	qQe0B/nP1Z/GwwUVDrHRxldh9l0CRZeI/zc8QDH0oNerlztoa5+nwXG+r8CM+b8=
X-Gm-Gg: ASbGnctW4tMehz8uKutghacQBlef5fp1PfvZ3RaQIxF6CuA9EjPfpMSxc+YRhIGV6Vj
	1qHuc+Af4zynB4DMdBeI1VtD1te5Dv5fnoxM/KCpSmG1aLJDtlTVP3zO6nxyHVadQil0UMzRLzu
	vUac+K9Xtm3DXHCn9xuIkuaMI2QtZdMra1rtYgePfcUs6gSdlOlFnNMpcSWDkYznS4vpYsCkKPI
	otE6Yu3ZtBMTT9gzFAozV7kXJFvdJGaUQt6oQUWzHbsLBrtbRhs1nkMgexNo277218qV+iYWd1p
	+50L+rA=
X-Google-Smtp-Source: AGHT+IHxVUpA6JnV0UM+ASUvrze0A4aDFlrUT4ekQ6eY/q9PI62J6bns7k5vlcjJjRBUja7ZL5TQWg==
X-Received: by 2002:a05:600c:1e8b:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-438913bf885mr288158065e9.4.1737715165891;
        Fri, 24 Jan 2025 02:39:25 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4d2a82sm21815685e9.36.2025.01.24.02.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 02:39:25 -0800 (PST)
Date: Fri, 24 Jan 2025 11:39:23 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Yury Norov <yury.norov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bitao Hu <yaoma@linux.alibaba.com>, Chen Ridong <chenridong@huawei.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] cgroup/rstat: Fix forceidle time in cpu.stat
Message-ID: <amw4ehhgqglvym6u4bkht2fcrxfzcwcyh4eeju3m3a3icnscxa@qx5ntsgw3y3c>
References: <20250123174713.25570-1-wuyun.abel@bytedance.com>
 <20250123174713.25570-2-wuyun.abel@bytedance.com>
 <cf5k7vmtqa2a5e6haxghvsolnydaczrz5n3bkluttmula5s35y@z35txmj4bxsb>
 <a7a24c05-87ca-49d1-9fa3-be4c3555e238@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cevqhc5nyjoojkeq"
Content-Disposition: inline
In-Reply-To: <a7a24c05-87ca-49d1-9fa3-be4c3555e238@bytedance.com>


--cevqhc5nyjoojkeq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/3] cgroup/rstat: Fix forceidle time in cpu.stat
MIME-Version: 1.0

On Fri, Jan 24, 2025 at 05:58:26PM +0800, Abel Wu <wuyun.abel@bytedance.com> wrote:
> The following hunk deleted the snapshot of cgrp->bstat.forceidle_sum:

But there's no such hunk in your PATCH 1/3 :-o

--cevqhc5nyjoojkeq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ5Nt2QAKCRAt3Wney77B
SdTZAP9x2+N8xJi+gkrAMqDzALVl5oGYN5nooXAL+KroNXDafAEAyQxKxbQrJGik
H1VmUbxZmYMwAyvgj+zPbanJFBuwAwg=
=odFv
-----END PGP SIGNATURE-----

--cevqhc5nyjoojkeq--

