Return-Path: <cgroups+bounces-5072-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286CA9954C8
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 18:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E574C28877F
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0775117BD9;
	Tue,  8 Oct 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmss+Qr1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6170346434;
	Tue,  8 Oct 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405964; cv=none; b=Gfp9zRnolvrNidFxEILooPJSdb2kMdqVn9H84BA0Pb41HbJX3KpeIzhSJTshcomHYiwz8WtO808GbFLyJXLFfPoNNnwtyeArz8OFE+uP1GpD2VP/ADXqWucOwzHOIei+jVF95LpMB1a24Io6fOcfsjwp19K6ZO9vDOVsjj1PVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405964; c=relaxed/simple;
	bh=6gZoU90UlV7MoQ/Cd4i6PIGVNDq3MTRXROloULEWSVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7TCMHRMeytDCRs3opGrh5ntw5xue6Kx8kFPfVXO6FiNdTkEhJUCshLhxhqnWtf5xWOgKDVeHV33zOS/53/RpcT/wpNMrPUyPaIJSEc0oX84rNtFM1xGQiB/8In4RdNQb6dwCXy44rkwvvKrZ/9H/kRJaDKjeFUjQN1QCD4k07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tmss+Qr1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e078d28fe9so4041416a91.2;
        Tue, 08 Oct 2024 09:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728405963; x=1729010763; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eTQnp0Ft2NE69dQH3wqh1g/A64hntEEVZC3s1ZykCxg=;
        b=Tmss+Qr1wcN+geNIVeTSrO/9Hpeb+pvZWZHpDNvCT6Qnqeft33WQqdLUeVn3sl3wdj
         JYTslnYq/vutBfBg26Qom6PVvhudByq/2mQoQuHmSWWSua1s6Flz12QpBEm4+deKyOOk
         CPR84Xl+Wg0CcKBIdCXpb1Sv/cuus3vuAjpsHDJWXis1W6Kadp14isI2JbDhaO2LSTVH
         EI7yLrAdLnmGD5bxYsi5wX1vOoJX1NbAiGSfFddHuMuyDfxcNY15YjzezJuK8bmETW0K
         s9WKsjsGLxf0vJAEiZP3TzYIccBeCeHrT8WhbWTO9XW54BVvNzFhX0/2KhFyq+O9Ga/8
         PuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728405963; x=1729010763;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTQnp0Ft2NE69dQH3wqh1g/A64hntEEVZC3s1ZykCxg=;
        b=fnDH3cPKLq7+hdqX1dqZ3Asj6O5XK5hKzMD2LEjd/PvC4GnpC9L6zGDPpRwTomw6uW
         3d1+f+Jf7t/7gcsWIZ7RYa84fp4r0tukRE85+DsIOr8vRqYU887tZcLQS0Z5xUZnXW42
         po6obFUHRwJOk6nor3966+qTQGbacTtYE68QFGWB9TP0I++tCDgKe+PS9tPFG8bO03Wp
         A9hpK7UZfSHIY+CB60ZTQgplnWzray+FvXMx4YNQnj/kWDn0r0Nb2rHn5PsNAdNpsle1
         m6HySL8dZiIP+uohyaulqz35W7db8o3chdVOfbGxF1EQ4g34gRJunFcfuf2ESZJT0IDn
         Dz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvbLPSm01qRJYFFufBn7vVYY9C6v6FPW0q6loqNLUjyIWrJHdvoHiH4biRlz52n+xVRJU9oLxuj1voeZxn@vger.kernel.org, AJvYcCXCIXkFL/N3jkM6phuxrh8UBTxS8TcfG1XkR76crqSN1h7/axOs7GL0WEXSDa/TP1vwwFYz7gtP@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcfgm8umSsCf2jdU/CJMoDM3gRSxVdwCWz9eHzyg/ExEnqGWV
	RuZNPnPydP9cFJd32MkWyNWunQfbAtK/SQXTN+yruKQtpW1QT530
X-Google-Smtp-Source: AGHT+IHM7yHhSQbw4zedDMKXs2JGoiydP8DLD1cFZmcbpMvKlIUhKpA0266dQQr9prqwdhRZqUMvpA==
X-Received: by 2002:a17:90a:5511:b0:2d3:da82:28e0 with SMTP id 98e67ed59e1d1-2e1e621e96cmr19672761a91.9.1728405962634;
        Tue, 08 Oct 2024 09:46:02 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e285765febsm1028448a91.1.2024.10.08.09.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:46:01 -0700 (PDT)
Date: Wed, 9 Oct 2024 00:45:56 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: xavier_qy@163.com, lizefan.x@bytedance.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, akpm@linux-foundation.org,
	jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2 5/6] cgroup/cpuset: Optimize domain counting using
 updated uf_union()
Message-ID: <ZwVhxDEz8cSeForw@visitorckw-System-Product-Name>
References: <20241007152833.2282199-1-visitorckw@gmail.com>
 <20241007152833.2282199-6-visitorckw@gmail.com>
 <ef7f2495-06fc-4409-8233-062d2e884271@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef7f2495-06fc-4409-8233-062d2e884271@redhat.com>

On Tue, Oct 08, 2024 at 10:02:23AM -0400, Waiman Long wrote:
> On 10/7/24 11:28 AM, Kuan-Wei Chiu wrote:
> > Improve the efficiency of calculating the total number of scheduling
> > domains by using the updated uf_union function, which now returns a
> > boolean to indicate if a merge occurred. Previously, an additional loop
> > was needed to count root nodes for distinct groups. With this change,
> > each successful merge reduces the domain count (ndoms) directly,
> > eliminating the need for the final loop and enhancing performance.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > Note: Tested with test_cpuset_prs.sh
> > 
> > Side note: I know this optimization provides limited efficiency
> > improvements in this case, but since the union-find code is in the
> > library and other users may need group counting in the future, and
> > the required code change is minimal, I think it's still worthwhile.
> > 
> >   kernel/cgroup/cpuset.c | 10 +++-------
> >   1 file changed, 3 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index a4dd285cdf39..5e9301550d43 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -817,6 +817,8 @@ static int generate_sched_domains(cpumask_var_t **domains,
> >   	if (root_load_balance && (csn == 1))
> >   		goto single_root_domain;
> > +	ndoms = csn;
> > +
> >   	for (i = 0; i < csn; i++)
> >   		uf_node_init(&csa[i]->node);
> > @@ -829,17 +831,11 @@ static int generate_sched_domains(cpumask_var_t **domains,
> >   				 * partition root cpusets.
> >   				 */
> >   				WARN_ON_ONCE(cgrpv2);
> > -				uf_union(&csa[i]->node, &csa[j]->node);
> > +				ndoms -= uf_union(&csa[i]->node, &csa[j]->node);
> 
> You are taking the implicit assumption that a boolean true is casted to int
> 1. That is the usual practice, but it is not part of the C standard itself
> though it is for C++.  I will be more comfortable with the "if (cond)
> ndoms++" form. It will also be more clear.
>
Thanks for your feedback. I appreciate your point regarding the implicit
casting of boolean values. And changing the code to:

if (uf_union(&csa[i]->node, &csa[j]->node))
    --ndoms;

would also enhance clarity and readability.

Would you like me to resend v3? I'm asking because I suspect Tejun may
want to see more user cases before considering such optimizations.

Regards,
Kuan-Wei

