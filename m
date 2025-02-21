Return-Path: <cgroups+bounces-6636-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ADAA3F900
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2025 16:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43546174831
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2025 15:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9392C1BBBF7;
	Fri, 21 Feb 2025 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e+Igh1Dq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2198632E
	for <cgroups@vger.kernel.org>; Fri, 21 Feb 2025 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152168; cv=none; b=e92h35gBo0bLYLF1DrofpfNORJ+1vL4fbe8dettNNaPc/OOKOaHMWmnL7OvPlsjhewjv57LWfiD6m+pVZVPWusx+u+SCWff+phjoXXcxgvW6UTU8W5Em8uwKY8wsloLxE7QmNEVAPNPezHjJV6O2tWzb0ZfImD1Hm2Q9Ms/KZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152168; c=relaxed/simple;
	bh=DLSCqwpXg5JE6IlskrkJzVCf92FiqmwfRs7ztERMGUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLzvTBBZYhJFMk46W48ZS/d6grZbJ86tPkIF4D7giHgku6oEKPLq/GGLaL5qKJSMj4Fn7hCwaiVDD3iLKCGCeTtkAxvWPFmU6Z3fFgrpz1ParIQ2A5cpFZ8crKMVem/Eq/mYKoOQ/FUgCRDz/+bpEDc9V1I3AyFkujxQkxO6DtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e+Igh1Dq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab78e6edb99so316927566b.2
        for <cgroups@vger.kernel.org>; Fri, 21 Feb 2025 07:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740152164; x=1740756964; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d5l4zz1sMG3mtHShUobc7HnHdYCuofJA4lkceeZVq4Q=;
        b=e+Igh1DqcIbm68dfARHdNcNudZxqDaUKqDGxFMO0zyGqpyk/J4UESGPSEMbnN3hqA+
         7QHCT/7WZ6kro64SZYZTLv5OjSK00DLComj7HkCFPuHLwCLelGZTF9cZfo1CueKtAaqP
         OH/QXaiUl2j3mmTjJJtkwEP96dhDMrfHQon8e55Y0Fz7aaORZvOOfzaqd0yWsiRhohqm
         MY4UaFN0kr0YBSFFwtkQcPTfnsoOjBs08FxgzhMX06NM47IZlaLQWz1jHgRt1j8fOus2
         znrBmtuhdczwZOLbgw3/UmwSvYWSrYDthjYKlgKQiyPoDD5lrI+eZYHUFiOf2uqeowe9
         B2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740152164; x=1740756964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5l4zz1sMG3mtHShUobc7HnHdYCuofJA4lkceeZVq4Q=;
        b=p2D7/Hi/kXkpznOXBfpqDEgjr8QnjVAewyWCCuFAUiyLh9u4MZrRl2z2QSa1njgIkk
         VT+e/2PZZrcVITzjnHZciB0iHsZIDuP1tos/bzhkaii9iQ0ity/fhAKn4U2kopv4PWJ1
         PgQFYSqdvJd0iRwaFElId0uQcP18Bn0GXSTwdIHmVcAyWVYwAqk+nUb5fpoQpcWJXMjC
         3954qOR+qeQU9ptq9iwoHqjqBWxHDC3gYFVLOQ+EYXbEkUWrLcNSig28/GNEGwiCrb3i
         jxkn4t19LYCrj9h0tG/Iyux/KR1xrhPB9/f8BxuO0Q72Y1GY1uzxuCc4eZhm/joz4IdX
         MzuA==
X-Forwarded-Encrypted: i=1; AJvYcCWLSclkmxOj0j/+IUTGctZK2e6gtVUCzk90Bl9TBVN0JErtmr3H2oiinT2mZqs5T2N4e+/Vd5fG@vger.kernel.org
X-Gm-Message-State: AOJu0YzUY0Yl6srtOiQjMEnOuvGKbOlVoocS6Pu6pWON3WfDoeDdYOz6
	E3ZsF2HUACGwdS5MKn0MPCJHe+nFj690KMJesw6pDsbUyPZES+TgWflnN5jqrVA=
X-Gm-Gg: ASbGnctel5UDBgJg/fbVnFMcYkEzFqz/AVmO4t4xUM09/bNu3WEBLiFlTxgeohwpCvg
	CPiG37RrE2azKRtI4FB1Vf+fBW/556bfZpcoRWMhMeAVwiT9zIrpsVNLsQeGBabzPUzqu2nKQcU
	5f7jt7Q+FcQbZZBss+EeuUO8+uRU6ImZZdPryq4pOeoRrx3HwgIUrOCeRWC8wtL1fHZXjAnUHsA
	elGZXrH+BaKrTPVod/h8q36DGpPhOkcFLn5daMEQdI/rGplafqk7GRxrHlgMJzyyX3SiFqY8T1j
	DbRcJPZgwJWDnaJeqpTh8C8drYm0
X-Google-Smtp-Source: AGHT+IE7R4MDw76EG5se1usjek3sk3eePWqQqCBEriY44mGinrtsqBn3iUcohkd9RyhQa0/COxWmNA==
X-Received: by 2002:a17:906:c142:b0:ab7:5cc9:66fc with SMTP id a640c23a62f3a-abc09e46652mr372546066b.50.1740152164419;
        Fri, 21 Feb 2025 07:36:04 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323225fsm1661890566b.24.2025.02.21.07.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:36:04 -0800 (PST)
Date: Fri, 21 Feb 2025 16:36:02 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>, Abel Wu <wuyun.abel@bytedance.com>, 
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
Message-ID: <m3og4sktkzf6j62terh4xcbfiw45ziymhmt7x7iuyzcogl67cy@ufqvgzttd2n7>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
 <20250125052521.19487-4-wuyun.abel@bytedance.com>
 <3wqaz6jb74i2cdtvkv4isvhapiiqukyicuol76s66xwixlaz3c@qr6bva3wbxkx>
 <9515c474-366d-4692-91a7-a4c1a5fc18db@bytedance.com>
 <qt3qdbvmrqtbceeogo32bw2b7v5otc3q6gfh7vgsk4vrydcgix@33hepjadeyjb>
 <Z6onPMIxS0ixXxj9@slm.duckdns.org>
 <20250210182545.GA2484@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210182545.GA2484@cmpxchg.org>

On Mon, Feb 10, 2025 at 01:25:45PM -0500, Johannes Weiner <hannes@cmpxchg.org> wrote:
> Yes, a more detailed description of the usecase would be helpful.
> 
> I'm not exactly sure how the sum of wait times in a cgroup would be
> used to gauge load without taking available concurrency into account.
> One second of aggregate wait time means something very different if
> you have 200 cpus compared to if you have 2.
> 
> This is precisely what psi tries to capture. "Some" does provide group
> loading information in a sense, but it's a
>
> ratio over available concurrency,

This comes as a surprise to me (I originally assumed it's only
time(some)/time(interval)).
But I confirm that after actually looking at the avg* values it is over
nr_tasks.
If the value is already normalized by nr_tasks, I'm seeing less of a
benefit of Σ run_delay.

> and currently capped at 100%. I.e.  if you have N cpus, 100% some is
> "at least N threads waiting at all times." There is a gradient below
> that, but not above.

Is this a typo? (s/some/full/ or s/at least N/at least 1/)

(Actually, if I correct my thinking with the nr_tasks normalization,
then your statement makes sense. OTOH, what is the difference betwen
'full' and 'some' at 100%?)

Also I played a bit.

cat >/root/cpu_n.sh <<EOD
#!/bin/bash

worker() {
	echo "$BASHPID: starting on $1"
	taskset -c -p $i $BASHPID
	while true ; do
		true
	done
}

for i in $(seq ${1:-1}) ; do
	worker $i &
	pids+=($!)
done

echo pids: ${pids[*]}
wait
EOD

systemd-run -u test.service /root/cpu_n.sh 2
# test.service/cpu.pressure:some is ~0

systemd-run -u pressure.service /root/cpu_n.sh 1
# test.service/cpu.pressure:some settles at ~25%, cpu1 is free, cpu2 half
# test.service/cpu.pressure:full settles at ~25% too(?!), I'd expect 0
                                            ^^^^^^^^^^^^

(kernel v6.13)

# pressure.service/cpu.pressure:some settles at ~50%, makes sense
# pressure.service/cpu.pressure:full settles at ~50%, makes sense

Thanks,
Michal

