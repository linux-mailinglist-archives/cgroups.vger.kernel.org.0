Return-Path: <cgroups+bounces-6893-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D615FA56BB2
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 16:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCE13B11ED
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618C4221D86;
	Fri,  7 Mar 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcvQEUbG"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B221CC6A
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360591; cv=none; b=mh22SkL7mU7eg85fS+CUhquzh40HB22H+JSAzTm68V/6nWlhqjf6ki/PJHURd1XMJMCokmNLOW4RSY09sbqIueUxP15Xz8MLuxVqF1Ru5az6K8UeFpCWs0cB6epaSmRgqJugp4azbulj0c7b3lRrQ2uvStfykDAiw8wCiDgsdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360591; c=relaxed/simple;
	bh=bBxbz03qAUVHviMss484CFNq9Oq7Zp1E6pkNgNBfDkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJQjQo8PYt73TI3RdPJYi9h62Jx8YmInMjOMiujI7/S2y5+4zAnLt6Tzlq53quwJB6Le7uIOi4kCywA3LCR5y8ICeeUNsvMPIEfTvzX73f2TIh/+8FeYpdK95cNsBFnoK0t6jlG/p2bpMRhJ2XtD1C9ctnSCQi1rW5OF7VKnZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcvQEUbG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741360588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8UPoCF2TV9wNGlnVaBCwxXKKLjXm2csIIhfyrHtuFdo=;
	b=gcvQEUbGMowybMr2zyjnc6yC5zm4iwckmZanU58u9JbVp1oJd7RH8OPSvlPRhGPgTFf4g6
	T/nuLaWchWPPDwunmHw+fP5DmXqzF6R6BD3Rw/iUSYXt5G0w2dRBfItRQSZwQDrH8zxkO2
	qXTQyrajvVMrOLcFB5NWemFrWN/QOAE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-kWO3N-daOhGasKoA9TikaA-1; Fri, 07 Mar 2025 10:16:27 -0500
X-MC-Unique: kWO3N-daOhGasKoA9TikaA-1
X-Mimecast-MFC-AGG-ID: kWO3N-daOhGasKoA9TikaA_1741360586
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bce8882d4so9421995e9.0
        for <cgroups@vger.kernel.org>; Fri, 07 Mar 2025 07:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360585; x=1741965385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UPoCF2TV9wNGlnVaBCwxXKKLjXm2csIIhfyrHtuFdo=;
        b=aNeTu/ypSq3W+e5QbbGwuQD0W4e4HAWxEQAp3v56I0eH+T7VdP3MZOU6GGNTVX4BjV
         4RKU1b+ZJQCd53t+Sdk4Zpa3kB03z7dP2Seovwvt0hs3TzUviFR4NlNFeriCkQNbS8TE
         zCev9hdl8k5/zB2X1GwNNsZ+1ZxA4V2mQkLUwJR541A9DF7mrEfLQGYZB9BKc/hjRPH0
         qGYFIjgy+Wgn8wg06VMY3//t/ybetDMzmHd25x5XGlnJRHTLiFkG9FH6gIguVj44l+XL
         SG9oj+9LBuzwfW5xIF3DBi1E1mKHJhTm0UcqkBwFaqUzJFwtflZiRfeywrGiCCmUGX0d
         JRZw==
X-Forwarded-Encrypted: i=1; AJvYcCWkb+uBFPtGZt4zV9SDO0wQV2aT7ZoJRFpIWAD7z8b4+bIOkv/Et50mtLCGjMmEXP3SvfG4n1tm@vger.kernel.org
X-Gm-Message-State: AOJu0YzM+3YhFlhgoC+vHG/OwyMltp/DVXTsA0CBIWaJFQmL8FTqY0tJ
	OShS46tIv8rYsNjPx51rEEHgzgdUngr0ypI7OiosZCs1gOoj+cqtiE6WY8s1LHti3R9V/T2bjuN
	MgjYp4QJaXwnPuHTRCs62C0pgQ5apW0J7W5H9zMZZ+JAwUAnEKtl+gXUpb+cAGjYgt+Kp
X-Gm-Gg: ASbGncteWcHk549h8k9yx6k3BWWa+pJly0hlPuJHxpG3iTGEYtjhmvwx2OxE28fhC7n
	IrzTjIlxz87OgtGfKQO5vrdShyiVbdbdReNYGMozgK0WhfwvIICiagJkq4Gwiz/oD0chI83Fau7
	tAJ2yua3oJSWEr+lEM6w0+1z9F+oN+HkqiwG7WaheCy1H8+OD9OwyoaP7JLI5Xf73APDspKxkGR
	ljDM0IIoP3/Cmky7whMVCtpt3zDCsxRU5ubvJXj9xk+TyAbjOwFa6dXHYfWC2K2kN+5ASiuGXjH
	lSCB8G5z3rkUIVD19+XCM5qqIr1E0va+oTef33C9op0pO/j5xxGFscDJftpKUre7Jntayx+loVe
	xDap4
X-Received: by 2002:a05:600c:154a:b0:43b:d040:3e08 with SMTP id 5b1f17b1804b1-43c601d888emr26836005e9.8.1741360585507;
        Fri, 07 Mar 2025 07:16:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbqdZopBPMKZX+Hcxaxbbjod5fJk6RsUqCj4tqlz0tE6ncD07MAJKcZmWETr1ADUNAGiMoKw==
X-Received: by 2002:a05:600c:154a:b0:43b:d040:3e08 with SMTP id 5b1f17b1804b1-43c601d888emr26835525e9.8.1741360585038;
        Fri, 07 Mar 2025 07:16:25 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0195bfsm5574660f8f.48.2025.03.07.07.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:16:24 -0800 (PST)
Date: Fri, 7 Mar 2025 15:16:22 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] Fix SCHED_DEADLINE bandwidth accounting during
 suspend
Message-ID: <Z8sNxll-9_VZptWB@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <5cffdf8b-2670-4b46-9434-8024e18e4750@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cffdf8b-2670-4b46-9434-8024e18e4750@nvidia.com>

Hi Jon,

On 07/03/25 11:40, Jon Hunter wrote:
> Hi Juri,
> 
> On 06/03/2025 14:10, Juri Lelli wrote:
> > Hello!
> > 
> > Jon reported [1] a suspend regression on a Tegra board configured to
> > boot with isolcpus and bisected it to commit 53916d5fd3c0
> > ("sched/deadline: Check bandwidth overflow earlier for hotplug").
> > 
> > Root cause analysis pointed out that we are currently failing to
> > correctly clear and restore bandwidth accounting on root domains after
> > changes that initiate from partition_sched_domains(), as it is the case
> > for suspend operations on that board.
> > 
> > This is v2 [2] of the proposed approach to fix the issue. With respect
> > to v1, the following implements the approach by:
> > 
> > - 01: filter out DEADLINE special tasks
> > - 02: preparatory wrappers to be able to grab sched_domains_mutex on
> >        UP (remove !SMP wrappers - Waiman)
> > - 03: generalize unique visiting of root domains so that we can
> >        re-use the mechanism elsewhere
> > - 04: the bulk of the approach, clean and rebuild after changes
> > - 05: clean up a now redundant call
> > - 06: remove partition_and_rebuild_sched_domains() (Waiman)
> > - 07: stop exposing partition_sched_domains_locked (Waiman)
> > 
> > Please test and review. The set is also available at
> 
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!

Best,
Juri


