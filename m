Return-Path: <cgroups+bounces-5575-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5D59CF0A5
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 16:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E682927EA
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6051E25EE;
	Fri, 15 Nov 2024 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QX8gZbjc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2748F1BC062
	for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685520; cv=none; b=p933qVwKiaAnfEpEc37k7P0shwc933vGasu1rqHcyoboo6ixx1oDGjsrQxcvP77fJ94HD46Wtt1LT9HyTd17Sh9uaIonfH77AeCV20EsO+RAKQmNN450JJW2wSbjOT9pXpW/PsFA9a+YBL7OUo3bzIQdBb8Df5EjnybkkypSmqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685520; c=relaxed/simple;
	bh=E4Yw5ryHe0PrhE5czm7rq68DeL/gmavge9/tYmPeUV8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oktjWh0Evl5LVoyZNCeUGzAJiYzNs8yEMA2b3cEFmE7QQvoL/kOq2pdsOaQb/jbXHUb2wK0FBMlfmT3ey4ddUlFKBxfXI1zq+Lnj7K/LDn3u/hHDtjx7KFDToY9zXWooal1XjGlmjdGgRC5NslagPEw9Eh6xqPfD8SUEvZf7S5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QX8gZbjc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315eac969aso11510015e9.1
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 07:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731685516; x=1732290316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk9wmOqq7hEs06S/i7psCcBuRiEdEebWnDigzg/vB0A=;
        b=QX8gZbjcfTI4fRTptl0Xme2EJg/O/xfQjua7n4czhz8NH0AjmjNufh0vUV7NQFlxOP
         8J3n7MmahHeDhzsXK2j2k2F0lOJJ2NjIrPG+SZR8DCGMRmJ8jxJkFoZouMQhFhcrtcNM
         7Uxsv5jdQlvYkru3rbFbZa1WmcvtRnC0SeX6A+ur6uZNo47ZaT+0dxhjO1imevzkaZVB
         d9ds1H3YmE1/mfc2JSn84VzX13oSTOBZnJkm4g+HY+2YGcuiKxWLV1yyRTTWmpUs0YtW
         z4YuZXDPDWhpNXFM74ScGlkgGC9BcrInOSYmrf61TDwK9Qq3CbZ9uGRC68K/pVHZU4+5
         k0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685516; x=1732290316;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pk9wmOqq7hEs06S/i7psCcBuRiEdEebWnDigzg/vB0A=;
        b=DAfBkI0uYiZs0Oqq6DgGQ3MrK4vazGJMcJ7Yk0rrXiHANyubPXywlr6NHEVVDQtX40
         gjejYg5Vvic5cMqDeehKxkEFsx/6nkcDcShuZNSvOt901K9SqYuAmF2GXjqIDrlOeXYb
         nT5TH2CeCojR1w3g1HQjtu86TEMDJTuD2VFVSW5fc9Y/lI5g24AgiFhOkfazthXuDFkm
         uFgVl1yWcnNJJVcSIttV//dFgBQaF1rucu4eMMhCIx8X2IJ2Ae5uIjZ1PH3BUMSsbt+v
         6Mq4X1z07osEpS050Sla7dkWpDTvzkYRYaVG21TyPeOapD/S0YcCnzyXwlnRFgYDtc2i
         fbYg==
X-Forwarded-Encrypted: i=1; AJvYcCWQg4NvO8p9PntEC0EIhPdCivJ2Px1O9w0HoL/+7+z2uVIi8VoZhU1zOGqKwl+Ib1OARRPo7FyK@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6yeCMFgUYmbEVv/Y4wk+3JvsWNpCOFdFTpN/XG/V5EWLtnQh
	CefC0hN+vl7RqCs8HJa724iVccGUMXOL4E8s5/eRfyByBoGt8hPzYmaELylKnTo=
X-Google-Smtp-Source: AGHT+IGElxD9ib7l0S6lbbwc2dt0xd/js/k/6ZtUBBJhGIYiZ4ce5dK638MoQxq2lAfgctmVwxlunQ==
X-Received: by 2002:a05:600c:3143:b0:42f:84ec:3e0 with SMTP id 5b1f17b1804b1-432d974cb6cmr68540395e9.9.1731685516481;
        Fri, 15 Nov 2024 07:45:16 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da298760sm60751155e9.37.2024.11.15.07.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:45:16 -0800 (PST)
Date: Fri, 15 Nov 2024 16:45:14 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Costa Shulyupin <cshulyup@redhat.com>, 
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2 1/2] sched/isolation: Exclude dynamically isolated
 CPUs from housekeeping masks
Message-ID: <qicmttz6sqccty6jha7s22wi6bc2agps44qrqwhm4hhorcluyp@nl734io7qnl5>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aetgb2xgrhx7s33g"
Content-Disposition: inline
In-Reply-To: <20240821142312.236970-2-longman@redhat.com>


--aetgb2xgrhx7s33g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

I recently liked the idea of considering isolated CPUs a static (boot
time) resource and only use cpusets to place (or remove) sensitive
workload from those selected CPUs depending on current needs. (Yes, this
may not efficiently utilize the isolated CPUs when reserve them based on
maximum needs of a node.)


On Wed, Aug 21, 2024 at 10:23:11AM GMT, Waiman Long <longman@redhat.com> wrote:
> This patch is a step in that direction by making the housekeeping CPU
> mask APIs exclude the dynamically isolated CPUs when they are called
> at run time. The housekeeping CPU masks will fall back to the bootup
> default when all the dynamically isolated CPUs are released.

But when I look at it with the dynamism in mind, I would expect that
some API like housekeeping_setup_type(), i.e. modify the set of isolated
CPUs are requested and leave it up to the isolation implementation to
propagate any changes to respective subsystems. And return an error of
type contains a flag for which dynamism isn't implemented yet or not
possible.

The boot time value would only be the initial default, but the value
would be mutated by this API. There's IMO no need to revert to that.

(Also someone mentioned that this could share lots of code with CPU
offlining/onlining.)

> A new housekeeping_exlude_isolcpus() function is added which is to be
                     exclude

> called by the cpuset subsystem to provide a list of isolated CPUs to
> be excluded.


HTH,
Michal

(-Cc: lizefan.x@bytedance.com)

--aetgb2xgrhx7s33g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZzdshwAKCRAt3Wney77B
Sd0qAQD2l52rIB38nps0sK9brhxVkIbyhqlRK1QjwJX9NTSqBQD+LBN8lvCuOpg3
9D0DYsNYIq1yqMkBNTf6TbbIjKHUGQE=
=ev2j
-----END PGP SIGNATURE-----

--aetgb2xgrhx7s33g--

