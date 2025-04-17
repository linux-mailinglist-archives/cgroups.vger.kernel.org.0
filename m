Return-Path: <cgroups+bounces-7611-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533E8A91BB5
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 14:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678283B0F72
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 12:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0A9240604;
	Thu, 17 Apr 2025 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QY6588nP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0FD233126
	for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892012; cv=none; b=IOVu+qOq8/8UExeIVgvzxLZMETiqyv+UVEH67D3cjbSRUETSB/n1DAkyMRZMLQNVuC999RlHN967sQMurC3xD1ahHSfgXwrfN8eDdkIs19f184Xewe7CuXSBZmooyhLpeumPAq5iYHg/pU4bG24MJCxjl4QhNbXALgSBZlrpNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892012; c=relaxed/simple;
	bh=lEso+tP9DMfItOz6/cUYaHOT59nTEkHn5AJ0F7V2euI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVCDMNObf+iYkOewQ2cd/xP94mb4kWpDbNNDrNCSIsHFhvVA0SdLHyp15kxuVpIW+kvOf3Lo9BNtvJACjpgGTQik+bQcRPY0QWbJbon8EA9AuOHT77K2539tCodFVR6hh2244Oj79b5iwt6tmfY0xtW3dJuYzSOk4RSBGZbZJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QY6588nP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso404136f8f.2
        for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 05:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744892008; x=1745496808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XwwwJQjRzixrZdNswPn1ZA0lqwm9eOl4vv52O8RBkKY=;
        b=QY6588nPrB/+2lN+cY1ntktz71FFv4ffBANlY58fpqF8660iBthroDrE58QqGK1niL
         x/tbhDyTfU05GgjlGSiHW3R/oHHp6QkBlHbmTIaF/He+5ctvyzrXMapM7uneK26U3lJx
         REjgDtQLX4f+V44ni3+kEPYmpB1jMM2ejt1vTkUjlib4Bh1iXkd8hBxAAOimAQpFBoWr
         HAh+/QL7S8kq4qlxNaVf58OTZq945bHq5lJ5RMtmTcr1xOfz5ogqK2qmo1LsZFK5vOVz
         BLjLFNSHRmfK7oOufJfdijP79BVL6ONN+yZuFObViybVf4LYD/KdcgKm8Xahws0qUM7A
         OZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744892008; x=1745496808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwwwJQjRzixrZdNswPn1ZA0lqwm9eOl4vv52O8RBkKY=;
        b=Mzkdz+HP6wegqps0N/hIkoA/dLhmL5RRA3CBe4EHVFGU0jHPvfPmrqi9MOzEEoY7jE
         YJv6635w4cg1dokL/czfkekU6VzVsNaQFoMIcBGDvVgGXIbwYnw6DiqcE2fPcPtJ4DjO
         +htLCeRhYCFM4Sl9mEhTzapfq9Nkku3i93pwFg24SVLo7rrJvabnC9BEtHtjQGpqY6WX
         krXjvl04mmjyfpeycJc0MnBwR1ECBiyjn6E/Qbbbirz0RpEJUzff6VhQf42G2KUtGC+i
         BxHRa/OQsh6fcZ43Qwm4nOlYzwlaTuLyOOvTJWR9aLZshqsvklQ7nM6iGt0g6nRRgddZ
         s4Rw==
X-Forwarded-Encrypted: i=1; AJvYcCV/NFyIt4+RjRswr/cQiWjZZx9Yxh+16Rs5Bo4ghYBbyz5q2Te9OWfvqulIGmezcQX7Nc6L6Qw7@vger.kernel.org
X-Gm-Message-State: AOJu0YzeOP2GGSZ4HGJCTVLnEX/xdf6xoZ6GUjlF1KyV85fT+wkjb7bZ
	b+Etp6Zn6Yru8OEL82oPoqI7caAtEoDPQxzaCq+aL+BcyVI4Hu4VrvWDgTPGaP8=
X-Gm-Gg: ASbGnctNyWUSaOqf2PEWmKjtw7KKuQC6o0d2fOH0oamoj8EX+TD1jTUmYVrvgImEpZ4
	hqAM99XhekBfwTJjS7O3xvSHoiizTSCmQ2js2fjikrxST+Ni15gDighT+3Sop5coXy3yGpR1EuO
	V7pgdvxb+6YQKUZC55ACPovzvCCnxviYGBENHjA/uDQs9u8FNlcg8d2agSkBDaAwM8mMydT+MX2
	ZyGtuW3vcnmmIqYCV22lMX/QJKsvUVKLYuTk3jPChG99NVSpr40f0D2kxXtS+iW2TBG4CLoGrsH
	Ee6AOfQD9XuoK+B+VBpTiw7DujixOfXRMvELpqIIPgU=
X-Google-Smtp-Source: AGHT+IHxuOS3fOIpeSg2ZQzBVBzTG6yxBBL0V6EGPuazSqxHnz3g+H+9mAg1G+Wi3MNm7dm9CPQRQw==
X-Received: by 2002:a05:6000:4586:b0:39c:30d8:ef9c with SMTP id ffacd0b85a97d-39ee5b19f94mr3979472f8f.24.1744892008153;
        Thu, 17 Apr 2025 05:13:28 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf44572csm20694445f8f.90.2025.04.17.05.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:13:27 -0700 (PDT)
Date: Thu, 17 Apr 2025 14:13:25 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Frederic Weisbecker <fweisbecker@suse.com>
Subject: Re: [PATCH v2 10/10] sched: Add deprecation warning for users of
 RT_GROUP_SCHED
Message-ID: <3sfn3j2l7wmsstzmtkxa7cyz4w3hmkdqya7nhdwrqlvfosoixv@q5wu2xluuwxf>
References: <20250310170442.504716-1-mkoutny@suse.com>
 <20250310170442.504716-11-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gg5h43zosnhgapna"
Content-Disposition: inline
In-Reply-To: <20250310170442.504716-11-mkoutny@suse.com>


--gg5h43zosnhgapna
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 10/10] sched: Add deprecation warning for users of
 RT_GROUP_SCHED
MIME-Version: 1.0

Hello.

On Mon, Mar 10, 2025 at 06:04:42PM +0100, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
=2E..
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
=2E..
>  static int cpu_rt_runtime_write(struct cgroup_subsys_state *css,
>                                 struct cftype *cft, s64 val)
> {
> +	pr_warn_once("RT_GROUP throttling is deprecated, use global sched_rt_ru=
ntime_us and deadline tasks.\n");

I just noticed that this patch isn't picked together with the rest of
the series in tip/sched/core.
Did it slip through the cracks (as the last one) or is that intentional
for some reason?

Thanks,
Michal

--gg5h43zosnhgapna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaADwYwAKCRAt3Wney77B
SVbpAP9a18ps1Mlop2Kvui9Ou5OH961COs9cP3fAdWToTBZ5qAD/ZRiZn4x+NNy6
/Ijz8wkaCGsedh894qkf7S5ruXmZpw8=
=82a+
-----END PGP SIGNATURE-----

--gg5h43zosnhgapna--

