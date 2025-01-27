Return-Path: <cgroups+bounces-6337-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E69A1D7D0
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 15:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A92F1886CF7
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 14:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1091FF1CC;
	Mon, 27 Jan 2025 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D3oKUK2r"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F593FC7
	for <cgroups@vger.kernel.org>; Mon, 27 Jan 2025 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737987008; cv=none; b=NWpB8gsBnIsNogx9edCUieBTeDyYAy3vzUaqVXe3GHAfC4Q97VlpA4MXhqRrTHChHEIx8Pp3NYKaahCwdDPfjKfgg790T3AVk2SHLvtWiD8oKXPnclsWZK/7tzliuFTVrLJKzctLSLvSm3ercEphhBo3hEJeZhBSjaUGrGr1NTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737987008; c=relaxed/simple;
	bh=KQRLfBaEDBa5jCtSAySQLmQF0Lj/tkM7lUCVd453Zkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tW/Jjwb4j4lzCTeDpc0UBsqShWERhfZ6flOo7GwH/J06Zj+/sojucDCOBpEEeA8mN5G6gLllpH9I4CMxd4CJ+caYkv+U9Av29JU6kJ6KTMeTYQnwE+XjIG3IbZ63JnLudaspeC694LiWAZv11eGZtPsnW0bHYgIXiET4Lis+ERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D3oKUK2r; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so46402235e9.1
        for <cgroups@vger.kernel.org>; Mon, 27 Jan 2025 06:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737987004; x=1738591804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tkD75Ts4CPh70YSx84KfjbKbYHVKyh5q/6VF+3rSAf8=;
        b=D3oKUK2rDm1K/OgyB2BKQvrSkEvIlVD8wof3zqAlJHVmyG92J/sDzPI3fCuEMpoXsU
         PPEUULTBGSkM3GK3yLp0tdOj2d/K1MdNJOka7GOdrKlD5xTdNgEyHDDt8bbLNU2BADfH
         GH+yrgoOX29CwCeEL1kYz9rmrvWv1AmjZ7NL57/If2L2qfapgEz0e9nOTZY2gUlc1tsP
         yqjFz3qFqXpr0PCmwWS+B9meWlhHOkSOmaZrUc7Gus96JfPTU2F3Re4thBKADbv104+0
         TNCiG0l7puEz6tWNur0n0M97bQxhJ3DwoEVI6RQSSqB9sci/yh5kDMvOUx406dYax4Bf
         /Uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737987004; x=1738591804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkD75Ts4CPh70YSx84KfjbKbYHVKyh5q/6VF+3rSAf8=;
        b=K6ZMqAfZksoYD5wYD6XLBzzf9nuLTbBhLy9STds7wId5XT+fA6IkGzdw9OV3IE6lLg
         Syi7HyOepp7Mq2Jw5W+W+kj3njjSKQ2xl9IksdH8veTpZweHVqd0U7ypod99zUjiZ6bN
         Aa7aNUQNKuFuLgcGCESWjKLlgOJLBcSxEhGLBIsBqx3v+0ZhHWKEBhU9HCFY5txQx58q
         cvUCQoOoQYUj9yvF9QbllLwi69K51SzRM20yq8J6bpWJJck+5fBXyVxun+BXK4oyGXb5
         3lAnmF0YvqT5k/29vmvxsxsgKjo/cPjLMu3ivkcI1wAQhD0Y+EooOF14vKLtwons/tpG
         TcCw==
X-Forwarded-Encrypted: i=1; AJvYcCU5YcVQLljgvvGUEcdV+3Kkm5HfUQN/kKJCliLJw/7FL+s6vbteUAdghAH7C3X6jXCrA/3AYHtr@vger.kernel.org
X-Gm-Message-State: AOJu0YyHA1dEI/0HT9TJeYqF1P03IV9kUH+ehQiI6P8RUn9ZrK+tfm2u
	SEBpM0XbsTN98Bta/9YJL/Z3O6Ix33/RRL3KZZMmsVPQvcir93480IkfIyYZPmI=
X-Gm-Gg: ASbGnctChw/sMvTApENmOD0WtdKZiiHMDUiiM+VK42pkSoUSf4UNSd8G9TVzWxIgBJo
	pta3exOUp5QHPwJsrpwJwuZJ7wDJprpJD0qDgo1YiJR8CyKyITY1qro/Z1UuiPJbJ17Z1OBiyyu
	voasBa/xWHK1OWODf9ZjGiJCef4oJXI7GePxiJ4rwGh/dFflauT6N/mgHIElIi7kDmS/6Sj/B6S
	oXT85L7RUBrhu0oJk8CrA6J+/KwE1gAPr/CXLLJZjLlLyLX0FAWJOqGaz9e2DOjUmca1VVZYbau
	Xcetvdw=
X-Google-Smtp-Source: AGHT+IGECP4URarMDrxhpRYgKkpXhOXF8KDgFDwNQc1Cm1K+dMcdFOzgVRq5fGtHk3WsEYeGYOMf5A==
X-Received: by 2002:a05:600c:524c:b0:432:7c08:d0ff with SMTP id 5b1f17b1804b1-4389143768fmr367657635e9.23.1737987004313;
        Mon, 27 Jan 2025 06:10:04 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c3fedsm10949249f8f.85.2025.01.27.06.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 06:10:03 -0800 (PST)
Date: Mon, 27 Jan 2025 15:10:02 +0100
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
Subject: Re: [PATCH v2 3/3] cgroup/rstat: Add run_delay accounting for cgroups
Message-ID: <3wqaz6jb74i2cdtvkv4isvhapiiqukyicuol76s66xwixlaz3c@qr6bva3wbxkx>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
 <20250125052521.19487-4-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pp2a2dbhnvcuqeeg"
Content-Disposition: inline
In-Reply-To: <20250125052521.19487-4-wuyun.abel@bytedance.com>


--pp2a2dbhnvcuqeeg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/3] cgroup/rstat: Add run_delay accounting for cgroups
MIME-Version: 1.0

Hello.

On Sat, Jan 25, 2025 at 01:25:12PM +0800, Abel Wu <wuyun.abel@bytedance.com=
> wrote:
> The per-task and per-cpu accounting have already been tracked by
> t->sched_info.run_delay and rq->rq_sched_info.run_delay respectively.
> Extends this to also include cgroups.
>=20
> The PSI indicator, "some" of cpu.pressure, loses the insight into how
> severely that cgroup is stalled. Say 100 tasks or just 1 task that gets
> stalled at a certain point will show no difference in "some" pressure.
> IOW "some" is a flat value that not weighted by the severity (e.g. # of
> tasks).

IIUC below are three examples of when "some" tasks are waiting for CPU:

a)
  t1 |----|
  t2 |xx--|

b)
  t1 |----|
  t2 |x---|
  t3 |-x--|

c)
  t1 |----|
  t2 |xx--|
  t3 |xx--|

(- means runnable on CPU, x means runnable waiting on RQ)

Which pair from a), b), c) is indistinguishable via PSI? (Or can you
please add your illustrative example?)
And how do per-cgroup run_delay distinguishe those?


Thanks,
Michal

--pp2a2dbhnvcuqeeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ5eTtwAKCRAt3Wney77B
SbcsAQCPV6LsTHPe6Ijw1sdNdZ2nksChYzapP7009NoaOGncxAD/SVqdXU2faOw1
BwrbEVQvfgmZAhRNkdzD9zYBlryolAA=
=sqDX
-----END PGP SIGNATURE-----

--pp2a2dbhnvcuqeeg--

