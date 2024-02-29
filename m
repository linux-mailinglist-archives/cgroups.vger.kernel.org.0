Return-Path: <cgroups+bounces-1926-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8705E86D55C
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 22:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CBCFB28162
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 21:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C616C9E2;
	Thu, 29 Feb 2024 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhg+MfpI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472A016B041;
	Thu, 29 Feb 2024 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239305; cv=none; b=lmWY33pJmEcz2kb+pX+pa5q4GK5kRZUiMl35cRv/l1LgcUpeXMCATA8cVFGfykmFUetEqWiPF6Xk0h2YAviEWzVluNw4TJPS4HjGj0pK64i6kc/Pifq7xysZX6qkJPjQNDQjZ/+qc3SiZq+lcgc+G10SdDLg/ut/HvGTqXEYL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239305; c=relaxed/simple;
	bh=APRMZ4n8LYH5W13havCjtiPcQWPmAf0KgH9MeFCxuFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzDH5dUycPkuuXBQ0j4sCQ+M+X/SlJEY5Mb78VhQAjaamx4/8KyPBsfOMhHhZ47Bff+dRg+gjlD8ukDXrtnJHbdGesxu21jtNOiUs2tGWZxKf3c1qpjqEXO3sWs0T/3K0TNnIiqZtcNYEtbejljcvkSI+46l5Ozcl/EzTxgRv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhg+MfpI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc5d0162bcso13270825ad.0;
        Thu, 29 Feb 2024 12:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709239303; x=1709844103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCuy/++A6Eh0DIGCLnbR4RQY4erAHeKD29B4iy7q32c=;
        b=fhg+MfpIN7opj+P+p/0Gc9adCTHPfd27qDIMVQEjKG1lY4+BKhdx4d9vlT0yRc4JSe
         FpLjpZ4/05PTke1V1COIFKSVsaQORF4lLXbXcpE6c/SwFtltJDOu69pSgfwymP827Ycw
         rYYOQdKXd1zxMSgaDCIAcdCl0/tlBZQJibZhUNMOqPEf3npeLiv6ljFzXEiFPSb/E6uN
         rUGd+TTieRsVes5oRVWdPP8OcWMOvMuwWdpNuxr4FCgC0rTnruBplh29R9CLCSRcDBLt
         RJiDMDpO6uPiuU4wymbDp2QQmIfQBUxmYX7z4eYiYPG/k1xJmP1E80IQZzA5rTX9FIs1
         IkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709239303; x=1709844103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCuy/++A6Eh0DIGCLnbR4RQY4erAHeKD29B4iy7q32c=;
        b=s2DrKl6y0KDWOyUa2Y1aTpJeDwF43PjCcspXN30ThoD6MrwBUuIq5aAKWrtID61IN4
         +4NXRWkmSEeaxVZ08SpzPSiJD5KJS8DFNck4mT1Te0tDKAXn5IT96ZqrXpCHjObc06TZ
         7LpJi8aYF034Napd8Z6CWPCf4Iiqa//+2BbHRVCUhDvdoWviooJpe7foc+0fqvA9t58P
         Y0ppd7kQDjTzkR780PnO+MsrZTbIS4GECcRnXPTwQOgctzLSIWZ7ryROo59eqxPfoote
         BrOPoIit+KiPbGkh8z0BfNvPv7dImtsFKIC6lejfRaNg+zLTmHfKdfD5c+neZPIo3EpF
         919Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZWcNwFtyw5y81DlbW3gaw/0yHnrhc1ln4M4uVjlDNENEj9bp3bzUiz02EfQujDg65/eNsLMuQLozzwSpr8UycRExUvwCdTOg1iXaZhNVQLIGtGAEmM6JpNHO97UJEfWT8CUcrmw==
X-Gm-Message-State: AOJu0YzFp3nZ7zFCEyKwNQy4Go+if/ulAdBnZrCnphGurFTKRE0i/aXk
	6O5k2L+vmIcU+g0JHcnxuQY4Aj4kwkwDECf1EcOx4iUWEsaB/liI
X-Google-Smtp-Source: AGHT+IGTQKsZ5pKWSZpx0KLaYeFeiUjZqrnllq1Zus41oD/Lse7gy8HG5VCwXQlQCIaaZTp2iFyYeA==
X-Received: by 2002:a17:902:aa8f:b0:1dc:890a:45a9 with SMTP id d15-20020a170902aa8f00b001dc890a45a9mr2640785plr.65.1709239303406;
        Thu, 29 Feb 2024 12:41:43 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:8305])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902900200b001dccaafe249sm1923875plp.220.2024.02.29.12.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:41:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 29 Feb 2024 10:41:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Cestmir Kalina <ckalina@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [PATCH 2/2] cgroup/cpuset: Exclude isolated CPUs from
 housekeeping CPU masks
Message-ID: <ZeDsBW4rC9gaMjuY@slm.duckdns.org>
References: <20240229021414.508972-1-longman@redhat.com>
 <20240229021414.508972-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229021414.508972-3-longman@redhat.com>

On Wed, Feb 28, 2024 at 09:14:14PM -0500, Waiman Long wrote:
> Call the newly introduced housekeeping_exlude_isolcpus() function to
> exclude isolated CPUs from the selected housekeeping CPU masks. This
> is in addition to the exclusion of isolated CPUs from the workqueue
> unbound CPU mask.
> 
> Right now only HK_TYPE_TIMER and HK_TYPE_RCU CPU masks are updated,
> but more may be added in the future when appropriate.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

This looks fine to me from cgroup POV. Please feel free to route the patch
any way you see fit.

  Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

