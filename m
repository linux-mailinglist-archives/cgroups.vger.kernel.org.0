Return-Path: <cgroups+bounces-7008-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C8CA5DE08
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 14:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4173B34FF
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 13:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A9A23F422;
	Wed, 12 Mar 2025 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyQinJ6k"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A231E48A
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786331; cv=none; b=QPHdjARMfVGrPmSspPM1CiP0XuzThdr77fh+fgxMBlUgP1hUKsdTj5245IlKgJCCpAR+SnJqj0vIPK55x/6MmCeqDyT6yqo5uT5L+mQ5oWEB3jsdM5a4oS7bcJgMKzm3Xmtl1DIGnzjJmPNof95fUlcqH3NoelrHJNIdDrdSKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786331; c=relaxed/simple;
	bh=n+YKh/MUNMUdrgEpVLdiNZ/ObkP4C8B3H8z7MNYDh6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UIOx9gmsPuqyDzJZgUOh6SPecpue9lU8qhnZIjAELpkWyVgY5NDmPcCNd/Y/LDIpwn9L+ThR4hBT2wsRuvGGSR74iFregLo/UYFD1roAOjnS7nlj58kDI+G660T2z/oHtm2rOS5R8cqgukgHGM3+fgHcft0JHL4sZ1nZ2hdL6zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyQinJ6k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+YKh/MUNMUdrgEpVLdiNZ/ObkP4C8B3H8z7MNYDh6w=;
	b=WyQinJ6k+hRU4h1rSTgLRNgTIdsIqed3U9ddF+dKd3PTUDXcfM5UJoFFElMCJ+BWAR2nLH
	RMTAZUWkkrnW7xqoQWU3XwX5iAZtCAtejj8KoRhxDtnn+pq8zg5Htt3OJc1G6pzZb97mnp
	Zc6N2tI/etxuPBNZF52GcvwDTuMYIJg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-vtQcsENEMau3hn02IywiSw-1; Wed, 12 Mar 2025 09:32:08 -0400
X-MC-Unique: vtQcsENEMau3hn02IywiSw-1
X-Mimecast-MFC-AGG-ID: vtQcsENEMau3hn02IywiSw_1741786326
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so19184695e9.0
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 06:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786326; x=1742391126;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+YKh/MUNMUdrgEpVLdiNZ/ObkP4C8B3H8z7MNYDh6w=;
        b=wMAPH8y3y6QTUKIL8wo3/cDdlOyD4fxs7AbgsFAJCsA6rJhEVaRDlVknzHgcdVC8xk
         htFXCrH6pwZsFNIvcmRBIzfv49f2omMP6gwtpRjhQAQdpVnPfypREpqjraV2sulw+URI
         IJkME2sl+cnlxwj+EV9O6SvKbhAOkPbeqLjvFhQrBFH/sHlz5VU4au0osYWeuDxSGRY4
         gj4MFuetZm8rEzLFDrmUYqS7TWYCNy9AsHk891xbdRAMCcqW0Qns7XFeIUaJ0VzdNr2Y
         FPKT0PFL+xWHdQHgaZMT2Ld96R9cLLwt5IZRyn7xZcISF7kzV0amRWOF0SCtqIdNq0KR
         /V9g==
X-Forwarded-Encrypted: i=1; AJvYcCV6XkigxgQyNzLv4rnPnznrgMBI31bMpkecKbm8a6CaMAsECa1vR1RTQvBi8R0TlSfCK2BD08pl@vger.kernel.org
X-Gm-Message-State: AOJu0YySCvf5eNcJl570K42Lx9VDHNUXjk6BftOfptn00PFFq2KOgYC6
	kJUEXTzMTKHskPD/oYsLN6DWWfOAzcDDZ36JO2qdWSMNpoDgwIjKg2GH/A5dtYU+lhgBGw98RfN
	C0s2A705kYcxAh1C0Il0sg6EZ8EDc6sQHlpgCRX8MzpB26CFaa+NZl+s=
X-Gm-Gg: ASbGnct/w0fEprmKdUeaC8ES7eqfRG6XqzCGz7A4Yw510/1sDJzhMlbnyXwIeGHJUfl
	H2864H+AG+87ENhySfxQoediYWo+0Qa5sX+vLL9ultJIFgRv+h++ijt68Xz3n8hoNDyMCknj/Mz
	GTnlTOb1Jxz8UpQHBNF5TlPvCDgVsruEiz7wHTGbU2x1qbKhy/exvCEfT2NwDLunuPJv5ilGtUT
	ykNThNQJ4eNpMHSDeiTv56OAqFOg6+cdH5wbTuYNAnhEsTBms7U/4nCuE0Vu/fTc1ZgkrtaQPKj
	5FUoM60SedpmQopuqrBEQE/AaD0+8jQe+cFhRxlXEWBxcrzvDrmraDWqRPbSMSYZzKaBydzj2Ng
	v
X-Received: by 2002:a05:600c:468a:b0:43a:ed4d:716c with SMTP id 5b1f17b1804b1-43c5a631741mr154089255e9.22.1741786326201;
        Wed, 12 Mar 2025 06:32:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5sHcDKhieURPdxRy300OU1jc5MhmokRYnxd3zuFMFYr99zeGoJFxp8tbG2zBpfoTzfjxCaQ==
X-Received: by 2002:a05:600c:468a:b0:43a:ed4d:716c with SMTP id 5b1f17b1804b1-43c5a631741mr154088845e9.22.1741786325818;
        Wed, 12 Mar 2025 06:32:05 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a72ed3csm21539145e9.6.2025.03.12.06.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:32:05 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?K?=
 =?utf-8?Q?outn=C3=BD?=
 <mkoutny@suse.com>, Qais Yousef <qyousef@layalina.io>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it, Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 1/8] sched/deadline: Ignore special tasks when
 rebuilding domains
In-Reply-To: <20250310091935.22923-2-juri.lelli@redhat.com>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <20250310091935.22923-2-juri.lelli@redhat.com>
Date: Wed, 12 Mar 2025 14:32:03 +0100
Message-ID: <xhsmhr032pe7g.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/03/25 10:19, Juri Lelli wrote:
> SCHED_DEADLINE special tasks get a fake bandwidth that is only used to
> make sure sleeping and priority inheritance 'work', but it is ignored
> for runtime enforcement and admission control.
>
> Be consistent with it also when rebuilding root domains.
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> Tested-by: Waiman Long <longman@redhat.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


