Return-Path: <cgroups+bounces-7384-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1A3A7D3BA
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 07:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9ADB16DC06
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 05:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8E82248A1;
	Mon,  7 Apr 2025 05:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWTJmR9F"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E2221DBC
	for <cgroups@vger.kernel.org>; Mon,  7 Apr 2025 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744005489; cv=none; b=P4f+T5MO7VoQ87XCnNf2KAstVXtA68cUpxYWYXTM0npV8+TUC+biS+grfMJIKv/+Wa+f87ZCQd+E+dxGRo0UP7YcUM6K3rdX5l/kLWcqlSpOoKISP4fA7/obRjySKXhInT6OWon605xfZet2Jwqv83ZEhF+5hsgzQSw+ObJtlns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744005489; c=relaxed/simple;
	bh=ZiKQU7+ZTag+PkDiP21DOnNU/DfFeWSpZpnHSsouA8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTc2VSl8IC7f9doJ842cDifdXFfFahl5xUWCH3uNKwlUD1VX0Jtp1SE8bhXjroNN0UUJndQnSX1bhOVXw3zT1PhizEtaW0oRl8SviFZ4YmVWdR+odzorrCYqij4uFYTM+bPVZ1r5qF+CswqchUGI5XKueeGX7woHHTKdZTGaHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWTJmR9F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744005486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdrgDYCSpZrgshUK0dQhM1SIggYbKVgzDdGuPaZZJ44=;
	b=MWTJmR9Fg/C1Z5kFpdWiujuoWhqmtwl3DRXYuGmgeN4+pqx89jP/Ta+X3535mYhOIvW3PA
	foBivHcFhI6my8qcS9aMiPX7rMs0oMmhkrdocLCSKIe8X+Vki3zPRgiLluCwov0K7LaDmt
	yTqYtgsb11vMH9jCrC1VGQXv6CDuL5E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-233JuzyZODu9rQDv2hoFIw-1; Mon, 07 Apr 2025 01:58:05 -0400
X-MC-Unique: 233JuzyZODu9rQDv2hoFIw-1
X-Mimecast-MFC-AGG-ID: 233JuzyZODu9rQDv2hoFIw_1744005484
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d6c65dc52so32709975e9.1
        for <cgroups@vger.kernel.org>; Sun, 06 Apr 2025 22:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744005483; x=1744610283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdrgDYCSpZrgshUK0dQhM1SIggYbKVgzDdGuPaZZJ44=;
        b=F50pA9Et3+EZpBjrnWPlrnVYaJrXsBwoIsRQsg7bjrLHCKuwRaUG/J0tMyMkNrrwWl
         leZc2583eoMuL3VGFKrnCUGCaQC8wDJYs2ic+XXCB+oss3KgBAPsqtPMNkB22CwsA6eR
         IvBtekJR4JJwWj34HIH4ChF3jld5HN+QNGytLGgspt1JCcXvbdPHMPucbhv3UKCAJ/RE
         BErUU4aOe9RE2ChozfGUdQ1Y5XtPyPUXH7wI/D/VT55/lF8Hw4mIBrAzz9f+tpuw7chx
         ZTt0QJIG66SiSJ2IcW2caHrsRKEjsZvlcKAIVmfRD2EvjcacfLCFKDgX25TcTKgrrFaT
         wq1g==
X-Forwarded-Encrypted: i=1; AJvYcCU9hhcyVSoYPjAIKDcSb1BOlQuYHYBCbP9NmMcljy1bDxZcs5UDz0PwgJpta+0oCs4sU+IM+gDp@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOvP7LybeSDnkbrEAMqJwsvPX+zx4BtVyLDLts+v2DAOcPIIg
	Mu1QmEIDmnw+sCF8yG2a6BjZ8LC3O6jGx9V2v6yM5NiN+D7+B0bfFwrtfwb8I9CdzWLL/2IFaPb
	v0rhdi7LYObilzaGqYWLHlgYeCE6ngnEKemxiwTUNSSs7NSW2bMVtPMI=
X-Gm-Gg: ASbGncvmnSWsbXVA0f8VAPndfs/EdVTiq7PCmAnajLZEyKtkSdrR+5CY5dE2qzdv9Eo
	3sh8u6RFklbH599hlD065WG9XTu8MPrG1hsColAIKfZxay0C2YtN+0qY2Ppz/fmm1SrSS0cHvgg
	EJ/AdjXp8TjdE9FEYmXyceyiZC2C/kyHFptKCoMoakAgfbrOQex7gs59Chlb32ERGMhhNix3yku
	XtyaJMBkC9ZVDcaHimmJ8PC6nHfoDWE19tgVhcZgETdjdekBrzoT1VPjxLQRwMZKn1NQLCvYH9b
	ifOboVODXjVf8B2ZtbGnbYUWZPC9VcTVS/E9fAKipXz0Hp7YasGuoGQyz252nJmgPNUX06inkdE
	=
X-Received: by 2002:a05:600c:4754:b0:43c:eec7:eab7 with SMTP id 5b1f17b1804b1-43ee0640054mr69945405e9.11.1744005483409;
        Sun, 06 Apr 2025 22:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCJwfJe9itIXh2LQ8CDQGreaVbRslAEp7rsJUnOQciHmPEfLvp8ZVDzU2l0AkPqAUjuQP5rw==
X-Received: by 2002:a05:600c:4754:b0:43c:eec7:eab7 with SMTP id 5b1f17b1804b1-43ee0640054mr69945155e9.11.1744005483064;
        Sun, 06 Apr 2025 22:58:03 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (rm-19-1-30.service.infuturo.it. [151.19.1.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342be6asm122527675e9.5.2025.04.06.22.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 22:58:02 -0700 (PDT)
Date: Mon, 7 Apr 2025 07:57:58 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: Re: [PATCH v2 00/10] Add kernel cmdline option for rt_group_sched
Message-ID: <Z_NpZmfeHMwa6cQH@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310170442.504716-1-mkoutny@suse.com>
 <20250401110508.GH25239@noisy.programming.kicks-ass.net>
 <s2omlhmorntg4bwjkmtbxhadeqfo667pbowzskdzbk3yxqdbfw@nvvw5bff6imc>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s2omlhmorntg4bwjkmtbxhadeqfo667pbowzskdzbk3yxqdbfw@nvvw5bff6imc>

Hi Michal,

On 03/04/25 14:17, Michal Koutný wrote:
> On Tue, Apr 01, 2025 at 01:05:08PM +0200, Peter Zijlstra <peterz@infradead.org> wrote:
> > > By default RT groups are available as originally but the user can
> > > pass rt_group_sched=0 kernel cmdline parameter that disables the
> > > grouping and behavior is like with !CONFIG_RT_GROUP_SCHED (with certain
> > > runtime overhead).
> > > 
> > ...
> > 
> > Right, so at OSPM we had a proposal for a cgroup-v2 variant of all this
> > that's based on deadline servers.
> 
> Interesting, are there any slides or recording available?

Yes, here (freshly uploaded :)

https://youtu.be/1-s8YU3Rzts?si=c4H0jZl4_5bq8pI9

Best,
Juri


