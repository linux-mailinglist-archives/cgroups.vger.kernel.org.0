Return-Path: <cgroups+bounces-6924-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C3EA59015
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 10:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7407A188E697
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 09:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D9B225793;
	Mon, 10 Mar 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCXnjgP4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C9225788
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599857; cv=none; b=jFmKsyjzmzrMF717FxlyX2KvOyHZ1ctW8SRVnmRvBo4tmMDAYJsmMm/3QSogl0SqP6OxVh64UgyEzVU/Mh5jq3Mn4Vk5vzDO5fKfcfvX1fkADl7PwcTl6QiC5H4kJCdEDWTznDgI2cJlH7SUCGcfFkvhBd1MiNO7pLOX0wGGtx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599857; c=relaxed/simple;
	bh=ow0vSqKBH8xstu1wBVYGDDOLkaAxIDlC21i68FzicaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkUkqaiNDllRr+sUYt7vmPaglzM4AbfTENXAtVXbAojx+rxhpm1ilCG3oGigbaS1czeoaCisdQHZGzJu7WtzgYj5cJ4RyLxigSCHPqIuSRKwmJCyEoj18uJRhYLRQX/ksW5GQG0VVyID0tcCkG6hV4RGGilyrOcrXnjzZq7cLm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCXnjgP4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ow0vSqKBH8xstu1wBVYGDDOLkaAxIDlC21i68FzicaY=;
	b=gCXnjgP47kHCeSzIqzS2Tie46sNDpQ9FgqyaOI1zaO5JNBR22qDbn69Xbn7luwYKqeGuxj
	IZcnI16sxw7KNi1nyPq1wwC19QCMPiKmsd0CnnjRnmIzdfEg0Y4EUdMDkZYQqo6bu5LYOd
	HUiemQ2se+jt2HXZ4bKxeRUG9uYssm0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-PbYnoiNCNOC2yExXKEpnvg-1; Mon, 10 Mar 2025 05:44:13 -0400
X-MC-Unique: PbYnoiNCNOC2yExXKEpnvg-1
X-Mimecast-MFC-AGG-ID: PbYnoiNCNOC2yExXKEpnvg_1741599852
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bdfb04bffso25902225e9.2
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 02:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599852; x=1742204652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow0vSqKBH8xstu1wBVYGDDOLkaAxIDlC21i68FzicaY=;
        b=I3p+ntorILDJ/MdeGpRgVvJQLYYO0aTJdvGxo7tj+2kgAUDnOT4oKlyuiRfwZoC/2e
         yEJWDoi/dfIpy2U73R6bZz240RIOx3xKFLamkUDVMlhGyF3kAWvZuz6621pZ8CGqd5/Y
         LEcW3sHuwGpKiVUz12VIo1kXj63JIJZOe+mfeUzbiFYtPT4WzicVwVXUz2n6NSYgogvM
         Am2hzrxJa07MZZ1wm0hk/YEVfNAQgFfwoto48IqVD4/Orfg7+3UjkiSe+pZfJ6GhdgLC
         mmMkzx606EL4EssYhQciuVnzRv4qHQidHtIMRqdrm5eS5CZoppkn+uPHPp1lXPQAm1qt
         e1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCV3G3e5YwzWx0iMT3du5DHLg6v//kmwSLJ/qkoTa+UL2qrtIzwYBhRYL/h4RE6BvgKvE4Gj1Ktz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4BOYWc4M8bYse39a/fw+6O+lirkBi7XK5shWSdzPxLgEaFUN
	o7kWyNKqjpg1/mEPtdVvXOY7Su3IGLly+awZNRfp/lMNjuOaO1MHbgvDQwaWV9mfkg++hBIfijb
	3sVZrFpYlmP6xUA6HwdxLJkWULSgrCRlOda105M/bio+va29lxDAhWEM=
X-Gm-Gg: ASbGncu3tVc71p2xUwFWaZArHfAwdH+EIqlD9HONj6+sDz9h2eZwPTI1JizoRardnJh
	kHCfF3Kt4osuzf6xhsoTfcjULzVrJl8v6TXto+6KSSiYt+OE3dZSSGfMrThyyq+Iz2kmTolPzkD
	KW9y4vxZiGf7gi06lX9yLTilsjaa9n5nMM/TjFXqFiu+kkjCjLX7NmjJbsMiIqTg3uhGdq3YE/p
	m9jj180bdzhNecReXruM4HXe7fYWIFyYRo65bJNidvBKQjzUjAQbgYzFknHNnPUZaO4DS8dRmQn
	qmTH8WyQJgNsihfMOwXxC6oB1FiQYf4WPEOTExuvEuw=
X-Received: by 2002:a05:600c:5248:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-43ced612d1amr36757275e9.17.1741599852105;
        Mon, 10 Mar 2025 02:44:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG77fEdHDZRZKrDxEEmFxw1lEnfG31UV0hCRnof1QV2KuaEAH7NTEsz+9UqqwywiQuSyuEvGA==
X-Received: by 2002:a05:600c:5248:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-43ced612d1amr36756885e9.17.1741599851658;
        Mon, 10 Mar 2025 02:44:11 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfd5082ccsm9538975e9.32.2025.03.10.02.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:44:10 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:44:07 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 0/8] Fix SCHED_DEADLINE bandwidth accounting during
 suspend
Message-ID: <Z860Z_aPTWh_-juW@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310092050.23052-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310092050.23052-1-juri.lelli@redhat.com>

Hi,

git-send-email acting weird, please disregard. I am going to resend.

Thanks,
Juri


