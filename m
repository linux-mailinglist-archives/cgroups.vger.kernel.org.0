Return-Path: <cgroups+bounces-6841-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21693A4FDEA
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 12:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525D916D90A
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 11:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A435241697;
	Wed,  5 Mar 2025 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEgFABIg"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508C81F416D
	for <cgroups@vger.kernel.org>; Wed,  5 Mar 2025 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175043; cv=none; b=bJve/7t+iGVoxvYF7Id4g/r6IWGxojN9rKG7EF63QGTUUoJwGupAj1OobeXjMcZRNh4eyZ6IMDwzuVFHBOu0E0TAyKXFMLqmNVE5R4xMbrG3XMWUt/WcqFJmucgs9MyzZTb3YNuXfbBbiKf6wbwZ9P97MzkPNKDTIAR/MF5R1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175043; c=relaxed/simple;
	bh=obAikUlss8cx2pGO1oC5Xm/p3+C6R04IBQkrAWhpcZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyLviWuJM5sizSWuZMS8ew7rHhKYEqHPfWiDYDdFLPJRX/Cc2MzDq8kilw8BR6SeYw/dGzwlYK0XzindhaPc1QwNOyTuzu1bfwQos/8K1TLYxU+J0HKYcvbjf7ISU0ijNjPjH758eax1OhExBeUv6X3ui4jFUVXfaXQ3NBeDMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEgFABIg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741175041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obAikUlss8cx2pGO1oC5Xm/p3+C6R04IBQkrAWhpcZg=;
	b=AEgFABIgVJVneNSnENXbzvhizKpcN7AUinBfIMy0lHz27WFXWL28dT8Jv8Nb7sKeO2oEiz
	5tJzVf34W+LKvCUlcpD5Yzp6zRADFNNo4DmL/y09p7z+SS+U7RYLVZWbiqdko6UcGdSTRd
	2mn74ym/1DKl01qBmZVxbULOcfZGUC8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-wA7-M5iYPFaHQLYYthozZg-1; Wed, 05 Mar 2025 06:43:55 -0500
X-MC-Unique: wA7-M5iYPFaHQLYYthozZg-1
X-Mimecast-MFC-AGG-ID: wA7-M5iYPFaHQLYYthozZg_1741175034
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c3c03b6990so520909685a.3
        for <cgroups@vger.kernel.org>; Wed, 05 Mar 2025 03:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741175034; x=1741779834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obAikUlss8cx2pGO1oC5Xm/p3+C6R04IBQkrAWhpcZg=;
        b=oXiXYW+wWwCPaMwdTea7u6x6L84f639Fhucln66hfPfaF6TdE9lWwx/Z0MF0oUXyYQ
         7ixF1Mnnsk4R1nw9OK7d7W6x5P+u10WYTyAYJouQ30dVMlAsFiBxSOp3LnzSV3lSHRY9
         NORfUInYmRh5rWPWgvrIv92FuGQs0t9BT9HX5wb4HvLDcUMZaBewvxHpVvj/f828TWxs
         M+2ok7FAynM4rsDH+VZ572ugWfmTnel5xIevV752befw94Ej/MuF5zQuZcG+XdAuN0jd
         JgyJ7Hww/cruNonznLLorn7j3aF1M1Q1j8GDGy2b/iMyv/fdwIPlw4SWqf4Wd4yFb3Za
         7qxA==
X-Forwarded-Encrypted: i=1; AJvYcCXfigaD70Tl+9j7iJ6AaPDarzjuoCGX3V4os9rv/c1bJXJ61girHqgz7HTX60qVewf108oI1h+E@vger.kernel.org
X-Gm-Message-State: AOJu0YxMjCnzuIKltUt11iPD2gqLzUHadY3sClv0IjancQesHUy5L9nO
	NYyziJ7S4koja+Y0X5ork0oagEczo8Q+3aOmMu7eTXCYhoSM58BOU74CRSKp/XKhB6WPbVmF1KX
	EBBc5C0bngU9NfDChDu5Iqyx1BdBarA3CxyorGMpj17INBzrrbszBsWc=
X-Gm-Gg: ASbGncv7WW91DPWYiiJU8yLukIHz9ug+QAYItbErA5EdM4KJoLy5uvtufkslD/xObqV
	leB9ejFp3a3ZKB8DBTiVZWwMT2xZwLRDhyApXL/thrOUVi3Lb8LKlHuB4pY6KQGyN672TQd/E7W
	cmRon7S10rJfd74VFfXJ3y1iUokfQAa9EzxS0gkSaWVDK0WKv20UNmO9alF3pexJ2yoLH1U8s3H
	0tgePb3gkyqnACmcn9Eyu+ziS5jdds9qlVqaaFhd50Q+hdwBpx5fqyRRzYzTykSuwnbO5XVjQ7H
	nlz8c/hMxY9MMY+MEaS73r5sxpJn6hTjLYy93BQZlm62vqTlOwxGSm/lFbYzxmOBtoY+JqKYTm7
	hxqUr
X-Received: by 2002:a05:620a:4455:b0:7c3:bb38:88e5 with SMTP id af79cd13be357-7c3d8ef9afemr474812985a.55.1741175034545;
        Wed, 05 Mar 2025 03:43:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeM42f765loSizjHEJobaXam/I1bWNzdv8SjjSG4IsKkXXUknDDoOYHG829povW2NR0z7mQw==
X-Received: by 2002:a05:620a:4455:b0:7c3:bb38:88e5 with SMTP id af79cd13be357-7c3d8ef9afemr474809885a.55.1741175034249;
        Wed, 05 Mar 2025 03:43:54 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3d29d77dasm179383985a.115.2025.03.05.03.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:43:53 -0800 (PST)
Date: Wed, 5 Mar 2025 11:43:47 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 4/5] sched/deadline: Rebuild root domain accounting after
 every update
Message-ID: <Z8g482-ZD7iuhhoC@jlelli-thinkpadt14gen4.remote.csb>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-5-juri.lelli@redhat.com>
 <e78c0d2d-c5bf-41f1-9786-981c60b7b50c@redhat.com>
 <a53c1601-81e7-439c-b0dd-ec009227a040@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a53c1601-81e7-439c-b0dd-ec009227a040@redhat.com>

On 04/03/25 10:33, Waiman Long wrote:

...

> BTW, dl_rebuild_rd_accounting() is defined only if CONFIG_CPUSETS is
> defined. I think you should move that declaration to cpuset.h and define a
> proper wrapper in the else part.

Sounds good. Will do.

Thanks,
Juri


